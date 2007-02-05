From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Use cache_sha1_file() in git-blame and git-merge-recursive.
Date: Mon, 5 Feb 2007 00:56:59 -0500
Message-ID: <20070205055659.GA13472@spearce.org>
References: <7v7iuxp2xt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 06:57:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDwqm-0002hJ-Dk
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 06:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbXBEF5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 00:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbXBEF5G
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 00:57:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34365 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbXBEF5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 00:57:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDwqb-00086w-La; Mon, 05 Feb 2007 00:57:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F3D4D20FBAE; Mon,  5 Feb 2007 00:56:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v7iuxp2xt.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38729>

Junio C Hamano <junkio@cox.net> wrote:
> git-blame needs to register an arbitrary data to in-core index
> while annotating a working tree file (or standard input), but
> git-blame is a read-only application and the user of it could
> even lack the privilege to write into the object store; it is
> another good example for cache_sha1_file().

*Excellent* reason for this.

But what about pretend_sha1_file() instead?

The term 'cache' suggests to me (on first glance) that its loading
an existing object and caching it in memory for faster, frequent
access, when compared to other non-cached objects.

-- 
Shawn.
