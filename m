From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Use rev-list --reverse in git-rebase.sh
Date: Wed, 11 Apr 2007 10:18:28 +0200
Message-ID: <81b0412b0704110118x476e96d3g302f6e66c8ae10f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8744_4095971.1176279508038"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:08:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbY2P-0001H5-Nx
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXDKISb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbXDKISa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:18:30 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:15292 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbXDKIS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:18:28 -0400
Received: by an-out-0708.google.com with SMTP id b33so110618ana
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 01:18:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=C2lwNPTFw5wdZekl1U4ZdM+GZx05x5NYyfrs1PWTbWDVGpf7rLrS0L5IPYjLryHzZHZGC59EcPzXjN2UtywlygLAH3IZZ2w6SQ5yN55ExbZlcnb4AkJwzBO8FukJjUb5RfzhFQKp/pff5N/ZKJEeR8+3AKg03TMMcnWgM1inyEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=gY8eWLQzkYRh2f6x3AUwEu4kAT2zR2bTKoQHlXzvi4OSxejheEJLevG/fyNfRHWxhFmYUQiWzMKVAtt5zrUlQBJTRKvYgo7qA7NqtrHGsNSOpE2E+GgZCyrvjSZj9Q+IJYoGfk8Rzp+zAXN0760jhJ1+eiPoYsGjem1Nq0cdPGA=
Received: by 10.100.133.9 with SMTP id g9mr232481and.1176279508090;
        Wed, 11 Apr 2007 01:18:28 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 11 Apr 2007 01:18:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44220>

------=_Part_8744_4095971.1176279508038
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

...and drop the last perl dependency in the script.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Gmail again. Will resend it properly, unless someone
does it before me. Please?

 git-rebase.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1d96f32..2dc2c4f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -339,8 +339,7 @@ prev_head=`git-rev-parse HEAD^0`
 echo "$prev_head" > "$dotest/prev_head"

 msgnum=0
-for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
-			| @@PERL@@ -e 'print reverse <>'`
+for cmt in `git-rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
-- 
1.5.1.147.gbaa5

------=_Part_8744_4095971.1176279508038
Content-Type: text/plain; 
	name=0001-Use-rev-list-reverse-in-git-rebase.sh.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0didonn
Content-Disposition: attachment; filename="0001-Use-rev-list-reverse-in-git-rebase.sh.txt"

RnJvbSAzOWM3OTJkZjgxYzI0MDA3ZWI0ZmNlYmY3NTg2ZjdjYTM1MjJjY2YyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDExIEFwciAyMDA3IDEwOjE1OjQwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gVXNlIHJl
di1saXN0IC0tcmV2ZXJzZSBpbiBnaXQtcmViYXNlLnNoCgphbmQgZHJvcCB0aGUgbGFzdCBwZXJs
IGRlcGVuZGVuY3kgaW4gdGhlIHNjcmlwdC4KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxy
YWEubGttbEBnbWFpbC5jb20+Ci0tLQogZ2l0LXJlYmFzZS5zaCB8ICAgIDMgKy0tCiAxIGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9n
aXQtcmViYXNlLnNoIGIvZ2l0LXJlYmFzZS5zaAppbmRleCAxZDk2ZjMyLi4yZGMyYzRmIDEwMDc1
NQotLS0gYS9naXQtcmViYXNlLnNoCisrKyBiL2dpdC1yZWJhc2Uuc2gKQEAgLTMzOSw4ICszMzks
NyBAQCBwcmV2X2hlYWQ9YGdpdC1yZXYtcGFyc2UgSEVBRF4wYAogZWNobyAiJHByZXZfaGVhZCIg
PiAiJGRvdGVzdC9wcmV2X2hlYWQiCiAKIG1zZ251bT0wCi1mb3IgY210IGluIGBnaXQtcmV2LWxp
c3QgLS1uby1tZXJnZXMgIiR1cHN0cmVhbSIuLk9SSUdfSEVBRCBcCi0JCQl8IEBAUEVSTEBAIC1l
ICdwcmludCByZXZlcnNlIDw+J2AKK2ZvciBjbXQgaW4gYGdpdC1yZXYtbGlzdCAtLXJldmVyc2Ug
LS1uby1tZXJnZXMgIiR1cHN0cmVhbSIuLk9SSUdfSEVBRGAKIGRvCiAJbXNnbnVtPSQoKCRtc2du
dW0gKyAxKSkKIAllY2hvICIkY210IiA+ICIkZG90ZXN0L2NtdC4kbXNnbnVtIgotLSAKMS41LjEu
MTQ3LmdiYWE1Cgo=
------=_Part_8744_4095971.1176279508038--
