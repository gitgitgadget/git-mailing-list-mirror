From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Add --verbose|-v to test-chmtime
Date: Thu, 30 Oct 2008 12:26:24 +0100
Message-ID: <81b0412b0810300426u2ccbe51at1bf5f989b6333ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24631_5025822.1225365984346"
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 12:27:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvVgk-00084w-G1
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 12:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbYJ3L01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbYJ3L01
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 07:26:27 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:27346 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbYJ3L00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 07:26:26 -0400
Received: by yx-out-2324.google.com with SMTP id 8so178501yxm.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=3b9sbwhviQKrxGoT55+gmrWLP7wZ04t/jX/1GoRj7Eo=;
        b=Ia6sanLbgr6M32OXejJ7PcKc84CcqKmTZMRVEu3XwFm7no4s37kXPAm5WqOKQcmQHZ
         wxTaHNVTghmnCH3GEc0o037QGzkIaz8GWrCwsDB9BqhjWEUKjyvGeWFK10gRnYlo00GW
         AFHrUK1qYID7zRgVn+bV3nmqIFFuk601iRUYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=xsNk/W1eW5FNnX44/uDz71XLq7KMxGsLHvhaRwso9xZnHxLEvs1nS7o3g2/zcNFOVr
         J3eouujfhN/wVmzst0QdKHmtN1umzqmYTEyib4AJMYnIL0q/3DZxGs+OPGGmcFnqQnkJ
         /JNU00nkMsTZ3laq6hFO86S0U4Gj6Vcsb7/kI=
Received: by 10.100.124.6 with SMTP id w6mr479918anc.80.1225365984369;
        Thu, 30 Oct 2008 04:26:24 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Thu, 30 Oct 2008 04:26:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99458>

------=_Part_24631_5025822.1225365984346
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This allows us replace perl when getting the mtime of a file because
of time zone conversions, though at the moment only one platform which
does this has been identified: Cygwin when used with ActiveState Perl
(as usual).

The output format is:

    <mtime1> TAB <filename1> <LF>
    <mtime2> TAB <filename2> <LF>
    ...

which, if only mtime is needed can be parsed with cut(1):

    test-chmtime -v +0 filename1 | cut -f 1

Also, the change adds a description of programs features, with examples.

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>
---
 test-chmtime.c |   91 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 70 insertions(+), 21 deletions(-)

------=_Part_24631_5025822.1225365984346
Content-Type: text/x-diff; name=0001-Add-verbose-v-to-test-chmtime.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmxb96p80
Content-Disposition: attachment;
 filename=0001-Add-verbose-v-to-test-chmtime.patch

RnJvbSBhNTlmMTcwMTNjYzU0MTEyZDBiZDExNTUwYjI3M2JhYTZlMzEyNzc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDMwIE9jdCAyMDA4IDEwOjAwOjI5ICswMTAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIEFk
ZCAtLXZlcmJvc2V8LXYgdG8gdGVzdC1jaG10aW1lCgpUaGlzIGFsbG93cyB1cyByZXBsYWNlIHBl
cmwgd2hlbiBnZXR0aW5nIHRoZSBtdGltZSBvZiBhIGZpbGUgYmVjYXVzZQpvZiB0aW1lIHpvbmUg
Y29udmVyc2lvbnMsIHRob3VnaCBhdCB0aGUgbW9tZW50IG9ubHkgb25lIHBsYXRmb3JtIHdoaWNo
CmRvZXMgdGhpcyBoYXMgYmVlbiBpZGVudGlmaWVkOiBDeWd3aW4gd2hlbiB1c2VkIHdpdGggQWN0
aXZlU3RhdGUgUGVybAooYXMgdXN1YWwpLgoKVGhlIG91dHB1dCBmb3JtYXQgaXM6CgogICAgPG10
aW1lMT4gVEFCIDxmaWxlbmFtZTE+IDxMRj4KICAgIDxtdGltZTI+IFRBQiA8ZmlsZW5hbWUyPiA8
TEY+CiAgICAuLi4KCndoaWNoLCBpZiBvbmx5IG10aW1lIGlzIG5lZWRlZCBjYW4gYmUgcGFyc2Vk
IHdpdGggY3V0KDEpOgoKICAgIHRlc3QtY2htdGltZSAtdiArMCBmaWxlbmFtZTEgfCBjdXQgLWYg
MQoKQWxzbywgdGhlIGNoYW5nZSBhZGRzIGEgZGVzY3JpcHRpb24gb2YgcHJvZ3JhbXMgZmVhdHVy
ZXMsIHdpdGggZXhhbXBsZXMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8YXJpZXNlbkBo
YXJtYW5iZWNrZXIuY29tPgotLS0KIHRlc3QtY2htdGltZS5jIHwgICA5MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFu
Z2VkLCA3MCBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0
LWNobXRpbWUuYyBiL3Rlc3QtY2htdGltZS5jCmluZGV4IDkwZGE0NDguLmQ1MzU4Y2IgMTAwNjQ0
Ci0tLSBhL3Rlc3QtY2htdGltZS5jCisrKyBiL3Rlc3QtY2htdGltZS5jCkBAIC0xLDM5ICsxLDgz
IEBACisvKgorICogVGhpcyBwcm9ncmFtIGNhbiBlaXRoZXIgY2hhbmdlIG1vZGlmaWNhdGlvbiB0
aW1lIG9mIHRoZSBnaXZlbgorICogZmlsZShzKSBvciBqdXN0IHByaW50IGl0LiBUaGUgcHJvZ3Jh
bSBkb2VzIG5vdCBjaGFuZ2UgYXRpbWUgbm9yCisgKiBjdGltZSAodGhlaXIgdmFsdWVzIGFyZSBl
eHBsaWNpdGVseSBwcmVzZXJ2ZWQpLgorICoKKyAqIFRoZSBtdGltZSBjYW4gYmUgY2hhbmdlZCB0
byBhbiBhYnNvbHV0ZSB2YWx1ZToKKyAqCisgKgl0ZXN0LWNobXRpbWUgPTxzZWNvbmRzPiBmaWxl
Li4uCisgKgorICogUmVsYXRpdmUgdG8gdGhlIGN1cnJlbnQgdGltZSBhcyByZXR1cm5lZCBieSB0
aW1lKDMpOgorICoKKyAqCXRlc3QtY2htdGltZSA9KzxzZWNvbmRzPiAob3IgPS08c2Vjb25kcz4p
IGZpbGUuLi4KKyAqCisgKiBPciByZWxhdGl2ZSB0byB0aGUgY3VycmVudCBtdGltZSBvZiB0aGUg
ZmlsZToKKyAqCisgKgl0ZXN0LWNobXRpbWUgPHNlY29uZHM+IGZpbGUuLi4KKyAqCXRlc3QtY2ht
dGltZSArPHNlY29uZHM+IChvciAtPHNlY29uZHM+KSBmaWxlLi4uCisgKgorICogRXhhbXBsZXM6
CisgKgorICogVG8ganVzdCBwcmludCB0aGUgbXRpbWUgdXNlIC0tdmVyYm9zZSBhbmQgc2V0IHRo
ZSBmaWxlIG10aW1lIG9mZnNldCB0byAwOgorICoKKyAqCXRlc3QtY2htdGltZSAtdiArMCBmaWxl
CisgKgorICogVG8gc2V0IHRoZSBtdGltZSB0byBjdXJyZW50IHRpbWU6CisgKgorICoJdGVzdC1j
aG10aW1lID0rMCBmaWxlCisgKgorICovCiAjaW5jbHVkZSAiZ2l0LWNvbXBhdC11dGlsLmgiCiAj
aW5jbHVkZSA8dXRpbWUuaD4KIAotc3RhdGljIGNvbnN0IGNoYXIgdXNhZ2Vfc3RyW10gPSAiKCt8
PXw9K3w9LXwtKTxzZWNvbmRzPiA8ZmlsZT4uLi4iOworc3RhdGljIGNvbnN0IGNoYXIgdXNhZ2Vf
c3RyW10gPSAiLXZ8LS12ZXJib3NlICgrfD18PSt8PS18LSk8c2Vjb25kcz4gPGZpbGU+Li4uIjsK
IAotaW50IG1haW4oaW50IGFyZ2MsIGNvbnN0IGNoYXIgKmFyZ3ZbXSkKK3N0YXRpYyBpbnQgdGlt
ZXNwZWNfYXJnKGNvbnN0IGNoYXIgKmFyZywgbG9uZyBpbnQgKnNldF90aW1lLCBpbnQgKnNldF9l
cSkKIHsKLQlpbnQgaTsKLQlpbnQgc2V0X2VxOwotCWxvbmcgaW50IHNldF90aW1lOwogCWNoYXIg
KnRlc3Q7Ci0JY29uc3QgY2hhciAqdGltZXNwZWM7Ci0KLQlpZiAoYXJnYyA8IDMpCi0JCWdvdG8g
dXNhZ2U7Ci0KLQl0aW1lc3BlYyA9IGFyZ3ZbMV07Ci0Jc2V0X2VxID0gKCp0aW1lc3BlYyA9PSAn
PScpID8gMSA6IDA7Ci0JaWYgKHNldF9lcSkgeworCWNvbnN0IGNoYXIgKnRpbWVzcGVjID0gYXJn
OworCSpzZXRfZXEgPSAoKnRpbWVzcGVjID09ICc9JykgPyAxIDogMDsKKwlpZiAoKnNldF9lcSkg
ewogCQl0aW1lc3BlYysrOwogCQlpZiAoKnRpbWVzcGVjID09ICcrJykgewotCQkJc2V0X2VxID0g
MjsgLyogcmVsYXRpdmUgImluIHRoZSBmdXR1cmUiICovCisJCQkqc2V0X2VxID0gMjsgLyogcmVs
YXRpdmUgImluIHRoZSBmdXR1cmUiICovCiAJCQl0aW1lc3BlYysrOwogCQl9CiAJfQotCXNldF90
aW1lID0gc3RydG9sKHRpbWVzcGVjLCAmdGVzdCwgMTApOworCSpzZXRfdGltZSA9IHN0cnRvbCh0
aW1lc3BlYywgJnRlc3QsIDEwKTsKIAlpZiAoKnRlc3QpIHsKLQkJZnByaW50ZihzdGRlcnIsICJO
b3QgYSBiYXNlLTEwIGludGVnZXI6ICVzXG4iLCBhcmd2WzFdICsgMSk7Ci0JCWdvdG8gdXNhZ2U7
CisJCWZwcmludGYoc3RkZXJyLCAiTm90IGEgYmFzZS0xMCBpbnRlZ2VyOiAlc1xuIiwgYXJnICsg
MSk7CisJCXJldHVybiAwOwogCX0KLQlpZiAoKHNldF9lcSAmJiBzZXRfdGltZSA8IDApIHx8IHNl
dF9lcSA9PSAyKSB7CisJaWYgKCgqc2V0X2VxICYmICpzZXRfdGltZSA8IDApIHx8ICpzZXRfZXEg
PT0gMikgewogCQl0aW1lX3Qgbm93ID0gdGltZShOVUxMKTsKLQkJc2V0X3RpbWUgKz0gbm93Owor
CQkqc2V0X3RpbWUgKz0gbm93OwogCX0KKwlyZXR1cm4gMTsKK30KKworaW50IG1haW4oaW50IGFy
Z2MsIGNvbnN0IGNoYXIgKmFyZ3ZbXSkKK3sKKwlzdGF0aWMgaW50IHZlcmJvc2U7CiAKLQlmb3Ig
KGkgPSAyOyBpIDwgYXJnYzsgaSsrKSB7CisJaW50IGkgPSAxOworCS8qIG5vIG10aW1lIGNoYW5n
ZSBieSBkZWZhdWx0ICovCisJaW50IHNldF9lcSA9IDA7CisJbG9uZyBpbnQgc2V0X3RpbWUgPSAw
OworCisJaWYgKGFyZ2MgPCAzKQorCQlnb3RvIHVzYWdlOworCisJaWYgKHN0cmNtcChhcmd2W2ld
LCAiLS12ZXJib3NlIikgPT0gMCB8fCBzdHJjbXAoYXJndltpXSwgIi12IikgPT0gMCkgeworCQl2
ZXJib3NlID0gMTsKKwkJKytpOworCX0KKwlpZiAodGltZXNwZWNfYXJnKGFyZ3ZbaV0sICZzZXRf
dGltZSwgJnNldF9lcSkpCisJCSsraTsKKwllbHNlCisJCWdvdG8gdXNhZ2U7CisKKwlmb3IgKDsg
aSA8IGFyZ2M7IGkrKykgewogCQlzdHJ1Y3Qgc3RhdCBzYjsKIAkJc3RydWN0IHV0aW1idWYgdXRi
OwogCkBAIC00Niw3ICs5MCwxMiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY29uc3QgY2hhciAqYXJn
dltdKQogCQl1dGIuYWN0aW1lID0gc2Iuc3RfYXRpbWU7CiAJCXV0Yi5tb2R0aW1lID0gc2V0X2Vx
ID8gc2V0X3RpbWUgOiBzYi5zdF9tdGltZSArIHNldF90aW1lOwogCi0JCWlmICh1dGltZShhcmd2
W2ldLCAmdXRiKSA8IDApIHsKKwkJaWYgKHZlcmJvc2UpIHsKKwkJCXVpbnRtYXhfdCBtdGltZSA9
IHV0Yi5tb2R0aW1lIDwgMCA/IDA6IHV0Yi5tb2R0aW1lOworCQkJcHJpbnRmKCIlIlBSSXVNQVgi
XHQlc1xuIiwgbXRpbWUsIGFyZ3ZbaV0pOworCQl9CisKKwkJaWYgKHV0Yi5tb2R0aW1lICE9IHNi
LnN0X210aW1lICYmIHV0aW1lKGFyZ3ZbaV0sICZ1dGIpIDwgMCkgewogCQkJZnByaW50ZihzdGRl
cnIsICJGYWlsZWQgdG8gbW9kaWZ5IHRpbWUgb24gJXM6ICVzXG4iLAogCQkJICAgICAgICBhcmd2
W2ldLCBzdHJlcnJvcihlcnJubykpOwogCQkJcmV0dXJuIC0xOwotLSAKMS42LjAuMy41NTIuZzRm
ZjczCgo=
------=_Part_24631_5025822.1225365984346--
