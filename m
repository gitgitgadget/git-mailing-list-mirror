Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5AE120357
	for <e@80x24.org>; Mon, 10 Jul 2017 19:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbdGJTvC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 15:51:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35677 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbdGJTvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 15:51:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so13897850pgc.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SAfdoloAAhgeE6rUo8CX6SRfhC7FuYuar8TKjc3Xyok=;
        b=JdLvrgO6Ok0BJegUSN88ASSju92+qi1GtsqAgvnAqDgpaPBwFxcD0NJ4aUw8/Ms++b
         r/0qKWGS1aIPkX6G94tPv8RvHYlgi8Pc/FQL7Pz5GPdPzU7IP7E19jOLzWw1jrHths43
         /+YHnv7CtZmOqb6241K44UaiN7wlWIHqpj3zb0pIPaPSrn0ysQpNEzxWjIZc9+XR2xnb
         tRyDsoFD7n81Ou3oW4SiPjliUsirspWxW4D2fDPRsDmiTsNVGxzXUFKtmR8kBOG/B1Xy
         tzmfsq1jVy/lJ/ctPweziaY3H+uuSiZJsZ1numH5m0raxPdFOkHZpYaaJAQlmizcgiq3
         7mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SAfdoloAAhgeE6rUo8CX6SRfhC7FuYuar8TKjc3Xyok=;
        b=mQGf2aXqXxOXcyZJeUiFFbIwiB55m+d6lN8EbVJveI20wh7ZrTbvR+mcRWwGhvOn2a
         vGoR+/NQ2UtqOtvK/SvoJpohFO8TsKHc97PpBVSzlpSe2abeA3ZwaLtrBUIy5L1nMztL
         CJW0Aep5G6Zp2Qo2zo1hqAicRBnFc9CznmzrwVwIKXEA2ygWwzWaDmD8oLn0vYinS5Dl
         Bvzq7batwUpETw7B7y4aHjRrN3vSX5zY8C5Vl1jeY6f1YrRgRlhw6Vq68S6ZcXFAzpwE
         5TOuVwQ0mKkc4btKh9lPW/k2DedsjOSz7YWmw3Lha0Hx3LQnfRVkorTBhcJUw2mg2wI1
         m70Q==
X-Gm-Message-State: AIVw112FgXpeYAYEKARKcqWGj7XSqyVABJfc8dz2XLez5mkxje0Y2a5x
        NVxeenIDPZYZCw==
X-Received: by 10.84.228.207 with SMTP id y15mr19640694pli.13.1499716261012;
        Mon, 10 Jul 2017 12:51:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id u2sm30251571pgn.28.2017.07.10.12.50.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 12:51:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] hook: cleanup script
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
        <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 10 Jul 2017 12:50:59 -0700
In-Reply-To: <20170710141744.8541-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 10 Jul 2017 19:47:41 +0530")
Message-ID: <xmqqo9ss5avw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Prepare the 'preare-commit-msg' sample script for
> upcoming changes. Preparation includes removal of
> an example that has outlived it's purpose. The example
> is the one that comments the "Conflicts:" part of a
> merge commit message. It isn't relevant anymore as
> it's done by default since 261f315b ("merge & sequencer:
> turn "Conflicts:" hint into a comment", 2014-08-28).
>
> Further remove the relevant comments from the sample script
> and update the documentation.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Documentation/githooks.txt                 |  3 ---
>  templates/hooks--prepare-commit-msg.sample | 20 ++++++++------------
>  2 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 706091a56..fdc01aa25 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -121,9 +121,6 @@ it is not suppressed by the `--no-verify` option.  A non-zero exit
>  means a failure of the hook and aborts the commit.  It should not
>  be used as replacement for pre-commit hook.
>  
> -The sample `prepare-commit-msg` hook that comes with Git comments
> -out the `Conflicts:` part of a merge's commit message.
> -
>  commit-msg
>  ~~~~~~~~~~

Makes sense.

>  
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index 86b8f227e..b8ba335cf 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -9,8 +9,7 @@
>  #
>  # To enable this hook, rename this file to "prepare-commit-msg".
>  
> -# This hook includes three examples.  The first comments out the
> -# "Conflicts:" part of a merge commit.
> +# This hook includes three examples.

Didn't we just remove one, reducing the total number to two?  If so,
the second and the third below would need to be promoted to the
first and the second, I think.

>  # The second includes the output of "git diff --name-status -r"
>  # into the message, just before the "git status" output.  It is
> @@ -20,17 +19,14 @@
>  # The third example adds a Signed-off-by line to the message, that can
>  # still be edited.  This is rarely a good idea.
>  
> -case "$2,$3" in
> -  merge,)
> -    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
>  
> -# ,|template,)
> -#   @PERL_PATH@ -i.bak -pe '
> -#      print "\n" . `git diff --cached --name-status -r`
> -#	 if /^#/ && $first++ == 0' "$1" ;;
> -
> -  *) ;;
> -esac
> +# case "$2,$3" in
> +#  ,|template,)
> +#    @PERL_PATH@ -i.bak -pe '
> +#       print "\n" . `git diff --cached --name-status -r`
> +# 	 if /^#/ && $first++ == 0' "$1" ;;
> +#  *) ;;
> +# esac
>  
>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
>  # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
