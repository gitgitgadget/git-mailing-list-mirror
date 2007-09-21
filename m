From: "Jakub Narebski" <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: Always set 'from_file' and 'to_file' in parse_difftree_raw_line
Date: Fri, 21 Sep 2007 23:39:49 +0200
Message-ID: <8fe92b430709211439v3c826dddw83e593d655bc6124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12876_22694380.1190410789324"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 23:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYqE9-0007sc-Dg
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 23:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987AbXIUVjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 17:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbXIUVjw
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 17:39:52 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:50083 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbXIUVjv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 17:39:51 -0400
Received: by nz-out-0506.google.com with SMTP id s18so786690nze
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 14:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=p0alD9TVr7+aKRCjj21HZn9/cMEggHUH2P9fEq80nAg=;
        b=i438h10UZwugU8Q7cXeGtrFNam3M2X6t1r4mRO+lE5i8KmS/mnRvbYJjUNdui3IAcfPdNB7eaADdUZEcRUJYIIjKD0j+evPLQUyo4OdCTOIX3H1b8JOprTlNkyR9DIfNz7vH9fWOYnkUnkgyPuou2o+ommL4V8CyEwAMADBeTKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=Tg4IUYId6WwaA0LVhHqgfQmPVWpj+ZJxiu0yRwRQ6CmcdTQKOTi8Ok3UodzYsbW2LUAZRvlg5G1sOHyBxWyMf33i3kc0y5/nRlpDb872hWdEsKp66YXCSDS/zcsNRtakvT7FGCB0KN8+F06z7agzWEm1wFtfdlkydmyqvA1rIOQ=
Received: by 10.114.124.1 with SMTP id w1mr3313417wac.1190410789344;
        Fri, 21 Sep 2007 14:39:49 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Fri, 21 Sep 2007 14:39:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58887>

------=_Part_12876_22694380.1190410789324
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Always set 'from_file' and 'to_file' keys when parsing raw diff output
format line, even if filename didn't change (file was not renamed).
This allows for less code (and no problems with file named '0'); use
this.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This simplifies code a bit _and_ fortifies gitweb against filenames
like '0' (although it does remove _fragments_ of lines, not lines
themselves, so it is not visible in diffstat).

 gitweb/gitweb.perl |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

------=_Part_12876_22694380.1190410789324
Content-Type: application/octet-stream;
 name="0004-gitweb-Always-set-from_file-and-to_file-in-pars.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0004-gitweb-Always-set-from_file-and-to_file-in-pars.patch"
X-Attachment-Id: f_f6v7t7fu

RnJvbSA5NzUzZjhiNmE2NzIzOWE0ZWQxYWQ1NDg5OTY1ZGIzN2Y3Y2JlYTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT4KRGF0
ZTogVGh1LCAxMyBTZXAgMjAwNyAyMTo1NzowMyArMDIwMApTdWJqZWN0OiBbUEFUQ0ggNC81XSBn
aXR3ZWI6IEFsd2F5cyBzZXQgJ2Zyb21fZmlsZScgYW5kICd0b19maWxlJyBpbiBwYXJzZV9kaWZm
dHJlZV9yYXdfbGluZQoKQWx3YXlzIHNldCAnZnJvbV9maWxlJyBhbmQgJ3RvX2ZpbGUnIGtleXMg
d2hlbiBwYXJzaW5nIHJhdyBkaWZmIG91dHB1dApmb3JtYXQgbGluZSwgZXZlbiBpZiBmaWxlbmFt
ZSBkaWRuJ3QgY2hhbmdlIChmaWxlIHdhcyBub3QgcmVuYW1lZCkuClRoaXMgYWxsb3dzIGZvciBs
ZXNzIGNvZGUgKGFuZCBubyBwcm9ibGVtcyB3aXRoIGZpbGUgbmFtZWQgJzAnKTsgdXNlCnRoaXMu
CgpTaWduZWQtb2ZmLWJ5OiBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT4KLS0tClRo
aXMgc2ltcGxpZmllcyBjb2RlIGEgYml0IF9hbmRfIGZvcnRpZmllcyBnaXR3ZWIgYWdhaW5zdCBm
aWxlbmFtZXMKbGlrZSAnMCcgKGFsdGhvdWdoIGl0IGRvZXMgcmVtb3ZlIF9mcmFnbWVudHNfIG9m
IGxpbmVzLCBub3QgbGluZXMKdGhlbXNlbHZlcywgc28gaXQgaXMgbm90IHZpc2libGUgaW4gZGlm
ZnN0YXQpLgoKIGdpdHdlYi9naXR3ZWIucGVybCB8ICAgMTcgKysrKysrKysrKy0tLS0tLS0KIDEg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9naXR3ZWIvZ2l0d2ViLnBlcmwgYi9naXR3ZWIvZ2l0d2ViLnBlcmwKaW5kZXggMWI1NjQy
YS4uNmM3OWE5NSAxMDA3NTUKLS0tIGEvZ2l0d2ViL2dpdHdlYi5wZXJsCisrKyBiL2dpdHdlYi9n
aXR3ZWIucGVybApAQCAtMTk2OCw3ICsxOTY4LDcgQEAgc3ViIHBhcnNlX2RpZmZ0cmVlX3Jhd19s
aW5lIHsKIAkJaWYgKCRyZXN7J3N0YXR1cyd9IGVxICdSJyB8fCAkcmVzeydzdGF0dXMnfSBlcSAn
QycpIHsgIyByZW5hbWVkIG9yIGNvcGllZAogCQkJKCRyZXN7J2Zyb21fZmlsZSd9LCAkcmVzeyd0
b19maWxlJ30pID0gbWFwIHsgdW5xdW90ZSgkXykgfSBzcGxpdCgiXHQiLCAkNyk7CiAJCX0gZWxz
ZSB7Ci0JCQkkcmVzeydmaWxlJ30gPSB1bnF1b3RlKCQ3KTsKKwkJCSRyZXN7J2Zyb21fZmlsZSd9
ID0gJHJlc3sndG9fZmlsZSd9ID0gJHJlc3snZmlsZSd9ID0gdW5xdW90ZSgkNyk7CiAJCX0KIAl9
CiAJIyAnOjoxMDA3NTUgMTAwNzU1IDEwMDc1NSA2MGU3OWNhMWIwMWJjOGIwNTdhYmUxN2RkYWI0
ODQ2OTlhN2Y1ZmRiIDk0MDY3Y2M1ZjczMzg4ZjMzNzIyZDUyYWUwMmY0NDY5MmJjMDc0OTAgOTQw
NjdjYzVmNzMzODhmMzM3MjJkNTJhZTAyZjQ0NjkyYmMwNzQ5MCBNUglnaXQtZ3VpL2dpdC1ndWku
c2gnCkBAIC0yMDM1LDcgKzIwMzUsMTAgQEAgc3ViIHBhcnNlX2Zyb21fdG9fZGlmZmluZm8gewog
CQlmaWxsX2Zyb21fZmlsZV9pbmZvKCRkaWZmaW5mbywgQHBhcmVudHMpCiAJCQl1bmxlc3MgZXhp
c3RzICRkaWZmaW5mby0+eydmcm9tX2ZpbGUnfTsKIAkJZm9yIChteSAkaSA9IDA7ICRpIDwgJGRp
ZmZpbmZvLT57J25wYXJlbnRzJ307ICRpKyspIHsKLQkJCSRmcm9tLT57J2ZpbGUnfVskaV0gPSAk
ZGlmZmluZm8tPnsnZnJvbV9maWxlJ31bJGldIHx8ICRkaWZmaW5mby0+eyd0b19maWxlJ307CisJ
CQkkZnJvbS0+eydmaWxlJ31bJGldID0gCisJCQkJZGVmaW5lZCAkZGlmZmluZm8tPnsnZnJvbV9m
aWxlJ31bJGldID8KKwkJCQkgICAgICAgICRkaWZmaW5mby0+eydmcm9tX2ZpbGUnfVskaV0gOgor
CQkJCSAgICAgICAgJGRpZmZpbmZvLT57J3RvX2ZpbGUnfTsKIAkJCWlmICgkZGlmZmluZm8tPnsn
c3RhdHVzJ31bJGldIG5lICJBIikgeyAjIG5vdCBuZXcgKGFkZGVkKSBmaWxlCiAJCQkJJGZyb20t
PnsnaHJlZid9WyRpXSA9IGhyZWYoYWN0aW9uPT4iYmxvYiIsCiAJCQkJICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaGFzaF9iYXNlPT4kcGFyZW50c1skaV0sCkBAIC0yMDQ3LDcgKzIwNTAsNyBA
QCBzdWIgcGFyc2VfZnJvbV90b19kaWZmaW5mbyB7CiAJCX0KIAl9IGVsc2UgewogCQkjIG9yZGlu
YXJ5IChub3QgY29tYmluZWQpIGRpZmYKLQkJJGZyb20tPnsnZmlsZSd9ID0gJGRpZmZpbmZvLT57
J2Zyb21fZmlsZSd9IHx8ICRkaWZmaW5mby0+eydmaWxlJ307CisJCSRmcm9tLT57J2ZpbGUnfSA9
ICRkaWZmaW5mby0+eydmcm9tX2ZpbGUnfTsKIAkJaWYgKCRkaWZmaW5mby0+eydzdGF0dXMnfSBu
ZSAiQSIpIHsgIyBub3QgbmV3IChhZGRlZCkgZmlsZQogCQkJJGZyb20tPnsnaHJlZid9ID0gaHJl
ZihhY3Rpb249PiJibG9iIiwgaGFzaF9iYXNlPT4kaGFzaF9wYXJlbnQsCiAJCQkgICAgICAgICAg
ICAgICAgICAgICAgIGhhc2g9PiRkaWZmaW5mby0+eydmcm9tX2lkJ30sCkBAIC0yMDU3LDcgKzIw
NjAsNyBAQCBzdWIgcGFyc2VfZnJvbV90b19kaWZmaW5mbyB7CiAJCX0KIAl9CiAKLQkkdG8tPnsn
ZmlsZSd9ID0gJGRpZmZpbmZvLT57J3RvX2ZpbGUnfSB8fCAkZGlmZmluZm8tPnsnZmlsZSd9Owor
CSR0by0+eydmaWxlJ30gPSAkZGlmZmluZm8tPnsndG9fZmlsZSd9OwogCWlmICghaXNfZGVsZXRl
ZCgkZGlmZmluZm8pKSB7ICMgZmlsZSBleGlzdHMgaW4gcmVzdWx0CiAJCSR0by0+eydocmVmJ30g
PSBocmVmKGFjdGlvbj0+ImJsb2IiLCBoYXNoX2Jhc2U9PiRoYXNoLAogCQkgICAgICAgICAgICAg
ICAgICAgICBoYXNoPT4kZGlmZmluZm8tPnsndG9faWQnfSwKQEAgLTI4MDIsNyArMjgwNSw3IEBA
IHN1YiBpc19wYXRjaF9zcGxpdCB7CiAJbXkgKCRkaWZmaW5mbywgJHBhdGNoaW5mbykgPSBAXzsK
IAogCXJldHVybiBkZWZpbmVkICRkaWZmaW5mbyAmJiBkZWZpbmVkICRwYXRjaGluZm8KLQkJJiYg
KCRkaWZmaW5mby0+eyd0b19maWxlJ30gfHwgJGRpZmZpbmZvLT57J2ZpbGUnfSkgZXEgJHBhdGNo
aW5mby0+eyd0b19maWxlJ307CisJCSYmICRkaWZmaW5mby0+eyd0b19maWxlJ30gZXEgJHBhdGNo
aW5mby0+eyd0b19maWxlJ307CiB9CiAKIApAQCAtNDYzNyw4ICs0NjQwLDggQEAgc3ViIGdpdF9i
bG9iZGlmZiB7CiAJCX0KIAogCQklZGlmZmluZm8gPSBwYXJzZV9kaWZmdHJlZV9yYXdfbGluZSgk
ZGlmZnRyZWVbMF0pOwotCQkkZmlsZV9wYXJlbnQgfHw9ICRkaWZmaW5mb3snZnJvbV9maWxlJ30g
fHwgJGZpbGVfbmFtZSB8fCAkZGlmZmluZm97J2ZpbGUnfTsKLQkJJGZpbGVfbmFtZSAgIHx8PSAk
ZGlmZmluZm97J3RvX2ZpbGUnfSAgIHx8ICRkaWZmaW5mb3snZmlsZSd9OworCQkkZmlsZV9wYXJl
bnQgfHw9ICRkaWZmaW5mb3snZnJvbV9maWxlJ30gfHwgJGZpbGVfbmFtZTsKKwkJJGZpbGVfbmFt
ZSAgIHx8PSAkZGlmZmluZm97J3RvX2ZpbGUnfTsKIAogCQkkaGFzaF9wYXJlbnQgfHw9ICRkaWZm
aW5mb3snZnJvbV9pZCd9OwogCQkkaGFzaCAgICAgICAgfHw9ICRkaWZmaW5mb3sndG9faWQnfTsK
LS0gCjEuNS4zCgo=
------=_Part_12876_22694380.1190410789324--
