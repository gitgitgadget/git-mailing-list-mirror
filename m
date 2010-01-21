From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] rev-parse --branches/--tags/--remotes=pattern
Date: Thu, 21 Jan 2010 18:27:05 +0100
Message-ID: <201001211827.05847.trast@student.ethz.ch>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi> <4B584DDD.7060701@viscovery.net> <4B585BED.700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY0on-0002MX-94
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab0AUR11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673Ab0AUR1N
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:27:13 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:51548 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab0AUR1I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:27:08 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 21 Jan
 2010 18:27:08 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 21 Jan
 2010 18:27:06 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.4.59; x86_64; ; )
In-Reply-To: <4B585BED.700@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137674>

Thanks Ilari for implementing my wishes :-)

On Thursday 21 January 2010 14:51:41 Michael J Gruber wrote:
> Johannes Sixt venit, vidit, dixit 21.01.2010 13:51:
> > Works for me, thank you very much!
> > 
> > Junio, kindly squash in these speeling fixes in both patches:
> > 
> > sed -i 's/impiled/implied/g' `git diff HEAD^ --name-only Documentation/`
> > 
> 
> Also, the option descriptions are kind of staccato English right now,
> lacking a few "the" here and there. Should we fix this or simply leave
> it at that?

Maybe the --branches, --tags and --remotes could be consolidated a
bit, as in the draft patch below.  If --all took a pattern, it could
be included there too, but that would probably look too weird.

diff --git i/Documentation/git-rev-parse.txt w/Documentation/git-rev-parse.txt
index 2bbb566..6fce919 100644
--- i/Documentation/git-rev-parse.txt
+++ w/Documentation/git-rev-parse.txt
@@ -104,29 +104,26 @@ OPTIONS
 	Show all refs found in `$GIT_DIR/refs`.
 
 --branches[=pattern]::
-	Show branch refs found in `$GIT_DIR/refs/heads`. If `pattern`
-	is given, only branches matching given shell glob are shown.
-	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
-
 --tags[=pattern]::
-	Show tag refs found in `$GIT_DIR/refs/tags`. If `pattern`
-	is given, only tags matching given shell glob are shown.
-	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
-
 --remotes[=pattern]::
-	Show tag refs found in `$GIT_DIR/refs/remotes`. If `pattern`
-	is given, only remote tracking branches matching given shell glob
-	are shown. If pattern lacks '?', '*', or '[', '/*' at the end is
-	impiled.
+	Show all branches, tags, or remote-tracking branches,
+	respectively (i.e., refs found in `$GIT_DIR/refs/heads`,
+	`$GIT_DIR/refs/tags`, or `$GIT_DIR/refs/remotes`,
+	respectively).
++
+If a `pattern` is given, only refs matching the given shell glob are
+shown.  If the pattern does not contain a globbing character (`?`,
+`\*`, or `[`), it is anchored by appending `/\*`.
+
+--glob=pattern::
+	Show all refs matching the shell glob pattern `pattern`. If
+	the pattern does not start with `refs/`, this is automatically
+	prepended.  If the pattern does not contain a globbing
+	character (`?`, `\*`, or `[`), it is anchored by appending `/\*`.
 
 --show-toplevel::
 	Show the absolute path of the top-level directory.
 
---glob=glob-pattern::
-	Show refs matching shell glob pattern `glob-pattern`. If pattern
-	specified lacks leading 'refs/', it is automatically prepended.
-	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
-
 --show-prefix::
 	When the command is invoked from a subdirectory, show the
 	path of the current directory relative to the top-level


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
