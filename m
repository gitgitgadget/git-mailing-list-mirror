From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] gitk: Update cherry-pick error message parsing
Date: Wed, 19 Jan 2011 14:45:00 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1101191441430.23868@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:45:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfdxv-0007VT-4U
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab1ASTpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jan 2011 14:45:06 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:45061 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753275Ab1ASTpE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:45:04 -0500
X-AuditID: 12074425-b7c98ae000000a04-8d-4d373f3f2440
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 7E.96.02564.F3F373D4; Wed, 19 Jan 2011 14:45:03 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p0JJj2qS026793;
	Wed, 19 Jan 2011 14:45:03 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p0JJj0go019805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 19 Jan 2011 14:45:01 -0500 (EST)
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165284>

Commit 981ff5c37ae20687c98d98c8689d5e89016026d2 changed the error
message from git cherry-pick from
    Automatic cherry-pick failed.  [...advice...]
to
    error: could not apply 7ab78c9... Do something neat.
    [...advice...]

Update gitk=E2=80=99s regex to match this, restoring the ability to lau=
nch git
citool to resolve conflicted cherry-picks.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 9cbc09d..a0f7816 100755
--- a/gitk
+++ b/gitk
@@ -9063,7 +9063,7 @@ proc cherrypick {} {
 			to file '%s'.\nPlease commit, reset or stash\
 			your changes and try again." $fname]
 	} elseif {[regexp -line \
-		       {^(CONFLICT \(.*\):|Automatic cherry-pick failed)} \
+		       {^(CONFLICT \(.*\):|Automatic cherry-pick failed|error: could=
 not apply)} \
 		       $err]} {
 	    if {[confirm_popup [mc "Cherry-pick failed because of merge\
 			conflict.\nDo you wish to run git citool to\
--=20
1.7.4.rc1
