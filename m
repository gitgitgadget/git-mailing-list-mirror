Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A6D1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfBLAa2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:30:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50473 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfBLAa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:30:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so1114484wmj.0
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kjZYwlcoOIff1EEbNfaaExPFG0ka7pAdUlgPU1gLazQ=;
        b=ju3PY/4s6XWOT8setTTCF4V+k8VZZajz6uJaj/FnsRo9V/Y1Yq4FlS+EahO/McGEch
         8cTYWqEg5sP7mfg1wXOm5+jdV8i8OWnW+CyyTsnmF6jeLowGIK17IwrzV4JyxdsaL1B6
         etUuRegDwClUasekp+NF8YsF7YU+bSpN9c/3iMONdTkxosB4pF6pVnaZ5r07RT9/vNIm
         np9qEoUAeqNttgJ+z+6WXCTk/hUYnwWlwmAfPrulmZmfJw0M4jlXVDtjJdWYVyNRo5ZK
         pKLCHyF7zeAYBSV3EiKl0wLpQOWM4axCIL6L/Fm76kvEsnordeazWnif4zUYIEqVjofD
         PnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kjZYwlcoOIff1EEbNfaaExPFG0ka7pAdUlgPU1gLazQ=;
        b=FfczqWTslEcjqTYyurl2BXW9K8GFbJcG2e64KDP8rV+zeWn0KK2Y5AAiG6Q3tE6+Vs
         UTAcQh0AOZAV8SyMy8jWJiYG6dm8RCh5bgywfrsabZJCoMQxhB+bETiLjXdnyK3PRYY4
         bfzB0Nq99QwjiN4QQYKas5TB1QG6tQ8P2mnd+6r7Um8ysJMCZSovX+ou6vLwTOPZ0OOh
         xrNwzt2wOA5VhGL9k5pyDVPJMQWZcDm7D0DCNfwsCF1WPAT5MrlKHfEwZvCCGJaKAOw8
         5LRQwrVx95mxil/WKAsORDZHFW4gv9ICkhPSCjAyxXwFNAQEZHjMn/q4Vr+s1n3dzUwa
         Ckvw==
X-Gm-Message-State: AHQUAuYGWm456alWeaW+Z/KVxgCg5P3upew+klWZOypcbQdyC8Pe8ogF
        OX6LBTSrS9qnDFjgnv5+zbE8PdTv
X-Google-Smtp-Source: AHgI3Ia0qzBnlYq3O4LsWaT7lF7/kIinzy8kWBzg5nYBQhtVTCtsO0WzyrYyPkFwyegb09vl1NzhbA==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr672115wmh.102.1549931425839;
        Mon, 11 Feb 2019 16:30:25 -0800 (PST)
Received: from szeder.dev (x4dbe9d5f.dyn.telefonica.de. [77.190.157.95])
        by smtp.gmail.com with ESMTPSA id i10sm13125878wrx.54.2019.02.11.16.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 16:30:24 -0800 (PST)
Date:   Tue, 12 Feb 2019 01:30:18 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: fix non-portable pattern bracket expressions
Message-ID: <20190212003018.GA1622@szeder.dev>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
 <20190211195803.1682-1-szeder.dev@gmail.com>
 <20190211234626.GA13301@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211234626.GA13301@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 06:46:26PM -0500, Jeff King wrote:
> On Mon, Feb 11, 2019 at 08:58:03PM +0100, SZEDER Gábor wrote:
> 
> > Use a '!' character to start a non-matching pattern bracket
> > expression, as specified by POSIX in Shell Command Language section
> > 2.13.1 Patterns Matching a Single Character [1].
> 
> Just when I think I know every little gotcha in the shell,

I've already gave up on that :)

> I learn
> another one. :) Thanks for fixing this, and for digging up the POSIX
> reference.

I had to, that 16.04's dash worked, but neither dash in older LTS nor
newer upstream version did was particularly puzzling.  Turns out that
in 0.5.8-1 Ubuntu (Debian? dunno.) started to configure dash with
'--enable-fnmatch', which makes it understand '^' as well.

