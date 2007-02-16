From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow config files to be included
Date: Fri, 16 Feb 2007 15:45:40 +0100
Message-ID: <81b0412b0702160645t1212f70apc466b670066ef433@mail.gmail.com>
References: <200702140909.28369.andyparkins@gmail.com>
	 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
	 <200702151019.25409.andyparkins@gmail.com>
	 <20070215113557.GB2282@steel.home> <20070216143952.GA2478@steel.home>
	 <81b0412b0702160642h69b632f0w6c1decc4ec04c24a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4971_7055619.1171637140962"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 15:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI4LL-00066q-Go
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 15:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbXBPOpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 09:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbXBPOpo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 09:45:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:5499 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160998AbXBPOpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 09:45:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so164961uga
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 06:45:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=MA04oaVrKuMuPChOg/m2FLTRwNhD3ofrPUGonYpnBQdLqa7mVGvXAQ3vHNJ1bUD442DH+puoTtXiz+0ixX2rJaZAP1FLrBEXA+w77zT0bMpBVuQ4wTzi5q3EZSfYsrGSss8DYIJL9JVaevf30qy927rnF19+G1DuAZJ3pJMPTlo=
Received: by 10.78.138.6 with SMTP id l6mr609682hud.1171637141022;
        Fri, 16 Feb 2007 06:45:41 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Fri, 16 Feb 2007 06:45:40 -0800 (PST)
In-Reply-To: <81b0412b0702160642h69b632f0w6c1decc4ec04c24a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39917>

------=_Part_4971_7055619.1171637140962
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The syntax is:

    [include "filename"]

which is somewhat branch/remote-alike. There are a few differences, though:
filenames happen to be long, so a backslash is supported to split the
names into multiple lines. No bare LF allowed, so this is illegal:
    [include "path/
    name"]
On the other hand, this is allowed:
    [include "path/\
    name"]

Backslash is just to quote characters (as in shell).
Only one quoted string allowed, so this is bad too:

    [include "path/" "name"]

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

> This is a resend, I have no idea what happened to original,
> but it never appeared on vger. And this will probably horribly
> garbled by gmail. Will see.

It was horribly garbled by gmail. Resending as attachment.

> Alex Riesen, Thu, Feb 15, 2007 12:35:57 +0100:
> > I suggest to ignore /etc/gitconfig completely if ~/.gitconfig exists,
> > but allow inclusion of /etc/gitconfig from ~/.gitconfig (there are
> > very singular and preciuos exceptions).
>
config.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 100 insertions(+), 3 deletions(-)

------=_Part_4971_7055619.1171637140962
Content-Type: text/x-patch; name="0001-Allow-config-files-to-be-included.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Allow-config-files-to-be-included.patch"
X-Attachment-Id: f_ey8qhqt5

RnJvbSAxMGM2ZGM4OTEyOGZkYTBiNGRlODlkNjliZDBjYTIwODdmNTMxYTI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhQHN0ZWVsLmhvbWU+CkRhdGU6IFRo
dSwgMTUgRmViIDIwMDcgMTg6MzQ6MzAgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBbGxvdyBjb25m
aWcgZmlsZXMgdG8gYmUgaW5jbHVkZWQKClRoZSBzeW50YXggaXM6CgogICAgW2luY2x1ZGUgImZp
bGVuYW1lIl0KCndoaWNoIGlzIHNvbWV3aGF0IGJyYW5jaC9yZW1vdGUtYWxpa2UuIFRoZXJlIGFy
ZSBhIGZldyBkaWZmZXJlbmNlcywgdGhvdWdoOgpmaWxlbmFtZXMgaGFwcGVuIHRvIGJlIGxvbmcs
IHNvIGEgYmFja3NsYXNoIGlzIHN1cHBvcnRlZCB0byBzcGxpdCB0aGUKbmFtZXMgaW50byBtdWx0
aXBsZSBsaW5lcy4gTm8gYmFyZSBMRiBhbGxvd2VkLCBzbyB0aGlzIGlzIGlsbGVnYWw6CiAgICBb
aW5jbHVkZSAicGF0aC8KICAgIG5hbWUiXQpPbiB0aGUgb3RoZXIgaGFuZCwgdGhpcyBpcyBhbGxv
d2VkOgogICAgW2luY2x1ZGUgInBhdGgvXAogICAgbmFtZSJdCgpCYWNrc2xhc2ggaXMganVzdCB0
byBxdW90ZSBjaGFyYWN0ZXJzIChhcyBpbiBzaGVsbCkuCk9ubHkgb25lIHF1b3RlZCBzdHJpbmcg
YWxsb3dlZCwgc28gdGhpcyBpcyBiYWQgdG9vOgoKICAgIFtpbmNsdWRlICJwYXRoLyIgIm5hbWUi
XQoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBj
b25maWcuYyB8ICAxMDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY29uZmlnLmMgYi9jb25maWcuYwppbmRleCBk
ODIxMDcxLi5iNDJhN2VhIDEwMDY0NAotLS0gYS9jb25maWcuYworKysgYi9jb25maWcuYwpAQCAt
MTIsNiArMTIsNTcgQEAKIHN0YXRpYyBGSUxFICpjb25maWdfZmlsZTsKIHN0YXRpYyBjb25zdCBj
aGFyICpjb25maWdfZmlsZV9uYW1lOwogc3RhdGljIGludCBjb25maWdfbGluZW5yOworCitzdHJ1
Y3QgZmlsZWluZm8KK3sKKwljaGFyICpuYW1lOworCWludCBsaW5lbnI7CisJRklMRSAqZmlsZTsK
KwlzdHJ1Y3QgZmlsZWluZm8gKnByZXY7Cit9Oworc3RhdGljIHN0cnVjdCBmaWxlaW5mbyAqY29u
ZmlnX3N0YWNrID0gTlVMTDsKKworc3RhdGljIHZvaWQgaW5jbHVkZV9maWxlKGNvbnN0IGNoYXIg
KmZpbGVuYW1lKQoreworCXN0cnVjdCBmaWxlaW5mbyAqcHJldjsKKwlGSUxFICpmaWxlOworCWZp
bGUgPSBmb3BlbihmaWxlbmFtZSwgInIiKTsKKwlpZiAoIWZpbGUpIHsKKwkJZXJyb3IoImlnbm9y
ZWQgXCIlc1wiOiAlcyIsIGZpbGVuYW1lLCBzdHJlcnJvcihlcnJubykpOworCQlyZXR1cm47CisJ
fQorCXByZXYgPSBtYWxsb2Moc2l6ZW9mKCpwcmV2KSk7CisJcHJldi0+bmFtZSA9IChjaGFyICop
Y29uZmlnX2ZpbGVfbmFtZTsKKwlwcmV2LT5saW5lbnIgPSBjb25maWdfbGluZW5yOworCXByZXYt
PmZpbGUgPSBjb25maWdfZmlsZTsKKwlwcmV2LT5wcmV2ID0gY29uZmlnX3N0YWNrOworCWNvbmZp
Z19zdGFjayA9IHByZXY7CisKKwljb25maWdfZmlsZSA9IGZpbGU7CisJY29uZmlnX2ZpbGVfbmFt
ZSA9IHhzdHJkdXAoZmlsZW5hbWUpOworCWNvbmZpZ19saW5lbnIgPSAwOworfQorCitzdGF0aWMg
RklMRSAqcG9wX2ZpbGUodm9pZCkKK3sKKwlzdHJ1Y3QgZmlsZWluZm8gKnByZXY7CisKKwlpZiAo
IWNvbmZpZ19zdGFjaykKKwkJLyogVGhlIGxhc3QgZmlsZSBvbiBzdGFjayBkb2VzIG5vdCBiZWxv
bmcgdG8gdXMuCisJCSAqIEZyZWUgdGhlIG5hbWVzIGFuZCBjbG9zZSBhbGwgaW5jbHVkZWQgZmls
ZXMuICovCisJCXJldHVybiBOVUxMOworCisJZnJlZSgodm9pZCopY29uZmlnX2ZpbGVfbmFtZSk7
CisJZmNsb3NlKGNvbmZpZ19maWxlKTsKKwljb25maWdfZmlsZSA9IGNvbmZpZ19zdGFjay0+Zmls
ZTsKKwljb25maWdfZmlsZV9uYW1lID0gY29uZmlnX3N0YWNrLT5uYW1lOworCWNvbmZpZ19saW5l
bnIgPSAwOworCXByZXYgPSBjb25maWdfc3RhY2stPnByZXY7CisJZnJlZShjb25maWdfc3RhY2sp
OworCWNvbmZpZ19zdGFjayA9IHByZXY7CisJcmV0dXJuIGNvbmZpZ19maWxlOworfQorCiBzdGF0
aWMgaW50IGdldF9uZXh0X2NoYXIodm9pZCkKIHsKIAlpbnQgYzsKQEAgLTMxLDEzICs4Miw1MSBA
QCBzdGF0aWMgaW50IGdldF9uZXh0X2NoYXIodm9pZCkKIAkJaWYgKGMgPT0gJ1xuJykKIAkJCWNv
bmZpZ19saW5lbnIrKzsKIAkJaWYgKGMgPT0gRU9GKSB7Ci0JCQljb25maWdfZmlsZSA9IE5VTEw7
CisJCQljb25maWdfZmlsZSA9IHBvcF9maWxlKCk7CiAJCQljID0gJ1xuJzsKIAkJfQogCX0KIAly
ZXR1cm4gYzsKIH0KIAorc3RhdGljIGludCBwYXJzZV9pbmNsdWRlKHZvaWQpCit7CisJY2hhciBu
YW1lW1BBVEhfTUFYXTsKKwlpbnQgcXVvdGUgPSAwLCBsZW4gPSAwOworCisJZm9yICg7Oykgewor
CQlpbnQgYyA9IGdldF9uZXh0X2NoYXIoKTsKKwkJaWYgKGxlbiA+PSBzaXplb2YobmFtZSkpCisJ
CQlyZXR1cm4gLTE7CisJCWlmIChjID09ICciJykgeworCQkJcXVvdGUrKzsKKwkJCWNvbnRpbnVl
OworCQl9CisJCWlmIChjID09ICdcbicpCisJCQkvKiBkbyBub3QgYWxsb3cgYmFyZSBcbiBhbnl3
aGVyZSBpbiBwYXRoICovCisJCQlyZXR1cm4gLTE7CisJCWlmIChxdW90ZSA9PSAxKSB7CisJCQlp
ZiAoYyA9PSAnXFwnKSB7CisJCQkJYyA9IGdldF9uZXh0X2NoYXIoKTsKKwkJCQlpZiAoYyA9PSAn
XG4nKQorCQkJCQljb250aW51ZTsKKwkJCX0KKwkJCW5hbWVbbGVuKytdID0gYzsKKwkJfQorCQlp
ZiAocXVvdGUgPT0gMiAmJiBjID09ICddJykgeworCQkJZG8KKwkJCQljID0gZ2V0X25leHRfY2hh
cigpOworCQkJd2hpbGUgKGMgIT0gJ1xuJyk7CisJCQlicmVhazsKKwkJfQorCQlpZiAoKHF1b3Rl
IDwgMSB8fCBxdW90ZSA+PSAyKSAmJiAhaXNzcGFjZShjKSApCisJCQlyZXR1cm4gLTE7CisJfQor
CW5hbWVbbGVuXSA9ICdcMCc7CisJaW5jbHVkZV9maWxlKG5hbWUpOworCXJldHVybiAwOworfQor
CiBzdGF0aWMgY2hhciAqcGFyc2VfdmFsdWUodm9pZCkKIHsKIAlzdGF0aWMgY2hhciB2YWx1ZVsx
MDI0XTsKQEAgLTE4MSw4ICsyNzAsMTMgQEAgc3RhdGljIGludCBnZXRfYmFzZV92YXIoY2hhciAq
bmFtZSkKIAkJaW50IGMgPSBnZXRfbmV4dF9jaGFyKCk7CiAJCWlmIChjID09IEVPRikKIAkJCXJl
dHVybiAtMTsKKwkJaWYgKCFpc2FscGhhKGMpICYmICFzdHJuY21wKG5hbWUsICJpbmNsdWRlIiwg
YmFzZWxlbikgJiYKKwkJICAgIGNvbmZpZ19maWxlKSB7CisJCQl1bmdldGMoYywgY29uZmlnX2Zp
bGUpOworCQkJcmV0dXJuIHBhcnNlX2luY2x1ZGUoKTsKKwkJfQogCQlpZiAoYyA9PSAnXScpCi0J
CQlyZXR1cm4gYmFzZWxlbjsKKwkJCXJldHVybiBiYXNlbGVuID8gYmFzZWxlbjogLTE7CiAJCWlm
IChpc3NwYWNlKGMpKQogCQkJcmV0dXJuIGdldF9leHRlbmRlZF9iYXNlX3ZhcihuYW1lLCBiYXNl
bGVuLCBjKTsKIAkJaWYgKCFpc2tleWNoYXIoYykgJiYgYyAhPSAnLicpCkBAIC0yMTYsOCArMzEw
LDExIEBAIHN0YXRpYyBpbnQgZ2l0X3BhcnNlX2ZpbGUoY29uZmlnX2ZuX3QgZm4pCiAJCX0KIAkJ
aWYgKGMgPT0gJ1snKSB7CiAJCQliYXNlbGVuID0gZ2V0X2Jhc2VfdmFyKHZhcik7Ci0JCQlpZiAo
YmFzZWxlbiA8PSAwKQorCQkJaWYgKGJhc2VsZW4gPCAwKQogCQkJCWJyZWFrOworCQkJaWYgKCFi
YXNlbGVuKQorCQkJCS8qIFtpbmNsdWRlICIuLi4iXSovCisJCQkJY29udGludWU7CiAJCQl2YXJb
YmFzZWxlbisrXSA9ICcuJzsKIAkJCXZhcltiYXNlbGVuXSA9IDA7CiAJCQljb250aW51ZTsKLS0g
CjEuNS4wLjEzOC5nMzZmODEKCg==
------=_Part_4971_7055619.1171637140962--
