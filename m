From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 02:21:06 -0400
Message-ID: <20070824062106.GV27913@spearce.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 08:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOSXj-0004nF-My
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 08:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703AbXHXGVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 02:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683AbXHXGVM
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 02:21:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44267 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbXHXGVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 02:21:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IOSXb-0003Ht-RK; Fri, 24 Aug 2007 02:21:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 91FEB20FBAE; Fri, 24 Aug 2007 02:21:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56550>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Any ideas on why git protocol clone is failing?
> 
> 2007-08-24_20:51:33.85649 [9758] Connection from 72.74.92.181:19367
> 2007-08-24_20:51:33.85828 [9758] Extended attributes (33 bytes) exist
> <host=git.jonsmirl.is-a-geek.net>
> 2007-08-24_20:51:33.96990 [9758] Request upload-pack for
> '/home/git/mpc5200b.git'
> 2007-08-24_20:51:45.00789 fatal: Out of memory? mmap failed: Cannot
> allocate memory
> 2007-08-24_20:51:45.08746 error: git-upload-pack: git-rev-list died with error.
> 2007-08-24_20:51:45.08771 fatal: git-upload-pack: aborting due to
> possible repository corruption on the remote side.
> 
> NSLU2 ($70) is 266Mhz ARM with 32MB memory.
> It's running Debian on a 250GB disk with 180MB swap.
> 
> Watching top the process runs up to about 60MB in virtual size and exits.
> Setting the window down made no difference  packedGitWindowSize = 4194304

ulimits?  packedGitLimit may also need to be decreased?  Though we
always try to free unused windows before we declare we are out
of memory...

-- 
Shawn.
