From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH v2 5/6] run test suite without dashed git-commands in PATH
Date: Tue, 1 Dec 2009 22:49:57 -0700
Message-ID: <20091202054956.GA2089@comcast.net>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net> <m3fx7un7vb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 06:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFiCz-0006em-3I
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 06:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbZLBF4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 00:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbZLBF4t
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 00:56:49 -0500
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:45852 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035AbZLBF4t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 00:56:49 -0500
Received: from OMTA21.emeryville.ca.mail.comcast.net ([76.96.30.88])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id C5Tq1d0011u4NiLA35wwKp; Wed, 02 Dec 2009 05:56:56 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA21.emeryville.ca.mail.comcast.net with comcast
	id C5wu1d00H5FCJCg8h5wvRG; Wed, 02 Dec 2009 05:56:56 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 22DBD89115; Tue,  1 Dec 2009 22:49:57 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <m3fx7un7vb.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134303>

On Tue, Dec 01, 2009 at 09:24:46AM -0800, Jakub Narebski wrote:
> Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:
> > +--with-dashes::
> > +	By default tests are run without dashed forms of
> > +	commands (like git-commit) in the PATH (it only uses
> > +	wrappers from TOP/git-bin).  Use this option to include TOP
> > +	in the PATH, which conains all the dashed forms of commands.
> > +	This option is currently implied by other options like --valgrind
> > +	and GIT_TEST_INSTALLED.
> > +
> 
> Shouldn't it be 'TOP/bin-wrappers' and not 'TOP/git-bin'?  
> Shouldn't TOP be explained somewhere, or is it obvious in the context?
> 
> s/conains/contains/.

I've appended a incremental patch for these.

Junio, do you want me to re-roll the 3 bin-wrappers patches to
include both this and the "@@ vs __" patch, or do you want
to just add or squash them in from the emails?

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Date: Tue, 1 Dec 2009 22:16:19 -0700
Subject: [PATCH] t/README: fix spelling in --with-dashes documentation

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/README |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 8c5d892..dcd3ebb 100644
--- a/t/README
+++ b/t/README
@@ -78,10 +78,11 @@ appropriately before running "make".
 --with-dashes::
 	By default tests are run without dashed forms of
 	commands (like git-commit) in the PATH (it only uses
-	wrappers from TOP/git-bin).  Use this option to include TOP
-	in the PATH, which conains all the dashed forms of commands.
-	This option is currently implied by other options like --valgrind
-	and GIT_TEST_INSTALLED.
+	wrappers from ../bin-wrappers).  Use this option to include
+	the build directory (..) in the PATH, which contains all
+	the dashed forms of commands.  This option is currently
+	implied by other options like --valgrind and
+	GIT_TEST_INSTALLED.
 
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
-- 
1.6.4.GIT
