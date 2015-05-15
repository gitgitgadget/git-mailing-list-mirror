From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Fri, 15 May 2015 15:33:07 -0500
Message-ID: <CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
	<20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	<5547C961.7070909@web.de>
	<CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
	<37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec5186b088364da051624c0b3
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 22:33:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMIE-0004Rm-8z
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934953AbbEOUdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 16:33:09 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34754 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934056AbbEOUdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 16:33:08 -0400
Received: by igblo3 with SMTP id lo3so48407707igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/6UHpdoNrjJ2JU7e+HlWeElA3Lk0DZsPWc1SNV0SitA=;
        b=SNKOegMJtETpz5QSlV7XG9HnDHz/G7Llh5CaDC/QZkmynKK3ssXTOh4hUAxJ3xXq7F
         Bmrs8Mk7W4Dp1TKTm9bsR9MnxINAm+48aOZu/MCmN5bEwI54UCXPuXPyc6+WtHvRbXwl
         QLtCr6wfqEykvFItYnGcE/vawF0hhutd3K8aNdI78cWFpyFX7Q6bEffE5wcKf5jwxpDT
         myqWEuoOlJ9QIagVNZQxlXQztXiffc3ay81v4uAtf1oSV4pUdc+dEVxGJm087tYetAnR
         bxgbmb18Bd5dqA2fQuM5Dc85Uur+U04dqxwnYARlMU0YUcN9cXT07/vspVJ8jpwEBO/T
         Dgzg==
X-Received: by 10.43.97.130 with SMTP id ck2mr22896095icc.91.1431721987966;
 Fri, 15 May 2015 13:33:07 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Fri, 15 May 2015 13:33:07 -0700 (PDT)
In-Reply-To: <37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
X-Google-Sender-Auth: pZWTNuY_j1dArkz6n0XSfHq-CDs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269178>

--bcaec5186b088364da051624c0b3
Content-Type: text/plain; charset=UTF-8

On Tue, May 5, 2015 at 12:49 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Robert,
>
> On 2015-05-04 22:21, Robert Dailey wrote:
>
>> Since I am not a linux user, I have implemented this feature against
>> the Git for Windows fork of git. I am not able to verify changes if I
>> make them directly against the Git repository.
>
> That is why I worked so hard on support of Vagrant: https://github.com/msysgit/msysgit/wiki/Vagrant -- in short, it makes it dead easy for you to set up a *minimal* Linux VM inside your Git SDK and interact with it via ssh.
>
> With the Vagrant solution, you can easily test Linux Git even on Windows.
>
> Ciao,
> Johannes

At the moment I have a "half-ass" patch attached. This implements the
feature itself. I'm able to test this and it seems to be working.
Please note I'm a C++ developer and straight C / Bash are not my
strong suits. I apologize in advance for any mistakes. I am open to
taking recommendations for corrections.

I'm not sure how I can verify the feature in a unit test. In addition
to learning bash scripting well enough to write the test, I am not
sure how to use git to check for the additional commits. Plus the repo
for the test will need to handle a submodule change to a merge commit
as well. Any advice on setting up a good test case for this? What
conditions should I check for, as far as log output goes?

--bcaec5186b088364da051624c0b3
Content-Type: application/octet-stream; 
	name="0001-Add-full-log-option-to-diff.submodule.patch"
Content-Disposition: attachment; 
	filename="0001-Add-full-log-option-to-diff.submodule.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i9q293mc0

RnJvbSA2NmRiMTg1YWI3NmQwZDg5Mzc5MmQwM2RjMGZjNDkxM2Q4NjhmMjE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JlcnQgRGFpbGV5IDxyY2RhaWxleUBnbWFpbC5jb20+CkRh
dGU6IFR1ZSwgNSBNYXkgMjAxNSAyMTo1NjoyNiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIEFkZCAn
ZnVsbC1sb2cnIG9wdGlvbiB0byBkaWZmLnN1Ym1vZHVsZQoKTGlrZSB0aGUgJ2xvZycgb3B0aW9u
IHRvIGBkaWZmIC0tc3VibW9kdWxlYCwgJ2Z1bGwtbG9nJyBwcm92aWRlcwpsb2dzIHdpdGhvdXQg
dGhlIGAtLWZpcnN0LXBhcmVudGAgb3B0aW9uLgotLS0KIGRpZmYuYyAgICAgIHwgMTYgKysrKysr
KysrKysrLS0tLQogZGlmZi5oICAgICAgfCAgMSArCiBzdWJtb2R1bGUuYyB8ICA5ICsrKysrLS0t
LQogc3VibW9kdWxlLmggfCAgMyArKy0KIDQgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kaWZmLmMgYi9kaWZmLmMKaW5kZXggNzUw
MGM1NS4uNThjNDg3MiAxMDA2NDQKLS0tIGEvZGlmZi5jCisrKyBiL2RpZmYuYwpAQCAtMTI4LDEw
ICsxMjgsMTggQEAgc3RhdGljIGludCBwYXJzZV9kaXJzdGF0X3BhcmFtcyhzdHJ1Y3QgZGlmZl9v
cHRpb25zICpvcHRpb25zLCBjb25zdCBjaGFyICpwYXJhbXMKIAogc3RhdGljIGludCBwYXJzZV9z
dWJtb2R1bGVfcGFyYW1zKHN0cnVjdCBkaWZmX29wdGlvbnMgKm9wdGlvbnMsIGNvbnN0IGNoYXIg
KnZhbHVlKQogewotCWlmICghc3RyY21wKHZhbHVlLCAibG9nIikpCisJaWYgKCFzdHJjbXAodmFs
dWUsICJsb2ciKSkgewogCQlESUZGX09QVF9TRVQob3B0aW9ucywgU1VCTU9EVUxFX0xPRyk7Ci0J
ZWxzZSBpZiAoIXN0cmNtcCh2YWx1ZSwgInNob3J0IikpCisJCURJRkZfT1BUX0NMUihvcHRpb25z
LCBTVUJNT0RVTEVfRlVMTF9MT0cpOworCX0KKwllbHNlIGlmICghc3RyY21wKHZhbHVlLCAiZnVs
bC1sb2ciKSkgeworCQlESUZGX09QVF9TRVQob3B0aW9ucywgU1VCTU9EVUxFX0ZVTExfTE9HKTsK
KwkJRElGRl9PUFRfQ0xSKG9wdGlvbnMsIFNVQk1PRFVMRV9MT0cpOworCX0KKwllbHNlIGlmICgh
c3RyY21wKHZhbHVlLCAic2hvcnQiKSkgewogCQlESUZGX09QVF9DTFIob3B0aW9ucywgU1VCTU9E
VUxFX0xPRyk7CisJCURJRkZfT1BUX0NMUihvcHRpb25zLCBTVUJNT0RVTEVfRlVMTF9MT0cpOwor
CX0KIAllbHNlCiAJCXJldHVybiAtMTsKIAlyZXR1cm4gMDsKQEAgLTIyNDAsNyArMjI0OCw3IEBA
IHN0YXRpYyB2b2lkIGJ1aWx0aW5fZGlmZihjb25zdCBjaGFyICpuYW1lX2EsCiAJc3RydWN0IHN0
cmJ1ZiBoZWFkZXIgPSBTVFJCVUZfSU5JVDsKIAljb25zdCBjaGFyICpsaW5lX3ByZWZpeCA9IGRp
ZmZfbGluZV9wcmVmaXgobyk7CiAKLQlpZiAoRElGRl9PUFRfVFNUKG8sIFNVQk1PRFVMRV9MT0cp
ICYmCisJaWYgKChESUZGX09QVF9UU1QobywgU1VCTU9EVUxFX0xPRykgfHwgRElGRl9PUFRfVFNU
KG8sIFNVQk1PRFVMRV9GVUxMX0xPRykpICYmCiAJCQkoIW9uZS0+bW9kZSB8fCBTX0lTR0lUTElO
SyhvbmUtPm1vZGUpKSAmJgogCQkJKCF0d28tPm1vZGUgfHwgU19JU0dJVExJTksodHdvLT5tb2Rl
KSkpIHsKIAkJY29uc3QgY2hhciAqZGVsID0gZGlmZl9nZXRfY29sb3Jfb3B0KG8sIERJRkZfRklM
RV9PTEQpOwpAQCAtMjI0OCw3ICsyMjU2LDcgQEAgc3RhdGljIHZvaWQgYnVpbHRpbl9kaWZmKGNv
bnN0IGNoYXIgKm5hbWVfYSwKIAkJc2hvd19zdWJtb2R1bGVfc3VtbWFyeShvLT5maWxlLCBvbmUt
PnBhdGggPyBvbmUtPnBhdGggOiB0d28tPnBhdGgsCiAJCQkJbGluZV9wcmVmaXgsCiAJCQkJb25l
LT5zaGExLCB0d28tPnNoYTEsIHR3by0+ZGlydHlfc3VibW9kdWxlLAotCQkJCW1ldGEsIGRlbCwg
YWRkLCByZXNldCk7CisJCQkJbWV0YSwgZGVsLCBhZGQsIHJlc2V0LCBESUZGX09QVF9UU1Qobywg
U1VCTU9EVUxFX0ZVTExfTE9HKSk7CiAJCXJldHVybjsKIAl9CiAKZGlmZiAtLWdpdCBhL2RpZmYu
aCBiL2RpZmYuaAppbmRleCBiNGE2MjRkLi45NWYzMTljIDEwMDY0NAotLS0gYS9kaWZmLmgKKysr
IGIvZGlmZi5oCkBAIC05MCw2ICs5MCw3IEBAIHR5cGVkZWYgc3RydWN0IHN0cmJ1ZiAqKCpkaWZm
X3ByZWZpeF9mbl90KShzdHJ1Y3QgZGlmZl9vcHRpb25zICpvcHQsIHZvaWQgKmRhdGEpCiAjZGVm
aW5lIERJRkZfT1BUX0RJUlNUQVRfQllfTElORSAgICAgKDEgPDwgMjgpCiAjZGVmaW5lIERJRkZf
T1BUX0ZVTkNDT05URVhUICAgICAgICAgKDEgPDwgMjkpCiAjZGVmaW5lIERJRkZfT1BUX1BJQ0tB
WEVfSUdOT1JFX0NBU0UgKDEgPDwgMzApCisjZGVmaW5lIERJRkZfT1BUX1NVQk1PRFVMRV9GVUxM
X0xPRyAgKDEgPDwgMzEpCiAKICNkZWZpbmUgRElGRl9PUFRfVFNUKG9wdHMsIGZsYWcpICAgICgo
b3B0cyktPmZsYWdzICYgRElGRl9PUFRfIyNmbGFnKQogI2RlZmluZSBESUZGX09QVF9UT1VDSEVE
KG9wdHMsIGZsYWcpICAgICgob3B0cyktPnRvdWNoZWRfZmxhZ3MgJiBESUZGX09QVF8jI2ZsYWcp
CmRpZmYgLS1naXQgYS9zdWJtb2R1bGUuYyBiL3N1Ym1vZHVsZS5jCmluZGV4IGQzN2Q0MDAuLmY5
ODE3M2UgMTAwNjQ0Ci0tLSBhL3N1Ym1vZHVsZS5jCisrKyBiL3N1Ym1vZHVsZS5jCkBAIC0yOTAs
MTQgKzI5MCwxNCBAQCB2b2lkIGhhbmRsZV9pZ25vcmVfc3VibW9kdWxlc19hcmcoc3RydWN0IGRp
ZmZfb3B0aW9ucyAqZGlmZm9wdCwKIAogc3RhdGljIGludCBwcmVwYXJlX3N1Ym1vZHVsZV9zdW1t
YXJ5KHN0cnVjdCByZXZfaW5mbyAqcmV2LCBjb25zdCBjaGFyICpwYXRoLAogCQlzdHJ1Y3QgY29t
bWl0ICpsZWZ0LCBzdHJ1Y3QgY29tbWl0ICpyaWdodCwKLQkJaW50ICpmYXN0X2ZvcndhcmQsIGlu
dCAqZmFzdF9iYWNrd2FyZCkKKwkJaW50ICpmYXN0X2ZvcndhcmQsIGludCAqZmFzdF9iYWNrd2Fy
ZCwgdW5zaWduZWQgZnVsbF9sb2cpCiB7CiAJc3RydWN0IGNvbW1pdF9saXN0ICptZXJnZV9iYXNl
cywgKmxpc3Q7CiAKIAlpbml0X3JldmlzaW9ucyhyZXYsIE5VTEwpOwogCXNldHVwX3JldmlzaW9u
cygwLCBOVUxMLCByZXYsIE5VTEwpOwogCXJldi0+bGVmdF9yaWdodCA9IDE7Ci0JcmV2LT5maXJz
dF9wYXJlbnRfb25seSA9IDE7CisJcmV2LT5maXJzdF9wYXJlbnRfb25seSA9IGZ1bGxfbG9nID8g
MCA6IDE7CiAJbGVmdC0+b2JqZWN0LmZsYWdzIHw9IFNZTU1FVFJJQ19MRUZUOwogCWFkZF9wZW5k
aW5nX29iamVjdChyZXYsICZsZWZ0LT5vYmplY3QsIHBhdGgpOwogCWFkZF9wZW5kaW5nX29iamVj
dChyZXYsICZyaWdodC0+b2JqZWN0LCBwYXRoKTsKQEAgLTM2Myw3ICszNjMsOCBAQCB2b2lkIHNo
b3dfc3VibW9kdWxlX3N1bW1hcnkoRklMRSAqZiwgY29uc3QgY2hhciAqcGF0aCwKIAkJY29uc3Qg
Y2hhciAqbGluZV9wcmVmaXgsCiAJCXVuc2lnbmVkIGNoYXIgb25lWzIwXSwgdW5zaWduZWQgY2hh
ciB0d29bMjBdLAogCQl1bnNpZ25lZCBkaXJ0eV9zdWJtb2R1bGUsIGNvbnN0IGNoYXIgKm1ldGEs
Ci0JCWNvbnN0IGNoYXIgKmRlbCwgY29uc3QgY2hhciAqYWRkLCBjb25zdCBjaGFyICpyZXNldCkK
KwkJY29uc3QgY2hhciAqZGVsLCBjb25zdCBjaGFyICphZGQsIGNvbnN0IGNoYXIgKnJlc2V0LAor
CQl1bnNpZ25lZCBmdWxsX2xvZykKIHsKIAlzdHJ1Y3QgcmV2X2luZm8gcmV2OwogCXN0cnVjdCBj
b21taXQgKmxlZnQgPSBOVUxMLCAqcmlnaHQgPSBOVUxMOwpAQCAtMzgxLDcgKzM4Miw3IEBAIHZv
aWQgc2hvd19zdWJtb2R1bGVfc3VtbWFyeShGSUxFICpmLCBjb25zdCBjaGFyICpwYXRoLAogCQkg
IShyaWdodCA9IGxvb2t1cF9jb21taXRfcmVmZXJlbmNlKHR3bykpKQogCQltZXNzYWdlID0gIihj
b21taXRzIG5vdCBwcmVzZW50KSI7CiAJZWxzZSBpZiAocHJlcGFyZV9zdWJtb2R1bGVfc3VtbWFy
eSgmcmV2LCBwYXRoLCBsZWZ0LCByaWdodCwKLQkJCQkJICAgJmZhc3RfZm9yd2FyZCwgJmZhc3Rf
YmFja3dhcmQpKQorCQkJCQkgICAmZmFzdF9mb3J3YXJkLCAmZmFzdF9iYWNrd2FyZCwgZnVsbF9s
b2cpKQogCQltZXNzYWdlID0gIihyZXZpc2lvbiB3YWxrZXIgZmFpbGVkKSI7CiAKIAlpZiAoZGly
dHlfc3VibW9kdWxlICYgRElSVFlfU1VCTU9EVUxFX1VOVFJBQ0tFRCkKZGlmZiAtLWdpdCBhL3N1
Ym1vZHVsZS5oIGIvc3VibW9kdWxlLmgKaW5kZXggN2JlZWM0OC4uMzAxMzU4YiAxMDA2NDQKLS0t
IGEvc3VibW9kdWxlLmgKKysrIGIvc3VibW9kdWxlLmgKQEAgLTI2LDcgKzI2LDggQEAgdm9pZCBz
aG93X3N1Ym1vZHVsZV9zdW1tYXJ5KEZJTEUgKmYsIGNvbnN0IGNoYXIgKnBhdGgsCiAJCWNvbnN0
IGNoYXIgKmxpbmVfcHJlZml4LAogCQl1bnNpZ25lZCBjaGFyIG9uZVsyMF0sIHVuc2lnbmVkIGNo
YXIgdHdvWzIwXSwKIAkJdW5zaWduZWQgZGlydHlfc3VibW9kdWxlLCBjb25zdCBjaGFyICptZXRh
LAotCQljb25zdCBjaGFyICpkZWwsIGNvbnN0IGNoYXIgKmFkZCwgY29uc3QgY2hhciAqcmVzZXQp
OworCQljb25zdCBjaGFyICpkZWwsIGNvbnN0IGNoYXIgKmFkZCwgY29uc3QgY2hhciAqcmVzZXQs
CisJCXVuc2lnbmVkIGZ1bGxfbG9nKTsKIHZvaWQgc2V0X2NvbmZpZ19mZXRjaF9yZWN1cnNlX3N1
Ym1vZHVsZXMoaW50IHZhbHVlKTsKIHZvaWQgY2hlY2tfZm9yX25ld19zdWJtb2R1bGVfY29tbWl0
cyh1bnNpZ25lZCBjaGFyIG5ld19zaGExWzIwXSk7CiBpbnQgZmV0Y2hfcG9wdWxhdGVkX3N1Ym1v
ZHVsZXMoY29uc3Qgc3RydWN0IGFyZ3ZfYXJyYXkgKm9wdGlvbnMsCi0tIAoyLjQuMS53aW5kb3dz
LjEKCg==
--bcaec5186b088364da051624c0b3--
