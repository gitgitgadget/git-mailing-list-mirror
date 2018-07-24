Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D85E1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeGXUJu (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:09:50 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33888 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388463AbeGXUJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:09:50 -0400
Received: by mail-wr1-f46.google.com with SMTP id c13-v6so5166115wrt.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P4teshoR8xse+7beDnjxIz20cSJNLJoJymWnuLXaxP4=;
        b=vZxTlB87tRYb1RvDmXECFXoa/B+43gjAslXILcJHVeU2bnQhzAbqzQuyOHqEhK1cDz
         ZeF4v2emGtEDFyg9uFkrIT1yLs9u/6AgsJoqEVUUAKSH48ZOa1UV+XQed+wGjkHyma6L
         /kqxZgQGiqCdV1KuxMzY6HXgplPqtqw5+QxahhFhR3C2znPfwz5ttKj8eoupaE+u8SYG
         0bWZbgMZZEXP2bMNh1A4LhBuyydY9Qv55ZLhL4TenXAukLbhmLiVKnTVoUoYbvh3Jftm
         Q8OXQ6F6t73odUWKdrMKtjZ9br7H1bgcdRCFQTbuCZFt+QbXW+MSagCxUhRL0xo3EwW8
         zs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P4teshoR8xse+7beDnjxIz20cSJNLJoJymWnuLXaxP4=;
        b=tnfH9OOvaT4bHtc3XLB6QM7Fn7eCLOLi3CbT+r4rcBwQABm17IrtlKrOXTVU61vzjd
         LW0FGEKno+Z+RBVO9rDIGrHb23Ooja/GRgaHMa0+5BlRw9YQLyalMIWogKKlv+Uw5TOY
         SKcNxtYjDyTAgCWmyBYQhFdmSFMKVKTbE7PThtFO05GoTJLFId7Lod5wb4bSJQPJEP3m
         p2gCnJBWsgPriHbpBp3CW1R/xMEnIsdsEXWJdK9Im1qVq9iuTqmuZda7kmlEw9uiyVRw
         CuN6RMlyJlW6NPUeyUTBMVvSLosZFaIQQ8QRTmgwrND1J2mqL9tlTwmicPsYhYorZRsh
         2g7g==
X-Gm-Message-State: AOUpUlFR8ph5v2pQc++lsqvm1Fr3xUbxCIAAlPiLnWCrVlIJduq8UPrh
        U49F2P2aPNWzTHsCx8y+UTLcDg==
X-Google-Smtp-Source: AAOMgpcqpIrg7xODjQOhaUdJJ0KTbxrx3oSn/TFiqfEG+lwMDd+7SN8sdXLV/mSMz7M8dxDjfToAqA==
X-Received: by 2002:adf:be0f:: with SMTP id n15-v6mr13001072wrh.267.1532458917644;
        Tue, 24 Jul 2018 12:01:57 -0700 (PDT)
Received: from 0f3cdde9c159 (80-248-185-253.newhall.nsdsl.net. [80.248.185.253])
        by smtp.gmail.com with ESMTPSA id r18-v6sm1421524wmh.28.2018.07.24.12.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:01:56 -0700 (PDT)
Date:   Tue, 24 Jul 2018 19:01:36 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180724190136.GA5@0f3cdde9c159>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180720215220.GB18502@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 09:52:20PM +0000, brian m. carlson wrote:
> 
> To summarize the discussion that's been had in addition to the above,
> Ævar has also stated a preference for SHA-256 and I would prefer BLAKE2b
> over SHA-256 over SHA3-256, although any of them would be fine.
> 
> Are there other contributors who have a strong opinion?  Are there
> things I can do to help us coalesce around an option?

Overall, I prefer SHA-256.

I mentioned this at the contributor summit - so this may have been
captured in the notes.  But if not, when I look at this from the
perspective of my day job at Notorious Big Software Company, we would
prefer SHA-256 due to its performance characteristics and the
availability of hardware acceleration.  We think about git object ids
in a few different ways:

Obviously we use git as a version control system - we have a significant
investment in hosting repositories (for both internal Microsoft teams
and our external customers).  What may be less obvious is that often,
git blob ids are used as fingerprints: on a typical Windows machine,
you don't have the command-line hash functions (md5sum and friends),
but every developer has git installed.  So we end up calculating git
object ids in places within the development pipeline that are beyond the
scope of just version control.  Not to dwell too much on implementation
details, but this is especially advantageous for us in (say) labs where
we can ensure that particular hardware is available to speed this up as
necessary.

Switching gears, if I look at this from the perspective of the libgit2
project, I would also prefer SHA-256 or SHA3 over blake2b.  To support
blake2b, we'd have to include - and support - that code ourselves.  But
to support SHA-256, we would simply use the system's crypto libraries
that we already take a dependecy on (OpenSSL, mbedTLS, CryptoNG, or
SecureTransport).  All of those support SHA-256 and none of them include
support for blake2b.  That means if there's a problem with (say)
OpenSSL's SHA-256 implementation, then it will be fixed by their vendor.
If there's a problem with libb2, then that's now my responsibility.

This is not to suggest that one library is of higher or lower quality
than another.  And surely we would try to use the same blake2b library
that git itself is using to minimize some of this risk (so that at least
we're all in the same boat and can leverage each other's communications
to users) but even then, there will be inevitable drift between our
vendored dependencies and the upstream code.  You can see this in action
in xdiff: git's xdiff has deviated from upstream, and libgit2 has taken
git's and ours has deviated from that.

Cheers-
-ed
