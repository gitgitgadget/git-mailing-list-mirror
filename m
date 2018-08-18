Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501C41F97E
	for <e@80x24.org>; Sat, 18 Aug 2018 12:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeHRPcD (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 11:32:03 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37484 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeHRPcD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 11:32:03 -0400
Received: by mail-ed1-f42.google.com with SMTP id b10-v6so5927048eds.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UhyCg/RgqrYcPkWP8xyodtG0MTz/fvwMF+rvHXKNdUw=;
        b=T47tq+Nod1DyFu48/Fw4mKwGaP/lE8nt6wPlcqYMwPCgY2Anfpux3pZisnoEkuwORC
         x/gZhgODFoKX9f8Juh3X4nKF2AeZ0fSn2eMP7gogY0moB6QP9Z9G1iKLP+kCmQxJU7PP
         GLPrtaIK2oZl28feHI5WqFqfazbdN4o3MuphDgr2v77rVaTlptIm1PiZ/WUAvP8vFN9c
         lFv/S7nflDLI8Mpjks1EfsQbWrEAsCD7kNWplQTInj4PtPJor3OV4p+GbuHsXoHVy5Ap
         4qME7h415dmbMRGcLlukWRiQrdbDBewswcyRRlituzY/0qo+6MUYVygZ2fwyURGhYElK
         fJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=UhyCg/RgqrYcPkWP8xyodtG0MTz/fvwMF+rvHXKNdUw=;
        b=aNQK0bWz6SziahjmNehaho3xA/KKyZTRi1Kz4ofaKeDSagXuuGCXOM2TIX54igHLvT
         Ji0VfQusD5cVldK8sqz2rr5rkEEEaaNuENFsd8bHeyfZXn4B7LUHmZ/VcPTY6jUbPbRm
         imVmTj5UIdjnTzAcfQgn0oZV0I+EmX3r5uj8Obw8d9JWKCrKMU+seUJEonC4vPMo23bf
         jrxiRmLKPre5xm7eYiW55hBn0Vdc03WGVAjDJqsc2RtVLUPF4KiXyB23K6pjLWRNZgqm
         BsU3lKpwk2TPdEgPPe5bePAHNDefOJVlF7kOpGXH/6jyWeKP6n/4bYnxhroRW+enHJKh
         JoaA==
X-Gm-Message-State: AOUpUlERcABHdc8E0Bb8iCnxAIhLJk7vgWBDwgChPHk+Y8ORffQ2hzm9
        zxaQc3ROb4bXuDhOpfJElDY=
X-Google-Smtp-Source: AA+uWPw486ZIxxttI5yj0h+y1FjmcFLM082+jxGzX33kEphTvMKmdIIg5H7lya43sbMmE13EHcYySA==
X-Received: by 2002:a50:b045:: with SMTP id i63-v6mr47834790edd.18.1534595069595;
        Sat, 18 Aug 2018 05:24:29 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id n17-v6sm2981064edq.10.2018.08.18.05.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 05:24:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Michael =?utf-8?Q?Mur=C3=A9?= <batolettre@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bug: Distributed bug tracker embedded in git
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
        <20180818054300.GB241538@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180818054300.GB241538@aiede.svl.corp.google.com>
Date:   Sat, 18 Aug 2018 14:24:26 +0200
Message-ID: <874lfrrhfp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 18 2018, Jonathan Nieder wrote:

> Hi,
>
> Michael Muré wrote:
>
>> I released today git-bug, a distributed bug tracker that embeds in
>> git. It use git's internal storage to store bugs information in a way
>> that can be merged without conflict. You can push/pull to the normal
>> git remote you are already using to interact with other people. Normal
>> code and bugs are completely separated and no files are added in the
>> regular branches.
>
> I am a bit unhappy about the namespace grab.  Not for trademark
> reasons: the Git trademark rules are pretty clear about this kind of
> usage being okay.  Instead, the unhappiness comes because a future Git
> command like "git bug" to produce a bug report with appropriate
> diagnostics for a bug in Git seems like a likely and useful thing to
> get added to Git some day.  And now the name's taken.
>
> Is it too late to ask if it's possible to come up with a less generic
> name?

Wouldn't we call such a thing "git-reportbug", or "git gitbug", with
reference to Debian reportbug or perl's perlbug?

Addressing the more general issue, if we're concerned with 3rd party
tools usurping the core namespace trying to convince individual authors
of 3rd party tools to change the names of those tools to something more
unique is pissing in the wind.

That's never going to make a dent in the vast amount of git-whatever
tools, most of which won't be discussed as ideas on this mailing list
before they're released.

I think we basically have these options:

1) Accept the status quo where people do create third party tools, much
   of which are way too obscure to matter (e.g. I'm sure someone's
   created a tool/alias called range-diff before, but we didn't
   care).

   If those tools become popular enough in the wild they get own that
   namespace, e.g. we're not going to ship a "git-annex" or "git-lfs"
   ourselves implementing some unrelated features (re parallel on-list
   discussion; "git annex" could also be a "git commit --amend" alias).

2) #1, but hope we catch new tools early enough to convince their
   authors to change the names.

3) Make some structural change to git where only things we ourselves
   compile get to be called as "git <whatever>", and you'd need to call
   e.g. "git-bug" as "git ext::bug" or something. We'd need to have a
   large hardcoded list of older tools (lfs, annex, ...) to grandfather
   in if we went for this approach.

I think we should just go for #1, and if we're concerned about #1 not
being OK we really need something like #3, because #2 isn't going to
work.

> Separately from that, I'm happy to see progress being made in the
> distributed bug tracker world; thanks for that!
>
> Thanks,
> Jonathan
