Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D135520248
	for <e@80x24.org>; Fri, 22 Feb 2019 23:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfBVXYu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 18:24:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45076 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 18:24:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so4026854wrn.12
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MtP49oaByodlkvcg7LPLzmFY/MePKuj/68a/LzbwF0M=;
        b=QCGt3fFyMDF92XvDrj3p2a2d9xVLR0eKp8GvKfA0zcUNOE0pol9cJk9gvtRmey4jI2
         z/ZCL06dZvIE1Y2h9GZ/RuKK677GYfb1FfnJgdZncMhdUMcRBqURC/VmseFOqqU1DvBY
         VwDMkeKp/sFhNj9tpmi+rWm1gkCm4tca9bo22N1IGYmYixVsS0i+sMyrHrVNzAjHknfN
         mzE+ny3+CedNwetPFLnaH/ZFKWPRS5twz/90C+WQ3I2QL9de6RizoK8sO+dbboD2ruTW
         UbMoVZrH5DZEAEa15kAbBVXOERvieDIGqfuAgVHwIeEHvar6Jq/SP65XXe8+uOlnL4Ob
         dmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MtP49oaByodlkvcg7LPLzmFY/MePKuj/68a/LzbwF0M=;
        b=FaTlLb8o6nj/uTKNCIlf4uDCygpWX1lZUQPEWn4USfBUEV1uCLhrTjkREtp+HaBPN3
         G0exq+61FVIj16bxkJaRZolq4Bd3t+EybD56CZ2t8Y6nyoSM0uqKOW6lQrT8Fuo6Qt76
         WuRVKhn1DuuKXtaadF262VBuayWsu1X87y9JxXu/dQh1f0SC4/SRvDxgD28/4eEkOYuB
         RwpwMeMjueBRqbCaAPej6JHTQ1ZjsapDcy7FpUtGKv0JPk7ZF+JjcXgD5ueS0/MLjZ2n
         PLOPDWpf6rEt073q3X1sHg+dRs7MV4yQ+9FR+R1EkY8mVmzMos1vN5Qyu0pcD6INOsAM
         io7A==
X-Gm-Message-State: AHQUAuaqLAq10QIuK22+W5Oadasu5oe5Bxm4bg1a986z8v0RcVmft3V3
        cC8wnslr/ItpZFYQBXXf81Q=
X-Google-Smtp-Source: AHgI3IajamR/buQp0DqX4+VrAaoj52FGUGQwVlygVBXJdM5yCNbQ0m465jGKJX0uzBeJKkD2scRFog==
X-Received: by 2002:a5d:4149:: with SMTP id c9mr4774649wrq.58.1550877888632;
        Fri, 22 Feb 2019 15:24:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x11sm7078521wrt.27.2019.02.22.15.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:24:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Delete check-racy.c
References: <20190222112757.20035-1-pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 15:24:47 -0800
In-Reply-To: <20190222112757.20035-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 22 Feb 2019 18:27:57 +0700")
Message-ID: <xmqqmumno18g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is git-checy-racy command, added a long time ago [1] and was never
> part of the default build. Naturally after some makefile changes [2],
> git-check-racy was no longer recognized as a build target. Even if it
> compiles to day, it will not link after the introduction of
> common-main.c [3].
>
> Racy index has not been a problem for a long time [4].  It's time to let
> this code go. I briefly consider if check-racy should be part of
> test-tool.  But I don't think it's worth the effort.
>
> [1] 42f774063d (Add check program "git-check-racy" - 2006-08-15)
> [2] c373991375 (Makefile: list generated object files in OBJECTS -
>     2010-01-26)
> [3] 3f2e2297b9 (add an extra level of indirection to main() -
>     2016-07-01)
> [4] I pretend I don't remember anything about the recent split-index's
>     racy problem
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  check-racy.c (gone) | 28 ----------------------------
>  1 file changed, 28 deletions(-)

Nice.
