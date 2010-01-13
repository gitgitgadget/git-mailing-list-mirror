From: "Rudolf Polzer" <divVerent@alientrap.org>
Subject: [PATCH] git push --track
Date: Wed, 13 Jan 2010 16:12:49 +0100
Message-ID: <op.u6g8jnixg402ra@nb-04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=----------DvrtIEtdHJb6dN249PoR3Z
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 16:25:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV55u-0005Tq-ND
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 16:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab0AMPZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 10:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689Ab0AMPZJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 10:25:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:52416 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755655Ab0AMPZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 10:25:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NV55k-0005OE-Aa
	for git@vger.kernel.org; Wed, 13 Jan 2010 16:25:04 +0100
Received: from nathost.tnd.lab.arcor.de ([145.253.194.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 16:25:04 +0100
Received: from divVerent by nathost.tnd.lab.arcor.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 16:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nathost.tnd.lab.arcor.de
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136832>

------------DvrtIEtdHJb6dN249PoR3Z
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I'd like a feature to automatically "transform" a non-tracking local  
branch into a tracking branch on push. A patch to do that is attached.

Usage:

git branch mybranch
git checkout mybranch
...
git push --track origin mybranch:mybranch

will not just perform the push, but also write a block

[branch "mybranch"]
         remote = origin
         merge = refs/heads/mybranch

to the git configuration so the branch becomes tracking.

This should be a simpler alternative to the otherwise usual procedure

git push origin mybranch:mybranch
git config branch.mybranch.remote origin
git config branch.mybranch.merge refs/heads/mybranch

Are there any chances for this getting added to official git - or an  
alternate convenient way convert a local to a tracking branch?

Best regards,

Rudolf
------------DvrtIEtdHJb6dN249PoR3Z
Content-Disposition: attachment; filename=git-push-track.diff
Content-Type: application/octet-stream; name=git-push-track.diff
Content-Transfer-Encoding: Base64

ZGlmZiAtLWdpdCBhL2J1aWx0aW4tcHVzaC5jIGIvYnVpbHRpbi1wdXNoLmMKaW5k
ZXggMjhhMjZlNy4uOGQ2ODY0NiAxMDA2NDQKLS0tIGEvYnVpbHRpbi1wdXNoLmMK
KysrIGIvYnVpbHRpbi1wdXNoLmMKQEAgLTcsNiArNyw3IEBACiAjaW5jbHVkZSAi
YnVpbHRpbi5oIgogI2luY2x1ZGUgInJlbW90ZS5oIgogI2luY2x1ZGUgInRyYW5z
cG9ydC5oIgorI2luY2x1ZGUgImJyYW5jaC5oIgogI2luY2x1ZGUgInBhcnNlLW9w
dGlvbnMuaCIKIAogc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBwdXNoX3VzYWdl
W10gPSB7CkBAIC0xMTUsNiArMTE2LDMzIEBAIHN0YXRpYyBpbnQgcHVzaF93aXRo
X29wdGlvbnMoc3RydWN0IHRyYW5zcG9ydCAqdHJhbnNwb3J0LCBpbnQgZmxhZ3Mp
CiAJCWZwcmludGYoc3RkZXJyLCAiUHVzaGluZyB0byAlc1xuIiwgdHJhbnNwb3J0
LT51cmwpOwogCWVyciA9IHRyYW5zcG9ydF9wdXNoKHRyYW5zcG9ydCwgcmVmc3Bl
Y19uciwgcmVmc3BlYywgZmxhZ3MsCiAJCQkgICAgICZub25mYXN0Zm9yd2FyZCk7
CisJaWYgKGVyciA9PSAwICYmIGZsYWdzICYgVFJBTlNQT1JUX1BVU0hfVFJBQ0sp
CisJeworCQlzdHJ1Y3QgcmVmICpyZW1vdGVfcmVmcyA9CisJCQl0cmFuc3BvcnQt
PmdldF9yZWZzX2xpc3QodHJhbnNwb3J0LCAxKTsKKwkJc3RydWN0IHJlZiAqbG9j
YWxfcmVmcyA9IGdldF9sb2NhbF9oZWFkcygpOworCQlpbnQgbWF0Y2hfZmxhZ3Mg
PSAwOworCQlpZiAoZmxhZ3MgJiBUUkFOU1BPUlRfUFVTSF9BTEwpCisJCQltYXRj
aF9mbGFncyB8PSBNQVRDSF9SRUZTX0FMTDsKKwkJaWYgKGZsYWdzICYgVFJBTlNQ
T1JUX1BVU0hfTUlSUk9SKQorCQkJbWF0Y2hfZmxhZ3MgfD0gTUFUQ0hfUkVGU19N
SVJST1I7CisJCWlmKCEoZmxhZ3MgJiBUUkFOU1BPUlRfUFVTSF9EUllfUlVOKSkK
KwkJaWYoIW1hdGNoX3JlZnMobG9jYWxfcmVmcywgJnJlbW90ZV9yZWZzLCByZWZz
cGVjX25yLCByZWZzcGVjLCBtYXRjaF9mbGFncykpCisJCXsKKwkJCXN0cnVjdCBy
ZWYgKm5leHQgPSByZW1vdGVfcmVmczsKKwkJCXdoaWxlKG5leHQpCisJCQl7CisJ
CQkJaWYobmV4dC0+cGVlcl9yZWYgJiYgKm5leHQtPnBlZXJfcmVmLT5uYW1lICYm
ICpuZXh0LT5uYW1lICYmIG5leHQtPnBlZXJfcmVmLT5uZXdfc2hhMSAmJiAhaXNf
bnVsbF9zaGExKG5leHQtPnBlZXJfcmVmLT5uZXdfc2hhMSkpCisJCQkJeworCQkJ
CQlpZiAoIXByZWZpeGNtcChuZXh0LT5wZWVyX3JlZi0+bmFtZSwgInJlZnMvaGVh
ZHMvIikpCisJCQkJCXsKKwkJCQkJCWluc3RhbGxfYnJhbmNoX2NvbmZpZyhCUkFO
Q0hfQ09ORklHX1ZFUkJPU0UsIG5leHQtPnBlZXJfcmVmLT5uYW1lICsgMTEsIHRy
YW5zcG9ydC0+cmVtb3RlLT5uYW1lLCBuZXh0LT5uYW1lKTsKKwkJCQkJfQorCQkJ
CX0KKwkJCQluZXh0ID0gbmV4dC0+bmV4dDsKKwkJCX0KKwkJfQorCX0KIAlpZiAo
ZXJyICE9IDApCiAJCWVycm9yKCJmYWlsZWQgdG8gcHVzaCBzb21lIHJlZnMgdG8g
JyVzJyIsIHRyYW5zcG9ydC0+dXJsKTsKIApAQCAtMjE4LDYgKzI0Niw4IEBAIGlu
dCBjbWRfcHVzaChpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNo
YXIgKnByZWZpeCkKIAkJT1BUX0JPT0xFQU4oIDAgLCAidGhpbiIsICZ0aGluLCAi
dXNlIHRoaW4gcGFjayIpLAogCQlPUFRfU1RSSU5HKCAwICwgInJlY2VpdmUtcGFj
ayIsICZyZWNlaXZlcGFjaywgInJlY2VpdmUtcGFjayIsICJyZWNlaXZlIHBhY2sg
cHJvZ3JhbSIpLAogCQlPUFRfU1RSSU5HKCAwICwgImV4ZWMiLCAmcmVjZWl2ZXBh
Y2ssICJyZWNlaXZlLXBhY2siLCAicmVjZWl2ZSBwYWNrIHByb2dyYW0iKSwKKwkJ
T1BUX0JJVCgndCcsICJ0cmFjayIsICAmZmxhZ3MsICJzZXQgdXAgdHJhY2tpbmcg
bW9kZSAoc2VlIGdpdC1wdWxsKDEpKSIsCisJCQlUUkFOU1BPUlRfUFVTSF9UUkFD
SyksCiAJCU9QVF9FTkQoKQogCX07CiAKZGlmZiAtLWdpdCBhL3RyYW5zcG9ydC5o
IGIvdHJhbnNwb3J0LmgKaW5kZXggOWU3NDQwNi4uOGE5Yzc3NiAxMDA2NDQKLS0t
IGEvdHJhbnNwb3J0LmgKKysrIGIvdHJhbnNwb3J0LmgKQEAgLTc0LDYgKzc0LDcg
QEAgc3RydWN0IHRyYW5zcG9ydCB7CiAjZGVmaW5lIFRSQU5TUE9SVF9QVVNIX1ZF
UkJPU0UgMTYKICNkZWZpbmUgVFJBTlNQT1JUX1BVU0hfUE9SQ0VMQUlOIDMyCiAj
ZGVmaW5lIFRSQU5TUE9SVF9QVVNIX1FVSUVUIDY0CisjZGVmaW5lIFRSQU5TUE9S
VF9QVVNIX1RSQUNLIDEyOAogCiAvKiBSZXR1cm5zIGEgdHJhbnNwb3J0IHN1aXRh
YmxlIGZvciB0aGUgdXJsICovCiBzdHJ1Y3QgdHJhbnNwb3J0ICp0cmFuc3BvcnRf
Z2V0KHN0cnVjdCByZW1vdGUgKiwgY29uc3QgY2hhciAqKTsK

------------DvrtIEtdHJb6dN249PoR3Z--
