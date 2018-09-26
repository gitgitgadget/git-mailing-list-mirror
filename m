Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7C41F453
	for <e@80x24.org>; Wed, 26 Sep 2018 13:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIZTxB (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 15:53:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38423 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeIZTxB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 15:53:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so8831039pgr.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CYVtVkvKiCoQsMEKyTwA8s92/HhKOTFJ+5kwwKDIxko=;
        b=nfkDNlJFNmT3BiqytilzYEKq2ObOHMqbFHCPwBRqUT64J5L9NX3LQk8V1fVYMgYwJQ
         NOJO3VDZIQS5chxJRLoGDtHqdHX4cbGseW/HQ0UB65eLM/1+avS3nXIiz/SGVaHs8dGm
         +siTrrh9fznvcq9AdvPtYAQd4m/BgksOSbnBqgv4AROs1UPwaTwMccvZzDiMHp5Z/qWb
         93fVOF4TBNjNO9XUtuVLRnDssIzTI88/fcI64F6q0cpW7UDtkLiv/guJL/5ORxfsjgXU
         hTdDvpeSGBQkKWXXJhTkz4NKhCbxqdf1bmTEgAuMfLdJ6ZtRkrvAqI97iPlPClJ7gfZZ
         0b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYVtVkvKiCoQsMEKyTwA8s92/HhKOTFJ+5kwwKDIxko=;
        b=pqAtfjoujSbBiSdy9xpazflYaEeSbkcNsk2r3bqL5B/nLkdDUU0D17et02px9I3ASx
         HDiRiDem/ysK5EBvOpzjmDMe1I5KnHmplibcq4MO1LRJH2CWkOL42EXGUZb3VZYfGtUJ
         YAzWUOuE7nVpOhQMEpLJprRkMTDCdHpJJhTxjCS7xF2+LsoQuJZr3uXPHk4FbgHgxqT3
         9VzviO1VQA2hZEoB19XkPbL5BIe7HkX0UHqHGVCeDuBV2SxBtPdz52J8HMaeor6By1Zf
         8rwDw0xukd2fX/gLE1/Q4EN9dK4jPJv8tr04LSLrGpaYWcpWGVE2Db0RyszpE2Aei9YJ
         I1yQ==
X-Gm-Message-State: ABuFfohhdztIhCpdXNed6Zvh/SoLOxj4Y0LWHxbp23/CS7eRSJcb0b0c
        WnyJP6XXz1x3c5Qx87UMiwVruQ==
X-Google-Smtp-Source: ACcGV63lZofrzspiDOOM0vllWk5MGnyXtJ3S85KYQN3/w8ysd/KKi+j06DQ0Z5LPVM02sv8XsRseOw==
X-Received: by 2002:a62:ff09:: with SMTP id b9-v6mr6401923pfn.46.1537969199689;
        Wed, 26 Sep 2018 06:39:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id t84-v6sm10876772pfj.7.2018.09.26.06.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:39:58 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 26 Sep 2018 06:39:56 -0700
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926133956.GA25697@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <20180922180231.GD432229@genre.crustytoothpaste.net>
 <20180922195258.GA20983@sigill.intra.peff.net>
 <20180926010935.GK4364@syl>
 <20180926033337.GC32064@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926033337.GC32064@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 11:33:37PM -0400, Jeff King wrote:
> On Tue, Sep 25, 2018 at 06:09:35PM -0700, Taylor Blau wrote:
>
> > > So I think this is fine (modulo that the grep and sed can be combined).
> > > Yet another option would be to simply strip away everything except the
> > > object id (which is all we care about), like:
> > >
> > >   depacketize | perl -lne '/^(\S+) \.have/ and print $1'
> >
> > Thanks for this. This is the suggestion I ended up taking (modulo taking
> > '-' as the first argument to 'depacketize').
>
> I don't think depacketize takes any arguments. It always reads from
> stdin directly, doesn't it? Your "-" is not hurting anything, but it is
> totally ignored.

Yep, certainly. I think that I was drawn to this claim because I watched
t5410 fail after applying the above recommendation, so thusly assumed
that it was my fault for not passing `-` to 'depacketize()`.

In the end, I'm not sure why the test failed originally (it's likely
that I hadn't removed the ".have" part of 'expect_haves()', yet). But, I
removed the `-` in my local copy of v3, and the tests passes on all
revisions of this series that have it.

> A perl tangent if you're interested:
>
>   Normally for shell functions like this that are just wrappers around
>   perl snippets, I would suggest to pass "$@" from the function's
>   arguments to perl. So for example if we had:
>
>     haves_from_packets () {
> 	perl -lne '/^(\S+) \.have/ and print $1' "$@"
>     }
>
>   then you could call it with a filename:
>
>     haves_from_packets packets
>
>   or input on stdin:
>
>     haves_from_packets <packets
>
>   and either works (this is magic from perl's "-p" loop, but you get the
>   same if you write "while (<>)" explicitly in your program).
>
>   But because depacketize() has to use byte-wise read() calls, it
>   doesn't get that magic for free. And it did not seem worth the effort
>   to implement, when shell redirections are so easy. ;)

To be clear, we ought to leave this function as:

  extract_haves () {
    depacketize | perl -lne '/^(\S+) \.have/ and print $1'
  }

Or are you suggesting that we change it to:

  extract_haves () {
    perl -lne '/^(\S+) \.have/ and print $1'
  }

And call it as:

  printf "0000" | git receive-pack fork >actual &&
  depacketize <actual >actual.packets
  extract_haves <actual.packets >actual.haves &&

Frankly, (and I think that this is what you're getting at in your reply
above), I think that the former (e.g., calling 'depacketize()' in
'extract_haves()') is cleaner. This approach leaves us with "actual" and
"actual.haves", and obviates the need for another intermediary,
"actual.packets".

> > The 'print $1' part of this makes things a lot nicer, actually, having
> > removed the " .have" suffix. We can get rid of the expect_haves()
> > function above, and instead call 'git rev-parse' inline and get the
> > right results.
>
> Yes. You can even do it all in a single rev-parse call.

Indeed.

Thanks,
Taylor
