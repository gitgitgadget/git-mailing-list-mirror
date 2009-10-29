From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 3/7] Add notify and warn to util.py
Date: Wed, 28 Oct 2009 23:40:22 -0700
Message-ID: <1256798426-21816-4-git-send-email-srabbelier@gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3OpA-0005ZL-4L
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbZJ2GtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756472AbZJ2GtW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:49:22 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63668 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451AbZJ2GtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:49:21 -0400
Received: by mail-pw0-f42.google.com with SMTP id 9so1254429pwj.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MHtV3DDykqnC7zQn5qMC4A0kvvlIRjfiydlBLw6Sno0=;
        b=yA5SmolMUCj0ySs30/tkoQRlC2GjK4t0hSI36SCjl47BukyZsUbA8JqLEngWDt6Zr2
         achvbSrMsypQq+Q5GbIBT2dNbSbAyFmDZwL34RYZFWneDc8qJcwvKexn/xIH/YPfKmsR
         HDMgazn+ZURL++zNYQ216ONwOQpC2r/zjlSHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AlYUa37OSoxgd1uvlOaKVBMdi9NHFfTARmJxxNRAC207MEn1/mX4Goh3qfhEF64eqf
         0XBntMqES9cUsT5HG5hSh2njLdhl9RLIm4VL3D8tq1EQZmjkqjFMdJdKBv4m+HJj2/qh
         7usKy+F2PHB+f4uteeoCoj7XyG+0Xo4eIBrZI=
Received: by 10.115.26.2 with SMTP id d2mr5645273waj.14.1256798489835;
        Wed, 28 Oct 2009 23:41:29 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm401242pxi.1.2009.10.28.23.41.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:41:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131565>

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	These turned out to be quite useful for my git-remote-hg, if
	desired this patch can move to later in the series, but I
	figured that it might be useful to someone else already.

 git_remote_helpers/util.py |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git_remote_helpers/util.py b/git_remote_helpers/util.py
index 7d6adb4..d3ca487 100644
--- a/git_remote_helpers/util.py
+++ b/git_remote_helpers/util.py
@@ -15,6 +15,10 @@ import subprocess
 # Whether or not to show debug messages
 DEBUG = False
 
+def notify(msg, *args):
+	"""Print a message to stderr."""
+	print >> sys.stderr, msg % args
+
 def debug (msg, *args):
     """Print a debug message to stderr when DEBUG is enabled."""
     if DEBUG:
@@ -24,6 +28,10 @@ def error (msg, *args):
     """Print an error message to stderr."""
     print >> sys.stderr, "ERROR:", msg % args
 
+def warn(msg, *args):
+	"""Print a warning message to stderr."""
+	print >> sys.stderr, "warning:", msg % args
+
 def die (msg, *args):
     """Print as error message to stderr and exit the program."""
     error(msg, *args)
-- 
1.6.5.2.291.gf76a3
