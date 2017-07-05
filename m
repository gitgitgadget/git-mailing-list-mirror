Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A369B202B1
	for <e@80x24.org>; Wed,  5 Jul 2017 19:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdGEThg (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 15:37:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34274 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdGEThY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 15:37:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so22690777pfe.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=R2txFqiqf7/ZTuxWH8T/CTZ0Yy5MBt7KDyHubzguexQ=;
        b=u6jBT/JOYN+lzf/K2tEcLGW0nyvbzYLLRCiLQ/7QCWTLoXftXRGO7sdhMaPSrXXAAI
         X5vMuS3oVgYn2lHRxKgct2gJ/8trZBRBOyXzTFK6jEOIhIUmxfi3G9lSNb/2rfInhT7E
         woXGWUjuiqcTQ+0fGqJr7dAFLYh1f9T/haPbPPzvvcw+usCbP9ZqMaGLcaA20nstLvUc
         ha6o6rwj/JFps3wpLNcRXdlD2ROxbXo+1EojltLWPIiTlSzf/6EUP+V90kZ4/PvzLiZf
         W6DY0R+UpitrEtua/V1GdlXbflbb5PGhOOEJgF7Lud8ARGZ+GQMGmP9+UtSkBKSlgBkZ
         XADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=R2txFqiqf7/ZTuxWH8T/CTZ0Yy5MBt7KDyHubzguexQ=;
        b=MWISUOBd0SMoQysPLmizGFD1jAgEQNna8lHl8whKH4x16Jmm5lm5Yn3NDXtG2cqBIM
         bg+HI44gE7EnGggR8fAXg3bfw+r1v4tmlqFvBLloClrLwSeLqhkm1cBkNKQzDwIuuxbD
         7QL0+Th2tsBe9Hw4jSXcdYKYyTR6xqKIctbcJq7CusnvY/et1kEUdayhAqXHEqVw2ZUA
         TM5BKebuuorELKYg4Wu/84upP7uGguraGgSlG5SbEyB7NaGbzgndqJP7jsBva242ssIE
         KQlg0JG3N63rFg4VTdXiR+7tz5ct5gjB+PeecRVw98U1743nFYjkJl0yf+Gv8FZBrxwm
         uKEw==
X-Gm-Message-State: AIVw1101GcLkMm56xILU8k9EJvPrnbMNLRyZYanKsw82rs1j5br4JMAh
        IGZ/9QWtNTjSjg==
X-Received: by 10.84.217.7 with SMTP id o7mr24081048pli.156.1499283443581;
        Wed, 05 Jul 2017 12:37:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id d11sm34475641pgu.64.2017.07.05.12.37.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 12:37:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] hooks: add signature using "interpret-trailers"
References: <20170705170034.20899-1-kaarticsivaraam91196@gmail.com>
        <20170705173508.28711-1-kaarticsivaraam91196@gmail.com>
Date:   Wed, 05 Jul 2017 12:37:22 -0700
In-Reply-To: <20170705173508.28711-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 5 Jul 2017 23:05:08 +0530")
Message-ID: <xmqqvan6hdzh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The sample hook to prepare the commit message before
> a commit allows users to opt-in to add the signature
> to the commit message. The signature is added at a place
> that isn't consistent with the "-s" option of "git commit".
> Further, it could go out of view in certain cases.
>
> Add the signature in a way similar to "-s" option of
> "git commit" using git's interpret-trailers command.

OK.

> It works well in all cases except when the user invokes
> "git commit" without any arguments. In that case manually
> add a new line after the first line to ensure it's consistent
> with the output of "-s" option.

OK (but its execution can be simplified).

> While at it, name the input parameters to improve readability
> of script.

Good.

>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Added a close quote that got missed in the previous patch.
>
>  templates/hooks--prepare-commit-msg.sample | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index 86b8f227e..4ddab7896 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -20,17 +20,28 @@
>  # The third example adds a Signed-off-by line to the message, that can
>  # still be edited.  This is rarely a good idea.
>  
> -case "$2,$3" in
> +COMMIT_MSG_FILE=$1
> +COMMIT_SOURCE=$2
> +SHA1=$3
> +NEW_LINE='\
> +'
> +SED_TEMP_FILE='.sed-output.temp'

Move the latter two variable definitions to where they matter,
i.e. the commented-out part that computes and adds $SOB.

> +case "$COMMIT_SOURCE,$SHA1" in
>    merge,)
> -    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
> +    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$COMMIT_MSG_FILE" ;;
>  
>  # ,|template,)
>  #   @PERL_PATH@ -i.bak -pe '
>  #      print "\n" . `git diff --cached --name-status -r`
> -#	 if /^#/ && $first++ == 0' "$1" ;;
> +#	 if /^#/ && $first++ == 0' "$COMMIT_MSG_FILE" ;;
>  
>    *) ;;
>  esac
>  
>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
> -# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
> +# git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
> +# if [ -z "$COMMIT_SOURCE" ]
> +# then

In our codebase (see Documentation/CodingGuidelines) we tend to
prefer "test" over "[".  I.e.

	if test -z "$COMMIT_SOURCE"
	then

> +#  sed -e "1i$NEW_LINE" "$COMMIT_MSG_FILE" >"$SED_TEMP_FILE" && mv "$SED_TEMP_FILE" "$COMMIT_MSG_FILE"

This looks like a more complex way to say

	{
		echo 
		cat "$COMMIT_MSG_FILE"
	} >"$SED_TEMP_FILE" &&
	mv "$SED_TEMP_FILE" "$COMMIT_MSG_FILE"

I wondered if it is safe to use a single hardcoded "$SED_TEMP_FILE",
but I think it is OK.

> +# fi

Thanks.
