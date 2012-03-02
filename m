From: Rune Schjellerup Philosof <rune@philosof.dk>
Subject: [PATCH 2/2] Complain in tests about aliases not working for, alternative
 config files
Date: Fri, 02 Mar 2012 12:00:12 +0100
Message-ID: <4F50A83C.9090407@philosof.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms070002000204010105050504"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 12:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3QJQ-0001Rg-C5
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab2CBLGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 06:06:01 -0500
Received: from mailout-limhamn.gigahost.dk ([94.246.99.122]:45361 "EHLO
	mailout-limhamn.gigahost.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932087Ab2CBLF7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 06:05:59 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Mar 2012 06:05:59 EST
Received: from mailout.gigahost.dk (mailout.gigahost.dk [217.116.232.226])
	by mailout-limhamn.gigahost.dk (Postfix) with ESMTP id 98B2118820F7
	for <git@vger.kernel.org>; Fri,  2 Mar 2012 11:00:14 +0000 (UTC)
Received: from smtp.gigahost.dk (unknown [89.186.169.107])
	by mailout.gigahost.dk (Postfix) with ESMTP id 6A55A1D702BB
	for <git@vger.kernel.org>; Fri,  2 Mar 2012 12:00:14 +0100 (CET)
Received: from [192.168.1.36] (unknown [89.186.169.85])
	by smtp.gigahost.dk (Postfix) with ESMTPSA id 26B94F4A5C4
	for <git@vger.kernel.org>; Fri,  2 Mar 2012 12:00:13 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192026>

Dette er en meddelelse med en digital signatur i MIME-format.

--------------ms070002000204010105050504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=46rom c412e07ba45be32f2158c5668752354a979734d6 Mon Sep 17 00:00:00 2001
From: Rune Philosof <rune.git@philosof.dk>
Date: Fri, 2 Mar 2012 11:13:55 +0100
Subject: [PATCH 2/2] Complain in tests about aliases not working for
 alternative config files

Aliases does not work when set in a configuration file specified by the
GIT_CONFIG variable.

Signed-off-by: Rune Philosof <rune.git@philosof.dk>
---
 t/t1300-repo-config.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 81ccad5..433ef94 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -955,6 +955,17 @@ test_expect_success 'git -c works with aliases of
builtins' '
 	test_cmp expect actual
 '

+test_expect_failure 'aliases work with alternative config' '
+	(
+		GIT_CONFIG=3Dalias &&
+		export GIT_CONFIG &&
+		git config alias.altconfig "-c foo.check=3Dbar config foo.check" &&
+		echo bar >expect &&
+		git altconfig >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'git -c does not split values on equals' '
 	echo "value with =3D in it" >expect &&
 	git -c core.foo=3D"value with =3D in it" config core.foo >actual &&
--=20
1.7.5.4


--------------ms070002000204010105050504
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME-signeret meddelelse

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFfDCC
BXgwggRgoAMCAQICBEWs2tMwDQYJKoZIhvcNAQEFBQAwMTELMAkGA1UEBhMCREsxDDAKBgNV
BAoTA1REQzEUMBIGA1UEAxMLVERDIE9DRVMgQ0EwHhcNMTAwNDAzMTkxMDU3WhcNMTIwNDAz
MTk0MDU3WjCBgTELMAkGA1UEBhMCREsxKTAnBgNVBAoTIEluZ2VuIG9yZ2FuaXNhdG9yaXNr
IHRpbGtueXRuaW5nMUcwIAYDVQQDExlSdW5lIFNjaGplbGxlcnVwIFBoaWxvc29mMCMGA1UE
BRMcUElEOjkyMDgtMjAwMi0yLTY1MDk2MzE3NjA4ODCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAqZxNgoq5z+rwVTNgHFsrP1Cv6f6Pw9WbeqIhn+zGIimcHMARng+KRJrgYZb6mfO4
c+rQLy/YQBatrKvCXdxoKak1ChwACrLfsh2hnmWEDt2uzLZDu7p4QxKGMqg4J+tJqPy9Q2ix
XrEOXFSTrAv4jSgShZtnA6rLtujKxp63KusCAwEAAaOCAskwggLFMA4GA1UdDwEB/wQEAwID
+DArBgNVHRAEJDAigA8yMDEwMDQwMzE5MTA1N1qBDzIwMTIwNDAzMTk0MDU3WjCCATcGA1Ud
IASCAS4wggEqMIIBJgYKKoFQgSkBAQEBAzCCARYwLwYIKwYBBQUHAgEWI2h0dHA6Ly93d3cu
Y2VydGlmaWthdC5kay9yZXBvc2l0b3J5MIHiBggrBgEFBQcCAjCB1TAKFgNUREMwAwIBARqB
xkZvciBhbnZlbmRlbHNlIGFmIGNlcnRpZmlrYXRldCBn5mxkZXIgT0NFUyB2aWxr5XIsIENQ
UyBvZyBPQ0VTIENQLCBkZXIga2FuIGhlbnRlcyBmcmEgd3d3LmNlcnRpZmlrYXQuZGsvcmVw
b3NpdG9yeS4gQmVt5nJrLCBhdCBUREMgZWZ0ZXIgdmlsa+VyZW5lIGhhciBldCBiZWdy5m5z
ZXQgYW5zdmFyIGlmdC4gcHJvZmVzc2lvbmVsbGUgcGFydGVyLjBBBggrBgEFBQcBAQQ1MDMw
MQYIKwYBBQUHMAGGJWh0dHA6Ly9vY3NwLmNlcnRpZmlrYXQuZGsvb2NzcC9zdGF0dXMwGwYD
VR0RBBQwEoEQcnVuZUBwaGlsb3NvZi5kazCBhAYDVR0fBH0wezBLoEmgR6RFMEMxCzAJBgNV
BAYTAkRLMQwwCgYDVQQKEwNUREMxFDASBgNVBAMTC1REQyBPQ0VTIENBMRAwDgYDVQQDEwdD
Ukw1MjAxMCygKqAohiZodHRwOi8vY3JsLm9jZXMuY2VydGlmaWthdC5kay9vY2VzLmNybDAf
BgNVHSMEGDAWgBRgtYXsVmR+EhknZx1QFUtzrjv5EjAdBgNVHQ4EFgQU7uRU/6dzBZH/lk/b
n4vHT5Gm+/QwCQYDVR0TBAIwADAZBgkqhkiG9n0HQQAEDDAKGwRWNy4xAwIDqDANBgkqhkiG
9w0BAQUFAAOCAQEAIwzXCtiKth84OI7h//Y81eNmQvb+CLe3wyj+0svD/qVoOXUKGCqpomRp
6Qhd7FlXc4NnEmqhEfPZEUevnGbdx0Kix+liSLasmwRwVzUcLs2W4JwNOd279mcO+yv6tbJZ
MAFVjMKA+cV6aEOKVso6iDPOX8b3mFphSsb+n44tBt4zIHPWUYxqF9vesBoA90BBKRBF2jTZ
HcsY28HmerehGZinNaoegg9qvI5CQ1n+tvJYTrs9svzTYx6yxUCNXIJO5SIpAvBB3HhUgs3I
Y92OuIAoSoSUSGgEn2sWDKyrLp+BPHXlZ1bQcLNR91qFSLgZ6PAxmU1D5OF0G28pb/0QGjGC
AjcwggIzAgEBMDkwMTELMAkGA1UEBhMCREsxDDAKBgNVBAoTA1REQzEUMBIGA1UEAxMLVERD
IE9DRVMgQ0ECBEWs2tMwCQYFKw4DAhoFAKCCAVQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMTIwMzAyMTEwMDEyWjAjBgkqhkiG9w0BCQQxFgQUSGHmRgjd
OBl2y4FvY+9vlbWYWHAwSAYJKwYBBAGCNxAEMTswOTAxMQswCQYDVQQGEwJESzEMMAoGA1UE
ChMDVERDMRQwEgYDVQQDEwtUREMgT0NFUyBDQQIERaza0zBKBgsqhkiG9w0BCRACCzE7oDkw
MTELMAkGA1UEBhMCREsxDDAKBgNVBAoTA1REQzEUMBIGA1UEAxMLVERDIE9DRVMgQ0ECBEWs
2tMwXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3
DQEBAQUABIGAqUe4ub6In0STCFk8cmthygKysG60eslDaJ9O5ZsYzD2nkiVvzVu6ErmqaZF8
QHvVq48AoEK+n7aQqNL6FuMkBcZPKL3K06e5imzLFE4/YKBaswEpKmKRZo6pRNc1rW8ql844
jhTKNTPv6Bvh4umfxogsVxAyVjxenJwvGF9c4IkAAAAAAAA=
--------------ms070002000204010105050504--
