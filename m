From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/10] Fix annotate test script; notice when git-annotate fails.
Date: Wed, 2 Aug 2006 02:03:18 +0100
Message-ID: <00a601c6b5cf$712efb80$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00A7_01C6B5D7.D2F36380"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858e-0006xh-Jl
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWHBBDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWHBBC7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:02:59 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:35849 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750895AbWHBBC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:02:59 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858T-000C1I-Gl
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:02:58 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24622>

This is a multi-part message in MIME format.

------=_NextPart_000_00A7_01C6B5D7.D2F36380
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The t8001-annotate.sh test claimed all tests pass, when in fact
the git-annotate perl script failed to run! (prior to fixing the
script to work with perl 5.5).

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 t/annotate-tests.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 1148b02..077b4a5 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -4,7 +4,8 @@ # sourced from t8001-annotate.sh and t80
 check_count () {
 	head=
 	case "$1" in -h) head="$2"; shift; shift ;; esac
-	$PROG file $head | perl -e '
+	$PROG file $head >.result || return 1
+	cat .result | perl -e '
 		my %expect = (@ARGV);
 		my %count = ();
 		while (<STDIN>) {
-- 
1.4.1

------=_NextPart_000_00A7_01C6B5D7.D2F36380
Content-Type: text/plain;
	name="P0002.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0002.TXT"

RnJvbSBiMGM0MzgzYmY0OGQxMGJiZDUyMjliNTFhZDVkOTIzMDU2OGFkZDJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTYXQsIDI5IEp1bCAyMDA2IDE3OjIwOjQxICswMTAwClN1YmplY3Q6
IFtQQVRDSCAyLzEwXSBGaXggYW5ub3RhdGUgdGVzdCBzY3JpcHQ7IG5vdGljZSB3aGVuIGdpdC1h
bm5vdGF0ZSBmYWlscy4KClRoZSB0ODAwMS1hbm5vdGF0ZS5zaCB0ZXN0IGNsYWltZWQgYWxsIHRl
c3RzIHBhc3MsIHdoZW4gaW4gZmFjdAp0aGUgZ2l0LWFubm90YXRlIHBlcmwgc2NyaXB0IGZhaWxl
ZCB0byBydW4hIChwcmlvciB0byBmaXhpbmcgdGhlCnNjcmlwdCB0byB3b3JrIHdpdGggcGVybCA1
LjUpLgoKU2lnbmVkLW9mZi1ieTogUmFtc2F5IEFsbGFuIEpvbmVzIDxyYW1zYXlAcmFtc2F5MS5k
ZW1vbi5jby51az4KLS0tCiB0L2Fubm90YXRlLXRlc3RzLnNoIHwgICAgMyArKy0KIDEgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Qv
YW5ub3RhdGUtdGVzdHMuc2ggYi90L2Fubm90YXRlLXRlc3RzLnNoCmluZGV4IDExNDhiMDIuLjA3
N2I0YTUgMTAwNjQ0Ci0tLSBhL3QvYW5ub3RhdGUtdGVzdHMuc2gKKysrIGIvdC9hbm5vdGF0ZS10
ZXN0cy5zaApAQCAtNCw3ICs0LDggQEAgIyBzb3VyY2VkIGZyb20gdDgwMDEtYW5ub3RhdGUuc2gg
YW5kIHQ4MAogY2hlY2tfY291bnQgKCkgewogCWhlYWQ9CiAJY2FzZSAiJDEiIGluIC1oKSBoZWFk
PSIkMiI7IHNoaWZ0OyBzaGlmdCA7OyBlc2FjCi0JJFBST0cgZmlsZSAkaGVhZCB8IHBlcmwgLWUg
JworCSRQUk9HIGZpbGUgJGhlYWQgPi5yZXN1bHQgfHwgcmV0dXJuIDEKKwljYXQgLnJlc3VsdCB8
IHBlcmwgLWUgJwogCQlteSAlZXhwZWN0ID0gKEBBUkdWKTsKIAkJbXkgJWNvdW50ID0gKCk7CiAJ
CXdoaWxlICg8U1RESU4+KSB7Ci0tIAoxLjQuMQoK

------=_NextPart_000_00A7_01C6B5D7.D2F36380--
