From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 11:54:52 +0100
Message-ID: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_873_9633877.1196160892718"
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 11:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwy5z-0005iL-LP
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 11:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbXK0Ky4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 05:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbXK0Ky4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 05:54:56 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:23037 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbXK0Kyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 05:54:54 -0500
Received: by el-out-1112.google.com with SMTP id v27so368226ele
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=mTyysB/sahjbg18bLC2N2YOYRUlo7X0YLE1QJBlZJ+M=;
        b=U2REEtMxNrBXmUvcs/B6Ub8HgO865j4vGCEG/zPQpmrS9BKpFpG8c8a/0627cVP3+3W4swWi5XUxLSDVRaOEs9lLRRMb2D/fRv+P4FXFUu48nm56Xrw6YKKUyNe5dKlUGHeeT5Iql97agV2sB/nFNDyyrU8m1WNqguNcy1WtvdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Rl4yMMmbk1EMWiPqhL/AxsavhCknWqWLrisBKolymOoDWIiU+Ix5wJg6oF2Heo8PfdPBj/WVeB/FlaB0alduahXeQGOZV7t0BtzvkWyBbtMyubLO/7As1ePEOAbBORnqE4Fkcgdy4ZNDSquvJvbF6n7Fuae84/GN0Mk4L2ZOI2g=
Received: by 10.78.201.2 with SMTP id y2mr3988003huf.1196160892774;
        Tue, 27 Nov 2007 02:54:52 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 02:54:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66183>

------=_Part_873_9633877.1196160892718
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The option is to enable operation exclusively on the index, without touching
working tree. Besides speeding up commit process on performance-challenged
platforms it also has to ensure that the index is commited exactly how
user sees it.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-commit.c  |   15 +++++++++++++--
 t/t7502-commit.sh |   30 ++++++++++++++++++++++++++++++
 wt-status.c       |    6 ++++--
 wt-status.h       |    1 +
 4 files changed, 48 insertions(+), 4 deletions(-)

Triggered by perpetual Windows/Cygwin problems.

------=_Part_873_9633877.1196160892718
Content-Type: text/x-patch;
 name=0001-Add-cached-to-builtin-commit-operate-only-on-inde.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9ib6nfd
Content-Disposition: attachment;
 filename=0001-Add-cached-to-builtin-commit-operate-only-on-inde.patch

RnJvbSBiN2NjYjZlZjk0ZmU4ZWQ3ZTlhZDIzMmJhOWFjNzcyMDA4YjJiOTRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDI3IE5vdiAyMDA3IDExOjQ2OjM5ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gYnVpbHRp
bi1jb21taXQ6IGFkZCAtLWNhY2hlZCB0byBvcGVyYXRlIG9ubHkgb24gaW5kZXgKClRoZSBvcHRp
b24gaXMgdG8gZW5hYmxlIG9wZXJhdGlvbiBleGNsdXNpdmVseSBvbiB0aGUgaW5kZXgsIHdpdGhv
dXQgdG91Y2hpbmcKd29ya2luZyB0cmVlLiBCZXNpZGVzIHNwZWVkaW5nIHVwIGNvbW1pdCBwcm9j
ZXNzIG9uIHBlcmZvcm1hbmNlLWNoYWxsZW5nZWQKcGxhdGZvcm1zIGl0IGFsc28gaGFzIHRvIGVu
c3VyZSB0aGF0IHRoZSBpbmRleCBpcyBjb21taXRlZCBleGFjdGx5IGhvdwp1c2VyIHNlZXMgaXQu
CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgotLS0KIGJ1
aWx0aW4tY29tbWl0LmMgIHwgICAxNSArKysrKysrKysrKysrLS0KIHQvdDc1MDItY29tbWl0LnNo
IHwgICAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHd0LXN0YXR1cy5jICAgICAg
IHwgICAgNiArKysrLS0KIHd0LXN0YXR1cy5oICAgICAgIHwgICAgMSArCiA0IGZpbGVzIGNoYW5n
ZWQsIDQ4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRp
bi1jb21taXQuYyBiL2J1aWx0aW4tY29tbWl0LmMKaW5kZXggYTM1ODgxZS4uNmFhNDU5ZSAxMDA2
NDQKLS0tIGEvYnVpbHRpbi1jb21taXQuYworKysgYi9idWlsdGluLWNvbW1pdC5jCkBAIC00NCw2
ICs0NCw3IEBAIHN0YXRpYyBpbnQgYWxsLCBlZGl0X2ZsYWcsIGFsc28sIGludGVyYWN0aXZlLCBv
bmx5LCBhbWVuZCwgc2lnbm9mZjsKIHN0YXRpYyBpbnQgcXVpZXQsIHZlcmJvc2UsIHVudHJhY2tl
ZF9maWxlcywgbm9fdmVyaWZ5OwogCiBzdGF0aWMgaW50IG5vX2VkaXQsIGluaXRpYWxfY29tbWl0
LCBpbl9tZXJnZTsKK3N0YXRpYyBpbnQgY2FjaGVkX29ubHk7CiBjb25zdCBjaGFyICpvbmx5X2lu
Y2x1ZGVfYXNzdW1lZDsKIHN0cnVjdCBzdHJidWYgbWVzc2FnZTsKIApAQCAtODIsNiArODMsNyBA
QCBzdGF0aWMgc3RydWN0IG9wdGlvbiBidWlsdGluX2NvbW1pdF9vcHRpb25zW10gPSB7CiAJT1BU
X0JPT0xFQU4oJ24nLCAibm8tdmVyaWZ5IiwgJm5vX3ZlcmlmeSwgImJ5cGFzcyBwcmUtY29tbWl0
IGhvb2siKSwKIAlPUFRfQk9PTEVBTigwLCAiYW1lbmQiLCAmYW1lbmQsICJhbWVuZCBwcmV2aW91
cyBjb21taXQiKSwKIAlPUFRfQk9PTEVBTigwLCAidW50cmFja2VkLWZpbGVzIiwgJnVudHJhY2tl
ZF9maWxlcywgInNob3cgYWxsIHVudHJhY2tlZCBmaWxlcyIpLAorCU9QVF9CT09MRUFOKDAsICJj
YWNoZWQiLCAmY2FjaGVkX29ubHksICJjb25zaWRlciBvbmx5IGNhY2hlZCBmaWxlcyIpLAogCiAJ
T1BUX0VORCgpCiB9OwpAQCAtMTY0LDYgKzE2NiwxMCBAQCBzdGF0aWMgY2hhciAqcHJlcGFyZV9p
bmRleChjb25zdCBjaGFyICoqZmlsZXMsIGNvbnN0IGNoYXIgKnByZWZpeCkKIAlzdHJ1Y3QgcGF0
aF9saXN0IHBhcnRpYWw7CiAJY29uc3QgY2hhciAqKnBhdGhzcGVjID0gTlVMTDsKIAorCWlmIChj
YWNoZWRfb25seSkgeworCQljb21taXRfc3R5bGUgPSBDT01NSVRfQVNfSVM7CisJCXJldHVybiBn
ZXRfaW5kZXhfZmlsZSgpOworCX0KIAlpZiAoaW50ZXJhY3RpdmUpIHsKIAkJaW50ZXJhY3RpdmVf
YWRkKCk7CiAJCWNvbW1pdF9zdHlsZSA9IENPTU1JVF9BU19JUzsKQEAgLTI4Nyw2ICsyOTMsNyBA
QCBzdGF0aWMgaW50IHJ1bl9zdGF0dXMoRklMRSAqZnAsIGNvbnN0IGNoYXIgKmluZGV4X2ZpbGUs
IGNvbnN0IGNoYXIgKnByZWZpeCkKIAl9CiAJcy52ZXJib3NlID0gdmVyYm9zZTsKIAlzLnVudHJh
Y2tlZCA9IHVudHJhY2tlZF9maWxlczsKKwlzLmNhY2hlZF9vbmx5ID0gY2FjaGVkX29ubHk7CiAJ
cy5pbmRleF9maWxlID0gaW5kZXhfZmlsZTsKIAlzLmZwID0gZnA7CiAKQEAgLTU1MCw2ICs1NTcs
OCBAQCBzdGF0aWMgaW50IHBhcnNlX2FuZF92YWxpZGF0ZV9vcHRpb25zKGludCBhcmdjLCBjb25z
dCBjaGFyICphcmd2W10pCiAJCQlmcmVlKGVuYyk7CiAJfQogCisJaWYgKGFsbCkKKwkJY2FjaGVk
X29ubHkgPSAwOwogCWlmICghIWFsc28gKyAhIW9ubHkgKyAhIWFsbCArICEhaW50ZXJhY3RpdmUg
PiAxKQogCQlkaWUoIk9ubHkgb25lIG9mIC0taW5jbHVkZS8tLW9ubHkvLS1hbGwvLS1pbnRlcmFj
dGl2ZSBjYW4gYmUgdXNlZC4iKTsKIAlpZiAoYXJnYyA9PSAwICYmIChhbHNvIHx8IChvbmx5ICYm
ICFhbWVuZCkpKQpAQCAtNTYwLDExICs1NjksMTIgQEAgc3RhdGljIGludCBwYXJzZV9hbmRfdmFs
aWRhdGVfb3B0aW9ucyhpbnQgYXJnYywgY29uc3QgY2hhciAqYXJndltdKQogCQlvbmx5X2luY2x1
ZGVfYXNzdW1lZCA9ICJFeHBsaWNpdCBwYXRocyBzcGVjaWZpZWQgd2l0aG91dCAtaSBub3IgLW87
IGFzc3VtaW5nIC0tb25seSBwYXRocy4uLiI7CiAJCWFsc28gPSAwOwogCX0KLQogCWlmIChhbGwg
JiYgYXJnYyA+IDApCiAJCWRpZSgiUGF0aHMgd2l0aCAtYSBkb2VzIG5vdCBtYWtlIHNlbnNlLiIp
OwogCWVsc2UgaWYgKGludGVyYWN0aXZlICYmIGFyZ2MgPiAwKQogCQlkaWUoIlBhdGhzIHdpdGgg
LS1pbnRlcmFjdGl2ZSBkb2VzIG5vdCBtYWtlIHNlbnNlLiIpOworCWVsc2UgaWYgKGNhY2hlZF9v
bmx5ICYmIGFyZ2MgPiAwKQorCQlkaWUoIlBhdGhzIHdpdGggLS1jYWNoZWQgZG9lcyBub3QgbWFr
ZSBzZW5zZS4iKTsKIAogCXJldHVybiBhcmdjOwogfQpAQCAtNjc4LDcgKzY4OCw4IEBAIGludCBj
bWRfY29tbWl0KGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4
KQogCX0KIAogCWlmICghcHJlcGFyZV9sb2dfbWVzc2FnZShpbmRleF9maWxlLCBwcmVmaXgpICYm
ICFpbl9tZXJnZSkgewotCQlydW5fc3RhdHVzKHN0ZG91dCwgaW5kZXhfZmlsZSwgcHJlZml4KTsK
KwkJaWYgKCFjYWNoZWRfb25seSkKKwkJCXJ1bl9zdGF0dXMoc3Rkb3V0LCBpbmRleF9maWxlLCBw
cmVmaXgpOwogCQlyb2xsYmFja19pbmRleF9maWxlcygpOwogCQl1bmxpbmsoY29tbWl0X2VkaXRt
c2cpOwogCQlyZXR1cm4gMTsKZGlmZiAtLWdpdCBhL3QvdDc1MDItY29tbWl0LnNoIGIvdC90NzUw
Mi1jb21taXQuc2gKaW5kZXggMjFhYzc4NS4uYmNmYWRkNyAxMDA3NTUKLS0tIGEvdC90NzUwMi1j
b21taXQuc2gKKysrIGIvdC90NzUwMi1jb21taXQuc2gKQEAgLTg5LDQgKzg5LDM0IEBAIHRlc3Rf
ZXhwZWN0X3N1Y2Nlc3MgJ3ZlcmJvc2UnICcKIAogJwogCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdj
YWNoZWQgb25seScgJworCisJZ2l0IHJlc2V0IC0taGFyZCAmJgorCWVjaG8gPmZpbGUxICYmCisJ
ZWNobyA+ZmlsZTIgJiYKKwlnaXQgYWRkIGZpbGUxIGZpbGUyICYmCisJZ2l0IGNvbW1pdCAtLWNh
Y2hlZCAtbWNhY2hlZDEKKworJworCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdjYWNoZWQgb25seSAo
aWdub3JlIHVuY2FjaGVkKScgJworCisJZ2l0IHJlc2V0IC0taGFyZCAmJgorCWVjaG8gZmlsZTEg
PmZpbGUxICYmCisJZWNobyBmaWxlMiA+ZmlsZTIgJiYKKwlnaXQgYWRkIGZpbGUxICYmCisJZ2l0
IHN0YXR1cyAtLWNhY2hlZCB8IGdyZXAgZmlsZTIKKwl0ZXN0ICQ/ICE9IDAKKworJworCit0ZXN0
X2V4cGVjdF9zdWNjZXNzICdkbyBub3QgY29tbWl0IGlmIGluZGV4IHVuY2hhbmdlZCcgJworCisJ
Z2l0IHJlc2V0IC0taGFyZCAmJgorCWVjaG8gY2hhbmdlID5maWxlMSAmJgorCWdpdCBjb21taXQg
LS1jYWNoZWQgLW1jYWNoZWQyCisJdGVzdCAkPyAhPSAwCisKKycKKwogdGVzdF9kb25lCmRpZmYg
LS1naXQgYS93dC1zdGF0dXMuYyBiL3d0LXN0YXR1cy5jCmluZGV4IDBlMDQzOWYuLjkzMDY0OTEg
MTAwNjQ0Ci0tLSBhL3d0LXN0YXR1cy5jCisrKyBiL3d0LXN0YXR1cy5jCkBAIC0zNjcsOCArMzY3
LDEwIEBAIHZvaWQgd3Rfc3RhdHVzX3ByaW50KHN0cnVjdCB3dF9zdGF0dXMgKnMpCiAJCXd0X3N0
YXR1c19wcmludF91cGRhdGVkKHMpOwogCX0KIAotCXd0X3N0YXR1c19wcmludF9jaGFuZ2VkKHMp
OwotCXd0X3N0YXR1c19wcmludF91bnRyYWNrZWQocyk7CisJaWYgKCFzLT5jYWNoZWRfb25seSkg
eworCQl3dF9zdGF0dXNfcHJpbnRfY2hhbmdlZChzKTsKKwkJd3Rfc3RhdHVzX3ByaW50X3VudHJh
Y2tlZChzKTsKKwl9CiAKIAlpZiAocy0+dmVyYm9zZSAmJiAhcy0+aXNfaW5pdGlhbCkKIAkJd3Rf
c3RhdHVzX3ByaW50X3ZlcmJvc2Uocyk7CmRpZmYgLS1naXQgYS93dC1zdGF0dXMuaCBiL3d0LXN0
YXR1cy5oCmluZGV4IDIyNWZiNGQuLmY1MGU3ODAgMTAwNjQ0Ci0tLSBhL3d0LXN0YXR1cy5oCisr
KyBiL3d0LXN0YXR1cy5oCkBAIC0xNyw2ICsxNyw3IEBAIHN0cnVjdCB3dF9zdGF0dXMgewogCWlu
dCB2ZXJib3NlOwogCWludCBhbWVuZDsKIAlpbnQgdW50cmFja2VkOworCWludCBjYWNoZWRfb25s
eTsKIAkvKiBUaGVzZSBhcmUgY29tcHV0ZWQgZHVyaW5nIHByb2Nlc3Npbmcgb2YgdGhlIGluZGl2
aWR1YWwgc2VjdGlvbnMgKi8KIAlpbnQgY29tbWl0YWJsZTsKIAlpbnQgd29ya2Rpcl9kaXJ0eTsK
LS0gCjEuNS4zLjYuMTAwOC5nYmFjY2YKCg==
------=_Part_873_9633877.1196160892718--
