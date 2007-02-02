From: Theodore Tso <tytso@mit.edu>
Subject: Re: Instructions concerning detached head lead to lost local changes
Date: Fri, 2 Feb 2007 01:59:49 -0500
Message-ID: <20070202065949.GI18880@thunk.org>
References: <87mz3xa3vr.wl%cworth@cworth.org> <7v1wl9mj48.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702012135550.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 08:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCsP1-0002hy-Id
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 08:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423162AbXBBHAB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 02:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbXBBHAB
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 02:00:01 -0500
Received: from THUNK.ORG ([69.25.196.29]:60763 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423162AbXBBHAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 02:00:00 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HCsTj-000321-8a; Fri, 02 Feb 2007 02:04:59 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HCsOj-0001gl-Sh; Fri, 02 Feb 2007 01:59:49 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702012135550.3021@xanadu.home>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38467>

On Thu, Feb 01, 2007 at 09:49:27PM -0500, Nicolas Pitre wrote:
> It might be some work to get to a given position with a detached head 
> and this very position might be valuable information, but if you then do 
> "checkout HEAD^" you will still be detached but your previous position 
> is lost just like it would be if you moved to master.  Yet you're not 
> prevented from going to HEAD^ but you are prevented from going to 
> master.

Exactly.  With Junio's reasoning, then why aren't we forcing -f in this sequence:

git checkout HEAD^
git checkout HEAD^^
git checkout HEAD^^^
git checkout -f master

The first three are just as likely to "lose" information as the last.
Personally, I don't think any of this is "losing" information, any
more than I "lose" information in the following sequence of commands:

cd /usr/src/linux/drivers/net
cd /usr/src/linux/drivers/char
cd /usr/src/linux/fs/ext3
cd /home/tytso

The current working directory is just like the detached HEAD.  If I'm
moving it around, there is no loss of data.  cd != rm.

						- Ted
