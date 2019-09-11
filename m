Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C781F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfIKSeb (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:34:31 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:42561 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfIKSea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:34:30 -0400
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D92DF100005;
        Wed, 11 Sep 2019 18:34:27 +0000 (UTC)
Date:   Thu, 12 Sep 2019 00:04:20 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
Message-ID: <20190911183419.jea27ctvcdl5olp3@yadavpratyush.com>
References: <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
 <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
 <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com>
 <8a726eea-f461-db90-7e36-70b708ff8915@kdbg.org>
 <CAKPyHN3+Sr2QJGR7Sw02x0A9OXshVUQofqH=ShXDivmqP5X7vw@mail.gmail.com>
 <20190910085446.GB32239@gmail.com>
 <CAGr--=Jdj+kJmV7z3vhYW+s129+0+KgbNYw8NFPmSASRYMTdbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=Jdj+kJmV7z3vhYW+s129+0+KgbNYw8NFPmSASRYMTdbg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/09/19 12:27PM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> I'm hoping this will be merged, even without changing the radio
> selectors to a checkbox(?). The patch from Bert resolves the issue I
> raised about wanting the hotkey.
> What do you think?

What do you mean by "this"? I am guessing you mean [0].

I'm afraid that patch conflicts with Bert's change [1] to using a 
checkbox. Since both patches are in flight, it makes more sense to base 
your work off his. If I merge your patch now, I'll have to revert it as 
soon as it is time to merge Bert's, and then rework your patch.

Also, after Bert's patch, the toggling becomes much simpler. All you'd 
have to do is something like:

  bind . <$M1B-Key-e> {
	# Toggle commit type.
	set commit_type_is_amend [expr {!$commit_type_is_amend}]
	do_select_commit_type
  }

Maybe a cleaner way is possible, but this is what I could come up with 
for toggling a boolean.

So can you please send a re-roll based on Bert's patch? I took a quick 
glance at it, and it seems mostly correct. I have a couple of comments, 
so some things might change based on the discussion, but I don't think 
it should affect your change too much.

[0] https://public-inbox.org/git/20190904175943.11924-1-birger.sp@gmail.com/
[1] https://public-inbox.org/git/ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com/

-- 
Regards,
Pratyush Yadav
