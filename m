Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF6D1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeKMBoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:44:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37793 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:44:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so14048067qkd.4
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/5Tegkl+/DqeJwaUj+QnjvBHNte1U3iyzfMLdLGJv5s=;
        b=bKz2+tB9gVi8f1P21/xEaPITKqxp0R7rEjbgzmYyu6na4wyOvuWOMKsdopPxFBCO5T
         seUfqhFgLfs2mraeNzHdFp6YtHnkdk7ymSSQd3DoJoZ4XgNql53IMSBSbm5BvAXsO4bo
         eWUyWnnx1OMUuLErEMxJ2u3ECVJkHyKzKFuhEP72nNYKt3RcZ0ZGzEo8BWvhR8n/ohac
         OZ5e6E9lwa9aWB+5h4ie0Hfw5V/fQMGDQRAN4sPpGG/jM2y1fcmm0PH5PE/MQ8THrpmU
         wBps/K+leGusi9hDEZKM4RJqOrILk4X2UQv71WQeREpTjc2EmuNIMAlAjC6d2ZXX86RZ
         eOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/5Tegkl+/DqeJwaUj+QnjvBHNte1U3iyzfMLdLGJv5s=;
        b=B6N29TqfFARatg/g/YyKwFfi+h2YfUTAi3FEeaXVsOuQYchJmxtTS7MDc5ICGE2szc
         HP9LBQqX5YK8vq1rqvPVBtc/+y7kA4D/Bw2yEAUMQjFEu/3zwN8ylb+z2kwSAquJ5syj
         c3B+JovsBHYqPuekK6W+YyzuGJ59qWZOsTyBULg7KbXqoFnaRk/vlsGedUO+17ISy5Vt
         T0f5FcUw06AeXPUIlW6i+r4CoiZISSNBeWPdnUPczOT0v0r6ajJz3kSV42lYP3lgEd3Y
         I70SO02SOFdZDaymPNzndPiaXuct8NJ+XYLLmsKRP2hCoouRt/Y6Nt6dn9tZHUI0QVVb
         KuEA==
X-Gm-Message-State: AGRZ1gKPPpENlS5R9pMVhmChqvb7QK612z+6OEbCbJwsitpp5jZBIrm2
        YDf7E/RAYuYjjSVw2z6SVsg=
X-Google-Smtp-Source: AJdET5cnwvA3yLtEFhO4Nu4bBlMnwB8IK2ooQZujjx2QJRr/BGc0fdFogb2IYyxMEmHmM6U3njHZkA==
X-Received: by 2002:a05:6214:18e:: with SMTP id q14mr1450253qvr.173.1542037818992;
        Mon, 12 Nov 2018 07:50:18 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:705f:75d7:178c:fe1c? ([2001:4898:8010:0:5995:75d7:178c:fe1c])
        by smtp.gmail.com with ESMTPSA id f13sm8307107qkm.52.2018.11.12.07.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:50:18 -0800 (PST)
Subject: Re: [PATCH 5/9] handle alternates paths the same as the main object
 dir
To:     Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112144935.GE7400@sigill.intra.peff.net>
 <56c50f51-5d9c-1166-75b9-418e384fc672@gmail.com>
 <20181112154617.GA6577@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2cf42b0c-663b-3409-da77-ccfdf0656a88@gmail.com>
Date:   Mon, 12 Nov 2018 10:50:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181112154617.GA6577@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/12/2018 10:46 AM, Jeff King wrote:
> On Mon, Nov 12, 2018 at 10:38:28AM -0500, Derrick Stolee wrote:
>
>>> We could go either direction here, but this patch moves the alternates
>>> struct over to the main directory style (rather than vice-versa).
>>> Technically the alternates style is more efficient, as it avoids
>>> rewriting the object directory name on each call. But this is unlikely
>>> to matter in practice, as we avoid reallocations either way (and nobody
>>> has ever noticed or complained that the main object directory is copying
>>> a few extra bytes before making a much more expensive system call).
>> Hm. I've complained in the past [1] about a simple method like strbuf_addf()
>> over loose objects, but that was during abbreviation checks so we were
>> adding the string for every loose object but not actually reading the
>> objects.
>>
>> [1]
>> https://public-inbox.org/git/20171201174956.143245-1-dstolee@microsoft.com/
> I suspect that had more to do with the cost of snprintf() than the extra
> bytes being copied. And here we'd still be using addstr and addch
> exclusively. I'm open to numeric arguments to the contrary, though. :)

I agree. I don't think it is worth investigating now, as the performance 
difference should be moot. I am making a mental note to take a look here 
if I notice a performance regression later. ;)

> There's actually a lot of low-hanging fruit there for pre-sizing, too.
> E.g., fill_sha1_path() calls strbuf_addch() in a loop, but it could
> quite easily grow the 41 bytes it needs ahead of time. I wouldn't want
> to change that without finding a measurable improvement, though. It
> might not be a big deal due to fec501dae8 (strbuf_addch: avoid calling
> strbuf_grow, 2015-04-16).
>
> -Peff

