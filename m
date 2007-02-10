From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 13:53:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702101351430.1757@xanadu.home>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
 <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702101131070.1757@xanadu.home>
 <7vmz3mj6yo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702101154130.1757@xanadu.home>
 <7v1wkxki4a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 19:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFxMY-0008P3-Bb
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 19:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXBJSxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 13:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbXBJSxq
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 13:53:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33315 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbXBJSxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 13:53:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD900FVDGHKSJ00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Feb 2007 13:53:45 -0500 (EST)
In-reply-to: <7v1wkxki4a.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39253>

On Sat, 10 Feb 2007, Junio C Hamano wrote:

>  (0) Do nothing.
> 
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

And don't get me wrong.  I think that for 1.5.0 you should really do (0).


Nicolas
