Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851391F858
	for <e@80x24.org>; Tue,  2 Aug 2016 10:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbcHBKWJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 06:22:09 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36192 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbcHBKWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 06:22:07 -0400
Received: by mail-wm0-f43.google.com with SMTP id q128so403038689wma.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 03:22:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7uHilIh18RcZfZj48/aukKlpYT/Sy+2hUMO0waQa0Vo=;
        b=mwvydrvSSBY3XFZ60WMVo5H4bp7GZteWadJwI4p33ID6zNn8uNyyjuOVdmAiaeCLuz
         XmDfdXnRrm7BxT53H3c2YrX2hahuDyNBIcE6mcloI/T/loWN9dyZNSIZ6R1np+POOm/v
         xv+z1ATc3I1WIumAD6ccVfW8VMy9sBXtWWpXhAJ9wzV1bTPK/1MtKx1h3z22vWaHOoVX
         d3G+p6Natzn6ILezKO3OxFNZfm6+VL+pC9s3Uyn/uxyE4uZom/yXuqoUj0OOqp3Bm5eY
         6s+1ECUfHV6qgemFYpZm87v40XkU4A4uIrITvVu6gAsnGmewvINvnHM67M0V4AIkUFDT
         uHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=7uHilIh18RcZfZj48/aukKlpYT/Sy+2hUMO0waQa0Vo=;
        b=OaTbb+eK+lpWSJCoIihl4o+CaQlsKV/mDczNKe8orxdyNJjUp8gJKBtgJZu3H8YRfV
         tq6Uu/PlyCuf2McOb4sCG63rgCYCat2eeaVgDBC5Sq6DwB7tjRCz9Zp/c9OgTa9NNLyA
         87TlW2hWCPD8/JQzh2I0VXMwymftZwxzuVBvYZlO1Km0ydb8QUFwApYwB/uRv7VLGAxM
         wuE2bNEZuEZ+gUQaJoW9Zgwv0PJY+uUmFdXSLQyN3CruP+5TcEVoqBZlj1seyw33iP5r
         zAATKgdx2UJ80aCKHK9sUHQCy+6N8MpMBk7kzyWsPd6XTkpVoq1jKGF8u6rIkYomdCUJ
         I5NQ==
X-Gm-Message-State: AEkoouvHNxgPRxg0aivhCDYXfsPO7m6+FVC2GQej385z8SSm0hhYOMCbYIcnzsMD7m16kw==
X-Received: by 10.194.114.194 with SMTP id ji2mr55640688wjb.33.1470131481275;
        Tue, 02 Aug 2016 02:51:21 -0700 (PDT)
Received: from [192.168.1.26] (enr64.neoplus.adsl.tpnet.pl. [83.20.7.64])
        by smtp.googlemail.com with ESMTPSA id s184sm21201803wmb.11.2016.08.02.02.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 02:51:19 -0700 (PDT)
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
To:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20160729161920.3792-1-kcwillford@gmail.com>
 <20160729161920.3792-5-kcwillford@gmail.com>
 <xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608011055180.149069@virtualbox>
 <xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
Cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <8ec80c21-5ab1-d806-d8d6-e7180be00670@gmail.com>
Date:	Tue, 2 Aug 2016 11:50:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 01.08.2016 o 22:11, Junio C Hamano pisze:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Fri, 29 Jul 2016, Junio C Hamano wrote:

>>> These error returns initially looks slightly iffy in that in general
>>> the caller of any_cmp_fn() wants to know how a/b compares, but by
>>> returning error(), it always says "a is smaller than b".
>>
>> I am to blame, as this is my design.
>>
>> And yes, it is kind of funny that we require a cmpfn that returns <0, ==0
>> and >0 for comparisons, when hashmaps try to avoid any order.
> 
> Perhaps hashmap API needs fixing in the longer term not to call this
> type hashmap_cmp_fn; instead it should lose cmp and say something
> like hashmap_eq_fn or something.

The problem is that one expects hashmap_cmp_fn() to return ==0 on equality,
while one would expect for hashmap_eq_fn() to return true (==1) on equality.
So we would have to rewrite all calling sites.

It would be nice to have a comment about how hashmap uses cmpfn in
hashmap.h.  


Though... currently our hashmap implementation uses linked
list (separate chaining) for handling hash collisions (for collision
resolution). More sophisticated data structures, such as balanced search
trees, or splay trees, are worth considering only if the load factor is
large, or if the hash distribution is likely to be very non-uniform,
or if one must guarantee good performance even in a worst-case scenario.
So almost certainly comparing function (which is needed for trees)
won't be needed.

Best,
-- 
Jakub Narębski

