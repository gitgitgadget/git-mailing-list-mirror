From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH] gitweb: recognize six digit abbreviated SHA1
Date: Tue, 13 Jan 2009 01:04:40 +0100
Message-ID: <87mydw2hrb.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 01:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWnI-0004X8-Cl
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbZAMAEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbZAMAEo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:04:44 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:40899 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbZAMAEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:04:44 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id A618630B04;
	Tue, 13 Jan 2009 01:03:58 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 5DFAF308D0;
	Tue, 13 Jan 2009 01:03:58 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105420>

This lets gitweb hightlight abbreviated hashes as produced by
git rev-parse --short.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

It seems like seven digit hashes are in vogue now. So, did I miss some
reason for keeping it at eight in this spot?


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0ac84d1..1a7d448 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1337,7 +1337,7 @@ sub format_log_line_html {
 	my $line = shift;
 
 	$line = esc_html($line, -nbsp=>1);
-	if ($line =~ m/([0-9a-fA-F]{8,40})/) {
+	if ($line =~ m/([0-9a-fA-F]{7,40})/) {
 		my $hash_text = $1;
 		my $link =
 			$cgi->a({-href => href(action=>"object", hash=>$hash_text),
-- 
1.6.0.2.514.g23abd3
