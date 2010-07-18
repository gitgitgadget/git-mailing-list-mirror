From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] Documentation: Explain git-mergetool's use of temporary files
Date: Sat, 17 Jul 2010 18:46:48 -0700
Message-ID: <1279417608-6442-1-git-send-email-davvid@gmail.com>
Cc: Charles Bailey <charles@hashpling.org>,
	The Best VCS <git@vger.kernel.org>,
	Chris Cheney <chris.cheney.nospam@tesco.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 03:47:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaIyF-0008Qr-6n
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 03:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab0GRBq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 21:46:56 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36577 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0GRBqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 21:46:55 -0400
Received: by pxi14 with SMTP id 14so1394871pxi.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=a2o0MvvFLkVKxxpzWl3nsAeCWgq+nEzetXtmEpNfNqc=;
        b=uvRTc+3usnmz7OAx/6TcqUkDxlQlrWsHs5TdHNedtVeuVvDL4W8bEWAUqG4NBMyNGi
         XKVZtMXqHhXmKrLzNUBP5W2f8+kBfziph/XqMv2PnWEGWnghew9aPwihLAmVRB+2geWT
         3cnSeUnqNXLcOnRGvRnQuPZOJ/uBOwkuPGBTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vgTQwjH60w5K2z3hLfPb468HX/lwqsyLjEGKFGkc7tnwgT79QkcB3l/P+ygbUj+YAm
         79FPPhHb93VoLfQVyI5B262LKlbpxi2H2TeRWmYXwzbKdmOTOrZgyWR6xFnsKh37EmeU
         H6iDa8xrwIliJp6r1IQHWH3mRLCgMMa+DXiJQ=
Received: by 10.114.47.4 with SMTP id u4mr4296723wau.58.1279417615230;
        Sat, 17 Jul 2010 18:46:55 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c24sm49546969wam.19.2010.07.17.18.46.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 18:46:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.10.g637ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151201>

'git mergetool' creates '*.orig' backup files in its
default configuration.  Mention this in its documentation.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-mergetool.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 55735fa..e4ed016 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -72,6 +72,16 @@ success of the resolution after the custom tool has exited.
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
+TEMPORARY FILES
+---------------
+`git mergetool` creates `*.orig` backup files while resolving merges.
+These are safe to remove once a file has been merged and its
+`git mergetool` session has completed.
+
+Setting the `mergetool.keepBackup` configuration variable to `false`
+causes `git mergetool` to automatically remove the backup as files
+are successfully merged.
+
 Author
 ------
 Written by Theodore Y Ts'o <tytso@mit.edu>
-- 
1.7.2.rc2.10.g637ab
