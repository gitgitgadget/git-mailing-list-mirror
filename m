Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630C31F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 21:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeKMHOs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 02:14:48 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43507 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMHOs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 02:14:48 -0500
Received: by mail-pg1-f179.google.com with SMTP id n10-v6so4604667pgv.10
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O2ENOOlDqZdMFMLWj3OAKJMK8ojis3YpZ1MXj8fxco4=;
        b=nVM+n7p8WWgj3oNDDhPP6fLl8LHN2h/5TXqtF2RwJD1rY8zFhO7lZRopLw3tGkHL78
         yPQ6fsUtKbDca45+39wiYj01QphY2o80SNm09f6uA+1YuGgZsD+VTDgVZW7vTkWLKsAn
         vKdmGHoEKMGhHyzWRg/3wWULk6HcFCkrOoPWPljo9HeKtfLUTd/bmbGyexW6kAe699fM
         e47Taaz/3hoZ6Ci1F/L3R/9rh8L8KT7Yj0Hqw9r/jVxWZgLMHqlnekAj6MVuBGb+qNkx
         813He1iilD7XdzhdZ4Ts09OTiLKs2hRci1Csw4jxnM3234VDpvptYRKQSCIXc7Fs/zuG
         v7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=O2ENOOlDqZdMFMLWj3OAKJMK8ojis3YpZ1MXj8fxco4=;
        b=DwxOMErxUCNZ07+sM53It/mp5aiI1AmyoUFV9GeSlBC8RlSqpXAfBQfG3rmZcNIXJX
         30rGBgxXGjnCGa1kKTiEaQ6oHJkY/W1QUYwiLSBajQC0gtp09N44viEF7k4T6itwtTWE
         sCmzQPU4AEXN+sqZuLuqbZS5kan+5YMYGpv1+pdONei1HFUr3mv/NqggpM0baZJmSWgg
         ktDkfrufn6v3Bj/fWIQWGp5T6ib8u9mJZYGDLLHbKTpfjVfzYIPjmsOXS6DwWZwfLssw
         SFE6EzzsJzKeAxIq14sK4DwIH9d+DPpdhstyxzc+qCbHbSU6bo2Btw+bSoTFp7BWzTUU
         DWeg==
X-Gm-Message-State: AGRZ1gJung+pprtTbIS0ifK/aeRhw+Bxvct5BxXZcsmxHuyepGrJRzyd
        GwcQ7Hpzhklt4osSfJY97ZjJ0g==
X-Google-Smtp-Source: AJdET5cXR8jVexkeE+1ohk4U9WMsYoSyfbPvr95F3NL/oYyQVC5wYKsKVgzHBoDBU2k//bKcPCe9Dw==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr2167517pge.94.1542057587895;
        Mon, 12 Nov 2018 13:19:47 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id h128sm19674282pgc.15.2018.11.12.13.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 13:19:46 -0800 (PST)
Date:   Mon, 12 Nov 2018 13:19:41 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        szeder.dev@gmail.com, martin.agren@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] coccicheck: introduce 'pending' semantic patches
Message-ID: <20181112211941.GA126896@google.com>
Mail-Followup-To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, szeder.dev@gmail.com,
        martin.agren@gmail.com, gitster@pobox.com
References: <20181108205255.193402-1-sbeller@google.com>
 <20181110001052.101290-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181110001052.101290-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.09 16:10, Stefan Beller wrote:
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
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
> I dialed back on the workflow, as we may want to explore it first
> before writing it down.
> 
> Stefan

Looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
