From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 00:20:43 -0500
Message-ID: <20060119052043.GB8121@trixie.casa.cgf.cx>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com> <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net> <20060118185229.GA3001@steel.home> <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 06:20:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzSE2-0006aG-6G
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 06:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWASFUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 00:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWASFUn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 00:20:43 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:48577 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161018AbWASFUn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 00:20:43 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 109154A84BC; Thu, 19 Jan 2006 00:20:43 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14888>

On Wed, Jan 18, 2006 at 05:18:50PM -0800, Junio C Hamano wrote:
>Alex Riesen <raa.lkml@gmail.com> writes:
>
>> this is probable unsafe too: not all systems export inodes
>> (the recent cygwin breakage comes to mind).
>
>Hmph.  I thought that breakage was about struct dirent, not what
>we read from struct stat; d_ino is XSI extension so that may
>have been the reason cygwin folks removed it, but st_ino is in
>BASE --- did they remove that as well?

No, we didn't.  We (i.e., I) removed d_ino in cygwin because it couldn't
be reliably calculated without slowing things down.  st_ino will always
be there.

cgf
