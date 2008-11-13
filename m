From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] Documentation: New GUI configuration and command-line options.
Date: Thu, 13 Nov 2008 20:28:49 +0300
Organization: HOME
Message-ID: <200811132028.49450.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 18:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0g3C-0003FN-OI
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 18:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbYKMRax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 12:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbYKMRax
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 12:30:53 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:23486 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbYKMRaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 12:30:52 -0500
Received: by mu-out-0910.google.com with SMTP id g7so978067muf.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 09:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qLfHppAJPpqoVSYjJmMT1OM07YRbN5F+U+VDdK9uFqo=;
        b=spOcA20idVx1CLnWGDvbpu2tIx7OdaN3UgP4iZk9pnCaGneDWO+iXHBEQM+IOWeCwa
         FGR2N1wHGSLu82CH8D8qjnVQv75C7kId61esnWVdphmKs5eHF+SLxDNWr9qcYHhZyVPw
         hd1M4ym6+nRPLQDNPSeNT3DykltEOc4FJTfG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=gyGaKEKfk2SgP8CgFRPy9oaQEk6R+XqWjSmQ5epG3SsWbRI6cX3THmpMFuq+/dB09c
         iyMf0stXlfxbaJ+sFinJCPS5ON90xf9tEtXv7SfQC1oAnX3dCy8axQuMTVy/O4to/mYN
         Y3WlIVgIO70CS4uKkio3HMSfhq6gyIGwpwXvE=
Received: by 10.181.203.11 with SMTP id f11mr3231908bkq.112.1226597450389;
        Thu, 13 Nov 2008 09:30:50 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 28sm5570684fkx.1.2008.11.13.09.30.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 09:30:49 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100890>

Add information on new git-gui and gitk command-line options,
configuration variables, and the encoding attribute.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 Documentation/config.txt        |   24 ++++++++++++++++++++++++
 Documentation/git-gui.txt       |   19 +++++++++++++++++++
 Documentation/gitattributes.txt |   17 +++++++++++++++++
 Documentation/gitk.txt          |    5 +++++
 4 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 965ed74..2223dc4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -796,6 +796,14 @@ gui.diffcontext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
 
+gui.encoding::
+	Specifies the default encoding to use for displaying of
+	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
+	It can be overridden by setting the 'encoding' attribute
+	for relevant files (see linkgit:gitattributes[5]).
+	If this option is not set, the tools default to the
+	locale encoding.
+
 gui.matchtrackingbranch::
 	Determines if new branches created with linkgit:git-gui[1] should
 	default to tracking remote branches with matching names or
@@ -818,6 +826,22 @@ gui.spellingdictionary::
 	the linkgit:git-gui[1]. When set to "none" spell checking is turned
 	off.
 
+gui.fastcopyblame::
+	If true, 'git gui blame' uses '-C' instead of '-C -C' for original
+	location detection. It makes blame significantly faster on huge
+	repositories at the expense of less thorough copy detection.
+
+gui.copyblamethreshold::
+	Specifies the theshold to use in 'git gui blame' original location
+	detection, measured in alphanumeric characters. See the
+	linkgit:git-blame[1] manual for more information on copy detection.
+
+gui.blamehistoryctx::
+	Specifies the radius of history context in days to show in
+	linkgit:gitk[1] for the selected commit, when the `Show History
+	Context` menu item is invoked from 'git gui blame'. If this
+	variable is set to zero, the whole history is shown.
+
 help.browser::
 	Specify the browser that will be used to display help in the
 	'web' format. See linkgit:git-help[1].
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 0e650f4..d0bc98b 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -65,9 +65,28 @@ git gui blame v0.99.8 Makefile::
 	example the file is read from the object database and not
 	the working directory.
 
+git gui blame --line=100 Makefile::
+
+	Loads annotations as described above and automatically
+	scrolls the view to center on line '100'.
+
 git gui citool::
 
 	Make one commit and return to the shell when it is complete.
+	This command returns a non-zero exit code if the window was
+	closed in any way other than by making a commit.
+
+git gui citool --amend::
+
+	Automatically enter the 'Amend Last Commit' mode of
+	the interface.
+
+git gui citool --nocommit::
+
+	Behave as normal citool, but instead of making a commit
+	simply terminate with a zero exit code. It still checks
+	that the index does not contain any unmerged entries, so
+	you can use it as a GUI version of linkgit:git-mergetool[1]
 
 git citool::
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index eb64841..e02899f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -495,6 +495,23 @@ in the file.  E.g. the string `$Format:%H$` will be replaced by the
 commit hash.
 
 
+Viewing files in GUI tools
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`encoding`
+^^^^^^^^^^
+
+The value of this attribute specifies the character encoding that should
+be used by GUI tools (e.g. linkgit:gitk[1] and linkgit:git-gui[1]) to
+display the contents of the relevant file. Note that due to performance
+considerations linkgit:gitk[1] does not use this attribute unless you
+manually enable per-file encodings in its options.
+
+If this attribute is not set or has an invalid value, the value of the
+`gui.encoding` configuration variable is used instead
+(See linkgit:git-config[1]).
+
+
 USING ATTRIBUTE MACROS
 ----------------------
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index ae29a00..317f631 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -56,6 +56,11 @@ frequently used options.
 	Use this instead of explicitly specifying <revs> if the set of
 	commits to show may vary between refreshes.
 
+--select-commit=<ref>::
+
+	Automatically select the specified commit after loading the graph.
+	Default behavior is equivalent to specifying '--select-commit=HEAD'.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
-- 
1.6.0.3.15.gb8d36
