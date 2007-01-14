From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a
 subdirectory
Date: Sun, 14 Jan 2007 10:29:41 -0800
Message-ID: <45AA7695.7040700@midwinter.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>	<7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>	<200701140111.20671.Josef.Weidendorfer@gmx.de>	<45A97EC5.10401@midwinter.com> <7virfaie1m.fsf@assigned-by-dhcp.cox.net> <45AA72E1.6060701@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhd-0006Kx-NN
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:01 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7l-0003eK-TC
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXANS3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 13:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXANS3m
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 13:29:42 -0500
Received: from tater.midwinter.com ([216.32.86.90]:38335 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751463AbXANS3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 13:29:41 -0500
Received: (qmail 1861 invoked from network); 14 Jan 2007 18:29:40 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 14 Jan 2007 18:29:40 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45AA72E1.6060701@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36815>

Steven Grimm wrote:
> Here's one use case for merge/pull/rebase that is, if not an everyday 
> thing, then at least fairly common in my group: Person B fixes a bug 
> in some code that's causing problems for the code person A is working 
> on. Person A is not at a stopping point in his own work yet, but wants 
> to get the fix.

I'll add that that's also the use case where I want git-pull and 
git-rebase to merge changes into my uncommitted working copy. It's 
probably less common in big distributed open-source projects where 
everyone is working on a logically separate, non-overlapping change to 
an otherwise stable code base, but in highly collaborative workgroup 
settings where 5 people are working on the same brand-new feature, it's 
not at all rare, and in those cases, where people are typically editing 
the same small set of files, you really do want to update early and 
often so as to minimize the scope of your merge conflicts and catch any 
integration problems as early as possible.

In that setting, I'd rather not have to commit before each update since 
I'd end up with a change history like "update" "update" "update" 
"implement function foo()" "update" "update" "fix a bug in bar()" etc., 
even if I use rebase.

Cogito handles this case reasonably well, though it has to play tricks 
to do it.

-Steve
