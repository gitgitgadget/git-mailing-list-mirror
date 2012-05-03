From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: [PATCH] Update Documentation/git-config to reflect --local option.
Date: Fri, 04 May 2012 00:44:21 +0200
Message-ID: <1754870.q6d2rgDqBT@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: davidbarr@google.com, florian.achleitner.2.6.31@gmail.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 00:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ4m5-0003Ti-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 00:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951Ab2ECWpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 18:45:20 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:20428 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab2ECWpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 18:45:19 -0400
Received: from flobuntu.localnet (m-149.vc-graz.ac.at [193.170.224.149])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q43MjDqV023163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 May 2012 00:45:13 +0200 (CEST)
User-Agent: KMail/4.8.2 (Linux/3.2.0-24-generic; KDE/4.8.2; x86_64; ; )
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.3
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196972>

Describe config file selection in git-config.
While the usage message of git-config shows --local,
the documentation page did not contain anything about that.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
This was pointed out in http://thread.gmane.org/gmane.comp.version-
control.git/196326

 Documentation/git-config.txt |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 81b0398..bda8bbb 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -44,10 +44,13 @@ a "true" or "false" string for bool), or '--path', which 
does some
 path expansion (see '--path' below).  If no type specifier is passed, no
 checks or transformations are performed on the value.
 
-The file-option can be one of '--system', '--global' or '--file'
+The file-option can be one of '--system', '--global', '--local', or '--file'
 which specify where the values will be read from or written to.
 The default is to assume the config file of the current repository,
-.git/config unless defined otherwise with GIT_DIR and GIT_CONFIG
+.git/config unless defined otherwise with GIT_DIR and GIT_CONFIG.
+For read commands like '--get' the default is to search local, global, and
+system config files (in this order) for the requested value and stop after
+the first finding.
 (see <<FILES>>).
 
 This command will fail (with exit code ret) if:
-- 
1.7.9.5
