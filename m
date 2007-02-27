From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 23:22:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272317510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <877iu3q13r.fsf@latte.josefsson.org> <200702271257.37437.andyparkins@gmail.com>
 <200702272227.05244.robin.rosenberg.lists@dewire.com>
 <7v649nclsq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:22:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAiJ-0002ti-Cp
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbXB0WWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbXB0WWQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:22:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:54246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751832AbXB0WWP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:22:15 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:22:14 -0000
X-Provags-ID: V01U2FsdGVkX18GnL8LbRoGgArcdIFvooitgaUnY7j9em9bpicoTR
	VG9w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v649nclsq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40824>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> It's been a while I looked at the coding guideline the last time, but I 
> think GNU convention wants you to say "filename (function)" when 
> applicable.  Which I happen to think makes much more sense than the 
> filename alone.
> 
> The information that would appear in "log -p --pretty" output needs to 
> be condensed to obtain such a log entry.  You _could_ still do that as a 
> built-in if you really wanted to, but I tend to think that it is much 
> better to implement such a specialized processing (for one thing, what a 
> function is depends on the programming language you are reading from) as 
> an external postprocessing filter that people can more easily tweak for 
> their specific needs.

It would be easy to write a consume() function (called with context 
== 0) which takes the information from the "@@" lines.

But the builtin -- as the script -- would suffer from the following 
problem:

-- snip --
+}
+
+static int new_function(void)
-- snap --

> That's why I keep stressing that one good thing about git is it is 
> easily scriptable.

IMHO it is easier to get right as a builtin. But as I said, I am not 
feeling too strongly about it.

Ciao,
Dscho
