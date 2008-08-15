From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix t3700 on filesystems which do not support question marks in names
Date: Fri, 15 Aug 2008 09:11:23 +0200
Message-ID: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_114463_30129071.1218784283795"
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Kevin Ballard" <kevin@sb.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 09:12:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTtU8-0001ZJ-49
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 09:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbYHOHLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 03:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbYHOHLZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 03:11:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:51643 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYHOHLY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 03:11:24 -0400
Received: by wa-out-1112.google.com with SMTP id j37so438726waf.23
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=fcIyDJUAuVEg9oOtOLQmGfX+T4jmOfKYUc0f/8OJJEg=;
        b=PNj7ZA2ewgCWdKhHJWHRvUHDxHxyEyDeyZQt9jXFW2aY8SJnyr4hmksZEtxTBV232e
         F44HceffhhWDIZnzaZgd6/Bsx1LkyRObMZR7N1qClxAl3QDBTPin3dDEpAjL2FGt7fFG
         8RtpyMqS83pgKMrn6E0u37fo/N9S5YznoZY/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=CYTA6en7tEsF1O2DW5bemFj8AQA2G4ewdbY9YoEtwsRjcqYmik2873ug8P1knY7MoN
         w0XXKtHHZHGk+KyAuFFPFvsnHMit/jPl4LZo2Htf9B7zyWaT+d52XzHmbO+gB4zVIlK0
         8RCNeQEiIl9WIndTU8Jt7KpI3nVKvptbeqZP0=
Received: by 10.114.26.18 with SMTP id 18mr2192004waz.162.1218784283787;
        Fri, 15 Aug 2008 00:11:23 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Fri, 15 Aug 2008 00:11:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92460>

------=_Part_114463_30129071.1218784283795
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

And the prominent example of the deficiency are, as usual, the filesystems
of Microsoft house.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t3700-add.sh |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

------=_Part_114463_30129071.1218784283795
Content-Type: text/x-patch;
 name=0001-Fix-t3700-on-filesystems-which-do-not-support-questi.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fjwgk9gf0
Content-Disposition: attachment;
 filename=0001-Fix-t3700-on-filesystems-which-do-not-support-questi.patch

RnJvbSAyZTViYmZlYTZhM2VlNmZmOGNmODI1OTljZWMwZTQ5ZGU5NGQwNjMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBGcmksIDE1IEF1ZyAyMDA4IDA5OjAwOjU0ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IHQz
NzAwIG9uIGZpbGVzeXN0ZW1zIHdoaWNoIGRvIG5vdCBzdXBwb3J0IHF1ZXN0aW9uIG1hcmtzIGlu
IG5hbWVzCgpBbmQgdGhlIHByb21pbmVudCBleGFtcGxlIG9mIHRoZSBkZWZpY2llbmN5IGFyZSwg
YXMgdXN1YWwsIHRoZSBmaWxlc3lzdGVtcwpvZiBNaWNyb3NvZnQgaG91c2UuCgpTaWduZWQtb2Zm
LWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgotLS0KIHQvdDM3MDAtYWRkLnNo
IHwgICAxOSArKysrKysrKysrKystLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdC90MzcwMC1hZGQuc2ggYi90L3Qz
NzAwLWFkZC5zaAppbmRleCA3N2E3ODJjLi4yZmE5MDdlIDEwMDc1NQotLS0gYS90L3QzNzAwLWFk
ZC5zaAorKysgYi90L3QzNzAwLWFkZC5zaApAQCAtMjIyLDEyICsyMjIsMTcgQEAgdGVzdF9leHBl
Y3Rfc3VjY2VzcyAnZ2l0IGFkZCAoYWRkLmlnbm9yZS1lcnJvcnMgPSBmYWxzZSknICcKIAkhICgg
Z2l0IGxzLWZpbGVzIGZvbzEgfCBncmVwIGZvbzEgKQogJwogCi10ZXN0X2V4cGVjdF9zdWNjZXNz
ICdnaXQgYWRkICdcJydmb1w/YmFyJ1wnJyBpZ25vcmVzIGZvb2JhcicgJwotCWdpdCByZXNldCAt
LWhhcmQgJiYKLQl0b3VjaCBmb1w/YmFyIGZvb2JhciAmJgotCWdpdCBhZGQgJ1wnJ2ZvXD9iYXIn
XCcnICYmCi0JZ2l0IGxzLWZpbGVzIGZvXD9iYXIgfCBncmVwIC1GIGZvXD9iYXIgJiYKLQkhICgg
Z2l0IGxzLWZpbGVzIGZvb2JhciB8IGdyZXAgZm9vYmFyICkKLScKK2lmIHRvdWNoIGZvXD9iYXIK
K3RoZW4KKwl0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgYWRkICdcJydmb1w/YmFyJ1wnJyBpZ25v
cmVzIGZvb2JhcicgJworCQlnaXQgcmVzZXQgLS1oYXJkICYmCisJCXRvdWNoIGZvb2JhciAmJgor
CQlnaXQgYWRkICdcJydmb1w/YmFyJ1wnJyAmJgorCQlnaXQgbHMtZmlsZXMgZm9cP2JhciB8IGdy
ZXAgLUYgZm9cP2JhciAmJgorCQkhICggZ2l0IGxzLWZpbGVzIGZvb2JhciB8IGdyZXAgZm9vYmFy
ICkKKwknCitlbHNlCisJc2F5ICJUaGUgZmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0ID8gaW4g
bmFtZXMsIHNvbWUgdGVzdHMgc2tpcHBlZCIKK2ZpCiAKIHRlc3RfZG9uZQotLSAKMS42LjAucmMy
LjY4Lmc0OWZhMwoK
------=_Part_114463_30129071.1218784283795--
