From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH] branch: add support for --dry-run option
Date: Wed, 21 Jan 2015 20:37:23 -0500
Message-ID: <20150122013723.GA3795@odin.ulthar.us>
References: <1421480159-4848-1-git-send-email-kuleshovmail@gmail.com>
 <54BD12C3.5050802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="RnlQjJ0d97Da+TV1"
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 02:45:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE6q8-0005FT-5B
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 02:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbbAVBpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 20:45:41 -0500
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:34441 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900AbbAVBpj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2015 20:45:39 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jan 2015 20:45:39 EST
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
	by resqmta-po-07v.sys.comcast.net with comcast
	id ipdD1p00358ss0Y01pdUjx; Thu, 22 Jan 2015 01:37:28 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-po-14v.sys.comcast.net with comcast
	id ipdR1p00m2Ekl4801pdTRE; Thu, 22 Jan 2015 01:37:27 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.7/8.14.5) with ESMTP id t0M1bPsL003858;
	Wed, 21 Jan 2015 20:37:25 -0500
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.7/8.14.7/Submit) id t0M1bO43003857;
	Wed, 21 Jan 2015 20:37:24 -0500
Content-Disposition: inline
In-Reply-To: <54BD12C3.5050802@drmicha.warpmail.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1421890648;
	bh=UQMEeoc+rXKJOQbokjs9ZGbgjV6V43BnIxXSQ8dGOYo=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=bfQO9X4rURNwdhxMiDmRFTBidPJmPV2wK2XKn6N+FpJ58nfQIglTMJMF//l3PDciZ
	 93clQlXUv0H+hHmS7+Y1+OrPEHHtx0o+y8f7o8/GdkckI9vwftMWmwNLkyf1B+HhGA
	 /6nex3EfalTHSrEKjNjwj8taGsCx5v+opoggNsKzz6CJFTdH9fLVmFzHTJ4ER/ZnkH
	 eOAwffWBds3co2+sRQfLyPj/PIbyXvMrptrxGAVGslD8aCHGddcx31iTqWXnDtNsp8
	 VD95jTGatw7bBogizDpNdimcFZUhtjhiMRmO1ZS1iIITrbv6FKHnHu7xNGm0PcJHhC
	 xZh0wVNfkaKJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262791>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 03:20:51PM +0100, Michael J Gruber wrote:
> Alexander Kuleshov schrieb am 17.01.2015 um 08:35:
> > This patch adds support -d/--dry-run option for branch(es) deletion.
> > If -d/--dry-run option passed to git branch -d branch..., branch(es)
> > will not be removed, instead just print list of branches that are
> > to be removed.
> >=20
> > For example:
> >=20
> >     $ git branch
> >     a
> >     b
> >     c
> >     * master
> >=20
> >     $ git branch -d -n a b c
> >     delete branch 'a' (261c0d1)
> >     delete branch 'b' (261c0d1)
> >     delete branch 'c' (261c0d1)
>=20
> Is there a case where deleting "a b c" would not delete "a b c"?

Sure:
$ cd /tmp/
$ git init foo
Initialized empty Git repository in /tmp/foo/.git/
$ cd foo/
$ touch .gitignore
$ git add .gitignore=20
$ git commit -m init
[master (root-commit) fde5138] init
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
$ git checkout -b a
Switched to a new branch 'a'
$ git branch -d a
error: Cannot delete the branch 'a' which you are currently on.
$ touch file
$ git add file
$ git commit -m 'add file'
[a e2c2ece] add file
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file
$ git checkout -b b master
Switched to a new branch 'b'
$ git branch -d a
error: The branch 'a' is not fully merged.
If you are sure you want to delete it, run 'git branch -D a'.

--=20
Scott Schmit

--RnlQjJ0d97Da+TV1
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIPLwYJKoZIhvcNAQcCoIIPIDCCDxwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
DGAwggY0MIIEHKADAgECAgEeMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYD
VQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0
ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAe
Fw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUg
U2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0
ZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHCYPMzi3YGrEp
pC4Tq5a+ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0tsvVCk6U9
b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIqu54q
zHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX
9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/
4ebfeZuCYKzN2P8O2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8E
BTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIw
HwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsG
AQUFBzABhhtodHRwOi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wu
Y29tL3Nmc2NhLmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIB
FiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4IC
AQAKgwh9eKssBly4Y4xerhy5I3dNoXHYfYa8PlVLL/qtXnkFgdtY1o95CfegFJTwqBBmf8py
TUnFsukDFUI22zF5bVHzuJ+GxhnSqN2sD1qetbYwBYK2iyYA5Pg7Er1A+hKMIzEzcduRkIMm
CeUTyMyikfbUFvIBivtvkR8ZFAk22BZy+pJfAoedO61HTz4qSfQoCRcLN5A0t4DkuVhTMXIz
uQ8CnykhExD6x4e6ebIbrjZLb7L+ocR0y4YjCl/Pd4MXU91y0vTipgr/O75CDUHDRHCCKBVm
z/Rzkc/b970MEeHt5LC3NiWTgBSvrLEuVzBKM586YoRD9Dy3OHQgWI270g+5MYA8GfgI/EPT
5G7xPbCDz+zjdH89PeR3U4So4lSXur6H6vp+m9TQXPF3a0LwZrp8MQ+Z77U1uL7TelWO5lAp
sbAonrqASfTpaprFVkL4nyGH+NHST2ZJPWIBk81i6Vw0ny0qZW2Niy/QvVNKbb43A43ny076
khXO7cNbBIRdJ/6qQNq9Bqb5C0Q5nEsFcj75oxQRqlKf6TcvGbjxkJh8BYtv9ePsXklAxtm8
J7GCUBthHSQgepbkOexhJ0wP8imUkyiPHQ0GvEnd83129fZjoEhdGwXV27ioRKbj/cIq7JRX
un0NbeY+UdMYu9jGfIpDLtUUGSgsg2zMGs5R4jCCBiQwggUMoAMCAQICAwo/3zANBgkqhkiG
9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNV
BAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0
Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBMB4XDTE0MDYxNjAw
NDQ1NVoXDTE1MDYxNjE3MzYyNFowQDEbMBkGA1UEAwwSaS5ncm9rQGNvbWNhc3QubmV0MSEw
HwYJKoZIhvcNAQkBFhJpLmdyb2tAY29tY2FzdC5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC3HoziY3IySZbVkCfbjfgjTKO5CISA2+1GKzBNbzycTCXBWLnHvzrlFPlI
17z3noLux8ebSYz+TFiCUuVdwKkFOpN0WWxGzD6K/Hb0AJtKZp62YKtyRkCV51n5NrEepo28
hFkRhjgSkZA9t/4vtaWt0Ds8pIpUoQ1sNaUDWzjJ3UALl7m6b3XZmIouND+jq1AQv0ivMLuk
QNXO2a0KcuRVHDhAEdBvTi9LSePi8+Q8UWWBOeWmGhiKwL5X98Ne03GKxxQnLXDJbrX+cNcC
uaZIPdrmhbZCo+zegLfrApLRu9/6ox6/dnRsvmMpGcjNKLCgKoEh4cwyb+mhyzPXWlpXAgMB
AAGjggLYMIIC1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFKtASVM24m5BiMPABLNlKft1oxbCMB8GA1UdIwQYMBaA
FFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB0GA1UdEQQWMBSBEmkuZ3Jva0Bjb21jYXN0Lm5ldDCC
AUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFy
dENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3
YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVt
ZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUg
aW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9i
bGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9j
cnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRwOi8vb2Nz
cC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKGNmh0dHA6
Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNV
HRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQADggEBALTg
t4rndUh0up2qJuskCTx4iRQd59+R0kOm7vJa94t+fSa8Wip4WeVOJZaHs1XIp17yoLTzcXN9
+L5lTC7HaHrBGOdB8su0muQyS///XwbDgn3/9+D0stPJZYLMrfRSm/FzQEk5j5McmODTCq8a
tQrlQilnBDcY00CYKBTKGAleOPjQ8yg/QVb/uqNuKE88+mfEdc6AKykYg7VXqxdL54ylqR3o
P8+PsP1YgCE2wqWWfGUp6hxIKa2XGtqVdHqL1yc5equX97TiUiIQ51j+nmU8tXTuR7OPRA1B
cHA+jx6rchpnZMEJn9DYPFOvkkC86mxOCax9r5HOtdidcw8uZSoxggKXMIICkwIBATCBlDCB
jDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3Vy
ZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNz
IDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMKP98wCQYFKw4DAhoFAKCB2DAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTAxMjIwMTM3MjNa
MCMGCSqGSIb3DQEJBDEWBBQsHw9Di6w7vTDoSDzJktzp9ZVlmTB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAN
BgkqhkiG9w0BAQEFAASCAQBrGg4tdsrvymzac0rVWV7pai+C5r5i3ZRXUb0S/Ex+tRb2YkeB
9QOU3tb3/b6XTuWCe3j5jIhRIajhgV+U31uyT1kmMMKq2W3cHckKu0iZ+6b8czQlI3X4A2sE
cfxqaWXny3ME9ukWQq7JHxgNlHgUrH8fGbm2+B8bizCKn6ILCCTrP4flsh32d/K6DowjIF59
umWNfbXURV4BVpslKOvmjgZRpCXRv1AZMbxF77G+Tv3+wJXjv8UYgYetc17cGqxBfiVKvPzB
3lUjMTf/LRPu9CPUSSIUPhgtL5DkcptpL7EpRO9KpxZd7nvRnibUUXbpu2KdgRTOi1GEk9yK
k7qO

--RnlQjJ0d97Da+TV1--
