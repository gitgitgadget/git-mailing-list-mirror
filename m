From: Kevin Ballard <kevin@sb.org>
Subject: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 15:19:25 -0500
Message-ID: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-2-584750016; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 21:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDQO5-00015Z-BB
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 21:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761020AbYAKUVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 15:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760691AbYAKUVa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 15:21:30 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:50472 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759697AbYAKUV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 15:21:28 -0500
Received: from randymail-a10.g.dreamhost.com (sd-green-bigip-202.dreamhost.com [208.97.132.202])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 01ABB17AEB8
	for <git@vger.kernel.org>; Fri, 11 Jan 2008 12:21:27 -0800 (PST)
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a10.g.dreamhost.com (Postfix) with ESMTP id EC95810FD50
	for <git@vger.kernel.org>; Fri, 11 Jan 2008 12:19:26 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70197>


--Apple-Mail-2-584750016
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Somehow I managed to change the case of a directory without git  
realizing it. I thought I issued `git mv CS4536 cs4536` but since that  
won't work in my efforts to reproduce the problem, I must have simply  
issued the `mv` outside of git and then re-added it.

Anyway, here's the state of my directory:

kevin@KBALLARD:~/Documents/School/C07> git ls-tree HEAD
040000 tree b47c8103e2e01fcf145bdc237c0e56ffc61f1c47	CS4536
040000 tree dbf7fc51ef3effebdf9b4e9172e4c86cae52b163	cs4536
040000 tree 15834a7b6534a285bf6930be4e5404b37e1dc718	ece3601
040000 tree 62d229b8c4a389b550df20a3752d666c48c767a4	ma2071

Note that I have both versions of the directory present.  
Unfortunately, only one of them can be present on the filesystem. If I  
run `mv cs4536 CS4536; git reset --hard` I end up with a different  
working tree.

Git should be able to detect this sort of conflict on a case- 
insensitive system. I didn't even realize what I'd done until I pushed  
back to the master repo and ran `git reset --hard` there, then  
wondered why the new file I added to cs4536/ was missing and why my  
directory was still named CS4536.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-2-584750016
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTExMjAxOTI2WjAjBgkqhkiG9w0BCQQxFgQU8yWn3FqMdr9NzoQLHhYIc/BNm3AwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAHz7fy+HxgxlOWNfPYRa83xlglRBhdLSy8//J+URNFTbERK5qwUB/GzoJhjRtBN6QAxHmHYI
jDbvfNUckKcsTey6CbsToFabiv7rYq44nGRCUKtH0ziW4W2UvAT91Dep9qqfZlcx/7Vs5PuySsxC
rJLGnc4FQt19tl8gx+qS8jKaDQWDMgOxaxoQbpWO1ebkHgZTBdu0UByJeJlJCqrSZEMhlSx7/Ryv
/ZdO1equHDETDCd7g2Dif3e7Qx+JkNFGIEoMIrWNxJTOiFek5JcXyUV6vzIp46/mxj3vBZe3YPdL
Ov+nRQK4l6rMkFUcFz8qpqhHou/3v4rgd5htC0mwzGEAAAAAAAA=

--Apple-Mail-2-584750016--
