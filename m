Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C451F404
	for <e@80x24.org>; Wed, 14 Feb 2018 23:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032118AbeBNXyL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 18:54:11 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39233 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032055AbeBNXyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 18:54:10 -0500
Received: by mail-pl0-f66.google.com with SMTP id s13so5853849plq.6
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 15:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rrl/bJve3El6un/Do6QYw/kcCYFpdo2fv9RE/UikNeU=;
        b=E0zcTtmBlu7jsBOi2z4eo4H50udf/XtH0pJpwBoZ7AygDP5xIFzw1mr/M5amg4hZ9f
         wuXPJ36Vk0UazQuh4Vz8sWJSyHKd8iuz8MTV3dWUurS6+HAC+T35SdG1y/Y5Jzth7s2v
         rOZ5Y5PzmJPlhOReokOJfsSrMwAi0CetrdNrTee0HpuU4M3PlaMtasRdAzxKYoE2Svx+
         12EAxEQAcpgWaAWkMBIfAosh4T9Ig7lxSbwLS8kOG3l5Fn18j29Mgk8QVbQLujCYzK57
         wP4+EBEbf1s+0qdz3yMs6+9vnpM290S2AzE5vpWq15Ma0KYXaaujMGvA1Yy/DBvln5YE
         1Lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rrl/bJve3El6un/Do6QYw/kcCYFpdo2fv9RE/UikNeU=;
        b=GNz4jOQHc4PCM4LDjAqKIU7r7FX+z66HHby1AMACify5SymHAhL85pF2oEWF5vbVM4
         zPZgwu3GNGk+UwId1zNTTukdjICXXUKCox+5H8VMbOj4yWuGlqfbpX9qthaC4ILC8Twd
         HCDDNIvanOO8OZX3rh7PXJ6VWPQSGGFDU/JZQmoNAONCo+mNfPJwUmC65+oECUa/HpSn
         jkVWq/Nipf6iClu+lZydk57uaun+rgMylYZmfIXT3BLC5njs0ao1UJEQJjjOUifyApC7
         exY9A44mYxcWBtl8bAWFZGT1eUfVGjQ/t/gEP+g78fZIznbvlZiv3R1YV7VOo4dldqbe
         Fxbw==
X-Gm-Message-State: APf1xPD2qZEjstpr2HE7YDQq6V4PKWTL3ZUmDPZyB1eF5GgUexxr0JHV
        /ibiZ02l3YZQqvw1a783pco=
X-Google-Smtp-Source: AH8x225Fl3OaDRRsPr2wxJMK5bd0blzrbG9Ww8kecc0rvBOoEpvDKNg9HZsABLbr592jayAJTRqWmQ==
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr663984pln.345.1518652447374;
        Wed, 14 Feb 2018 15:54:07 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c29sm45999894pfd.113.2018.02.14.15.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 15:54:06 -0800 (PST)
Date:   Wed, 14 Feb 2018 15:54:04 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 8/8] perl: hard-depend on the File::{Temp,Spec} modules
Message-ID: <20180214235404.GH136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-9-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1324,8 +1324,9 @@ sub _temp_cache {
>  }
>  
>  sub _verify_require {
> -	eval { require File::Temp; require File::Spec; };
> -	$@ and throw Error::Simple($@);
> +	require File::Temp;
> +	require File::Spec;
> +	return;

Same question as in the other patches: any reason not to simplify by
using 'use' at the top of the file instead?

Thanks,
Jonathan
