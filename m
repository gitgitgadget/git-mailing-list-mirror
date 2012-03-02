From: Rune Schjellerup Philosof <rune@philosof.dk>
Subject: [PATCH 1/2] Complain in the tests about git config not failing with,
 keys without a section
Date: Fri, 02 Mar 2012 11:57:34 +0100
Message-ID: <4F50A79E.5060206@philosof.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms070300000406060303040709"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 12:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3QJQ-0001Rg-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281Ab2CBLGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 06:06:03 -0500
Received: from mailout-limhamn.gigahost.dk ([94.246.99.122]:45377 "EHLO
	mailout-limhamn.gigahost.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932260Ab2CBLF7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 06:05:59 -0500
Received: from mailout.gigahost.dk (mailout.gigahost.dk [217.116.232.226])
	by mailout-limhamn.gigahost.dk (Postfix) with ESMTP id 911A118820BF
	for <git@vger.kernel.org>; Fri,  2 Mar 2012 10:57:36 +0000 (UTC)
Received: from smtp.gigahost.dk (unknown [89.186.169.107])
	by mailout.gigahost.dk (Postfix) with ESMTP id 6AC1B1D702BE
	for <git@vger.kernel.org>; Fri,  2 Mar 2012 11:57:36 +0100 (CET)
Received: from [192.168.1.36] (unknown [89.186.169.85])
	by smtp.gigahost.dk (Postfix) with ESMTPSA id 364DCF4A5C9
	for <git@vger.kernel.org>; Fri,  2 Mar 2012 11:57:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192027>

Dette er en meddelelse med en digital signatur i MIME-format.

--------------ms070300000406060303040709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=46rom c4fc13a5a1e8c1eab9873232e6e8b7e0523cd6ea Mon Sep 17 00:00:00 2001
From: Rune Philosof <rune.git@philosof.dk>
Date: Fri, 2 Mar 2012 10:42:23 +0100
Subject: [PATCH 1/2] Complain in the tests about git config not failing w=
ith
 keys without a section

git is supposed to fail when having a key without a section, but does not=
=2E

Signed-off-by: Rune Philosof <rune.git@philosof.dk>
---
 t/t1300-repo-config.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 5f249f6..81ccad5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -928,6 +928,11 @@ test_expect_success 'git -c "key=3Dvalue" support' '=

 	test_must_fail git -c name=3Dvalue config core.name
 '

+test_expect_failure 'No section' '
+	echo "fail=3Dtrue" > failconf &&
+	test_must_fail git config --file failconf --list
+'
+
 test_expect_success 'key sanity-checking' '
 	test_must_fail git config foo=3Dbar &&
 	test_must_fail git config foo=3D.bar &&
--=20
1.7.5.4


--------------ms070300000406060303040709
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
ATAcBgkqhkiG9w0BCQUxDxcNMTIwMzAyMTA1NzM0WjAjBgkqhkiG9w0BCQQxFgQUBv7iBPxl
vNxPNvKvI70P7rqRsC0wSAYJKwYBBAGCNxAEMTswOTAxMQswCQYDVQQGEwJESzEMMAoGA1UE
ChMDVERDMRQwEgYDVQQDEwtUREMgT0NFUyBDQQIERaza0zBKBgsqhkiG9w0BCRACCzE7oDkw
MTELMAkGA1UEBhMCREsxDDAKBgNVBAoTA1REQzEUMBIGA1UEAxMLVERDIE9DRVMgQ0ECBEWs
2tMwXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3
DQEBAQUABIGAJcbKRs6l4dsPetfP768qz+MlwPneYHqk/NdsUC3ZR/3fOmAZ4RXQpjLOB88p
H/M53t+p4LzcPPzQ+/AeE8w30CAkooRTpPssY4/3o88NgcinLJVQngKbQXHm938AS3ghV6Ya
HiwycGJY7lD1Zu+bc7BHsspngey3NN+/s0c6hnQAAAAAAAA=
--------------ms070300000406060303040709--
