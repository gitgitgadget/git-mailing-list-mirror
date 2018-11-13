Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA481F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbeKNCBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 21:01:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53177 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbeKNCBj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 21:01:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so12451901wmb.2
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 08:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0T8Y0pUJzWQkDIAdKb/dSrzNBq2Z3QefDWQprs17T1k=;
        b=miv6cWi+Rr5bQ77m+/IG+m3coy5AUq/IHzbHlLzXqLfCFAhOogujZZMdKxAM1sDRDr
         E11uLGGw33lJe1JnIN1Di+x/x6Cp8W8abgWCidVLLCfGV9zClpEdbM2PElgjDdd+cdV7
         soQOFCZoBmSB8Fi+e3Fq+5xpu3NPrUqLQG1qqeJCCuO2zSTZ+PNfxdNPuB5GnoKo5mji
         H8Wgv+syiQNxSW5Yzcl6qP0Vv1itFg76sY/XFsvn6i4UC703qsdPWpkFF2salcbiHG7f
         DN0GaqS3D3SPZlqjuRKPvsJTimIYJVowMKL4Mt2SY9723wzrRJttSMcnAQ/yhwCpXp9t
         MwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0T8Y0pUJzWQkDIAdKb/dSrzNBq2Z3QefDWQprs17T1k=;
        b=ukPBaM85LBzr8zslc2jLlHnMkYtYOQ3NN9+i+0bR7mTvUBdblqbQWSU8Qtf5rGL1Sw
         mNnip/QaiNiM47LihLXf6t1FuXWgf1rmqYauWMCgcQ8zbqBjtPXIcJ6TvCHbLJPbDN1Q
         K7YDy+1p0uhF3lnhhHyLK5usg/z/2nnh034I0chbH/y6SOhaFgi1OzcS8EyIa/FJkQZj
         o/9c5eaJp2o5MSt7suBxMr/+RrrnryRy8DV4+XUKWKGGbZcwepizgfIkdVQQGuSveut/
         3FSPu3v8/PwqrtIAtmQlIoZlnfMBHajfFXmQ6JLKF38TB4OsznDB8sxnnRITKraKzTFf
         Cd1Q==
X-Gm-Message-State: AGRZ1gLsuxaxhWmj1fgY1dbTVHb2GyI+sAXWykASi7oxTeFi58ieav8k
        DofjjzQdIA6Q7EXP0R1QJEvBvI57
X-Google-Smtp-Source: AJdET5cqjDInO+QD67yriPtbJfPBTsW9HGo6DraEODb/mOkKtrhzxDecUQvTUu8cJBUAgL7957KQgA==
X-Received: by 2002:a1c:c543:: with SMTP id v64mr3736004wmf.123.1542124975130;
        Tue, 13 Nov 2018 08:02:55 -0800 (PST)
Received: from szeder.dev (x4db2a36c.dyn.telefonica.de. [77.178.163.108])
        by smtp.gmail.com with ESMTPSA id m3-v6sm5126853wrr.72.2018.11.13.08.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:02:54 -0800 (PST)
Date:   Tue, 13 Nov 2018 17:02:52 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        martin.agren@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] coccicheck: introduce 'pending' semantic patches
Message-ID: <20181113160252.GF30222@szeder.dev>
References: <20181108205255.193402-1-sbeller@google.com>
 <20181110001052.101290-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181110001052.101290-1-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 04:10:52PM -0800, Stefan Beller wrote:
> From: SZEDER Gábor <szeder.dev@gmail.com>
> 
> Teach `make coccicheck` to avoid patches named "*.pending.cocci" and
> handle them separately in a new `make coccicheck-pending` instead.
> This means that we can separate "critical" patches from "FYI" patches.
> The former target can continue causing Travis to fail its static
> analysis job, while the latter can let us keep an eye on ongoing
> (pending) transitions without them causing too much fallout.
> 
> Document the intended use-cases around these two targets.
> As the process around the pending patches is not yet fully explored,
> leave that out.
> 
> Based-on-work-by: SZEDER Gábor <szeder.dev@gmail.com>

Hm, do I need to sign off?
Well, I sign off now anyway, and then Junio can take it if necessary
or just ignore it if not.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
> I dialed back on the workflow, as we may want to explore it first
> before writing it down.

Yeah, I too think that's better to wait with the workflow details
until we gather some experience about how it works out in practice.

Thanks for following it through.

