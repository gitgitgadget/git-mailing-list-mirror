From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 21:03:09 +0200
Message-ID: <E1FiFgL-0003m6-Eb@moooo.ath.cx>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org> <44713BE4.9040505@gentoo.org> <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <Pine.LNX.4.64.0605221013020.3697@g5.osdl.org> <e4stna$o1g$1@sea.gmane.org> <Pine.LNX.4.64.0605221055270.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 22 21:03:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiFgQ-000433-PJ
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWEVTDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 15:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWEVTDM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:03:12 -0400
Received: from moooo.ath.cx ([85.116.203.178]:52101 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750825AbWEVTDM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 15:03:12 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221055270.3697@g5.osdl.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20518>

> But people _should_ realize that removing objects is very very special. 

Just a similar question: is there any reason not tu run git
repack/prune-packed as cron job? I would think of something like this
for every night:

- git prune-packed (remove objects packed last time)
- check how many objects git-count-objects counts, if it are not enough
  abort
- git repack

git repack -a -d is probably a bad idea, I guess, because a program
could try to open them after they were deleted.  Is there any way to
delete unnecessary packs (those which would repack -a -d delete)?
Making it possible to do a git repack -a and delete those packs the
next night?
