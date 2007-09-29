From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.9.1
Date: Sun, 30 Sep 2007 00:14:39 +0200
Message-ID: <20070929221439.GA23150@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 00:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibkc5-000827-3I
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556AbXI2WQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbXI2WQa
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:16:30 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:47599 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500AbXI2WQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:16:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0356F601816
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 00:16:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZeRyzrALL6ic for <git@vger.kernel.org>;
	Sun, 30 Sep 2007 00:16:26 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5DF0B6018C8
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 00:14:40 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 657036DFD3D
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 00:09:31 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 329A063292; Sun, 30 Sep 2007 00:14:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59501>

Hello,

I would like to announce the next installment of tig, which mainly
brings a bunch of fixes. However, there was also room for a few new
features, such as support for cherry-picking to the current branch
(bound to 'C' by default), refreshing of the status view (bound to 'R'),
as well as better handling of unmerged entries in the status view by
suggesting users to launch git-mergetool (by default wired to 'M').

For tig-0.10, I hope to finally get time to finish splitting up the
tig.c file into more manageable pieces. It might also be the release
that will try to get handling of different encodings right by using
wchar_t.

What is tig?
------------
Tig is a ncurses-based text-mode interface for git. It can mainly
function as a git repository browser but can also additionally can act
as a pager for output from various git commands.

 Homepage:	http://jonas.nitro.dk/tig/
 Manual:	http://jonas.nitro.dk/tig/manual.html
 Tarballs:	http://jonas.nitro.dk/tig/releases/
 Gitfeed:	git://repo.or.cz/tig.git
 Gitweb:	http://repo.or.cz/w/tig.git

Changes in this release
-----------------------
Below is the diffstat and shortlog for changes made in this release.

 .gitignore   |    2 +
 Makefile     |   26 +++++---
 SITES        |    2 +-
 VERSION      |    2 +-
 acinclude.m4 |   62 ++++++++++++++++++
 configure.ac |   41 +------------
 manual.txt   |    4 +
 tig.1.txt    |    4 +
 tig.c        |  198 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 tigrc.5.txt  |    3 +
 10 files changed, 265 insertions(+), 79 deletions(-)

Jonas Fonseca (21):
      tig-0.9.1.git
      Use the more advanced iconv.m4 script from ELinks
      Oops, always ensure that ICONV_CONST is defined
      Support cherry-picking commits in main view to current branch
      Handle REQ_NONE upfront in view_driver
      Fix open_editor to make the file path relative to the project root
      Fix out-of-range lineno when reloading the status view
      Fix the clean rule to never remove generated doc files
      Include autoconf file for 'make dist'
      Remove unused 'view' argument from open_editor
      Add support for refreshing/reloading the status view
      Also ignore generated .md5 files for tarballs
      Never put the release number in the tarball name for tagged versions
      Ignore REQ_NONE in the help view and improve unbound request handling
      Document the refresh request
      Detect working trees and disable the status view when it is missing
      Refactor code to open_external_viewer
      Add support for launching git-mergetool from the status view
      Cleanup status_request to make it reload the status view by default
      SITES: 'Tarballs' is a bit more telling than 'Releases'
      tig-0.9.1

-- 
Jonas Fonseca
