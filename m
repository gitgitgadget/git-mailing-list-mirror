Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A01C201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbdELWcH (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:32:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33323 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbdELWcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:32:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id a23so8397883pfe.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bVVgy8YwTiffGBXmnkus156y25XJj8O5H2lrRNdgPa8=;
        b=Vb4D7wLucxSYq6QtrVGLyw4xzd8khqXOiE2W0dW+djKplQvpJtEIRPrytd+dHB6dZl
         dxwr7V8s9wstjKhw1hRMKoVDx+l+zhldNyVPV/DLuiqYN2kMar1USmmHi8R9FCRlic65
         Uw0tNS0Ippjx+nes+fAfxZpRrv4O4NaiuoTAXPA9r/+Fky1Bev7wdzONgMmgWxGBwMZm
         Hb7HLSXXF0TcAn7onyOHOyiGT78Gr2FOkkFC2qZw2T4QHgPHvE8uu9/hyuv7uQuRppvj
         Vjta2cOrbd2m/noEYzcEOUyefJ2p5+60jA61mDxfmEgQEv4fS8z+Q0khECpM08G07eww
         L07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bVVgy8YwTiffGBXmnkus156y25XJj8O5H2lrRNdgPa8=;
        b=j9Leim8ZjH1CUHrWvu/WKdDwnk0Rfpceyq/UnXp5tjl7pQKl9ROxaQpzW8nZyyLACj
         YJMWypot6tuEL1fL5k9io/8qGL3JKm9FDrrMs1FV63rTGEpJdgZt4COXW2w+vn/pWzVz
         lGdKqU+q5yYM5/JYFiQ1jFVWneBXUtnaiU44e5nN5iSaR+iFUjWsBe1BOZMUBCrLBfEv
         mh9yvexk/YN2CbwtNDQdjFoKDLWmS/kRVxdsvfT5va15wgyDAJCuL+mrE6EjGqbzNCKf
         uOlnigwbSkxKVYzg4VfNgl1cHAa5oWxIdELf5W7csqpV8+d10nOjU4aHR810kDjeilBR
         +4Vg==
X-Gm-Message-State: AODbwcD0rYhkEzXFNbJuVcj6ZV11WIO6bEIvECukJsjlPPujOIMi9QhR
        R3JHUrsS9fmSizJ2Few=
X-Received: by 10.98.192.143 with SMTP id g15mr6781737pfk.219.1494628326067;
        Fri, 12 May 2017 15:32:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id v6sm6741574pgb.20.2017.05.12.15.32.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 15:32:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style options & config
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
Date:   Sat, 13 May 2017 07:32:04 +0900
In-Reply-To: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 12 May 2017 12:50:55 +0200
        (CEST)")
Message-ID: <xmqqtw4p4sgr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, `(1|2)` is not a valid file name, and therefore the tag
> cannot be created as expected by the new test.
>
> So simply skip this test on Windows.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Will queue as an emergency fix on 'pu' for now, but I'd expect
(read: ask) Ævar to squash this in when the series is rerolled.

Thanks.

> Published-As: https://github.com/dscho/git/releases/tag/exhaustive-grep-tests-fixup-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git exhaustive-grep-tests-fixup-v1
>
>  t/t4202-log.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 36321f19061..6f108e99b7b 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -296,7 +296,7 @@ test_expect_success 'log with grep.patternType configuration and command line' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'log with various grep.patternType configurations & command-lines' '
> +test_expect_success !MINGW 'log with various grep.patternType configurations & command-lines' '
>  	git init pattern-type &&
>  	(
>  		cd pattern-type &&
>
> base-commit: 3760a479060228867a31eed443334b30124465b9
