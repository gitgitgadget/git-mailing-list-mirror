Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F816C2D0E9
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 08:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447BE20784
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 08:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appsbroker.com header.i=@appsbroker.com header.b="oaJA3qDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgC3ISb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:18:31 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45143 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgC3ISa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 04:18:30 -0400
Received: by mail-io1-f53.google.com with SMTP id a24so16137306iol.12
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appsbroker.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=FOnQVP0dTd84pP9f2D1oc7w28oGxsOrfLy3mzmzh4T8=;
        b=oaJA3qDGGXBbQ0F/LZlRV+k0HGLKm1xBUUMAUuGzX2L0kAOtUkqL3kxk1nvyx7Tb5j
         3sIfLRk5pP2h3lp7oduthBeej4GNS4Nz5DANHF9JJRnodhESkdqLYzUh5dpGgV+sNpg5
         CS1HaYNdUHr4BTwYfGOabsUA7lcNmr8rMeW8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=FOnQVP0dTd84pP9f2D1oc7w28oGxsOrfLy3mzmzh4T8=;
        b=k8phohT21qGiQmfjYOKtItSzkfukjV+fitUSXrc7Agxw5e35GhLJDbB1ycA6AIn4xt
         F5MkyXl/eyAXmT6McGiVDFSc0jcnAv1o9lYApw0PLS4ChmsCi7no3yFdtG4YyMYid14o
         2pJ3WbxbTkJ/P0RC9+SrQ/UMOTVkOQs/1itFKotK3Gr/SUWm0Y5GasIpNpR6E6NPv7Ty
         i7IYClS/I6bwwViv12cy0CvWlBdiiIOwndubcwbBz4X8Hs+iKTpp7gOl1ZbCaz3Om6F5
         wvdEn8I9emUBXcx0YywqQbt1bvYBel9KzHSbmmO6z0zCo68Qq7LCtpiadYKZ/K6Hj/36
         mm/w==
X-Gm-Message-State: ANhLgQ03oaXPO/s1AbCLTVe+U6C8MrQxVxc1PKmGlm6V7TGZIMwGqczm
        JiRhoLdNOPk1vX1bn9QCxtuczc731d0TUuPOoZ3WR7H9YnqmY+dRlcTpRFtHEo1X9gft1ooNlZn
        6cetHN+QfDfL6w2NL5prdySo=
X-Received: by 2002:a05:6638:c51:: with SMTP id g17mt10365084jal.33.1585556309063;
 Mon, 30 Mar 2020 01:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+U58yrKi=4VHRCAw68yAste=j3vzrvd2DoEW6QL-_sRWO2Aw@mail.gmail.com>
 <20200327124140.643uxbt2kvjwfxri@yadavpratyush.com> <CAJ+U58wHszg6amZivFEh=08N0ZNTcLHVFVyaCv0nQrzi_nx-UA@mail.gmail.com>
In-Reply-To: <CAJ+U58wHszg6amZivFEh=08N0ZNTcLHVFVyaCv0nQrzi_nx-UA@mail.gmail.com>
From:   James Yeoman <james.yeoman@appsbroker.com>
Date:   Mon, 30 Mar 2020 09:18:18 +0100
Message-ID: <CAJ+U58zvMCxuL6a8yfdNHCfsBkivybWxTioPU-p_PtekAAOWuA@mail.gmail.com>
Subject: Fwd: Bug Report
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, my message got rejected because Gmail added html to the
message, and when I went to resend my response (making sure it was in
plain text mode), I must have clicked the wrong reply button

---------- Forwarded message ---------
From: James Yeoman <james.yeoman@appsbroker.com>
Date: Fri, 27 Mar 2020 at 14:31
Subject: Re: Bug Report
To: Pratyush Yadav <me@yadavpratyush.com>


Hi, of course

=== File at commit 1 ===
import java.util.List;

public class Foo {
    private int id;
    private String name;
    private List<Programme> programmes;

    public Foo() {

    }

    public Foo(int id, String name, List<Programme> programmes) {
        this.id = id;
        this.name = name;
        this.programmes = programmes;
    }

    // getters and setters
}

=== File in working area ===

import java.util.List;

public class Foo {
    private int id;
    private String name;
    private List<Programme> programmes;

    public Foo() {

    }

    public Foo(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Foo(int id, String name, List<Programme> programmes) {
        this(id, name);
        this.programmes = programmes;
    }

    // getters and setters
}

=== diff with default ===
-    public Foo(int id, String name, List<Programme> programmes) {
+    public Foo(int id, String name) {
         this.id = id;
         this.name = name;
+    }
+
+    public Foo(int id, String name, List<Programme> programmes) {
+        this(id, name);
         this.programmes = programmes;
     }

=== diff with patience ===
    public Foo(int id, String name) {
+        this.id = id;
+        this.name = name;
+    }
+
     public Foo(int id, String name, List<Programme> programmes) {
-        this.id = id;
-        this.name = name;
+        this(id, name);
         this.programmes = programmes;
     }


On Fri, 27 Mar 2020 at 12:59, Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi James,
>
> On 27/03/20 11:53AM, James Yeoman wrote:
> > gitk and git-gui are both not respecting git config.
> >
> > When I set the diff.algorithm global config to patience, the command
> > line git respects the config. However, both gitk and git-gui don't.
> > When I use "git status -vv" to get a diff of the working directory,
> > the diff produced respects the algorithm choice. The diff of the
> > working directory in gitk and git-gui both still use the default diff
> > algorithm, rather than the algorithm from the config.
>
> Thanks for reporting. Can you please send steps to produce a simple
> scenario where the diff from two algorithms is different so I can test
> why git-gui is not respecting the config. Make them as minimal as
> possible.
>
> Also, +Cc Paul, the gitk maintainer.
>
> --
> Regards,
> Pratyush Yadav

-- 



