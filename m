Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143BB1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 11:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA2LQD (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 06:16:03 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46203 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfA2LQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 06:16:02 -0500
Received: by mail-wr1-f44.google.com with SMTP id l9so21519899wrt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 03:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNmgzu58dLYuPDf1GfsqrS14lJU0aUbExsKv0XTAHy8=;
        b=i3PWHHr9pU0f883cP5Tx2ZAgbxaOjBgpP8JYX6YZxazuDVZJouDQwOwT16n6PTfjTX
         eM0gyW+CC2wqccLM2CHm+FAsfumRKX/F/i2qSvxm1OpCooIS/XUrbX4CZm48wLhz3SND
         Fpntdul3Lz+APrv03c4i+q4OdPjxw7iJ/dc3CjviAhQRc8KCwLVHwsZQH05UKQwFqf+z
         SPNU1jQTxGLL/I8z8ttI/R/Tit//VtTc7xGKtTthmVQqc8/lbcOxA81zne0ITrFF2cDO
         Aic+MZopkwzqXPYTlffICchVYVATrTnCA7aoQSg8VksewcPicUfeqUm0++sMISKY28Ws
         HQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNmgzu58dLYuPDf1GfsqrS14lJU0aUbExsKv0XTAHy8=;
        b=QVc5VND2fMCtSdZ+lZ0sh4oJgg7xQ7qlwnCciYK1jl8JkwujuY9uHvCrz2F1gTTLsK
         ynXpHQ/Oy7OKM/LyXxSWtzODOfu7snWa2EeWmRLoLuRCbW9+7qdtEuOVG2l7nr0Djlf1
         Q8EfuB+ohfRY7HQXTUB5pnCkH2ieGlTgNbtHyw+aSdpvFo1a5VjQSOvJpvMDOMTZhb59
         lvOX3zKjZKWT0p5B+HRaD+5Ftd/WL0KDsGlkRLxR+JDHeiDdaVsvMxyEFM9W7imqC7qR
         epzJJ/07LeX3zzwXzQe0cqhFQ+f2L5tqJ4akXDzKLLhDmdqDqlnlbW52wvdjmhlHwx7w
         LMkQ==
X-Gm-Message-State: AJcUukeDWtKOCmtBWJ13dRnLm9KACBgfV89v/d0vNdkrxMiN7szDeAJL
        tGA2qG62hfJFgWG7JCmbIWHn+HDrZHc=
X-Google-Smtp-Source: ALg8bN7WD1BK3NS7kmmzo+WTWuS/JsdoJ5fD+G/WUekARDaqByz99T3Wz3e0xAsKqnm3HS2v+8Bp5w==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr25323323wrq.260.1548760561291;
        Tue, 29 Jan 2019 03:16:01 -0800 (PST)
Received: from szeder.dev (x4db3778b.dyn.telefonica.de. [77.179.119.139])
        by smtp.gmail.com with ESMTPSA id i192sm1900047wmg.7.2019.01.29.03.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:16:00 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:15:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     sxenos@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] evolve: Add support for writing metacommits
Message-ID: <20190129111554.GA13764@szeder.dev>
References: <20190127194128.161250-1-sxenos@google.com>
 <20190127194128.161250-6-sxenos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190127194128.161250-6-sxenos@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 11:41:26AM -0800, sxenos@google.com wrote:
> diff --git a/metacommit.c b/metacommit.c

> +static void compute_change_name(struct commit *initial_commit, struct strbuf* result)
> +{
> +	struct strbuf default_name;
> +	struct object_id unused;
> +
> +	strbuf_init(&default_name, 0);
> +	if (initial_commit) {
> +		compute_default_change_name(initial_commit, &default_name);
> +	} else {
> +		strbuf_addstr(&default_name, "change");
> +	}
> +	strbuf_addstr(result, "refs/metas/");
> +	strbuf_addstr(result, default_name.buf);

Please use the slightly more efficient strbuf_addbuf() function
instead.

