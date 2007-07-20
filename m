From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC status report
Date: Fri, 20 Jul 2007 11:37:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707201118550.14781@racer.site>
References: <200707201024.35605.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-76565903-1184927842=:14781"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 12:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBprY-0001Le-Vd
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbXGTKh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbXGTKh3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:37:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:48203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751984AbXGTKh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 06:37:28 -0400
Received: (qmail invoked by alias); 20 Jul 2007 10:37:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 20 Jul 2007 12:37:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gDndQsuTggupnVxwtrlWOwikoNz67tttDXHXcS0
	3ruEdnFLylrkd1
X-X-Sender: gene099@racer.site
In-Reply-To: <200707201024.35605.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53081>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-76565903-1184927842=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 20 Jul 2007, Jakub Narebski wrote:

> How it goes with Google Summer of Code git projects:
> builtinification, libification and GitTorrent?

For my part, I am very pleased with the progress Carlos is making with 
builtinification.  He is quite familiar with the source code by now, and 
with the style We Do Things Here(tm).  Even though _he_ thinks the 
progress is slow, I do not.  The first phase was to get acquainted with 
the code, and with the techniques to convert shell code into C.

And since Kristian joined into the builtinification process, and since 
Carlos and Kristian are working together quite nicely, I am even more 
happy.

FWIW this is the list of scripts that I would like to see converted by the 
end of the year (feel free to object), ordered by their size:

verify-tag, reset, repack, tag, checkout, rebase, bisect, 
rebase--interactive, am, commit.

It looks like 'tag' and 'commit' are pretty near to completion, with 'tag' 
already being in the 'next' branch, and verify-tag will probably follow 
soon.

The list left out two clusters: 'fetch' related scripts (pull, ls-remote, 
parse-remote, fetch, clone) and 'merge' related scripts (merge-ours, 
merge-resolve, merge-stupid, merge-octopus, merge)¹.

Julian and Daniel are working on the fetch front, and the progress is 
awesome.  I especially like the abstraction we have now, so that new 
transports are much easier to implement.  I am even tempted to have a go 
at 'pushing' to bundles.

Seems like I got the 4 people I wished for the builtin project, in a way 
;-)

IMHO 'stash', 'submodule' and 'filter-branch'² are not yet ready to be 
made builtin.

As for the merge stuff, I consider it too soon, too, especially since 
"git-merge" is a critical part of core Git _and_ quite long (even if the 
same arguments would apply to 'commit', too, but Kristian is already at 
work ;-)

Ciao,
Dscho

Footnote 1: I left out merge-one-file, since I have an (untested) builtin 
in my tree.  So there is not really much work to do there, I only have to 
find some time to research how to test this script properly.

Footnote 2: Sven is working on rewrite-commits, which is somewhat more 
limited than filter-branch ATM, though faster.  As Junio suggested, we can 
always consider using rewrite-commits as a fast backend to filter-branch, 
once both rewrite-commits and filter-branch stabilised.
--8323584-76565903-1184927842=:14781--
