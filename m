Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6071F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfH0KdS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:33:18 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35987 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0KdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:33:18 -0400
Received: by mail-wm1-f51.google.com with SMTP id g67so2464583wme.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZTM6n7/tlaIMGirJWgtkCEQ5CLue9KsQHj27g33YBHA=;
        b=IulS7tdipd1kUJIVHduqVR6HxK+gg4kDMp2/i8OKKIm9rnJ/b0XYP1WgIQIaI4ZxFV
         zVtUAJBqj4kxoOFeMXgPDTJJURwClTKKBUoPC4CjQUoHT6f6Xs4jAbmJMV3CH8NoTtl/
         ELH+6vJHDPc//gesDDW9IQpwCSge6NDlnS4s3JE58CAqTLE/7Ylmlcu/fdJGKgE4x5zr
         hG/4G++vJscHMTWVmo2j+vlytYyuL32bJ1qlS4TwpjsjIUEvxfcE2FQNqq89JTKe1ROz
         96Pdk8VunXahv7XAcVCTB0h++PoMxslMgw1rsCMPKujBtp+ksXuF3av80PpC1fQx/2Uq
         Pemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZTM6n7/tlaIMGirJWgtkCEQ5CLue9KsQHj27g33YBHA=;
        b=D+OgsL6kvw3tWOdTkLoH+1+Mc/V04vSYDJMt53cd/gTYxVY+f9vRfSpsqAYYQItdpl
         w4UD5S4wva/x+vQotX1t8QFGjV0OG4qwD7HFaT03+LAyB4TYHluzAOH7UlRHCIB8J0hk
         vEQw8X5gupVXUdPTyAo+2VsvZwm5HXM/0m2DG+M7Bt0RyBqcNeJaG2xfFOiEmTkwSLXo
         CxZKwTuiWONDdRrFgxbd06gIwQrDd/JS8mvuyDrl5aX4VB6X5IN3SkGtBTsMqCQIKose
         PQ9tUgP5oRDEt3S8muUzx9gsfFQJWHVgqG+FM6FdcaYk8qbdiRz54JMF7VRcn5UZf3b1
         qgAA==
X-Gm-Message-State: APjAAAXoCXk+DuBjE0SYqCQr8NAnW97EM7e2awTZ8W9JcFjCX5kADkpi
        kRBL6315kNyK642cdUYRx1XIjZeF
X-Google-Smtp-Source: APXvYqxUb44x8uPf0GmD2I47udbr8SYYAzItVP9L1SuE6xJB4CiZL1vS/aWaZYjS7UkE17V0r58efw==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr28292419wml.169.1566901996258;
        Tue, 27 Aug 2019 03:33:16 -0700 (PDT)
Received: from szeder.dev (x4db46f61.dyn.telefonica.de. [77.180.111.97])
        by smtp.gmail.com with ESMTPSA id r17sm38296457wrg.93.2019.08.27.03.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 03:33:15 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:33:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, git@vger.kernel.org,
        entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827103309.GA8571@szeder.dev>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
 <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de>
 <20190827094407.GV20404@szeder.dev>
 <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 12:04:27PM +0200, Uwe Kleine-König wrote:
> I'm a bit surprised that the default for --decorate depends on the
> output being a terminal.

Decorations (and colors as well) are for humans, and humans read the
terminal.

> Thanks for your help, I will think about what I want to do. Just using
> --no-decorate will work, but isn't nice either. Will test if just
> throwing away all those tags from linux-next will make this already
> better.

Note that you can disable decorations by setting the 'log.decorate'
configuration variable to false.

