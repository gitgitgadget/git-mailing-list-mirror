From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Allow fmt_ident to get an arbitrary buffer for the output
Date: Tue, 31 Jul 2007 19:16:14 +0200
Message-ID: <81b0412b0707311016p692611b8h28a2c62d776622f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_39632_3329234.1185902174372"
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 19:16:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFvKa-0001x3-0y
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 19:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760451AbXGaRQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 13:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759645AbXGaRQR
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 13:16:17 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:21853 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbXGaRQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 13:16:16 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1085013ika
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 10:16:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=qi8t2KMD46DvkTd8Z7VWKVwe3V4yIiGMe+IsyqQHYzc/8iLW7ozTtBwD/jBQvjAz+AIdzd1znE4G/vDI4TMen6jRY7YpdbGyMGGmZkOtWiXtduvlqVzIbaLxwMRrPF655x62iDZzVdqTbRoTk8GyK+e05/+i9gbVFqXQ3jWG5ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=uE3ZJyaqbUsSWylHJejDAx6UpDDGnCCLzcKC+hXe+KvWIeESfp6ArXDgx9cZ8fs0EG226UbFCOZ4tzL0hqvRPJXLZjGdVuHB/zqcI51NdzjrS0CNNa/2h9plNT3ZfaeQhrQV5eFClO9VFRYzoGjasFotqlgD29VJrqgext4n/oQ=
Received: by 10.78.138.14 with SMTP id l14mr1863683hud.1185902174412;
        Tue, 31 Jul 2007 10:16:14 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Tue, 31 Jul 2007 10:16:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54365>

------=_Part_39632_3329234.1185902174372
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-blame.c |    5 +++--
 cache.h         |    8 +++++++-
 ident.c         |   47 +++++++++++++++++++++--------------------------
 3 files changed, 31 insertions(+), 29 deletions(-)

On 7/31/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Ach, that's why... Junio, how about this then? I'd even suggest adding
> the buffer argument to fmt_ident and use it everywhere (ATM there is
> only one user outside of ident.c: builtin-blame.c).

Something like this (on top of the previous re git_author|committer_info)

------=_Part_39632_3329234.1185902174372
Content-Type: text/plain; 
	name=0002-Allow-fmt_ident-to-get-an-arbitrary-buffer-for-the-out.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4snjb3h
Content-Disposition: attachment; filename="0002-Allow-fmt_ident-to-get-an-arbitrary-buffer-for-the-out.txt"

RnJvbSBmZDcyOGFjYzk2ZWMzNWUzNmIwYTgyMzNjOWY5YzJmMGViNzhmZDFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDMxIEp1bCAyMDA3IDE5OjEzOjA2ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQWxsb3cg
Zm10X2lkZW50IHRvIGdldCBhbiBhcmJpdHJhcnkgYnVmZmVyIGZvciB0aGUgb3V0cHV0CgoKU2ln
bmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBidWlsdGlu
LWJsYW1lLmMgfCAgICA1ICsrKy0tCiBjYWNoZS5oICAgICAgICAgfCAgICA4ICsrKysrKystCiBp
ZGVudC5jICAgICAgICAgfCAgIDQ3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDI5IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4tYmxhbWUuYyBiL2J1aWx0aW4tYmxhbWUuYwpp
bmRleCAwNTE5MzM5Li4yZDVlMzVkIDEwMDY0NAotLS0gYS9idWlsdGluLWJsYW1lLmMKKysrIGIv
YnVpbHRpbi1ibGFtZS5jCkBAIC0xOTk1LDcgKzE5OTUsNyBAQCBzdGF0aWMgc3RydWN0IGNvbW1p
dCAqZmFrZV93b3JraW5nX3RyZWVfY29tbWl0KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIg
KmNvbgogCXN0cnVjdCBvcmlnaW4gKm9yaWdpbjsKIAl1bnNpZ25lZCBjaGFyIGhlYWRfc2hhMVsy
MF07CiAJY2hhciAqYnVmOwotCWNvbnN0IGNoYXIgKmlkZW50OworCWNoYXIgaWRlbnRbRk1UX0lE
RU5UX0JVRlNJWkVdOwogCWludCBmZDsKIAl0aW1lX3Qgbm93OwogCXVuc2lnbmVkIGxvbmcgZmlu
X3NpemU7CkBAIC0yMTA4LDcgKzIxMDgsOCBAQCBzdGF0aWMgc3RydWN0IGNvbW1pdCAqZmFrZV93
b3JraW5nX3RyZWVfY29tbWl0KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKmNvbgogCWNh
Y2hlX3RyZWVfaW52YWxpZGF0ZV9wYXRoKGFjdGl2ZV9jYWNoZV90cmVlLCBwYXRoKTsKIAogCWNv
bW1pdC0+YnVmZmVyID0geG1hbGxvYyg0MDApOwotCWlkZW50ID0gZm10X2lkZW50KCJOb3QgQ29t
bWl0dGVkIFlldCIsICJub3QuY29tbWl0dGVkLnlldCIsIE5VTEwsIDApOworCWZtdF9pZGVudChp
ZGVudCwgc2l6ZW9mKGlkZW50KSwKKwkJICAiTm90IENvbW1pdHRlZCBZZXQiLCAibm90LmNvbW1p
dHRlZC55ZXQiLCBOVUxMLCAwKTsKIAlzbnByaW50Zihjb21taXQtPmJ1ZmZlciwgNDAwLAogCQki
dHJlZSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXG4iCiAJCSJwYXJl
bnQgJXNcbiIKZGlmZiAtLWdpdCBhL2NhY2hlLmggYi9jYWNoZS5oCmluZGV4IDUzODAxYjguLmQ3
YjJlZjYgMTAwNjQ0Ci0tLSBhL2NhY2hlLmgKKysrIGIvY2FjaGUuaApAQCAtNDI1LDcgKzQyNSwx
MyBAQCB1bnNpZ25lZCBsb25nIGFwcHJveGlkYXRlKGNvbnN0IGNoYXIgKik7CiAKIGV4dGVybiBj
b25zdCBjaGFyICpnaXRfYXV0aG9yX2luZm8oaW50KTsKIGV4dGVybiBjb25zdCBjaGFyICpnaXRf
Y29tbWl0dGVyX2luZm8oaW50KTsKLWV4dGVybiBjb25zdCBjaGFyICpmbXRfaWRlbnQoY29uc3Qg
Y2hhciAqbmFtZSwgY29uc3QgY2hhciAqZW1haWwsIGNvbnN0IGNoYXIgKmRhdGVfc3RyLCBpbnQp
OworI2RlZmluZSBGTVRfSURFTlRfQlVGU0laRSAxMDAwCitleHRlcm4gY2hhciAqZm10X2lkZW50
KGNoYXIgKmJ1ZmZlciwKKwkJICAgICAgIGludCBidWZzaXplLAorCQkgICAgICAgY29uc3QgY2hh
ciAqbmFtZSwKKwkJICAgICAgIGNvbnN0IGNoYXIgKmVtYWlsLAorCQkgICAgICAgY29uc3QgY2hh
ciAqZGF0ZV9zdHIsCisJCSAgICAgICBpbnQgZXJyb3Jfb25fbm9fbmFtZSk7CiAKIHN0cnVjdCBj
aGVja291dCB7CiAJY29uc3QgY2hhciAqYmFzZV9kaXI7CmRpZmYgLS1naXQgYS9pZGVudC5jIGIv
aWRlbnQuYwppbmRleCAwZDU5MDkwLi5hMjlkMjE3IDEwMDY0NAotLS0gYS9pZGVudC5jCisrKyBi
L2lkZW50LmMKQEAgLTE5Miw5ICsxOTIsOSBAQCBzdGF0aWMgY29uc3QgY2hhciAqZW52X2hpbnQg
PQogIkFkZCAtLWdsb2JhbCB0byBzZXQgeW91ciBhY2NvdW50XCdzIGRlZmF1bHRcbiIKICJcbiI7
CiAKLSNkZWZpbmUgRk1UX0lERU5UX0JVRlNJWkUgMTAwMAotc3RhdGljIGNoYXIgKmZtdF9pZGVu
dF9idWYoY2hhciAqYnVmZmVyLCBjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICplbWFpbCwK
LQkJCSAgIGNvbnN0IGNoYXIgKmRhdGVfc3RyLCBpbnQgZXJyb3Jfb25fbm9fbmFtZSkKK2NoYXIg
KmZtdF9pZGVudChjaGFyICpidWZmZXIsIGludCBzaXplLAorCQljb25zdCBjaGFyICpuYW1lLCBj
b25zdCBjaGFyICplbWFpbCwKKwkJY29uc3QgY2hhciAqZGF0ZV9zdHIsIGludCBlcnJvcl9vbl9u
b19uYW1lKQogewogCWNoYXIgZGF0ZVs1MF07CiAJaW50IGk7CkBAIC0yMjcsMzQgKzIyNywyOCBA
QCBzdGF0aWMgY2hhciAqZm10X2lkZW50X2J1ZihjaGFyICpidWZmZXIsIGNvbnN0IGNoYXIgKm5h
bWUsIGNvbnN0IGNoYXIgKmVtYWlsLAogCWlmIChkYXRlX3N0cikKIAkJcGFyc2VfZGF0ZShkYXRl
X3N0ciwgZGF0ZSwgc2l6ZW9mKGRhdGUpKTsKIAotCWkgPSBjb3B5KGJ1ZmZlciwgRk1UX0lERU5U
X0JVRlNJWkUsIDAsIG5hbWUpOwotCWkgPSBhZGRfcmF3KGJ1ZmZlciwgRk1UX0lERU5UX0JVRlNJ
WkUsIGksICIgPCIpOwotCWkgPSBjb3B5KGJ1ZmZlciwgRk1UX0lERU5UX0JVRlNJWkUsIGksIGVt
YWlsKTsKLQlpID0gYWRkX3JhdyhidWZmZXIsIEZNVF9JREVOVF9CVUZTSVpFLCBpLCAiPiAiKTsK
LQlpID0gY29weShidWZmZXIsIEZNVF9JREVOVF9CVUZTSVpFLCBpLCBkYXRlKTsKLQlpZiAoaSA+
PSBGTVRfSURFTlRfQlVGU0laRSkKKwlpID0gY29weShidWZmZXIsIHNpemUsIDAsIG5hbWUpOwor
CWkgPSBhZGRfcmF3KGJ1ZmZlciwgc2l6ZSwgaSwgIiA8Iik7CisJaSA9IGNvcHkoYnVmZmVyLCBz
aXplLCBpLCBlbWFpbCk7CisJaSA9IGFkZF9yYXcoYnVmZmVyLCBzaXplLCBpLCAiPiAiKTsKKwlp
ID0gY29weShidWZmZXIsIHNpemUsIGksIGRhdGUpOworCWlmIChpID49IHNpemUpCiAJCWRpZSgi
SW1wb3NzaWJseSBsb25nIHBlcnNvbmFsIGlkZW50aWZpZXIiKTsKIAlidWZmZXJbaV0gPSAwOwog
CXJldHVybiBidWZmZXI7CiB9CiAKLWNvbnN0IGNoYXIgKmZtdF9pZGVudChjb25zdCBjaGFyICpu
YW1lLCBjb25zdCBjaGFyICplbWFpbCwKLQkJICAgICAgY29uc3QgY2hhciAqZGF0ZV9zdHIsIGlu
dCBlcnJvcl9vbl9ub19uYW1lKQotewotCXN0YXRpYyBjaGFyIGJ1ZmZlcltGTVRfSURFTlRfQlVG
U0laRV07Ci0JcmV0dXJuIGZtdF9pZGVudF9idWYoYnVmZmVyLCBuYW1lLCBlbWFpbCwgZGF0ZV9z
dHIsIGVycm9yX29uX25vX25hbWUpOwotfQotCiBjb25zdCBjaGFyICpnaXRfYXV0aG9yX2luZm8o
aW50IGVycm9yX29uX25vX25hbWUpCiB7CiAJc3RhdGljIGNoYXIgKmJ1ZmZlcjsKIAlpZiAoIWJ1
ZmZlcikKIAkJYnVmZmVyID0geG1hbGxvYyhGTVRfSURFTlRfQlVGU0laRSk7Ci0JcmV0dXJuIGZt
dF9pZGVudF9idWYoYnVmZmVyLAotCQkJICAgICBnZXRlbnYoIkdJVF9BVVRIT1JfTkFNRSIpLAot
CQkJICAgICBnZXRlbnYoIkdJVF9BVVRIT1JfRU1BSUwiKSwKLQkJCSAgICAgZ2V0ZW52KCJHSVRf
QVVUSE9SX0RBVEUiKSwKLQkJCSAgICAgZXJyb3Jfb25fbm9fbmFtZSk7CisJcmV0dXJuIGZtdF9p
ZGVudChidWZmZXIsCisJCQkgRk1UX0lERU5UX0JVRlNJWkUsCisJCQkgZ2V0ZW52KCJHSVRfQVVU
SE9SX05BTUUiKSwKKwkJCSBnZXRlbnYoIkdJVF9BVVRIT1JfRU1BSUwiKSwKKwkJCSBnZXRlbnYo
IkdJVF9BVVRIT1JfREFURSIpLAorCQkJIGVycm9yX29uX25vX25hbWUpOwogfQogCiBjb25zdCBj
aGFyICpnaXRfY29tbWl0dGVyX2luZm8oaW50IGVycm9yX29uX25vX25hbWUpCkBAIC0yNjIsOSAr
MjU2LDEwIEBAIGNvbnN0IGNoYXIgKmdpdF9jb21taXR0ZXJfaW5mbyhpbnQgZXJyb3Jfb25fbm9f
bmFtZSkKIAlzdGF0aWMgY2hhciAqYnVmZmVyOwogCWlmICghYnVmZmVyKQogCQlidWZmZXIgPSB4
bWFsbG9jKEZNVF9JREVOVF9CVUZTSVpFKTsKLQlyZXR1cm4gZm10X2lkZW50X2J1ZihidWZmZXIs
Ci0JCQkgICAgIGdldGVudigiR0lUX0NPTU1JVFRFUl9OQU1FIiksCi0JCQkgICAgIGdldGVudigi
R0lUX0NPTU1JVFRFUl9FTUFJTCIpLAotCQkJICAgICBnZXRlbnYoIkdJVF9DT01NSVRURVJfREFU
RSIpLAotCQkJICAgICBlcnJvcl9vbl9ub19uYW1lKTsKKwlyZXR1cm4gZm10X2lkZW50KGJ1ZmZl
ciwKKwkJCSBGTVRfSURFTlRfQlVGU0laRSwKKwkJCSBnZXRlbnYoIkdJVF9DT01NSVRURVJfTkFN
RSIpLAorCQkJIGdldGVudigiR0lUX0NPTU1JVFRFUl9FTUFJTCIpLAorCQkJIGdldGVudigiR0lU
X0NPTU1JVFRFUl9EQVRFIiksCisJCQkgZXJyb3Jfb25fbm9fbmFtZSk7CiB9Ci0tIAoxLjUuMy5y
YzMuMTMyLmczOTE3OQoK
------=_Part_39632_3329234.1185902174372--
