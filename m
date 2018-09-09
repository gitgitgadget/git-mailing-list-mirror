Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D2B1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIIXzr (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 19:55:47 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:39705 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeIIXzr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 19:55:47 -0400
Received: by mail-io1-f53.google.com with SMTP id l7-v6so5286537iok.6
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTbt7TvCXi3dVoX3LMwtODpY6Bsevn6R5fCt2uVG8Wo=;
        b=M+s+WVOC5S3d0KM/knCn4IJlHj6lclL+pGJhFzqbhzh7cvrG3wN7t687/nzYE6MDwZ
         5WpO6flB/6wOR0ks6xzWpYv9dQd+QOmsfmRBYzslIDKQU+RCKtLPt0TB7XQRETKkLM61
         faGqIWyE0UGeXem5l4HvG4Vvy1wKpiPMRRN6IsRUprBX1OKqwFEhQyshDQo4HnHhXVUC
         xJlNnmLrgCQswZTcC+hW9wFeGHkfTOwb/wVGHSkhEEJclhXxIFIPXn8QjPy9jIhOfhwR
         VjSGi/9cdig6Lq1EU1MyvLBDfEzR8bZ5uQ7TtpDS/ASstd3PFHJdI0cZCCidsBiMjeTW
         jQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTbt7TvCXi3dVoX3LMwtODpY6Bsevn6R5fCt2uVG8Wo=;
        b=UW/CKMiPUW8ZBnfuXGuX+3onPIGf2fboeyG/NfQ0G3rkPMLtZ4RePvPkApoU5iR4DS
         Y7kj8Kt9YP52Amlu32NYHTP+eEgSKfduFEVJPSHyJlINkfh2xElZxZsbE/JfFTToIhiQ
         F0Znb3/WZdIq0U8/nZ81QDNiP7O6Eo/YqlqeYPs8j3trxoJoFpGCTFh7yib2ZX+Qh0rd
         /lhNDb3IzHaKnsyDDqm9OP8qXPa5hB3q9uHK7Y2vNgJoP8bNzZN6wy/Bwn3AazG+ayF7
         ZAFHwN4LsEmQx4t6INzxIdV0T4JdvbiKm9aG0Ssn79iv4XmRvCTGZoddKixU+5c5Vu42
         g4fg==
X-Gm-Message-State: APzg51AjmbInUg8armlmgps6QP0puJDjfP7AU3TGo6LT/suKYIdM8e4L
        s4Ok0VFOOB6td66/g+hSIbFWgTcqRskNsH8P9jOFMw==
X-Google-Smtp-Source: ANB0VdbWOAl4wwymjTf4xitci3pUpSurFlpcrMagW9XGynOr4w+V8DXRxq9BOTGQy/EgOmoNRLp/sSDsX298DWwWarQ=
X-Received: by 2002:a6b:5911:: with SMTP id n17-v6mr14752622iob.68.1536519909139;
 Sun, 09 Sep 2018 12:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGJNu5RPXjeib-vayVzmFkU9cZ=h5o5VDoM1vQqv2+HgtNXLw@mail.gmail.com>
 <CAPGJNu5=GkiALR1=RYgHLv3NDrycqv13jpU5_=SOW-yWtRXduw@mail.gmail.com>
In-Reply-To: <CAPGJNu5=GkiALR1=RYgHLv3NDrycqv13jpU5_=SOW-yWtRXduw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Sun, 9 Sep 2018 12:04:58 -0700
Message-ID: <CAGyf7-EFiZ7ouUPDMtv3eb57QEiM2pkavyKQe7iNO7+eBeuZ9w@mail.gmail.com>
Subject: Re: [Possible GIT Bug]
To:     dylanyoungmeijer@gmail.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 9, 2018 at 6:31 AM Dylan Young <dylanyoungmeijer@gmail.com> wro=
te:
>
> Works:
>
> git show -C --find-copies-harder  055f6c89fa4506037d1621761f13430f469b802=
9
>
> git show -C --find-copies-harder
> 055f6c89fa4506037d1621761f13430f469b8029 --name-status

Here, because you didn't provide _any_ paths, Git is allowed to
consider all of the paths modified in the commit and, because you
specified --find-copies-harder, it's allowed to consider paths that
_weren't_ modified too. That means it can "see" both the source and
destination for the copy, and it detects the copy as you're expecting.

>
> Doesn=E2=80=99t Work:
>
> git show -C --find-copies-harder
> 055f6c89fa4506037d1621761f13430f469b8029  --  PATH_TO_MY_COPIED_FILE

Here, though, you've _explicitly limited_ Git to only the copied file.
It's not allowed to consider any others, which means it can't "see"
the source path anymore. As a result, the copy is detected as a
straight add. Note that --find-copies-harder means the diff machinery
is allowed to consider files that weren't modified in the commit as
possible sources for copies, but that's still subject to your explicit
filtering. In other words, if PATH_TO_SOURCE_FILE wasn't modified,
running this would _not_ see a copy:

git show -C 055f6c89fa4506037d1621761f13430f469b8029  --
PATH_TO_MY_COPIED_FILE PATH_TO_SOURCE_FILE

But running this would:

git show -C -C 055f6c89fa4506037d1621761f13430f469b8029  --
PATH_TO_MY_COPIED_FILE PATH_TO_SOURCE_FILE

No bugs here. Everything is working as intended, if not, perhaps, as
you expected.

Hope this helps,
Bryan

>
> i.e.
>
> --- /dev/null
>
> +++ b/ PATH_TO_MY_COPIED_FILE
>
> Hope that=E2=80=99s self-explanatory!!!
>
> Best,
> Casey Meijer
