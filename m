From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 6 Jun 2007 09:45:21 +0200
Message-ID: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22735_21506078.1181115921904"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:45:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvqCx-0001T5-0m
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXFFHpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbXFFHpY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:45:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:38409 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXFFHpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:45:23 -0400
Received: by wr-out-0506.google.com with SMTP id i21so33594wra
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 00:45:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=JUJbwE8h7icMrvuesunrO+8gcWWzqBtPL0V/gDmM5mhfYvQPW8w5FkGYLj7phvp60EnWKP6mLF3Xak/YZ71q6qru3/sAxDchu3I57yc/dij2szBKDn3g1mOiC3XHUT+KFhZf1Wyl0YA6QAtST9yUu3OlvIFYB565Qd9y1r0uU3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=LIi4NK5JrL4btVRKJjJzMxJdFqVtty9591jefTWYNsMYcLydUOC7sNvSlBLbSDVkvzBgqCeVs+5gNgAmb7Fzj5Gcpn2CG1ERie385kCE19MiOXr2HiJrS/wqSWCRJHoxKDMpXFhE/5s9Kp8bL166Z8MbjEGoF7v4itHjGnoJ0C0=
Received: by 10.78.171.20 with SMTP id t20mr59735hue.1181115921934;
        Wed, 06 Jun 2007 00:45:21 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 6 Jun 2007 00:45:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49257>

------=_Part_22735_21506078.1181115921904
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise ".git" is removed from every remote name which has it:

  $ git fetch -v
    * refs/heads/origin: same as branch 'master' of /home/user/linux
      commit: 5ecd310
  $ ls /home/user/linux
  ls: /home/user/linux: No such file or directory
  $ ls /home/user/linux.git
  HEAD  objects  packed-refs  ...

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-fetch--tool.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

------=_Part_22735_21506078.1181115921904
Content-Type: text/plain; 
	name=0001-Fix-the-remote-note-the-fetch-tool-prints-after-stor.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2lhvtm1
Content-Disposition: attachment; filename="0001-Fix-the-remote-note-the-fetch-tool-prints-after-stor.txt"

RnJvbSAxMDA3NDI4MjE2MTlmZGQ4M2U3NWFhOGRjYjg4NDg5YWE0YjYwNjQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhQGxpbWJvLmxvY2FsZG9tYWluPgpE
YXRlOiBXZWQsIDYgSnVuIDIwMDcgMDA6MTY6MTQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXgg
dGhlIHJlbW90ZSBub3RlIHRoZSBmZXRjaC10b29sIHByaW50cyBhZnRlciBzdG9yaW5nIGEgZmV0
Y2hlZCByZWZlcmVuY2UKCk90aGVyd2lzZSAiLmdpdCIgaXMgcmVtb3ZlZCBmcm9tIGV2ZXJ5IHJl
bW90ZSBuYW1lIHdoaWNoIGhhcyBpdDoKCiAgJCBnaXQgZmV0Y2ggLXYKICAgICogcmVmcy9oZWFk
cy9vcmlnaW46IHNhbWUgYXMgYnJhbmNoICdtYXN0ZXInIG9mIC9ob21lL3VzZXIvbGludXgKICAg
ICAgY29tbWl0OiA1ZWNkMzEwCiAgJCBscyAvaG9tZS91c2VyL2xpbnV4CiAgbHM6IC9ob21lL3Vz
ZXIvbGludXg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICAkIGxzIC9ob21lL3VzZXIvbGlu
dXguZ2l0CiAgSEVBRCAgb2JqZWN0cyAgcGFja2VkLXJlZnMgIC4uLgoKU2lnbmVkLW9mZi1ieTog
QWxleCBSaWVzZW4gPHJhYUBsaW1iby5sb2NhbGRvbWFpbj4KLS0tCiBidWlsdGluLWZldGNoLS10
b29sLmMgfCAgIDEyICsrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1mZXRjaC0tdG9vbC5jIGIv
YnVpbHRpbi1mZXRjaC0tdG9vbC5jCmluZGV4IGVkNGQ1ZGUuLjIyY2ExMjUgMTAwNjQ0Ci0tLSBh
L2J1aWx0aW4tZmV0Y2gtLXRvb2wuYworKysgYi9idWlsdGluLWZldGNoLS10b29sLmMKQEAgLTE0
MCw3ICsxNDAsNyBAQCBzdGF0aWMgaW50IGFwcGVuZF9mZXRjaF9oZWFkKEZJTEUgKmZwLAogCQkJ
ICAgICBpbnQgdmVyYm9zZSwgaW50IGZvcmNlKQogewogCXN0cnVjdCBjb21taXQgKmNvbW1pdDsK
LQlpbnQgcmVtb3RlX2xlbiwgaSwgbm90ZV9sZW47CisJaW50IHJlbW90ZV9sZW4sIG5vdGVfbGVu
OwogCXVuc2lnbmVkIGNoYXIgc2hhMVsyMF07CiAJY2hhciBub3RlWzEwMjRdOwogCWNvbnN0IGNo
YXIgKndoYXQsICpraW5kOwpAQCAtMTczLDExICsxNzMsMTEgQEAgc3RhdGljIGludCBhcHBlbmRf
ZmV0Y2hfaGVhZChGSUxFICpmcCwKIAl9CiAKIAlyZW1vdGVfbGVuID0gc3RybGVuKHJlbW90ZSk7
Ci0JZm9yIChpID0gcmVtb3RlX2xlbiAtIDE7IHJlbW90ZVtpXSA9PSAnLycgJiYgMCA8PSBpOyBp
LS0pCi0JCTsKLQlyZW1vdGVfbGVuID0gaSArIDE7Ci0JaWYgKDQgPCBpICYmICFzdHJuY21wKCIu
Z2l0IiwgcmVtb3RlICsgaSAtIDMsIDQpKQotCQlyZW1vdGVfbGVuID0gaSAtIDM7CisJaWYgKHJl
bW90ZV9sZW4gPiA1KSB7CisJCWNoYXIgKnAgPSBzdHJyY2hyKHJlbW90ZSwgJy8nKTsKKwkJaWYg
KHAgJiYgIXN0cmNtcChwLCAiLy5naXQiKSkKKwkJICAgIHJlbW90ZV9sZW4gLT0gNDsKKwl9CiAK
IAlub3RlX2xlbiA9IDA7CiAJaWYgKCp3aGF0KSB7Ci0tIAoxLjUuMi4xLjEzNC5nMzUyYgoK
------=_Part_22735_21506078.1181115921904--
