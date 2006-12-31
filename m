From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sun, 31 Dec 2006 01:12:32 -0500
Message-ID: <20061231061232.GC6106@spearce.org>
References: <20061231031305.GA5620@spearce.org> <7vy7ooip6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 07:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tvz-0003cn-JX
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 07:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbWLaGMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 01:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933031AbWLaGMg
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 01:12:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45549 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933032AbWLaGMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 01:12:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0tw6-00053n-6i; Sun, 31 Dec 2006 01:12:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 605F820FB65; Sun, 31 Dec 2006 01:12:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7ooip6y.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35679>

Junio C Hamano <junkio@cox.net> wrote:
> > diff --git a/config.c b/config.c
> > index 2e0d5a8..83ce9e1 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -236,8 +236,16 @@ int git_config_int(const char *name, const char *value)
> >  	if (value && *value) {
> >  		char *end;
> >  		int val = strtol(value, &end, 0);
> > +		while (isspace(*end))
> > +			end++;
> 
> Why?  Are you allowing "1024 k"?  Do we want to?

Yes.  Why not?

-- 
Shawn.
