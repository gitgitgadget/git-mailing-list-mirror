From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Wed, 5 Mar 2008 00:12:12 -0500
Message-ID: <20080305051212.GZ8410@spearce.org>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041044120.22527@racer.site> <7vk5ki91zj.fsf@gitster.siamese.dyndns.org> <0t4pbmaew9.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041203320.22527@racer.site> <0tr6eq87az.wl%bremner@pivot.cs.unb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: David Bremner <bremner@unb.ca>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWlwZ-0005TR-W8
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbYCEFMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 00:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYCEFMy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:12:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49411 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbYCEFMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 00:12:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWlv6-00069g-JH; Wed, 05 Mar 2008 00:12:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6DE1B20FBAE; Wed,  5 Mar 2008 00:12:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <0tr6eq87az.wl%bremner@pivot.cs.unb.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76170>

David Bremner <bremner@unb.ca> wrote:
> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>     >> Tue, 4 Mar 2008, David Bremner wrote:
>     >> 
>     >> Yeah, I should have been more explicit. The problem is a line
>     >> 
>     >> read -N1 VAR
> 
>     Johannes> Can you be even more explicit?  IOW why does this have
>     Johannes> to be a pre-commit hook, and cannot be done before
>     Johannes> calling git-commit itself?
> 
> I have this feeling I don't really understand the question.  Yes, in
> principle, whatever I am doing in a pre-commit hook could be done by
> hand first.  I guess it is primarily a user interface issue.  The goal
> is modify the behaviour of git-commit in a particular repository;
> isn't this the purpose of pre-commit hooks?  

What happens to such hooks under git-gui?

git-gui invokes the pre-commit hook with stdin coming off the stdin
that the wish process inherited when it was spawned.  This may not
be the best way to interact with the end-user of that repository.

-- 
Shawn.
