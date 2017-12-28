Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9861F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbdL1TE5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:04:57 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:46247 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753565AbdL1TE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:04:56 -0500
Received: by mail-it0-f67.google.com with SMTP id c16so4904260itc.5
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 11:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yPxZvwx1fMcbE8aULsRbbjpx0Uh9cqMb+OCwJz1o7Bo=;
        b=Q6FVZKvRl97iIYvc6G7T4HeQBRyuiEVagkEriTO2pHEEHWzsCBHK/npoU8bUeDjQng
         QK5sbXHjzwpsqcbLpClbxIn5vD+IETikipYdJSqA49NC09nqwFFeUhcykVJjLhQRlml3
         q3EkkFFQn15e+upyVnPz35r6m/CVZi9XSDAVTQtHIwF7TJxq0GLR8wf2i2Gn2sOLWVvF
         0wD6qsB95lG4bAKg5k1jlAXwobz3zTsfs7fyHAS3LmOQwDa5X5ZjiIIg42WCUMDzMgFB
         JxyQRgn72f/fr5Z4RVtZU8+b3Ltzr4ufwk9XYnGyRcDFoPNpGt6uX/hfDWDlO6ZAkaGd
         8XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yPxZvwx1fMcbE8aULsRbbjpx0Uh9cqMb+OCwJz1o7Bo=;
        b=dB3/pylSsCba9zwXD1/+uAuhvDjGBbKCZ+xkfMJ++WQhy5FRxo10O8NLnEXcusn/VP
         ZzOs4yGJgWOyqVXCjBy6hoCn9CFabgfFrfEFQzYxrSFzNANkzuv+sNPOesuMVfRgJn3K
         PizBWOivukxiSkEmdfCBgDhCKTEaRuPoTc4k0BSf5qGEZxxV4ZHOOQBgB7TgLybr78v1
         7SAnaS0NvdUSQcFed2QRxPytFqxrcHgjZDW/JEe35Su44NRh8dsJr7OWz0MHq/+jHV+Q
         bRfMunxJlVui6e2gElpsqnggxpXFMLBPqiMVnw9UGp/snIkU6RJakDrDEha5/RaIN1Be
         7aMw==
X-Gm-Message-State: AKGB3mL4PiaFoTtb7EjbsRum1cvlwC5RQcM7IzITCLE5/kwLS8LEHYae
        +C/2urceu6HTL5d4HlzA/+E=
X-Google-Smtp-Source: ACJfBosxeWEd9NDwvDLv5aLKgVEz8M/aOOvswgyRi3R27JukQnAFG2m8G80gvukwWJz1Zq3wN8MnxQ==
X-Received: by 10.36.133.135 with SMTP id r129mr45206954itd.69.1514487895680;
        Thu, 28 Dec 2017 11:04:55 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p68sm11954220itc.26.2017.12.28.11.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 11:04:55 -0800 (PST)
Date:   Thu, 28 Dec 2017 11:04:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Windows: stop supplying BLK_SHA1=YesPlease by
 default
Message-ID: <20171228190452.GB92530@aiede.mtv.corp.google.com>
References: <20171227233912.GB181628@aiede.mtv.corp.google.com>
 <20171228140742.26735-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171228140742.26735-3-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Using BLK_SHA1 in lieu of the OpenSSL routines was done in
> 9bccfcdbff ("Windows: use BLK_SHA1 again", 2009-10-22), since DC_SHA1
> is now the default for git in general it makes sense for Windows to
> use that too, this looks like something that was missed back in
> e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17).

micronit: the commas should be periods.

With or without such a tweak, this is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
