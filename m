Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB0F1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCWShN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:37:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50638 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeCWShM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:37:12 -0400
Received: by mail-wm0-f48.google.com with SMTP id i75so5266295wmf.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6JTCLfHCNmvJ3u1HJvCDjXQTyKAIbmfu8eJIahPqfcQ=;
        b=S3Zyef8+hIegt7Go1aNxiZgNYV1QHuR0VCOJxa+JaLYz8M7p8MsYdKC3AYVRzDI3Kx
         HMfJzcvCCGSyhZ6Q3MJHsl8U7/oD+cUSzh8F638F20wEQOM9oDy0yiNK82jjpmN+DIii
         eL21Q9OdrJysdD5D8AgVK3O/3+EOEoREeFuXRN9PZzvOpwhP4VDGqQfDNi0hiExwNTJS
         HaJOuwe0Jyx+b4fKzwBuqLpvBe09EXRHc+Avg+5oxgrlcLxt2JNKJs4b8kt2FCjiGDjL
         qdWGeBl0k1UAC50WEMl8SVTqkGC+4fls3VBWJoNag0MJ8DXD931wVKdrHy4/BfAjY4u2
         VMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6JTCLfHCNmvJ3u1HJvCDjXQTyKAIbmfu8eJIahPqfcQ=;
        b=Vi76CW8tepT+CkNGPB7JwlYb7JOilMl3Ng+VSkCgmC8hCN+9FvMgin8zZkPpaZnj85
         CgOJi8IMZ+8h9N24Lotg5PJnmHK1y2lHlKg4tC6AxhDOF8u2/rncdq5S3rIki8HhVPFn
         shL7zmJKLtoKX/kFiHtl/k3enl3CtUiO2zpxnDkcEAOODWDXsEn6KsG1bujuBHTEdAOG
         bN5LAvQiVa2amD8iKc6RWrR4F/VWmQvX8lGjJD6Ypt7QDO4r8tI4VwOplXmxbsS2jZ8q
         ccTtKH6o9yREZyeJZWfpM1WmXKdVBcbvcAOLwYlKAjOOjcyVOI3PIcqJf4RuBSlCesrp
         oEnw==
X-Gm-Message-State: AElRT7GqryPQcUYObC0YMw+sTbys/+7YMTxUHuqQLWaCfYzegwh1b5JY
        aDuW3fTl0ez2/rxvcCGcrdR4agpH
X-Google-Smtp-Source: AG47ELvZvE1xY1HBwGva9byXIEyZEBz0zWdJ7etVj/JDNQGRK0TLv22ERCz03QljDghx1Ns4bByUtw==
X-Received: by 10.28.138.6 with SMTP id m6mr10046618wmd.146.1521830231711;
        Fri, 23 Mar 2018 11:37:11 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id p14sm19338643wrc.30.2018.03.23.11.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:37:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Loganaden Velvindron <logan@hackers.mu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Allow use of TLS 1.3
References: <20180323182506.GA15493@voidlinux>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180323182506.GA15493@voidlinux>
Date:   Fri, 23 Mar 2018 19:37:08 +0100
Message-ID: <87in9my6y3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 23 2018, Loganaden Velvindron wrote:

> Done during IETF 101 hackathon

Hi. Thanks. Let's add a meaningful commit message to this though,
something like:

    Add a tlsv1.3 option to http.sslVersion in addition to the existing
    tlsv1.[012] options. libcurl has supported this since 7.52.0.

> --- a/http.c
> +++ b/http.c
> @@ -61,6 +61,9 @@ static struct {
>  	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
>  	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
>  	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
> +#if LIBCURL_VERSION_NUM >= 0x075200
> +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
> +#endif

I wonder if this wouldn't be better as:

    +#ifdef CURL_SSLVERSION_TLSv1_3
    +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
    +#endif

We've been bitten before by doing version checks on libcurl code, only
to find that some distros are actively backporting features, so checking
the specific macros is usually better.

>  #endif
>  };
>  #if LIBCURL_VERSION_NUM >= 0x070903
