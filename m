Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA196C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DC6205C9
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 09:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="D1u+ZeYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfLKJnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:43:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41712 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfLKJnN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 04:43:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so23264974wrw.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 01:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGXuYkALn/BQIGKJa66LubUs2Nd+5PjC9XYLyWl7kdY=;
        b=D1u+ZeYqFYlxy4tz7hi6PB8eGiW/gVGuknbcMIV/KmQBWfhnVChHSVpnKKDK2FZF0o
         vUldotWkaN5MffiLlka0Zgp/qLvM48rXEQ1YOHbk0Ex4GOHOBlsR34uquFKoEvouY8KT
         z7aW9hc7JImEBA/ewNTPBbyaZWRcSJ4p71SeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGXuYkALn/BQIGKJa66LubUs2Nd+5PjC9XYLyWl7kdY=;
        b=Uh9dEV+6UJmhx0yFCCvl51QlPCgRVNAO2HlKbHhk5YgPijXy4lHZihscOrVVShrYy0
         xNZrS449YYB1Jrk6ZWgk7HBzBSuASy/LAd5hl8O3cizlsT4CFw1luTevBZP6tXAIZP5r
         w7G3wes0JEYbiK325HFI9Do7AyOdZsykzG1DjiYlP9lhxDlWC7rr+th2j2rpXZZDUWfn
         Eybwoql3sB72N/L1iyoMDnKFqEDWkqRi2z26ewSCGiebBu0hjQOvTV/0W+56TddGvF/b
         AFOPC0213HOrsNdr/rsG6twvKjpDRyjfiTYeXWmzshY0H3j3QVEzlT2/NcKd5sQ3YASk
         jdXg==
X-Gm-Message-State: APjAAAWB+fzuWDRtShKcwtCXhuYTCM6s4FR+u6ODl/kWNKdE5QZ3+Tlc
        CRSBubqosWy6q7LS1yrLpY5sER61hPHtTck9FfZZqw==
X-Google-Smtp-Source: APXvYqxbrt7z2xJjFhThfR4G2PAzL2Z4OeGPWgY2rBie6SGQaZ20a7C5nxP+oHFAuTidUFFEEdBwbhGRJzo5XvcgS4o=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr2613596wrp.110.1576057390326;
 Wed, 11 Dec 2019 01:43:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com> <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 11 Dec 2019 09:43:03 +0000
Message-ID: <CAE5ih78hTOjXcwOxQvKLz+MAvThXLSF+CGM9RFAr7zJcSKr8pw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] git-p4: Usability enhancements
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 10 Dec 2019 at 15:23, Ben Keene via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Some user interaction with git-p4 is not as user-friendly as the rest of the
> Git ecosystem. Here are three areas that can be improved on:
>
> 1) When a patch fails and the user is prompted, there is no sanitization of
> the user input so for a "yes/no" question, if the user enters "YES" instead
> of a lowercase "y", they will be re-prompted to enter their answer.
>
> Commit 1 addresses this by sanitizing the user text by trimming and
> lowercasing their input before testing. Now "YES" will succeed!
>
> 2) Git can handle scraping the RCS Keyword expansions out of source files
> when it is preparing to submit them to P4. However, if the config value
> "git-p4.attemptRCSCleanup" isn't set, it will just report that it fails.
>
> Commit 2 adds a helpful suggestion, that the user might want to set
> git-p4.attemptRCSCleanup.
>
> 3) If the command line arguments are incorrect for git-p4, the program
> reports that there was a syntax error, but doesn't show what the correct
> syntax is.
>
> Commit 3 displays the context help for the failed command.
>
> Ben Keene (4):
>   git-p4: yes/no prompts should sanitize user text
>   git-p4: show detailed help when parsing options fail
>   git-p4: wrap patchRCSKeywords test to revert changes on failure
>   git-p4: failure because of RCS keywords should show help
>
>  git-p4.py | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
>
> base-commit: 083378cc35c4dbcc607e4cdd24a5fca440163d17
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-675%2Fseraphire%2Fseraphire%2Fp4-usability-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-675/seraphire/seraphire/p4-usability-v2
> Pull-Request: https://github.com/git/git/pull/675
>
> Range-diff vs v1:
>
>  1:  e721cdaa00 ! 1:  527b7b8f8a git-p4: [usability] yes/no prompts should sanitize user text
>      @@ -1,6 +1,6 @@
>       Author: Ben Keene <seraphire@gmail.com>
>
>      -    git-p4: [usability] yes/no prompts should sanitize user text
>      +    git-p4: yes/no prompts should sanitize user text
>
>           When prompting the user interactively for direction, the tests are
>           not forgiving of user input format.

Looks good to me!

>  3:  2a10890ef7 ! 2:  1d4f4e210b git-p4: [usability] Show detailed help when parsing options fail
>      @@ -1,6 +1,6 @@
>       Author: Ben Keene <seraphire@gmail.com>
>
>      -    git-p4: [usability] Show detailed help when parsing options fail
>      +    git-p4: show detailed help when parsing options fail
>
>           When a user provides invalid parameters to git-p4, the program
>           reports the failure but does not provide the correct command syntax.

This would make git-p4 more consistent with other git commands which
give some brief options, so seems like a sensible thing to do.


>  2:  d608f529a0 ! 3:  20aa557193 git-p4: [usability] RCS Keyword failure should suggest help
>      @@ -1,14 +1,13 @@
>       Author: Ben Keene <seraphire@gmail.com>
>
>      -    git-p4: [usability] RCS Keyword failure should suggest help
>      +    git-p4: wrap patchRCSKeywords test to revert changes on failure
>
>      -    When applying a commit fails because of RCS keywords, Git
>      -    will fail the P4 submit. It would help the user if Git suggested that
>      -    the user set git-p4.attemptRCSCleanup to true.
>      +    The patchRCSKeywords function has the potentional of throwing
>      +    an exception and this would leave files checked out in P4 and partially
>      +    modified.
>
>      -    Change the applyCommit() method that when applying a commit fails
>      -    becasue of the P4 RCS Keywords, the user should consider setting
>      -    git-p4.attemptRCSCleanup to true.
>      +    Add a try-catch block around the patchRCSKeywords call and revert
>      +    the edited files in P4 before leaving the method.
>
>           Signed-off-by: Ben Keene <seraphire@gmail.com>
>
>      @@ -30,14 +29,6 @@
>       +                        for f in editedFiles:
>       +                            p4_revert(f)
>       +                        raise
>      -+            else:
>      -+                # They do not have attemptRCSCleanup set, this might be the fail point
>      -+                # Check to see if the file has RCS keywords and suggest setting the property.
>      -+                for file in editedFiles | filesToDelete:
>      -+                    if p4_keywords_regexp_for_file(file) != None:
>      -+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
>      -+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
>      -+                        break

The code doesn't actually check if there are any files with RCS
keywords, it just looks to see if there are files that _could_ have
RCS keywords. There's some code in the other branch of the if-else
which checks for RCS keywords.

Perhaps factor that out, and then do the check (?).

Given that, this would be quite a useful hint for people.


>
>                    if fixed_rcs_keywords:
>                        print("Retrying the patch with RCS keywords cleaned up")
>  -:  ---------- > 4:  50e9a175c3 git-p4: failure because of RCS keywords should show help
>
> --
> gitgitgadget

In your branch there's also a "wrap patchRCSKeywords test" commit,
which isn't in here. That has some whitespace damage. But also I
wonder if the reverting should happen higher up, since there is
already some code around which tries to do this in other
circumstances.

Other than the small comments above, this looks good to me, thanks!

Luke
