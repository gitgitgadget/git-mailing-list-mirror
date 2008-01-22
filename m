From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 22:04:07 -0500
Message-ID: <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
References: <478E1FED.5010801@web.de> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0! 801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linu
 x-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati! on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-40--674451355; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9RS-0001OC-Vp
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbYAVDEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757470AbYAVDEN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:04:13 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:41675 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753232AbYAVDEL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 22:04:11 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id 48AA2A8AA7;
	Mon, 21 Jan 2008 19:04:09 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71405>


--Apple-Mail-40--674451355
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 9:50 PM, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>>
>> Anyway, please see my countless former emails where I ask to work  
>> towards a
>> solution instead of just arguing.
>
> We know what the solution is:
>
> - The OS X filesystem _is_ crap (and you seem to have almost  
> admitted as
>   much by your comment that the HFS+ designers did it back in the dark
>   ages and didn't mean for it to ever be a server filesystem anyway)

I agree that HFS+ isn't well suited for tasks which it is being asked  
to do. I was never arguing that it was the perfect filesystem. But  
that hardly matters now, I know nobody's going to bother understanding  
my argument so I may as well just stop trying.

> - But we can at least make a wrapper around readdir() return the NFC  
> form
>   on OS X, and effectively hide much of the fallout from the crap.

Again, I don't think that's the correct solution. What about the  
translation table that was suggested back at the beginning of the  
thread? That would solve the case insensitivity issue as well, whereas  
this NFC "solution" does nothing for that.

> There is no way around it. Your "solutions" all seem to boil down to
> asking git to do the same idiotic crap that OS X does, taking all the
> same performance hits, and just generally doing crap just to work  
> around
> crap in your favourite OS.

No, I am not asking git to do the same thing HFS+ does. You just  
persist in misinterpreting my arguments, no matter how many times I  
protest that this is not what I am saying.

> And no, making git be stupid just to suit a stupid filesystem simply  
> isn't
> going to happen.
>
> So how about you see _my_ point instead: OS X may have an inferior
> filesystem, but we don't have to make git inferior just for that.  
> The fact
> that OS X does case independence is *its* problem, not git's.

So, what, you're saying git shouldn't do any work at all to try and  
behave nicer on OS X? Because OS X sure as hell can't change to suit  
git.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-40--674451355
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
DxcNMDgwMTIyMDMwNDA4WjAjBgkqhkiG9w0BCQQxFgQUQyJ2/wqfOHiuZs9CqNkO0WLIV1swgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAJtNTgqww9b8KarFyHoQd531fhTYS6xZ5yaSaJC5h0yJw6EcbsxsbL/xsZf0i/GtI4mdwrL+
OK/9opAxeQNLz6kZpXUfpDaoeE3NVbzmeu99IhCi9duxd5L4kDTpfMLUxzqSc1j03/gmmeE0JcSv
lmmsHgx0GQ1kpCQUisiBWW+PjV6RBDd04TPYcopqki1wtJPx2+kzQxxDUYNCfY8PpeGCLWTlfGPI
qRwXMiuDrOkJqyLorpTLSUPQsXiyg6cLUaD9uBn7+cKMY5i8pcVAhYbkHcwPEtVOsC8RU3rukO5N
C5p7Hd+QaDSIwKiFEhymWNSr014B9l/OR6s3oudrg+sAAAAAAAA=

--Apple-Mail-40--674451355--
