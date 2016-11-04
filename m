Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20732022D
	for <e@80x24.org>; Fri,  4 Nov 2016 16:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935415AbcKDQKK (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 12:10:10 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33586 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934706AbcKDQKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 12:10:08 -0400
Received: by mail-qt0-f169.google.com with SMTP id p16so50931840qta.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T6WG1ryWSTcfULgR60lSI9/ZIuHrFwnVnPlQmtgWR4o=;
        b=PyzqqmKdhfsXC+GmWHhIdtvLH/q6dx3pY/aMcXbUo2r3YoTpwdGbliIUJEnPfvo5/X
         8ztwDDRJK6+JKkwrCqiwgtRrzuyMeDtUB5VGcR4T/W1jguhDCBDpz8rdZM+rdjXW7djq
         KCboohMb/aK/teOb/iqkV9UxX7RUqlWD017Br19kjavY98NVRydttQivaVJA7h7lbmqm
         BqCvC849WXUfywKGviNpD7b6H1ItAKR8r5zMKhd/TveAldF6hQBR866Axa2YYirwgU9c
         XrM6sTXq6rzkkTvloSnDQIm0w7gi+B54xY7hs5rMnhzK9PVO2hBWxNTjELg0thsNCgEM
         PIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T6WG1ryWSTcfULgR60lSI9/ZIuHrFwnVnPlQmtgWR4o=;
        b=eObfwDvRP+LneeEE6HofotipgiDV7QysQBivRXeRCGuw5czvVFG9kMf/AAMJmuIC6p
         E+Og1K3anHVgaMx+Uj9Ax5Xm7ObHJTjl9TCMPXxfN5WWLqBvMnaFYaY2YuOqGWfoguFG
         cYkeXwwIuI6WQBawrxLL4ceHIWkHue+z8c5kJrFcxWhEKco+gHKVwjRsLSz+7kYXrRNJ
         UAFLNuTcWKM9eFaS0+VIHZ+PVHrD8AInLTc4RhR4q3muhTHeLpahPBl442OOlM0ubyDB
         qnM1XV7rjVWRSL5MqG96dahUaNYZnKUZPqLZrCB+E+TSTWeKolGWHXZLZJmTKw9/M0VU
         f9/A==
X-Gm-Message-State: ABUngvcpeBWDZurEgxLqKN6dXY59ZRHkJ20fqQA2pQTlsxoJyQ+Oguda8wX0SoodjGIrWP5SQCSGgPBpUQFf+M4J
X-Received: by 10.237.63.25 with SMTP id p25mr14359044qtf.18.1478275807453;
 Fri, 04 Nov 2016 09:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 4 Nov 2016 09:10:07 -0700 (PDT)
In-Reply-To: <CADJspfL3zVCPv+mfRM_v4ukUggQkhGH7KB50a+HLPZXZqn1pXw@mail.gmail.com>
References: <CADJspfL3zVCPv+mfRM_v4ukUggQkhGH7KB50a+HLPZXZqn1pXw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 4 Nov 2016 09:10:07 -0700
Message-ID: <CAGZ79kafn3usjKPPif6yRg1r_zyspWGNqOPLpCeyQwqFKXydwQ@mail.gmail.com>
Subject: Re: git -C has unexpected behaviour
To:     Felix Nairz <felix.nairz@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 7:28 AM, Felix Nairz <felix.nairz@gmail.com> wrote:
> Hi guys,
>
> I ran into some really weird git behaviour today.
>
> My git --version is: git version 2.8.1.windows.1
>
> We have a git repository with a submodule called TestData. The data in
> there is modified and reset as part of our unit tests.
>
> The submodule is a sub-folder of the git repository called TestData.
> So the relative path from the git repository to the submodule is
> .\TestData
>
> If I delete the entire TestData folder and run
> git -C .\TestData reset --hard
>
> I will get the following error:
> git : fatal: Cannot change to '.\TestData': No such file or directory
> This is as expected.
>
>
> Now, to the unexpected part, which I think is a bug:
>
> If the TestData folder is there, but empty (I deleted all the files),

And "all the files" includes the ".git" file, which git uses to find out if
it is in a git repository. So it keeps walking up until it finds a .git
file/directory, which is the parent project.

Once a git directory is found, the main function of git initializes some
data structures, e.g. the "path prefix" inside the repository which would be
" .\TestData" in your case. then the actual command is found and run.

So what it is doing is:
"Suppose you are in the TestData directory of the parent project and then
run the command ..."

My gut reaction was to propose to check if any GITLINK (submodule)
is a prefix of said "path prefix" and then rather initialize and operate on
the submodule.

However I do not think this is a good idea:
* Git wants to be fast and checking if we are in any submodule
slows down the common case.
* Historically commands in un-initialized or deinitialized submodules
behave as if in the parent project. I think if we'd fix this issue, other
people would complain as their workflow is harmed.

>
> Because of this we have had losses of uncommitted changes a few times
> now (loosing a few days of work, and getting a bit paranoid),

* commit early, commit often such that the losses are less than a few days.
* do not remove the submodule directory as a whole thing
  (make sure the .git file is there and not wiped)
* instead use "git -C TestData clean -dffx && git -C TestData reset --hard"
   https://git-scm.com/docs/git-clean


> could never find the root cause for this until today, where I found
> out that it happens when the TestData directory is empty.

I am undecided if it is a bug or a feature. Fixing this as a bug
would be a performance penalty. Not fixing it may incur data losses.
I dunno.

>
> Thank for looking into this, and I am looking forward to hear your
> opinions about this.
>
> Best Regards, Felix Nairz
