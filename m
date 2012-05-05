From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: [PATCH v2] Update Documentation/git-config to reflect --local option.
Date: Sat, 05 May 2012 12:03:52 +0200
Message-ID: <4557278.eakEfj5iWL@flomedio>
References: <1754870.q6d2rgDqBT@flobuntu> <7vr4v0deyg.fsf@alter.siamese.dyndns.org> <20120504032400.GB2589@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	davidbarr@google.com, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 12:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQbqc-0004cB-NS
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 12:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab2EEKEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 06:04:13 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:12837 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab2EEKEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 06:04:11 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q45A3sMG005938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 May 2012 12:03:54 +0200 (CEST)
User-Agent: KMail/4.8.2 (Linux/3.2.0-24-generic; KDE/4.8.2; x86_64; ; )
In-Reply-To: <20120504032400.GB2589@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197103>

Describe config file selection in git-config.
While the usage message of git-config shows --local,
the documentation page did not contain anything about that.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
Updated with the formulation suggested by Junio.

 Documentation/git-config.txt |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 81b0398..3f5d216 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -44,11 +44,15 @@ a "true" or "false" string for bool), or '--path', which does some
 path expansion (see '--path' below).  If no type specifier is passed, no
 checks or transformations are performed on the value.
 
-The file-option can be one of '--system', '--global' or '--file'
-which specify where the values will be read from or written to.
-The default is to assume the config file of the current repository,
-.git/config unless defined otherwise with GIT_DIR and GIT_CONFIG
-(see <<FILES>>).
+When reading, the values are read from the system, global and
+repository local configuration files by default, and options
+'--system', '--global', '--local' and '--file <filename>' can be
+used to tell the command to read from only that location (see <<FILES>>).
+
+When writing, the new value is written to the repository local
+configuration file by default, and options '--system', '--global',
+'--file <filename>' can be used to tell the command to write to
+that location (you can say '--local' but that is the default).
 
 This command will fail (with exit code ret) if:
 
-- 
1.7.9.5
