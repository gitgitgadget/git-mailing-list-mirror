From: Theodore Tso <tytso@mit.edu>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 13:43:13 -0500
Message-ID: <20070210184313.GF25607@thunk.org>
References: <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com> <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de> <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com> <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702101049480.1757@xanadu.home> <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702101131070.1757@xanadu.home> <7vmz3mj6yo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702101154130.1757@xanadu.home> <7v1wkxki4a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 19:43:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFxC6-0002sd-1X
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 19:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXBJSn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXBJSn0
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 13:43:26 -0500
Received: from THUNK.ORG ([69.25.196.29]:57801 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbXBJSn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 13:43:26 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HFxGy-0002lh-NJ; Sat, 10 Feb 2007 13:48:32 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HFxBp-00089W-1y; Sat, 10 Feb 2007 13:43:13 -0500
Content-Disposition: inline
In-Reply-To: <7v1wkxki4a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39251>

On Sat, Feb 10, 2007 at 10:00:37AM -0800, Junio C Hamano wrote:
>  (1) We keep the current "git-status [-v] [-a] [[-i|-o] <paths...>]"
>      command line and do the necessary index manipulation
>      in-core without writing it out (see git-commit.sh for
>      details of what it involves).  
> 
>  (2) We drop the support for any command line parameter from
>      "git-status", apply my two patches for Marco to
>      "git-runstatus", and rename "git-runstatus" to
>      "git-status".
> 
> If I have to pick between the two, I would probably pick (2).
> While (1) would essentially mean doing "git-commit" entirely
> in-core without writing the index out until we really make the
> commit, which is a good thing in itself in the longer term, it
> is out of the question this late in the game for 1.5.0.

If you end up doing (2), may I suggest making the functionality of
"git-status" today available as "git-commit -n"?  It is something
useful, so we shouldn't lose it, and -n meaning --no-action is a well
accepted convention for Unix commands.

						- Ted
