From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.12
Date: Mon, 15 Sep 2008 21:07:53 +0200
Message-ID: <20080915190753.GA1946@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 21:09:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfJRZ-0005RG-Fd
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 21:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbYIOTH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYIOTH6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 15:07:58 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:44860 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490AbYIOTH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 15:07:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0B8AB52C3A8
	for <git@vger.kernel.org>; Mon, 15 Sep 2008 21:07:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJOr-xFv66Ft for <git@vger.kernel.org>;
	Mon, 15 Sep 2008 21:07:53 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 6485952C319
	for <git@vger.kernel.org>; Mon, 15 Sep 2008 21:07:53 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 975436DF823
	for <git@vger.kernel.org>; Mon, 15 Sep 2008 21:07:34 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 5215D1A4001; Mon, 15 Sep 2008 21:07:53 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95928>

Hello,

Here goes tig version 0.12 after several bug fixes and improvements have
accumulated. This is the first release with a proper NEWS file from
which the notes for this release is included below. The rendering code
has been cleaned up and simplified so if you notice any regressions,
such as slow downs, please report them. Enjoy!

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://repo.or.cz/tig.git 
 - Gitweb:	http://repo.or.cz/w/tig.git

Release notes
-------------
Improvements:

 - F5 also refreshes the current view.
 - Allow line graphics to be disabled with new line-graphics option.
 - Main view: also include the reference names when searching.
 - Main view: support for refreshing.
 - Main view: disable boundary commits by default. Use --boundary when
   they should be shown. (Debian bug 498628)
 - Stage view: add stage-next action to jump to next diff chunk that can
   be staged. By default bound to '@'.
 - Configure: check for the ncurses header files.
 - Add author-width option to costumize the width of the author column.
   For example, put the following in ~/.tigrc: set author-width = 10

Bug fixes:

 - Fix regression when staging all diff chunks in a section.
 - Bind the maximize view action to 'O'; it conflicted with the
   keybinding to launch the merge tool in the status view.
 - Fix problem with $(cmd) usage in shell code. Some shells (jsh)
   installed as /bin/sh does not support it.
 - Do not show incomplete boundary commits when --no-walk is used.
 - Documentation: Rename gitlink macro to support AsciiDoc 8.2.3.
 - Ignore pipe reads with errno "Success" reported after a signals,
   for example when refreshing doing background loading.

Change summary
--------------
The diffstat and shortlog summary for changes made in this release.

     3	Dominik Vogt
     1	Jeff King
    33	Jonas Fonseca
     1	Rodolfo Borges

 INSTALL       |    4 +
 Makefile      |   10 +-
 NEWS          |  164 +++++++++++
 TODO          |    3 +
 VERSION       |    2 +-
 asciidoc.conf |    7 +-
 configure.ac  |   26 +-
 manual.txt    |    5 +-
 tig.1.txt     |    4 +-
 tig.c         |  733 ++++++++++++++++++++++++++++---------------------
 tigrc.5.txt   |   14 +-
 11 files changed, 641 insertions(+), 331 deletions(-)

-- 
Jonas Fonseca
