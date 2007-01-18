From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] prune-packed: new option --min-age=N
Date: Thu, 18 Jan 2007 12:24:08 -0500
Message-ID: <20070118172408.GG15428@spearce.org>
References: <20070118171830.GA13521@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 18:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7azq-0000Yt-KM
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 18:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXARRYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbXARRYN
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 12:24:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57630 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXARRYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 12:24:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7azc-0002gG-6r; Thu, 18 Jan 2007 12:24:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8AC7120FBAE; Thu, 18 Jan 2007 12:24:08 -0500 (EST)
To: Matthias Lederhofer <matled@gmx.net>
Content-Disposition: inline
In-Reply-To: <20070118171830.GA13521@moooo.ath.cx>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37126>

Matthias Lederhofer <matled@gmx.net> wrote:
> This option allows to remove the unpacked version of an object only if
> it has been packed for a minimum time.  It is intended to work around
> the problem of freshly packed objects which should not be deleted
> because someone might still try to open the unpacked version.

Are we not rescanning for new packs if we fail to find an
object in the object directory?  I thought we were doing this in
read_sha1_file.  *looks at code* Indeed, we are...

Is this somehow not working?

-- 
Shawn.
