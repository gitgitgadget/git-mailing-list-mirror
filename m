From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk layout bug
Date: Mon, 21 Jan 2008 20:50:34 +1100
Message-ID: <18324.27370.96611.769276@cargo.ozlabs.ibm.com>
References: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 10:51:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGtJ7-0002th-O8
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 10:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318AbYAUJuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 04:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757130AbYAUJuk
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 04:50:40 -0500
Received: from ozlabs.org ([203.10.76.45]:40122 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756107AbYAUJuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 04:50:40 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5525FDDE06; Mon, 21 Jan 2008 20:50:38 +1100 (EST)
In-Reply-To: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71246>

Linus Torvalds writes:

> In the current git repository, try this:
> 
> 	gitk origin/master..origin/pu
> 
> and it starts out looking ok.
> 
> But then scroll down a bit (say, press "PageDown" ten to twenty times), 
> and scroll up again, and now that thing is totally unusable.
> 
> Is it just me?

No, I have seen it occasionally (though not recently), but I've never
been able to trigger it when I had some time to debug it. :/

I'd be interested to know if you can trigger it with the "dev" branch
of gitk, too.  The dev branch doesn't use --topo-order or
--date-order, but instead does the topological sort itself, so the
cold-cache case is a lot faster (and the hot-cache case goes just as
fast as before).  And because I can now reorder the commits, I can put
each open-circle commit just after the last merge that has it as a
parent, which ends up looking much nicer too.

Paul.
