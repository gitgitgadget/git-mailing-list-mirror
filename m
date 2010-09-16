From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Thu, 16 Sep 2010 11:31:03 +0200
Message-ID: <1284629465-14798-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwApE-0007gF-En
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0IPJbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:31:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52672 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0IPJbu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:31:50 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so1146293wyf.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cNxPtY5kXsDYwgl2xAWJ0Gry1KD1Cm9lupdAtBLRkss=;
        b=iwtH97VDqtAxgNgbmQeWq38fW12XF0LL6IiwdhFrCYX883KMGc7+q29wM/MENdJbo6
         XmZKnDiMEteWDxrzLLJiR0zBY8VxXumR7PRwgb/DOo6Ji4i3cPhmiBRm2Om8DQW7v4MO
         D2XmdnCoPwtztO6xDlN5CjFOi7V3snrYj9Ht8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wZFoVLmh16xe6uJXrKmYEjTlfSUfXibT9Sz3Nb9Sx+LB9Ze4dvuXxdfgZJzosYaM2q
         fzCJzEhsgli79tozHWIvaFXIMNieQ5ahc70u4AC7HZ/o4uNe8K7S7ktR6vfWOkXdWEER
         rnTnRtC7jbXbqQ7IO++DaGD1LKD3TZu0H8yf0=
Received: by 10.216.181.84 with SMTP id k62mr2434630wem.76.1284629509901;
        Thu, 16 Sep 2010 02:31:49 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id n40sm1669398weq.5.2010.09.16.02.31.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:31:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
In-Reply-To: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156310>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6138c6e..92551e4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3765,6 +3765,21 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+sub git_begin_group {
+	my ($class, $id, @rest) = @_;
+
+	$class = ' class="' . join(' ', 'group', $class) . '"';
+
+	$id = ' id="' . $id . '"' if $id;
+
+	print "<div$class$id>\n";
+	git_print_header_div(@rest);
+}
+
+sub git_end_group {
+	print "</div>\n"
+}
+
 sub print_local_time {
 	print format_local_time(@_);
 }
-- 
1.7.3.rc1.230.g8b572
