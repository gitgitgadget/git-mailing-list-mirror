Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F881F424
	for <e@80x24.org>; Tue, 24 Apr 2018 04:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDXE1o (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 00:27:44 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:37913 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeDXE1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 00:27:43 -0400
Received: by mail-pf0-f169.google.com with SMTP id o76so6449954pfi.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hB3xtOx9tq7pK6khb/B7xFS67+z+TjkCkqPD/UxFNAk=;
        b=rSrVjeYthh8vLJnW6b4AAsTU4jBf6yd1CEfHa0N1Ct9HqYYaYbnZBQ0qFt3G7Zu80j
         ofvc0n2qgtC1TCa5XelauB9wTlUX40G21Kxo1KbVTcoX0/o9jT+SWnO2o0O+DfAOyT2J
         eKDrQ/wRtc1asbHz07A+L6/Z4oGr5kxUHfH8fjeJ6RecpNWfFurA8VMFUf/fNMpsn/y1
         +PgRTpUhGAvAOgOLbl70xJ8uERxkic08AFyfYQMZmlFRgq09P0c0nNXavG9bOCLkNVRM
         ZZC4J+tw90UzU+RwAKRG0e7fpHJxgKPw+kSUtasy09OoremvK37YqcFgjtvxtytGgRRT
         x9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hB3xtOx9tq7pK6khb/B7xFS67+z+TjkCkqPD/UxFNAk=;
        b=g1aRN569aFJg5SrHiHw7sy24raw0C5g9vZATcEmI0dGiH7eYILwLEHGc+CcaGYVIAA
         N5duVjCMe98iNponuIaBshMedLdXwe9kApjGPzJIbae/ahU6/rKXeIj49TkWsGyOgvd7
         fyopBEzjG1QRelPX/+xU/AlHAwhydoMdLwhv6lGU/qZ3cIoD9dePKLcTpEgcsrzBoK1+
         JJ6CNAe6cPjx4HHLlk6NqhZua/Kd4GG2QsNpno6vi4Gk9j+WBLLOTq3frZERk3Fuz2GV
         LYY2/njYgoWc1f+37pxA5FcCnwp07kQxox4C3ya4dJe7fifUNPuPLvECfC5VxpEGxd58
         ul6A==
X-Gm-Message-State: ALQs6tCc9E2GTvk7OG0t6psySG7t1AODiBsSGlS7MGPKl4KE2tBgCLW8
        aQB+9XYTd6/cAiw2+O5dlG573Q==
X-Google-Smtp-Source: AIpwx4/dEIiEe6Y1rc/uMU03w3f5j28zfZqxEMI2yt1cLsBAhblqwD7m40zeQyCCItUIel8NXaMjtA==
X-Received: by 10.99.109.132 with SMTP id i126mr19085341pgc.414.1524544062541;
        Mon, 23 Apr 2018 21:27:42 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id m65sm31541409pfg.135.2018.04.23.21.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 21:27:40 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 23 Apr 2018 21:27:39 -0700
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to
 show_line()
Message-ID: <20180424042739.GA82093@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
 <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
 <20180423011726.GD78148@syl.local>
 <CAPig+cR0dP2Hrb4JhuqmCNFzDPoy7KdqYX3irso6mKdmh9Y4VQ@mail.gmail.com>
 <87604ie61h.fsf@evledraar.gmail.com>
 <CAPig+cRXkSrPHPyEEhp6_ndRBNW3hE7HkspSk1atPSE5pn_sMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRXkSrPHPyEEhp6_ndRBNW3hE7HkspSk1atPSE5pn_sMw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 03:34:21AM -0400, Eric Sunshine wrote:
> On Mon, Apr 23, 2018 at 3:27 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > On Mon, Apr 23 2018, Eric Sunshine wrote:
> >> One important issue I noticed is that patch 3/7 neglects to update
> >> grep.c:init_grep_defaults() to initialize opt.color_columnno.
> >
> > I think this is fine for fields that are 0 by default, since the struct
> >  is already zero'd out. See my e62ba43244 ("grep: remove redundant
> >  double assignment to 0", 2017-06-29) for some prior art.
>
> Indeed, I wasn't worried about opt.columnnum, which is fine being
> zero'd out by the memset(). What I was concerned about was
> opt.color_columnno; the corresponding opt.color_lineno is handled
> explicitly in init_grep_defaults():
>
>     color_set(opt->color_lineno, "");
>
> I'd expect opt.color_columnno to be treated likewise.

I agree with Ævar and Eric, we should certainly zero-out
opt->color_lineno in grep.c's init_grep_defaults().

I recall doing this in v1, but I think that I must have dropped this
part of the patch on the floor. In either case, I have amended my local
copy to include this color_set() invocation and will include it in v3
(which I hope to send later this evening).


Thanks,
Taylor
