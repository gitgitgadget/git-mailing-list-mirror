Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B15A1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965714AbeCSTaZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:30:25 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:41886 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935481AbeCSTaV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:30:21 -0400
Received: by mail-wr0-f173.google.com with SMTP id f14so19776574wre.8
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9gTVgC7T/QtYUmFSRC02P2wbI+Vz6R6ILBNO3WDSYlE=;
        b=QI3fEaGYph9KXTiXXsBzbR37qCmF4aSbYctze8BUeHJaXmEcZrUafxcrimZaz/vCt+
         IJSr0DbZogx7cNDzMgMOtyfOio7bG/q6lcYJkg19FB8FSQJTsEnsFWuPu73C9nZN9Nyl
         Y3vCyfBuj3ZmSpuX5gxEyV6xlwZiAiEZXmJQTaVaL+bEvDJ6CKJHKeH550KqsRRzzA10
         c8S0oxEleF7y77IUr/sf11kvHwdo270mfx1yU6ffsTS97Z83qK7WLQsk7oVCMnGOzWt7
         Am3ROOxxugt9py9NiOIodyss0IjnXoW1X1W6QHhcpK3MYswS8TVRPT30oB+MUYlPCOVq
         LEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9gTVgC7T/QtYUmFSRC02P2wbI+Vz6R6ILBNO3WDSYlE=;
        b=IzOZmYMEGfOsVuzgka+0Drsw8rqC0kpUV+KYwGad6Hi+9gle4zfpkLNxNbAuDTe2Vt
         J+lWy9lXWXTBfma/3XIj0DK0iK4BuYtzEiAWzxjrXi1MlsCjmRhE6jwb5e0bQaHYM8x5
         oPWdMJ/VeYC+hDIgh6IfG9HYhlK5Nh13+LeAQI96PcjLBBlV8SgR4X3NXTzjRz6o2Flp
         h/rbnHRHPZ/73/SfVpcgGkzAmcmtnUzeKK4Jd3lH+tA43spPph0f9HSV9M+d77Vmx/Zf
         BxCOBl/vc1kVcQ8GKSvFlvL/K7k1PftrvDbw8kWoBHxSMP+NktrAfT+bC2VrwOjszZ3E
         ZEhg==
X-Gm-Message-State: AElRT7EF92NJMVzXavYSis+wGawF51DDCKe61TJ5QrNAOK5tbD2jsMeT
        OqutZsmNPlifrS9sJ3rrMMA=
X-Google-Smtp-Source: AG47ELvcCrgmoxxbxDRilZNK1rxmvmPxohhvCD3vrpQRUjMhHmmpi1G4SN9WuoxGe+/AXBO2U4B1dQ==
X-Received: by 10.223.184.234 with SMTP id c39mr10046387wrg.67.1521487820097;
        Mon, 19 Mar 2018 12:30:20 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d8sm945667wrf.8.2018.03.19.12.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:30:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 0/3] RUNTIME_PREFIX relocatable Git
References: <20180319025046.58052-1-dnj@google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180319025046.58052-1-dnj@google.com>
Date:   Mon, 19 Mar 2018 20:30:18 +0100
Message-ID: <87vadrc185.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 19 2018, Dan Jacques jotted:

> I'm dusting this back off now that avarab@'s Perl Makefile simplification
> patch set has landed. It's been a few months, so I'm a bit rusty, but I think
> that I've incorporated all of the feedback. Please take a look and let me know
> what you think!

Thanks a lot, sans the tiny nits I noted in individual patch review (and
stuff noted by others) these all look good to me.

Also it would be great if you could test it for your use-case with the
next branch and define my new INSTALL_SYMLINKS to check that it doesn't
ruin anything for you, it shouldn't since I made it use relative
symlinks, but better to make sure (maybe I missed some edge case, and
we're largely modifying code in similar places).
