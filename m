Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B46C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 16:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJNQ6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJNQ6h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 12:58:37 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5B1D5549
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 09:58:35 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id y80so4360782iof.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 09:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKyOBfQt47ZvATpc+qCP0ThzFFxC/35LhqBAp0d68Z4=;
        b=Pgb/0dlC2Tcy8LReGAXP7VSDbUqk1WUXaAzW29AghJipCRZardkYuMe7L/ST8+5Q+Q
         mtzr+QRXGgxktA/QPCOsoH6nlMqts27BLlPHHUq+w8iFg56zqeIHuQpWROx3IspZ528T
         esfZ/YnvNW6DYfanVLFRTFQIYdXHqC7i59XSIE5l8U14IbA7qmACw3BjHjyVDuH8PfqQ
         PB9yyYpQ69U+luLVYTZkOKAlDa2QRDhd7LsZ7Q4SGJuTqVjqqBG7VnnKGctGTmrOP7ju
         zB9faeyfJa6ouHQ0KgPSb4K/CwRkczNgwvMv/d0fIMp+Z50WUQBNWGhdz20J4IBajqw/
         X/Kw==
X-Gm-Message-State: ACrzQf1KiEwdyWL42BS3SDzdMjqMXpZhvC5moHTmroKKvPG0k/sjnqCp
        cG0SweVxqtrgESvPnkX4stl8YMdRr9xoc0aidTg=
X-Google-Smtp-Source: AMsMyM6ihqy3upsRaSvXzDrYvATvK72Wfr8Chjsfkt4YPxOxCzqrs5IFpfv5bebXF3qbcOFpP+3Kbvu/O0HSHLTGoaQ=
X-Received: by 2002:a05:6638:490e:b0:363:c0fb:a5ea with SMTP id
 cx14-20020a056638490e00b00363c0fba5eamr3267469jab.285.1665766715088; Fri, 14
 Oct 2022 09:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
 <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
 <xmqqv8om9yaz.fsf@gitster.g> <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
In-Reply-To: <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Oct 2022 12:58:24 -0400
Message-ID: <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 12:35 PM Derrick Stolee
<derrickstolee@github.com> wrote:
> On 10/14/2022 12:15 PM, Junio C Hamano wrote:
> > "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> Cc: Christian Couder  <christian.couder@gmail.com>
> >> Cc: Hariom Verma <hariom18599@gmail.com>
> >
> > What are these C: lines for?  I do not think the message I am
> > responding to is Cc'ed to them.  There may be a special incantation
> > to tell GitGitGadget to Cc to certain folks, but adding Cc: to the
> > log message trailer like this does not seem to be it---at least it
> > appears that it did not work that way.
>
> GitGitGadget will read the "cc:" lines from the end of the pull request
> description, not the commit messages. I'm pretty sure they will be
> ignored if there are other lines after them.

For Wilberforce's edification for future submissions, presumably the
reason that the CC: in the pull-request's description didn't work is
because the CC: line wasn't the last line in the description? Does
there need to be a blank line before the CC: line? Is it okay to list
multiple people on the same CC: line as done in this case, or is that
also a problem?
