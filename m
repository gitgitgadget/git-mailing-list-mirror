From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 6 Jun 2007 17:52:16 +0200
Message-ID: <81b0412b0706060852y4ab6b794m5fed0484c63159e4@mail.gmail.com>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26542_28743482.1181145136973"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 17:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvxoP-0007ab-97
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 17:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934768AbXFFPwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 11:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934780AbXFFPwT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 11:52:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:28233 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934768AbXFFPwS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 11:52:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so475237ugf
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 08:52:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=EoQMpzhS6atXnMYrEezXWH+Xa2iMmO2KhEE663WKljlo8PKwHLTkvs4uUhByBFVVQJq8h1Ekm7eBSFa89FKtjkYo+TRZj2AsInXUgruYTf1Ymujt7DYyZhGFR7QHmHrlV8sCgS9axPe9CQDppFs1pX302tVic40uB9Byhim6H2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JWOfjcnr1BbhAvEYKfDgn34fqiRWz4ATRenxYYubWC0/yuTIv6f6QFo90Dqr3SCiXU18WzzReSnsQ2FY8ausfdwJkus/VqKLmK5o50BzqEUGSGruVnOyGbcgzi7PuX06FPXANdlu/kvNpdfRqwibMP6q/BFzPC/TwwHs61OCsXQ=
Received: by 10.78.170.17 with SMTP id s17mr239152hue.1181145137006;
        Wed, 06 Jun 2007 08:52:17 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 6 Jun 2007 08:52:16 -0700 (PDT)
In-Reply-To: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49295>

------=_Part_26542_28743482.1181145136973
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise ".git" is removed from every remote path which has it,
including "/some/path/somename.git".

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Fixed truncation of "/.git/" (with a trailing slash).
The old code broke t5515, because it has left "../.git/"
unchanged, but should have removed ".git/".

 builtin-fetch--tool.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

------=_Part_26542_28743482.1181145136973
Content-Type: text/plain; 
	name=0001-Fix-the-remote-note-the-fetch-tool-prints-after-stori.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2lz84n9
Content-Disposition: attachment; filename="0001-Fix-the-remote-note-the-fetch-tool-prints-after-stori.txt"

RnJvbSBjNzY3ZGNjMjAwMGM3MjkwOTAxM2I5ZTk3YjE4NDAzNjg2YjQ0NDk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhQGxpbWJvLmxvY2FsZG9tYWluPgpE
YXRlOiBXZWQsIDYgSnVuIDIwMDcgMDA6MTY6MTQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXgg
dGhlIHJlbW90ZSBub3RlIHRoZSBmZXRjaC10b29sIHByaW50cyBhZnRlciBzdG9yaW5nIGEgZmV0
Y2hlZCByZWZlcmVuY2UKCk90aGVyd2lzZSAiLmdpdCIgaXMgcmVtb3ZlZCBmcm9tIGV2ZXJ5IHJl
bW90ZSBuYW1lIHdoaWNoIGhhcyBpdDoKCiAgJCBnaXQgZmV0Y2ggLXYKICAgICogcmVmcy9oZWFk
cy9vcmlnaW46IHNhbWUgYXMgYnJhbmNoICdtYXN0ZXInIG9mIC9ob21lL3VzZXIvbGludXgKICAg
ICAgY29tbWl0OiA1ZWNkMzEwCiAgJCBscyAvaG9tZS91c2VyL2xpbnV4CiAgbHM6IC9ob21lL3Vz
ZXIvbGludXg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICAkIGxzIC9ob21lL3VzZXIvbGlu
dXguZ2l0CiAgSEVBRCAgb2JqZWN0cyAgcGFja2VkLXJlZnMgIC4uLgoKU2lnbmVkLW9mZi1ieTog
QWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBidWlsdGluLWZldGNoLS10b29s
LmMgfCAgIDIxICsrKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4tZmV0Y2gtLXRv
b2wuYyBiL2J1aWx0aW4tZmV0Y2gtLXRvb2wuYwppbmRleCBlZDRkNWRlLi5lYzRhOGMzIDEwMDY0
NAotLS0gYS9idWlsdGluLWZldGNoLS10b29sLmMKKysrIGIvYnVpbHRpbi1mZXRjaC0tdG9vbC5j
CkBAIC0xNDAsNyArMTQwLDcgQEAgc3RhdGljIGludCBhcHBlbmRfZmV0Y2hfaGVhZChGSUxFICpm
cCwKIAkJCSAgICAgaW50IHZlcmJvc2UsIGludCBmb3JjZSkKIHsKIAlzdHJ1Y3QgY29tbWl0ICpj
b21taXQ7Ci0JaW50IHJlbW90ZV9sZW4sIGksIG5vdGVfbGVuOworCWludCByZW1vdGVfbGVuLCBu
b3RlX2xlbjsKIAl1bnNpZ25lZCBjaGFyIHNoYTFbMjBdOwogCWNoYXIgbm90ZVsxMDI0XTsKIAlj
b25zdCBjaGFyICp3aGF0LCAqa2luZDsKQEAgLTE3MywxMSArMTczLDIwIEBAIHN0YXRpYyBpbnQg
YXBwZW5kX2ZldGNoX2hlYWQoRklMRSAqZnAsCiAJfQogCiAJcmVtb3RlX2xlbiA9IHN0cmxlbihy
ZW1vdGUpOwotCWZvciAoaSA9IHJlbW90ZV9sZW4gLSAxOyByZW1vdGVbaV0gPT0gJy8nICYmIDAg
PD0gaTsgaS0tKQotCQk7Ci0JcmVtb3RlX2xlbiA9IGkgKyAxOwotCWlmICg0IDwgaSAmJiAhc3Ry
bmNtcCgiLmdpdCIsIHJlbW90ZSArIGkgLSAzLCA0KSkKLQkJcmVtb3RlX2xlbiA9IGkgLSAzOwor
CWlmIChyZW1vdGVfbGVuID4gNSkgeworCQlzdGF0aWMgY29uc3QgY2hhciBlbmRpbmdbXSA9ICIv
LmdpdCI7CisJCWNvbnN0IGNoYXIgKnBlID0gZW5kaW5nICsgNDsKKwkJY29uc3QgY2hhciAqcHIg
PSByZW1vdGUgKyByZW1vdGVfbGVuIC0gMTsKKwkJLyogaWdub3JlIHRyYWlsaW5nIHNsYXNoZXMg
Ki8KKwkJd2hpbGUgKHByID4gcmVtb3RlICYmICpwciA9PSAnLycpCisJCQktLXByOworCQlmb3Ig
KDsgcHIgPiByZW1vdGUgJiYgcGUgPiBlbmRpbmc7IC0tcHIsIC0tcGUpCisJCQlpZiAoKnByICE9
ICpwZSkKKwkJCQlicmVhazsKKwkJaWYgKHBlID09IGVuZGluZykKKwkJCS8qICIrIDEiIHRvIGxl
YXZlIHRoZSAvIGJlZm9yZSAuZ2l0ICovCisJCQlyZW1vdGVfbGVuID0gcHIgLSByZW1vdGUgKyAx
OworCX0KIAogCW5vdGVfbGVuID0gMDsKIAlpZiAoKndoYXQpIHsKLS0gCjEuNS4yLjEuODY4Lmdi
ODVjMQoK
------=_Part_26542_28743482.1181145136973--
