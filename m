From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] t3703: skip more tests using colons in file names on Windows
Date: Tue, 7 Jun 2011 15:43:55 +0200
Message-ID: <BANLkTik3K2GVZ5rzegYSXRrvROU_bzBdVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6dbe82589293504a51f6a39
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTwa3-0007N8-Rj
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 15:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab1FGNoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 09:44:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39965 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab1FGNoS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 09:44:18 -0400
Received: by bwz15 with SMTP id 15so4187628bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=BPb08f9PWBXKJymHyWThSkOamC6Y0plimYBCk5c2rko=;
        b=MAC56GZwEmTgKmcuXHY54iMJROfGsDR9+nR1bddrWcd+6xQOGNqfwuRZH0rGFpN+J8
         hvifB8T1yva3UhZ+cf1V9ZukHalpBAxhXE8nPYRAbjmIQnyHnGDmeQd7aINbUaGtgo0t
         PceKxtWl1cvest4RgyvlsNlEwAalD5Dz1a2GA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=d5XarEtRoDsA2L8OVzmu3rIkPUnaDLSzCAf8Klyar1SvIiTBv84BiQ8Lb6S3fBaBei
         wW/9Kdij92Xu1omI/+8AvoTJbVLtRDCMCgyKf/X00vvFHBR9YpGNAv1RsDJthCkl1vVk
         o0GPYlq7W3RC3XX7tIzZfZbeyDKWfW1zcynSs=
Received: by 10.204.83.129 with SMTP id f1mr6470467bkl.29.1307454256785; Tue,
 07 Jun 2011 06:44:16 -0700 (PDT)
Received: by 10.204.62.9 with HTTP; Tue, 7 Jun 2011 06:43:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175204>

--0016e6dbe82589293504a51f6a39
Content-Type: text/plain; charset=UTF-8

Use the same test and prerequisite as introduced in similar
fix in 650af7ae8bdf92bd92df2.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Why didn't Johannes noticed it, I wonder. The failing test was
here all the time.

OTOH, I update my Windows repo very irregularly lately, may be
it is the same with Johannes. Windows is just not very friendly
development environment (more of a breaking environment).

 t/t3703-add-magic-pathspec.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
index e508246..5115de7 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -38,17 +38,17 @@ cat >expected <<EOF
 add 'sub/foo'
 EOF

-test_expect_success 'a file with the same (long) magic name exists' '
-	: >":(icase)ha" &&
-	test_must_fail git add -n ":(icase)ha" &&
-	git add -n "./:(icase)ha"
-'
-
 if mkdir ":" 2>/dev/null
 then
 	test_set_prereq COLON_DIR
 fi

+test_expect_success COLON_DIR 'a file with the same (long) magic name exists' '
+	: >":(icase)ha" &&
+	test_must_fail git add -n ":(icase)ha" &&
+	git add -n "./:(icase)ha"
+'
+
 test_expect_success COLON_DIR 'a file with the same (short) magic
name exists' '
 	: >":/bar" &&
 	test_must_fail git add -n :/bar &&
-- 
1.7.5.1.407.g53f4f

--0016e6dbe82589293504a51f6a39
Content-Type: application/octet-stream; 
	name="0001-t3703-skip-more-tests-using-colons-in-file-names-on-W.diff"
Content-Disposition: attachment; 
	filename="0001-t3703-skip-more-tests-using-colons-in-file-names-on-W.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gomwc5sz0

RnJvbSBiY2EzZmE3ZGYzMGI5NDY4NDFiZDA1ZDZjZTdhYWMyMzk3MjFjMDk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDcgSnVuIDIwMTEgMTE6NDk6NDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSB0MzcwMzog
c2tpcCBtb3JlIHRlc3RzIHVzaW5nIGNvbG9ucyBpbiBmaWxlIG5hbWVzIG9uIFdpbmRvd3MKClVz
ZSB0aGUgc2FtZSB0ZXN0IGFuZCBwcmVyZXF1aXNpdGUgYXMgaW50cm9kdWNlZCBpbiBzaW1pbGFy
CmZpeCBpbiA2NTBhZjdhZThiZGY5MmJkOTJkZjIuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNl
biA8cmFhLmxrbWxAZ21haWwuY29tPgotLS0KIHQvdDM3MDMtYWRkLW1hZ2ljLXBhdGhzcGVjLnNo
IHwgICAxMiArKysrKystLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3QvdDM3MDMtYWRkLW1hZ2ljLXBhdGhzcGVjLnNo
IGIvdC90MzcwMy1hZGQtbWFnaWMtcGF0aHNwZWMuc2gKaW5kZXggZTUwODI0Ni4uNTExNWRlNyAx
MDA3NTUKLS0tIGEvdC90MzcwMy1hZGQtbWFnaWMtcGF0aHNwZWMuc2gKKysrIGIvdC90MzcwMy1h
ZGQtbWFnaWMtcGF0aHNwZWMuc2gKQEAgLTM4LDE3ICszOCwxNyBAQCBjYXQgPmV4cGVjdGVkIDw8
RU9GCiBhZGQgJ3N1Yi9mb28nCiBFT0YKIAotdGVzdF9leHBlY3Rfc3VjY2VzcyAnYSBmaWxlIHdp
dGggdGhlIHNhbWUgKGxvbmcpIG1hZ2ljIG5hbWUgZXhpc3RzJyAnCi0JOiA+IjooaWNhc2UpaGEi
ICYmCi0JdGVzdF9tdXN0X2ZhaWwgZ2l0IGFkZCAtbiAiOihpY2FzZSloYSIgJiYKLQlnaXQgYWRk
IC1uICIuLzooaWNhc2UpaGEiCi0nCi0KIGlmIG1rZGlyICI6IiAyPi9kZXYvbnVsbAogdGhlbgog
CXRlc3Rfc2V0X3ByZXJlcSBDT0xPTl9ESVIKIGZpCiAKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgQ09M
T05fRElSICdhIGZpbGUgd2l0aCB0aGUgc2FtZSAobG9uZykgbWFnaWMgbmFtZSBleGlzdHMnICcK
Kwk6ID4iOihpY2FzZSloYSIgJiYKKwl0ZXN0X211c3RfZmFpbCBnaXQgYWRkIC1uICI6KGljYXNl
KWhhIiAmJgorCWdpdCBhZGQgLW4gIi4vOihpY2FzZSloYSIKKycKKwogdGVzdF9leHBlY3Rfc3Vj
Y2VzcyBDT0xPTl9ESVIgJ2EgZmlsZSB3aXRoIHRoZSBzYW1lIChzaG9ydCkgbWFnaWMgbmFtZSBl
eGlzdHMnICcKIAk6ID4iOi9iYXIiICYmCiAJdGVzdF9tdXN0X2ZhaWwgZ2l0IGFkZCAtbiA6L2Jh
ciAmJgotLSAKMS43LjUuMS40MDcuZzUzZjRmCgo=
--0016e6dbe82589293504a51f6a39--
