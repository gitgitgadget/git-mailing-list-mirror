Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C037D1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 19:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbfISTEF (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 15:04:05 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44841 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389807AbfISTEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 15:04:04 -0400
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 03AD51C0003;
        Thu, 19 Sep 2019 19:04:01 +0000 (UTC)
Date:   Fri, 20 Sep 2019 00:33:59 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190919190359.cuvy5g3xangrkgim@yadavpratyush.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
 <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
 <20190919183258.g7ae4u5nzuzwgu7b@yadavpratyush.com>
 <20190919184708.GA83166@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919184708.GA83166@dentonliu-ltm.internal.salesforce.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/09/19 11:47AM, Denton Liu wrote:
> On Fri, Sep 20, 2019 at 12:02:58AM +0530, Pratyush Yadav wrote:
> > Hi Junio,
> > 
> > On 18/09/19 10:49AM, Junio C Hamano wrote:
> > > Pratyush Yadav <me@yadavpratyush.com> writes:
> > > You should be able to merge this (and all other git-gui topics
> > > already in my tree Denton pointed out) to your 'master'.  If you
> > > then make a trial merge of the result back into my tree with "git
> > > merge -Xsubtree=git-gui", it should result in "already up to date",
> > > i.e. a noop merge.
> > 
> > I pulled all the changes into git-gui. I had to manually backport two 
> > commits:
> > 
> >   * 7560f547e6 (treewide: correct several "up-to-date" to "up to date", * 2017-08-23)
> >   * 00ddc9d13c (Fix build with core.autocrlf=true, 2017-05-09)
> > 
> > because they touched other parts of git, that were not in git-gui.
> > 
> 
> For the record, you could do a
> 
> 	git cherry-pick -Xsubtree=git-gui 00ddc9d13c 7560f547e6
> 
> to bring them over instead of manually recreating the changes yourself.
> Personally, I'd prefer the cherry-picked commits as it'd preserve
> authorship information but I'm not sure how Junio feels.

I'm not sure how this will work internally, but won't this also pull all 
the ancestors of those commits into git-gui? That is bloat I'd rather 
avoid.

I tried creating branches for those two commits and then did a subtree 
pull, and that is what happened. The repo size went up from around 6M to 
72M. Will cherry-picking avoid that?

And if it won't, how about munging a patch created by format-patch to 
get the authorship information without having to pull all the ancestors?
 
> From a correctness perspective, however, I compared my results after
> doing that with yours and it's identical.
 
> > If it looks all good, I'll put all this on my 'master' and re-send 
> > the pull request.
> 
> I took a look as well and the end result looks good to me too.

Thanks.

-- 
Regards,
Pratyush Yadav
