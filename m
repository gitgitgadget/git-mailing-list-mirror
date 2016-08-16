Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535E42018E
	for <e@80x24.org>; Tue, 16 Aug 2016 18:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbcHPSuN (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 14:50:13 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:36977 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbcHPSuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 14:50:12 -0400
Received: by mail-it0-f52.google.com with SMTP id f6so75400389ith.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 11:50:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r/ZWbVnYUzPD219G1JzFaGelN2D96yhOXDoroYzMh0k=;
        b=N3z+wEemDDymKtzAoWfw1LD7K5fvblmdn8OeKnUml1EzZ1Vhmq4qQc00bv9RLISwr2
         XabK7H0Ynt5+zXygbxHVsrpJqaFgxp16kKJHg7nK3lNePnGyi+LCxz2wm1YQj5VeB1zb
         0pTzllSmARzGZ1iWXuEzwwJPXkIalfxxUPu3+4l1608XKmraj9bQ4nqc8rlai3cO+jO5
         E5FIkWzs7kgI8/vvg9s3OZ4L7y5CFipOCBtM54DZrsTeIHQpEwC1orROws2Wcxzc318E
         w7KXdkTTnVL7dFyPcz5NeSVUAyl5ik4qywzl7PnwAwiTqRcXMBllvA5FHBrxpUbxC1b/
         aRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r/ZWbVnYUzPD219G1JzFaGelN2D96yhOXDoroYzMh0k=;
        b=UZxGi81J++wOuxHPVx/1b4w3g15QFM5ECFvzwgGS0Y3xUgGBxcjXs3hnTWhZ3IIrr4
         AOsTNz9LgJE8HFWTdtpSjuAjR963bsPLnVIw3//CZyYRXmqyqAiwsC2AW7Df14KAOBdk
         vOjWNF6whtOLqu7x9HeH4xuRD3v9vyq3nWi04q+2Jyi8heb3wPjAyzA2DXRRyJf8FzNl
         eMeSL+pDV4x94e6tOtyWPio1P2uypjQMNgzCxptgTb3cbwpB5HAW61suPvGumz4z54wc
         kd02sNTKPbgG+MggYbLGgLlrIaCk6Eo5slIiVIkVBQOosImrTKKrek2dB5wFpaXltW+l
         mYxA==
X-Gm-Message-State: AEkoouvwdp/5RUfBrTY8zLYJ1hY6rPGWBPfpYDNCx9mVn5+QACa0EtxvKaqtlhIED+HnMGc++MiGh1m4o7I2/BjU
X-Received: by 10.36.228.138 with SMTP id o132mr22545537ith.49.1471373411654;
 Tue, 16 Aug 2016 11:50:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 16 Aug 2016 11:50:11 -0700 (PDT)
In-Reply-To: <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
References: <20160816161838.klvjhhoxsftvkfmd@x> <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x> <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 16 Aug 2016 11:50:11 -0700
Message-ID: <CAGZ79kZ7dzh6AhQRQZsEFdWB4MQxW431yfDuEXao=k_meNE8Nw@mail.gmail.com>
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
To:	Jeff King <peff@peff.net>
Cc:	Josh Triplett <josh@joshtriplett.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 16, 2016 at 10:34:44AM -0700, Josh Triplett wrote:
>
>> > Sadly you cannot use a capability to fix that, because all of this
>> > happens before the client agrees to any capabilities (you can find
>> > discussion of a "v2" protocol on the list which solves this, but it's
>> > sort of languishing in the design phase).
>>
>> As a potential 1.1 version, which could work in a backward-compatible
>> way with existing servers and no additional round-trip: what if, in the
>> smart HTTP protocol, the client advertised client capabilities with an
>> additional HTTP header (e.g.  "Git-Client-Caps: symrefs othershiny
>> featurenames"?  git-http-backend could then pass those capabilities to
>> git-upload-pack (--client-caps='...'), which could take them into
>> account in the initial response?
>>
>> That wouldn't work as a single-pass approach for SSH, since the client
>> can't know if the server's upload-pack supports --client-caps, but it
>> would work for the smart HTTP protocol.
>
> You can dig up the discussion on the list under the name "protocol v2",
> but basically yes, that approach has been considered. It's a little
> gross just because it leaves other protocols behind http (and it is not
> necessarily a good idea to push people into http, because it has some
> fundamental drawbacks over the other protocols because of its
> half-duplex nature).

Some more thoughts on protocol v2 (the good parts to be attributed to
jrnieder@gmail.com):

* In case of http we can use the http header and know information
  about the client, i.e. if it may support the following ideas:

* Instead of introducing a new protocol we introduce a capability\
  "resend-ref-advertisement" and only advertise very few refs (e.g.
  only the branches, not the pending changes in case of Gerrit)

* The client can then ignore the refs advertisement and ask for a resend
  of the refs with more specification,
  e.g. "want refs/heads/*", so allowing more than just sha1s in the
  want line but complex things like branch patterns.

>
>> > That should Just Work over the existing http protocol without requiring
>> > an extra request.
>>
>> It'd require one extra request for git ls-remote, which normally doesn't
>> need the second round-trip, but that still seems reasonable.
>
> Good point. I don't think there's an easy way around that short of v2 or
> v1.1 that you mention above. I agree it's probably reasonable, though.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
