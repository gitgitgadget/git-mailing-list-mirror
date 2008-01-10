From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 02:23:44 +0300
Message-ID: <20080110232344.GD3197@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801101208500.3148@woody.linux-foundation.org> <C3AC3E6F.10D42%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 00:24:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD6lJ-0007Bu-Qm
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 00:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbYAJXXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 18:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbYAJXXu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 18:23:50 -0500
Received: from smtp06.mtu.ru ([62.5.255.53]:63128 "EHLO smtp06.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426AbYAJXXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 18:23:49 -0500
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id D56498EC2EC;
	Fri, 11 Jan 2008 02:23:44 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-171-194.pppoe.mtu-net.ru [85.140.171.194])
	by smtp06.mtu.ru (Postfix) with ESMTP id 6DF3C8EC1E7;
	Fri, 11 Jan 2008 02:23:44 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JD6kS-0002XR-ER; Fri, 11 Jan 2008 02:23:44 +0300
Content-Disposition: inline
In-Reply-To: <C3AC3E6F.10D42%jefferis@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70109>

On Thu, Jan 10, 2008 at 09:28:15PM +0000, Gregory Jefferis wrote:
> 
> Insisting that repos created on windows should have textfiles munged to LF
> by default doesn't seem right.  Even using Dmitry's clever autocrlf=safe
> option on Windows would lead to inconvenience since all LF files have to be
> explicitly attributed as text.  We should be helping Windows people to use
> LF files rather than hindering them!

I think people may have different preferences about that. Some people
may want to have text files with CRLF but others with LF. Some trust Git
heuristic for detecting text files (which seems works rahter good for
most commonly used formats) but others are paranoid about loss some
data. Finally, there are some people, who just wants to store their
messy files as is. Based on that, the following options are possible:

1. autocrlf=input for those who want LF and trust Git text heuristic
2. autocrlf=true is for those who want CRLF and trust Git text heuristic
3. autocrlf=fail for those who want LF but do not trust Git heuristic
4. autocrlf=safe for those who want CRLF but do not trust Git heuristic
5. autocrlf=false for those who like messy files with different EOLs

All these options have been mentioned in this thread, and I don't think
we are likely to come up with a better solution, because "better"
depends in which category of people you fall. IMHO, #5 is the least
reasonable of all.

Dmitry
