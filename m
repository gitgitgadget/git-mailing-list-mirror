From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 5/8] imap-send: build imap-send on Windows
Date: Fri,  9 Oct 2009 17:04:39 +0200
Message-ID: <1255100682-13952-5-git-send-email-kusmabite@gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-3-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-4-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH8B-0007fT-RW
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761068AbZJIPG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761065AbZJIPG2
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:06:28 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:37056 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758754AbZJIPG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:06:27 -0400
Received: by ewy4 with SMTP id 4so697776ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4WCRx8OMbL+ZPDUUl8qqhA99k6Wei9fW+s3SaXmpq40=;
        b=IUQTPdCHkOWw2EcKN+M6WldgBj/7POGJsrx22EngZ5oJFqpeo2Ihb3AHQE9mI9i2RM
         +J+NibN8o4NpE/soCClSpUPkGDeIJYSFoLUG9Xl66Ys3TRynsR2ABQi52g5haoo3wOXJ
         V/E8hqr3r4wKnAJ7xgXE3Rn8ch6oHyV69Uqrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rf5rndYf0aLhlyRYBKbNeuz0UQYcwjhu/bcboZYMeGi7ukQUd1jRKOI/Xikgp8GLD+
         Nxc85c4CoOU+xCeceT5YvsG2QZXXkU/zoBNEZkMsZWvxes8RGKBQjXbdXMsR6cAZlGYf
         1YIPjpIXfMYHcExgJ3QpdCg9gjqWJzc/3FiXM=
Received: by 10.211.159.11 with SMTP id l11mr3321310ebo.78.1255100750498;
        Fri, 09 Oct 2009 08:05:50 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 28sm338349eyg.36.2009.10.09.08.05.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:05:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255100682-13952-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129815>

Since the POSIX-specific tunneling code has been replaced
by the run-command API (and a compile-error has been
cleaned away), we can now enable imap-send on Windows
builds.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 12defd4..8ba789a 100644
--- a/Makefile
+++ b/Makefile
@@ -361,6 +361,7 @@ PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-imap-send$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
@@ -1056,7 +1057,6 @@ EXTLIBS += -lz
 
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS += git-daemon$X
-	PROGRAMS += git-imap-send$X
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
-- 
1.6.5.rc1.60.g41795
