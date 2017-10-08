Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B829A1FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 21:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdJHVlQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 17:41:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36198 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdJHVlP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 17:41:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id 131so11954383wmk.3
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tgYm3ze8D9WRnfqoX+3dPiTd8IVnfY0DefEQ+OG2j/g=;
        b=u9Fh2myI/BPtqnbfXbLe0INXOWH8tZlnT5OdpqpOAXhI18B0M87meN+SbN08IYjkbp
         0IXy/OfWXpJAUPtMwHNNBF/M6VeNL2agdURNuQH+GL5PKKe1je5LNB9N0fjC4xnB2QJo
         piBwXdVmJZJXEi/Pab7abzDPvdQkWvbXeI4yaZ3Lhrlk3j82xaOLgKD9nOTx7ekF3JVC
         hTQ6hwXue/TyfmnoF4QmY7tLODlcLyfrn4wOmOY5v6hVgfeGOMNV/AjVUz6FC+8JlMEw
         BP95qR0LUpj5O8UD5IPFx2G/Dhdi1k0mcXpDPs4qQqEhfCtX99T/pjGycKkXwsyr1XoM
         KJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tgYm3ze8D9WRnfqoX+3dPiTd8IVnfY0DefEQ+OG2j/g=;
        b=pW6gtIGFIEeyVDeh42+nBfceElu6HLOFr/m0kIWqHaIAhhIgh5mDz+QaTwk+3AEVLB
         fmVKXykpH4uxmY25btfWIov/H5P+EY7fs6KXz4i7c0f6N/y89hOhbDmM7i7NBqUcJFyz
         kJKMuFoThAASg7MdQm5FR1eQqMTj2cEWWmJhgljahWyEbyJ87W/gYc0lyjPCjjQ1Gn7S
         KEDQo8asuAKabwMOowLSREdBlib/ZUo12TXcz15BwMmTWCpEN6vJFMMF2DcHK2xXPhb+
         8UnIfJmxxQwoLGtU3cwLKlA+gV2u2A/Zlp46YZNlUS/dIaiss5RTdJKuH4b4AfCb9T8m
         jCrA==
X-Gm-Message-State: AMCzsaUjes+NKH6fJbWnkv9hsPPq76p6VF2dNoCySTqqMHeEUsz8bcTV
        /lhVawA0+rJUrRfnI/rQ054=
X-Google-Smtp-Source: AOwi7QDFNEtT+sACuxy8oYxuGZhZ+dIi5RBBYRsfeyjEFnIGQEBUMzodQ+cEgakw+jiztRhlop06Ww==
X-Received: by 10.223.139.140 with SMTP id o12mr5330023wra.78.1507498874781;
        Sun, 08 Oct 2017 14:41:14 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5615.dip0.t-ipconnect.de. [93.219.86.21])
        by smtp.gmail.com with ESMTPSA id w5sm3487630wrg.65.2017.10.08.14.41.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Oct 2017 14:41:14 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 2/2] entry.c: check if file exists after checkout
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171006045640.vihagnlnuximzmjs@sigill.intra.peff.net>
Date:   Sun, 8 Oct 2017 23:41:13 +0200
Cc:     Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 7bit
Message-Id: <C7B91A82-CB55-4435-9204-D6A8F7F640CB@gmail.com>
References: <20171005104407.65948-1-lars.schneider@autodesk.com> <20171005104407.65948-3-lars.schneider@autodesk.com> <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net> <xmqqlgkoyk8n.fsf@gitster.mtv.corp.google.com> <20171006045640.vihagnlnuximzmjs@sigill.intra.peff.net>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Oct 2017, at 06:56, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Oct 06, 2017 at 01:26:48PM +0900, Junio C Hamano wrote:
> 
> ...
>> -- >8 --
>> From: Lars Schneider <larsxschneider@gmail.com>
>> Date: Thu, 5 Oct 2017 12:44:07 +0200
>> Subject: [PATCH] entry.c: check if file exists after checkout
>> 
>> If we are checking out a file and somebody else racily deletes our file,
>> then we would write garbage to the cache entry. Fix that by checking
>> the result of the lstat() call on that file. Print an error to the user
>> if the file does not exist.
> 
> I don't know if we wanted to capture any of the reasoning behind using
> error() here or not. Frankly, I'm not sure how to argue for it
> succinctly. :) I'm happy with letting it live on in the list archive.
> 
>> diff --git a/entry.c b/entry.c
>> index f879758c73..6d9de3a5aa 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -341,7 +341,9 @@ static int write_entry(struct cache_entry *ce,
>> 	if (state->refresh_cache) {
>> 		assert(state->istate);
>> 		if (!fstat_done)
>> -			lstat(ce->name, &st);
>> +			if (lstat(ce->name, &st) < 0)
>> +				return error_errno("unable stat just-written file %s",
>> +						   ce->name);
> 
> s/unable stat/unable to stat/, I think.
> 
> Other than that, this looks fine to me.
> 
> -Peff

Looks fine to me, too.

Thanks,
Lars
