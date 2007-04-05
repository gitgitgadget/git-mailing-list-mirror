From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 04/13] support rollback on writes to checksummed files
Date: Thu, 5 Apr 2007 15:29:32 -0700
Message-ID: <56b7f5510704051529k55a96bdfy5b072b220f8269a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58999_26169062.1175812172602"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaSX-0005FM-DG
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767200AbXDEW3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767369AbXDEW3e
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:29:34 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:11694 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767200AbXDEW3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:29:33 -0400
Received: by nz-out-0506.google.com with SMTP id s1so402275nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:29:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=knp3UXn1wUiJaOTdl6OwRpdebVVZ1BBQfLLPU2chxr4E5b/rsxPsNXsceO96v61WbhUQO+gh11axdhWa9h5uDTJiinec/kksydij4UYJiy20CTXGNUScoDXUCPRZLywmwL4Te/lVl/sQJLyd3rcx80plCtm3v7ZTVmVX/aLjVAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Q7CHu8mcQVeSaRbwcO6LiHNCHmaMNKG1wROBEssFJxMvzguFKzRQxm1P87AiA7fdnhmq/n3T3XFalsAKdLtLwz5pTsINCP3TXSDOIAF3eg+hzKkUYdcFaFsgCDWyRcAkDIK/wsmfaA1jrCJKAeBETutXhNHPzYModGkYkqsmKC4=
Received: by 10.115.75.1 with SMTP id c1mr959716wal.1175812172667;
        Thu, 05 Apr 2007 15:29:32 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:29:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43867>

------=_Part_58999_26169062.1175812172602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

add struct sha1posn, sha1mark(), sha1undo() to csum-file.[ch]
---
 csum-file.c |   38 ++++++++++++++++++++++++++++++++++++++
 csum-file.h |    6 ++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_58999_26169062.1175812172602
Content-Type: text/plain; name="0004-support-rollback-on-writes-to-checksummed-files.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0004-support-rollback-on-writes-to-checksummed-files.patch.txt"
X-Attachment-Id: f_f05s77oa

RnJvbSAxZGY5ZTQ0M2NlMTEzNjVmOTU1YjgzZTcwMzY1NjcwZmY5YWRhOGQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTM6MTM6NDIgLTA3MDAKU3ViamVjdDogW1BBVENIIDA0
LzEzXSBzdXBwb3J0IHJvbGxiYWNrIG9uIHdyaXRlcyB0byBjaGVja3N1bW1lZCBmaWxlcwphZGQg
c3RydWN0IHNoYTFwb3NuLCBzaGExbWFyaygpLCBzaGExdW5kbygpIHRvIGNzdW0tZmlsZS5bY2hd
Ci0tLQogY3N1bS1maWxlLmMgfCAgIDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiBjc3VtLWZpbGUuaCB8ICAgIDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQ0IGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY3N1bS1maWxlLmMgYi9j
c3VtLWZpbGUuYwppbmRleCBlMWZmNzY5Li5lMmJlZjc1IDEwMDY0NAotLS0gYS9jc3VtLWZpbGUu
YworKysgYi9jc3VtLWZpbGUuYwpAQCAtNzIsNiArNzIsNDQgQEAgaW50IHNoYTF3cml0ZShzdHJ1
Y3Qgc2hhMWZpbGUgKmYsIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGNvdW50KQogCXJldHVybiAw
OwogfQogCisvKgorICogU2F2ZSBjdXJyZW50IHBvc2l0aW9uL3N0YXRlIGluIG91dHB1dCBmaWxl
CisgKiAobmVlZHMgdG8gYmUgZmFzdCAtLSBubyBzeXN0ZW0gY2FsbHMhKQorICovCit2b2lkIHNo
YTFtYXJrKHN0cnVjdCBzaGExZmlsZSAqZiwgc3RydWN0IHNoYTFwb3NuICpwKQoreworCXAtPm9m
ZnNldCA9IGYtPm9mZnNldDsKKwlwLT5jdHggPSBmLT5jdHg7CS8qIGxhcmdlciB0aGFuIEknZCBs
aWtlICovCit9CisKKy8qCisgKiBSZXN0b3JlIHByZXZpb3VzIHBvc2l0aW9uL3N0YXRlIGluIG91
dHB1dCBmaWxlCisgKiAoY2FuIGJlIHNsb3cpCisgKi8KK3ZvaWQgc2hhMXVuZG8oc3RydWN0IHNo
YTFmaWxlICpmLCBzdHJ1Y3Qgc2hhMXBvc24gKnAsIGxvbmcgbmV3LCBsb25nIG9sZCkKK3sKKwlp
ZiAobmV3IC0gb2xkID09IChsb25nKWYtPm9mZnNldCAtIChsb25nKXAtPm9mZnNldCkgeworCQlm
LT5jdHggPSBwLT5jdHg7CisJCWYtPm9mZnNldCA9IHAtPm9mZnNldDsKKwkJcmV0dXJuOworCX0K
KwlpZiAobHNlZWsoZi0+ZmQsIChvZmZfdClvbGQgLSAob2ZmX3QpcC0+b2Zmc2V0LCBTRUVLX1NF
VCkgPT0gKG9mZl90KS0xKQorCQlkaWUoInNoYTEgZmlsZSAnJXMnIHVuZG8gc2Vla2JhY2sgZXJy
b3IgKCVzKSIsIGYtPm5hbWUsIHN0cmVycm9yKGVycm5vKSk7CisJZi0+Y3R4ID0gcC0+Y3R4Owor
CXdoaWxlIChwLT5vZmZzZXQpIHsKKwkJaW50IHJldCA9IHhyZWFkKGYtPmZkLCBmLT5idWZmZXIs
IHAtPm9mZnNldCk7CisJCWlmICghcmV0KQorCQkJZGllKCJzaGExIGZpbGUgJyVzJyB1bmRvIHJl
YWRiYWNrIGVycm9yLiBObyBkYXRhIiwgZi0+bmFtZSk7CisJCWlmIChyZXQgPCAwKQorCQkJZGll
KCJzaGExIGZpbGUgJyVzJyB1bmRvIHJlYWRiYWNrIGVycm9yICglcykiLCBmLT5uYW1lLCBzdHJl
cnJvcihlcnJubykpOworCQlTSEExX1VwZGF0ZSgmZi0+Y3R4LCBmLT5idWZmZXIsIHJldCk7CisJ
CXAtPm9mZnNldCAtPSByZXQ7CisJfQorCWlmIChmdHJ1bmNhdGUoZi0+ZmQsIChvZmZfdClvbGQp
KQorCQlkaWUoInNoYTEgZmlsZSAnJXMnIHVuZG8gdHJ1bmNhdGUgZXJyb3IgKCVzKSIsIGYtPm5h
bWUsIHN0cmVycm9yKGVycm5vKSk7CisJZi0+b2Zmc2V0ID0gMDsKK30KKwogc3RydWN0IHNoYTFm
aWxlICpzaGExY3JlYXRlKGNvbnN0IGNoYXIgKmZtdCwgLi4uKQogewogCXN0cnVjdCBzaGExZmls
ZSAqZjsKZGlmZiAtLWdpdCBhL2NzdW0tZmlsZS5oIGIvY3N1bS1maWxlLmgKaW5kZXggM2FkMWE5
OS4uNzgwZGYxNyAxMDA2NDQKLS0tIGEvY3N1bS1maWxlLmgKKysrIGIvY3N1bS1maWxlLmgKQEAg
LTksMTEgKzksMTcgQEAgc3RydWN0IHNoYTFmaWxlIHsKIAljaGFyIG5hbWVbUEFUSF9NQVhdOwog
CXVuc2lnbmVkIGNoYXIgYnVmZmVyWzgxOTJdOwogfTsKK3N0cnVjdCBzaGExcG9zbiB7CisJdW5z
aWduZWQgaW50IG9mZnNldDsKKwlTSEFfQ1RYIGN0eDsKK307CiAKIGV4dGVybiBzdHJ1Y3Qgc2hh
MWZpbGUgKnNoYTFmZChpbnQgZmQsIGNvbnN0IGNoYXIgKm5hbWUpOwogZXh0ZXJuIHN0cnVjdCBz
aGExZmlsZSAqc2hhMWNyZWF0ZShjb25zdCBjaGFyICpmbXQsIC4uLikgX19hdHRyaWJ1dGVfXygo
Zm9ybWF0IChwcmludGYsIDEsIDIpKSk7CiBleHRlcm4gaW50IHNoYTFjbG9zZShzdHJ1Y3Qgc2hh
MWZpbGUgKiwgdW5zaWduZWQgY2hhciAqLCBpbnQpOwogZXh0ZXJuIGludCBzaGExd3JpdGUoc3Ry
dWN0IHNoYTFmaWxlICosIHZvaWQgKiwgdW5zaWduZWQgaW50KTsKIGV4dGVybiBpbnQgc2hhMXdy
aXRlX2NvbXByZXNzZWQoc3RydWN0IHNoYTFmaWxlICosIHZvaWQgKiwgdW5zaWduZWQgaW50KTsK
K2V4dGVybiB2b2lkIHNoYTFtYXJrKHN0cnVjdCBzaGExZmlsZSAqLCBzdHJ1Y3Qgc2hhMXBvc24g
Kik7CitleHRlcm4gdm9pZCBzaGExdW5kbyhzdHJ1Y3Qgc2hhMWZpbGUgKiwgc3RydWN0IHNoYTFw
b3NuICosIGxvbmcsIGxvbmcpOwogCiAjZW5kaWYKLS0gCjEuNS4xLnJjMi4xOC5nOWM4OC1kaXJ0
eQoK
------=_Part_58999_26169062.1175812172602--
