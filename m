Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2031F1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 20:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965761AbeBMUmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 15:42:47 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36564 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeBMUmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 15:42:46 -0500
Received: by mail-yw0-f180.google.com with SMTP id t129so13238432ywc.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2GSysmzhSdc3LpgiPKazNxdRgBi0XYdt1H3vMhPA+Sc=;
        b=O1vSLfI0SDg7g/FPk/1Pi/68w03SsjXEPnb/DF+U6+aqKUCZ6m7L0l6amW13+4F3LP
         HVEBw0VctS1nFXq+QzkvJKakx0b4WJduDics63Z28BnGpw8TEMPKQITQx0RE4z0vhTbR
         3F4OLEAsj6bwPlxkXdELZHyhHS1SfjUXpUyP4ZA0Wm7RqwOwSoP/pNH+GHcXMtrnuD0k
         MCI6pOnIinY3HVXf5OscFyEbrl9r458HiRYJk/Bz43YoE0PKSGSSRX2lUcRiIOeoIP44
         H9fycnSGD/03xF/3U7ihuzJUiRCbKScuRQu8cjD0VmUGZKyQWmMsgGHSW/vhFNzlFa0P
         be9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2GSysmzhSdc3LpgiPKazNxdRgBi0XYdt1H3vMhPA+Sc=;
        b=fbg2PmVk8w1JBmwv4WzroGt8Kie0x+WdcS96fxLREhCviqFfU2+U1NT2wVUnNAShaM
         C96il7vVpiOEaV836ayf2xz0HEJc+j6MX61RLg/3ZMaolz2M8oj2G+hFlJdwGETPX/od
         qEoAOdYszc1MPekP9JF4lIEMyU/bzp/dYse/yjHMri2n2zXZL3Nvgnx8gh0Hu7PQEQRI
         NfqRMgNdyckDUOUyzcu+X4VRcs7BcOtjMcgSYQ2OCEyj3jjcSr5G/Aso7iw3VvJMfnSe
         sHWCHkIpFWb5Up3TluEmwfxqNCf2PkNGU7ANk6pj2LLKT7cLqTnXSQhwLQOGRwYavnnY
         Gqeg==
X-Gm-Message-State: APf1xPBXBqg0Dx553/WMbvrhgjIIHdnBiQOzKeKW8SIOJv6BhIrZjc+s
        T2booZ4EZX47Q9+v0ztDmcYnmBAZKdnBjVkQ6qHKnQ==
X-Google-Smtp-Source: AH8x224Kd4RgKwEdqy7ml0pEIOB2VoR0DjSaGX/JM/pFugJIbJmjciRhsYsLj69qfpKCf7I67CW4xROBa2CzabQvHxM=
X-Received: by 10.37.101.11 with SMTP id z11mr1718131ybb.201.1518554565989;
 Tue, 13 Feb 2018 12:42:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 12:42:45 -0800 (PST)
In-Reply-To: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 12:42:45 -0800
Message-ID: <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
Subject: Re: git-rebase --undo-skip proposal
To:     Psidium Guajava <psiidium@gmail.com>,
        Paul Tan <pyokagan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 12:22 PM, Psidium Guajava <psiidium@gmail.com> wrote:
> Hello git community,
>
> I'd like to add a new feature in git-rebase: --undo-skip.
> But first, I'd like to consult with the experts if it would be
> beneficial for the project and if my line of tought is correct.
>
> Imagine that you are working on a feature for a long time, but there
> are multiple bug fixes happening at `master` branch at the same time.
> After lots of commits on both ends, you decide to rebase your changes
> on top of the current `master` branch.
> After lots of conflict resolution steps, you mistakenly call
> `git-rebase --skip` instead of `git-rebase --continue`, thus losing a
> commit of your work, and possibly inserting bugs in your project.
> The only solution for this right now would be to abort the current
> rebase and start over.
>
> It seems that a feature like this have been requested once on the mail list [1].
>
> I propose the existence of --undo-skip on git-rebase's `$action` domain.
>
> How I fixed it when that happened with me was (just after running the
> wrong skip):
>
> 1. I figured I was making a rebase that used `git-am` as a backend.
> 2. In the rebase-apply directory I searched for the patch file with
> the change I just skipped.
> 3. Found the `rebase-apply/next` file.
> 4. Wrote the number of the patch I skipped - 1 in rebase-apply/next.
> 5. run `git rebase --skip` again on the repository.
>
> This made the lost patch appear again and I could `--continue` it this time.

I think this could also be done with "git rebase --edit-todo", which brings
up the right file in your editor.

> I propose the addition of an action `--undo-skip`, that could be
> called only after a wrongfully called `--skip`.
> `git rebase --undo-skip`.
> I would implemented it to do programatically what I did by hand when
> that happened with me.
>
> Here are my questions for you:
> 1. Would this be beneficial for the users?

I guess it is.

> 2. For `rebase--am`, I would need to change `git-rebase--am.sh` file, correct?
> 3. Can I assume `builtin/am.c` will always store its information on
> `$state_dir/next` and `$state_dir/$patchnumbers`?
> 4. How hard would it be to add that logic for `rebase--interactive`
> and `rebase--merge` backends?

cc'd Johannes who is currently working on revamping rebase.

>
> Also, a little unrelated with this issue:
> 5. What happened to the rewrite of rebase in C [2]? I couldn't find
> any information after 2016.
>
> [1] https://public-inbox.org/git/201311011522.44631.thomas@koch.ro/
> [2] https://public-inbox.org/git/1457779597-6918-1-git-send-email-pyokagan@gmail.com/

cc'd Paul Tan, maybe he recalls the situation.
