From: Danny Lin <danny0838@gmail.com>
Subject: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Mon, 4 May 2015 14:13:56 +0800
Message-ID: <CAMbsUu4aCntGYW4iy+awx2WA89rUcPHZQYQFK0+FRyp9DQB6Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1146d04e8c3b6305153b772b
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 08:14:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp9dz-00078j-8M
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 08:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbbEDGN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 02:13:58 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35830 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbbEDGN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 02:13:57 -0400
Received: by qgej70 with SMTP id j70so61425224qge.2
        for <git@vger.kernel.org>; Sun, 03 May 2015 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=SZvfjRF4h8co2kevrTS8kyWArFsTvNu9Cqi79Kl0qmU=;
        b=nzuHhS47HF7/0nz+bVj7ZW0Pq9UEyxREiLWbqtDq8R0zbEiH197ZKs6n1fogxUKhUW
         +fAXVdKn2pJeZf0YpDlUIjiDfAvQ/Y2CwmKVRWP6stOu3T3EhcPR3Is/+ltkLH+VeOuv
         PcUb7PnCBSoPB1rlREJWJsVHO2l4zhXJ3ABYOC25Hx+1nxrhWGqJBOXOwSAp3WgpV7Hv
         /RNgFRd4VUhAdcEOO5l0zbXpmOv3Ji8wdWr7iAWJB/f36zHetYD8m5X9ID3iihUK9Mpq
         MiGVk61DKIxyxguBrE42OtXUx6vLceRCuCguNZsRCf/n5a66wcDGdSH8e4muI50jTz0a
         wpjg==
X-Received: by 10.55.23.96 with SMTP id i93mr41688036qkh.75.1430720036450;
 Sun, 03 May 2015 23:13:56 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Sun, 3 May 2015 23:13:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268305>

--001a1146d04e8c3b6305153b772b
Content-Type: text/plain; charset=UTF-8



--001a1146d04e8c3b6305153b772b
Content-Type: application/octet-stream; 
	name="0001-contrib-subtree-fix-linefeeds-trimming-for-cmd_split.patch"
Content-Disposition: attachment; 
	filename="0001-contrib-subtree-fix-linefeeds-trimming-for-cmd_split.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i99hrmpk0

RnJvbSBkYzU0OWI2YjRlYzM2ZjhmYWY5YzZmN2JiMWUzNDNlZjdiYWJkMTRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5ueSBMaW4gPGRhbm55MDgzOEBnbWFpbC5jb20+CkRhdGU6
IE1vbiwgNCBNYXkgMjAxNSAxNDowOTozOCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGNvbnRyaWIv
c3VidHJlZTogZml4IGxpbmVmZWVkcyB0cmltbWluZyBmb3IgY21kX3NwbGl0KCkKCmNtZF9zcGxp
dCgpIHByaW50cyB0aGUgaW5mbyBtZXNzYWdlIHVzaW5nICJzYXkgLW4iLCB3aGljaAptYWtlcyBu
byBzZW5zZSBhbmQgY291bGQgY2F1c2UgdGhlIGxpbmVmZWVkIGJlIHRyaW1tZWQgaW4Kc29tZSBj
YXNlcy4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUuCi0tLQogY29udHJpYi9zdWJ0cmVlL2dp
dC1zdWJ0cmVlLnNoIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9zdWJ0cmVlL2dpdC1zdWJ0cmVlLnNoIGIv
Y29udHJpYi9zdWJ0cmVlL2dpdC1zdWJ0cmVlLnNoCmluZGV4IGZhMWE1ODMuLjI4YTEzNzcgMTAw
NzU1Ci0tLSBhL2NvbnRyaWIvc3VidHJlZS9naXQtc3VidHJlZS5zaAorKysgYi9jb250cmliL3N1
YnRyZWUvZ2l0LXN1YnRyZWUuc2gKQEAgLTU5OSw3ICs1OTksNyBAQCBjbWRfc3BsaXQoKQogCWV2
YWwgIiRncmwiIHwKIAl3aGlsZSByZWFkIHJldiBwYXJlbnRzOyBkbwogCQlyZXZjb3VudD0kKCgk
cmV2Y291bnQgKyAxKSkKLQkJc2F5IC1uICIkcmV2Y291bnQvJHJldm1heCAoJGNyZWF0ZWNvdW50
KQ0iCisJCXNheSAiJHJldmNvdW50LyRyZXZtYXggKCRjcmVhdGVjb3VudCkiCiAJCWRlYnVnICJQ
cm9jZXNzaW5nIGNvbW1pdDogJHJldiIKIAkJZXhpc3RzPSQoY2FjaGVfZ2V0ICRyZXYpCiAJCWlm
IFsgLW4gIiRleGlzdHMiIF07IHRoZW4KLS0gCjIuMy43LndpbmRvd3MuMQoK
--001a1146d04e8c3b6305153b772b--
