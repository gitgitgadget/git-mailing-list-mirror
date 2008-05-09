From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Java Git (aka jgit) library switching license to BSD/EPL
Date: Thu, 8 May 2008 22:11:58 -0400
Message-ID: <20080509021158.GA29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philippe Ombredanne <philippe@easyeclipse.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <b
X-From: git-owner@vger.kernel.org Fri May 09 04:13:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuI6w-00007b-4a
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbYEICMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbYEICMO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:12:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34184 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbYEICML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:12:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JuI5M-0004Dw-E5; Thu, 08 May 2008 22:11:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3896720FBAE; Thu,  8 May 2008 22:11:58 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81585>

The Java Git library (also known as "jgit"[*1*]) is a 100% pure Java
implementation of a data access library for the Git on-disk data
structures, as well as a re-implementation of some commonly used
application functions such as history graph traversal/visualization
and network transport (fetch).

Since its inception on March 6, 2006 jgit has been under the
GPLv2 license.  To make the library available to a wider audience
(including but not limited to the Eclipse Git plugin, numerous
Apache projects such as Ant/Maven, the Netbeans IDE, etc.) we are
switching to a dual license between a 3-clause BSD (the EDL[*2*])
and the EPL[*3*].

As of the bleeding edge (40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
[*4*]) the ownership of all currently surviving lines of code is
broken down as follows:

   $ sh owner.sh 
    78%   27607 Shawn O. Pearce
    17%    6061 Robin Rosenberg
     4%    1518 Dave Watson    
     0%       4 Thad Hughes    
     0%       2 Roger C. Soares
   ------------------------------
   100%   35192 total

Robin and Dave:

  With 17% and 4% ownership, can you please reply to verify
  this license change will be permitted for your contributions?
  Please note this change is _only_ to jgit, and not to the egit
  (Eclipse plugin) code.

Nico, Linus, Junio, Daniel, Dscho, et.al.:

  We would appreciate it if you could provide a statement saying
  you have no current copyright ownership interest in jgit, and that
  you do not currently own nor invented any patents related to the
  "Git technology" that this code might need to use to function as
  a Git implementation.

  Part of the application process for EGit to become a project
  under the umbrella of the Eclipse Foundation[*5*] requires us
  to be reasonably certain the source code we are contributing is
  free of claims that could be brought by a 3rd party.  A statement
  from major contributors to C Git (those who created much of the
  C implementation) would show those individuals have no claims
  to bring against the current version of jgit, and that jgit is
  therefore likely to be free of any IP claims.

  There are three particular sections of jgit code that I would
  like to bring to your attention before you respond:

    * BinaryDelta[*6*] bears a striking simiarlity to patch-delta.c.
    * PackFetchConnection[*7*] does what builtin-fetch-pack.c does.
    * IndexPack[*8*] does what index-pack.c does.

  Here (and everywhere else in jgit) we have tried to avoid directly
  translating C->Java, but sometimes things just come out in a
  similar way once expressed in source form.  Knowing both the jgit
  and C git code well I think these are the closest sections where
  someone might suspect jgit copied code from C git.  The attached
  owner.sh script applied to those three files in C git came up
  with the following major contributors:

       33%     616 Nicolas Pitre
       16%     304 Junio C Hamano
       13%     241 Johannes Schindelin
       10%     197 Sergey Vlasov
        5%     107 Linus Torvalds
        5%     105 Shawn O. Pearce
        5%      94 Martin Koegler
        3%      71 Daniel Barkalow
        2%      40 Johannes Sixt
        1%      36 Geert Bosch
  

*1*  http://repo.or.cz/w/egit.git
*2*  http://www.eclipse.org/org/documents/edl-v10.php
*3*  http://www.eclipse.org/org/documents/epl-v10.php
*4*  http://repo.or.cz/w/egit/spearce.git
*5*  http://wiki.eclipse.org/EGit/Proposal

*6*  http://repo.or.cz/w/egit/spearce.git?a=blob;f=org.spearce.jgit/src/org/spearce/jgit/lib/BinaryDelta.java;h=bba6b19a4000923abfe57b844bae17e7a03e0419;hb=40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
*7*  http://repo.or.cz/w/egit/spearce.git?a=blob;f=org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java;h=c7fa66c0654eaf84c143e61ee4d11b74d73db28f;hb=40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36
*8*  http://repo.or.cz/w/egit/spearce.git?a=blob;f=org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java;h=b6e5956f62fa8cb60770c991699ae7b457d8954f;hb=40c5c6cb11b8cc6caf3ea6a681caf0a6b8d66f36

--8< owner.sh --
#!/bin/sh

for f in $(git ls-files \
	jgit \
	org.spearce.jgit \
	org.spearce.jgit.test \
	| egrep -v '.(launch|pack|idx)$' \
	| egrep -v ^org.spearce.jgit/lib/ \
	)
do
	git blame -C -C --whitespace "$f"
done | perl -e '
	$total = 0;
	while (<>) {
		die "$_\n" unless
		/^[0-9a-f]+ (?:[^)]+)?\((.*?) \d{4}-\d{2}-\d{2} /;
		$n = $1;
		$n =~ s/^\s+//;
		$n =~ s/\s+$//;
		$who{$n}++;
		$total++;
	}
	@own = map {[$_, $who{$_}, $who{$_} * 100 / $total]} keys %who;
	$fnd = 0;
	foreach (sort {$b->[2] <=> $a->[2]} @own) {
		$fnd += $_->[1];
		printf "%3i%% %7i %s\n", $_->[2], $_->[1], $_->[0];
	}
	$unk = $total - $fnd;
	print "-" x 30, "\n";
	if ($unk > 0) {
		printf "%3i%% %7i (unknown)\n", $unk * 100 / $total, $unk;
	}
	printf "%3i%% %7i total\n", 100, $total;
'

-- 
Shawn.
