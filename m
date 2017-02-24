Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB31201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdBXX2K (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:28:10 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36711 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBXX2J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:28:09 -0500
Received: by mail-io0-f182.google.com with SMTP id 25so635185iom.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ru5YMt3NC2IX9qiTH64zzm7SUIThG7sjFy9QeswJs+o=;
        b=vr3V7biM6PF9xEh17ffTZsc7DRrAAioXckrN6yyAUQ48qKtkVlbKqOT/97LBbDVtwq
         xgTaP/pVovXdnGybWdw12hRw/GaoAxXe2JZdsRN1XEmelaGpHpUFkFSzRJ53nlKpaNJD
         zhi1d/Ybf58afW5M5fFe6GW8N5s5xzXIAXVv/tmDd+QJTf95L7wli3DgWzFg6ies6TgA
         TQ3rF0P7dpQPSbLeR83exb///ccZrX45OYUV+meijHdXBHLlHt225rhnfitEFYHzY2MY
         BKi2loT7JGhTNwJEGu8bgwhRza+xjbF/Oyipv9gTAeh/qKopkit+SwNxmOx8l1z0X0z/
         NbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ru5YMt3NC2IX9qiTH64zzm7SUIThG7sjFy9QeswJs+o=;
        b=bVnFxoYS6zvzPHCAxFN2MQomOpgxNkrWLLGg6MDzEdwP8kWy4uB6OPS3TPWJ7rSBEh
         p0d/mXYyYdOPZ1LF6tqE0aq4LxLYpEPnAxeJ1twmJwFjRvDNMKFdWG/cF+OeJz7ogREV
         HmPCdTJA7/ewGdvsJGIXHvbBQvMKpsxFbxGHKVAhO9iOGsyl0HjBfy7rjnn1SeSdtWgp
         EnNY6KMOEqY8ZRrPGns1gbm/MLA9RwLrK18Ck0zLQjFi0iP5TJ/tby7cFaKMWrnjHbDd
         f1uHbFhREwlEL1wMQN1mNG1raZ7jEkvt4AKGe7h+r3rSU6TNtwEMstWXyEhepqXXI2Qy
         3A3w==
X-Gm-Message-State: AMke39nEa1ENAatzo02ImKzpXii+oavt2xDS6azPfcbaIp2hUVNaMb63ly3u+7+isXjVScggrpgWiJ3cECmtYSFt
X-Received: by 10.107.37.148 with SMTP id l142mr4645633iol.159.1487978888220;
 Fri, 24 Feb 2017 15:28:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Fri, 24 Feb 2017 15:28:07 -0800 (PST)
In-Reply-To: <20170224210816.ftcfa4jy4wltv2b7@sigill.intra.peff.net>
References: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net> <20170224210816.ftcfa4jy4wltv2b7@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Feb 2017 15:28:07 -0800
Message-ID: <CAGZ79kbR4iHnFmhpk0qZurN2sdMnk3kukMAfZ_KitZHx3X-wbA@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse_hide_refs_config: tell parse_config_key we
 don't want a subsection
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 1:08 PM, Jeff King <peff@peff.net> wrote:
> +           (!parse_config_key(var, section, NULL, NULL, &key) &&
> +            !strcmp(key, "hiderefs"))) {

Heh, see how fast my code gets replaced with even better code? ;)
All three patches look good,

Thanks,
Stefan
