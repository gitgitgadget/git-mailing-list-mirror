Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84411F404
	for <e@80x24.org>; Tue, 13 Feb 2018 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965398AbeBMRIw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 12:08:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54444 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965425AbeBMRIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 12:08:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id i186so17359493wmi.4
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 09:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=M8yzVF6GpHzy4mA9boc+iSRFniJzaGy+Xp4FH/KTt00=;
        b=qEUHXcYta3yJ+s1g3PSC5S/7C6dkvzZqNA3jxe6cP9bK5D2QpUudkMPTGzlJ/TK0C4
         C6MM8o1TAosB1dyUmRIW3nneo9qqUniq/lE2qh7L6zVhiT7+0wEgEW8Asn6d3QISqklC
         s9wGGoHtenopCZjMz/brRpW33I/RjYCTFuz94NsaOkF5Wqr7utpDFgvMhnmstPY6IyOB
         oyFnyW7wCQEoi8+EDAMTW4FrJItfmtkxXJpIo+ksAWqbvQijCWE4UTKm1dHwQc+bWYNa
         Z81Knv4QpZ1ef+2NKYTAQJ32cnjz5O2N8jLNWXTGtexDEGm3soOJyxxs04I7O75VsXnB
         gtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=M8yzVF6GpHzy4mA9boc+iSRFniJzaGy+Xp4FH/KTt00=;
        b=kajZy6Z5RFmr3XDRo7HT4HRdRYuV/rAE7FQ/WkECpBaGse163LogWhoRqBAMCcIdmt
         0/w44ufJnypqgV7m9+78OpsDsFGOLGhk/bGzBlpjJ69Wf8R+x+XsY0QzkXW7CoHJrvOA
         Ulykb+H0pO2ieolE7QUi3G5Rj9oyLEl1YV1iO9Ydagc0Sgf/b1W64sLaRtySY5jYbZ+i
         TrVQlq47Pz8Q05bNLGZUnsslM9WiRddDC6+QHwC3jgtjOdYB/UUtuqDdaA8ClgkAEAEa
         EYTxR4JUXJFIptYgV0IQGyWFuvIMnte5RJKfjHDc+EaFvG98hvHy4ezFsH4V2vyk7Vjd
         mThQ==
X-Gm-Message-State: APf1xPDcLy5tzU06njoONSkx3GyVj4PCpHTyTMRk8oXXIh0uCMAWRd8J
        1BkJRtHg2dFYpDKliyabTnNw36Z+
X-Google-Smtp-Source: AH8x225t769QBlMG1aVe/LDWxKzkLs3vVgc66IVtABzs9eHPAmxKxhXyYlG+hdWpZBST0WPV8Efhcg==
X-Received: by 10.28.144.20 with SMTP id s20mr1984222wmd.149.1518541726323;
        Tue, 13 Feb 2018 09:08:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q12sm12430237wrg.37.2018.02.13.09.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 09:08:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
        <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
        <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
        <20180213100437.15685-1-szeder.dev@gmail.com>
Date:   Tue, 13 Feb 2018 09:08:44 -0800
In-Reply-To: <20180213100437.15685-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 13 Feb 2018 11:04:37 +0100")
Message-ID: <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> A third possible fix, which is also in the "we don't care about the
> order of multiple warning messages" camp and has a nice looking
> diffstat, would be something like this:

Hmph, we are running a "git fetch" locally and observing the error
output from both "fetch" and its counterpart "upload-pack", aren't
we?  The "fetch" instances that are run with test_must_fail are
expected to stop talking to "upload-pack" by detecting an error and
severe the connection abruptly---depending on the relative timing
between the processes, the other side may try to read and diagnose
"the remote end hung up unexpectedly", no?  

I think "grep -v" filtering is an attempt to protect the test from
getting confused by that output, but is it safe not to worry about
it these days?

> diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
> index 2e42cf3316..91f28c2f78 100755
> --- a/t/t5536-fetch-conflicts.sh
> +++ b/t/t5536-fetch-conflicts.sh
> @@ -18,14 +18,6 @@ setup_repository () {
>  	)
>  }
>  
> -verify_stderr () {
> -	cat >expected &&
> -	# We're not interested in the error
> -	# "fatal: The remote end hung up unexpectedly":
> -	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
> -	test_i18ncmp expected actual
> -}
> -
>  test_expect_success 'setup' '
>  	git commit --allow-empty -m "Initial" &&
>  	git branch branch1 &&
> @@ -48,9 +40,7 @@ test_expect_success 'fetch conflict: config vs. config' '
>  		"+refs/heads/branch2:refs/remotes/origin/branch1" && (
>  		cd ccc &&
>  		test_must_fail git fetch origin 2>error &&
> -		verify_stderr <<-\EOF
> -		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
> -		EOF
> +		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1" error
>  	)
>  '
