Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EBEE1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbcG2Sfp (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:35:45 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35117 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcG2Sfo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:35:44 -0400
Received: by mail-io0-f182.google.com with SMTP id m101so136288391ioi.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 11:35:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tFiQDN2cnrpeOp9EyrU666pVvCEv9ZmKbje+UhNAG/k=;
        b=k7H2PSOVf6p6d76XmJrTXoaecT9fw3M0VFcvwgrQdI1DQqMgXpKkgu3liUqTfiHvnh
         TWDWQUxjYxTFH/xTQOhaVsJgNnUnAtwaHoS12I1ZWBXIUh76dOq5BabZ/mdpbzO2u768
         99z2bX9qeZ0E0mN1+y7Lqd2Vk4DP31Fupx2emySxhKv5fIVPveUDRMt5ALYhToio1z51
         86xjkYVU+2BtuKIk9rx7D4JQV6pDKBqM5TIEubsx6lKeNnOmRXApFi/TfFROf0OvUgpm
         /6al5b+HPO3B79YcX19ayo6c9Uy6xnXmhGf6n6G/rhdfWaeaZdGVrnWwydELjCodWiHB
         05Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tFiQDN2cnrpeOp9EyrU666pVvCEv9ZmKbje+UhNAG/k=;
        b=mRv0s/II246Er3j+8HAje0Trj9NzUMdeNX2jgHedWR0h8BJeuPzdDAtdAwkjjv7aWq
         cHNOwTeA1xoKBJxaadzumubLVT/7UMcGpqJb4pDHDaVaSPJD/+Ka8/gCSmRDPLnPMnvT
         6eiMcyIe/NLqei3kYs413ZMSsEHVVia72wp8zvgvXUGyffECMPGZuqUvHG094dCgJNI8
         v/RdiB4oKpZF1kQPWToim0PQ2ZG2bBD8ck0g/dIrXOWfuydBd4kIsg3zoW/t10ByqPWe
         QFB3emPzedG1rXtrivjrPjIh8FnV0inzu6BEajKh04MIj6kDtvp6VSfq68E8Bzekvd8J
         /18w==
X-Gm-Message-State: AEkoouuxdsXm1eoASp2XsFZehZ/djyqHaXjMrxkwAbVZ4KLDuDnMWRjWsTiBlA6dj1DJ73nykiHsmZnHArHZ5A==
X-Received: by 10.107.159.147 with SMTP id i141mr44099180ioe.29.1469817343836;
 Fri, 29 Jul 2016 11:35:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 29 Jul 2016 11:35:14 -0700 (PDT)
In-Reply-To: <CAP8UFD3pZedUPWTj1A8q0zBGhR5ATL3CXOCxHf1_4Fuo+Uu4UQ@mail.gmail.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
 <20160627182429.31550-33-chriscool@tuxfamily.org> <xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
 <CACsJy8Bi00yBb6UPm7_x8BDnwQKCXXpOPbswKtayRofmSOstcg@mail.gmail.com>
 <CAP8UFD1SSjSGV+1e+zP4s=p+ohgSz6mct3EhPXqbde_y48ST7g@mail.gmail.com>
 <CACsJy8CT2r1MKE_bQotPzKEWi10QB81sNn6w7H23GxRkEYRFfg@mail.gmail.com> <CAP8UFD3pZedUPWTj1A8q0zBGhR5ATL3CXOCxHf1_4Fuo+Uu4UQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 29 Jul 2016 20:35:14 +0200
Message-ID: <CACsJy8C=d-PsfEuRw_XoE3=E6+2_a7Pai1oFv0pEuQsqXwsWwA@mail.gmail.com>
Subject: Re: [PATCH v8 32/41] environment: add set_index_file()
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 8:23 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Jul 29, 2016 at 5:34 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> Yeah. If the libification movement is going strong, we can start
>> converting and at some point should be able to define
>> NO_THE_INDEX_COMPATIBILITY_MACROS globally (and avoid the_index along
>> the way)
>>
>> Without that, there is a risk. I looked at 'nm apply.o | grep ' [Uu]
>> '' and I don't see any external functions that would potentially
>> access the index, except ll_merge. Again there's a good chance I may
>> have missed something.
>>
>>> So it looks like it is a very big and different project to make the
>>> current libified code be explicit about which index it is using.
>>> And by the way perhaps this other project should just remove the
>>> "the_index" global altogether.
>>
>> This is probably the way to go. But it's the boring sort of work that
>> nobody wants to do :(
>
> Do you mean that it might be a source of micro-projects for the next
> GSoC or Outreachy? ;-)

No that's what I meant by boring. This is not something to interest
GSoC candidates, and while it looks simple, sometimes it needs a good
understanding of git overall, and it's definitely not small enough for
a micro project. It's very similar to i18n-izing the code base.
Luckily Vasco Almeida came out of nowhere and did (still do) that.
There may be another Vasco somewhere ;-)
-- 
Duy
