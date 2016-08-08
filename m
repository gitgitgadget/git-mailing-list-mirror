Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7E72018E
	for <e@80x24.org>; Mon,  8 Aug 2016 16:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbcHHQVX (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 12:21:23 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35356 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbcHHQVW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 12:21:22 -0400
Received: by mail-wm0-f41.google.com with SMTP id f65so126781628wmi.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 09:21:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=by3g3KQeeln/C6ofwOVqTH6UtUdLA+UnIVGW7lc0PlQ=;
        b=hmgKVSZGMgUFWC03VzXEfKtFcAeG+a9KzmZIgsICqveYDNQOlCOopoZNfuvgPLHhO9
         3ewQAk/dBTAcK2CUN7gdpd9sErlQXRY8UPaI+Z18k1HNM935YyxYHb+oU2uwJcBj32UA
         v1MYvfuIU/cNKnAyIdROgYnRyaobhNA3MPcgPK07GFbwc+/cKvsMajz8WXeAfoJqwdr8
         Szufkoti2YaRKuFTtyCJfsf/HfdqtaHPciTCKsy/DT8GhZdb5WBAH0kSKdf6QqpbjIMm
         wN746lYILISPvk/4MyNtJ0aZ27Gkow4QTlXV/xMe0a2OpJLfm4ag43V+IZl/mlvrmSOl
         i2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=by3g3KQeeln/C6ofwOVqTH6UtUdLA+UnIVGW7lc0PlQ=;
        b=XhJ34RuDWZYv/Q+HLWATr7JGGKcBNPXMOzuPVjzCF+hq8GVPl7t6RS341s5VLyx9ns
         qb1Vn29HcaYe9p9hvwzr0t0xcstfWaO0F8w1x28w49pKVn/5Q0Z+0gM8wCbW/R2haoVz
         HqZL0wHMoJjOaTQUDcwByUU1fCBWEYfYiSnmY5Go93mvt+js5qtPv4cfoWTkmN7CA0Vh
         Gg3aDOAlUfZ9x7K619P3XLMeCp5fUsE2Fnez4gvms09R49YVGrNJJfb0x+q09GNiFCRW
         rWEd0wn1HHNqGyLR2D/8l6B5dRRmpzRgOHFIX0haMzIsd8/EYtoCoNsieDp0ExZzd8hx
         jpFw==
X-Gm-Message-State: AEkoouv1VPYMS9R27m1hDXDDfUi2RCqGnidzL/3T4SawYNUSK/gl709qbpZZS9XpxtCsJQ==
X-Received: by 10.28.69.203 with SMTP id l72mr15934993wmi.51.1470673280530;
        Mon, 08 Aug 2016 09:21:20 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id c8sm33674079wjm.19.2016.08.08.09.21.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 09:21:19 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160808150255.2otm3z5fluimpiqw@sigill.intra.peff.net>
Date:	Mon, 8 Aug 2016 18:21:18 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 7bit
Message-Id: <6D2101A9-2D01-47E8-9DFF-6C85DED4269D@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de> <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com> <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net> <87D4BF17-67BB-4AFA-9B27-40DBB44C0456@gmail.com> <20160806121421.bs7n4lhed7phdshb@sigill.intra.peff.net> <A07BE78B-5A5D-41F1-A51B-5C71F3E86CCF@gmail.com> <20160808150255.2otm3z5fluimpiqw@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 08 Aug 2016, at 17:02, Jeff King <peff@peff.net> wrote:
> 
> On Sat, Aug 06, 2016 at 08:19:28PM +0200, Lars Schneider wrote:
> 
>>> I dunno. It's not _that_ big a deal to code around. I was just surprised
>>> not to see an up-front status when responding to a request. It seems
>>> like the normal thing in just about every protocol I've ever used.
>> 
>> Alright. The fact that it "surprised" you is a bad sign. 
>> How about this:
>> 
>> Happy answer:
>> ------------------------
>> packet:          git< status=accept\n
>> packet:          git< SMUDGED_CONTENT
>> packet:          git< 0000
>> packet:          git< status=success\n
>> ------------------------
> 
> I notice that the status pkt-lines are by themselves. I had assumed we'd
> be sending other data, too (presumably before, but I guess possibly
> after, too). Something like:
> 
>  git< status=accept
>  git< 0000
>  git< SMUDGED_CONTENT
>  git< 0000
>  git< status=success
>  git< 0000
> 
> I don't have any particular meta-information in mind, but I thought
> stuff like the tentative "size" field would be here.
> 
> I had imagined it at the front, but I guess it could go in either place.
> I wonder if keys at the end could simply replace ones from the beginning
> (so if you say "foo=bar" at the front, that is tentative, but if you
> then say "foo=revised" at the end, that takes precedence).
> 
> And so the happy answer is really:
> 
>  git< status=success
>  git< 0000
>  git< SMUDGED_CONTENT
>  git< 0000
>  git< 0000  # empty list!
> 
> i.e., no second status. The original "success" still holds.

OK, that sounds sensible to me.


> And then:
> 
>> Happy answer with no content:
>> ------------------------
>> packet:          git< status=success\n
>> ------------------------
> 
> This can just be spelled:
> 
>  git< status=success
>  git< 0000
>  git< 0000   # empty content!
>  git< 0000   # empty list!

Is the first flush packet one too many?
If there is nothing then I think we shouldn't
send any packets?!

I agree with the remaining two flush packets.


>> Rejected content:
>> ------------------------
>> packet:          git< status=reject\n
>> ------------------------
> 
> I'd assume that an error status would end the output for that file
> immediately, no empty lists necessary (so what you have here). I'd
> probably just call this "error" (see below).

OK!


>> Error during content response:
>> ------------------------
>> packet:          git< status=accept\n
>> packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
>> packet:          git< 0000
>> packet:          git< status=error\n
>> ------------------------
> 
> And then this would be:
> 
>  git< status=success
>  git< 0000
>  git< HALF_OF_CONTENT
>  git< 0000
>  git< status=error
>  git< 0000
> 
> And then you have only two status codes: success and error. Which keeps
> things simple.
> 
> There's one other case, which is when the filter dies halfway through
> the conversation, like:
> 
>  git< status=success
>  git< 0000
>  git< CONTENT
>  git< 0000
>  ... EOF on pipe ...
> 
> Any time git does not get the conversation all the way to the final
> flush after the trailers, it should be considered an error (because we
> can never know if the filter was about to say "whoops, status=error").

Right. I agree with the protocol above and I will implement it
that way.

There is one more thing: I introduced a return value "status=error-all".
Using this the filter can signal Git that it does not want to process
any other file using the particular command.

Jakub came up with this idea here:

"Another response, which I think should be standarized, or at
least described in the documentation, is filter driver refusing
to filter further (e.g. git-LFS and network is down), to be not
restarted by Git."

http://public-inbox.org/git/607c07fe-5b6f-fd67-13e1-705020c267ee%40gmail.com/

I think it is a good idea. Do you see arguments against it?

Thanks,
Lars
