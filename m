From: Eric Raible <raible@gmail.com>
Subject: Re: How to connect remotely with Git machine
Date: Mon, 8 Jun 2009 15:25:32 +0000 (UTC)
Message-ID: <loom.20090608T151053-794@post.gmane.org>
References: <23920805.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 17:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDgjX-0002n7-Am
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 17:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbZFHPZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 11:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbZFHPZp
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 11:25:45 -0400
Received: from main.gmane.org ([80.91.229.2]:42276 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357AbZFHPZo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 11:25:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MDgjI-00038Z-At
	for git@vger.kernel.org; Mon, 08 Jun 2009 15:25:44 +0000
Received: from nmd.sbx07304.ardslny.wayport.net ([98.96.132.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 15:25:44 +0000
Received: from raible by nmd.sbx07304.ardslny.wayport.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 15:25:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.96.132.70 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121080>

stpl_nk <nkjha <at> systematixtechnocrates.com> writes:

> 
> 
> Hello all ,
> I am new in using Git . I have a small network , all the machine in LAN . I
> install Git in my windows machine (Windows XP sp2) in a central location .
> Now how to connect other hosts to central windows machine with the help of
> Git .
> 
> Thanks .

We have a similar situation at $dayjob.
Each developer who is ot use git installs it locally.
Each developer has their own local repo.
The shared (bare) repo is on a network drive, and that drive is mapped:

c:> net use g: \\server1\Engineering

Then individual developers can clone do something like this from bash:

$ git clone file://g:/path/to/repo/on/G

The only real hitch is that (in the largest single fustercluck
or all time) windows likes using backslash as a path separator.

But mapping the network drive to a drive letter allows you to avoid
almost all of the pain.

- Eric
