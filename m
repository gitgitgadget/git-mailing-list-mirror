Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001A72031F
	for <e@80x24.org>; Thu,  9 Mar 2017 20:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdCIUZP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 15:25:15 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35718 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdCIUZN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 15:25:13 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so3404769pge.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LukEgK0Qlqt99bsa5/vZALZwFYlJEfhJDT/GK+hM4IY=;
        b=qn5kawbCNjcOIEyKcvblZX20Y5/YQPWYZqDgqUxhxfh0MlT+8LPO1g7LVkcK2iuOvn
         bW12oqwcHT00VRtgXIy0aaZrs0pFRnzDJRBUitQUDnjMds3nbkXu1hF1qbvmcUZMuFqa
         DE7HQXILCkojEdDDqwmt2vZmwnNwioYrIndIRPzv+TqNFKH9qCye/uGqtVt+SqAqNx1H
         ZukSL1ZoaPQEzvmw1ef1mA6B4VjfZzmIJ14UQIRgp+M7YNaO+bQVHE4gz17FLpYfbRip
         m0HvFlG7ykCYW6tONlZ/85D3BaQzhnvhwKrKHkHA6SxqoEC44SnAMoWKmwuoBEo7ElqF
         k1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LukEgK0Qlqt99bsa5/vZALZwFYlJEfhJDT/GK+hM4IY=;
        b=Tgn5Cd0HFt/GwN2D6f9uL+hkGKVqK6rOB4kPFZooS17P+hSoVU2+ILsmjOaYDKOUQq
         27+ByrfItbiY127R0PmFIXnhqp3ZH5tAG9/zM7qb0qL8s9HnY9QZK905eLGtibyrHbiY
         4EX3CMyyz8NoxKCMGGcy4HBDvOwSJTgjXa4yHj9KamuPOhIJNorYYjf2t7uZ3l6ZjptU
         AUxqfO9RRqyQAtTc0Yrd8YFaGXsNXz2XRYDS2O93KSIIVKfnOjDvop8NMhvrWNIgG28R
         W04qZLRd7Cb4/dW/OGf43FCcoA+THHYJJKVLxaQe83RmQiXdX9ir/ZyZDmMU+9tNBHnx
         gI8w==
X-Gm-Message-State: AMke39lVprjhyuCGvcSksaQ36YJ/LodkdpNcJFwWfojomBqnm0aLgJK7I1HmZLvFNJRN3w==
X-Received: by 10.84.216.93 with SMTP id f29mr19929439plj.10.1489091080347;
        Thu, 09 Mar 2017 12:24:40 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:b074:1559:4f91:9f93])
        by smtp.gmail.com with ESMTPSA id r134sm14104463pfr.83.2017.03.09.12.24.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 12:24:39 -0800 (PST)
Date:   Thu, 9 Mar 2017 12:24:08 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170309202408.GA17847@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Shawn Pearce wrote:
> On Mon, Mar 6, 2017 at 4:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Alongside the packfile, a sha3 repository stores a bidirectional
>> mapping between sha3 and sha1 object names. The mapping is generated
>> locally and can be verified using "git fsck". Object lookups use this
>> mapping to allow naming objects using either their sha1 and sha3 names
>> interchangeably.
>
> I saw some discussion about using LevelDB for this mapping table. I
> think any existing database may be overkill.
>
> For packs, you may be able to simplify by having only one file
> (pack-*.msha1) that maps SHA-1 to pack offset; idx v2. The CRC32 table
> in v2 is unnecessary, but you need the 64 bit offset support.
>
> SHA-1 to SHA-3: lookup SHA-1 in .msha1, reverse .idx, find offset to
> read the SHA-3.
> SHA-3 to SHA-1: lookup SHA-3 in .idx, and reverse the .msha1 file to
> translate offset to SHA-1.

Thanks for this suggestion.  I was initially vaguely nervous about
lookup times in an idx-style file, but as you say, object reads from a
packfile already have to deal with this kind of lookup and work fine.

> For loose objects, the loose object directories should have only
> O(4000) entries before auto gc is strongly encouraging
> packing/pruning. With 256 shards, each given directory has O(16) loose
> objects in it. When writing a SHA-3 loose object, Git could also
> append a line "$sha3 $sha1\n" to objects/${first_byte}/sha1, which
> GC/prune rewrites to remove entries. With O(16) objects in a
> directory, these files should only have O(16) entries in them.

Insertion time is what worries me.  When writing a small number of
objects using a command like "git commit", I don't want to have to
regenerate an entire idx file.  I don't want to move the pain to
O(loose objects) work at read time, either --- some people disable
auto gc, and others have a large number of loose objects due to gc
ejecting unreachable objects.

But some kind of simplification along these lines should be possible.
I'll experiment.

Jonathan
