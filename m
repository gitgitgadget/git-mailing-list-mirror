Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270061F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbfJ1Ow0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 10:52:26 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36794 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbfJ1Ow0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 10:52:26 -0400
Received: by mail-wr1-f49.google.com with SMTP id w18so10234295wrt.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2UPFmjk5YjoUMGxbElEvw8jaSITtpd1t9aodqxvMPIE=;
        b=nMXDObLJi7BP8FeH709V6TTnsR+hhvKgRnljuYwCy1uG0gRVgGQAqFZXZGhrFNoBoF
         57Zjl6M4DmD2IV/7077Tbb4p2jY97KiPCkQIPT5awOk6jMPeUNNGeEkOj14dLq6O1/0j
         9XxxC7JqT748wo+7S26DdU0BOxd2SwlTxFq0J2EdTIkMe2LJQa2utnzx1WEXqfHFiTMT
         4za8cXWN1UBhkVUJfG6qUd/zoeUxIha86D+PGmIhE8+omhHajZnyvhPufdzF/Y0e2YEe
         7V4z+yw2+yj0AHDWO1zfi6smGylGDpG+8ZNmtTn65JdydtCB/CIF1vBOl41BJrmCOx0x
         tRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2UPFmjk5YjoUMGxbElEvw8jaSITtpd1t9aodqxvMPIE=;
        b=rOZxOisLvajhWbMgMYWbjgBbKQCxzCLgS3PlfYmq9jynnVotetluu/e5s9Y71IF6v3
         HkRcdCawt61FNN4/nRlpwTOQMiuZZcPkVqnqZxxzIw42buSUwqKtJBFWlBQK1LRnA/lK
         jDBqI8GkvpSaO/U/f2EDvEi50LhdDkA1FK58kcmcFSPmJWlNrLjrULF0ajjX5f4CGgPG
         h8GRBAR760fQsDwW5Va7U6fg5Lddw1FPs28UwvQ9gbCLxmt2834ZjeqImgO0bO0bdb9p
         h6HEg1NmroiaDb6N/eeUybsgRWb4wEt7o55g53OWjZ6g8PnkQmY9eU3yVhXM+SGqZUHe
         fNHw==
X-Gm-Message-State: APjAAAXdekylrEh/rMTEVoPDsVlVFroQoG19TXzlF1iwf3CCIEBiYOBi
        +DUYn64IPTUZa3mGKfnr+Kg=
X-Google-Smtp-Source: APXvYqytvqKYILbWCoXQdjdYcsmM1Je1Cm7ECAaZkGOuqIkVOCJr0XeXtOwe9RmTP12Vm17BH3IVDg==
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr15124370wrw.152.1572274342893;
        Mon, 28 Oct 2019 07:52:22 -0700 (PDT)
Received: from szeder.dev (x4db30d31.dyn.telefonica.de. [77.179.13.49])
        by smtp.gmail.com with ESMTPSA id h17sm10934437wmb.33.2019.10.28.07.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 07:52:22 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:52:20 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [BUG] git 2.24.0-rc1 t0500 on NonStop in Jenkins
Message-ID: <20191028145220.GU4348@szeder.dev>
References: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com>
 <nycvar.QRO.7.76.6.1910281405000.46@tvgsbejvaqbjf.bet>
 <026401d58d9a$2bbe7600$833b6200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <026401d58d9a$2bbe7600$833b6200$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 10:15:31AM -0400, Randall S. Becker wrote:
> Here is the verbose output from subtest 2 that failed. Sorry it took so
> long, we had to arrange a different Jenkins job to test this in isolation.
> Format issue?
> 
> Cheers,
> Randall
> 
> expecting success of 0500.2 'progress display with total': 
> 	cat >expect <<-\EOF &&
> 	Working hard:  33% (1/3)<CR>
> 	Working hard:  66% (2/3)<CR>
> 	Working hard: 100% (3/3)<CR>
> 	Working hard: 100% (3/3), done.
> 	EOF
> 
> 	cat >in <<-\EOF &&
> 	progress 1
> 	progress 2
> 	progress 3
> 	EOF
> 	test-tool progress --total=3 "Working hard" <in 2>stderr &&
> 
> 	show_cr <stderr >out &&
> 	test_i18ncmp expect out
> 
> + cat
> + 1> expect 0< /tmp/sh1811939370.4

Wow :)

> + cat
> + 1> in 0< /tmp/sh1811939370.5
> + test-tool progress --total=3 Working hard
> + 0< in 2> stderr
> + show_cr
> + 0< stderr 1> out

Another wow.

This is unrelated to the test failure, but makes me rather curious:
you run the test script with '-x', that's why we see the trace of
commands executed during the test.  Interestingly, though, we don't
see any trace of commands executed within any shell function invoked
in the test, i.e. from show_cr above and test_i18ncmp below.

What kind of shell is this?

> + test_i18ncmp expect out
> --- expect	2019-10-28 14:11:40 +0000
> +++ out	2019-10-28 14:11:41 +0000
> @@ -1,4 +1,2 @@
> -Working hard:  33% (1/3)<CR>
> -Working hard:  66% (2/3)<CR>
> -Working hard: 100% (3/3)<CR>
> -Working hard: 100% (3/3), done.
> +Working hard:   0% (1/12884901888)<CR>
> +Working hard:   0% (3/12884901888), done.

Weird, this looks exactly like the big-endian test failure that was
fixed in 2b6f6ea1bd (test-progress: fix test failures on big-endian
systems, 2019-10-20), but that is already in 2.24.0-rc1 (but not yet
in -rc0).

https://public-inbox.org/git/f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de/

Is NonStop big or little-endian?  Does t0500 pass without 2b6f6ea1bd?

> error: last command exited with $?=1
> not ok 2 - progress display with total
> #	
> #		cat >expect <<-\EOF &&
> #		Working hard:  33% (1/3)<CR>
> #		Working hard:  66% (2/3)<CR>
> #		Working hard: 100% (3/3)<CR>
> #		Working hard: 100% (3/3), done.
> #		EOF
> #	
> #		cat >in <<-\EOF &&
> #		progress 1
> #		progress 2
> #		progress 3
> #		EOF
> #		test-tool progress --total=3 "Working hard" <in 2>stderr &&
> #	
> #		show_cr <stderr >out &&
> #		test_i18ncmp expect out
> #	
> 
