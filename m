From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-checkout-index to use file suffixes.
Date: Thu, 2 Mar 2006 01:51:36 -0500
Message-ID: <20060302065136.GA6377@spearce.org>
References: <20060301044132.GF22894@spearce.org> <20060301150629.GB3456@spearce.org> <slrne0bh1p.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 07:52:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEhfg-0007Lf-FR
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 07:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWCBGwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 01:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWCBGwF
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 01:52:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:14730 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751397AbWCBGwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 01:52:04 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEhfM-0005QH-Is
	for git@vger.kernel.org; Thu, 02 Mar 2006 01:52:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C7C620FBC2; Thu,  2 Mar 2006 01:51:36 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <slrne0bh1p.fr9.mdw@metalzone.distorted.org.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17057>

Mark Wooding <mdw@distorted.org.uk> wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > I thought about using instead:
> >
> >   --stage=all --suffix1=\#1 --suffix2\=#2 --suffix3=\#3
> 
> How about something like
> 
>   --suffixes=:#1:#2:#3
> 
> uses first character as a delimiter to separate the suffixes.  A single
> --suffix option could plausibly provide the suffix if only one stage is
> being checked out, and doesn't have the grim delimiter wart.

Why let the user choose?  '/' shouldn't be permitted as that
(possibly) would try to create a directory also named the same as
the file (a bad thing).  Then its just two formats, depending on
if you want all stages or just 1 stage:

	--stage=all --suffix=#1/#2/#3

or

	--stage=1 --suffix=#1

?

-- 
Shawn.
