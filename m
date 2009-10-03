From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 4/7] imap-send: build imap-send on Windows
Date: Sat,  3 Oct 2009 00:39:42 +0000
Message-ID: <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Oct 03 02:40:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtsfd-0004T7-2t
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 02:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbZJCAkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 20:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbZJCAkE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 20:40:04 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:60096 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZJCAkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 20:40:03 -0400
Received: by mail-qy0-f173.google.com with SMTP id 3so1339018qyk.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 17:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jcj0Lrh6yynF9KRTKzA3vm0HMW9MkQlXRn72PQbLDEE=;
        b=oI99dfEZYbtvgLyjRLj3RaJnVKvsMnjo3+kKFq+ziDciQ055cy2/TURdCLAXCzSqE7
         T6sXi5q6xcU96FLJPXokOa5ykYZqsfkxbT63AP7YDxydZKnQaM1miI5e7KQaEoQSmfs6
         zTnXOVr8Uq9jwSR4HDnBbE1OLqyYVWBwIv5JI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yg2KUDBzOiX7MOIrpOoakQ+PsYcZN6Ijq82E+ojh/xxE6pAJdTGeNHWJxhNipY7n3N
         L5iW28XzPIPBYY8RUF4vvTlGqzp14j0j7D4j7QtboD4Ji4PSkdUUPRZW9UwIQ5+c6jmb
         DSQmbmjFgrAwNTEN87zZIpH7wZJlbbsROTkXk=
Received: by 10.224.24.136 with SMTP id v8mr1662105qab.79.1254530407535;
        Fri, 02 Oct 2009 17:40:07 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 20sm251988qyk.9.2009.10.02.17.40.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 17:40:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129474>

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
1.6.5.rc2.7.g4f8d3
