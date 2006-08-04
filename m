From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 1/4] gitweb: blame table row no highlight fix
Date: Fri, 4 Aug 2006 15:09:59 -0700 (PDT)
Message-ID: <20060804220959.8423.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Aug 05 00:10:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97ro-0001gm-Mb
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161523AbWHDWKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161525AbWHDWKA
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:10:00 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:9339 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161523AbWHDWKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:10:00 -0400
Received: (qmail 8425 invoked by uid 60001); 4 Aug 2006 22:09:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3tf3RM345EmVi66wOlXZ6Wguonj4kKDZEPNV0q1CWRel7Q8Z9TVMqbig3gDr/VDBruZ0vNvsCmH/sIMPTjeLHbUDKv2sMj18gseAlPwa2uWw4IZq1PHp3uL6lnu/0Cvfwc74uLfoC7icutcGPStFtQf7Iakxxs/5Xh1lkb7psx8=  ;
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Fri, 04 Aug 2006 15:09:59 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24850>

Until now blame just used the commit/tree/tags/etc style of
highlight-able table rows, which have strictly alternating
light/dark rows. This is very annoying in blame, since the
text is static and it interferes with the per-revision block
highlight.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 460e728..47c1ade 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -171,6 +171,10 @@ tr.dark {
 	background-color: #f6f6f0;
 }
 
+tr.dark2 {
+	background-color: #f6f6f0;
+}
+
 tr.dark:hover {
 	background-color: #edece6;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 58eb5b1..049f27e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1493,7 +1493,7 @@ sub git_blame2 {
 	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype);
-	my @rev_color = (qw(light dark));
+	my @rev_color = (qw(light2 dark2));
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
 	my $last_rev;
-- 
1.4.2.rc3.g6df3
