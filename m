Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B9B1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 18:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeCFSB4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 13:01:56 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35734 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753654AbeCFSBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 13:01:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id x7so23877956wmc.0
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6mE/wBCOr/wY2yHVDFXULC2yVMcrjgpRt2w8jSSYj9Q=;
        b=OApNATRljWtGKkKDW6zDaDVTZ9SljeP6/ydjhDbVExCQf3lY112xFD2NAMiMb8qjGF
         3LGTLvhwobdWoY1G8Bq6BpBNifo05ZfTW2BsYueQyH8gSZq2AFVvvGVl3tWFp7Z2PZuS
         tAITbi69JVJXiptSHD5A/abqS14g2VTu9JXmkxSGKPQoHdZA6voyJhqezbPMbD2pKwAU
         qlXR7nVZYDPaWyyzGNqGUalH9SvwZH/JkgQVqbk+A5qaGbAOq3idddC7hamstoMTW7Kr
         LYcWAjPVL4zdMvZfUrzM1yHtyLzGx+XowLKS294HyKuMqlr9+b5XwaWyiX/HTrpHT0Nn
         rI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6mE/wBCOr/wY2yHVDFXULC2yVMcrjgpRt2w8jSSYj9Q=;
        b=cnknOCEGZL7Miu54aX/fi/pG1PGaGkd5r2mutQqdcWUfGTuuqXi7gd9YbYA31d2SG6
         XJhNcCKNrVT1iqBKCVrHHotBVu5izXG7mq1YqaZ1ffHac5VT3x/QmsgiKPiFVQRR8PhY
         AFWj4ym5LawZOM2umO8jM36BNscehCNhS/zF/+PcX/tU+nUAbSU22NU9BxQY32N0HGFT
         1xU1NR+oCjaQvpWR1e9roFksfZ3rdb1/0LYR3DnPpBsRCQfCZHvlTDphsJS9UNLugk5M
         tbYdFzJ+6D8khoJvSnDjk/M0vjKKdjFqR2afwwkSYnGXoTSBS/cF73HXzLwl8eyiluzC
         YWOA==
X-Gm-Message-State: AElRT7H0Lvx0RMR9tW8Go3sp0AMDcT+0/jO5ATkEohQKMsUGGpbWVsWl
        iE43BTFIHL0OvU2HYWJmZDRciUPU
X-Google-Smtp-Source: AG47ELu8UubJaGf9soNAKo87/c8lQCI/PXGGIjjcESPPmzCSfEcBolGFxOV9hLmYqe372N0A79VQFA==
X-Received: by 10.28.130.1 with SMTP id e1mr11530444wmd.45.1520359312738;
        Tue, 06 Mar 2018 10:01:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g96sm14638561wrd.73.2018.03.06.10.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 10:01:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 1/5] fixup! Add a test showing that 'git repack' throws away grafted-away parents
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
        <20180306104158.6541-2-pclouds@gmail.com>
Date:   Tue, 06 Mar 2018 10:01:51 -0800
In-Reply-To: <20180306104158.6541-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 6 Mar 2018 17:41:54 +0700")
Message-ID: <xmqqo9k15bhs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The closing quote of a test body by convention is always at the start
> of line.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Obviously correct.  While the title may technically be correct, the
original commit is age old that we won't be amending it anyway, and
it is not very helpful not to say which aspect of the original is
being fixed up.  Perhaps something like:

    t7700: have closing quote of a test at the beginning of line

    1ec64827 ("Add a test showing that 'git repack' throws away
    grafted-away parents", 2009-07-23) added this test but indented
    the closing quote by mistake.

if we really cared documenting where the blame lies, but I do not
think it is quite worth it; anybody who cares deeply can ask "git
blame" about it, so I'll just retitle and use your original log
message body.

Thanks.

>  t/t7700-repack.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 6061a04147..38247afbec 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -194,7 +194,7 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
>  	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
>  	git repack -a -d &&
>  	git cat-file -t $H1
> -	'
> +'
>  
>  test_done
