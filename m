From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 08/13] prevent try_delta from using objects not in pack
Date: Thu, 5 Apr 2007 15:35:12 -0700
Message-ID: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59059_29179840.1175812512503"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaY3-00071d-FA
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767373AbXDEWfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767377AbXDEWfP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:35:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:25938 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767373AbXDEWfN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:35:13 -0400
Received: by wr-out-0506.google.com with SMTP id 71so466354wri
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:35:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=lVw8+XJDbFdbCsHM7MfDkV/4iupr+NoJ1L3BIO9ZYmkddaeO90HIbH1dmb0Rkf3Bfix3uTK+1eRaaVXVojBMxQMN21CIot/hQ3jUGV63EkrUW4QgyS6OJ5YCzSuW8e7Lsp/eVc2CsbavPeFn9hIc28CmdqREnvNXuY1tqJg45EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=sxaXeawh5hPX8NqWO8lMy69Ff+arXS5K29vdlR2mb+50LjfA3it1LCDeCHhV6sEcuVHUl3LZhqBdEr0dCgGVpIM/3q1Hba0ZVZQ9y8nsmYOQ4w/hsQcHJUW9bqgHcpvD3aEj4DYld5qHA1HGeYWXPpWCCDO/KmHaNL5/gMlsT/U=
Received: by 10.114.131.2 with SMTP id e2mr963245wad.1175812512549;
        Thu, 05 Apr 2007 15:35:12 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:35:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43871>

------=_Part_59059_29179840.1175812512503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59059_29179840.1175812512503
Content-Type: text/plain; name="0008-prevent-try_delta-from-using-objects-not-in-pack.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0008-prevent-try_delta-from-using-objects-not-in-pack.patch.txt"
X-Attachment-Id: f_f05seh0n

RnJvbSA3ZDUxMGY4MmIxZTZhY2NjYzI1NTk2MDUyYWJmM2M1ZjE5NjFlYmNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTQ6MDQ6NTkgLTA3MDAKU3ViamVjdDogW1BBVENIIDA4
LzEzXSBwcmV2ZW50IHRyeV9kZWx0YSBmcm9tIHVzaW5nIG9iamVjdHMgbm90IGluIHBhY2sKCi0t
LQogYnVpbHRpbi1wYWNrLW9iamVjdHMuYyB8ICAgIDQgKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1wYWNr
LW9iamVjdHMuYyBiL2J1aWx0aW4tcGFjay1vYmplY3RzLmMKaW5kZXggOWViNWZkNi4uMzdiMDE1
MCAxMDA2NDQKLS0tIGEvYnVpbHRpbi1wYWNrLW9iamVjdHMuYworKysgYi9idWlsdGluLXBhY2st
b2JqZWN0cy5jCkBAIC0xMjUxLDYgKzEyNTEsMTAgQEAgc3RhdGljIGludCB0cnlfZGVsdGEoc3Ry
dWN0IHVucGFja2VkICp0cmcsIHN0cnVjdCB1bnBhY2tlZCAqc3JjLAogCWlmICh0cmdfZW50cnkt
PnR5cGUgIT0gc3JjX2VudHJ5LT50eXBlKQogCQlyZXR1cm4gLTE7CiAKKwkvKiBEb24ndCB0cnkg
ZGVsdGFzIGludm9sdmluZyBhbHJlYWR5L25vbiB3cml0dGVuIG9iamVjdHMgKi8KKwlpZiAodHJn
X2VudHJ5LT5ub193cml0ZSB8fCBzcmNfZW50cnktPm5vX3dyaXRlKQorCQlyZXR1cm4gLTE7CisK
IAkvKiBXZSBkbyBub3QgY29tcHV0ZSBkZWx0YSB0byAqY3JlYXRlKiBvYmplY3RzIHdlIGFyZSBu
b3QKIAkgKiBnb2luZyB0byBwYWNrLgogCSAqLwotLSAKMS41LjEucmMyLjE4Lmc5Yzg4LWRpcnR5
Cgo=
------=_Part_59059_29179840.1175812512503--
