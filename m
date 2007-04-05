From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Thu, 5 Apr 2007 15:36:52 -0700
Message-ID: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59071_12479061.1175812612307"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaZf-0007W4-P2
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767374AbXDEWgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767381AbXDEWgz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:36:55 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:13812 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767376AbXDEWgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:36:53 -0400
Received: by nz-out-0506.google.com with SMTP id s1so403161nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:36:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=UuKCD3yosLlLKMg4BkgFtrnoh0cPkSliXMNPZZFQaBKepj9mfEF5Zeb31hecH2Qe12BRct6KipRd8ucqBm5p4htSR6K+a4g9MY/OPJbBk0aebY2eumaocTYgHeSW8NQWCaGV9ilkqPd2Byqy/qLhl2nkVa5tfYUlR4MyHjYvseE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=KXSpEJzY0KL2fyRnprQx/jKcW/mW8w5lNhUK6hWvOUCWNXmRkgbcEzH3dgLsdKTeaICEPjnlh90x0Po4K/tHOWtgLPBZXNLUv0COHWVlSaOiCQp+weRgyjB6R2iDiaxCp41D5Ygc1qNTCOdvmcYJxWlUZ/sqc6RLRUwtO+Af1ek=
Received: by 10.114.205.1 with SMTP id c1mr976310wag.1175812612351;
        Thu, 05 Apr 2007 15:36:52 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:36:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43872>

------=_Part_59071_12479061.1175812612307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59071_12479061.1175812612307
Content-Type: text/plain; name="0009-drop-objects-larger-than-blob-limit-if-specified.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0009-drop-objects-larger-than-blob-limit-if-specified.patch.txt"
X-Attachment-Id: f_f05sgomt

RnJvbSA2MjUzMmRlMmE4YzE5Y2E4ZDhiZmIyZTRiYzAyYmZmMzliY2M3Y2E4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTQ6MDY6MDUgLTA3MDAKU3ViamVjdDogW1BBVENIIDA5
LzEzXSBkcm9wIG9iamVjdHMgbGFyZ2VyIHRoYW4gLS1ibG9iLWxpbWl0IGlmIHNwZWNpZmllZAoK
LS0tCiBidWlsdGluLXBhY2stb2JqZWN0cy5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEg
aW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9idWlsdGluLXBhY2st
b2JqZWN0cy5jIGIvYnVpbHRpbi1wYWNrLW9iamVjdHMuYwppbmRleCAzN2IwMTUwLi5jY2MyZDE1
IDEwMDY0NAotLS0gYS9idWlsdGluLXBhY2stb2JqZWN0cy5jCisrKyBiL2J1aWx0aW4tcGFjay1v
YmplY3RzLmMKQEAgLTExMTYsNiArMTExNiw3IEBAIHN0YXRpYyB2b2lkIGNoZWNrX29iamVjdChz
dHJ1Y3Qgb2JqZWN0X2VudHJ5ICplbnRyeSkKIAl9CiAKIAllbnRyeS0+dHlwZSA9IHNoYTFfb2Jq
ZWN0X2luZm8oZW50cnktPnNoYTEsICZlbnRyeS0+c2l6ZSk7CisJbnJfc2tpcHBlZCArPSBlbnRy
eS0+bm9fd3JpdGUgPSBibG9iX2xpbWl0ICYmICh1bnNpZ25lZCBsb25nKWVudHJ5LT5zaXplID49
IGJsb2JfbGltaXQ7CiAJaWYgKGVudHJ5LT50eXBlIDwgMCkKIAkJZGllKCJ1bmFibGUgdG8gZ2V0
IHR5cGUgb2Ygb2JqZWN0ICVzIiwKIAkJICAgIHNoYTFfdG9faGV4KGVudHJ5LT5zaGExKSk7Ci0t
IAoxLjUuMS5yYzIuMTguZzljODgtZGlydHkKCg==
------=_Part_59071_12479061.1175812612307--
