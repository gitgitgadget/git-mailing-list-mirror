Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008AA1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 18:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeCGSvw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 13:51:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50739 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754541AbeCGSvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 13:51:51 -0500
Received: by mail-wm0-f67.google.com with SMTP id w128so6818692wmw.0
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vv1BQIVsVtxxfBLc37HwR6MZXClLgrlYXZDwXfFRVFg=;
        b=CCrplht3FIusAsNWdX8dXVi/t5gTT+fG/Zd0gYpQ3lfG/X2amkoRABXhsjxOQfYhtg
         LROW6s6zKE5osbsSvlWCCL6GdA9yZ1CVEx/8v3Ux8YMsMymgEdKeOB71PjvxckxxqLkt
         nEOPa4jIfHpFtqW3/FHrCQ4LQm5asX5NXgfcU6QDLmZ3Jzpw6jalh95xODTYVhDfF0wT
         VCy0wYCFKQEKP5iERDbPkkYb1ozNo/3wV9BhfC6JPVW/UCl51GNKnGMWgyupMnGYSGhZ
         yafVztK2o7wpKpcEKnYFX+Rh4FTmaqcVFNzeBa5KUQa2i66/Bm8XsQ3QzTRXTH2niIAG
         Ey6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vv1BQIVsVtxxfBLc37HwR6MZXClLgrlYXZDwXfFRVFg=;
        b=B/kB08nZoQEiJQ+JFF8XNbrTF4C10fcfT0Lc16Wc/ETomAsmZKHzbvR+9S1tHT7Khw
         7kZHQO6e2RX5VqmxZKFfeMgs2eo9m6U3cw+P265nigo5rvoRCWFMQ9RVM/2vvFQ1Qhbq
         09JqrIP0br56hQLFScnHJk3xH9gvmKkJa/+ZH6iNUXsrem+PKdZCUQhl2siOfJa21xAU
         uVrMWlx2F/n7puAK4jtsHp70hc0q15ZP9POtL0nrhYjYCbjuhGKZ1OTTbihEnHD+Jqdw
         Ggeo7sp/MT8qefm1mU09I0g6pPqV5jwPnAzsnFsR7sM0bNMj8UBqfTp/vvTcRI5K4o37
         SxTg==
X-Gm-Message-State: AElRT7GcjyhisQ/mTXYwr+lqfr4Wglkj26Q0RRFBNsxAAp+4LrgI7rEI
        RKOJ73VCQrfwh83jsab5hnY=
X-Google-Smtp-Source: AG47ELtQu/49SXTkqosOaNsoZt11S2HrseE1QD3C8beTqEfTU75STCaKjwXaNYy5Cig1A0ZyxSlPKQ==
X-Received: by 10.28.194.84 with SMTP id s81mr16462684wmf.31.1520448709774;
        Wed, 07 Mar 2018 10:51:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f206sm4632982wmf.26.2018.03.07.10.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 10:51:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] completion: simplify _git_notes
References: <20180303092307.3796-1-pclouds@gmail.com>
        <20180303092307.3796-3-pclouds@gmail.com>
        <CAM0VKjmmF2t=B2s3rJoKmO3j6Bk5d6PEfCV==ONRGMcdUMLFpQ@mail.gmail.com>
        <xmqqd10g3jxb.fsf@gitster-ct.c.googlers.com>
        <20180307010843.3503-1-szeder.dev@gmail.com>
Date:   Wed, 07 Mar 2018 10:51:48 -0800
In-Reply-To: <20180307010843.3503-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 7 Mar 2018 02:08:43 +0100")
Message-ID: <xmqq4llr1zy3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> That works fine, but this would work just as well and has one less
> case arm:

OK, I missed that "obvious optimization" opportunity.  I agree that
would work.

>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ab80f4e6e8..038af63c1a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1839,6 +1839,8 @@ _git_notes ()
>  	*,--*)
>  		__gitcomp_builtin notes_$subcommand
>  		;;
> +	prune,*)
> +		;;
>  	*)
>  		case "$prev" in
>  		-m|-F)
