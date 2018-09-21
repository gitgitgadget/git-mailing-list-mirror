Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9A61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390693AbeIUXjZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:39:25 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:38553 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390365AbeIUXjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:39:25 -0400
Received: by mail-it1-f174.google.com with SMTP id p129-v6so2837138ite.3
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02TgbFW2KAycJkkT+ZTlH6agRL2ssz2ek0aNntkRKC4=;
        b=M5idlNkO9G572/zmt0QCwfXezV6ZF3kPNABbzmv7bl2vGEtVBz2vC3iYsH+cDoMFjA
         Wz7K8v4w7bQyhq/0t5hawIotYS5zzmCJJh7tcaZP8yevYTRFvth8GoMhu3OJLS2H2are
         DlOn77luh3Rsk3khYweFaKtRo47qikfGnWI2vA76V0Xmw2kHxBtvTSRsLLfSnM1dW1Sw
         jXUK1ioHNsWE1tOj0Vpk9vt9eGzWVY87iQSyIlDaA806uNwM02gQ0dpFTtzMLZ2CUmJF
         1OwxZmrawM1w6zEqAgXgqY72LiOWFcDpDcO/KBvrRCSnnduPVnDL6f7flGj/f0BS+6IU
         /pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02TgbFW2KAycJkkT+ZTlH6agRL2ssz2ek0aNntkRKC4=;
        b=Mhy7TX6+zSDmUnpVMYeaoz+a8ptdkOmzSSmfbhD8Kt83xFS2L2QklyW3QiXFqswTnK
         psMiFIK9mSPzgxUkAm0Lw48OYI+d+IiavKNEAjaxi3LMHDYzYaIHswxnT7fUXz1WvkVJ
         eVeyxRDijf7Zrqr/tYa/TAxWKHKyc+d7ZUMBtlW6R5ZUR25o/1lPr4lddm73EBKh/goa
         WWom2ERQwPU0oZ32qTascGtOVLh3ZKD41V6YjobsqlfURp+GzDv+L25JH0ZAg+gzorNU
         /930qbL1LZLiY/3iULrlLUvAFQZgDAtu7B1VXhbJKd23W17ITafNCuaV0d766GKJT1cg
         4gdA==
X-Gm-Message-State: APzg51BHjESBlEGHHXwCxVKskWW+x8kVuSL9lfUBd1wQqV1AKLHM6IQV
        y4kzLQjp8q1xac6LjyVg9WmQEw==
X-Google-Smtp-Source: ANB0VdY8ygC5IsK7TbBF29M0DgdAzSyTSVp2w1qlwn3nZJvN2U+vN6KXjc9U3lgHsvXb+s9J1HEmVw==
X-Received: by 2002:a02:9d4f:: with SMTP id m15-v6mr8102221jal.28.1537552166974;
        Fri, 21 Sep 2018 10:49:26 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id o201-v6sm2578034ito.41.2018.09.21.10.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:49:25 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:49:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180921174923.GB17718@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
 <CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com>
 <20180921140732.GA43093@syl>
 <xmqqfty2x0iw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfty2x0iw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 09:45:11AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > ...' block with your suggestion above. It's tempting to introduce it as:
> >
> >   expect_haves() {
> >     printf "%s .have\n" $(git rev-parse -- $@)
> >   }
> >
> > And call it as:
> >
> >   expect_haves one three two >expect
> >
> > But I'm not sure whether I think that this is better or worse than
> > writing it twice inline.
>
> If the expected pattern is expected to stay to be just a sequence of
> "<oid> .have" and nothing else for the foreseeable future, I think
> it is a good idea to introduce such a helper function.  Spelling it
> out at the use site, e.g.
>
> 	printf "%s .have\n" $(git rev-parse a b c) >expect
>
> will become cumbersome once the set of objects you need to show
> starts growing.

That's a good reason, and I hadn't thought of it.

> 	expect_haves a b c >expect
>
> would be shorter, of course.  And as long as we expect to have ONLY
> "<oid> .have" lines and nothing else, there is no downside that the
> details of the format is hidden away inside the helper.

Yeah, I don't expect this to to change much at all, so I think that
'expect_haves()' is good.

Thanks,
Taylor
