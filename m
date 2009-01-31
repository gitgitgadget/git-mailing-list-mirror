From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: understanding index
Date: Sat, 31 Jan 2009 12:10:11 +0100
Message-ID: <20090131111011.GA29748@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 12:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTEBP-0007R4-I4
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 12:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbZAaLhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 06:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZAaLhS
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 06:37:18 -0500
Received: from out3.laposte.net ([193.251.214.120]:12755 "EHLO
	out4.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751880AbZAaLhR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 06:37:17 -0500
X-Greylist: delayed 1290 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jan 2009 06:37:17 EST
Received: from out3.laposte.net (lbao93aubmepnpf001-183-pip.meplus.info [10.98.50.10])
	by mwinf8310.laposte.net (SMTP Server) with ESMTP id 824961C0018C
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 12:16:14 +0100 (CET)
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8312.laposte.net (SMTP Server) with ESMTP id 071F17000087
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 12:15:40 +0100 (CET)
Received: from ? (91-164-156-12.rev.libertysurf.net [91.164.156.12])
	by mwinf8312.laposte.net (SMTP Server) with ESMTP id BE67E7000084
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 12:15:39 +0100 (CET)
X-ME-UUID: 20090131111539780.BE67E7000084@mwinf8312.laposte.net
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (0)(0000)gggruggvucftvghtrhhoucdtuddrvdektddrjeegucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107917>


Hey list.

I'm having some understanding trouble with git index. As I understand,
'git rm --cached' is not strictly the opposite of 'git add'. It's a
little embarrassing in this particular case : what if you want to
commit and did a wrong 'git add -u' command ?

Here's a minimalist sample :

% ls
foo	bar

[ hack, hack, hack on both files ]

% git status
[...]
	modified: foo
	modified: bar
[...]
% git add -u foo bar

[ optional hack on foo ]
[ damn, you realize you don't want to commit changes on foo at all ]

% git rm --cached foo
% git status
[...]
	deleted: foo
	modified: bar
[...]

If committed as is, foo will be marked as deleted (in 'git log
--name-status' at least, which is not wanted).

How to retrieve the state before the wrong 'git add -u' command _and_
keep the working tree as well (including last hacks) ? Is there any
command which is the exact opposite of 'git add -u' ?

Cheers,

-- 
Nicolas Sebrecht
