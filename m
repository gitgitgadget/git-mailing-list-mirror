Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213C11F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeIZE4g (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:56:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44327 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeIZE4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:56:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so4606641pgu.11
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UKMsOWM6QRK6RYTsqILPOaON20HwoDEUn7TUFKW08ug=;
        b=mOnanYrQQgz08TJ95h3idoX1/VxD6vKmIpogt57riJZ1JgLKT9vZ4F/rQAosxZn7Lt
         7ZT87oxMzFud8KZvH3nhYAlYzzXcg/iDdR9s4iryzrXIU/4s6omcZ+Psj8vWu3P2Xr7R
         pJ1Z0JxT7upRgzRvzhgyZLY4ASaPs8pTLAIEkZ4dwgMY0megzSzHMl9Ql7wbxZ8yJthZ
         aummAHiMqYRtH1jQM5/hTg0yfwPszrhKXniaUT0lFqt217RhGbHdBe69R5vZ8irtVyUo
         h5W6St6g5sQuVNatT6EkN4zgEn3QlC3UVh59hpIvdQNdji1p5Ucd7wyROrKwWFt1D7YY
         HD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKMsOWM6QRK6RYTsqILPOaON20HwoDEUn7TUFKW08ug=;
        b=EvGnT0Ravw+bg1CHEYVjCkZl34NRDOZ8R/DS8oBQzACxjD9CtlrEM4ALoaR5+lioKe
         ofrINN8M5Gqym+dG4KXBR6XEYeIWmRUuj1Esp0RgxGt2097AOfXdo7kkEVkRRDMhRg84
         mSULnO+BmCaA2uNBa1KD8p0bMYyXi1yGIgQ0Pg0v8eqmVJ0JV0VssOW0kIFCCzm7HTKr
         yEa2yG061F6i9ark4Re21Tc2A1cSBkZU2BH7Ae/TEpdjUrQ6CJgTi2wJOL7pYCPknjrT
         6tYkMzG9TR9o3xsSTMTWxJqmOVnLpnwi9B6zxalBpsSvvnXoG8rl20GvM64G8rONETQJ
         yjzQ==
X-Gm-Message-State: ABuFfoig6cDnNcIlTuDUWcqX+ZL0UIG50MqA2kesp6k2TTYNPzOTng4x
        mNzFMf2qXDMHEGQmADX/6Z1VGQ==
X-Google-Smtp-Source: ACcGV63JB7kiWYcNHpNjyz50+/ECyKbx7ufts0xTM/1tlavsepQWeYtDXiQ9vOlnBjMJV71BCdhXtA==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr3109057pld.145.1537915608507;
        Tue, 25 Sep 2018 15:46:48 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id k8-v6sm10188912pga.80.2018.09.25.15.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:46:46 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:46:45 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180925224645.GG4364@syl>
References: <20180921213753.GA11177@sigill.intra.peff.net>
 <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
 <20180921221832.GC11177@sigill.intra.peff.net>
 <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
 <20180924181011.GA24781@sigill.intra.peff.net>
 <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
 <20180924205022.GA26936@sigill.intra.peff.net>
 <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
 <20180924231455.GA7702@sigill.intra.peff.net>
 <xmqq1s9hqxtt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1s9hqxtt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 10:41:18AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Right, I think that is totally fine for the current uses. I guess my
> > question was: do you envision cutting the interface down to only the
> > oids to bite us in the future?
> >
> > I was on the fence during past discussions, but I think I've come over
> > to the idea that the refnames actively confuse things.
>
> [ ... ]
>
> So, I think we probably are better off without names.

Sorry for re-entering the thread a little later. I was travelling
yesterday, and was surprised when I discovered that our "grep | sed" vs.
"sed" discussion had grown so much ;-).

My reading of this is threefold:

  1. There are some cosmetic changes that need to occur in t5410 and
     documentation, which are mentioned above. Those seem self
     explanatory, and I've applied the necessary bits already on my
     local version of this topic.

  2. The core.alternateRefsCommand vs transport.* discussion was
     resolved in [1] as "let's use core.alternateRefsCommand and
     core.alternateRefsPrefixes" for now, and others contributors can
     change this as is needed.

  3. We can apply Peff's patch to remove the refname requirement before
     mine, as well as any relevant changes in my series as have been
     affected by Peff's patch (e.g., documentation mentioning
     '%(refname)', etc).

Does this all sound sane to you (and match your recollection/reading of
the thread)? If so, I'll send v3 hopefully tomorrow.

Sorry for repeating what's already been said in this thread, but I felt
it was important to ensure that we had matching understandings of one
another.

Thanks,
Taylor

[1]: https://public-inbox.org/git/xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com/
