Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF77620248
	for <e@80x24.org>; Wed,  6 Mar 2019 22:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfCFWm7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 17:42:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37380 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFWm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 17:42:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so7389023wmg.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 14:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8wwZL2vdUrrYLgp0BnF7n2UcS2tsAoKPw0R6H+mCAVo=;
        b=PvuYMRCQz5IPWWMSPjPs4x40HJQzxfrZbfB3R6JW/ZRd3zqqhwLPTfDmBacvQXe5xC
         cvFhiNxfSgzniHqnjVWdP9Yj5yTKjwJAHKafgo/n4DbCrpeWpxWCjDEubv74Jfvz9O0R
         RxOn1BbQYNdcKgrbEGBhKR7MtP9venvqdfkz+GH3Gizs20SdpzQWxe+ewB8q0bU5rwjW
         dXFa1dYghJjNcB6UTFsT2YGwk7CFZ/Qsm4Bow1n+LpZOcYZxR+zLjHGrdmtXrfZQ37Od
         PxbIsLGBtjWxS7LdJyoi6c4CsOrTYu9h5hbuV0a8zZC2OeRv4C3zfLnBzFHi7pCXHpFs
         zPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8wwZL2vdUrrYLgp0BnF7n2UcS2tsAoKPw0R6H+mCAVo=;
        b=CbH3Yfduf1kfz1DPhQ/1SvkMQ0M4EJne6CSo+nVe0QTCSI0GQuOAN0uZ+BTnre2GOR
         gTkdZM8rKTX98Bgd3MGixl2NMJMw46B1xk//Gets5ggH6EadkUQ9hWnMktRjofsJwBOB
         e7nIG1/u1mnDDAdpkk1GcvK7vbD0wLnnF6wW9Cpriks8v6003/FLv8m9Y+bVlbqIwwxD
         fOs0B0KQdHSOi898B3V/9RNZoeFad77AblwPQUEsceAR6FPSB3lIC/ePxD9hvZBvgIXv
         eAuEkYcmRsXZCu3mRvJQ6KZMXowwPZIsNZSoEeuQ0zERP+ZWHvbA62U811DTbH4HqL9n
         OcKA==
X-Gm-Message-State: APjAAAXNtQ2nYb9K30ZAdl3quzdIy/7Eajvg1Zi/RIPMNFCvKxmlJ/cY
        zLIDbVMpcahYaRAX057S8v8=
X-Google-Smtp-Source: APXvYqza1RBGjcssp6eT+8hj7mX75ToPpvEC3ItSTxYN029W+GMjDkU3t1zLuYKq0pvPMD3RcPiLGA==
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr3743811wmc.20.1551912177357;
        Wed, 06 Mar 2019 14:42:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 12sm6117187wme.25.2019.03.06.14.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 14:42:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] compat/bswap: add include header guards
References: <20190301213619.GA1518@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
        <20190303171951.GD23811@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
        <20190304214155.GB3347@sigill.intra.peff.net>
        <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
        <20190305230723.GB22901@sigill.intra.peff.net>
        <42d125d4-76bf-afc3-8f12-a9fa1296c85c@ramsayjones.plus.com>
        <20190306044006.GA6664@sigill.intra.peff.net>
        <xmqqd0n4r2qm.fsf@gitster-ct.c.googlers.com>
        <20190306190509.GA18239@sigill.intra.peff.net>
Date:   Thu, 07 Mar 2019 07:42:54 +0900
In-Reply-To: <20190306190509.GA18239@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 6 Mar 2019 14:05:10 -0500")
Message-ID: <xmqq8sxrr5e9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 06, 2019 at 02:28:01PM +0900, Junio C Hamano wrote:
>
>> > +#ifndef COMPAT_BSWAP_H
>> > +#define COMPAT_BSWAP_H
>> [...]
>> 
>> This probably is worth having as an independent clean-up.
>
> Yeah, let's do that now before we forget.

Thanks

>
> -- >8 --
> Subject: [PATCH] compat/bswap: add include header guards
> ...
