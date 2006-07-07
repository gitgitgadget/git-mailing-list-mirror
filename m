From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] Add "raw" output option to blobs in "tree" view format
Date: Thu, 6 Jul 2006 23:39:30 -0700 (PDT)
Message-ID: <20060707063930.7752.qmail@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1031073099-1152254370=:6902"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 07 08:39:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyjzy-0007Xy-Up
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 08:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWGGGjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 02:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGGGjb
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 02:39:31 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:4499 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750752AbWGGGjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 02:39:31 -0400
Received: (qmail 7754 invoked by uid 60001); 7 Jul 2006 06:39:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dSZwWHigShVLxr0GYqrxIoThPNgOUiTe+DufD1OaxhIMA3ZmH+s8lldfyyLFAtyLHzfeWkbDtOFBNFoThm7AzenEVRFbF7u5Kwf/zfAFpCuYucm03L6B13b2kTiL7cbfGdmhAUM8nMsxx6KgSaEG2pqbTV7zowcqwW86D0MKq90=  ;
Received: from [68.186.48.129] by web31805.mail.mud.yahoo.com via HTTP; Thu, 06 Jul 2006 23:39:30 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23413>

--0-1031073099-1152254370=:6902
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Add a "raw" output option to blobs in "tree" view format, so that the
user doesn't have to click on "blob", wait for the (binary) file to be
uploaded and shown in "blob" mode, and then click on "plain" to
download the (binary) file.

This is useful when the file is clearly binary and we don't want the
browser to upload and display it in "blob" mode, but we just want to
download it.  Case in point: pdf files, wlg.

Note: the "raw" format is equivalent to the blob->plain view, not
blob->head view. I.e. the view has the hash of the file as listed
by git-ls-tree, not just "HEAD".

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 3e2790c..cce0753 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1668,6 +1668,7 @@ sub git_tree {
 			      $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=blob;h=$t_hash$base_key;f=$base$t_name")}, "blob") .
 #			      " | " . $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=blame;h=$t_hash$base_key;f=$base$t_name")}, "blame") .
 			      " | " . $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=history;h=$hash_base;f=$base$t_name")}, "history") .
+			      " | " . $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=blob_plain;h=$t_hash;f=$base$t_name")}, "raw") .
 			      "</td>\n";
 		} elsif ($t_type eq "tree") {
 			print "<td class=\"list\">" .
-- 
1.4.1.g88ada
--0-1031073099-1152254370=:6902
Content-Type: application/octet-stream; name="patch.patch"
Content-Transfer-Encoding: base64
Content-Description: 2829251161-patch.patch
Content-Disposition: attachment; filename="patch.patch"

MjZmMDM0ZGM3YmYzMGU2NzVkNTNkYTRmMjE1Y2EyZTFlNmI4OGQxZgpkaWZm
IC0tZ2l0IGEvZ2l0d2ViL2dpdHdlYi5jZ2kgYi9naXR3ZWIvZ2l0d2ViLmNn
aQppbmRleCAzZTI3OTBjLi5jY2UwNzUzIDEwMDc1NQotLS0gYS9naXR3ZWIv
Z2l0d2ViLmNnaQorKysgYi9naXR3ZWIvZ2l0d2ViLmNnaQpAQCAtMTY2OCw2
ICsxNjY4LDcgQEAgc3ViIGdpdF90cmVlIHsKIAkJCSAgICAgICRjZ2ktPmEo
ey1ocmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2plY3Q7
YT1ibG9iO2g9JHRfaGFzaCRiYXNlX2tleTtmPSRiYXNlJHRfbmFtZSIpfSwg
ImJsb2IiKSAuCiAjCQkJICAgICAgIiB8ICIgLiAkY2dpLT5hKHstaHJlZiA9
PiAiJG15X3VyaT8iIC4gZXNjX3BhcmFtKCJwPSRwcm9qZWN0O2E9YmxhbWU7
aD0kdF9oYXNoJGJhc2Vfa2V5O2Y9JGJhc2UkdF9uYW1lIil9LCAiYmxhbWUi
KSAuCiAJCQkgICAgICAiIHwgIiAuICRjZ2ktPmEoey1ocmVmID0+ICIkbXlf
dXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2plY3Q7YT1oaXN0b3J5O2g9JGhh
c2hfYmFzZTtmPSRiYXNlJHRfbmFtZSIpfSwgImhpc3RvcnkiKSAuCisJCQkg
ICAgICAiIHwgIiAuICRjZ2ktPmEoey1ocmVmID0+ICIkbXlfdXJpPyIgLiBl
c2NfcGFyYW0oInA9JHByb2plY3Q7YT1ibG9iX3BsYWluO2g9JHRfaGFzaDtm
PSRiYXNlJHRfbmFtZSIpfSwgInJhdyIpIC4KIAkJCSAgICAgICI8L3RkPlxu
IjsKIAkJfSBlbHNpZiAoJHRfdHlwZSBlcSAidHJlZSIpIHsKIAkJCXByaW50
ICI8dGQgY2xhc3M9XCJsaXN0XCI+IiAuCg==

--0-1031073099-1152254370=:6902--
