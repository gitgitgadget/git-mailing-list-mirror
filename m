Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B2A203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 16:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbcG0Qki (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 12:40:38 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35797 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcG0Qkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 12:40:37 -0400
Received: by mail-yw0-f174.google.com with SMTP id j12so61809790ywb.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 09:40:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IBfcin0zXGZ8cq8aXuAJmh+NFgrSS6MrU0V13YOKAy4=;
        b=p+HNcYVYfaah927wbcV7m+2tl38YsSTczidtpj/vNfqIdq/oBfs6P1+2zKEnHnT/Zc
         y+/5llQUE+o1RBa/3t/ZYPK3DCbSpYAy8dyJ3nlCgNBad0dp/rCq7ZWll3Qz0Pfx7Wih
         P0MZKmUCnEvcnp9Pk1NUPbhreT5H0VVyJjuOusP8k4xKwt9PjislB5U5lW2En3HGwjPN
         CvWrfvBEG6nNKq0HD+/JuZjLEbhTYx4P4hQRViMUdrp6J3O9QkT8gQ3zgHqINyJQjp4q
         NvfpLaRiXIxA8ipGOBpDf2LF3kJwixJFi57TYYzBPnN2KHw8asUi3IQSHL8Z8Htgn01u
         J6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IBfcin0zXGZ8cq8aXuAJmh+NFgrSS6MrU0V13YOKAy4=;
        b=chA4SatZ+XB6IpxbnAcdM6qswvtAdkB12UGXyZICOT72Z/ltMcmXhU97s/PYbULO+x
         8YjUrd47c0GoL8HpZ1XiekD1iD7/i0G7O7QDbTINUeMcDwif7X5biSX+OQmAN2MZJjMg
         MXzpmhMgVyvS2J+vtHXG3rpI+iVds+KVuRYEr3XGjB9Ii4wF+BfoDzrsl919dZ6toCaz
         y0cs0fOJOAxzJmZ/K7UrJGq8SkjwtPHGJNjuTUVSkjzmTH3uciwBglr85pi9tXh1HLvZ
         IgTAGkBHHjqx7sAuTH//gX3toE/bfi2jxrV68d5SvRStZVv2vByfXhN8sy/W5KyxqIio
         cLGg==
X-Gm-Message-State: AEkoousnrCkDOJX8UcIkSHS6hx9DbWWlULXoUbPRMIe5qvVvennvOmPSQ9F15Mzn6o9pvB/kOwB6TWz8HaG9Mg==
X-Received: by 10.129.106.197 with SMTP id f188mr24973152ywc.38.1469637636335;
 Wed, 27 Jul 2016 09:40:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 27 Jul 2016 09:40:17 -0700 (PDT)
In-Reply-To: <9d167448-84ce-e368-0bb4-41aa4452268d@kdbg.org>
References: <5bd59ca2f87e388350f3c8fb17c9a287661cd055.1469623136.git.johannes.schindelin@gmx.de>
 <9d167448-84ce-e368-0bb4-41aa4452268d@kdbg.org>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 27 Jul 2016 09:40:17 -0700
X-Google-Sender-Auth: MghPdTYfakFJYaL07bkasbX6Tx4
Message-ID: <CAPc5daW10y_5rat0Au-1NWXUf2QYFrDfQeprqq9NsYPBjdqOTw@mail.gmail.com>
Subject: Re: [PATCH] t4130: work around Windows limitation
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 9:37 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>
> How about this instead? It makes the sizes of the files different,
> which is a bit less obscure, IMHO.
> ...
> Equal file sizes are not crucial for the test cases, however.

That does sounds like a better solution.
