From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] imap-send.c fails to build on OSX
Date: 12 Mar 2006 20:29:09 -0800
Message-ID: <86zmjvhsru.fsf@blue.stonehenge.com>
References: <863bhnlo3r.fsf@blue.stonehenge.com>
	<20060313042552.GA18136@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 05:29:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIegG-0003gF-Nb
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 05:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWCME3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 23:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWCME3M
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 23:29:12 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:42930 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751242AbWCME3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 23:29:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id BA8DB8FF22;
	Sun, 12 Mar 2006 20:29:10 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 25329-01-28; Sun, 12 Mar 2006 20:29:10 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3C5A78FF23; Sun, 12 Mar 2006 20:29:10 -0800 (PST)
To: Shawn Pearce <spearce@spearce.org>
x-mayan-date: Long count = 12.19.13.2.4; tzolkin = 11 Kan; haab = 2 Cumku
In-Reply-To: <20060313042552.GA18136@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17545>

>>>>> "Shawn" == Shawn Pearce <spearce@spearce.org> writes:

Shawn> Workarounds for compiling on MacOS X.
Shawn> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Shawn>  This should fix the build issues on Mac OS X.  Not tested on other
Shawn>  (possibly) more important platforms, like Linux.  :-)

My C is a bit rusty, but wouldn't that provide a definition for vasprintf when
the libc is *also* providing a definition?  Might that not also break other
apps that want to link with this?

Maybe the right solution is to rename this local implementation so that it
can't conflict, like "git_vasprintf", or to include it only when the libc
doesn't provide it.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
