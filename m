From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: [PATCH] git-p4: Fix sorting changelists when cloning a Perforce repository
Date: Mon, 13 Aug 2007 19:50:59 +0100
Message-ID: <3f4fd2640708131150r1d9fb02ai1f655a22658cb544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14277_28769858.1187031059084"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 20:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKf0r-0007Ji-Fo
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 20:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969648AbXHMSvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966318AbXHMSvF
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 14:51:05 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:2493 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S974328AbXHMSvB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 14:51:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1244660rvb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 11:50:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=rnK4uS6fWdCZ4SeG6ljZ6abuDtHQUzt76EyZbPXiNV2TfXEDLblV/aSP9/zvCBL6tnD7f4eCp38sZIWftt3IbrTh12WP6+z4l3i4/ju1fHSt7QkLNEtixjA9kzmL3D84l41agVmCkfaFKKfzBnR79i11q+NL3qk+yptJIXHNETM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=e0vrFSw9JZgJYkbnqcxBtc2I0UutydMdDxjWLlXNvM5g1gQBLRGcy5CP6lklWEqyFCbI6HrV23Y3R4mGAUq8uqcIWFN7cBTNhg9mjej10SPImPJFibuSM7bhtcDeGArKch3k1UUymQx8QK244xRPWkmZkVlDdcssyBXSag6HFcE=
Received: by 10.141.51.15 with SMTP id d15mr2323051rvk.1187031059097;
        Mon, 13 Aug 2007 11:50:59 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Mon, 13 Aug 2007 11:50:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55777>

------=_Part_14277_28769858.1187031059084
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

When performing a git-p4 clone operation on a Perforce repository,
where the changelists change in order of magnitude (e.g. 100 to 1000),
the set of changes to import from is not sorted properly. This is
because the data in the list is strings not integers. The other place
where this is done already converts the value to an integer, so it is
not affected.

This patch fixes this issue.

- Reece

------=_Part_14277_28769858.1187031059084
Content-Type: text/x-diff; 
	name=0001-git-p4-Fix-the-sorting-of-changelists-when-cloning.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f5bbd8di
Content-Disposition: attachment; filename="0001-git-p4-Fix-the-sorting-of-changelists-when-cloning.patch"

RnJvbSA4YzNkNWUyZDU4ODZiMzMwZDBkZmQxMzlmMDNiM2QxZmQ1MTIwN2Y1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZWVjZSBILiBEdW5uIDxtc2NscmhkQGdtYWlsLmNvbT4KRGF0
ZTogTW9uLCAxMyBBdWcgMjAwNyAxOTo0MDo1MCArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIGdpdC1w
NDogRml4IHRoZSBzb3J0aW5nIG9mIGNoYW5nZWxpc3RzIHdoZW4gY2xvbmluZyBhIFBlcmZvcmNl
IHJlcG9zaXRvcnkuCgotLS0KIGNvbnRyaWIvZmFzdC1pbXBvcnQvZ2l0LXA0IHwgICAgMiArLQog
MSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvY29udHJpYi9mYXN0LWltcG9ydC9naXQtcDQgYi9jb250cmliL2Zhc3QtaW1wb3J0L2dp
dC1wNAppbmRleCA4MDVkNjMyLi42ZDAxMDYyIDEwMDc1NQotLS0gYS9jb250cmliL2Zhc3QtaW1w
b3J0L2dpdC1wNAorKysgYi9jb250cmliL2Zhc3QtaW1wb3J0L2dpdC1wNApAQCAtMTMyMiw3ICsx
MzIyLDcgQEAgY2xhc3MgUDRTeW5jKENvbW1hbmQpOgogCiAgICAgICAgICAgICAgICAgZm9yIGxp
bmUgaW4gb3V0cHV0OgogICAgICAgICAgICAgICAgICAgICBjaGFuZ2VOdW0gPSBsaW5lLnNwbGl0
KCIgIilbMV0KLSAgICAgICAgICAgICAgICAgICAgY2hhbmdlcy5hcHBlbmQoY2hhbmdlTnVtKQor
ICAgICAgICAgICAgICAgICAgICBjaGFuZ2VzLmFwcGVuZChpbnQoY2hhbmdlTnVtKSkKIAogICAg
ICAgICAgICAgICAgIGNoYW5nZXMuc29ydCgpCiAKLS0gCjEuNS4xLjMKCg==
------=_Part_14277_28769858.1187031059084--
