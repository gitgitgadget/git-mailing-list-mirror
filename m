From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-bundle - bundle objects and references for disconnected transfer.
Date: Wed, 14 Feb 2007 14:42:37 -0500
Message-ID: <20070214194237.GC28290@spearce.org>
References: <11714622292110-git-send-email-mdl123@verizon.net> <11714622292295-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:42:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQ1m-0001dV-IM
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbXBNTmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbXBNTmm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:42:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40053 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500AbXBNTml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:42:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHQ1P-0001EL-Br; Wed, 14 Feb 2007 14:42:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C1A020FBAE; Wed, 14 Feb 2007 14:42:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <11714622292295-git-send-email-mdl123@verizon.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39731>

Mark Levedahl <mdl123@verizon.net> wrote:
> +# add the pack file
> +(git-rev-list --objects $gitrevargs | \
> +	cut -b -40 | \
> +	git pack-objects --all-progress --progress --stdout >.gitBundlePack) \
> +	|| (rm -f "$bfile" ; exit)

pack-objects can run a rev-list internally; which means this
can be written as:

 echo $gitrevargs | \
 git pack-objects --all-progress --progress --stdout --revs >.gitBundlePack \
 || (rm -f "$bfile" ; exit)

-- 
Shawn.
