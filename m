From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: bugfix: git_print_page_path() needs the hash base
Date: Thu, 17 Aug 2006 10:39:29 -0700 (PDT)
Message-ID: <20060817173929.46560.qmail@web31813.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1411232729-1155836369=:46511"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 17 19:39:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDlqA-0002dM-2L
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 19:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWHQRjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWHQRjb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 13:39:31 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:10143 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932387AbWHQRja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 13:39:30 -0400
Received: (qmail 46562 invoked by uid 60001); 17 Aug 2006 17:39:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FYMDyVD32I8Xc3dUjsWK+cNZuHcCsHGdy1lUAzsSnnnnsz0DDligcWvDFb29laFyfVO7hLiodkjH+4D26Y6Y9CAfWSb2OYlXUJydUQquhM6PIK2sTiLG4RUoJP8BJAWg2YQzWQJ9Ihk7HlrqLJv0aq6LDn3GXutFowxfq8hVJmg=  ;
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Thu, 17 Aug 2006 10:39:29 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25598>

--0-1411232729-1155836369=:46511
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

If a file F exists in branch B, but doesn't exist
in master branch, then blob_plain needs the hash base in
order to properly get the file.  The hash base is passed
on symbolically so we still preserve the "latest" quality
of the link presented by git_print_page_path().

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

--0-1411232729-1155836369=:46511
Content-Type: application/octet-stream; name="p1.patch"
Content-Transfer-Encoding: base64
Content-Description: 2795696785-p1.patch
Content-Disposition: attachment; filename="p1.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3
ZWIucGVybAppbmRleCAzNmQzMDgyLi5iYjc3YjU1IDEwMDc1NQotLS0gYS9n
aXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBA
IC0xMTc1LDEyICsxMTc1LDE4IEBAIHN1YiBnaXRfcHJpbnRfaGVhZGVyX2Rp
diB7CiBzdWIgZ2l0X3ByaW50X3BhZ2VfcGF0aCB7CiAJbXkgJG5hbWUgPSBz
aGlmdDsKIAlteSAkdHlwZSA9IHNoaWZ0OworCW15ICRoYiA9IHNoaWZ0Owog
CiAJaWYgKCFkZWZpbmVkICRuYW1lKSB7CiAJCXByaW50ICI8ZGl2IGNsYXNz
PVwicGFnZV9wYXRoXCI+PGI+LzwvYj48L2Rpdj5cbiI7CiAJfSBlbHNpZiAo
ZGVmaW5lZCAkdHlwZSAmJiAkdHlwZSBlcSAnYmxvYicpIHsKLQkJcHJpbnQg
IjxkaXYgY2xhc3M9XCJwYWdlX3BhdGhcIj48Yj4iIC4KLQkJCSRjZ2ktPmEo
ey1ocmVmID0+IGhyZWYoYWN0aW9uPT4iYmxvYl9wbGFpbiIsIGZpbGVfbmFt
ZT0+JGZpbGVfbmFtZSl9LCBlc2NfaHRtbCgkbmFtZSkpIC4gIjwvYj48YnIv
PjwvZGl2PlxuIjsKKwkJcHJpbnQgIjxkaXYgY2xhc3M9XCJwYWdlX3BhdGhc
Ij48Yj4iOworCQlpZiAoZGVmaW5lZCAkaGIpIHsKKwkJCXByaW50ICRjZ2kt
PmEoey1ocmVmID0+IGhyZWYoYWN0aW9uPT4iYmxvYl9wbGFpbiIsIGhhc2hf
YmFzZT0+JGhiLCBmaWxlX25hbWU9PiRmaWxlX25hbWUpfSwgZXNjX2h0bWwo
JG5hbWUpKTsKKwkJfSBlbHNlIHsKKwkJCXByaW50ICRjZ2ktPmEoey1ocmVm
ID0+IGhyZWYoYWN0aW9uPT4iYmxvYl9wbGFpbiIsIGZpbGVfbmFtZT0+JGZp
bGVfbmFtZSl9LCBlc2NfaHRtbCgkbmFtZSkpOworCQl9CisJCXByaW50ICI8
L2I+PGJyLz48L2Rpdj5cbiI7CiAJfSBlbHNlIHsKIAkJcHJpbnQgIjxkaXYg
Y2xhc3M9XCJwYWdlX3BhdGhcIj48Yj4iIC4gZXNjX2h0bWwoJG5hbWUpIC4g
IjwvYj48YnIvPjwvZGl2PlxuIjsKIAl9CkBAIC0xODY4LDcgKzE4NzQsNyBA
QCBzdWIgZ2l0X2JsYW1lMiB7CiAJCSIgfCAiIC4gJGNnaS0+YSh7LWhyZWYg
PT4gaHJlZihhY3Rpb249PiJibGFtZSIsIGZpbGVfbmFtZT0+JGZpbGVfbmFt
ZSl9LCAiaGVhZCIpOwogCWdpdF9wcmludF9wYWdlX25hdignJywnJywgJGhh
c2hfYmFzZSwkY297J3RyZWUnfSwkaGFzaF9iYXNlLCAkZm9ybWF0c19uYXYp
OwogCWdpdF9wcmludF9oZWFkZXJfZGl2KCdjb21taXQnLCBlc2NfaHRtbCgk
Y297J3RpdGxlJ30pLCAkaGFzaF9iYXNlKTsKLQlnaXRfcHJpbnRfcGFnZV9w
YXRoKCRmaWxlX25hbWUsICRmdHlwZSk7CisJZ2l0X3ByaW50X3BhZ2VfcGF0
aCgkZmlsZV9uYW1lLCAkZnR5cGUsICRoYXNoX2Jhc2UpOwogCW15IEByZXZf
Y29sb3IgPSAocXcobGlnaHQyIGRhcmsyKSk7CiAJbXkgJG51bV9jb2xvcnMg
PSBzY2FsYXIoQHJldl9jb2xvcik7CiAJbXkgJGN1cnJlbnRfY29sb3IgPSAw
OwpAQCAtMTkyMiw3ICsxOTI4LDcgQEAgc3ViIGdpdF9ibGFtZSB7CiAJCSIg
fCAiIC4gJGNnaS0+YSh7LWhyZWYgPT4gaHJlZihhY3Rpb249PiJibGFtZSIs
IGZpbGVfbmFtZT0+JGZpbGVfbmFtZSl9LCAiaGVhZCIpOwogCWdpdF9wcmlu
dF9wYWdlX25hdignJywnJywgJGhhc2hfYmFzZSwkY297J3RyZWUnfSwkaGFz
aF9iYXNlLCAkZm9ybWF0c19uYXYpOwogCWdpdF9wcmludF9oZWFkZXJfZGl2
KCdjb21taXQnLCBlc2NfaHRtbCgkY297J3RpdGxlJ30pLCAkaGFzaF9iYXNl
KTsKLQlnaXRfcHJpbnRfcGFnZV9wYXRoKCRmaWxlX25hbWUsICdibG9iJyk7
CisJZ2l0X3ByaW50X3BhZ2VfcGF0aCgkZmlsZV9uYW1lLCAnYmxvYicsICRo
YXNoX2Jhc2UpOwogCXByaW50ICI8ZGl2IGNsYXNzPVwicGFnZV9ib2R5XCI+
XG4iOwogCXByaW50IDw8SFRNTDsKIDx0YWJsZSBjbGFzcz0iYmxhbWUiPgpA
QCAtMjA4NSw3ICsyMDkxLDcgQEAgc3ViIGdpdF9ibG9iIHsKIAkJICAgICAg
Ijxici8+PGJyLz48L2Rpdj5cbiIgLgogCQkgICAgICAiPGRpdiBjbGFzcz1c
InRpdGxlXCI+JGhhc2g8L2Rpdj5cbiI7CiAJfQotCWdpdF9wcmludF9wYWdl
X3BhdGgoJGZpbGVfbmFtZSwgImJsb2IiKTsKKwlnaXRfcHJpbnRfcGFnZV9w
YXRoKCRmaWxlX25hbWUsICJibG9iIiwgJGhhc2hfYmFzZSk7CiAJcHJpbnQg
IjxkaXYgY2xhc3M9XCJwYWdlX2JvZHlcIj5cbiI7CiAJbXkgJG5yOwogCXdo
aWxlIChteSAkbGluZSA9IDwkZmQ+KSB7CkBAIC0yMTM1LDcgKzIxNDEsNyBA
QCBzdWIgZ2l0X3RyZWUgewogCWlmIChkZWZpbmVkICRmaWxlX25hbWUpIHsK
IAkJJGJhc2UgPSBlc2NfaHRtbCgiJGZpbGVfbmFtZS8iKTsKIAl9Ci0JZ2l0
X3ByaW50X3BhZ2VfcGF0aCgkZmlsZV9uYW1lLCAndHJlZScpOworCWdpdF9w
cmludF9wYWdlX3BhdGgoJGZpbGVfbmFtZSwgJ3RyZWUnLCAkaGFzaF9iYXNl
KTsKIAlwcmludCAiPGRpdiBjbGFzcz1cInBhZ2VfYm9keVwiPlxuIjsKIAlw
cmludCAiPHRhYmxlIGNlbGxzcGFjaW5nPVwiMFwiPlxuIjsKIAlteSAkYWx0
ZXJuYXRlID0gMDsKQEAgLTIzMzIsNyArMjMzOCw3IEBAIHN1YiBnaXRfYmxv
YmRpZmYgewogCQkgICAgICAiPGJyLz48YnIvPjwvZGl2PlxuIiAuCiAJCSAg
ICAgICI8ZGl2IGNsYXNzPVwidGl0bGVcIj4kaGFzaCB2cyAkaGFzaF9wYXJl
bnQ8L2Rpdj5cbiI7CiAJfQotCWdpdF9wcmludF9wYWdlX3BhdGgoJGZpbGVf
bmFtZSwgImJsb2IiKTsKKwlnaXRfcHJpbnRfcGFnZV9wYXRoKCRmaWxlX25h
bWUsICJibG9iIiwgJGhhc2hfYmFzZSk7CiAJcHJpbnQgIjxkaXYgY2xhc3M9
XCJwYWdlX2JvZHlcIj5cbiIgLgogCSAgICAgICI8ZGl2IGNsYXNzPVwiZGlm
Zl9pbmZvXCI+YmxvYjoiIC4KIAkgICAgICAkY2dpLT5hKHstaHJlZiA9PiBo
cmVmKGFjdGlvbj0+ImJsb2IiLCBoYXNoPT4kaGFzaF9wYXJlbnQsIGhhc2hf
YmFzZT0+JGhhc2hfYmFzZSwgZmlsZV9uYW1lPT4oJGZpbGVfcGFyZW50IHx8
ICRmaWxlX25hbWUpKX0sICRoYXNoX3BhcmVudCkgLgpAQCAtMjUwMiw3ICsy
NTA4LDcgQEAgc3ViIGdpdF9oaXN0b3J5IHsKIAlpZiAoZGVmaW5lZCAkaGFz
aCkgewogCQkkZnR5cGUgPSBnaXRfZ2V0X3R5cGUoJGhhc2gpOwogCX0KLQln
aXRfcHJpbnRfcGFnZV9wYXRoKCRmaWxlX25hbWUsICRmdHlwZSk7CisJZ2l0
X3ByaW50X3BhZ2VfcGF0aCgkZmlsZV9uYW1lLCAkZnR5cGUsICRoYXNoX2Jh
c2UpOwogCiAJb3BlbiBteSAkZmQsICItfCIsCiAJCSRHSVQsICJyZXYtbGlz
dCIsICItLWZ1bGwtaGlzdG9yeSIsICRoYXNoX2Jhc2UsICItLSIsICRmaWxl
X25hbWU7Ci0tIAoxLjQuMi5nZGI5OAoK

--0-1411232729-1155836369=:46511--
