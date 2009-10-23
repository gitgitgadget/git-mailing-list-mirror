From: =?ISO-8859-1?Q?Kevyn=2DAlexandre_Par=E9?= 
	<kevyn.alexandre.pare@gmail.com>
Subject: Re: Write and Submit Your First Kernel Patch
Date: Fri, 23 Oct 2009 16:30:25 -0400
Message-ID: <dc1d0f40910231330n7cc521d0n52aac929c334bc9d@mail.gmail.com>
References: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
	 <7v8wf1c2h9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636d33c7cfaf8cb0476a014b5
Cc: linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-newbie-owner@vger.kernel.org Fri Oct 23 22:30:36 2009
Return-path: <linux-newbie-owner@vger.kernel.org>
Envelope-to: lnx-linux-newbie@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QmS-0005Ad-0W
	for lnx-linux-newbie@lo.gmane.org; Fri, 23 Oct 2009 22:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbZJWUaY (ORCPT <rfc822;lnx-linux-newbie@m.gmane.org>);
	Fri, 23 Oct 2009 16:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZJWUaX
	(ORCPT <rfc822;linux-newbie-outgoing>);
	Fri, 23 Oct 2009 16:30:23 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:63315 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZJWUaV (ORCPT
	<rfc822;linux-newbie@vger.kernel.org>);
	Fri, 23 Oct 2009 16:30:21 -0400
Received: by iwn10 with SMTP id 10so4898010iwn.4
        for <multiple recipients>; Fri, 23 Oct 2009 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JCiHkOkcuUgrh3/fdlcVfWkC6pri9UbDNEN1AU3T8Ok=;
        b=rR16Rp1/LgkQ8sHtqUQKtu0ai51TY2XqcQrfT4gQunWqzVpEmf/D+a6UGbSQFuMFSU
         ZElELl7IcdG99ppcMOZGAZiDwM8LOZkwLWT7XBq+O+3wPt9JZqlMjkqkndta4uGdJ2Kw
         G1uyWBJHpu8WxuBqHdGWBjwT6POt7LqOJgeXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PznB753ZS7YOnW8pBapaft0XnQMn1Bj2/Cqp8P7EgJXaxGgJ5m8rbylve9nWX6B+Rv
         f7Gu0uxIoePmMKC26nzXfREle1jOy7SsHuvxhHG2zoX3tyyjsi6VEwE7cSrbGmUiFX7I
         SGkxm3Em1GE+R8iQFI7nVGF60Ljc1oZ2exLBE=
Received: by 10.231.153.69 with SMTP id j5mr128251ibw.40.1256329825678; Fri, 
	23 Oct 2009 13:30:25 -0700 (PDT)
In-Reply-To: <7v8wf1c2h9.fsf@alter.siamese.dyndns.org>
Sender: linux-newbie-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-newbie.vger.kernel.org>
X-Mailing-List: linux-newbie@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131129>

--001636d33c7cfaf8cb0476a014b5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thx junio for that analyse!

So what I understand from what you have said is that the problem is
not in format-patch since that I see white space from git show $commit
?!:

history: I was trying to remove coding style problem in
drivers/staging/comedi/drivers/pcl726.c

./scripts/checkpatch.pl --terse --file
drivers/staging/comedi/drivers/pcl726.c        #### NO warning after
removing problems
### git commit -a
                      # was done after that
### git format-patch -s -n master..pcl726

kapare@vostro:~/linux-kernel-patch/linux-2.6$ git show $commit >
TEST.git.show.commit      #### see whitespace in vim
kapare@vostro:~/linux-kernel-patch/linux-2.6$ ./scripts/checkpatch.pl
--terse --file TEST.git.show.commit
TEST:19: ERROR: trailing whitespace
TEST:27: ERROR: trailing whitespace
TEST:35: ERROR: trailing whitespace
TEST:45: ERROR: trailing whitespace
TEST:55: ERROR: trailing whitespace
TEST:60: ERROR: trailing whitespace
TEST:67: ERROR: trailing whitespace
TEST:69: ERROR: trailing whitespace
TEST:80: ERROR: trailing whitespace
TEST:106: ERROR: trailing whitespace
TEST:113: ERROR: trailing whitespace

So what am I doing wrong? Any clues? see attachment you ask

thx

kap

On Fri, Oct 23, 2009 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Kevyn-Alexandre Par=E9 =A0<kevyn.alexandre.pare@gmail.com> writes:
>
>> Just before I send my patch I got this error with:
>> ./scripts/checkpatch.pl --terse --file
>> 0001-Staging-comedi-driver-fix-coding-style.patch
>>
>> 0001-Staging-comedi-driver-fix-coding-style.patch:27: ERROR: trailing wh=
itespace
>> 0001-Staging-comedi-driver-fix-coding-style.patch:35: ERROR: trailing wh=
itespace
>> 0001-Staging-comedi-driver-fix-coding-style.patch:43: ERROR: trailing wh=
itespace
>> 0001-Staging-comedi-driver-fix-coding-style.patch:53: ERROR: trailing wh=
itespace
>>
>> I have done a step by step explanation of what I have done:
>> http://kapare.blogspot.com/2009/09/write-and-submit-your-first-kernel.ht=
ml
>>
>> It seem to me that the whitespace are added after I do this command:
>> git format-patch -s -n master..mybranch
>
> "The whitespace are added after..." sounds to me that what you committed
> were checkpatch compliant, and format-patch somehow broke it. =A0If that =
is
> the case we need to fix format-patch.
>
> Please check if "git show $commit" output for the commit that corresponds
> to the "[Staging] comedi driver: fix coding style" patch has trailing
> whitespaces. =A0That is what you committed.
>
> If there already is whitespace breakage in what you committed, then we do
> not have to blame format-patch and look for bugs in it to fix.
>
> Otherwise, please send 0001-*.patch (output from format-patch) and output
> from that "git show $commit" as separate attachments, so that we can debu=
g
> and fix format-patch.
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-newbie" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.linux-learn.org/faqs
>

--001636d33c7cfaf8cb0476a014b5
Content-Type: text/x-patch; charset=UTF-8; 
	name="0001-Staging-comedi-driver-fix-coding-style.patch"
Content-Disposition: attachment; 
	filename="0001-Staging-comedi-driver-fix-coding-style.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g15dl2uq0

RnJvbSAyMzEzMjcwMDY4NTgxZmY0MjUxNDBjMWYzNjFiMjZlZGQwOTY2NThmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/S2V2eW4tQWxleGFuZHJlPTIwUGFyPUMzPUE5
Pz0gPGtldnluLmFsZXhhbmRyZS5wYXJlQGdtYWlsLmNvbT4KRGF0ZTogRnJpLCAyMyBPY3QgMjAw
OSAwMDo1OTo0MCAtMDQwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBTdGFnaW5nOiBjb21lZGkgZHJp
dmVyOiBmaXggY29kaW5nIHN0eWxlCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD11dGYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgoK
U2lnbmVkLW9mZi1ieTogS2V2eW4tQWxleGFuZHJlIFBhcsOpIDxrZXZ5bi5hbGV4YW5kcmUucGFy
ZUBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9zdGFnaW5nL2NvbWVkaS9kcml2ZXJzL3BjbDcyNi5j
IHwgICA0MSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQs
IDIwIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3RhZ2luZy9jb21lZGkvZHJpdmVycy9wY2w3MjYuYyBiL2RyaXZlcnMvc3RhZ2luZy9jb21lZGkv
ZHJpdmVycy9wY2w3MjYuYwppbmRleCBjY2FkZDA5Li42MjA4YmNhIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3N0YWdpbmcvY29tZWRpL2RyaXZlcnMvcGNsNzI2LmMKKysrIGIvZHJpdmVycy9zdGFnaW5n
L2NvbWVkaS9kcml2ZXJzL3BjbDcyNi5jCkBAIC0zOSwyNyArMzksMjcgQEAgSW50ZXJydXB0cyBh
cmUgbm90IHN1cHBvcnRlZC4KICAgICBPcHRpb25zIGZvciBQQ0wtNzI2OgogICAgICBbMF0gLSBJ
TyBCYXNlCiAgICAgIFsyXS4uLls3XSAtIEQvQSBvdXRwdXQgcmFuZ2UgZm9yIGNoYW5uZWwgMS02
OgotICAgICAgICAgICAgICAgMDogMC01ViwgMTogMC0xMFYsIDI6ICsvLTVWLCAzOiArLy0xMFYs
Ci0JICAgICAgIDQ6IDQtMjBtQSwgNTogdW5rbm93biAoZXh0ZXJuYWwgcmVmZXJlbmNlKQorCQkw
OiAwLTVWLCAxOiAwLTEwViwgMjogKy8tNVYsIDM6ICsvLTEwViwKKwkJNDogNC0yMG1BLCA1OiB1
bmtub3duIChleHRlcm5hbCByZWZlcmVuY2UpCiAKICAgICBPcHRpb25zIGZvciBQQ0wtNzI3Ogog
ICAgICBbMF0gLSBJTyBCYXNlCiAgICAgIFsyXS4uLlsxM10gLSBEL0Egb3V0cHV0IHJhbmdlIGZv
ciBjaGFubmVsIDEtMTI6Ci0gICAgICAgICAgICAgICAwOiAwLTVWLCAxOiAwLTEwViwgMjogKy8t
NVYsCi0JICAgICAgIDM6IDQtMjBtQQorCQkwOiAwLTVWLCAxOiAwLTEwViwgMjogKy8tNVYsCisJ
CTM6IDQtMjBtQQogCiAgICAgT3B0aW9ucyBmb3IgUENMLTcyOCBhbmQgQUNMLTYxMjg6CiAgICAg
IFswXSAtIElPIEJhc2UKICAgICAgWzJdLCBbM10gLSBEL0Egb3V0cHV0IHJhbmdlIGZvciBjaGFu
bmVsIDEgYW5kIDI6Ci0gICAgICAgICAgICAgICAwOiAwLTVWLCAxOiAwLTEwViwgMjogKy8tNVYs
IDM6ICsvLTEwViwKLQkgICAgICAgNDogNC0yMG1BLCA1OiAwLTIwbUEKKwkJMDogMC01ViwgMTog
MC0xMFYsIDI6ICsvLTVWLCAzOiArLy0xMFYsCisJCTQ6IDQtMjBtQSwgNTogMC0yMG1BCiAKICAg
ICBPcHRpb25zIGZvciBBQ0wtNjEyNjoKICAgICAgWzBdIC0gSU8gQmFzZQogICAgICBbMV0gLSBJ
UlEgKDA9ZGlzYWJsZSwgMywgNSwgNiwgNywgOSwgMTAsIDExLCAxMiwgMTUpIChjdXJyZW50bHkg
aWdub3JlZCkKICAgICAgWzJdLi4uWzddIC0gRC9BIG91dHB1dCByYW5nZSBmb3IgY2hhbm5lbCAx
LTY6Ci0gICAgICAgICAgICAgICAwOiAwLTVWLCAxOiAwLTEwViwgMjogKy8tNVYsIDM6ICsvLTEw
ViwKLQkgICAgICAgNDogNC0yMG1BCisJCTA6IDAtNVYsIDE6IDAtMTBWLCAyOiArLy01ViwgMzog
Ky8tMTBWLAorCQk0OiA0LTIwbUEKICovCiAKIC8qCkBAIC0xMjcsNyArMTI3LDggQEAgc3RydWN0
IHBjbDcyNl9ib2FyZCB7CiAJaW50IGRpX2xvOwogCWludCBkb19oaTsKIAlpbnQgZG9fbG87Ci0J
Y29uc3Qgc3RydWN0IGNvbWVkaV9scmFuZ2UgKmNvbnN0ICpyYW5nZV90eXBlX2xpc3Q7CS8qICBs
aXN0IG9mIHN1cHBvcnRlZCByYW5nZXMgKi8KKwljb25zdCBzdHJ1Y3QgY29tZWRpX2xyYW5nZSAq
Y29uc3QgKnJhbmdlX3R5cGVfbGlzdDsKKwkvKiAgbGlzdCBvZiBzdXBwb3J0ZWQgcmFuZ2VzICov
CiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBjbDcyNl9ib2FyZCBib2FyZHR5cGVzW10gPSB7
CkBAIC0yMDQsOSArMjA1LDggQEAgc3RhdGljIGludCBwY2w3MjZfYW9faW5zbl9yZWFkKHN0cnVj
dCBjb21lZGlfZGV2aWNlICpkZXYsCiAJaW50IGNoYW4gPSBDUl9DSEFOKGluc24tPmNoYW5zcGVj
KTsKIAlpbnQgbjsKIAotCWZvciAobiA9IDA7IG4gPCBpbnNuLT5uOyBuKyspIHsKKwlmb3IgKG4g
PSAwOyBuIDwgaW5zbi0+bjsgbisrKQogCQlkYXRhW25dID0gZGV2cHJpdi0+YW9fcmVhZGJhY2tb
Y2hhbl07Ci0JfQogCXJldHVybiBuOwogfQogCkBAIC0yNTYsMTAgKzI1NiwxMCBAQCBzdGF0aWMg
aW50IHBjbDcyNl9hdHRhY2goc3RydWN0IGNvbWVkaV9kZXZpY2UgKmRldiwgc3RydWN0IGNvbWVk
aV9kZXZjb25maWcgKml0KQogCiAJaW9iYXNlID0gaXQtPm9wdGlvbnNbMF07CiAJaW9yYW5nZSA9
IHRoaXNfYm9hcmQtPmlvX3JhbmdlOwotCXByaW50aygiY29tZWRpJWQ6IHBjbDcyNjogYm9hcmQ9
JXMsIDB4JTAzbHggIiwgZGV2LT5taW5vciwKKwlwcmludGsoS0VSTl9XQVJOSU5HLCAiY29tZWRp
JWQ6IHBjbDcyNjogYm9hcmQ9JXMsIDB4JTAzbHggIiwgZGV2LT5taW5vciwKIAkgICAgICAgdGhp
c19ib2FyZC0+bmFtZSwgaW9iYXNlKTsKIAlpZiAoIXJlcXVlc3RfcmVnaW9uKGlvYmFzZSwgaW9y
YW5nZSwgInBjbDcyNiIpKSB7Ci0JCXByaW50aygiSS9PIHBvcnQgY29uZmxpY3RcbiIpOworCQlw
cmludGsoS0VSTl9XQVJOSU5HLCAiSS9PIHBvcnQgY29uZmxpY3RcbiIpOwogCQlyZXR1cm4gLUVJ
TzsKIAl9CiAKQEAgLTI4MywxNiArMjgzLDE2IEBAIHN0YXRpYyBpbnQgcGNsNzI2X2F0dGFjaChz
dHJ1Y3QgY29tZWRpX2RldmljZSAqZGV2LCBzdHJ1Y3QgY29tZWRpX2RldmNvbmZpZyAqaXQpCiAJ
CWRldnByaXYtPmZpcnN0X2NoYW4gPSAyOwogCQlpZiAoaXJxKSB7CS8qIHdlIHdhbnQgdG8gdXNl
IElSUSAqLwogCQkJaWYgKCgoMSA8PCBpcnEpICYgYm9hcmR0eXBlc1tib2FyZF0uSVJRYml0cykg
PT0gMCkgewotCQkJCXByaW50awotCQkJCSAgICAoIiwgSVJRICVkIGlzIG91dCBvZiBhbGxvd2Vk
IHJhbmdlLCBESVNBQkxJTkcgSVQiLAotCQkJCSAgICAgaXJxKTsKKwkJCQlwcmludGsoS0VSTl9X
QVJOSU5HLAorCQkJCQkiLCBJUlEgJWQgaXMgb3V0IG9mIGFsbG93ZWQgcmFuZ2UsIgorCQkJCQki
IERJU0FCTElORyBJVCIsIGlycSk7CiAJCQkJaXJxID0gMDsJLyogQmFkIElSUSAqLwogCQkJfSBl
bHNlIHsKIAkJCQlpZiAocmVxdWVzdF9pcnEoaXJxLCBpbnRlcnJ1cHRfcGNsODE4LCAwLAogCQkJ
CQkJInBjbDcyNiIsIGRldikpIHsKLQkJCQkJcHJpbnRrCi0JCQkJCSAgICAoIiwgdW5hYmxlIHRv
IGFsbG9jYXRlIElSUSAlZCwgRElTQUJMSU5HIElUIiwKLQkJCQkJICAgICBpcnEpOworCQkJCQlw
cmludGsoS0VSTl9XQVJOSU5HLAorCQkJCQkJIiwgdW5hYmxlIHRvIGFsbG9jYXRlIElSUSAlZCwi
CisJCQkJCQkiIERJU0FCTElORyBJVCIsIGlycSk7CiAJCQkJCWlycSA9IDA7CS8qIENhbid0IHVz
ZSBJUlEgKi8KIAkJCQl9IGVsc2UgewogCQkJCQlwcmludGsoIiwgaXJxPSVkIiwgaXJxKTsKQEAg
LTM3Miw5ICszNzIsOCBAQCBzdGF0aWMgaW50IHBjbDcyNl9kZXRhY2goc3RydWN0IGNvbWVkaV9k
ZXZpY2UgKmRldikKIC8qIHByaW50aygiY29tZWRpJWQ6IHBjbDcyNjogcmVtb3ZlXG4iLGRldi0+
bWlub3IpOyAqLwogCiAjaWZkZWYgQUNMNjEyNl9JUlEKLQlpZiAoZGV2LT5pcnEpIHsKKwlpZiAo
ZGV2LT5pcnEpCiAJCWZyZWVfaXJxKGRldi0+aXJxLCBkZXYpOwotCX0KICNlbmRpZgogCiAJaWYg
KGRldi0+aW9iYXNlKQotLSAKMS42LjAuNAoK
--001636d33c7cfaf8cb0476a014b5
Content-Type: application/octet-stream; name="TEST.git.show.commit"
Content-Disposition: attachment; filename="TEST.git.show.commit"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g15dlj451

Y29tbWl0IDIzMTMyNzAwNjg1ODFmZjQyNTE0MGMxZjM2MWIyNmVkZDA5NjY1OGYKQXV0aG9yOiBL
ZXZ5bi1BbGV4YW5kcmUgUGFyw6kgPGtldnluLmFsZXhhbmRyZS5wYXJlQGdtYWlsLmNvbT4KRGF0
ZTogICBGcmkgT2N0IDIzIDAwOjU5OjQwIDIwMDkgLTA0MDAKCiAgICBTdGFnaW5nOiBjb21lZGkg
ZHJpdmVyOiBmaXggY29kaW5nIHN0eWxlCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2Nv
bWVkaS9kcml2ZXJzL3BjbDcyNi5jIGIvZHJpdmVycy9zdGFnaW5nL2NvbWVkaS9kcml2ZXJzL3Bj
bDcyNi5jCmluZGV4IGNjYWRkMDkuLjYyMDhiY2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2lu
Zy9jb21lZGkvZHJpdmVycy9wY2w3MjYuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvY29tZWRpL2Ry
aXZlcnMvcGNsNzI2LmMKQEAgLTM5LDI3ICszOSwyNyBAQCBJbnRlcnJ1cHRzIGFyZSBub3Qgc3Vw
cG9ydGVkLgogICAgIE9wdGlvbnMgZm9yIFBDTC03MjY6CiAgICAgIFswXSAtIElPIEJhc2UKICAg
ICAgWzJdLi4uWzddIC0gRC9BIG91dHB1dCByYW5nZSBmb3IgY2hhbm5lbCAxLTY6Ci0gICAgICAg
ICAgICAgICAwOiAwLTVWLCAxOiAwLTEwViwgMjogKy8tNVYsIDM6ICsvLTEwViwKLQkgICAgICAg
NDogNC0yMG1BLCA1OiB1bmtub3duIChleHRlcm5hbCByZWZlcmVuY2UpCisJCTA6IDAtNVYsIDE6
IDAtMTBWLCAyOiArLy01ViwgMzogKy8tMTBWLAorCQk0OiA0LTIwbUEsIDU6IHVua25vd24gKGV4
dGVybmFsIHJlZmVyZW5jZSkKIAogICAgIE9wdGlvbnMgZm9yIFBDTC03Mjc6CiAgICAgIFswXSAt
IElPIEJhc2UKICAgICAgWzJdLi4uWzEzXSAtIEQvQSBvdXRwdXQgcmFuZ2UgZm9yIGNoYW5uZWwg
MS0xMjoKLSAgICAgICAgICAgICAgIDA6IDAtNVYsIDE6IDAtMTBWLCAyOiArLy01ViwKLQkgICAg
ICAgMzogNC0yMG1BCisJCTA6IDAtNVYsIDE6IDAtMTBWLCAyOiArLy01ViwKKwkJMzogNC0yMG1B
CiAKICAgICBPcHRpb25zIGZvciBQQ0wtNzI4IGFuZCBBQ0wtNjEyODoKICAgICAgWzBdIC0gSU8g
QmFzZQogICAgICBbMl0sIFszXSAtIEQvQSBvdXRwdXQgcmFuZ2UgZm9yIGNoYW5uZWwgMSBhbmQg
MjoKLSAgICAgICAgICAgICAgIDA6IDAtNVYsIDE6IDAtMTBWLCAyOiArLy01ViwgMzogKy8tMTBW
LAotCSAgICAgICA0OiA0LTIwbUEsIDU6IDAtMjBtQQorCQkwOiAwLTVWLCAxOiAwLTEwViwgMjog
Ky8tNVYsIDM6ICsvLTEwViwKKwkJNDogNC0yMG1BLCA1OiAwLTIwbUEKIAogICAgIE9wdGlvbnMg
Zm9yIEFDTC02MTI2OgogICAgICBbMF0gLSBJTyBCYXNlCiAgICAgIFsxXSAtIElSUSAoMD1kaXNh
YmxlLCAzLCA1LCA2LCA3LCA5LCAxMCwgMTEsIDEyLCAxNSkgKGN1cnJlbnRseSBpZ25vcmVkKQog
ICAgICBbMl0uLi5bN10gLSBEL0Egb3V0cHV0IHJhbmdlIGZvciBjaGFubmVsIDEtNjoKLSAgICAg
ICAgICAgICAgIDA6IDAtNVYsIDE6IDAtMTBWLCAyOiArLy01ViwgMzogKy8tMTBWLAotCSAgICAg
ICA0OiA0LTIwbUEKKwkJMDogMC01ViwgMTogMC0xMFYsIDI6ICsvLTVWLCAzOiArLy0xMFYsCisJ
CTQ6IDQtMjBtQQogKi8KIAogLyoKQEAgLTEyNyw3ICsxMjcsOCBAQCBzdHJ1Y3QgcGNsNzI2X2Jv
YXJkIHsKIAlpbnQgZGlfbG87CiAJaW50IGRvX2hpOwogCWludCBkb19sbzsKLQljb25zdCBzdHJ1
Y3QgY29tZWRpX2xyYW5nZSAqY29uc3QgKnJhbmdlX3R5cGVfbGlzdDsJLyogIGxpc3Qgb2Ygc3Vw
cG9ydGVkIHJhbmdlcyAqLworCWNvbnN0IHN0cnVjdCBjb21lZGlfbHJhbmdlICpjb25zdCAqcmFu
Z2VfdHlwZV9saXN0OworCS8qICBsaXN0IG9mIHN1cHBvcnRlZCByYW5nZXMgKi8KIH07CiAKIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgcGNsNzI2X2JvYXJkIGJvYXJkdHlwZXNbXSA9IHsKQEAgLTIwNCw5
ICsyMDUsOCBAQCBzdGF0aWMgaW50IHBjbDcyNl9hb19pbnNuX3JlYWQoc3RydWN0IGNvbWVkaV9k
ZXZpY2UgKmRldiwKIAlpbnQgY2hhbiA9IENSX0NIQU4oaW5zbi0+Y2hhbnNwZWMpOwogCWludCBu
OwogCi0JZm9yIChuID0gMDsgbiA8IGluc24tPm47IG4rKykgeworCWZvciAobiA9IDA7IG4gPCBp
bnNuLT5uOyBuKyspCiAJCWRhdGFbbl0gPSBkZXZwcml2LT5hb19yZWFkYmFja1tjaGFuXTsKLQl9
CiAJcmV0dXJuIG47CiB9CiAKQEAgLTI1NiwxMCArMjU2LDEwIEBAIHN0YXRpYyBpbnQgcGNsNzI2
X2F0dGFjaChzdHJ1Y3QgY29tZWRpX2RldmljZSAqZGV2LCBzdHJ1Y3QgY29tZWRpX2RldmNvbmZp
ZyAqaXQpCiAKIAlpb2Jhc2UgPSBpdC0+b3B0aW9uc1swXTsKIAlpb3JhbmdlID0gdGhpc19ib2Fy
ZC0+aW9fcmFuZ2U7Ci0JcHJpbnRrKCJjb21lZGklZDogcGNsNzI2OiBib2FyZD0lcywgMHglMDNs
eCAiLCBkZXYtPm1pbm9yLAorCXByaW50ayhLRVJOX1dBUk5JTkcsICJjb21lZGklZDogcGNsNzI2
OiBib2FyZD0lcywgMHglMDNseCAiLCBkZXYtPm1pbm9yLAogCSAgICAgICB0aGlzX2JvYXJkLT5u
YW1lLCBpb2Jhc2UpOwogCWlmICghcmVxdWVzdF9yZWdpb24oaW9iYXNlLCBpb3JhbmdlLCAicGNs
NzI2IikpIHsKLQkJcHJpbnRrKCJJL08gcG9ydCBjb25mbGljdFxuIik7CisJCXByaW50ayhLRVJO
X1dBUk5JTkcsICJJL08gcG9ydCBjb25mbGljdFxuIik7CiAJCXJldHVybiAtRUlPOwogCX0KIApA
QCAtMjgzLDE2ICsyODMsMTYgQEAgc3RhdGljIGludCBwY2w3MjZfYXR0YWNoKHN0cnVjdCBjb21l
ZGlfZGV2aWNlICpkZXYsIHN0cnVjdCBjb21lZGlfZGV2Y29uZmlnICppdCkKIAkJZGV2cHJpdi0+
Zmlyc3RfY2hhbiA9IDI7CiAJCWlmIChpcnEpIHsJLyogd2Ugd2FudCB0byB1c2UgSVJRICovCiAJ
CQlpZiAoKCgxIDw8IGlycSkgJiBib2FyZHR5cGVzW2JvYXJkXS5JUlFiaXRzKSA9PSAwKSB7Ci0J
CQkJcHJpbnRrCi0JCQkJICAgICgiLCBJUlEgJWQgaXMgb3V0IG9mIGFsbG93ZWQgcmFuZ2UsIERJ
U0FCTElORyBJVCIsCi0JCQkJICAgICBpcnEpOworCQkJCXByaW50ayhLRVJOX1dBUk5JTkcsCisJ
CQkJCSIsIElSUSAlZCBpcyBvdXQgb2YgYWxsb3dlZCByYW5nZSwiCisJCQkJCSIgRElTQUJMSU5H
IElUIiwgaXJxKTsKIAkJCQlpcnEgPSAwOwkvKiBCYWQgSVJRICovCiAJCQl9IGVsc2UgewogCQkJ
CWlmIChyZXF1ZXN0X2lycShpcnEsIGludGVycnVwdF9wY2w4MTgsIDAsCiAJCQkJCQkicGNsNzI2
IiwgZGV2KSkgewotCQkJCQlwcmludGsKLQkJCQkJICAgICgiLCB1bmFibGUgdG8gYWxsb2NhdGUg
SVJRICVkLCBESVNBQkxJTkcgSVQiLAotCQkJCQkgICAgIGlycSk7CisJCQkJCXByaW50ayhLRVJO
X1dBUk5JTkcsCisJCQkJCQkiLCB1bmFibGUgdG8gYWxsb2NhdGUgSVJRICVkLCIKKwkJCQkJCSIg
RElTQUJMSU5HIElUIiwgaXJxKTsKIAkJCQkJaXJxID0gMDsJLyogQ2FuJ3QgdXNlIElSUSAqLwog
CQkJCX0gZWxzZSB7CiAJCQkJCXByaW50aygiLCBpcnE9JWQiLCBpcnEpOwpAQCAtMzcyLDkgKzM3
Miw4IEBAIHN0YXRpYyBpbnQgcGNsNzI2X2RldGFjaChzdHJ1Y3QgY29tZWRpX2RldmljZSAqZGV2
KQogLyogcHJpbnRrKCJjb21lZGklZDogcGNsNzI2OiByZW1vdmVcbiIsZGV2LT5taW5vcik7ICov
CiAKICNpZmRlZiBBQ0w2MTI2X0lSUQotCWlmIChkZXYtPmlycSkgeworCWlmIChkZXYtPmlycSkK
IAkJZnJlZV9pcnEoZGV2LT5pcnEsIGRldik7Ci0JfQogI2VuZGlmCiAKIAlpZiAoZGV2LT5pb2Jh
c2UpCg==
--001636d33c7cfaf8cb0476a014b5--
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
