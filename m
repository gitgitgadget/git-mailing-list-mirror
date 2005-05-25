From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] Make tests more portable
Date: Tue, 24 May 2005 21:52:28 -0700 (PDT)
Message-ID: <20050525045229.29706.qmail@web41205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2032473658-1116996748=:28010"
X-From: git-owner@vger.kernel.org Wed May 25 06:52:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DanrG-0000Z5-Sa
	for gcvg-git@gmane.org; Wed, 25 May 2005 06:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVEYEwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 00:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVEYEwk
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 00:52:40 -0400
Received: from web41205.mail.yahoo.com ([66.218.93.38]:35730 "HELO
	web41205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262255AbVEYEwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 00:52:30 -0400
Received: (qmail 29708 invoked by uid 60001); 25 May 2005 04:52:29 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=cPgmh1a7amoYMRD0kWGgF7Dhxb5QIBR2Nj90/Toc0kXJFlMFXjkO9q8VfKknYliyLwMmp6o/iof6HQqsQWeNoGhYccsCV8t6J7+XQ6a8O2qxygsRTDpqhZceQGzlNdDE5nVbE0VjUgMt/j2OVrIVePnTekSdcQsfHPcU37i7Tno=  ;
Received: from [209.98.144.212] by web41205.mail.yahoo.com via HTTP; Tue, 24 May 2005 21:52:28 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-2032473658-1116996748=:28010
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

I made some minor changes to the test suite to make the tests more portable.  The sed on
Darwin doesn't understand extended regex, cmp won't read from '-', and xargs doesn't have
an '-r' command line flag.

The t3000 test was broken because it wasn't updated when Linus merged Junio's patch to
make git-ls-files show filenames with leading dots.  I fixed that with a trivial
addition. 

Cheers,

--Mark

--0-2032473658-1116996748=:28010
Content-Type: application/octet-stream; name="git-tests.patch"
Content-Transfer-Encoding: base64
Content-Description: 3636773645-git-tests.patch
Content-Disposition: attachment; filename="git-tests.patch"

TWFrZSB0MDAwMC1iYXNpYy5zaCBhbmQgdDAxMTAtZW52aXJvbm1lbnQtbmFt
ZXMtb2xkLnNoIG1vcmUgcG9ydGFibGUuCkZpeCB0MzAwMC1scy1maWxlcy1v
dGhlcnMgdG8gcGljayB1cCBmaWxlbmFtZXMgdGhhdCBzdGFydCB3aXRoIGRv
dHMuCgotLS0KY29tbWl0IDM2YzNlNzhiNTVkNjc0MDIwMTI5NmFhZGQzMjQz
MGMwMjEyYWQwYmYKdHJlZSBiMTdlYWRmMzUxZjRkMmE5YzdmODg1MTg2MzE4
OGRkYjhlOWUzYzVhCnBhcmVudCBjNGVlMjk1MmIzMTQ2ZmU3ZGM5NDMzYjky
YmYwNjZlNTU5ODdlZjc0CmF1dGhvciBNYXJrIEFsbGVuIDxtYWxsZW5AYWVy
aXMubG9jYWw+IDExMTY5OTYyMzAgLTA1MDAKY29tbWl0dGVyIE1hcmsgQWxs
ZW4gPG1hbGxlbkBhZXJpcy5sb2NhbD4gMTExNjk5NjIzMCAtMDUwMAoKIHQw
MDAwLWJhc2ljLnNoICAgICAgICAgICAgICAgICB8ICAgIDIgKy0KIHQwMTEw
LWVudmlyb25tZW50LW5hbWVzLW9sZC5zaCB8ICAgIDYgKystLS0tCiB0MzAw
MC1scy1maWxlcy1vdGhlcnMuc2ggICAgICAgfCAgICAxICsKIDMgZmlsZXMg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zLCA1IGRlbGV0aW9ucwoKSW5kZXg6IHQv
dDAwMDAtYmFzaWMuc2gKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gMGE2
ZGQxMTRmM2NiZDE5ZmM5NzczZGMzMWYxOWMyMWI1OTAwNzgwMC90L3QwMDAw
LWJhc2ljLnNoICAobW9kZToxMDA3NTUpCisrKyBiMTdlYWRmMzUxZjRkMmE5
YzdmODg1MTg2MzE4OGRkYjhlOWUzYzVhL3QvdDAwMDAtYmFzaWMuc2ggICht
b2RlOjEwMDc1NSkKQEAgLTg0LDcgKzg0LDcgQEAKIGRvbmUKIHRlc3RfZXhw
ZWN0X3N1Y2Nlc3MgXAogICAgICdhZGRpbmcgdmFyaW91cyB0eXBlcyBvZiBv
YmplY3RzIHdpdGggZ2l0LXVwZGF0ZS1jYWNoZSAtLWFkZC4nIFwKLSAgICAn
ZmluZCBwYXRoKiAhIC10eXBlIGQgLXByaW50MCB8IHhhcmdzIC0wIC1yIGdp
dC11cGRhdGUtY2FjaGUgLS1hZGQnCisgICAgJ2ZpbmQgcGF0aCogISAtdHlw
ZSBkIC1wcmludDAgfCB4YXJncyAtMCBnaXQtdXBkYXRlLWNhY2hlIC0tYWRk
JwogCiAjIFNob3cgdGhlbSBhbmQgc2VlIHRoYXQgbWF0Y2hlcyB3aGF0IHdl
IGV4cGVjdC4KIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXApJbmRleDogdC90MDEx
MC1lbnZpcm9ubWVudC1uYW1lcy1vbGQuc2gKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQotLS0gMGE2ZGQxMTRmM2NiZDE5ZmM5NzczZGMzMWYxOWMyMWI1OTAw
NzgwMC90L3QwMTEwLWVudmlyb25tZW50LW5hbWVzLW9sZC5zaCAgKG1vZGU6
MTAwNzU1KQorKysgYjE3ZWFkZjM1MWY0ZDJhOWM3Zjg4NTE4NjMxODhkZGI4
ZTllM2M1YS90L3QwMTEwLWVudmlyb25tZW50LW5hbWVzLW9sZC5zaCAgKG1v
ZGU6MTAwNzU1KQpAQCAtODYsOCArODYsNyBAQAogRU9GCiB0ZXN0X2V4cGVj
dF9zdWNjZXNzIFwKICAgICAndmVyaWZ5IG9sZCBBVVRIT1IgdmFyaWFibGVz
IHdlcmUgdXNlZCBjb3JyZWN0bHkgaW4gY29tbWl0JyBcCi0gICAgJ3NlZCAt
bmUgJ1wnJy9eXChhdXRob3JcfGNvbW1pdHRlclwpL3N8Pi4qfD58cCdcJycg
Y3VycmVudCB8Ci0gICAgIGNtcCAtIGV4cGVjdGVkJworICAgICdzZWQgLW5l
ICdcJycvXlwoYXV0aG9yXCkvc3w+Lip8PnxwJ1wnJyAtZSdcJycvXlwoY29t
bWl0dGVyXCkvc3w+Lip8PnxwJ1wnJ1wgICAgY3VycmVudCA+IG91dCAmJiBj
bXAgb3V0IGV4cGVjdGVkJwogCiB1bnNldCBHSVRfRElSCiB0ZXN0X2V4cGVj
dF9zdWNjZXNzIFwKQEAgLTEyOCw3ICsxMjcsNiBAQAogRU9GCiB0ZXN0X2V4
cGVjdF9zdWNjZXNzIFwKICAgICAndmVyaWZ5IG5ldyBBVVRIT1IgdmFyaWFi
bGVzIHdlcmUgdXNlZCBjb3JyZWN0bHkgaW4gY29tbWl0LicgXAotICAgICdz
ZWQgLW5lICdcJycvXlwoYXV0aG9yXHxjb21taXR0ZXJcKS9zfD4uKnw+fHAn
XCcnIGN1cnJlbnQgfAotICAgICBjbXAgLSBleHBlY3RlZCcKKyAgICAnc2Vk
IC1uZSAnXCcnL15cKGF1dGhvclwpL3N8Pi4qfD58cCdcJycgLWUnXCcnL15c
KGNvbW1pdHRlclwpL3N8Pi4qfD58cCdcJydcICAgIGN1cnJlbnQgPiBvdXQg
JiYgY21wIG91dCBleHBlY3RlZCcKIAogdGVzdF9kb25lCkluZGV4OiB0L3Qz
MDAwLWxzLWZpbGVzLW90aGVycy5zaAo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSAwYTZkZDExNGYzY2JkMTlmYzk3NzNkYzMxZjE5YzIxYjU5MDA3ODAw
L3QvdDMwMDAtbHMtZmlsZXMtb3RoZXJzLnNoICAobW9kZToxMDA3NTUpCisr
KyBiMTdlYWRmMzUxZjRkMmE5YzdmODg1MTg2MzE4OGRkYjhlOWUzYzVhL3Qv
dDMwMDAtbHMtZmlsZXMtb3RoZXJzLnNoICAobW9kZToxMDA3NTUpCkBAIC0y
Miw2ICsyMiw3IEBACiAgICAgJ2dpdC1scy1maWxlcyAtLW90aGVycyB0byBz
aG93IG91dHB1dC4nIFwKICAgICAnZ2l0LWxzLWZpbGVzIC0tb3RoZXJzID4u
b3V0cHV0JwogY2F0ID4uZXhwZWN0ZWQgPDxFT0YKKy5vdXRwdXQKIHBhdGgw
CiBwYXRoMQogcGF0aDIvZmlsZTIK

--0-2032473658-1116996748=:28010--
