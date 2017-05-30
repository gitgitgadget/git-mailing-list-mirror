Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5815F20D0A
	for <e@80x24.org>; Tue, 30 May 2017 06:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750904AbdE3GI2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 02:08:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34137 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdE3GI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 02:08:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so15600916pfk.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yF9IF58mxoBfdlulgDjZzQwISOizCEo8+A+AAqiPLtc=;
        b=uyNBjcj+wKJgQnWBGaySil1ObQTSfQ2bd12c+uCVKSI8VBm63lduaMN3MhPBAcZUsl
         a9ExA3te8TuZefOwLmH6kc9NUP6JHO3mYxvMq9gkH5xfypvZ8SR/4UkxcXalgBmxHAyJ
         esN2Sgk6iuhTjUkAG/eFRg8okCzPDUFpqCwr6+m3TLhqYNay0Unao6jl+3IBzbLxsVtf
         YKXuajjHpOnWtnDC43Tyu/dTrV6Bd0MoI7+t6dBskFvMsRTt4epuqrc+azrwhWQIIU9y
         ufQALt7S2IV12bLV8ZqNJA3Ikdc1NqFRXLBlCuv80kXN+YCI0SykWgmqvPbclV2k2TOM
         7MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yF9IF58mxoBfdlulgDjZzQwISOizCEo8+A+AAqiPLtc=;
        b=l8HmuTnsRXYjij+ZYqLr8+Ezv4zUwKVipThCPc9Qx+Drm1Cx6iZoCVqm906+LBD1VG
         yWT1+Pfjq1K9R4mqFrIO/l1SBEcIfKx1sBghfFzESftV6aLPz8hwboP8Je6bhSDiRt2f
         EG+iptLDa9B/2waqhrmyLCI/GFr4AdR2IJGDS41AJAOoVOt/Ax0S4KS72/Taa65FezQz
         /KIIXRnK6g4uud4lMAhpj1NZeWshgRstdBraVfSyWnuKnxNN4L7V8s5t37toNsvL1ViJ
         UcYM237l2UZZt8/nYCxcZoPyY80lgqKbqiGy6iRstYBDYZHIvUU1f30hl8axLMh5Pw6I
         cniw==
X-Gm-Message-State: AODbwcD84vG0ZwMILWXxSsY0s8HCeg/ZCL/5mBobkJHyrpphrudXJ749
        7/S6Sth7r+hbIw==
X-Received: by 10.99.124.94 with SMTP id l30mr23158300pgn.55.1496124506990;
        Mon, 29 May 2017 23:08:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id z64sm21658512pfd.20.2017.05.29.23.08.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 23:08:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
        <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
        <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
Date:   Tue, 30 May 2017 15:08:25 +0900
In-Reply-To: <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 May 2017 02:05:55 -0400")
Message-ID: <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 30, 2017 at 03:03:18PM +0900, Junio C Hamano wrote:
>
>> > +test_expect_success 'generate builtin list' '
>> > +	git --list-builtins >builtins
>> > +'
>> > +
>> > +while read builtin
>> > +do
>> > +	test_expect_success "$builtin can handle -h" '
>> > +		test_expect_code 129 git $builtin -h >output 2>&1 &&
>> > +		test_i18ngrep usage output
>> > +	'
>> > +done <builtins
>> > +
>> 
>> These still seem to need further tweaks?
>> 
>>     diff-files
>>     diff-index
>>     diff-tree
>>     rev-list
>
> How so? They pass the test for me, and the output for a manual run looks
> sane.

Am I missing some patches (I have these 8) outside the series,
perhaps?

