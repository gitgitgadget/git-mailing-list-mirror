From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 8/10] Fix some minor warnings to allow -Werror.
Date: Wed, 2 Aug 2006 02:03:42 +0100
Message-ID: <00be01c6b5cf$7f7e9e20$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00BF_01C6B5D7.E1430620"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858y-00071U-Vk
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWHBBDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWHBBDY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:24 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:56073 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750908AbWHBBDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:23 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858r-000C1I-Gp
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:22 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24626>

This is a multi-part message in MIME format.

------=_NextPart_000_00BF_01C6B5D7.E1430620
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-mailinfo.c |    3 ++-
 diff.c             |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 3e40747..bb5e7b7 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -531,7 +531,8 @@ static int decode_b_segment(char *in, ch
 static void convert_to_utf8(char *line, char *charset)
 {
 #ifndef NO_ICONV
-	char *in, *out;
+	const char *in;
+	char *out;
 	size_t insize, outsize, nrc;
 	char outbuf[4096]; /* cheat */
 	static char latin_one[] = "latin1";
diff --git a/diff.c b/diff.c
index 5a71489..81630c0 100644
--- a/diff.c
+++ b/diff.c
@@ -614,6 +614,7 @@ static void emit_binary_diff(mmfile_t *o
 	 * whichever is smaller.
 	 */
 	delta = NULL;
+	orig_size = 0;
 	deflated = deflate_it(two->ptr, two->size, &deflate_size);
 	if (one->size && two->size) {
 		delta = diff_delta(one->ptr, one->size,
-- 
1.4.1

------=_NextPart_000_00BF_01C6B5D7.E1430620
Content-Type: text/plain;
	name="P0008.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0008.TXT"

RnJvbSAyNjJiNTc5MTdmZjAxZjc0Yzk1NjcwYWU1OWYxY2Q1OWE5MDI0MTM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTdW4sIDMwIEp1bCAyMDA2IDE3OjA2OjI1ICswMTAwClN1YmplY3Q6
IFtQQVRDSCA4LzEwXSBGaXggc29tZSBtaW5vciB3YXJuaW5ncyB0byBhbGxvdyAtV2Vycm9yLgoK
U2lnbmVkLW9mZi1ieTogUmFtc2F5IEFsbGFuIEpvbmVzIDxyYW1zYXlAcmFtc2F5MS5kZW1vbi5j
by51az4KLS0tCiBidWlsdGluLW1haWxpbmZvLmMgfCAgICAzICsrLQogZGlmZi5jICAgICAgICAg
ICAgIHwgICAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9idWlsdGluLW1haWxpbmZvLmMgYi9idWlsdGluLW1haWxpbmZv
LmMKaW5kZXggM2U0MDc0Ny4uYmI1ZTdiNyAxMDA2NDQKLS0tIGEvYnVpbHRpbi1tYWlsaW5mby5j
CisrKyBiL2J1aWx0aW4tbWFpbGluZm8uYwpAQCAtNTMxLDcgKzUzMSw4IEBAIHN0YXRpYyBpbnQg
ZGVjb2RlX2Jfc2VnbWVudChjaGFyICppbiwgY2gKIHN0YXRpYyB2b2lkIGNvbnZlcnRfdG9fdXRm
OChjaGFyICpsaW5lLCBjaGFyICpjaGFyc2V0KQogewogI2lmbmRlZiBOT19JQ09OVgotCWNoYXIg
KmluLCAqb3V0OworCWNvbnN0IGNoYXIgKmluOworCWNoYXIgKm91dDsKIAlzaXplX3QgaW5zaXpl
LCBvdXRzaXplLCBucmM7CiAJY2hhciBvdXRidWZbNDA5Nl07IC8qIGNoZWF0ICovCiAJc3RhdGlj
IGNoYXIgbGF0aW5fb25lW10gPSAibGF0aW4xIjsKZGlmZiAtLWdpdCBhL2RpZmYuYyBiL2RpZmYu
YwppbmRleCA1YTcxNDg5Li44MTYzMGMwIDEwMDY0NAotLS0gYS9kaWZmLmMKKysrIGIvZGlmZi5j
CkBAIC02MTQsNiArNjE0LDcgQEAgc3RhdGljIHZvaWQgZW1pdF9iaW5hcnlfZGlmZihtbWZpbGVf
dCAqbwogCSAqIHdoaWNoZXZlciBpcyBzbWFsbGVyLgogCSAqLwogCWRlbHRhID0gTlVMTDsKKwlv
cmlnX3NpemUgPSAwOwogCWRlZmxhdGVkID0gZGVmbGF0ZV9pdCh0d28tPnB0ciwgdHdvLT5zaXpl
LCAmZGVmbGF0ZV9zaXplKTsKIAlpZiAob25lLT5zaXplICYmIHR3by0+c2l6ZSkgewogCQlkZWx0
YSA9IGRpZmZfZGVsdGEob25lLT5wdHIsIG9uZS0+c2l6ZSwKLS0gCjEuNC4xCgo=

------=_NextPart_000_00BF_01C6B5D7.E1430620--
