From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] common progress display support
Date: Wed, 18 Apr 2007 14:56:49 -0400
Message-ID: <20070418185649.GB18328@spearce.org>
References: <alpine.LFD.0.98.0704181422050.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeFL0-00082z-8u
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993032AbXDRS4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993034AbXDRS4z
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:56:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52252 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993032AbXDRS4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 14:56:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HeFKd-0002Fp-I5; Wed, 18 Apr 2007 14:56:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BD91320FBAE; Wed, 18 Apr 2007 14:56:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704181422050.4504@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44930>

Nicolas Pitre <nico@cam.org> wrote:
> Instead of having this code duplicated in multiple places, let's have
> a common interface for progress display.  If someday someone wishes to
> display a cheezy progress bar instead then only one file will have to
> be changed.
> 
> Note: I left merge-recursive.c out since it has a strange notion of
> progress as it apparently increase the expected total number as it goes.
> Someone with more intimate knowledge of what that is supposed to mean
> might look at converting it to the common progress interface.

That disaster in merge-recursive.c is my fault.  The progress
meter there doesn't mean much of anything.  Even on my slow as
dirt Windows system I see the progress meter jump to the end as
soon as we discover the number of files we have to chug though.
So its always at 99%.

About the only value it has is saying "Oh; I just found out there
are 6,000 files deleted/renamed between the two branches, and I
finished processing them.  Oh; I just found out that was just
an inner recursive merge, now there are actually 12,000 files
deleted/renamed when you add in the final merge.  OK, I'm done."

I've been thinking about getting rid of it.

-- 
Shawn.
