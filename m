From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 2/4] gitweb: bugfix: git_commit and git_commitdiff parents
Date: Fri, 4 Aug 2006 15:11:47 -0700 (PDT)
Message-ID: <20060804221147.18778.qmail@web31801.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1680852539-1154729507=:18771"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Aug 05 00:11:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97tX-0001vi-Ce
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161528AbWHDWLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161529AbWHDWLs
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:11:48 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:6024 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161528AbWHDWLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:11:48 -0400
Received: (qmail 18780 invoked by uid 60001); 4 Aug 2006 22:11:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=peOp5XqAuQeiXIs3dljgWSafsvD9UOXHai7ApK+P5GnlaqfNXDbTKZavbWWEbnciRo4meMUottTRswVkQtQiNQVVS6d94ETUjGEq/Oejpyk5aZ4WznIS6taqfuyKpqFDWEDNuyFaqPVdSxBjj+BRf/ye9EwZVhueMY9LOWqCm4I=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Fri, 04 Aug 2006 15:11:47 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24851>

--0-1680852539-1154729507=:18771
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

In git_commit() the hash base of $from_id is $parent, not
$hash:
 - If status is "D", then action blob for $from_id wants
   $parent, not $hash.  History needs $parent too.
 - If status is "R", then action blob for $from_id wants
   $parent, not $hash.

In git_commitdiff() the hash base of $from_id is
$hash_parent, not $hash:
 - If status is "D".
 - If status is "M".

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)
--0-1680852539-1154729507=:18771
Content-Type: application/octet-stream; name="p2.patch"
Content-Transfer-Encoding: base64
Content-Description: 3952834181-p2.patch
Content-Disposition: attachment; filename="p2.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3
ZWIucGVybAppbmRleCAwNDlmMjdlLi42OWI3ODdmIDEwMDc1NQotLS0gYS9n
aXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBA
IC0yMDE4LDExICsyMDE4LDExIEBAIHN1YiBnaXRfY29tbWl0IHsKIAkJCSAg
ICAgICI8dGQgY2xhc3M9XCJsaW5rXCI+IiAuICRjZ2ktPmEoey1ocmVmID0+
ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2plY3Q7YT1ibG9iO2g9
JHRvX2lkO2hiPSRoYXNoO2Y9JGZpbGUiKX0sICJibG9iIikgLiAiPC90ZD5c
biI7CiAJCX0gZWxzaWYgKCRzdGF0dXMgZXEgIkQiKSB7CiAJCQlwcmludCAi
PHRkPiIgLgotCQkJICAgICAgJGNnaS0+YSh7LWhyZWYgPT4gIiRteV91cmk/
IiAuIGVzY19wYXJhbSgicD0kcHJvamVjdDthPWJsb2I7aD0kZnJvbV9pZDto
Yj0kaGFzaDtmPSRmaWxlIiksIC1jbGFzcyA9PiAibGlzdCJ9LCBlc2NfaHRt
bCgkZmlsZSkpIC4gIjwvdGQ+XG4iIC4KKwkJCSAgICAgICRjZ2ktPmEoey1o
cmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2plY3Q7YT1i
bG9iO2g9JGZyb21faWQ7aGI9JHBhcmVudDtmPSRmaWxlIiksIC1jbGFzcyA9
PiAibGlzdCJ9LCBlc2NfaHRtbCgkZmlsZSkpIC4gIjwvdGQ+XG4iIC4KIAkJ
CSAgICAgICI8dGQ+PHNwYW4gY2xhc3M9XCJmaWxlX3N0YXR1cyBkZWxldGVk
XCI+W2RlbGV0ZWQgIiAuIGZpbGVfdHlwZSgkZnJvbV9tb2RlKS4gIl08L3Nw
YW4+PC90ZD5cbiIgLgogCQkJICAgICAgIjx0ZCBjbGFzcz1cImxpbmtcIj4i
IC4KLQkJCSAgICAgICRjZ2ktPmEoey1ocmVmID0+ICIkbXlfdXJpPyIgLiBl
c2NfcGFyYW0oInA9JHByb2plY3Q7YT1ibG9iO2g9JGZyb21faWQ7aGI9JGhh
c2g7Zj0kZmlsZSIpfSwgImJsb2IiKSAuCi0JCQkgICAgICAiIHwgIiAuICRj
Z2ktPmEoey1ocmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHBy
b2plY3Q7YT1oaXN0b3J5O2hiPSRoYXNoO2Y9JGZpbGUiKX0sICJoaXN0b3J5
IikgLgorCQkJICAgICAgJGNnaS0+YSh7LWhyZWYgPT4gIiRteV91cmk/IiAu
IGVzY19wYXJhbSgicD0kcHJvamVjdDthPWJsb2I7aD0kZnJvbV9pZDtoYj0k
cGFyZW50O2Y9JGZpbGUiKX0sICJibG9iIikgLgorCQkJICAgICAgIiB8ICIg
LiAkY2dpLT5hKHstaHJlZiA9PiAiJG15X3VyaT8iIC4gZXNjX3BhcmFtKCJw
PSRwcm9qZWN0O2E9aGlzdG9yeTtoYj0kcGFyZW50O2Y9JGZpbGUiKX0sICJo
aXN0b3J5IikgLgogCQkJICAgICAgIjwvdGQ+XG4iCiAJCX0gZWxzaWYgKCRz
dGF0dXMgZXEgIk0iIHx8ICRzdGF0dXMgZXEgIlQiKSB7CiAJCQlteSAkbW9k
ZV9jaG5nZSA9ICIiOwpAQCAtMjA2NCw3ICsyMDY0LDcgQEAgc3ViIGdpdF9j
b21taXQgewogCQkJcHJpbnQgIjx0ZD4iIC4KIAkJCSAgICAgICRjZ2ktPmEo
ey1ocmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2plY3Q7
YT1ibG9iO2g9JHRvX2lkO2hiPSRoYXNoO2Y9JHRvX2ZpbGUiKSwgLWNsYXNz
ID0+ICJsaXN0In0sIGVzY19odG1sKCR0b19maWxlKSkgLiAiPC90ZD5cbiIg
LgogCQkJICAgICAgIjx0ZD48c3BhbiBjbGFzcz1cImZpbGVfc3RhdHVzIG1v
dmVkXCI+W21vdmVkIGZyb20gIiAuCi0JCQkgICAgICAkY2dpLT5hKHstaHJl
ZiA9PiAiJG15X3VyaT8iIC4gZXNjX3BhcmFtKCJwPSRwcm9qZWN0O2E9Ymxv
YjtoPSRmcm9tX2lkO2hiPSRoYXNoO2Y9JGZyb21fZmlsZSIpLCAtY2xhc3Mg
PT4gImxpc3QifSwgZXNjX2h0bWwoJGZyb21fZmlsZSkpIC4KKwkJCSAgICAg
ICRjZ2ktPmEoey1ocmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9
JHByb2plY3Q7YT1ibG9iO2g9JGZyb21faWQ7aGI9JHBhcmVudDtmPSRmcm9t
X2ZpbGUiKSwgLWNsYXNzID0+ICJsaXN0In0sIGVzY19odG1sKCRmcm9tX2Zp
bGUpKSAuCiAJCQkgICAgICAiIHdpdGggIiAuIChpbnQgJHNpbWlsYXJpdHkp
IC4gIiUgc2ltaWxhcml0eSRtb2RlX2NobmddPC9zcGFuPjwvdGQ+XG4iIC4K
IAkJCSAgICAgICI8dGQgY2xhc3M9XCJsaW5rXCI+IiAuCiAJCQkgICAgICAk
Y2dpLT5hKHstaHJlZiA9PiAiJG15X3VyaT8iIC4gZXNjX3BhcmFtKCJwPSRw
cm9qZWN0O2E9YmxvYjtoPSR0b19pZDtoYj0kaGFzaDtmPSR0b19maWxlIil9
LCAiYmxvYiIpOwpAQCAtMjE3OCwxNSArMjE3OCwxNyBAQCBzdWIgZ2l0X2Nv
bW1pdGRpZmYgewogCQkJZ2l0X2RpZmZfcHJpbnQodW5kZWYsICIvZGV2L251
bGwiLCAkdG9faWQsICJiLyRmaWxlIik7CiAJCX0gZWxzaWYgKCRzdGF0dXMg
ZXEgIkQiKSB7CiAJCQlwcmludCAiPGRpdiBjbGFzcz1cImRpZmZfaW5mb1wi
PiIgLiBmaWxlX3R5cGUoJGZyb21fbW9kZSkgLiAiOiIgLgotCQkJICAgICAg
JGNnaS0+YSh7LWhyZWYgPT4gIiRteV91cmk/IiAuIGVzY19wYXJhbSgicD0k
cHJvamVjdDthPWJsb2I7aD0kZnJvbV9pZDtoYj0kaGFzaDtmPSRmaWxlIil9
LCAkZnJvbV9pZCkgLiAiKGRlbGV0ZWQpIiAuCisJCQkgICAgICAkY2dpLT5h
KHstaHJlZiA9PiAiJG15X3VyaT8iIC4gZXNjX3BhcmFtKCJwPSRwcm9qZWN0
O2E9YmxvYjtoPSRmcm9tX2lkO2hiPSRoYXNoX3BhcmVudDtmPSRmaWxlIil9
LCAkZnJvbV9pZCkgLiAiKGRlbGV0ZWQpIiAuCiAJCQkgICAgICAiPC9kaXY+
XG4iOwogCQkJZ2l0X2RpZmZfcHJpbnQoJGZyb21faWQsICJhLyRmaWxlIiwg
dW5kZWYsICIvZGV2L251bGwiKTsKIAkJfSBlbHNpZiAoJHN0YXR1cyBlcSAi
TSIpIHsKIAkJCWlmICgkZnJvbV9pZCBuZSAkdG9faWQpIHsKIAkJCQlwcmlu
dCAiPGRpdiBjbGFzcz1cImRpZmZfaW5mb1wiPiIgLgotCQkJCSAgICAgIGZp
bGVfdHlwZSgkZnJvbV9tb2RlKSAuICI6IiAuICRjZ2ktPmEoey1ocmVmID0+
ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2plY3Q7YT1ibG9iO2g9
JGZyb21faWQ7aGI9JGhhc2g7Zj0kZmlsZSIpfSwgJGZyb21faWQpIC4KKwkJ
CQkgICAgICBmaWxlX3R5cGUoJGZyb21fbW9kZSkgLiAiOiIgLgorCQkJCSAg
ICAgICRjZ2ktPmEoey1ocmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0o
InA9JHByb2plY3Q7YT1ibG9iO2g9JGZyb21faWQ7aGI9JGhhc2hfcGFyZW50
O2Y9JGZpbGUiKX0sICRmcm9tX2lkKSAuCiAJCQkJICAgICAgIiAtPiAiIC4K
LQkJCQkgICAgICBmaWxlX3R5cGUoJHRvX21vZGUpIC4gIjoiIC4gJGNnaS0+
YSh7LWhyZWYgPT4gIiRteV91cmk/IiAuIGVzY19wYXJhbSgicD0kcHJvamVj
dDthPWJsb2I7aD0kdG9faWQ7aGI9JGhhc2g7Zj0kZmlsZSIpfSwgJHRvX2lk
KTsKKwkJCQkgICAgICBmaWxlX3R5cGUoJHRvX21vZGUpIC4gIjoiIC4KKwkJ
CQkgICAgICAkY2dpLT5hKHstaHJlZiA9PiAiJG15X3VyaT8iIC4gZXNjX3Bh
cmFtKCJwPSRwcm9qZWN0O2E9YmxvYjtoPSR0b19pZDtoYj0kaGFzaDtmPSRm
aWxlIil9LCAkdG9faWQpOwogCQkJCXByaW50ICI8L2Rpdj5cbiI7CiAJCQkJ
Z2l0X2RpZmZfcHJpbnQoJGZyb21faWQsICJhLyRmaWxlIiwgICR0b19pZCwg
ImIvJGZpbGUiKTsKIAkJCX0KLS0gCjEuNC4yLnJjMy5nNmRmMwoK

--0-1680852539-1154729507=:18771--
