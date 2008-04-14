From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: Git Wiki improvements
Date: Mon, 14 Apr 2008 12:53:43 -0400
Message-ID: <BAYC1-PASMTP07541F260058BCB1E881EFAEE80@CEZ.ICE>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca>
	<200804140303.22624.jnareb@gmail.com>
	<8aa486160804140106m570d3fb9va0081d8a0d42870@mail.gmail.com>
	<alpine.DEB.1.00.0804141555350.28504@racer>
	<BAYC1-PASMTP10A8BA28CC2999519EA0B2AEE80@CEZ.ICE>
	<87skxos93x.fsf@jeremyms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?ISO-8859-1?B?QulqYXI=?= <sbejar@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Pack\, Dylan" <PackD@navcanada.ca>,
	"Pack\, Dylan" <sarpulhu@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 14 19:16:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlRxI-0001Jq-VZ
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 18:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760844AbYDNQyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 12:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760712AbYDNQyG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 12:54:06 -0400
Received: from bay0-omc2-s23.bay0.hotmail.com ([65.54.246.159]:36444 "EHLO
	bay0-omc2-s23.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759787AbYDNQyE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 12:54:04 -0400
Received: from BAYC1-PASMTP07 ([65.54.191.167]) by bay0-omc2-s23.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Apr 2008 09:54:00 -0700
X-Originating-IP: [70.54.4.86]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.4.86]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 14 Apr 2008 09:53:59 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JlSsC-0005XV-4N; Mon, 14 Apr 2008 13:53:44 -0400
In-Reply-To: <87skxos93x.fsf@jeremyms.com>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 14 Apr 2008 16:54:00.0066 (UTC) FILETIME=[22EE1620:01C89E50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79517>

On Mon, 14 Apr 2008 12:18:42 -0400
Jeremy Maitin-Shepard <jbms@cmu.edu> wrote:

Hi Jeremy,

> I've thought about this possibility myself, but it seems that the clone,
> edit, commit, push cycle may not really be ideal for a wiki.  For one
> thing, it is hardly ever necessary or useful to have anything more than
> per-file commits.  Also, if there are a large number of simultaneous
> users trying to push to the repository, you could run into a problem
> whereby you can never successfully push because ever time you try, it is
> not a fast-forward, so you have to fetch then merge (we can assume the
> merge is just done automatically because e.g. only different files were
> modified) then try to push again, but before you have a chance to retry
> the push, the branch head may have changed again due to another push.
> 
> I suppose in practice this may not be a problem for the git wiki as it
> may not have so many contributors, but this would certainly be a problem
> for e.g. wikipedia.

Yeah, it should be okay on this scale, its the same as having multiple developers
push into a common source repo.  Ikiwiki itself is hosted in Git and handles its
own wiki exactly this way.  It can be updated via the web site or Git push.
Running  "git pull --rebase" before doing a push into the wiki isn't onerous.

> More generally, though, although we may all dislike using webpage
> interfaces, actually having to keep the entire wiki updated locally
> doesn't seem terribly useful.  Really, you just want a way to edit a
> particular page in your text editor, have various commands available for
> e.g. previewing, and have commands available for showing the log
> information with a nicer interface than a web page.

The goal would be to make the help texts available in multiple ways.  In a
text editor, or converted into other formats for use with other tools.  More
importantly they should continue be easy to find with Google and editable
via a browser for quick fixes by casual users.  But as it stands, the wiki
information is stuck on the web.

Git's documentation is already handled very close to this today.  It's easy to
clone the asciidoc source, read in a text editor, and turned into web or man
pages.   It seems attractive to do likewise for the wiki docs since the tools
are all at hand.

Cheers,
Sean
