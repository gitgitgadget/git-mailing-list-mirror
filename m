Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3410F1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbdFMV6X (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:58:23 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35420 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbdFMV6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:58:22 -0400
Received: by mail-it0-f51.google.com with SMTP id m62so49222369itc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SRQnyMuuQ2Maksba31I8CB92B2tHh7A1eZ+BMyC3b70=;
        b=PLE8hOqJaIsrct/vfYS+r/Y/FvMN0r/EZmM1TOSDZVAAHSWUQaSDf9iJtQjzBMwglk
         yszv8D/rAaauHhD60u/Ilm2tOvOzZhgK4NdCsh4hgb+mhQbeQVUhTgh8R/SbnfOqbU78
         56KxPnR4FUoq0JJ665aKi13GI+334rOt3Gk4GYjfEun1R3i5bor14KMSP1VgkUV5L92K
         iMufEbFu9jQ0gjdwWpSlmQQxQ3Q89s1BTtme0rOdsTcpvFLIOeOy+0rUc+zNY0kJPSHi
         b+iALVRz62FEo8ohxWjOtiRowcqsmW0d9+vaD+ZE7/i1PY2zm4AbzMGik8O0SJBrfQ3I
         bumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SRQnyMuuQ2Maksba31I8CB92B2tHh7A1eZ+BMyC3b70=;
        b=gFcNS/peQtlj6cDWC2QRx6JByayQ2dHTcFLnR5psB1SJbZBuao8xTjPudAdrSpisXC
         hgeU9+gI8AB6fn/rcBvl+gbWkpiDYI1dYUf3adoSLMJfyyDETWqExXhfK0UknEHFEU6V
         uq39GcJfssOsJmW64w9XD0H9lxL3ilQd2y5pZt96ri4aGAqveNhCO0+6UlaxWDKHs4gf
         2V6gPop/QzMl3Dd5zviKM75WRO10fNsojrwQ9adhDMqRyOEMzJrKnEFP28DF2ZAAkLKC
         OzN58rLKgCRxrAE2CHkalE9UMdxs2E0toOytt12LYGwl1LAUa5acq1vUNxVGjYTEssh9
         Ruwg==
X-Gm-Message-State: AODbwcBsv7XLIkFcWwO5chTmD1/jyy9rcevXf6pamx4DdZVmWP9ghbEN
        jVNJp+90HSEH1g==
X-Received: by 10.36.189.134 with SMTP id x128mr19733728ite.27.1497391101571;
        Tue, 13 Jun 2017 14:58:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id l19sm6923039ioe.3.2017.06.13.14.58.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:58:20 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:58:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net
Subject: Re: [PATCH v2 3/6] config: don't include config.h by default
Message-ID: <20170613215818.GN133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-4-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613210321.152978-4-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> Stop including config.h by default in cache.h.  Instead only include
> config.h in those files which require use of the config system.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
[...]
>  145 files changed, 145 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
