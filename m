Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20521F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 14:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbdFIOsT (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 10:48:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33161 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdFIOsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 10:48:16 -0400
Received: by mail-pf0-f182.google.com with SMTP id 83so29299792pfr.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W5UeeDpjekFzzYokXr8lzxH5V5focpyQ+N3SlMxCSjo=;
        b=D0gt/qHbtcdxDf1FaNjM6/JRpGXOvYg+WmWvjqAHNVnB6a7P3aSDX3CcHNH+hKUhQG
         Gx968FCTam3vJQ1figUOWO80sr3hmYOh63p4TrHTtherOCTu7RV/o33bnPNZmDsTZiTB
         jzTrs9cBkASeh7XW4HZ2Uxj83o6932F5PQzvxZmYt+6zFSRl2/eEfW5hLPQQqzxXzgIv
         x40RXr53DR4F57sV8YWWsILVDZx/IIIWEm/Z/1MpZ9BEfYTVOl4vbYt8ud5eupLRxyLV
         91MqRmYhLErNXEtd3gx0ATpCha+5DFSrR0c+n0plitw7fuABfxhWJ+ptPchPE0OwTA4L
         GhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W5UeeDpjekFzzYokXr8lzxH5V5focpyQ+N3SlMxCSjo=;
        b=t2MAB+V1lDRTmPCPCHehaq/L1jOS5XaCYcHGnudlTrzgqa3cKEAdY3EET1GT8YRuiw
         Cj92vrZb5niFB2JY60MhmhJwEfUU3Yp591oA1zcaKKSeMd9Ey+jGfR2JmE+0aT0yyY2k
         zC6H83tX9M17OiT4OfBjezWEOnHYQEpN186Z2CeAtJCXHpTITi621MvYGH8vRgbD9pcw
         sdAPnQz7aXoCiiw7EyiNFTuRmf4+BubYt+CKfkE/ASKw32TS33N7qLx2BCb91Vb9MT0T
         W+P7m5oX7Iq7HzAloVWCM15ikaEJJYmElUm1NQ/my5Gtf4udMXSnS3Xt6hiLZylJT9rE
         P2BQ==
X-Gm-Message-State: AODbwcBuGVQY3FOWRx4nAglTv+EyGwXFd2RkLKUqiYdZOPm94XDBLGP/
        2JKcM8nozNcUyZE1
X-Received: by 10.84.204.133 with SMTP id b5mr17851260ple.77.1497019695580;
        Fri, 09 Jun 2017 07:48:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:95c0:15a:33cb:7a91])
        by smtp.gmail.com with ESMTPSA id x64sm4945625pff.123.2017.06.09.07.48.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 07:48:14 -0700 (PDT)
Date:   Fri, 9 Jun 2017 07:48:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] *.[ch] refactoring: make use of the freez() wrapper
Message-ID: <20170609144813.GA81269@google.com>
References: <20170608234100.188529-8-bmwill@google.com>
 <20170609085346.19974-1-avarab@gmail.com>
 <20170609085346.19974-3-avarab@gmail.com>
 <CAN0heSo_S+_dut8RgDzVxffPZOzSTLwahsKrn7KG8aLvnrPbAw@mail.gmail.com>
 <CACBZZX7U2SO11VZ43duLco1BhgM_XDzNTtrjcknjhijRkaeuxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7U2SO11VZ43duLco1BhgM_XDzNTtrjcknjhijRkaeuxw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Jun 9, 2017 at 12:12 PM, Martin Ågren <martin.agren@gmail.com> wrote:
> > On 9 June 2017 at 10:53, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >> Replace occurrences of `free(p); p = NULL` with `freez(p)`. This
> >> introduces no functional changes, but cuts the number of lines spent
> >> on this cleanup in half.
> >
> > It's even better than that. ;)
> >
> >>  48 files changed, 97 insertions(+), 197 deletions(-)
> >
> > The difference is in builtin/am.c where some empty lines are removed
> > in am_next(), so no need to be alarmed.
> >
> > The macro would be dangerous with things like "freez(ptr++)" but I
> > couldn't find any such side-effects. In hindsight, I guess your commit
> > message says as much since using "ptr++" for "p" would already be a
> > bug.

It also couldn't hurt to add a comment to the macro definition
explaining that side-effect operators would be broken.

> 
> Yes, although perhaps we should call this FREEZ() or GIT_FREEZ()
> instead of freez() to make it clear that it's a macro.
> 
> > I have no idea whether this conflicts with other topics, or any
> > opinion on the best strategy for doing the conversion (all-at-once or
> > "while we're here").
> 
> It has no conflicts with pu, so that's something, and passes all tests
> with & without that merge.

-- 
Brandon Williams
