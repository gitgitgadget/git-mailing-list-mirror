From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 16:28:41 -0500
Message-ID: <E46A8ED2-7E95-41CF-A5A7-2CB9BC18F95D@sb.org>
References: <478E1FED.5010801@web.de> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <46a038f90801211317v4902ffd3ic8ccc35f8df72bd9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-35--694577910; micalg=sha1; protocol="application/pkcs7-signature"
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4Cm-0002qE-HZ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbYAUV2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbYAUV2r
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:28:47 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:41841 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753484AbYAUV2q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:28:46 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 3B8E9EEEA0;
	Mon, 21 Jan 2008 13:28:44 -0800 (PST)
In-Reply-To: <46a038f90801211317v4902ffd3ic8ccc35f8df72bd9@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71346>


--Apple-Mail-35--694577910
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 21, 2008, at 4:17 PM, Martin Langhoff wrote:

> On Jan 22, 2008 9:53 AM, Kevin Ballard <kevin@sb.org> wrote:
>> On Jan 21, 2008, at 3:33 PM, Linus Torvalds wrote:
>>> Umm. What's this inability to see that data is data is data?
>>
>> I'm not sure what you mean. I stated a fact - at least on OS X, the
>> filename does not contribute to the listed filesize, so changing the
>> encoding of the filename doesn't change the filesize. This isn't a
>> philosophical point, it's a factual statement.
>
> Kevin,
>
> as you might know, Linus' "other hobby" is to write kernels ;-) From
> taht POV, a filename is as much data as the data in the file. Doing
> odd things like sorting it, searching through it, etc, is all work for
> code higher in the stack that is free to mangle the data in any way it
> wants, including creating nice case-insensitive indexes, and
> who-knows-what for ideogram-based languages. In contrast, the core OS
> treats user data a sacred stuff, and I'm thankful it does.

That's certainly a reasonable POV. However, it's not the only one. As =20=

evidenced by the Mac, treating filenames as strings rather than bytes =20=

is a viable alternative POV - you can't argue that it doesn't work, =20
because OS X proves it does.

However, it is a trade-off.

> And from a kernel/filesystem POV, a directory is also a file. So if a
> filename has a different number of octets, the directory will be
> different.

Sure, that makes sense. That's why, if you are going to mangle =20
filenames, you need to pick a stable form to always use, which HFS+ =20
does.

> For all the searching and matching, it really makes sense to have
> something like locate or SpotLight or whatever to index user files
> that should be easy to find and match, because all the locale rules
> for matching are hideously expensive to apply. Even today, most UTF-8
> aware (and supposedly collation-smart) applications have trouble
> matching MART=CDN when asked for mart=EDn in a case-insensitive =
search.
> That pesky latin =ED trips them up everytime.


Perhaps you should try OS X. Every single Cocoa app should do the =20
search properly. In fact, I just checked using 3 different text =20
engines (WebKit, Cocoa's text engine, and ATSUI) and all 3 did the =20
case-insensitive search properly. That said, this isn't particularly =20
relevant.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-35--694577910
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
DxcNMDgwMTIxMjEyODQxWjAjBgkqhkiG9w0BCQQxFgQUzky48yX31K2Jdad2/ehSJZ0FUTQwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAC0hfZpQwCV1sxs5xtwjspdRv+829G67JJRbg09O3xkO7RY8BLac/Oig2ZA+YecqG94jsuZH
SINmhIwj1fupN32rAvJEDYWVYktmOeUd9/gpTDxdNQJbsKE+9kRU+Aj8rK33cm2i8qgzQOj8EdiZ
WWZVoXBfwFUDahUofA+C1g9aKy6/2vHA2VWuJL5ZTFcAi7CJwrsTpEJpfwndpqSj850BdDdpmlUj
MSlTnDc7oKmpYbnsSkJFGjARgubz6t6JILoc/BTYy/4pEBmGRcqMI78xqQIs5yvZ+EqhWCWCGjZc
LKxLvq17qRGGUyexUlfnPvrs1FNo0fg7/D5quPrr2zQAAAAAAAA=

--Apple-Mail-35--694577910--
