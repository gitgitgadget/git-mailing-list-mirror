From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [RFC] Add --index to git-commit: just commit current index
Date: Thu, 15 Mar 2007 10:43:37 +0100
Message-ID: <81b0412b0703150243h6a5f036aye8f115d82e11e883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23072_23847454.1173951817947"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 15 10:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRmUp-0005U1-E4
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 10:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbXCOJnk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 05:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbXCOJnk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 05:43:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:15143 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbXCOJnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 05:43:39 -0400
Received: by ug-out-1314.google.com with SMTP id 44so252631uga
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 02:43:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=cgqC5MK20eE5Rk/m0JdA881FfT+xfunCb17bt9M3XoITNUGX0qfg2/CI9ct1PZufW5dTBxvPiotm4eYfSIRiDvfa771QvhI0umn3aiwX9p4iGWFz7VYSm0rG4VXnzAV1XW0smkwX2RT+eTu0NKBp+2Lu5CWvN5BHYgl3J2BaSnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=uY2fRO1jbvZKaDpInE+wHxLV6Bt7BY59V7LQQYmtMnkSsN5eBbTok4v4V26YISfQDUFa9wquQwPWUk0HZGeC9z+kCzwZpF+vyaaq+Va5Zw51mLAOV8kKDf27oa2kuHLLZ6P7IJU4EueEZouFzuDCbOKsKnl6zIRRsv0CgsdTfJM=
Received: by 10.78.204.20 with SMTP id b20mr229193hug.1173951817981;
        Thu, 15 Mar 2007 02:43:37 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Thu, 15 Mar 2007 02:43:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42275>

------=_Part_23072_23847454.1173951817947
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Refreshing index takes a long time on big repositories with many files,
especially if the developer was unlucky enough to stick to a slow filesystem
or a broken OS. In this situation explicit git-update-index with
git-commit --index will speedup the workflow.
Giving either --all, -o, or -i silently turns --index off (these have to
refresh index).
In case of unmodified index no status message is shown, for all
the same reasons: it takes too long.
---

First use of new --quiet :)

 git-commit.sh |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

------=_Part_23072_23847454.1173951817947
Content-Type: text/plain; 
	name=0001-Add-index-to-git-commit-just-commit-current-index.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ezb0n9x2
Content-Disposition: attachment; filename="0001-Add-index-to-git-commit-just-commit-current-index.txt"

RnJvbSA0OWI4NDZhNjU0ZDJmMWVmNTQwZDY0MzgzNTZiZmZlYWZhOTdiYTYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDE1IE1hciAyMDA3IDEwOjM5OjM2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIC0t
aW5kZXggdG8gZ2l0LWNvbW1pdDoganVzdCBjb21taXQgY3VycmVudCBpbmRleAoKUmVmcmVzaGlu
ZyBpbmRleCB0YWtlcyBhIGxvbmcgdGltZSBvbiBiaWcgcmVwb3NpdG9yaWVzIHdpdGggbWFueSBm
aWxlcywKZXNwZWNpYWxseSBpZiB0aGUgZGV2ZWxvcGVyIGlzIHVubHVja3kgZW5vdWdoIHRvIHN0
aWNrIHRvIGEgc2xvdyBmaWxlc3lzdGVtCm9yIGEgYnJva2VuIE9TLiBJbiB0aGlzIHNpdHVhdGlv
biBleHBsaWNpdCBnaXQtdXBkYXRlLWluZGV4IHdpdGgKZ2l0LWNvbW1pdCAtLWluZGV4IHdpbGwg
c3BlZWR1cCB0aGUgd29ya2Zsb3cuCkdpdmluZyBlaXRoZXIgLS1hbGwsIC0tb25seSwgb3IgLS1p
bmNsdWRlIHNpbGVudGx5IHR1cm5zIC0taW5kZXggb2ZmLgotLS0KIGdpdC1jb21taXQuc2ggfCAg
IDIxICsrKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1jb21taXQuc2ggYi9naXQtY29t
bWl0LnNoCmluZGV4IDM2NTZkNjAuLjU2NTQzYzkgMTAwNzU1Ci0tLSBhL2dpdC1jb21taXQuc2gK
KysrIGIvZ2l0LWNvbW1pdC5zaApAQCAtMyw3ICszLDcgQEAKICMgQ29weXJpZ2h0IChjKSAyMDA1
IExpbnVzIFRvcnZhbGRzCiAjIENvcHlyaWdodCAoYykgMjAwNiBKdW5pbyBDIEhhbWFubwogCi1V
U0FHRT0nWy1hIHwgLS1pbnRlcmFjdGl2ZV0gWy1zXSBbLXZdIFstLW5vLXZlcmlmeV0gWy1tIDxt
ZXNzYWdlPiB8IC1GIDxsb2dmaWxlPiB8ICgtQ3wtYykgPGNvbW1pdD4gfCAtLWFtZW5kXSBbLXVd
IFstZV0gWy0tYXV0aG9yIDxhdXRob3I+XSBbWy1pIHwgLW9dIDxwYXRoPi4uLl0nCitVU0FHRT0n
Wy1hIHwgLS1pbnRlcmFjdGl2ZV0gWy1zXSBbLXZdIFstLW5vLXZlcmlmeV0gWy1tIDxtZXNzYWdl
PiB8IC1GIDxsb2dmaWxlPiB8ICgtQ3wtYykgPGNvbW1pdD4gfCAtLWFtZW5kXSBbLXVdIFstZV0g
Wy0tYXV0aG9yIDxhdXRob3I+XSBbLS1pbmRleF0gW1staSB8IC1vXSA8cGF0aD4uLi5dJwogU1VC
RElSRUNUT1JZX09LPVllcwogLiBnaXQtc2gtc2V0dXAKIHJlcXVpcmVfd29ya190cmVlCkBAIC04
Nyw2ICs4Nyw3IEBAIHNpZ25vZmY9CiBmb3JjZV9hdXRob3I9CiBvbmx5X2luY2x1ZGVfYXNzdW1l
ZD0KIHVudHJhY2tlZF9maWxlcz0KK2luZGV4X29ubHk9CiB3aGlsZSBjYXNlICIkIyIgaW4gMCkg
YnJlYWs7OyBlc2FjCiBkbwogCWNhc2UgIiQxIiBpbgpAQCAtMjYyLDYgKzI2MywxMCBAQCAkMSIK
IAkJdW50cmFja2VkX2ZpbGVzPXQKIAkJc2hpZnQKIAkJOzsKKwktLWluZGV4KQorCQlpbmRleF9v
bmx5PXQKKwkJc2hpZnQKKwkJOzsKIAktLSkKIAkJc2hpZnQKIAkJYnJlYWsKQEAgLTI3NSw2ICsy
ODAsNyBAQCAkMSIKIAllc2FjCiBkb25lCiBjYXNlICIkZWRpdF9mbGFnIiBpbiB0KSBub19lZGl0
PSA7OyBlc2FjCitjYXNlICIkYWxsJGFsc28kb25seSIgaW4gdCopIGluZGV4X29ubHk9IDs7IGVz
YWMKIAogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwogIyBTYW5pdHkgY2hlY2sgb3B0aW9ucwpAQCAtNDA0LDE1ICs0MTAsMjIg
QEAgZWxzZQogCVVTRV9JTkRFWD0iJFRISVNfSU5ERVgiCiBmaQogCi1jYXNlICIkc3RhdHVzX29u
bHkiIGluCi10KQorY2FzZSAiJHN0YXR1c19vbmx5LCRpbmRleF9vbmx5IiBpbgordCwqKQogCSMg
VGhpcyB3aWxsIHNpbGVudGx5IGZhaWwgaW4gYSByZWFkLW9ubHkgcmVwb3NpdG9yeSwgd2hpY2gg
aXMKIAkjIHdoYXQgd2Ugd2FudC4KIAlHSVRfSU5ERVhfRklMRT0iJFVTRV9JTkRFWCIgZ2l0LXVw
ZGF0ZS1pbmRleCAtcSAtLXVubWVyZ2VkIC0tcmVmcmVzaAogCXJ1bl9zdGF0dXMKIAlleGl0ICQ/
CiAJOzsKLScnKQorLHQpCisJR0lUX0lOREVYX0ZJTEU9IiRVU0VfSU5ERVgiIFwKKwlnaXQtZGlm
Zi1pbmRleCAtLWNhY2hlZCAtLXF1aWV0IC0tZXhpdC1jb2RlIEhFQUQgJiYgeworCQllY2hvID4m
MiAiTm8gY2hhbmdlcyBpbiB0aGUgaW5kZXgiCisJCWV4aXQgMQorCX0KKwk7OworLCkKIAlHSVRf
SU5ERVhfRklMRT0iJFVTRV9JTkRFWCIgZ2l0LXVwZGF0ZS1pbmRleCAtcSAtLXJlZnJlc2ggfHwg
ZXhpdAogCTs7CiBlc2FjCi0tIAoxLjUuMC40LjQzOS5nY2U1ZgoK
------=_Part_23072_23847454.1173951817947--
