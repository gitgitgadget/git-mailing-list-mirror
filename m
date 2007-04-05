From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 02/13] declare overflow during base128 decoding when 1 MSB nonzero, not 7
Date: Thu, 5 Apr 2007 15:24:49 -0700
Message-ID: <56b7f5510704051524p28eafc18mae3131ef13cdabfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58963_21877745.1175811889115"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaNy-0003pd-Bk
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767215AbXDEWYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767367AbXDEWYv
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:24:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:10343 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767215AbXDEWYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:24:50 -0400
Received: by nz-out-0506.google.com with SMTP id s1so401704nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:24:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=eTMEbctWT51nEJ73Ub23BCd713lwYhzJSVHOWO5MYNrzqW7jXHleiq+fpmf/srikQHsU/eE9lBz3i1WaxvzXxb0vCP0p4L78bGHppv54EL+VWbKlyLMdsrmi304Yf9gJ1wSFuq2m6X+g5RlfnCvGuPXiFYx4bm7vMU1YnFKrAHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=rc5JmMhQvn9sxAVG1/mCLX/FQ4iIcPGWgXhenJHBkNKuPBraYKn/aLp/ooSuPFT8DyLuYLm6BNYBpDpJk8DBfFGDPASWB/ruANjbQrsyVhynkSHXB0kZYEb8JNiw0akCP7P5DV25po+NVjHjEaRLQ4TZrg9YHaZ2/eMpeDPrbf4=
Received: by 10.115.33.1 with SMTP id l1mr954585waj.1175811889188;
        Thu, 05 Apr 2007 15:24:49 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:24:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43865>

------=_Part_58963_21877745.1175811889115
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c   |    2 +-
 builtin-unpack-objects.c |    2 +-
 index-pack.c             |    2 +-
 sha1_file.c              |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_58963_21877745.1175811889115
Content-Type: text/plain; name="0002-declare-overflow-during-base128-decoding-when-1-MSB.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-declare-overflow-during-base128-decoding-when-1-MSB.patch.txt"
X-Attachment-Id: f_f05s185s

RnJvbSA5MDkzN2I3MjJmMzkxYWJlMWNiYzAzNWMyOWIzM2Y1MDBjMzg5MzM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTI6MTU6MjIgLTA3MDAKU3ViamVjdDogW1BBVENIIDAy
LzEzXSBkZWNsYXJlIG92ZXJmbG93IGR1cmluZyBiYXNlMTI4IGRlY29kaW5nIHdoZW4gMSBNU0Ig
bm9uemVybywgbm90IDcKCi0tLQogYnVpbHRpbi1wYWNrLW9iamVjdHMuYyAgIHwgICAgMiArLQog
YnVpbHRpbi11bnBhY2stb2JqZWN0cy5jIHwgICAgMiArLQogaW5kZXgtcGFjay5jICAgICAgICAg
ICAgIHwgICAgMiArLQogc2hhMV9maWxlLmMgICAgICAgICAgICAgIHwgICAgMiArLQogNCBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YnVpbHRpbi1wYWNrLW9iamVjdHMuYyBiL2J1aWx0aW4tcGFjay1vYmplY3RzLmMKaW5kZXggYjVm
OTY0OC4uNTAyNDZlMSAxMDA2NDQKLS0tIGEvYnVpbHRpbi1wYWNrLW9iamVjdHMuYworKysgYi9i
dWlsdGluLXBhY2stb2JqZWN0cy5jCkBAIC0xMDE0LDcgKzEwMTQsNyBAQCBzdGF0aWMgdm9pZCBj
aGVja19vYmplY3Qoc3RydWN0IG9iamVjdF9lbnRyeSAqZW50cnkpCiAJCQkJb2ZzID0gYyAmIDEy
NzsKIAkJCQl3aGlsZSAoYyAmIDEyOCkgewogCQkJCQlvZnMgKz0gMTsKLQkJCQkJaWYgKCFvZnMg
fHwgb2ZzICYgfih+MFVMID4+IDcpKQorCQkJCQlpZiAoIW9mcyB8fCBvZnMgJiB+KH4wVUwgPj4g
MSkpCiAJCQkJCQlkaWUoImRlbHRhIGJhc2Ugb2Zmc2V0IG92ZXJmbG93IGluIHBhY2sgZm9yICVz
IiwKIAkJCQkJCSAgICBzaGExX3RvX2hleChlbnRyeS0+c2hhMSkpOwogCQkJCQljID0gYnVmW3Vz
ZWRfMCsrXTsKZGlmZiAtLWdpdCBhL2J1aWx0aW4tdW5wYWNrLW9iamVjdHMuYyBiL2J1aWx0aW4t
dW5wYWNrLW9iamVjdHMuYwppbmRleCAzOTU2YzU2Li44NGE2YzVjIDEwMDY0NAotLS0gYS9idWls
dGluLXVucGFjay1vYmplY3RzLmMKKysrIGIvYnVpbHRpbi11bnBhY2stb2JqZWN0cy5jCkBAIC0y
MDksNyArMjA5LDcgQEAgc3RhdGljIHZvaWQgdW5wYWNrX2RlbHRhX2VudHJ5KGVudW0gb2JqZWN0
X3R5cGUgdHlwZSwgdW5zaWduZWQgbG9uZyBkZWx0YV9zaXplLAogCQliYXNlX29mZnNldCA9IGMg
JiAxMjc7CiAJCXdoaWxlIChjICYgMTI4KSB7CiAJCQliYXNlX29mZnNldCArPSAxOwotCQkJaWYg
KCFiYXNlX29mZnNldCB8fCBiYXNlX29mZnNldCAmIH4ofjBVTCA+PiA3KSkKKwkJCWlmICghYmFz
ZV9vZmZzZXQgfHwgYmFzZV9vZmZzZXQgJiB+KH4wVUwgPj4gMSkpCiAJCQkJZGllKCJvZmZzZXQg
dmFsdWUgb3ZlcmZsb3cgZm9yIGRlbHRhIGJhc2Ugb2JqZWN0Iik7CiAJCQlwYWNrID0gZmlsbCgx
KTsKIAkJCWMgPSAqcGFjazsKZGlmZiAtLWdpdCBhL2luZGV4LXBhY2suYyBiL2luZGV4LXBhY2su
YwppbmRleCAzYzc2OGZiLi4wMjcyMmY3IDEwMDY0NAotLS0gYS9pbmRleC1wYWNrLmMKKysrIGIv
aW5kZXgtcGFjay5jCkBAIC0yNDksNyArMjQ5LDcgQEAgc3RhdGljIHZvaWQgKnVucGFja19yYXdf
ZW50cnkoc3RydWN0IG9iamVjdF9lbnRyeSAqb2JqLCB1bmlvbiBkZWx0YV9iYXNlICpkZWx0YV8K
IAkJYmFzZV9vZmZzZXQgPSBjICYgMTI3OwogCQl3aGlsZSAoYyAmIDEyOCkgewogCQkJYmFzZV9v
ZmZzZXQgKz0gMTsKLQkJCWlmICghYmFzZV9vZmZzZXQgfHwgYmFzZV9vZmZzZXQgJiB+KH4wVUwg
Pj4gNykpCisJCQlpZiAoIWJhc2Vfb2Zmc2V0IHx8IGJhc2Vfb2Zmc2V0ICYgfih+MFVMID4+IDEp
KQogCQkJCWJhZF9vYmplY3Qob2JqLT5vZmZzZXQsICJvZmZzZXQgdmFsdWUgb3ZlcmZsb3cgZm9y
IGRlbHRhIGJhc2Ugb2JqZWN0Iik7CiAJCQlwID0gZmlsbCgxKTsKIAkJCWMgPSAqcDsKZGlmZiAt
LWdpdCBhL3NoYTFfZmlsZS5jIGIvc2hhMV9maWxlLmMKaW5kZXggOWMyNjAzOC4uNzA4MmQzZSAx
MDA2NDQKLS0tIGEvc2hhMV9maWxlLmMKKysrIGIvc2hhMV9maWxlLmMKQEAgLTExNDksNyArMTE0
OSw3IEBAIHN0YXRpYyBvZmZfdCBnZXRfZGVsdGFfYmFzZShzdHJ1Y3QgcGFja2VkX2dpdCAqcCwK
IAkJYmFzZV9vZmZzZXQgPSBjICYgMTI3OwogCQl3aGlsZSAoYyAmIDEyOCkgewogCQkJYmFzZV9v
ZmZzZXQgKz0gMTsKLQkJCWlmICghYmFzZV9vZmZzZXQgfHwgYmFzZV9vZmZzZXQgJiB+KH4wVUwg
Pj4gNykpCisJCQlpZiAoIWJhc2Vfb2Zmc2V0IHx8IGJhc2Vfb2Zmc2V0ICYgfih+MFVMID4+IDEp
KQogCQkJCWRpZSgib2Zmc2V0IHZhbHVlIG92ZXJmbG93IGZvciBkZWx0YSBiYXNlIG9iamVjdCIp
OwogCQkJYyA9IGJhc2VfaW5mb1t1c2VkKytdOwogCQkJYmFzZV9vZmZzZXQgPSAoYmFzZV9vZmZz
ZXQgPDwgNykgKyAoYyAmIDEyNyk7Ci0tIAoxLjUuMS5yYzIuMTguZzljODgtZGlydHkKCg==
------=_Part_58963_21877745.1175811889115--
