Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838D01F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfFMRwl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:52:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35099 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfFMRwl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:52:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so11060607wml.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WeTcgrFm1RQETNGuZdBGdKgq0oHRumvmVfYfnjUunzY=;
        b=ZwUKIX1QHvf0pZUyDwxG3H5WG4+nzBc5Wcm7MDzdGRzy44RhZvfYT8uj7x8CKOmZjt
         JYL49Tc532m9ADwL6sQ9cjeWyNo9Yz3q6AZrONHXRXnv1MDv5caZ9qcRhfq9aqB2XUj4
         bzBNlCpIyCjebpgGaeB1+JiqBWHEP+NN1ACmVIsJygYWz3bvciSSsaHF+gsTCcF7Taz6
         gugYGRt2jGJXx8dcnlYApdv4ySu/DUnsKVrZFiDzoWGODHyiaXclyk9NHBkc+UlfXufz
         C2S9gAkKvpcBgwXyAQ5Dqrs63P5z5LdZZTnA7kU99crZy08yQZA+jhzKl5ee+kQ2uHOv
         JvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WeTcgrFm1RQETNGuZdBGdKgq0oHRumvmVfYfnjUunzY=;
        b=AxsCb2Rd63gxhWrR5aif8wuASoy8SlGShVNmHGh/NunBtCf5F87BSgGUSsGLmURuk4
         cjU8hRSl5nu6M9LNdLH5dkFtqBWx/zr19/beKwDZxoFtrmg0c49yynJVS8HWAQyJK1/V
         FQ5ZAJZKyC5sbAYEp9WEkDTOwNYOXypKMeDT297ilawxwar7zXsZWrtWggSvyUKKx9Yc
         6z7o7Y0AOmi8tiC/RNzHt0Wm0Q9vXDqsdvJ31bOnFc/lRxH4lXRCSiiQQjbEUXtXs3mk
         vtbejanrW2METlnCqbgvUwUjs/Zs4/BmLm+Pz6klvzVFW3M58ZkbPhM4ucIkHohfhZL1
         15yQ==
X-Gm-Message-State: APjAAAV8TqyHLHe2cSDqIVXqG16mXFHy/o9cYnlmubVwEJ1sSq6/f4q7
        jxZyFKjbjxxUaaQydP0ISA4=
X-Google-Smtp-Source: APXvYqykKOSMKWNAk5Z+MFIsJErKYTy+YbYwA+pCeFAkT4kJwbNGGVeex8HjkWcB85gxvz7+05rshg==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr4499579wmg.69.1560448359784;
        Thu, 13 Jun 2019 10:52:39 -0700 (PDT)
Received: from szeder.dev (x4dbd2f68.dyn.telefonica.de. [77.189.47.104])
        by smtp.gmail.com with ESMTPSA id x4sm476922wrd.46.2019.06.13.10.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:52:38 -0700 (PDT)
Date:   Thu, 13 Jun 2019 19:52:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
Message-ID: <20190613175236.GF31952@szeder.dev>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org>
 <20190609092259.GB24208@szeder.dev>
 <20190613171913.GA14055@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613171913.GA14055@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 01:19:13PM -0400, Jeff King wrote:
> On Sun, Jun 09, 2019 at 11:22:59AM +0200, SZEDER Gábor wrote:
> 
> > So, 'test oidmap' from the previous patch prints the value we want to
> > check with:
> > 
> >     printf("%u\n", sha1hash(oid.hash));
> > 
> > First, since object ids inherently make more sense as hex values, it
> > would be more appropriate to print that hash with the '%x' format
> > specifier, and then we wouldn't need Perl's hex() anymore, and thus
> > could swap the order of the first four bytes in oidmap's hash without
> > relying on Perl, e.g. with:
> > 
> >   sed -e 's/^\(..\)\(..\)\(..\)\(..\).*/\4\3\2\1/'
> > 
> > Second, and more importantly, the need for swapping the byte order
> > indicates that this test would fail on big-endian systems, I'm afraid.
> > So I think we need an additional bswap32() on the printing side, and
> > then could further simplify 'test_oidhash':
> 
> I agree with all your points about using hex and pushing the logic into
> test-oidmap.c. BUT.
> 
> At the point where we are normalizing byte order of the hashes, I have
> to wonder: why do we care about testing the hash value in the first
> place? We care that oidmap can store and retrieve values, and that it
> performs well. But as long as it does those things, I don't think
> anybody cares if it uses the first 4 bytes of the sha1 or the last 4.
> 
> I know there are testing philosophies that go to this level of
> white-box testing, but I don't think we usually do in Git. A unit
> test of oidmap's externally visible behavior seems like the right
> level to me.

That's a good point...  but then why does 't0011-hashmap.sh' do it in
the first place?  As far as I understood this t0016 mainly follows
suit of t0011.

