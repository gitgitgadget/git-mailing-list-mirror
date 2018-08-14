Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D571F404
	for <e@80x24.org>; Tue, 14 Aug 2018 16:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbeHNTp7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 15:45:59 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:39011 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbeHNTp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 15:45:59 -0400
Received: by mail-yw1-f45.google.com with SMTP id r184-v6so16717799ywg.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4A1u+N79ath9wXFt+HA+NHRIn0tjWFXcT0JGXsEY84=;
        b=aAREiG6pZYGQJ5mx51XuGoDYeh0sZiN7mjLD8A4R0Ozd5+86ZR8xuqgMRwjgREPhBL
         qQF/0ay9tJ1BY+MnfuFw6arY2lm3hq0+ACZIVT5tB/OOTio+YWpGSETaurWiT6Z80HH3
         eVghQM5cLU27EICzYPQ7R+4IhU6j84ZNRADoIlYTuzudI5toYL5q1CbjYAjy2PqE1frF
         iShxqVgLcQ+w2gCXldOoFcNR7E3aaS6m00QYUhwMNaTM/1fqSRWfnWWynFBi93rqPzrQ
         VFGPBtjKFq4+Kp9zy7Q6L1GjEsyiVBtIaUaF34DrBO0mN3QAhFoJa1fqNg9L/HNU+HCb
         bXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4A1u+N79ath9wXFt+HA+NHRIn0tjWFXcT0JGXsEY84=;
        b=hkLVfk5KQi7cWdf4nxtwV6niEvFteVH7Yjxgg8SScwiMHZiUyd5VLmTpjOcHrng7Uh
         3/LLD04gVzSoYk2kGSXgfe2wxAfRkL4ziB/eMc5WoDNSyrzKnTrSzPSUeggWBEHw+QZN
         vtVGN+FPqeUB0JIIaMNQj1iCsEQ2qBjpLk2yX7bpoSKAr8fGD6qnq+oOawdbDkhbDtSP
         f4Fd/nyEWNgco6lH5csd9TBzNdkFAfSEqg7/BIFKS/5qjoYSHQPWQ5725lUj3cNx6FmS
         Raw+e1qxVro8xKNN5Gf5oiVb2ui4zi60me6u8MLjQLd/9ViYgQvWfvlCttgGY/FoQ+QA
         423A==
X-Gm-Message-State: AOUpUlGTMbBQoK+KWYdm0NRUv22XgmLzSIluFWv8D5gIYlFTgI3sPAkm
        eKDrV+JEqO/838U0mVmRI0KuEuKMZMn3eifm60FwHA==
X-Google-Smtp-Source: AA+uWPyD+8dybLaH7Ewv/+e3gPqBDO0QAWwZ6zQBEZetHifgqr7R7MUemmBQZTRX0blzVJ9iSw3Vmh8RwjoRZvW9so4=
X-Received: by 2002:a25:3c45:: with SMTP id j66-v6mr1410555yba.247.1534265880266;
 Tue, 14 Aug 2018 09:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net> <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com> <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net> <CACsJy8Dbf6+ZjLk0vgYvzhwweOdp+5QTno+ejoA-r2YYsdpzrQ@mail.gmail.com>
 <20180814144711.GB3441@sigill.intra.peff.net>
In-Reply-To: <20180814144711.GB3441@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 09:57:48 -0700
Message-ID: <CAGZ79kbPKRM4dfRDoZWQz=jXzmjJeiNwR-EVtxyHxBqyTQ5r1Q@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 7:47 AM Jeff King <peff@peff.net> wrote:

>
> One problem there is that the prefixes are ambiguous (e.g., Jacob Keller
> shares with me, and I think at least one other over the years). You
> could look at the author of the tip commit, but that's not always right
> (and in fact, counting just merged topics misses bug-fixes that get
> applied directly on top of other people's topics). And of course there's
> the notion that "topic" might be a documentation typo fix, or it might
> be the entire range-diff program.

One could take all topics and see if you have at least one commit in there.
But that would mostly measure how much of an allrounder you are in the
code base (e.g. bug or style fixes such as Ramsay's "please squash this"
would be in many topics if not squashed).

There are other players who are very deep into one area of the code,
and probably have fewer series.

> I think "surviving lines" is another interesting metric, though it also
> has flaws (if I s/sha1/oid/ on your line, it becomes my line; even
> though my change is useful and should be counted, it's probably not as
> important as whatever the code was doing in the first place).

I wonder if we could measure the entropy added to the code base instead.
A patch that does s/sha1/oid/ (or introduction of a repository argument)
might compress very well, whereas new code might not compress very
well. ;-)
