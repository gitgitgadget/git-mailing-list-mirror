From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 1/4] gitk: Update cherry-pick error message parsing
Date: Fri, 19 Nov 2010 02:38:17 -0500
Message-ID: <1290152300-21393-1-git-send-email-andersk@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 08:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJLYb-0002wQ-En
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 08:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab0KSHiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 02:38:24 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:44006 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257Ab0KSHiY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 02:38:24 -0500
X-AuditID: 1209190f-b7c1dae000000a2b-c5-4ce6296f0ad8
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 56.7C.02603.F6926EC4; Fri, 19 Nov 2010 02:38:23 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id oAJ7cLrF024242;
	Fri, 19 Nov 2010 02:38:21 -0500
Received: from localhost (ET-TWENTY-THREE.MIT.EDU [18.208.1.23])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oAJ7cKSC019333;
	Fri, 19 Nov 2010 02:38:21 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161728>

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
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..dbc8f86 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9002,7 +9002,7 @@ proc cherrypick {} {
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
1.7.3.2
