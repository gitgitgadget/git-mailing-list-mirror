Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76431F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDXSeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:34:09 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:38012 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXSeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:34:06 -0400
Received: by mail-pf0-f174.google.com with SMTP id o76so8273936pfi.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OuwU0PEfJ0EFDKtb/spwbkFU7+uLxLTUWpg1gdhbjfU=;
        b=ex1iVGdCsmP4ZY8L5ziS/Bes5llbHtOnwO5B5iXI1uXDQ+h2z/0HQxtoaUKo+pWc6M
         hg+hgiyqjpkX7SQ95YIby8k0kjdsYSiMmOyPH2MAYbBtn3CT/f3rMIR9HPwyBiI+0BbG
         YgwunZlnYpWISRQRZHW770NZWJdRXQrHMF5mdHeuDJvuYh3xuA26uKcFOtVXv98OHTGX
         MRWnJ7ick7ud4EtCUAwu9RVsLl5cZWZEfnUjjxKetek/Z4cLriZNthxtU3VCBL/E2T2N
         C77u3X7wgeWbwauJHXaGKyz/W1XBK0Pb/nTaKPixswupSX1t+L1kIRwxOnePXycV7eer
         Th5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OuwU0PEfJ0EFDKtb/spwbkFU7+uLxLTUWpg1gdhbjfU=;
        b=jQ/g6/oa6gHsEjQCbx9PxaecYV5ap5CdrSXseU9BM3AmX72oomg2lxAj3isNe3TMi1
         UKhLGNYHDV3lTV/RUV0nU+dU8UHXLZEpV2vaoDc6pmQTNVfrFxu2ShdnEtxON4wTEC5w
         Qqb7hLqsnxYT0DB8MQ/9gD7GrmAkhvunPMNlltpiudGD8Vp+O0+6sfhQAFwBfgFg5ICP
         ERg+cAZa4ebqEopo9DkpNBqZLIWSoepylVRtR8jBubt2cFZloOGOkuD3miBoWKHC6ZDu
         NWVi3fjjXXDSaZkDgxP/zqUZ90QQyt/3aYtyREaC1l72M28Fj4+xNda5LUuGS1S8Z2A4
         NN9w==
X-Gm-Message-State: ALQs6tAgPm8Vz5IG3T6kuuVanSlwFWbf+mAaNOFVwqN0IiEF8lf+TnZC
        osFHtuosJmqYQ6dqM2IuN6of7w==
X-Google-Smtp-Source: AIpwx497j5NWIYX7tF7kjEwuIEBSYP9hT2zshJ1g3l37RJgmGDoxWdRR/4bwM4m9LjJxgTlaY/I1eg==
X-Received: by 10.99.117.71 with SMTP id f7mr12085342pgn.204.1524594843810;
        Tue, 24 Apr 2018 11:34:03 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id g64sm37292544pfd.75.2018.04.24.11.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Apr 2018 11:34:02 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 24 Apr 2018 11:34:01 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to
 show_line()
Message-ID: <20180424183401.GA13208@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
 <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
 <20180423011726.GD78148@syl.local>
 <874lk2e4he.fsf@evledraar.gmail.com>
 <xmqqtvs15dy4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtvs15dy4.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 03:13:55PM +0900, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
> > I think when we add features to git-grep we should be as close to GNU
> > grep as possible (e.g. not add this -m alias meaning something different
> > as in your v1), but if GNU grep doesn't have something go with the trend
> > of other grep tools, as noted at
> > https://beyondgrep.com/feature-comparison/ (and I found another one that
> > has this: https://github.com/beyondgrep/website/pull/83), so there's
> > already 3 prominent grep tools that call this just --column.
> >
> > I think we should just go with that.
>
> OK.  If they called it --column-number, that might have been more in
> line with GNU grep's --line-number, but that is not something we can
> dictate retroactively anyway, so --column to match them would be
> better than trying to be consistent and ending up with being
> different from everybody else.

That sounds sensible. Let's call the new option '--column', and the
configuration options grep.column and color.grep.column to match
(instead of s/column/columnNumber/g), yes?

Thanks,
Taylor
