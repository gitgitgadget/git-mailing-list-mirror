Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA28920357
	for <e@80x24.org>; Mon, 10 Jul 2017 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754467AbdGJUCK (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 16:02:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34089 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbdGJUCI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 16:02:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so13923511pge.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AE4brVia+gJ5fJ+yLjJwxy4k7VOyMwmTTAhg6aFID2c=;
        b=rpO2FF/wPzUJ514DWLFzsDYYF79a+FsH7cTqcsKrQD7EQaO4K0PNHzWm64Yb1+c+kZ
         191iPPLtsVH9+thOORS3C7AU4vRfzKHWiNeqXIUNhuYm2U4jG3rB3/hKyile3u0a3oyF
         avdrb7xVJbG/KxrLcGt/7/IgAnwxCkcPQV5o+KPelV9CcqposrMVJHs3I0IqpP5d+HoC
         EefsWCfrwXMBkj2s7bPLJCHO2aBvIWD8GJh5H1nZYwGtLx4tStp+665OdkF/oyH5TUPe
         DavZrlrzZHD6i5go5GCpQ073QJeE3mAU57l6uJ2kKP0J1C6A3D8oeTENSQVDVKdPorNW
         ixlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AE4brVia+gJ5fJ+yLjJwxy4k7VOyMwmTTAhg6aFID2c=;
        b=A+1hU8X8ozDzsU5WGVYDmO4ku0bJ3cPpwgyH4ZwZC7eJioMIEcJDX0v6eGUoCG0ECG
         SeBPeKxSqC9YYpNbahvRJrPZK+nF5z+8J+Sm7hpVhLv+5p/YpW8v4Epmhb2PHGSjplwq
         re9DGIkqJ4jqhaYpbRXeB1ZVYKyMjL16xmBh5bpfFfnha2q7sQDnpwqGfUpxaEHBLFl+
         Dl2YMt4/nKYme0JowucGGweFx/XU0ahsSQ4UjO0yxL+krTIM1R+WnAXX7XidUQ3thXpC
         HOnOa9lQQos3oPcWuccQYcMNW2uQUr9hCpGf73Tc9/SF8O9EpTC91XzFR8a4lEVw7ssJ
         BotA==
X-Gm-Message-State: AIVw110pm8hmeCL/9g7ankZZZjQebxh3Y5MVI0VHibN9tUCkzpfdJO/2
        JhTs+aIkrMbdpw==
X-Received: by 10.99.123.17 with SMTP id w17mr16347753pgc.100.1499716928089;
        Mon, 10 Jul 2017 13:02:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id p5sm25732830pgf.50.2017.07.10.13.02.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 13:02:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] hook: add a simple first example
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
        <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
        <20170710141744.8541-4-kaarticsivaraam91196@gmail.com>
Date:   Mon, 10 Jul 2017 13:02:06 -0700
In-Reply-To: <20170710141744.8541-4-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 10 Jul 2017 19:47:44 +0530")
Message-ID: <xmqqbmos5add.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

>  I made an attempt to make the second example work with amending 
>  with the aim of making it suitable for usage out of the box. It
>  seems that it's not easy to make it work as the status of a file
>  cannot be determined correctly when the index while amending
>  introduces changes to a file that has a change in the commit being
>  amended.
>
>  Is there any way in which the second example could be made to work with
>  amending without much effort? I'm asking this assuming something might
>  have happened, since the script was added, that could ease the task.

Sorry, but I do not understand what you are asking here.

Ahh, do you mean if we can avoid doing one half of the 1/4 (i.e. the
part that removes the commented out 'diff --name-status') and instead
make it a useful example (while still removing the thing that
comments out the "conflicts:")?

After going back and checking 1/4, I realize that I misread the patch.
you did keep the commented out 'diff --name-status' thing, so it still
has three---it just lost one half of the original "first" example.  So
please disregard my earlier "do we still have three, not two?"



>  Documentation/githooks.txt                 | 3 +++
>  templates/hooks--prepare-commit-msg.sample | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index fdc01aa25..59f38efba 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -121,6 +121,9 @@ it is not suppressed by the `--no-verify` option.  A non-zero exit
>  means a failure of the hook and aborts the commit.  It should not
>  be used as replacement for pre-commit hook.
>  
> +The sample `prepare-commit-msg` hook that comes with Git removes the
> +help message found in the commented portion of the commit template.
> +
>  commit-msg
>  ~~~~~~~~~~
>  
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index a15d6d634..a84c3e5a8 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -9,7 +9,8 @@
>  #
>  # To enable this hook, rename this file to "prepare-commit-msg".
>  
> -# This hook includes three examples.
> +# This hook includes three examples.  The first one removes the
> +# "# Please enter the commit message..." help message.
>  #
>  # The second includes the output of "git diff --name-status -r"
>  # into the message, just before the "git status" output.  It is
> @@ -23,6 +24,8 @@ COMMIT_MSG_FILE=$1
>  COMMIT_SOURCE=$2
>  SHA1=$3
>  
> +@PERL_PATH@ -i.bak -ne 'print unless(m/^. Please enter the commit message/..m/^#$/)' "$COMMIT_MSG_FILE"
> +
>  # case "$COMMIT_SOURCE,$SHA1" in
>  #  ,|template,)
>  #    @PERL_PATH@ -i.bak -pe '
