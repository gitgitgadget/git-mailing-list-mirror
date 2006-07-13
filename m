From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb.cgi: Teach tree->raw to not require the hash of the blob
Date: Wed, 12 Jul 2006 20:31:45 -0700 (PDT)
Message-ID: <20060713033145.62912.qmail@web31808.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-70938868-1152761505=:49949"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 13 05:31:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0rvc-00068k-LV
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 05:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWGMDbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 23:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWGMDbq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 23:31:46 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:43144 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750863AbWGMDbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 23:31:46 -0400
Received: (qmail 62914 invoked by uid 60001); 13 Jul 2006 03:31:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F/37gVR/xut5SOdl2srNZE4dFxFGaQYwEbdKUuGzZ7nLSfsNlfuPjJkznqkz7Z4n3g2gtOWPenJlecqgZfjhNmFd0fgvyC8ppND+0CB8m1KenB2mGyzUZ4oLBa3DcVWXT3TraREOlrf/XyrvUx8V/TpFZ4LfroReyWLsTlSgJFY=  ;
Received: from [68.186.50.195] by web31808.mail.mud.yahoo.com via HTTP; Wed, 12 Jul 2006 20:31:45 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23805>

--0-70938868-1152761505=:49949
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Teach tree->raw to not require the hash of the blob, but to
figure it out from the file name.  This allows to externally
link to files into the repository, such that the hash is not
required.  I.e. the file obtained would be as of the HEAD
commit.

In contrast tree->blob for binary files passes the hash, as
does tree->blob->plain for "text/*" files.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)
--0-70938868-1152761505=:49949
Content-Type: application/octet-stream; name="p1.patch"
Content-Transfer-Encoding: base64
Content-Description: pat867582916
Content-Disposition: attachment; filename="p1.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIuY2dpIGIvZ2l0d2ViL2dpdHdl
Yi5jZ2kKaW5kZXggMmU4N2RlNC4uZTkwNGViNyAxMDA3NTUKLS0tIGEvZ2l0
d2ViL2dpdHdlYi5jZ2kKKysrIGIvZ2l0d2ViL2dpdHdlYi5jZ2kKQEAgLTE1
MjEsNiArMTUyMSwxNCBAQCBzdWIgZ2l0X2Jsb2JfcGxhaW5fbWltZXR5cGUg
ewogfQogCiBzdWIgZ2l0X2Jsb2JfcGxhaW4geworCWlmICghZGVmaW5lZCAk
aGFzaCkgeworCQlpZiAoZGVmaW5lZCAkZmlsZV9uYW1lKSB7CisJCQlteSAk
YmFzZSA9ICRoYXNoX2Jhc2UgfHwgZ2l0X3JlYWRfaGVhZCgkcHJvamVjdCk7
CisJCQkkaGFzaCA9IGdpdF9nZXRfaGFzaF9ieV9wYXRoKCRiYXNlLCAkZmls
ZV9uYW1lLCAiYmxvYiIpIHx8IGRpZV9lcnJvcih1bmRlZiwgIkVycm9yIGxv
b2t1cCBmaWxlLiIpOworCQl9IGVsc2UgeworCQkJZGllX2Vycm9yKHVuZGVm
LCAiTm8gZmlsZSBuYW1lIGRlZmluZWQuIik7CisJCX0KKwl9CiAJbXkgJHR5
cGUgPSBzaGlmdDsKIAlvcGVuIG15ICRmZCwgIi18IiwgIiRnaXRiaW4vZ2l0
LWNhdC1maWxlIGJsb2IgJGhhc2giIG9yIGRpZV9lcnJvcigiQ291bGRuJ3Qg
Y2F0ICRmaWxlX25hbWUsICRoYXNoIik7CiAKQEAgLTE1NDQsOSArMTU1Miwx
MyBAQCBzdWIgZ2l0X2Jsb2JfcGxhaW4gewogfQogCiBzdWIgZ2l0X2Jsb2Ig
ewotCWlmICghZGVmaW5lZCAkaGFzaCAmJiBkZWZpbmVkICRmaWxlX25hbWUp
IHsKLQkJbXkgJGJhc2UgPSAkaGFzaF9iYXNlIHx8IGdpdF9yZWFkX2hlYWQo
JHByb2plY3QpOwotCQkkaGFzaCA9IGdpdF9nZXRfaGFzaF9ieV9wYXRoKCRi
YXNlLCAkZmlsZV9uYW1lLCAiYmxvYiIpIHx8IGRpZV9lcnJvcih1bmRlZiwg
IkVycm9yIGxvb2t1cCBmaWxlLiIpOworCWlmICghZGVmaW5lZCAkaGFzaCkg
eworCQlpZiAoZGVmaW5lZCAkZmlsZV9uYW1lKSB7CisJCQlteSAkYmFzZSA9
ICRoYXNoX2Jhc2UgfHwgZ2l0X3JlYWRfaGVhZCgkcHJvamVjdCk7CisJCQkk
aGFzaCA9IGdpdF9nZXRfaGFzaF9ieV9wYXRoKCRiYXNlLCAkZmlsZV9uYW1l
LCAiYmxvYiIpIHx8IGRpZV9lcnJvcih1bmRlZiwgIkVycm9yIGxvb2t1cCBm
aWxlLiIpOworCQl9IGVsc2UgeworCQkJZGllX2Vycm9yKHVuZGVmLCAiTm8g
ZmlsZSBuYW1lIGRlZmluZWQuIik7CisJCX0KIAl9CiAJbXkgJGhhdmVfYmxh
bWUgPSBnaXRfZ2V0X3Byb2plY3RfY29uZmlnX2Jvb2wgKCdibGFtZScpOwog
CW9wZW4gbXkgJGZkLCAiLXwiLCAiJGdpdGJpbi9naXQtY2F0LWZpbGUgYmxv
YiAkaGFzaCIgb3IgZGllX2Vycm9yKHVuZGVmLCAiT3BlbiBmYWlsZWQuIik7
CkBAIC0xNjc4LDggKzE2OTAsNyBAQCBzdWIgZ2l0X3RyZWUgewogCQkJICAg
ICAgJGNnaS0+YSh7LWhyZWYgPT4gIiRteV91cmk/IiAuIGVzY19wYXJhbSgi
cD0kcHJvamVjdDthPWJsb2I7aD0kdF9oYXNoJGJhc2Vfa2V5O2Y9JGJhc2Uk
dF9uYW1lIil9LCAiYmxvYiIpIC4KICMJCQkgICAgICAiIHwgIiAuICRjZ2kt
PmEoey1ocmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2pl
Y3Q7YT1ibGFtZTtoPSR0X2hhc2gkYmFzZV9rZXk7Zj0kYmFzZSR0X25hbWUi
KX0sICJibGFtZSIpIC4KIAkJCSAgICAgICIgfCAiIC4gJGNnaS0+YSh7LWhy
ZWYgPT4gIiRteV91cmk/IiAuIGVzY19wYXJhbSgicD0kcHJvamVjdDthPWhp
c3Rvcnk7aD0kaGFzaF9iYXNlO2Y9JGJhc2UkdF9uYW1lIil9LCAiaGlzdG9y
eSIpIC4KLQkJCSAgICAgICIgfCAiIC4gJGNnaS0+YSh7LWhyZWYgPT4gIiRt
eV91cmk/IiAuIGVzY19wYXJhbSgicD0kcHJvamVjdDthPWJsb2JfcGxhaW47
aD0kdF9oYXNoO2Y9JGJhc2UkdF9uYW1lIil9LCAicmF3IikgLgorCQkJICAg
ICAgIiB8ICIgLiAkY2dpLT5hKHstaHJlZiA9PiAiJG15X3VyaT8iIC4gZXNj
X3BhcmFtKCJwPSRwcm9qZWN0O2E9YmxvYl9wbGFpbjtmPSRiYXNlJHRfbmFt
ZSIpfSwgInJhdyIpIC4KIAkJCSAgICAgICI8L3RkPlxuIjsKIAkJfSBlbHNp
ZiAoJHRfdHlwZSBlcSAidHJlZSIpIHsKIAkJCXByaW50ICI8dGQgY2xhc3M9
XCJsaXN0XCI+IiAuCi0tIAoxLjQuMS5nOWNhMwoK

--0-70938868-1152761505=:49949--
