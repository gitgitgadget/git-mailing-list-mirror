Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B481F744
	for <e@80x24.org>; Sat,  2 Jul 2016 11:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbcGBLag (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 07:30:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:62285 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbcGBLaf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 07:30:35 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MJXEd-1bKgyO0UVH-0039eT; Sat, 02 Jul 2016 13:30:27
 +0200
Date:	Sat, 2 Jul 2016 13:30:25 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 4/9] merge_recursive: abort properly upon errors
In-Reply-To: <xmqqy45lz708.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607021324330.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <81a74b02ac714a4fa3734dfb774cff6dea3a3471.1467199553.git.johannes.schindelin@gmx.de> <xmqqvb0r3gi4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607011215010.12947@virtualbox>
 <xmqqy45lz708.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+s4SfE/cztt+qE8J2EcQE2Z413BhJecM1LQCWdaAx12YCm4/933
 k7OGiaWcyxCUYal6gX5k3ppSol+wBBIeQvuqqpK1ME4sXfZ4LmlR502Horpvbpa0m/elLp2
 jRq2z7CO5nvFIZXLPFXFEWlNvNomHTtSwuU12FAGYOPTF2pXkhQJtDRggDpqCBC/TMoMk9j
 seP2Pxte+8mogVFZorytw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jmjSF30sgQw=:cPA4v1TA4WCaeNQXu1XYLn
 OG+yuU4iofMLM4Zt2sDW17y/rakx+Jk08gfj7XOXWa6QJn6YLgGHZMbFC1XBmBJ8iAkAjS66W
 EaETP8vIkLXpxjzPcwLg9QLGcb/bmcb42B6BvME1foz9dhL36uF4az/T0xoi4Bb+p9dYN+Ia6
 WkVDiiYyNEvDW9CXeIMKMX59dj0soYxgKxz2YDxVJNPIWQPvou7RqMfm8r3rOrdJD7aVojJR/
 3UVZYmqjfdsaQFcsHxbGrh60cKVgqhuRwJIESEJKzzYfvPTvTKydNbOOkvuCRIwW8ch8VpO7L
 Mg1jDRMeyljLkmz6dUKYeDY1E+9AHiSmseGGQ0pg3OJ7C1CRS4UxyMADimajtoWid2Hkx9GNr
 3yYXOUQGoesiJ34QTMqGHW7OKCP4KqEHYsjTUaG+oA1JkNVfCzE7O6uysflLORyzBTOV2CuqW
 +M1ss4xMyXQVWPSDzbRvxqthqc+PNppERFQEJ3Gben8SdXhcalMlQ+0vjRLQwLTr68mh8Rp3B
 +use1bu2suQQuSFp2jv7I/mh+ZpehqSm8jmFuUs/wyjYmoY+95srDH7XPgRFSylvgY7hWhdq2
 bkZKpmhTP8Rn3x/xvc8LmIQwSiyH7qiz10yxSy6TbOkpEF1NmfKrPw44cetyMYsk5tLmwlSKp
 K1ctjpskSFb+DEBM0+DfOej2mVkR4dxZe5W1Fe8iW7zOeIqaQVKl349EXvHRCIptF6pQA4Fhc
 Vq3OpudyPCANpVPABjElD/0hdozkImHNv7Z07h4FTVRzayrNZ/3Vd7z7mtS7KJDFlB2qa8fJ3
 5czlOJU
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 1 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> >  		saved_b2 = o->branch2;
> >> >  		o->branch1 = "Temporary merge branch 1";
> >> >  		o->branch2 = "Temporary merge branch 2";
> >> > -		merge_recursive(o, merged_common_ancestors, iter->item,
> >> > -				NULL, &merged_common_ancestors);
> >> > +		if (merge_recursive(o, merged_common_ancestors, iter->item,
> >> > +				NULL, &merged_common_ancestors) < 0)
> >> > +			return -1;
> >> >  		o->branch1 = saved_b1;
> >> >  		o->branch2 = saved_b2;
> >> >  		o->call_depth--;
> >> 
> >> I wonder if o->branch[12] need to be restored, though.  The only
> >> sensible thing the caller can do is to punt,...
> >
> > I do not think that the caller can do anything sensible with *o after we
> > return an error...
> 
> That is totally up to what this patch does, isn't it?

No, not really. We do not really know *where* in the recursive merge the
failure happened.

All we know is that it happened while trying to merge the temporary
branches.

> By deliberately keeping o->branch[12] to point at the temporary
> names and not restoring, this patch declares "the caller cannot do
> anything sensible with *o".  If it restores, the caller still can.

But would restoring the branch names not give the false impression that
the error occurred during a different phase of the recursive merge?

> Even with this step as-is, the caller can tell at which recursion
> level the merge failed by looking at o->call_depth, for example.

Well, not really:

1) please note the o->call_depth-- that is *also* skipped in case of an
   error after my patch, and

2) what use is the recursion level if an arbitrary number of merges could
   happen at the same recursion depth?

In short, I do not think that resetting those values in *o could bring any
benefit to the caller, short of introducing those fine-grained error
values I mentioned elsewhere.

Ciao,
Dscho
