Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE87A202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 16:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdGEQ0U (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 12:26:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33892 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdGEQ0T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 12:26:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so21983500pfe.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fQOE0dTkEVvP54QRAmyMCiqVlJNS0NRB11wvttkqUcg=;
        b=hSCn/81Xh5R86d6KyjMVKzT/c/aeCGz1WJSN+80QHDSkYg3JynNp1cV4xMjhOkmGVR
         N7a1iakY4BW5TeDfHRqI8Cmb/W4Whn+6yWWWNKSpGXGP7Nere8nGcdz5zrPCJ+RlVSlh
         zdvhtAZrmtRce8o8Wnjfcgnu6X0Ucd3JAWA5pZdoyNpA2EQd7Uu0MZL1pMUJZye08gnA
         BNJpxiA5Jw84JAfighuCbwSMbCuNibbR7pi+4UbNCHucHkHtgFjCaSQPzZv00fjj8+P8
         po1DkKXD0KpJLvMnDFBbF/9k75z8jURXxuR7vbit6qXkdfnLuH8guIa/opJUoWAPeFYW
         lglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fQOE0dTkEVvP54QRAmyMCiqVlJNS0NRB11wvttkqUcg=;
        b=tSkXtlXttYlo3yqxhxoYDrY2SPuPOyORxb72YfKlSB4VIrPwi26sYRzwy2KurP93q0
         aiuD7vf6mnk/i+omwFVbkg5WF12rFEWfodGWN2+pK38SYVGA26JiF58FHf0rngQLJ+Po
         tM1S1z7UtezdZ5XInVdjfV8UrlKjfXu3zvN7Zl1JXnvvtRje8kDBZe+YCA/0f2aukNxW
         Mw/MN6nB8mPfcIv1xEf6F1c8sHAa7NsXR3KoI4anxDYWlpYyUFYiy4W3I4GK4DqiX0vM
         rCqWhauu+vQoPPZIn0i7nhRw37d/OmVPjXec4Y+Hj431nqdZ6mHG6p+knysNgf2GgO1b
         6FEw==
X-Gm-Message-State: AIVw111fEp22m2sWgJd+eXsx2+5bzGES2+s9qKkFUPeRkmXAK4rZJ9FA
        dsziJ+u/eR9CVQ==
X-Received: by 10.84.215.135 with SMTP id l7mr13376853pli.194.1499271978611;
        Wed, 05 Jul 2017 09:26:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id c22sm54931904pfl.97.2017.07.05.09.26.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 09:26:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t5534: fix misleading grep invocation
References: <936f43ce2c993e545deaee5e196c018933375214.1499254650.git.johannes.schindelin@gmx.de>
Date:   Wed, 05 Jul 2017 09:26:15 -0700
In-Reply-To: <936f43ce2c993e545deaee5e196c018933375214.1499254650.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 5 Jul 2017 13:37:49 +0200
        (CEST)")
Message-ID: <xmqq1spukfyw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It seems to be a little-known feature of `grep` (and it certainly came
> as a surprise to this here developer who believed to know the Unix tools
> pretty well) that multiple patterns can be passed in the same
> command-line argument simply by separating them by newlines. Watch, and
> learn:
>
> 	$ printf '1\n2\n3\n' | grep "$(printf '1\n3\n')"
> 	1
> 	3
>
> That behavior also extends to patterns passed via `-e`, and it is not
> modified by passing the option `-E` (but trying this with -P issues the
> error "grep: the -P option only supports a single pattern").
>
> It seems that there are more old Unix hands who are surprised by this
> behavior, as grep invocations of the form
>
> 	grep "$(git rev-parse A B) C" file
>
> were introduced in a85b377d041 (push: the beginning of "git push
> --signed", 2014-09-12), and later faithfully copy-edited in b9459019bbb
> (push: heed user.signingkey for signed pushes, 2014-10-22).
>
> Please note that the output of `git rev-parse A B` separates the object
> IDs via *newlines*, not via spaces, and those newlines are preserved
> because the interpolation is enclosed in double quotes.
>
> As a consequence, these tests try to validate that the file contains
> either A's object ID, or B's object ID followed by C, or both. Clearly,
> however, what the test wanted to see is that there is a line that
> contains all of them.
>
> This is clearly unintended, and the grep invocations in question really
> match too many lines.
>
> Fix the test by avoiding the newlines in the patterns.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

The invocation this fixes is not just misleading but simply wrong.
Nicely spotted.

Thanks, will queue.

>  t/t5534-push-signed.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 5bcb288f5c4..464ffdd147a 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -119,8 +119,11 @@ test_expect_success GPG 'signed push sends push certificate' '
>  		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
>  	) >expect &&
>  
> -	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
> -	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
> +	noop=$(git rev-parse noop) &&
> +	ff=$(git rev-parse ff) &&
> +	noff=$(git rev-parse noff) &&
> +	grep "$noop $ff refs/heads/ff" dst/push-cert &&
> +	grep "$noop $noff refs/heads/noff" dst/push-cert &&
>  	test_cmp expect dst/push-cert-status
>  '
>  
> @@ -200,8 +203,11 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
>  		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
>  	) >expect &&
>  
> -	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
> -	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
> +	noop=$(git rev-parse noop) &&
> +	ff=$(git rev-parse ff) &&
> +	noff=$(git rev-parse noff) &&
> +	grep "$noop $ff refs/heads/ff" dst/push-cert &&
> +	grep "$noop $noff refs/heads/noff" dst/push-cert &&
>  	test_cmp expect dst/push-cert-status
>  '
>  
>
> base-commit: 5116f791c12dda6b6c22fa85b600a8e30dfa168a
