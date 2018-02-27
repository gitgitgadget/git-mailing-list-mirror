Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCA61F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeB0XDX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:03:23 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43553 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeB0XDW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:03:22 -0500
Received: by mail-pl0-f65.google.com with SMTP id f23-v6so307779plr.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pExV2xfdY3lhNqRq1wte5bEUfkb3MLK6Kbxm6k1RE6g=;
        b=Lx7h5EPektX81pdjYRz5CaCwtX+ZvSCdJfe+kuKqT2962agaFVfjp23O6XbS5SM4vS
         bxu4sKCWbYXFG0pA//YTCito4eg0SGBoQilOXePEHIt+Uf7JMycCnr37ucBTxS8ylO2i
         ultdbZdnqSAC/rhmE9lQoIpMM787HgW5FZOeDFED50Gjs+Qxo78qf5Il7k4dOlWub7m2
         aP+/P8F8EKupWz880mO11qQNoIdOfmX3/UoOMWyadtOFfAPCnGWY7PxCEY45thhgIIvr
         a1xoCsHBnr0Uzuvy7aymwLrEA3AUqgW+tkKCsM6Oi4Xb33Q2z6Gcp14u5TbZpMPGTsmg
         +oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pExV2xfdY3lhNqRq1wte5bEUfkb3MLK6Kbxm6k1RE6g=;
        b=P1rAzq4CfMF/0LRv7iiccwYKm+7teOf7HmVbspHrih2zLhA4xVWffoQQSSdwkfQ0cn
         +AUWyab3sk9KUlgI23Ckc+RHqyjDg+cKEFjSNTBbYbNmlmRVah30ckXWu7pI0JftdVBz
         Or02WqYx5NTo+XznovOtSayxETPBWy1jCIdmpm8vfACq35p8454Wluy8Ov76Nr+k3Ydb
         jaxR/mFOhRSGMjpVVVyShTIUPCOacg34vO3D3hREvpMOZihCWjrrKNr+WHoi4gYJSPF/
         XyeTKoV0+KVyXcHB4gWK4/Y6+u/EN29ybhrKjAXSiufV1oFu0W9FoRNGe+BjdFM1FqeW
         C/Cw==
X-Gm-Message-State: APf1xPAPibi4826U1GNUkzBInvc/6BtOLlcoxPQXEJUSpO3BQ13mRgZG
        bRiwO8gFQq9zL2Jslhefj0SVv4o9
X-Google-Smtp-Source: AH8x2263/8vpBYVE2cNi99HS3nyHKORtYKsmXkDjmJr97+3ydEjANPJAQrmvZO1q38LSVQSodh87Iw==
X-Received: by 2002:a17:902:aa5:: with SMTP id 34-v6mr15978635plp.429.1519772601562;
        Tue, 27 Feb 2018 15:03:21 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x124sm253196pfx.105.2018.02.27.15.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:03:18 -0800 (PST)
Date:   Tue, 27 Feb 2018 15:03:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 26/35] transport-helper: remove name parameter
Message-ID: <20180227230316.GE174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-27-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-27-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Commit 266f1fdfa (transport-helper: be quiet on read errors from
> helpers, 2013-06-21) removed a call to 'die()' which printed the name of
> the remote helper passed in to the 'recvline_fh()' function using the
> 'name' parameter.  Once the call to 'die()' was removed the parameter
> was no longer necessary but wasn't removed.  Clean up 'recvline_fh()'
> parameter list by removing the 'name' parameter.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  transport-helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Nice.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
