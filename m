From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 11:59:24 -0500
Message-ID: <CFF9E74C-4A4C-4E5F-8DA3-662D80095503@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801 171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.ci
 xit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <86r6gbi0pr.fsf@lola.quinscape.zz>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-8--710734437; micalg=sha1; protocol="application/pkcs7-signature"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 18:00:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH00D-0005HG-6E
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 18:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbYAUQ73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 11:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbYAUQ73
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 11:59:29 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:41668 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751109AbYAUQ72 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 11:59:28 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 61EFDEF2E5;
	Mon, 21 Jan 2008 08:59:26 -0800 (PST)
In-Reply-To: <86r6gbi0pr.fsf@lola.quinscape.zz>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71295>


--Apple-Mail-8--710734437
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 21, 2008, at 11:48 AM, David Kastrup wrote:

> Kevin Ballard <kevin@sb.org> writes:
>
>> On Jan 21, 2008, at 9:14 AM, Peter Karlsson wrote:
>>
>>> I happen to prefer the text-as-string-of-characters (or code points,
>>> since you use the other meaning of characters in your posts), =20
>>> since I
>>> come from the text world, having worked a lot on Unicode text
>>> processing.
>>>
>>> You apparently prefer the text-as-sequence-of-octets, which I tend =20=

>>> to
>>> dislike because I would have thought computer engineers would have
>>> evolved beyond this when we left the 1900s.
>>
>> I agree. Every single problem that I can recall Linus bringing up =20
>> as a
>> consequence of HFS+ treating filenames as strings is in fact only a
>> problem if you then think of the filename as octets at some point. If
>> you stick with UTF-8 equivalence comparison the entire time, then
>> everything just works.
>
> git calculates hashes over filenames and sorts them.  This is not a =20=

> mere
> question of "UTF-8 equivalence comparison".

No, it's a question of hashing algorithm. And it's one that's fairly =20
easily solved simply by picking a specific nonambiguous UTF-8 encoding =20=

before hashing.

>> Granted, this is a problem when you have to operate on a filesystem
>> that thinks of filenames as octets,
>
> It also is a problem when operating on a filesystem that considers =20
> "=E4" a
> single utf-8 character instead of decomposing it.

What makes you say that?

>> but as I said before, this doesn't mean the HFS+ approach is wrong, =20=

>> it
>> just means it's incompatible with Linus's approach.
>
> It is not the business of a file system to juggle with filename
> representations.

You're right, that probably belongs in the VFS layer, but the behavior =20=

is the same either way. You can't leave it up to user-space libraries =20=

to enforce a filesystem encoding, because you can't rely on all =20
clients to behave properly.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-8--710734437
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
DxcNMDgwMTIxMTY1OTI1WjAjBgkqhkiG9w0BCQQxFgQU9VFhkP2F1hMF1aTubGjtWi0mX+owgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAEk4SkBWXvCVujDJ3q/WbcHOYFwU3uzIjZjZS7v/sduDDBDkn2cnaExsxilTElqCg729vuxJ
rysOFefUcY/vWg6R9kh+dF31umLauC4ln/8xApzZIWIQ4vW4MquNU2bnWEOKRw3YX5s9U8Vqnzfi
rxM9smkuT4jw6vVSbLvZ4z31jz82eFcTGptdAn2h/OwQCpLrVbzuNWAS17u3o+hQ+yY5nFMBJ52G
AyWLlpuG30rQVz7HyaanIPiuu7wJTXzzrwBbQN5ioeiOtBBB2R4kWkFUn6/eAChp8MV0Qsssv/AW
Jf9n8F3aS0rpW7xTYzwhZSGRFSQi0ygPTYUUR7B8oJgAAAAAAAA=

--Apple-Mail-8--710734437--
