Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467061F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeHBW5o (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:57:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45750 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBW5o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:57:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id j143-v6so2534128lfj.12
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pxe2oZFOV3qE+mvkmN66H5Uo4oB0rpqsYq17u8mEZsY=;
        b=ADmYaL55u2Yn/ILxv7CG4E0rVawBxzGAZLGAitFMIB0DqE5GTf8H5ZPwK1/p//q4JE
         7FK3xv6SiCW9Tc26RGFN9KVqV1HWcIfx+oNXTCUtFmGTtZhsLEaW2saY8acHEZ+n1RXO
         5b5+moOkh1lIeVjdSRge46NkBYv2IbwcASdO8D9LbWaUdSGyExJ8tCIyajwyoybadtd4
         7Kb/KXgXiIijolmqLBBdo+NzvrcOWx/KwuCtaJReMh/ElZiY5E7a32g/IZ79lFWABhJ/
         5wS8n6KP/uUN2pzS0IPwPIMwxiaC00KIfupEGB3AuflAqMwP2is51vyMlmRcMV8cBaj0
         yGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pxe2oZFOV3qE+mvkmN66H5Uo4oB0rpqsYq17u8mEZsY=;
        b=Ws5ARTPnBUT0YZdrp3E+bNnq/0ilHX2vYFMo/QQXFTCHJR7WVdO0L0c5ijI0HGLjye
         PL8i1Jvtrvyxa7LiDREUZyJpgjTA0hDEA+CCooOwe/FBjMjAtSAcDFYMW15cIOG+4tUQ
         gN9YIAKlJl0Z0VtKrlC7tk6Ww+kXlUQRvCaBF91GONzB75l3RqDmGC51tXrJb9gYAx2i
         BQZ/9DT/DTiFXyjsU3m7w8mVu+DuRJWFbugbk/yC2vu/brZBHooz/aKm2N41K0nNO7AV
         IMSq3zlpCMiPWZr+OnhJndpE5xbbNUtUiENwmuHeAuRuz9zemJ17v9KozrlXLZzrTYuA
         eTWw==
X-Gm-Message-State: AOUpUlFGF9o2y8C+D7GK/THASiUnsKiejS3pn9LgTI9pUu3tt1c86xy2
        GqakLIPREm0cA+Tq94oB/SqMJKKtOPo=
X-Google-Smtp-Source: AAOMgpcv+35a9frOSaQKELSm7ZvMFvlpl68FMyrp4Rqc7rDmYw7Tc2hzfqU1bt6/U+JW+nmuih+1cg==
X-Received: by 2002:a19:aac8:: with SMTP id t191-v6mr2979924lfe.68.1533243890682;
        Thu, 02 Aug 2018 14:04:50 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id f3-v6sm463947lfc.30.2018.08.02.14.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 14:04:49 -0700 (PDT)
Subject: Re: [PATCH 1/6] add, update-index: fix --chmod argument help
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
 <20180802165457.GC15984@sigill.intra.peff.net>
 <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
 <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <4a570679-3024-1541-95da-0fa8baef75ba@gmail.com>
Date:   Thu, 2 Aug 2018 23:04:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-02 21:17, René Scharfe wrote:
> Don't translate the argument specification for --chmod; "+x" and "-x"
> are the literal strings that the commands accept.
> > [...]
> 
> -	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
> +	{ OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",
> +	  N_("override the executable bit of the listed files"),
> +	  PARSE_OPT_LITERAL_ARGHELP },

Would it make sense to drop the localizations in po/* as well?
Or should such things be handled with l10n rounds?

Can be found using:

    grep '(+/-)x' po/*
