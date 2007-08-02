From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix set_work_tree on cygwin
Date: Thu, 2 Aug 2007 17:25:58 +0200
Message-ID: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58642_19991554.1186068358650"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcYy-0003xf-8H
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbXHBP0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbXHBP0D
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:26:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:61800 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142AbXHBP0A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:26:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so356846ugf
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 08:25:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=He9qDrWq/9PkJtxRLE6AZukpdgG+Rn8X64kNcv/saV01GMJt5Cqo3U9yNCbdm9/HVBi50Wj5JlrAxc4GL/83z4qtC+eelxJe2GA2NgU5L4uBgppOTGLqJgRlBfNY9/sAy2MSxf2G7ckiyvSmZ4OAw54RSIY3/UxMOpv6Gz3bK9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=E0/BFPLW5Zd32JmD7Pt0BjNFrNVoIs1mi5bwQTC2lKTcoxggvac8YDr0MsZzGmUps0HHAOc4Yi+evHkIaINXEa6XUGsiM1mq4Se9MMYV6vWaVV1NuaykslJewW6jq/mivvFien+egweOW3MCtl6/nGJxl+TTI7Co/KNDKQZwjPU=
Received: by 10.78.132.2 with SMTP id f2mr585957hud.1186068358693;
        Thu, 02 Aug 2007 08:25:58 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 2 Aug 2007 08:25:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54562>

------=_Part_58642_19991554.1186068358650
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I don't know why, but for some unknown reason the buffer did not
contain zeros. This broke t1500-rev-parse.sh (the test for
GIT_DIR=../.git git rev-parse --show-prefix).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

It could be a memory corruption somewhere, but I really was
unable to find what could that, nor could I reproduce the problem
on a handy linux box.

 setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

------=_Part_58642_19991554.1186068358650
Content-Type: text/plain; name=0001-Fix-set_work_tree-on-cygwin.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4vei20y
Content-Disposition: attachment; filename="0001-Fix-set_work_tree-on-cygwin.txt"

RnJvbSBlNWU3YWRiN2RiMGQ5YzAwYTkzOGYzMjI4MTc3NGY2YTc1MzJiNDRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDIgQXVnIDIwMDcgMTY6MzM6MDIgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXggc2V0
X3dvcmtfdHJlZSBvbiBjeWd3aW4KCkkgZG9uJ3Qga25vdyB3aHksIGJ1dCBmb3Igc29tZSB1bmtu
b3duIHJlYXNvbiB0aGUgYnVmZmVyIGRpZCBub3QKY29udGFpbiB6ZXJvcy4gVGhpcyBicm9rZSB0
MTUwMC1yZXYtcGFyc2Uuc2ggKHRoZSB0ZXN0IGZvcgpHSVRfRElSPS4uLy5naXQgZ2l0IHJldi1w
YXJzZSAtLXNob3ctcHJlZml4KS4KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGtt
bEBnbWFpbC5jb20+Ci0tLQogc2V0dXAuYyB8ICAgIDMgKystCiAxIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zZXR1cC5jIGIvc2V0
dXAuYwppbmRleCAzNjUzMDkyLi4xYmViYTdlIDEwMDY0NAotLS0gYS9zZXR1cC5jCisrKyBiL3Nl
dHVwLmMKQEAgLTIwOSw3ICsyMDksOCBAQCBjb25zdCBjaGFyICpzZXRfd29ya190cmVlKGNvbnN0
IGNoYXIgKmRpcikKIAlsZW4gPSBzdHJsZW4oZGlyKTsKIAlpZiAobGVuID4gcG9zdGZpeF9sZW4g
JiYgIXN0cmNtcChkaXIgKyBsZW4gLSBwb3N0Zml4X2xlbiwKIAkJCQkiLyIgREVGQVVMVF9HSVRf
RElSX0VOVklST05NRU5UKSkgewotCQkJc3RybmNweShkaXJfYnVmZmVyLCBkaXIsIGxlbiAtIHBv
c3RmaXhfbGVuKTsKKwkJc3RybmNweShkaXJfYnVmZmVyLCBkaXIsIGxlbiAtIHBvc3RmaXhfbGVu
KTsKKwkJZGlyX2J1ZmZlcltsZW4gLSBwb3N0Zml4X2xlbl0gPSAnXDAnOwogCiAJCS8qIGFyZSB3
ZSBpbnNpZGUgdGhlIGRlZmF1bHQgd29yayB0cmVlPyAqLwogCQlyZWwgPSBnZXRfcmVsYXRpdmVf
Y3dkKGJ1ZmZlciwgc2l6ZW9mKGJ1ZmZlciksIGRpcl9idWZmZXIpOwotLSAKMS41LjMucmMzLjE0
NS5nNGQ5Y2RiCgo=
------=_Part_58642_19991554.1186068358650--
