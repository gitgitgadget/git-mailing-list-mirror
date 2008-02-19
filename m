From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] format-patch header improvements, --cc
Date: Tue, 19 Feb 2008 02:40:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802190227500.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:41:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRN62-0006Hp-L3
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758456AbYBSHkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757738AbYBSHkW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:40:22 -0500
Received: from iabervon.org ([66.92.72.58]:33327 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272AbYBSHkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:40:21 -0500
Received: (qmail 16190 invoked by uid 1000); 19 Feb 2008 07:40:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 07:40:20 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74382>

This series improves the handling of extra headers in format-patch:

 - extra headers should get tested in the test suite

 - it shouldn't be necessary to have \n in the config file in order to 
   have multiple extra headers. (It's actually challenging to test having 
   newlines in values in the config file, let alone set things up that way 
   for an end user...)

 - multiple "to:" headers, or multiple "cc:" headers should be combined by 
   the program, without requiring the user to do it.

Finally, the series adds a --cc=<email> option, which can be used to CC 
people who are reviewing this particular series and may not be interested 
in your patches in general otherwise.

This series is based on the cover-letter series, but the changes are 
actually independant; they are just adjacent to each other, and generate a 
lot of conflicts if applied separately and merged.

I messed up some extra whitespace initially, corrected it in the patches, 
but didn't regenerate the cover letter, so the diffstat will be off by two 
blank lines not actually added.

Daniel Barkalow (4):
      Add tests for extra headers in format-patch
      Fix format.headers not ending with a newline
      Combine To: and Cc: headers
      Support a --cc=<email> option in format-patch

 Documentation/git-format-patch.txt |    5 ++
 builtin-log.c                      |   80 +++++++++++++++++++++++++++++++----
 t/t4014-format-patch.sh            |   42 +++++++++++++++++++
 3 files changed, 117 insertions(+), 10 deletions(-)
