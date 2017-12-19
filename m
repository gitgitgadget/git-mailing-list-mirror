Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEAE31F428
	for <e@80x24.org>; Tue, 19 Dec 2017 22:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbdLSWbe (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:31:34 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:42707 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdLSWbd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:31:33 -0500
Received: by mail-pl0-f50.google.com with SMTP id bd8so7838833plb.9
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUkLQK2zemivbtHc9myghraw45WbC6o1QMgceMTC6ss=;
        b=VoAbXA4Nf1qyOgdphi3rFBXB+JKVRWW6omiFJXfVhXLk+kobz5ZjitMLyeSJs4dMm/
         eYN611ny73jjeK5zL1AWihRg+04K4BTiXUyMoU2LwPBknh8t09BRDa2CnQz97jTqXeX8
         TBA3raks0bEfCC9EoD28GvTk4PFTNgzyMK2p7kagEA5kmuSA3jj2soEFTFcJSLqITo8q
         suz2Pn/dwCabOz5vIYxz8jv7HrQhOolLvUwH1LaFTdTBC9ZOruFJUEgqYBz9HWUiHlYU
         yjijZqoU460+wAGegc7Vq0NGCsiEfK0E+u55D4aw8ljGccI0ffLWqT6fV7j/R0YThkeA
         rXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUkLQK2zemivbtHc9myghraw45WbC6o1QMgceMTC6ss=;
        b=pUqIJoMNQdNUC9jT0PkUpU1kEvexP4yb7XpbZicdqn8jlSa0jtasFZ2nT4I1d2gEdH
         Aak5ZWnHMCJdoTmBdPNM5wmDvQdB0Wm7kkw1+ly5SaWyAKqjwLhTP9UJbnSslHNvB3j9
         yFT6Lw8HGc1vS4H1s8ZwSH3lautY5AgsRb0QsTRcs+6MQfSvnipDVdqkbB0w4TXzFVTc
         5mj1OHcomGakGXDc6vVMLSrwOgze+LYMw30HPTOh46htwlEfbJ4FMvNQhEPxEqe6DxQX
         6UUnDwf6O31yu9FfnpEjMj7tW39DCuqHd8SPWl8kV4Le3j9Hm7u8m9ZcftqpwLtJ9FM9
         AyFA==
X-Gm-Message-State: AKGB3mJLbF0VDTbFzEG+g2x6JrgbhdFTHRyhYTFF4PRBjvizrvxUtDQD
        aoNjlS3CtyeUNNk6gNfoSH2DLG75
X-Google-Smtp-Source: ACJfBotev+JD8Ljh5jW9hQsUPUqN+VlRojdH2p/Wg+sE42mUt66B7Ocy4sIe5mRdPx3JekalgxgDYQ==
X-Received: by 10.159.218.150 with SMTP id w22mr4524966plp.91.1513722692946;
        Tue, 19 Dec 2017 14:31:32 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t2sm3456390pgb.88.2017.12.19.14.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:31:32 -0800 (PST)
Date:   Tue, 19 Dec 2017 14:31:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] t/lib-submodule-update.sh: add new test for
 submodule internal change
Message-ID: <20171219223130.GF240141@aiede.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171219222636.216001-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219222636.216001-4-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> The test is marked as a failure as the fix comes in a later patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/lib-submodule-update.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I think I'd find this easier to undrestand if it were squashed with the
patch that fixes it.

This is part of test_submodule_foced_switch --- does that mean it
affects both checkout -f and reset --hard, or only the latter?

Thanks,
Jonathan
