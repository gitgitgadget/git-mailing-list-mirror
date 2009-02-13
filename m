From: Ben Hoskings <ben@hoskings.net>
Subject: Unexpected local changes immediately after fresh clone
Date: Fri, 13 Feb 2009 14:08:05 +1000
Message-ID: <3D94CDCE-88EB-479A-9D36-6B92FCFCBAF4@hoskings.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 05:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXpQX-0002Si-Ue
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 05:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757865AbZBMEIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 23:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbZBMEIL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 23:08:11 -0500
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58148 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbZBMEIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 23:08:10 -0500
Received: from 203-206-171-81.perm.iinet.net.au ([203.206.171.81] helo=[192.168.2.3])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <ben@hoskings.net>)
	id 1LXpLU-0002px-Fh
	for git@vger.kernel.org; Fri, 13 Feb 2009 04:08:09 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 203.206.171.81
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18FayInmlNFNC087yEcrA32
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109703>

Hi all,

As part of learning a bit more about git workflows, I thought I'd  
poke around a large and high-traffic repo, so I cloned Linus'  
linux-2.6 repository today from

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

After the clone was done, I changed into the repo's directory and ran  
a 'git status' (just out of habit), and it showed a bunch of  
uncommitted, unstaged changes.

Here's a log of the terminal during this (I removed no-ops like 'ls',  
and I inserted line breaks before each prompt for readability):

http://gist.github.com/63027

Doing a 'git diff' on the net/ subdirectory showed that the changes  
were sensible - i.e. it wasn't random corruption or anything. The ones  
I looked through were cleanups to part of the TCP code (you can see  
them in the gist linked above).

Is this normal or expected? My understanding was that a clone first  
received the current HEAD and its history, and then checked out the  
current state of it as the working copy. In any case, I would have  
expected the repositories at git.kernel.org to be bare and as such  
have no working copy for uncommitted changes to be in.

My system is a Mac OS X 10.5.6 box (aluminium MacBook); some details  
are below.

This may well be normal behaviour, but I asked about it in  
freenode:#git and no one had heard of it happening before.

Cheers
Ben Hoskings

------------------------------------

$ uname -a
Darwin hat 9.6.0 Darwin Kernel Version 9.6.0: Mon Nov 24 17:37:00 PST  
2008; root:xnu-1228.9.59~1/RELEASE_I386 i386

$ which git
/usr/local/bin/git

$ git --version
git version 1.6.1.2

$ df /
Filesystem Size Used Avail Capacity Mounted on
/dev/disk0s2 233Gi 213Gi 19Gi 92% /
