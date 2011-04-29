From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 0/8] --dirstat fixes, part 2
Date: Fri, 29 Apr 2011 11:36:15 +0200
Message-ID: <1304069783-22739-1-git-send-email-johan@herland.net>
References: <7vfwp13dme.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 11:36:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFk7u-0004FI-OG
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 11:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536Ab1D2Jgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 05:36:35 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52918 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab1D2Jge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 05:36:34 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00BLDQOVZU50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:31 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 6BF251EEFB59_DBA869FB	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:31 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4D0101EEFACB_DBA869FF	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:31 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00LICQOV8010@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:31 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <7vfwp13dme.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172434>

Hi,

Here's version 6 incorporating Junio's feedback regarding tests,
error messages, and i18n. The following patches have changed:

 - 1/8: Added test: 'various ways to misspell --dirstat'

 - 3/8: Added a couple of more misspellings to the above test

 - 7/8: Improved error message handling, and tests covering error messages

 - 8/8: New patch marking dirstat error messages for translation.

The new 8/8 patch WILL NOT COMPILE until the topic branch is merged with
an i18n/gettext-aware branch (i.e. where _() and test_i18ngrep is present).


Have fun! :)

...Johan

Johan Herland (8):
  Add several testcases for --dirstat and friends
  Make --dirstat=0 output directories that contribute < 0.1% of changes
  Refactor --dirstat parsing; deprecate --cumulative and --dirstat-by-file
  Add config variable for specifying default --dirstat behavior
  Allow specifying --dirstat cut-off percentage as a floating point number
  New --dirstat=lines mode, doing dirstat analysis based on diffstat
  Improve error handling when parsing dirstat parameters
  Mark dirstat error messages for translation

 Documentation/config.txt       |   44 ++
 Documentation/diff-options.txt |   54 ++-
 diff.c                         |  171 +++++++-
 diff.h                         |    3 +-
 t/t4047-diff-dirstat.sh        |  979 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1219 insertions(+), 32 deletions(-)
 create mode 100755 t/t4047-diff-dirstat.sh

-- 
1.7.5.rc1.3.g4d7b
