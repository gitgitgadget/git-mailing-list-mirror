From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Avoid ActiveState Perl IO in t800[12]
Date: Mon, 5 Feb 2007 14:15:14 +0100
Message-ID: <81b0412b0702050515s7e0efe3fm76220a6c647dbee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_46196_12321629.1170681314180"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 14:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE3go-00039I-7i
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 14:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbXBENPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 08:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbXBENPS
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 08:15:18 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:43986 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbXBENPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 08:15:17 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1218377wra
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 05:15:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=QPZzeRiKOR6FqNl96tanpCtFTwki6U0jEN1NvxCUFOe7MWizpE4Rax80JPcExodv8ndP2PiaNpZTukl3DOjqqT9Es2fxC402rms6oQ8kKhOIpGPDSSYKRnuC+u4y5bjhGsaS2aZQtQsrEF1T7g28v/Q9AxLiQmk0pakcttL/Kog=
Received: by 10.78.172.20 with SMTP id u20mr1073077hue.1170681314376;
        Mon, 05 Feb 2007 05:15:14 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 5 Feb 2007 05:15:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38751>

------=_Part_46196_12321629.1170681314180
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Use sed instead, it comes with cygwin and there is almost no chance of
someone installing a sed with default CRLF lineendings by accident.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I have been seeing failures in the t800x tests from the beginning on, I
believe. Today they annoyed me enough to get them fixed.
The reason of the failures is the usual one: for reasons unexplainable
activestate perl defaults to CRLF lineendings in all output, which in the
testcase changes the whole file.

 t/annotate-tests.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

------=_Part_46196_12321629.1170681314180
Content-Type: text/plain; name=0001-Avoid-ActiveState-Perl-IO-in-t800-12.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_exsxfv9z
Content-Disposition: attachment; filename="0001-Avoid-ActiveState-Perl-IO-in-t800-12.txt"

RnJvbSBjMjQyYzdlYTA3ZDk4ZGRmYjQ1OTYxYjUyZjU5NzVkMDI5N2Y5NzgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDUgRmViIDIwMDcgMTQ6MDQ6MDkgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBdm9pZCBB
Y3RpdmVTdGF0ZSBQZXJsIElPIGluIHQ4MDBbMTJdCgpVc2Ugc2VkIGluc3RlYWQsIGl0IGNvbWVz
IHdpdGggY3lnd2luIGFuZCB0aGVyZSBpcyBhbG1vc3Qgbm8gY2hhbmNlIG9mCnNvbWVvbmUgaW5z
dGFsbGluZyBhIHNlZCB3aXRoIGRlZmF1bHQgQ1JMRiBsaW5lZW5kaW5ncyBieSBhY2NpZGVudC4K
ClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQoKSSBo
YXZlIGJlZW4gc2VlaW5nIGZhaWx1cmVzIGluIHRoZSB0ODAweCB0ZXN0cyBmcm9tIHRoZSBiZWdp
bm5pbmcgb24sIEkKYmVsaWV2ZS4gVG9kYXkgdGhleSBhbm5veWVkIG1lIGVub3VnaCB0byBnZXQg
dGhlbSBmaXhlZC4KVGhlIHJlYXNvbiBvZiB0aGUgZmFpbHVyZXMgaXMgdGhlIHVzdWFsIG9uZTog
Zm9yIHJlYXNvbnMgdW5leHBsYWluYWJsZQphY3RpdmVzdGF0ZSBwZXJsIGRlZmF1bHRzIHRvIENS
TEYgbGluZWVuZGluZ3MgaW4gYWxsIG91dHB1dCwgd2hpY2ggaW4gdGhlCnRlc3RjYXNlIGNoYW5n
ZXMgdGhlIHdob2xlIGZpbGUuCgogdC9hbm5vdGF0ZS10ZXN0cy5zaCB8ICAgIDMgKystCiAxIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90L2Fubm90YXRlLXRlc3RzLnNoIGIvdC9hbm5vdGF0ZS10ZXN0cy5zaAppbmRleCBiNWNlYmE0
Li44NzQwM2RhIDEwMDY0NAotLS0gYS90L2Fubm90YXRlLXRlc3RzLnNoCisrKyBiL3QvYW5ub3Rh
dGUtdGVzdHMuc2gKQEAgLTExMyw3ICsxMTMsOCBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKIAog
dGVzdF9leHBlY3Rfc3VjY2VzcyBcCiAgICAgJ3NvbWUgZWRpdCcgXAotICAgICdwZXJsIC1wIC1p
Lm9yaWcgLWUgInMvXjFBLipcbiQvLzsgcy9eM0EvOTkvIiBmaWxlICYmCisgICAgJ212IGZpbGUg
ZmlsZS5vcmlnICYmCisgICAgc2VkIC1lICJzL14zQS85OS8iIC1lICIvXjFBL2QiIDwgZmlsZS5v
cmlnID4gZmlsZSAmJgogICAgIEdJVF9BVVRIT1JfTkFNRT0iRCIgZ2l0IGNvbW1pdCAtYSAtbSAi
ZWRpdCInCiAKIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAotLSAKMS41LjAucmMzLjcyLmc0MDA1Cgo=

------=_Part_46196_12321629.1170681314180--
