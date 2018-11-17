Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F30C1F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeKQWzc (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 17:55:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeKQWzc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 17:55:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so27482116wre.1
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 04:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xuT0E/Tn7eHrZMThob6EmPn66G6DvkSmJ3Wr2knpeds=;
        b=UwpasPokzyWaIcSfHlqYiPgcB5msaSQPvtpjPMsQmVJM05gOMLSFUfVDU2noQkP2c1
         VtDg4ZYS1p76KEJ5j7/GwRk0DhP2em9/ay0qWrwDWoyvdY2VfjJvI3zNJ/qGBOwOc9Kz
         8qkxL9cZnEyBs4V4+/LyzB7GwEqGHLxAeTX56pgJWE8zoIs7TsJWGGTsA4iqjkOQ/okQ
         3gKaYU4H5N3SXXo7EsoFtwCTZ5Qz9tiU+wrqDm5UFtJ6fvBLyD6B1qi37VKEoyglyWEu
         VcJ6gHT8YT86pdn68zvJQ7xlnzPG6KkluJq/Uxvtw+uemLK00Bwvhd07mqjNqUqUclZn
         1Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xuT0E/Tn7eHrZMThob6EmPn66G6DvkSmJ3Wr2knpeds=;
        b=Q6xT0UTXPHGsXfthtNSQfOW77ewOCJb8QupNbtJ8w6B/EMAJsNJADDubn9tm9wh4xY
         ahgUscurCr2DygzNpaVMMk1g1Xsp7aCm39lIVYt7KFduJx0X5et4cDEP12GNSLlKuLsK
         i6gx+0i+Jpy7B6psHDgArfmHWCBic6qWmNUNPepDfqR2xTjJMBnL7xMBhYuyYgKgNrfu
         CH8i93q7A6MHJLr+JzTBwEuo+1Rw166tWNuPubD8YxeG9RTTQEMDa9o6Zp72Zco58NVb
         Bu4Q7VP1zUosHUkv5CQBPFiMfbuLivDVFL4D7cdGPtqZMytBZ8EoeDUuaaMnC6FuggmH
         um7g==
X-Gm-Message-State: AGRZ1gIf9MzYEqlMgI7cwjaHYkSQVE2FYk254XLi+E/55YqzcJQsmZPC
        euOHGvrEc3WN2ETiTuKM6GE=
X-Google-Smtp-Source: AJdET5chpi4j5NIms37yWE4ZpNhWmcKE7VPYDk3rOX6CuLs85MTCtrYFmsDJ66ujdp8gb8ziaPDqBA==
X-Received: by 2002:adf:ea52:: with SMTP id j18mr11875892wrn.108.1542458336852;
        Sat, 17 Nov 2018 04:38:56 -0800 (PST)
Received: from szeder.dev (x4db06bb4.dyn.telefonica.de. [77.176.107.180])
        by smtp.gmail.com with ESMTPSA id h13sm9963224wrp.61.2018.11.17.04.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 04:38:55 -0800 (PST)
Date:   Sat, 17 Nov 2018 13:38:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] read-cache: write all indexes with the same
 permissions
Message-ID: <20181117123854.GQ30222@szeder.dev>
References: <874lcl2e9t.fsf@evledraar.gmail.com>
 <20181113153235.25402-1-avarab@gmail.com>
 <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com>
 <8736s43mps.fsf@evledraar.gmail.com>
 <CAP8UFD1Nd657Afgk6s+uNXMW=26Fg-6Jnv6ngB1biUX2mGBkSw@mail.gmail.com>
 <20181116190716.GO30222@szeder.dev>
 <CACsJy8DS1JyuRFyKhVRnVt+ax40+yyv-OVknfQ82OO9jtMeK8g@mail.gmail.com>
 <CAP8UFD3sX4YPmyXtxbcL3-TZEyd_fq7MuSZkYeNGvqswuF4Ncw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3sX4YPmyXtxbcL3-TZEyd_fq7MuSZkYeNGvqswuF4Ncw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 17, 2018 at 07:52:30AM +0100, Christian Couder wrote:
> On Fri, Nov 16, 2018 at 8:20 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Fri, Nov 16, 2018 at 8:07 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > > With the default 20% threshold a new shared index is written rather
> > > frequently with our usual small test-repos:
> >
> > Side note. Split index is definitely not meant for small repos.
> 
> I very much agree with that. It makes sense to use them only for big
> repos and big repos usually don't pass a 20% threshold very often.

But our test suite does use very small repositories, so perhaps we
have been already testing what Ævar wanted to test?  (Though I didn't
quite understood what that was; and we likely don't do so explicitly,
but only by chance with GIT_TEST_SPLIT_INDEX=1.)

> > But
> > maybe we should have a lower limit (in terms of absolute number of
> > entries) that prevent splitting. This splitting seems excessive.
> 
> I would agree if split index was the default mode or if our goal was
> to eventually make it the default mode.

Same here.  If you don't need split index, i.e. don't have huge repos,
then don't enable it in the first place.  And if it is enabled in a
small repo, then the extra effort to write a new shared index is
negligible, and the space wasted for those small files doesn't really
matter (though arguably the output from a 'ls .git' would be
surprising...  which, at the same time, would be a good motivating
factor to turn the feature off).

