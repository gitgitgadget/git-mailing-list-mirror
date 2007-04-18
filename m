From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/7] gitweb: show "no difference" message for empty diff
Date: Wed, 18 Apr 2007 15:52:47 +0200
Message-ID: <200704181552.48363.jnareb@gmail.com>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Thu Apr 19 01:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeJrF-00045z-0G
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 01:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992999AbXDRXqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 19:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993002AbXDRXqX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 19:46:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:65212 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992999AbXDRXqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 19:46:22 -0400
Received: by ug-out-1314.google.com with SMTP id 44so526745uga
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 16:46:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h9KhWZ5aQWPUtaVhpOUJv/15By1W/WrhP2xq6IKw+AsUyfTbNIs85uQQrr5WQJgIV4bbyvKt+KXbWc/oKjQCJcn4NK8IKC8A671u03U5ahle9cejD6plqRrwPyukZ5wCNsKFZ5U+VVQzKTdL/0KbNb6UyOwQdyR1u9erKQxnxxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SFi7nGSUvnsIxG2XK2lRmNssOFvmdfaO/T760+4ZwCcXP/KjVlwFn6vZPzqwChMWFM9ArcGsCrZ8Ff9VF9bTPus5SgIKnoug4Z6rRp1k9vSayKjdM0ehXSEwA70lVlvhJ0peEjyCJOZzIAhouxcSgYOS0yir4QcYzrajv4URZwQ=
Received: by 10.82.146.14 with SMTP id t14mr1859759bud.1176939980800;
        Wed, 18 Apr 2007 16:46:20 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id i5sm1219818mue.2007.04.18.16.46.17;
        Wed, 18 Apr 2007 16:46:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44964>

On Sun, Apr 15, 2007, Martin Koegler wrote:
> Currently, gitweb shows only header and footer, if no differences are
> found. This patch adds a "No differences found" message for the html
> output.
> 
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
> $patch_idx does not work, so I need a new variable.

Nice work.

> The css style for the no difference message is useable. If somebody
> does not like, feel free to send a patch with a better layout.

I like it, although I'd rather have "quieter" CSS style for the
"No differences found" message. But it is I think a matter of taste.

Below your patch with my changes.

-- >8 --
From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/7] gitweb: Show "no difference" message for empty diff

Currently, gitweb shows only header and footer, if no differences are
found. This patch adds a "No differences found" message for the html
output.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5e40292..2b023bd 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -387,6 +387,10 @@ div.diff.incomplete {
 	color: #cccccc;
 }
 
+div.diff.nodifferences {
+	font-weight: bold;
+	color: #600000;
+}
 
 div.index_include {
 	border: solid #d9d8d1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c48b35a..cbd8d03 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2398,6 +2398,7 @@ sub git_patchset_body {
 	my ($fd, $difftree, $hash, $hash_parent) = @_;
 
 	my $patch_idx = 0;
+	my $patch_number = 0;
 	my $patch_line;
 	my $diffinfo;
 	my (%from, %to);
@@ -2419,6 +2420,7 @@ sub git_patchset_body {
 		# git diff header
 		#assert($patch_line =~ m/^diff /) if DEBUG;
 		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
+		$patch_number++;
 		push @diff_header, $patch_line;
 
 		# extended diff header
@@ -2581,6 +2583,7 @@ sub git_patchset_body {
 	} continue {
 		print "</div>\n"; # class="patch"
 	}
+	print "<div class=\"diff nodifferences\">No differences found</div>\n" if (!$patch_number);
 
 	print "</div>\n"; # class="patchset"
 }
-- 
1.5.1
