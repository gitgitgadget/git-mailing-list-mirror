From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-unbundle - unbundle objects and references for disconnected transfer.
Date: Wed, 14 Feb 2007 14:45:37 -0500
Message-ID: <20070214194537.GD28290@spearce.org>
References: <11714622292110-git-send-email-mdl123@verizon.net> <11714622292295-git-send-email-mdl123@verizon.net> <11714622293142-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:46:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQ4p-0002uE-VU
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbXBNTpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbXBNTpm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:45:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40186 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbXBNTpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:45:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHQ4J-0001R3-L0; Wed, 14 Feb 2007 14:45:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 017F820FBAE; Wed, 14 Feb 2007 14:45:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <11714622293142-git-send-email-mdl123@verizon.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39733>

Mark Levedahl <mdl123@verizon.net> wrote:
> +# get the objects
> +unzip -p "$bfile" .gitBundlePack | git-unpack-objects

Since you are transporting a packfile by sneakernet it might
be reasonable to assume this transfer happens infrequently.
Consequently we might assume its object count exceeds
transfer.unpackLimit, which means a standard fetch or push would
have kept the packfile rather than unpacking it to loose objects.

So maybe use git-index-pack here to index the packfile and
retain it as-is, rather than unpacking it?

-- 
Shawn.
