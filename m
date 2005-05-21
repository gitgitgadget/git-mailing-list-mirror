From: "Sean" <seanlkml@sympatico.ca>
Subject: [PATCH 2/3] - Convert git-fsck-cache to argp
Date: Sat, 21 May 2005 14:32:51 -0400 (EDT)
Message-ID: <2236.10.10.10.24.1116700371.squirrel@linux1>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050521143251_15599"
X-From: git-owner@vger.kernel.org Sat May 21 20:32:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZYlN-0005Ut-9w
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVEUSdC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 14:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVEUSdC
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 14:33:02 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:26327 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261763AbVEUScw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 14:32:52 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521183251.YOOE23474.simmts7-srv.bellnexxia.net@linux1>
          for <git@vger.kernel.org>; Sat, 21 May 2005 14:32:51 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LIWp61021511
	for <git@vger.kernel.org>; Sat, 21 May 2005 14:32:51 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 14:32:51 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050521143251_15599
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


First in a series of patches to convert git commands to use "argp" for
argument processing as suggested by Jeff Garzik.  This patch converts
git-fsck-cache.  It improves the usage message, adds a --version option,
and allows options to be combined together with a single leading dash.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
Acked-by: "Jeff Garzik" <jgarzik@pobox.com>
Acked-by: "Junio C Hamano" <junkio@cox.net>


 Documentation/git-fsck-cache.txt |    6 +++
 fsck-cache.c                     |   60
++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 27 deletions(-)


------=_20050521143251_15599
Content-Type: application/octet-stream; name="argp-fsck-cache-v3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="argp-fsck-cache-v3.patch"

SW5kZXg6IGZzY2stY2FjaGUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSA1ODc0MWM2OTU3MDcwNTgwMWRiNGI3
ODU2ODE3OTBkNjM2NDc1Njk1L2ZzY2stY2FjaGUuYyAgKG1vZGU6MTAwNjQ0KQorKysgdW5jb21t
aXR0ZWQvZnNjay1jYWNoZS5jICAobW9kZToxMDA2NDQpCkBAIC0xLDUgKzEsNyBAQAogI2luY2x1
ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPGRpcmVudC5oPgorI2luY2x1ZGUgPGFyZ3AuaD4K
K2NvbnN0IGNoYXIgKmFyZ3BfcHJvZ3JhbV92ZXJzaW9uID0gVkVSU0lPTjsKIAogI2luY2x1ZGUg
ImNhY2hlLmgiCiAjaW5jbHVkZSAiY29tbWl0LmgiCkBAIC00MDcsMzYgKzQwOSw0MiBAQAogCWZp
bmRfZmlsZV9vYmplY3RzKGdpdF9kaXIsICJyZWZzIik7CiB9CiAKK3N0YXRpYyBjb25zdCBjaGFy
IGRvY1tdID0gIlBlcmZvcm0gcmVwb3NpdG9yeSBjb25zaXN0ZW5jeSBjaGVjayI7CisKK3N0YXRp
YyBzdHJ1Y3QgYXJncF9vcHRpb24gb3B0aW9uc1tdID0geworIHsidW5yZWFjaGFibGUiLCAndScs
IDAsIDAsICJTaG93IG1pc3Npbmcgb2JqZWN0cyBvciBkZWx0YXMifSwKKyB7InRhZ3MiLCAndCcs
IDAsIDAsICJTaG93IHJldmlzaW9uIHRhZ3MifSwKKyB7InJvb3QiLCAncicsIDAsIDAsICJTaG93
IHJvb3Qgb2JqZWN0cywgaWUuIHRob3NlIHdpdGhvdXQgcGFyZW50cyJ9LAorIHsiZGVsdGEtZGVw
dGgiLCAnZCcsIDAsIDAsICJTaG93IHRoZSBtYXhpbXVtIGxlbmd0aCBvZiBkZWx0YSBjaGFpbnMi
fSwKKyB7ImNhY2hlIiwgJ2MnLCAwLCAwLCAiTWFyayBhbGwgb2JqZWN0cyByZWZlcmVuY2VkIGJ5
IGNhY2hlIGFzIHJlYWNoYWJsZSJ9LAorIHsgfQorfTsKKworc3RhdGljIGVycm9yX3QgcGFyc2Vf
b3B0IChpbnQga2V5LCBjaGFyICphcmcsIHN0cnVjdCBhcmdwX3N0YXRlICpzdGF0ZSkKK3sKKyAg
ICAgICAgc3dpdGNoIChrZXkpIHsKKyAgICAgICAgY2FzZSAndSc6CQlzaG93X3VucmVhY2hhYmxl
ID0gMTsgYnJlYWs7CisgICAgICAgIGNhc2UgJ3QnOgkJc2hvd190YWdzID0gMTsgYnJlYWs7Cisg
ICAgICAgIGNhc2UgJ3InOgkJc2hvd19yb290ID0gMTsgYnJlYWs7CisgICAgICAgIGNhc2UgJ2Qn
OgkJc2hvd19tYXhfZGVsdGFfZGVwdGggPSAxOyBicmVhazsKKyAgICAgICAgY2FzZSAnYyc6CQlr
ZWVwX2NhY2hlX29iamVjdHMgPSAxOyBicmVhazsKKyAgICAgICAgZGVmYXVsdDoJCXJldHVybiBB
UkdQX0VSUl9VTktOT1dOOworICAgICAgICB9CisgICAgICAgIHJldHVybiAwOworfQorCitzdGF0
aWMgY29uc3Qgc3RydWN0IGFyZ3AgYXJncCA9IHsgb3B0aW9ucywgcGFyc2Vfb3B0LCAiW0hFQUQt
U0hBMS4uLl0iLCBkb2MgfTsKKwogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewog
CWludCBpLCBoZWFkczsKIAljaGFyICpzaGExX2RpcjsKKwlpbnQgaWR4OwogCi0JZm9yIChpID0g
MTsgaSA8IGFyZ2M7IGkrKykgewotCQljb25zdCBjaGFyICphcmcgPSBhcmd2W2ldOwotCi0JCWlm
ICghc3RyY21wKGFyZywgIi0tdW5yZWFjaGFibGUiKSkgewotCQkJc2hvd191bnJlYWNoYWJsZSA9
IDE7Ci0JCQljb250aW51ZTsKLQkJfQotCQlpZiAoIXN0cmNtcChhcmcsICItLXRhZ3MiKSkgewot
CQkJc2hvd190YWdzID0gMTsKLQkJCWNvbnRpbnVlOwotCQl9Ci0JCWlmICghc3RyY21wKGFyZywg
Ii0tcm9vdCIpKSB7Ci0JCQlzaG93X3Jvb3QgPSAxOwotCQkJY29udGludWU7Ci0JCX0KLQkJaWYg
KCFzdHJjbXAoYXJnLCAiLS1kZWx0YS1kZXB0aCIpKSB7Ci0JCQlzaG93X21heF9kZWx0YV9kZXB0
aCA9IDE7Ci0JCQljb250aW51ZTsKLQkJfQotCQlpZiAoIXN0cmNtcChhcmcsICItLWNhY2hlIikp
IHsKLQkJCWtlZXBfY2FjaGVfb2JqZWN0cyA9IDE7Ci0JCQljb250aW51ZTsKLQkJfQotCQlpZiAo
KmFyZyA9PSAnLScpCi0JCQl1c2FnZSgiZ2l0LWZzY2stY2FjaGUgWy0tdGFnc10gW1stLXVucmVh
Y2hhYmxlXSBbLS1jYWNoZV0gPGhlYWQtc2hhMT4qXSIpOworCWVycm9yX3QgcmMgPSBhcmdwX3Bh
cnNlKCZhcmdwLCBhcmdjLCBhcmd2LCAwLCAmaWR4LCBOVUxMKTsKKwlpZiAocmMpIHsKKwkJZnBy
aW50ZihzdGRlcnIsICJhcmd1bWVudCBmYWlsZWQ6ICVzXG4iLCBzdHJlcnJvcihyYykpOworCQly
ZXR1cm4gMTsKIAl9CiAKIAlzaGExX2RpciA9IGdldF9vYmplY3RfZGlyZWN0b3J5KCk7CkBAIC00
NTAsNyArNDU4LDcgQEAKIAlleHBhbmRfZGVsdGFzKCk7CiAKIAloZWFkcyA9IDA7Ci0JZm9yIChp
ID0gMTsgaSA8IGFyZ2M7IGkrKykgeworCWZvciAoaSA9IGlkeDsgaSA8IGFyZ2M7IGkrKykgewog
CQljb25zdCBjaGFyICphcmcgPSBhcmd2W2ldOyAKIAogCQlpZiAoKmFyZyA9PSAnLScpCkluZGV4
OiBEb2N1bWVudGF0aW9uL2dpdC1mc2NrLWNhY2hlLnR4dAo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSA0NzA4OTI1
ZTNlM2I5NTVmZmNiNDE3ZmM0YWNkYmIwYWFmZGY4ZGMwL0RvY3VtZW50YXRpb24vZ2l0LWZzY2st
Y2FjaGUudHh0ICAobW9kZToxMDA2NDQpCisrKyB1bmNvbW1pdHRlZC9Eb2N1bWVudGF0aW9uL2dp
dC1mc2NrLWNhY2hlLnR4dCAgKG1vZGU6MTAwNjQ0KQpAQCAtOSw3ICs5LDggQEAKIAogU1lOT1BT
SVMKIC0tLS0tLS0tCi0nZ2l0LWZzY2stY2FjaGUnIFstLXRhZ3NdIFstLXJvb3RdIFtbLS11bnJl
YWNoYWJsZV0gWy0tY2FjaGVdIDxvYmplY3Q+XCpdCisnZ2l0LWZzY2stY2FjaGUnIFstLXRhZ3Nd
IFstLXJvb3RdIFstLWRlbHRhLWRlcHRoXSAKKwkJCVtbLS11bnJlYWNoYWJsZV0gWy0tY2FjaGVd
IDxvYmplY3Q+XCpdCiAKIERFU0NSSVBUSU9OCiAtLS0tLS0tLS0tLQpAQCAtMzQsNiArMzUsOSBA
QAogCUNvbnNpZGVyIGFueSBvYmplY3QgcmVjb3JkZWQgaW4gdGhlIGNhY2hlIGFsc28gYXMgYSBo
ZWFkIG5vZGUgZm9yCiAJYW4gdW5yZWFjaGFiaWxpdHkgdHJhY2UuCiAKKy0tZGVsdGEtZGVwdGg6
OgorCVNob3cgbGVuZ3RoIG9mIGxvbmdlc3QgZGVsdGEgY2hhaW4uCisKIEl0IHRlc3RzIFNIQTEg
YW5kIGdlbmVyYWwgb2JqZWN0IHNhbml0eSwgYW5kIGl0IGRvZXMgZnVsbCB0cmFja2luZyBvZgog
dGhlIHJlc3VsdGluZyByZWFjaGFiaWxpdHkgYW5kIGV2ZXJ5dGhpbmcgZWxzZS4gSXQgcHJpbnRz
IG91dCBhbnkKIGNvcnJ1cHRpb24gaXQgZmluZHMgKG1pc3Npbmcgb3IgYmFkIG9iamVjdHMpLCBh
bmQgaWYgeW91IHVzZSB0aGUK
------=_20050521143251_15599--


