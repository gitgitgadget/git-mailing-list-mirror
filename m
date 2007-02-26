From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: [PATCH] blameview: Fix the browse behavior in blameview
Date: Mon, 26 Feb 2007 14:01:57 +0530
Message-ID: <cc723f590702260031v5b293125i489ecef957299760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_87238_21800317.1172478717064"
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 09:32:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLbHA-00061D-7a
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 09:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933799AbXBZIb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 03:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933798AbXBZIb7
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 03:31:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:53360 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933799AbXBZIb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 03:31:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1676278nfa
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 00:31:57 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=oXmDUTLASS67ejN00MhnmGyXXkQRfWa7ianKV1/ofiD7yMkka4XHl4EGsHCEC82SJqnxciIevhqDfkPEzkDvcKLW9ktAbZX3Dw7ezlOsX1eP0Z0VtCIYQzvjMopN3HfM2ore/xWGSUWzXrT3dBo/ST2XNmrG4lpDBLZKew3ehmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=UqBFKEvtN1/Un3l633LSvpmS2PinMZsASLB6KhVB0a2Oh13shGwacUSfpVjugqX2auZDEQYOcDd4r493JotD1DlAg+zavE6Ao9XZrukke9W8Hb4Z0ydTED+ep3NsJGfeqYlc5szg320vMOHNd4nySDpgMYgsuMNezE0R4956aLA=
Received: by 10.48.216.8 with SMTP id o8mr12124568nfg.1172478717095;
        Mon, 26 Feb 2007 00:31:57 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Mon, 26 Feb 2007 00:31:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40614>

------=_Part_87238_21800317.1172478717064
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



------=_Part_87238_21800317.1172478717064
Content-Type: text/x-patch; name=blameview.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eymnj1xv
Content-Disposition: attachment; filename="blameview.patch"

CldlIHdlIGRvdWJsZSBjbGljayB0aGUgbGluZSB3ZSBhY3R1YWxseSB3YW50ZWQgdG8gaG93IGhv
dyB0aGUKZmlsZSBsb29rZWQgYmVmb3JlIHRoZSBjaGFuZ2VzIHdhcyBhcHBsaWVkLgoKU2lnbmVk
LW9mZi1ieTogQW5lZXNoIEt1bWFyIEsuViA8YW5lZXNoLmt1bWFyQGdtYWlsLmNvbT4KLS0tCiBj
b250cmliL2JsYW1ldmlldy9ibGFtZXZpZXcucGVybCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbnRyaWIv
YmxhbWV2aWV3L2JsYW1ldmlldy5wZXJsIGIvY29udHJpYi9ibGFtZXZpZXcvYmxhbWV2aWV3LnBl
cmwKaW5kZXggYTlhNTA5Zi4uMWRlYzAwMSAxMDA3NTUKLS0tIGEvY29udHJpYi9ibGFtZXZpZXcv
YmxhbWV2aWV3LnBlcmwKKysrIGIvY29udHJpYi9ibGFtZXZpZXcvYmxhbWV2aWV3LnBlcmwKQEAg
LTQxLDcgKzQxLDcgQEAgJGZpbGV2aWV3LT5zZXRfcnVsZXNfaGludCgxKTsKICRmaWxldmlldy0+
c2lnbmFsX2Nvbm5lY3QgKHJvd19hY3RpdmF0ZWQgPT4gc3ViIHsKIAkJbXkgKCRzbCwgJHBhdGgs
ICRjb2x1bW4pID0gQF87CiAJCW15ICRyb3dfcmVmID0gJHNsLT5nZXRfcm93X2RhdGFfZnJvbV9w
YXRoICgkcGF0aCk7Ci0JCXN5c3RlbSgiYmxhbWV2aWV3IEAkcm93X3JlZlswXSAkZm4gJiIpOwor
CQlzeXN0ZW0oImJsYW1ldmlldyBAJHJvd19yZWZbMF1+MSAkZm4gJiIpOwogCQl9KTsKIAogbXkg
JGNvbW1pdHdpbmRvdyA9IEd0azI6OlNjcm9sbGVkV2luZG93LT5uZXcoKTsKLS0gCjEuNS4wLjEu
MjI3Lmc5OWQ0Mi1kaXJ0eQoK
------=_Part_87238_21800317.1172478717064--
