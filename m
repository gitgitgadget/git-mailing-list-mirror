Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4E81F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 13:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKONSJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 08:18:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35430 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 08:18:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so10974085wrw.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h7s4TSiaG89/5y/B8jj34VJFJf1Z8g9vmbVoZQiOaa0=;
        b=KIs3N1hnTcY2hf9lmhMOqL6IFAHRPODiXeZEmBW1hELRojzd5TaHoNGOLn5vRAUG3M
         xC5mVML9bf8Ocrbg3V1oTcKSGA2K9jSgT4ed0u/ThuioHnzLNJKCFbTcMhj6dRlw7qvV
         l28I3gGUg0GfIaVbwVjc/DK4ub3LRC/RrZipTeEAsoZN0ooWmmDHu50MTkNIApM8OauF
         VgQ/VmHhR4pLzT/Rycmc4jrP6BNAuo6HRDkgmDm94Zq89cHFCcvElZ1YlR/w03F+OcaL
         8RnGVXW8e7zB9ekiW3lRpXF+nE+IGQt4FoRuM1q12VYFHsHIeEQYfjzsMkfrdAa2jO2i
         nUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h7s4TSiaG89/5y/B8jj34VJFJf1Z8g9vmbVoZQiOaa0=;
        b=t8ssq032OTLrrgX4ApM01xk9+tXZ2LbQbr/RAkx3cLRtNlwPvtCOREMtejuPYdo+B9
         PHOBndr+ubLbSkn7jbu7N4KDvcYju7Zg896DWSZEEpIAj1q3GFYGAcPSakfWU3hdqgBP
         Z+lE3QtTDyMZfJJoJgtT5RR5fVF+1sldL+mqba2k7GCzdYYaazYcqG2yKm10b8oEDtre
         MGYqHgEj6jPMpL4D3FWeL5JkCy8yAcVVjTbCC8Xcd5lzRJUYJd3yuTRQrd/73WscU2Q2
         JNW0rPYJDQD+9PrtrymWyfd/cdHQTc456q9BHBqmsfCPvwie0vZ9fTr7p/e+6rWNf0gU
         Oi6Q==
X-Gm-Message-State: APjAAAXyk5CWUFqo1wwOZZ3hJ01l9/5DZgAd/h68EO0ccMJSclmE15f+
        IzPgJwueLL+J2Yw+qwWMPrA=
X-Google-Smtp-Source: APXvYqzHquq6mqk9VhB/Vj5EFUyfY8zLCI6O13gVk+bU0ejocI2e2RT4/6MKEez10RGEAK5u1VN3zw==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr15644933wro.22.1573823887528;
        Fri, 15 Nov 2019 05:18:07 -0800 (PST)
Received: from szeder.dev (x4db65c83.dyn.telefonica.de. [77.182.92.131])
        by smtp.gmail.com with ESMTPSA id w11sm13433228wra.83.2019.11.15.05.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 05:18:06 -0800 (PST)
Date:   Fri, 15 Nov 2019 14:18:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 09/10] pretty: implement 'reference' format
Message-ID: <20191115131803.GU4348@szeder.dev>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
 <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
 <xmqqbltd7juo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbltd7juo.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:07:59PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > +* 'reference'
> > +
> > +	  <abbrev hash> (<title line>, <short author date>)
> 
> s/title line/title/ as you definitely do *not* want a line with a
> title on it (and nothing else) in this context.

Well, we just followed suit of the descriptions of other pretty
formats, and they all say "<title line>".

On a related note, the description of the '%s' format specifier in the
same document is "subject", not "title".  Perhaps they should be made
consistent, but I'm not sure.  I like that '%s' means "subject",
because the first letter matches, but some man pages (commit,
format-patch, am) make difference between a subject and a title.

