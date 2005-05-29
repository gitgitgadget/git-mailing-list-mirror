From: Mark Allen <mrallen1@yahoo.com>
Subject: [COGITO PATCH] Fix cg-log and cg-status for non-GNU sed/sort
Date: Sun, 29 May 2005 16:00:10 -0700 (PDT)
Message-ID: <20050529230011.30885.qmail@web41201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-776295570-1117407610=:30283"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon May 30 00:58:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcWjg-0002Xi-28
	for gcvg-git@gmane.org; Mon, 30 May 2005 00:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVE2XAn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVE2XAn
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:00:43 -0400
Received: from web41201.mail.yahoo.com ([66.218.93.34]:33140 "HELO
	web41201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261228AbVE2XAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:00:30 -0400
Received: (qmail 30950 invoked by uid 60001); 29 May 2005 23:00:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HVn1cacvdWGDYHx6zxNNvHvAo6Ml3iO5BH08z3Bh1qPggei02ynJlMcfS0PjmH/snJAAOvm1LDPaNLv6xuqohwp/oQRPs/XbnZ0EZUOx8OasCRGRLt/aaG0XjXiQ0BWw+ne8DauoKCtNInTHbyRB4vYSHkTi2fUdKaL6sHlCo9g=  ;
Received: from [66.41.38.150] by web41201.mail.yahoo.com via HTTP; Sun, 29 May 2005 16:00:10 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-776295570-1117407610=:30283
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Here're a couple of pretty simple patches against cg-log and cg-status (two cogito
commands I use a lot) for the non-GNU (or at least older, forked GNU) tools on Darwin.

There's also a non-GNU sed problem in cg-commit, but I haven't quite figured a good way
to tackle this issue yet. (The problem is in the regex stripping leading and trailing
newlines from $LOGMSG at line 170. Darwin's sed does not like the embedded curly braces,
but there's not a good simple way to rewrite this and retain the meaning of the "sedlet"
that tracks whether its seen any text yet.)

Cheers,

--Mark
--0-776295570-1117407610=:30283
Content-Type: application/octet-stream; name="cogito-non-gnu.patch"
Content-Transfer-Encoding: base64
Content-Description: 14121161-cogito-non-gnu.patch
Content-Disposition: attachment; filename="cogito-non-gnu.patch"

Ci0tLQpjb21taXQgZTQzZmM2NGIxZjc3OWIxZWNmMWJjYzM2ZTRmODlhOWY0
M2FiMmZiNgp0cmVlIDk1NzcwNjE2ZWRiZDQ5YzcxZGZmOWNhNmU1MWU3YWJm
NDQ5ZDM1ZTcKcGFyZW50IGQzNmVkMWZkMDExZDM0OWVhMmFkYzAwNDU2NzUw
YjViM2RhM2E5Y2QKYXV0aG9yIE1hcmsgQWxsZW4gPG1yYWxsZW4xQHlhaG9v
LmNvbT4gMTExNzQwNjY1MiAtMDUwMApjb21taXR0ZXIgTWFyayBBbGxlbiA8
bWFsbGVuQGFlcmlzLmxvY2FsPiAxMTE3NDA2NjUyIC0wNTAwCgogY2ctbG9n
ICAgIHwgICAxMyArKysrKy0tLS0tLS0tCiBjZy1zdGF0dXMgfCAgICAyICst
CiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkKCkluZGV4OiBjZy1sb2cKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gM2E2NWY1ZmI1MzM2N2M3NWY0Zjc2YWViZWQyN2E4M2Q4Njc5ZjA2OC9j
Zy1sb2cgIChtb2RlOjEwMDc1NSkKKysrIDk1NzcwNjE2ZWRiZDQ5YzcxZGZm
OWNhNmU1MWU3YWJmNDQ5ZDM1ZTcvY2ctbG9nICAobW9kZToxMDA3NTUpCkBA
IC0xNDgsMTAgKzE0OCwxMCBAQAogCQkJCWZpCiAKIAkJCQlkYXRlPSgke3Jl
c3QjKj4gfSkKLQkJCQlwZGF0ZT0iJChzaG93ZGF0ZSAkZGF0ZSkiCisJCQkJ
cGRhdGU9IiQoZGF0ZSAtdSAtciAkZGF0ZSkiCiAJCQkJaWYgWyAiJHBkYXRl
IiBdOyB0aGVuCi0JCQkJCWVjaG8gLW4gJGNvbG9yJGtleSAkcmVzdCB8IHNl
ZCAicy8+LiovPiAkcGRhdGUvIgotCQkJCQllY2hvICRjb2xkZWZhdWx0CisJ
CQkJCWVjaG8gLW4gJGNvbG9yJGtleSAkcmVzdCB8IHNlZCAicy8+LiovPiAk
cGRhdGUvIiAKKwkJCQkJZWNobyAtbiAkY29sZGVmYXVsdAogCQkJCWVsc2UK
IAkJCQkJZWNobyAkY29sb3Ika2V5ICRyZXN0ICRjb2xkZWZhdWx0CiAJCQkJ
ZmkKQEAgLTE2OCwxMSArMTY4LDggQEAKIAkJCQlpZiBbIC1uICIkbGlzdF9m
aWxlcyIgXTsgdGhlbgogCQkJCQlsaXN0X2NvbW1pdF9maWxlcyAiJHRyZWUx
IiAiJHRyZWUyIgogCQkJCWZpCi0JCQkJZWNobzsgc2VkIC1yZSAnCi0JCQkJ
CS8gKlNpZ25lZC1vZmYtYnk6LiovSXMvLyckY29sc2lnbm9mZicmJyRjb2xk
ZWZhdWx0Jy8KLQkJCQkJLyAqQWNrZWQtYnk6LiovSXMvLyckY29sc2lnbm9m
ZicmJyRjb2xkZWZhdWx0Jy8KLQkJCQkJcy8uLyAgICAmLwotCQkJCScKKwkJ
CQllY2hvOyBzZWQgLWUgIi8gKlNpZ25lZC1vZmYtYnk6Liovcy8gKlNpZ25l
ZC1vZmYtYnk6LiovJGNvbHNpZ25vZmYmJGNvbGRlZmF1bHQvIiAtZSIvICpB
Y2tlZC1ieTouKi9zLyAqQWNrZWQtYnk6LiovJGNvbHNpZ25vZmYmJGNvbGRl
ZmF1bHQvIiAtZSAicy8uLyAgICAmLyIKKwkJCQkKIAkJCQk7OwogCQkJKikK
IAkJCQllY2hvICRjb2xoZWFkZXIka2V5ICRyZXN0ICRjb2xkZWZhdWx0Cklu
ZGV4OiBjZy1zdGF0dXMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gM2E2
NWY1ZmI1MzM2N2M3NWY0Zjc2YWViZWQyN2E4M2Q4Njc5ZjA2OC9jZy1zdGF0
dXMgIChtb2RlOjEwMDc1NSkKKysrIDk1NzcwNjE2ZWRiZDQ5YzcxZGZmOWNh
NmU1MWU3YWJmNDQ5ZDM1ZTcvY2ctc3RhdHVzICAobW9kZToxMDA3NTUpCkBA
IC0xNSw3ICsxNSw3IEBACiAKIHsKIAlnaXQtbHMtZmlsZXMgLXogLXQgLS1v
dGhlcnMgLS1kZWxldGVkIC0tdW5tZXJnZWQgJEVYQ0xVREUKLX0gfCBzb3J0
IC16IC1rIDIgfCB4YXJncyAtMCBzaCAtYyAnCit9IHwgc29ydCAtdCAnXDAn
IC1rIDIgfCB4YXJncyAtMCBzaCAtYyAnCiB3aGlsZSBbICIkMSIgXTsgZG8K
IAl0YWc9JHsxJSAqfTsKIAlmaWxlbmFtZT0kezEjKiB9Owo=

--0-776295570-1117407610=:30283--
