From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: fix 2 whitespace issues
Date: Thu, 12 Oct 2006 23:08:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610122254350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610121418180.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pu9pjwe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1024602135-1160687283=:14200"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 23:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY7mk-0005vB-VA
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 23:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWJLVIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 17:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWJLVIG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 17:08:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:33211 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750892AbWJLVIF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 17:08:05 -0400
Received: (qmail invoked by alias); 12 Oct 2006 21:08:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 12 Oct 2006 23:08:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pu9pjwe.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28799>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1024602135-1160687283=:14200
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 12 Oct 2006, Junio C Hamano wrote:

> I noticed this breakage sometime last week and it was sitting at near 
> the bottom of my stack of things to look at.

I actually enjoyed tracking your todo "branch", although lately, there is 
substantially less traffic there. Maybe git is finished ;-)

> You mentioned six whitespace problems but I counted only three
> and the test failed on "CR at the end"; the test vector was easy
> to hand-fix thanks to the "index" line.
> 
> This patch is an example that we do not want to transmit files
> that has CRs in e-mail.  These CRs appear in format-patch
> output, so either the user needs to do --attach (and perhaps the
> option needs to do base64 or qp in such a case) or format-patch
> needs to treat a blob with CR as binary and emit binary diff?
> The latter is not appropriate since patches apply just fine with
> CR in them.

The problem is more likely my (strange) workflow. I never use 
git-send-email. Not only because I am a bit wary of the Perl stuff, but 
also because I cannot use sendmail directly (some stoopid "firewall" 
pretending to fix spamming from %&/%&/ users with their %&"§ infected 
Windows machines).

Thus, I used ^R in my venerable patched pine to insert the file, and (just 
a guess) pine -- in its infinite wisdom -- decided I'd probably not want 
the carriage return, when I put it there on purpose, using my l33t sk1llz.

In hindsight, it might be not _that_ important to test for a carriage 
return, but testing _any_ whitespace should do (which I put in also, for 
good measure). However, carriage returns from my beloved friends using the 
Most Stupid operating system were the reason I hacked in the whitespace 
options, and therefore I wanted to test this case specifically.

Ciao,
Dscho

---1148973799-1024602135-1160687283=:14200--
