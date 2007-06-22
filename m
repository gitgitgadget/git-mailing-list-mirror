From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Fri, 22 Jun 2007 00:47:16 -0400
Message-ID: <20070622044716.GG17393@spearce.org>
References: <20070621045333.GB13977@spearce.org> <7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com> <20070622035652.GD17393@spearce.org> <7vzm2sab63.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 06:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1b3L-0004xL-El
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 06:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbXFVErW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 00:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbXFVErW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 00:47:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46833 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbXFVErV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 00:47:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1b3H-0008R7-N5; Fri, 22 Jun 2007 00:47:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3E35020FBAE; Fri, 22 Jun 2007 00:47:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vzm2sab63.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50675>

Junio C Hamano <gitster@pobox.com> wrote:
> This is only minor nuisance, but can we do something about this?
> 
>  $ git gui --version
>  Application initialization failed: no display name and no $DISPLAY environment variable
> 
> I know it is from wish, not you, so I wouldn't insist, though.

Actually that should be fixable.

Should be as simple as using a Bourne shell script up front to
check for "z$1" = zversion || "z$1" = z--version, and if so dump
back the version, otherwise exec wish.  This is actually quite easy
and won't change things for existing users.  I'll put a patch into
maint tonight for it.

-- 
Shawn.
