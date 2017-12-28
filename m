Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E952E1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754589AbdL1XtG (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 18:49:06 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34879 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754322AbdL1XtF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 18:49:05 -0500
Received: by mail-wm0-f49.google.com with SMTP id a79so6979118wma.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 15:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VaX7ASHOg3e88Ak/gQ7w1JkIhioQTwvXaBxMqfJgNsQ=;
        b=Po1lgx6V16jcjOUhjBDhXle91ImhLy754zPto713xR7phJYzbPQZlLbZpE2EUY3bRx
         KfzGbPXlxEwpnpsA5TQX4uwaECe+tNRMfSsGNZr+E0auJ0UckPymiRCJFsUeiUWHATxd
         mk7wdeKH9CvX+/KSBivZ1ESIFcT5tN/NtwxJlESf2Pt5wstgS8WmbbFbC+NjmSMWFRug
         JpzHwapdxqHJMU8u2ZTjsi5sdjeDVIE1DBywOzlTAoevWUjxVXR7/r84GNpHIGh+8/wn
         3es5fBqmARL0k0HILzN0IwfWJkf+4Ld+ov87SbSITSZJks9DnzBaxHqfPa62eTjW4MAG
         MArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VaX7ASHOg3e88Ak/gQ7w1JkIhioQTwvXaBxMqfJgNsQ=;
        b=dWVF6uBTRvnejkmDiZekTkW9kYwWdZJkVe3wYW1t8WhSvjJ/RdSXv0GhXkIdKD4kO1
         q0Ru/L3ZgjlHrUpoAlo2dY7rW8+NioLLPQlSpxkSLUeVLd+1AJcXk/6BT9EeeDPWiqkW
         XgVHXatqom/zpBqNnf5AV5dkcBkDWnGR9WxTjlpXFladk5Nn7PRnGUDN6urPWwuXb0vV
         BsUFhsjbPvbooJymO8+Cd4IrS5i3qiWBpQlzrqrLtfVrRUhBq6Zq45RbgdUkbV+Omldf
         Uld2X7IRRjCCaR5dU7DU0GaYgYPrLdXjSvXRfPLCz6BS4DkGX85L3WBZE4Ik0m8baqnu
         Y/vA==
X-Gm-Message-State: AKGB3mKB5AY5/cYGPTvFTqKPoly7qovFq7C3HP6cR7plwpyNyMfS5gBF
        nNLwPEcZFZrdZG3CtTwRmkmxSCWx
X-Google-Smtp-Source: ACJfBou1dO9ifUalo2Zz5AbSDdErvjVqZh0Tu8lVrZW1tNdLp2VbV2wGvE2LIO0G53U5M8B1SZ9c3w==
X-Received: by 10.80.167.228 with SMTP id i91mr42631420edc.20.1514504943981;
        Thu, 28 Dec 2017 15:49:03 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id x5sm28002117eda.8.2017.12.28.15.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 15:49:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/7] increase wildmatch test coverage
References: <20171223213012.1962-1-avarab@gmail.com> <20171225002835.29005-1-avarab@gmail.com> <xmqqr2reii4u.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqr2reii4u.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 29 Dec 2017 00:49:02 +0100
Message-ID: <87a7y28lch.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 28 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> This v2 addresses comments by Johannes Sixt in
>> <8f4cdb23-8e2e-144a-1f70-99776b027166@kdbg.org> and there's osme other
>> cleanups as noted below.
>
> One thing I found "interesting" (because it is usually the other way
> around) is that about two dozens of the tests in this fail when your
> shell is bash and all of them pass when your shell is dash.

I sent out v3 before seeing this. I can reproduce this and will send a
v4 with a fix.
