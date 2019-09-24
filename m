Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FA01F463
	for <e@80x24.org>; Tue, 24 Sep 2019 14:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfIXOGv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 10:06:51 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47755 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfIXOGv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 10:06:51 -0400
Received: from localhost (unknown [1.186.12.39])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 31E87100014;
        Tue, 24 Sep 2019 14:06:47 +0000 (UTC)
Date:   Tue, 24 Sep 2019 19:36:45 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190924140645.k62dkndxy3z5fxke@yadavpratyush.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
 <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
 <20190919183258.g7ae4u5nzuzwgu7b@yadavpratyush.com>
 <20190919184708.GA83166@dentonliu-ltm.internal.salesforce.com>
 <20190919190359.cuvy5g3xangrkgim@yadavpratyush.com>
 <20190919191105.GA85790@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919191105.GA85790@dentonliu-ltm.internal.salesforce.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/09/19 12:11PM, Denton Liu wrote:
> On Fri, Sep 20, 2019 at 12:33:59AM +0530, Pratyush Yadav wrote:
> > On 19/09/19 11:47AM, Denton Liu wrote:
> > > For the record, you could do a
> > > 
> > > 	git cherry-pick -Xsubtree=git-gui 00ddc9d13c 7560f547e6
> > > 
> > > to bring them over instead of manually recreating the changes yourself.
> > > Personally, I'd prefer the cherry-picked commits as it'd preserve
> > > authorship information but I'm not sure how Junio feels.
> > 
> > I'm not sure how this will work internally, but won't this also pull all 
> > the ancestors of those commits into git-gui? That is bloat I'd rather 
> > avoid.
> > 
> > I tried creating branches for those two commits and then did a subtree 
> 
> Since those two commits have parents that are found in git.git, you'll
> pull the whole history of git.git if you try doing this.
> 
> > pull, and that is what happened. The repo size went up from around 6M to 
> > 72M. Will cherry-picking avoid that?
> > 
> 
> Yes, when you cherry-pick, you're essentially replaying the patch from
> the old tree onto the new tree and recording a fresh commit from it. The
> new commit is completely separate from the one it's based on so you
> won't end up pulling in any ancestry information and, as a result, you
> won't pull the rest of git's history.
> 
> In any case, give it a try. It doesn't hurt to experiment and play
> around with it.

It works. Thanks.

-- 
Regards,
Pratyush Yadav
