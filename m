Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4101F404
	for <e@80x24.org>; Sun,  8 Apr 2018 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeDHW7U (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 18:59:20 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52020 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDHW7T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 18:59:19 -0400
Received: by mail-wm0-f50.google.com with SMTP id u189so14440935wmd.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hfXgj5exvo0sDI/5hh4i23QOEnOst+wV9ZPlWG/UBas=;
        b=ANVMpjwv14CcbABicLokKJZoRdAgZGkn2avIVTf15UCbiwMuga9PcEeru257qUefmQ
         ktzx+HHiSa1Pc7q2zi/lAJxtiuy9nPeCei6t4p5oVmKG3sZ75PmpVxUES8gyJm9Uym8U
         iunjqEkjyNMoEw/XQuJ7/82rYgCUJlCnDMZ2vqR06VRIlu6aVVu6Rojee3DP36JSZGuc
         aTHovqZ3j2aLMi575Rlr5dhrrkfWzwdaG5ks0Z2bxcKnHcsUq240lgzcZQKfecCYueqb
         Ek2Ll5GzcTeyGvpwnBfobdPxO2Hrbudh3Gw+T1JvUU1ZWwoW3ER7XIU6rAlO47YIKgfA
         P5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hfXgj5exvo0sDI/5hh4i23QOEnOst+wV9ZPlWG/UBas=;
        b=A7/1YQoVN6c1wh7s7Jqe6MQdU2OsZvQ6HeNxYMxYfDIE6tgErRfnipYkwBopJKjruj
         o4Nzm5msBTNUnFnjntAhOGgmVSnwMKDLIE32CRuYIj0ordhsn5ncSenAQigSjgWD0617
         KghTMqY2flcQj6f64xEHY3TpnOztFTc6iKsFvCcpWSMC9aaynC7n34ktXHzOeTPJtyac
         0LE0ChlqTjjtnaGcUlEcigAv290XH3o9v/xj0rT1K/nekcJW8/ctbAHO7KZAqX+H3ZQU
         CjSyn/MWkT8rpRYSVcW4nvDCeEef2M40EyxAY5UY8b6tFu8xNm0B+IfLMJ/t6KtfkAol
         i8Lg==
X-Gm-Message-State: AElRT7EZg81vNEjU3T3Leb6Uo/NUUYO/MCOlB8yW6UfUTDYxAlJVWAN4
        nIvjOgwb5FlVn85348l+gq0=
X-Google-Smtp-Source: AIpwx49mAim9PCIx4Kv49OQc5jWIyXfy5k9MtIrQEF9jjVFcGutKoIObIp06jUYeI1hGdmqOKi1ROw==
X-Received: by 10.28.9.81 with SMTP id 78mr16969843wmj.23.1523228357750;
        Sun, 08 Apr 2018 15:59:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i52sm21175927wra.82.2018.04.08.15.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 15:59:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
Cc:     git@vger.kernel.org,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: load completion file for external subcommand
References: <20180408182552.26289-1-mail@floga.de>
        <20180408182552.26289-3-mail@floga.de>
Date:   Mon, 09 Apr 2018 07:59:16 +0900
In-Reply-To: <20180408182552.26289-3-mail@floga.de> ("Florian =?utf-8?Q?Ga?=
 =?utf-8?Q?mb=C3=B6ck=22's?=
        message of "Sun, 8 Apr 2018 20:26:13 +0200")
Message-ID: <xmqq37059uez.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Gamböck <mail@floga.de> writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index b09c8a236..e6114822c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3096,12 +3096,20 @@ __git_main ()
>  	fi
>  

Sorry if I am asking something obvious, as I am not fluent in
bash-isms, but

>  	local completion_func="_git_${command//-/_}"
> +	if ! declare -f $completion_func >/dev/null 2>/dev/null; then
> +		declare -f __load_completion >/dev/null 2>/dev/null &&
> +			__load_completion "git-$command"

wouldn't the above be easier to read if it were

	if ! declare ... $completion_func ... && declare -f __load_completion
	then
		__load_completion "git-$command"
	fi

or is there a reason why it is better to &&-chain the check for
__load_completion with its use?  Same comment applies to the other
hunk.
