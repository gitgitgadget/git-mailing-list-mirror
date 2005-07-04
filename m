From: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Mon, 4 Jul 2005 10:09:50 -0700
Organization: YPO4
Message-ID: <20050704100950.393630e8.rdunlap@xenotime.net>
References: <1119994003.9631.6.camel@localhost.localdomain>
	<m3ekagp9mk.fsf@telia.com>
	<1120385280.6845.12.camel@localhost.localdomain>
	<m3oe9k6p40.fsf@telia.com>
	<1120425269.6845.28.camel@localhost.localdomain>
	<m3y88m21ln.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 19:13:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpUUz-0001Ed-Ut
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 19:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVGDRMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 13:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVGDRMF
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 13:12:05 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:39143 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261488AbVGDRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 13:09:57 -0400
Received: from pool-71-111-147-75.ptldor.dsl-w.verizon.net ([71.111.147.75]:56592 helo=midway.verizon.net)
	by chretien.genwebhost.com with esmtpa (Exim 4.51)
	id 1DpUSF-00072p-JP; Mon, 04 Jul 2005 13:10:00 -0400
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3y88m21ln.fsf@telia.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 04 Jul 2005 14:32:36 +0200 Peter Osterlund wrote:

| Catalin Marinas <catalin.marinas@gmail.com> writes:
| 
| > On Sun, 2005-07-03 at 14:38 +0200, Peter Osterlund wrote:
| > > Catalin Marinas <catalin.marinas@gmail.com> writes:
| > > > I know that using -A gives a more detailed output in case of a conflict.
| > > > The problem is that you will get a conflict even if the changes are
| > > > identical, making it impossible to detect when a patch was merged
| > > > upstream.
| > > 
| > > OK, I see. How about using wiggle instead?
| > > 
| > >         http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/
| > > 
| > > That's what patch-utils uses if you run "pushpatch -m". wiggle is also
| > > a lot smarter than diff3, so there will be fewer cases that result in
| > > a conflict. Maybe a parameter to "stg push" could enable wiggle mode.
| > 
| > I haven't used wiggle before but I will give it a try (though I prefer
| > such a tool not to be too smart since it might make mistakes). Anyway, I
| > will make this configurable, i.e. you could put something like below in
| > the .stgitrc file:
| > 
| > merger = 'diff3 -m -E %(branch1)s %(ancestor)s %(branch2)s'
| > 
| > or
| > 
| > merger = 'wiggle -m %(branch1)s %(ancestor)s %(branch2)s'
| > 
| > > Is there a way in StGIT to undo a push that results in a large mess of
| > > conflicts?
| > 
| > Good point. No, there isn't yet. I will think about an undo command. At
| > the moment, the old top and bottom ids of a patch are saved so that the
| > patch before the merge can be retrieved but there isn't any command to
| > make use of them.
| 
| I agree with the other comments, it's probably not wise to rely on
| wiggle, and wiggle sometimes makes a mess. However, it often does the
| right thing, and with a configurable merge program and an undo
| function, this should not be a problem. Just undo and try again if you
| don't like the result.

You could try Chris Mason's 'rej' as well.
ftp://ftp.oregonstate.edu/pub/suse/people/mason/rej/rej-0.15.tar.gz
(from one mirror site)

---
~Randy
