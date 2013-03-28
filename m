From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Subject: Re: [PATCH] use refnames instead of "left"/"right" in dirdiffs
Date: Thu, 28 Mar 2013 13:46:16 +0100
Message-ID: <1364474776.11891.9.camel@heisenberg.scientia.net>
References: <1364422397.8091.1.camel@heisenberg.scientia.net>
	 <20130327230715.GU2286@serenity.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha512";
	protocol="application/x-pkcs7-signature";
	boundary="=-lMUddG51NGeJSHgxCs2/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 28 13:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCEK-0000bO-Hs
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 13:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab3C1Mq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 08:46:27 -0400
Received: from mailgw02.dd24.net ([193.46.215.43]:51028 "EHLO
	mailgw02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab3C1Mq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 08:46:26 -0400
Received: from localhost (amavis02.dd24.net [192.168.1.113])
	by mailgw02.dd24.net (Postfix) with ESMTP id 463F83569DB
	for <git@vger.kernel.org>; Thu, 28 Mar 2013 12:46:23 +0000 (GMT)
X-Virus-Scanned: domaindiscount24.com mail filter gateway
Received: from mailgw02.dd24.net ([192.168.1.197])
	by localhost (amavis02.dd24.net [192.168.1.106]) (amavisd-new, port 10197)
	with ESMTP id smXTp08u3vx2 for <git@vger.kernel.org>;
	Thu, 28 Mar 2013 12:46:17 +0000 (GMT)
Received: from [10.153.238.27] (unknown [141.84.43.125])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mailgw02.dd24.net (Postfix) with ESMTPSA id 62EBB35681E
	for <git@vger.kernel.org>; Thu, 28 Mar 2013 12:46:17 +0000 (GMT)
In-Reply-To: <20130327230715.GU2286@serenity.lan>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219384>


--=-lMUddG51NGeJSHgxCs2/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John.


On Wed, 2013-03-27 at 23:07 +0000, John Keeping wrote:=20
> That's not going to work well on Windows, is it?
Uhm Winwhat? No seriously... doesn't dir-diff fail ther anway? The mkdir
right now also uses mkpath with "/"... and I could read in it's
documentation that it would automatically translate this, does it?

>  Anything with two dots
> in is already forbidden so we don't need to worry about that
Sure about this? I mean they're forbidden as refnames, but is this
really checked within git-difftool before?

> ; I'm not
> sure we need to remove forward slashes at all
Mhh could be... seems that the cleanup happens via completely removing
the $tmpdir path.
And for the actual diff it shouldn't matter when there's a partentdir
more.


>  until we consider the
> "commit containing" syntax ':/fix nasty bug' or 'master^{/fix bug}'.
Phew... don't ask me... I'm not that into the git source code... from
the filename side, these shouldn't bother, only / an NUL is forbidden
(in POSIX,... again I haven't checked win/mac which might not adhere to
the standards).

> I'm more concerned with specifiers containing '^', '@', '{', ':' - see
> 'SPECIFYING REVISIONS' in git-rev-parse(1) for the full details of
> what's acceptable.
Mhh there are likely more problems... I just noted that $ldir/$rdir are
used in a call to system() so... that needs to be shell escaped to
prevent any bad stuff
And if perl (me not a perl guy) interprets any such characters specially
in strings, it must be handled either.

> At some point I think it may be better to fall back
> to the SHA1 of the relevant commit.
Think that would be quite a drawback...

Cheers,
Chris.

--=-lMUddG51NGeJSHgxCs2/
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCCEP4w
ggV1MIIDXaADAgECAgMBAYIwDQYJKoZIhvcNAQEFBQAwVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4x
HjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMg
Um9vdDAeFw0xMjA3MjMxNDU2NDVaFw0xNDA3MjMxNDU2NDVaMHwxITAfBgNVBAMTGENocmlzdG9w
aCBBbnRvbiBNaXR0ZXJlcjEkMCIGCSqGSIb3DQEJARYVY2FsZXN0eW9Ac2NpZW50aWEubmV0MTEw
LwYJKoZIhvcNAQkBFiJtYWlsQGNocmlzdG9waC5hbnRvbi5taXR0ZXJlci5uYW1lMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqv+F91K5vyBwiGFMqj6wTehWdqZnfFeXqT8g5b3qrXWL
ywSzcoD9xtyoRqAgOCX+PSmBpm6pPhe31VnBtc3HcBMe4rSico9/Z2H9h1l6IMVEnyhabWzoKbE3
BFrsYJGthJCbhK072G8AhCk+5p+L+knLhQXN0Ph7MJbdY26o3M4vjsXFNbJL8TOYxo80cGD1LIh2
SUZFqaIG24TVmTW8F4jD5Z9/NEwJa8kQK+VBNHUntXYNah4Reh0jSsGnq9Pg3Hf4KC+F0IR8QgBm
SnwitMFUX9UnhLEvRQxjDI1tm+h6RxfjlV7moI68Ulh7bcdPhM/z2Q16XmaY12rc85pSRQIDAQAB
o4IBJjCCASIwDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIgb3duIGNl
cnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2VydC5vcmcwQAYD
VR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMDBglghkgB
hvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5jYWNlcnQub3Jn
MEQGA1UdEQQ9MDuBFWNhbGVzdHlvQHNjaWVudGlhLm5ldIEibWFpbEBjaHJpc3RvcGguYW50b24u
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
+G8T/HNZ92ZCdB6K4/jc0m+YnMtHmJVABfvpAgMBAAGjgb8wgbwwDwYDVR0TAQH/BAUwAwEB/zBd
BggrBgEFBQcBAQRRME8wIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLkNBY2VydC5vcmcvMCgGCCsG
AQUFBzAChhxodHRwOi8vd3d3LkNBY2VydC5vcmcvY2EuY3J0MEoGA1UdIARDMEEwPwYIKwYBBAGB
kEowMzAxBggrBgEFBQcCARYlaHR0cDovL3d3dy5DQWNlcnQub3JnL2luZGV4LnBocD9pZD0xMDAN
BgkqhkiG9w0BAQQFAAOCAgEAfwiIodoaUEnaifuhCHLzivcexDq0eVsgMLFF3sJd02Vp8cJdVFQ8
hV+5e0KRwpn9G1Gbq0aloRBTnm2IrHNuLDOm8PSe4HXBPohFqeFmQ/5WWtF6QXj3QNpKOvELW6W7
FgbmwueTuYVNl0+xHjhDgO+bDYzvuKdgAIdXfR5EHMsj75s8mZ2vtSkcRXkWlk0nbfEcbMPCVWSz
vBTi86QfHjL8JxUFz90urj6CYXvwIRAY9kTqUzn53NCaIODGu+C7Wk/EmcgHvbW9otsuYg1CNEG8
/4uK9VEiqogwAOKw1Ly+ZbrVA1d5m+jcyE34UO2RpVIooqz7Nlg+6ZQrkVCHG9Ze1ozM9w8QDFJO
0BZh5eUKbL8Xx3JGV5yY9WxgY3pvXrlOL8i5ubtqhbyYDe35PpeENJSuAK+h5eeSbk698+LZFItc
0usBbKAXpS0Q65x6Sr297s797SJAq3A4iPUKh2rCqwVgyUgF2lPB3kR3arPzPDztgLymOEopJF/+
WTubJXpWYwBkuV2kYn1XNk+tg+8fklOgjndX3eVhET0jAJBMPPqjYJMEo6819g5qj09KYKeFBWxG
oY/0x3bjoVlX93GyxG4UXG1tQWbfG5Ox1ADD7svPPD0hgKlfY2X83eBfpPQr8IVxQdRnJfsasZeu
1pmCE0HSbqUbmSeA5wupqAAxggLtMIIC6QIBATBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4w
HAYDVQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJv
b3QCAwEBgjANBglghkgBZQMEAgMFAKCCAWMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTMwMzI4MTI0NjE2WjBPBgkqhkiG9w0BCQQxQgRA0la0bCVZGXMq59SWCpsb
To9DdN7qvmVuwPw2nxCBbpnc5ODDzahAX4jhLmfFjLNhx8PACtAEAWEZpBV3jcj7DTBqBgkrBgEE
AYI3EAQxXTBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYDVQQLExVodHRwOi8vd3d3LkNB
Y2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJvb3QCAwEBgjBsBgsqhkiG9w0BCRAC
CzFdoFswVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0
Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMgUm9vdAIDAQGCMA0GCSqGSIb3DQEBAQUABIIB
AEnBgW8oWAVHy1EgRs60Z08tSatgoXx4jHjeE7/zCl4eceYj6MeJsHzY/hOl6izKre/SDVmuK9eQ
MSR0fVd03dhonUTig4rpL7pvRJCVi3Q2AmKZNscahMtvgz/rO+36de3m7LQQsjXSx/WiGWHz59/P
5EFe4i/y6zpygag7FkZZp9/pZIUWuPX2oLCJhFDejzT8YVmvOeM18lvoJ4l7H+FRGgv/V7b3dI/W
WPcCk7rEM90hZhnWtnYYr1YIdq2dhWsXNPeCHHrA1de5+mAkZa39deED3A51CHwkEBBGcUzPu66T
kITGFL/FrZOw0Z6ucWse5NO/g9Uz6a4oGVBnKNoAAAAAAAA=


--=-lMUddG51NGeJSHgxCs2/--
