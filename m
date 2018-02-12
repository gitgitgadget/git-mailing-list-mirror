Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8379F1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeBLUSU (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:18:20 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52268 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbeBLUSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:18:09 -0500
Received: by mail-wm0-f68.google.com with SMTP id g1so11854133wmg.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8AEdjOU+6lyk4b2bGm77YM2XAwaBzQ+hteU1C7V1g68=;
        b=kyYvWD06865kM+z6cnWDB7JwFYw4WugIP9u1W1RowDQRlkoUUHPgUiwbGMdXKH1Acb
         xyUH47ToMUC/zvd+5YtwTtIk/yWKZngbadzqii4xqyGtzWnyI+IOIamzlqnTrx1n0Vtd
         pR81PuAjjYd5oZJGvh06kFzwSz4yfLfea8jgrHr7lFh5vZkB52mCj9ludqisBu3SB7V1
         xIEQ0ddgufWS9yxENx2Eblxb9QKZmcMPBW9/Rml8ac/hlDDVgRHnZQUNNTnjEBaa3n0r
         4xyE6TaNIAb4YqJYH1eSXpikBi6OM79SAv+FL0uc/NMGT7mkIvcgtRWNNuXNhc82zkNk
         X0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8AEdjOU+6lyk4b2bGm77YM2XAwaBzQ+hteU1C7V1g68=;
        b=IdHm/FPstxqKww6J8gv7sPeRCmhdD29AHMFHlXZmxKy6bg4xN3pE7OvD8svmMZBYf5
         Jwx0jeavNnVNv65v+z4hO0pdrY43a0D1C17qQo/kHmn33TxN11qTr5nFFDvbQbeRj6VL
         bnQB8rymkBsYLBpidxYFBTVRdlWcEcbHaWm59K6iRDwh+J5ksWMwNk3A4kZxuKCEWHka
         ulTUgGk6sPRqK6v+qgVFjCR5EqROyC4VJJujt2xbhA3N21C9FqsSioOcnd5rrbHNK15y
         g6MoQNczsqzavKocgYtMAvCHv7+BPXHsEOzFO1cM6B61WHJzXBo5TpWQ6jBNYctvoj8O
         KWRw==
X-Gm-Message-State: APf1xPBINBBzXFWJSZkls18LSSRMHgePdj7wyN4VFT67ggxv15Fvlaum
        PRAvs+s0Sp0gg3WZGcZzT//EasTS
X-Google-Smtp-Source: AH8x224ao34Wi04OFD63IpX1ooY38jWVok/Ye4Vhdlyd2sTwKkYxLywRiwFUcmiGUjAPA3SDtsSz5g==
X-Received: by 10.28.129.70 with SMTP id c67mr4961355wmd.160.1518466688171;
        Mon, 12 Feb 2018 12:18:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b65sm17465551wrd.26.2018.02.12.12.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 12:18:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 12:18:06 -0800
In-Reply-To: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 12 Feb 2018 00:18:23 +0000")
Message-ID: <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Attempting to grep the output of test_i18ngrep will not work under a
> poison build, since the output is (almost) guaranteed not to have the
> string you are looking for. In this case, the output of test_i18ngrep
> is further filtered by a simple piplined grep to exclude an '... remote
> end hung up unexpectedly' warning message. Use a regular 'grep -E' to
> replace the call to test_i18ngrep in the filter pipeline.
> Also, remove a useless invocation of 'sort' as the final element of the
> pipeline.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  t/t5536-fetch-conflicts.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
> index 2e42cf331..38381df5e 100755
> --- a/t/t5536-fetch-conflicts.sh
> +++ b/t/t5536-fetch-conflicts.sh
> @@ -22,7 +22,7 @@ verify_stderr () {
>  	cat >expected &&
>  	# We're not interested in the error
>  	# "fatal: The remote end hung up unexpectedly":
> -	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
> +	grep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual &&
>  	test_i18ncmp expected actual

OK, but not quite OK.

Two grep invocations will not leave anything useful in 'actual'
under poison build, and is almost guaranteed that 'expected' would
not match, but that is perfectly OK because the final comparison is
done.

However, it is brittle to rely on the latter "grep -v" to exit with
status 0 for the &&-chain to work.  The original was most likely
masked by the "| sort" exiting with 0 status all the time ;-)

There needs an explanation why this commit thinks the invocation of
"sort" useless.  I do not particularly think "suppressing a
not-found non-zero exit from 'grep'" is a useful thing, but are we
committed to show the two warnings seen in the last test in this
file to always in the shown order (i.e. the same order as the
refspecs are given to us)?  If not, then "sort" does serve a
purpose.  Note that I do not think we want to be able to reorder the
warning messages in future versions of Git for that last case, so
making that explicit may be a good justification.

    The "sort" as the last step in the pipeline makes sure that we
    do not have to guarantee the order in which we give the two
    warning messages from the last test in this script, but
    processing the refspecs in the same order as they are given on
    the command line and warning against them as we discover
    problems is a property we would rather want to keep, so drop it
    to make sure that we would catch regression when we accidentally
    change the order in which these messages are given.

or something like that, perhaps.

