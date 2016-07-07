Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A7520705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbcGGVea (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:34:30 -0400
Received: from avasout05.plus.net ([84.93.230.250]:53164 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcGGVe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:34:28 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id FxaS1t0012iA9hg01xaTp3; Thu, 07 Jul 2016 22:34:27 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=V/4/6qvi c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=kj9zAlcOel0A:10 a=cAmyUtKerLwA:10 a=Ew9TdX-QAAAA:8 a=APH_RvaqiIioEbBB-tgA:9
 a=obabQ9O6v7JZJTLIbnk7:22
Received: from charles by hashpling.plus.com with local (Exim 4.84_2)
	(envelope-from <charles@hashpling.org>)
	id 1bLGwE-0005MT-8w; Thu, 07 Jul 2016 22:34:26 +0100
Date:	Thu, 7 Jul 2016 22:34:26 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #02; Wed, 6)
Message-ID: <20160707213426.GA20572@hashpling.org>
References: <xmqqr3b6qwdt.fsf@gitster.mtv.corp.google.com>
 <20160707204002.GA19138@hashpling.org>
 <xmqqshvlnnzb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshvlnnzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 02:21:28PM -0700, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> > I just wanted to clarify what was actually fixed. The actual bug that
> > was reported and fixed was the fact that 'git grep' (without --cached)
> > wasn't searching the contents of files in the working tree if the index
> > entry had the "intent to add" bit set.
> 
> Ouch, you are absolutely right.
> 
>  Git does not know what the contents in the index should be for a
>  path added with "git add -N" yet, so "git grep --cached" should not
>  show hits (or show lack of hits, with -L) in such a path, but that
>  logic does not apply to "git grep", i.e. searching in the working
>  tree files.  But we did so by mistake, which has been corrected.
> 
> perhaps?

Yes, that reads like an accurate summary to me.
