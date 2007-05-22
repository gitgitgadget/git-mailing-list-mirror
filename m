From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Cross-reference the manpages for git-name-rev and git-describe
Date: Tue, 22 May 2007 02:17:32 -0400
Message-ID: <20070522061732.GC11636@spearce.org>
References: <pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr> <A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com> <vpq8xbkoir8.fsf@bauges.imag.fr> <839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com> <7vfy5sy91f.fsf@assigned-by-dhcp.cox.net> <vpq7ir3658t.fsf_-_@bauges.imag.fr> <7vsl9rmkm0.fsf@assigned-by-dhcp.cox.net> <20070521072025.GO3141@spearce.org> <7vhcq59yiy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 08:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNgq-0003V4-Ez
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbXEVGRn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756835AbXEVGRn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:17:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38822 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752AbXEVGRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:17:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HqNgd-000115-1N; Tue, 22 May 2007 02:17:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8F37520FBAE; Tue, 22 May 2007 02:17:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vhcq59yiy.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48074>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Teach git-describe how to run name-rev
> 
> Sorry for a belated question, but is there a reason not to do
> this (on top)?

Nope, I just completely missed it.  Please make it so!  ;-)
 
> diff --git a/builtin-describe.c b/builtin-describe.c
> index efbd43f..2a32af6 100644
> --- a/builtin-describe.c
> +++ b/builtin-describe.c
> @@ -283,8 +283,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  		nr[2] = "--tags";
>  		memcpy(nr + 3, argv + i, (argc - i) * sizeof(char*));
>  		nr[3 + argc - i] = NULL;
> -		execv_git_cmd(nr);
> -		die("unable to start %s", nr[0]);
> +		return cmd_name_rev(3 + argc - i, nr, prefix);
>  	}
>  
>  	if (argc <= i)
> 

-- 
Shawn.
