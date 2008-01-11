From: Kevin Ballard <kevin@sb.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 16:09:12 -0500
Message-ID: <CCDF6298-4F17-4F70-AF00-E63F2C2A2816@sb.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-3-587736530; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 22:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDR8K-0001DZ-0c
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759520AbYAKVJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759062AbYAKVJP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:09:15 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:46905 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758226AbYAKVJO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 16:09:14 -0500
X-Greylist: delayed 2987 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2008 16:09:14 EST
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id AD332EF2CC
	for <git@vger.kernel.org>; Fri, 11 Jan 2008 13:09:13 -0800 (PST)
In-Reply-To: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70201>


--Apple-Mail-3-587736530
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Wow, it's even worse. I made a tmp branch and used git-filter-branch  
to remove the commit that introduced CS4536, leaving only the cs4536  
directory. But now if I try and run `git co master` it refuses, as it  
thinks it's going to overwrite the untracked file CS4536/ 
introduction.txt. I believe it's actually seeing the tracked file  
cs4536/introduction.txt.

-Kevin Ballard

On Jan 11, 2008, at 3:19 PM, Kevin Ballard wrote:

> Somehow I managed to change the case of a directory without git  
> realizing it. I thought I issued `git mv CS4536 cs4536` but since  
> that won't work in my efforts to reproduce the problem, I must have  
> simply issued the `mv` outside of git and then re-added it.
>
> Anyway, here's the state of my directory:
>
> kevin@KBALLARD:~/Documents/School/C07> git ls-tree HEAD
> 040000 tree b47c8103e2e01fcf145bdc237c0e56ffc61f1c47	CS4536
> 040000 tree dbf7fc51ef3effebdf9b4e9172e4c86cae52b163	cs4536
> 040000 tree 15834a7b6534a285bf6930be4e5404b37e1dc718	ece3601
> 040000 tree 62d229b8c4a389b550df20a3752d666c48c767a4	ma2071
>
> Note that I have both versions of the directory present.  
> Unfortunately, only one of them can be present on the filesystem. If  
> I run `mv cs4536 CS4536; git reset --hard` I end up with a different  
> working tree.
>
> Git should be able to detect this sort of conflict on a case- 
> insensitive system. I didn't even realize what I'd done until I  
> pushed back to the master repo and ran `git reset --hard` there,  
> then wondered why the new file I added to cs4536/ was missing and  
> why my directory was still named CS4536.
>
> -Kevin Ballard
>
> -- 
> Kevin Ballard
> http://kevin.sb.org
> kevin@sb.org
> http://www.tildesoft.com
>
>

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-3-587736530
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
DxcNMDgwMTExMjEwOTEyWjAjBgkqhkiG9w0BCQQxFgQUZ6SJ14zVz9ClyxkhHPhrJ733fDQwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAGfCK+jQ71jwje29w6Iqx2zOijD+5JV4SsaQjkbSHB1wfmxMyOi+1S7pce5YxxAycFZofmTu
OJZYcKi41ju43UqWT0V/p2Um2eOopc3wxSz5+L9S8h84n8HgVKCOmNBBzQTrSLIEjondHT2vVQI8
qXRkyBHeGPGj0jq5SMSRNx08ieZ9fLr0D1BynIdjO8FYly/rtSJboyGw/EsHp0L+kqtQ+1atRZzK
8y9R1fk93Uxpu2qAb58Hs2zBj6E7hsOw116TKuwfVulQUwMF23Jtfl1uLbCz3M0MBge4Oz8yCjmx
GN0F6cet6SBtuahivOly4Z1m2VzJcK8UFwgxJfDQSwQAAAAAAAA=

--Apple-Mail-3-587736530--
