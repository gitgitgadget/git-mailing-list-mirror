From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 21:02:35 -0500
Message-ID: <A3E36E38-5BBC-4E71-8220-FAB498A59EB5@sb.org>
References: <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <alpine.LFD.1.00.0801221743470.1741@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-55--591743894; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Theodore Tso <tytso@MIT.EDU>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHUxR-0001cL-Fa
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbYAWCCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYAWCCk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:02:40 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:40001 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752613AbYAWCCi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 21:02:38 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id D295418CE21;
	Tue, 22 Jan 2008 18:02:36 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801221743470.1741@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71490>


--Apple-Mail-55--591743894
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 22, 2008, at 8:56 PM, Linus Torvalds wrote:

> On Tue, 22 Jan 2008, Theodore Tso wrote:
>>
>> It's pretty clear the Unicode conversion is being done in HFS+, not  
>> in
>> the VFS layer of Mac OS X.
>
> Ok. That's going to make it both easier and harder for them in the  
> future.
> In particular, it probably means that their VFS layer really has no  
> notion
> of this at all, and it's going to be fairly hard to support any kind  
> of
> generic "backwards compatibility" layer on top of other filesystems.

HFS+ was developed on Mac OS 8, which I believe didn't have the notion  
of a VFS, or at least not one that would have been in any way capable  
of doing the case-insensitivity and normalization necessary. However,  
I'm not sure what you mean by a "backwards compatibility" layer on  
other filesystems - if you mean treating another filesystem like HFS+,  
well, if you're using a filesystem that doesn't do normalization then  
the VFS really shouldn't do it for you.

>> So presumably if and when Mac OS adopts ZFS, they will be able to be
>> free of this mess, at least if they care about being compatible with
>> Solaris.
>
> I wouldn't hold my breadth on ZFS, considering the memory  
> requirements.
> ZFS apparently wants *lots* of memory:
>
> 	http://www.solarisinternals.com/wiki/index.php/ZFS_Best_Practices_Guide#ZFS_Administration_Considerations
> 	http://wiki.freebsd.org/ZFSTuningGuide
>
> in fact it seems that the FreeBSD people basically recomment against  
> using
> ZFS on 32-bit kernels because of the memory use issues.
>
> Yes, it could be BSD-specific, but considering Solaris has the same
> recommendation, it sure seems like ZFS isn't ready for prime time on  
> any
> low-end (read: consumer) hardware.
>
> Of course, in a year or two, 2GB will be the norm. Right now it's  
> still
> fairly unusual on Mac hardware outside of the Mac Pro line (which, I
> think, comes with a *minimum* of 2GB), and the people who get it  
> want it
> not for the filesystem caches, but for big photo editing jobs..

Actually, interestingly the new MacBook Air comes with 2GB stock (I'm  
assuming it's soldered onto the motherboard, though, so it makes sense  
that Apple's giving customers 2GB as they can't upgrade themselves).

In any case, everybody's making a big fuss about ZFS, but it really  
doesn't make a lot of sense to use for a consumer system, it seems  
more geared for a server.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-55--591743894
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
DxcNMDgwMTIzMDIwMjM1WjAjBgkqhkiG9w0BCQQxFgQU3wfdVwyp4FUoa6iL8/cEQ4dWx/cwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAMksok/GUUzZx8nfpZrBGj8PLb/dL4CjdGbjdmqxyiYi8vW1BYhOo6dSuN8mh5ws/0N+2yoy
BcszDQucapPIIpNlx/gPXzk7FF4jViXEIVQqmSjdUzKvfxtqzN57E+PnnywXcHiyqM3G7hyylf5+
NZgOvb1ObeUhx4GsReKBonUzUp/b4sXCEYgvKTHloYoDhRGesSiB+pV5Gs8+4pW0JEn7XcFnosm/
wOrAHTsvYfF/rl4ilZZrQeKmPRgnXPzEitYYxBtpayQ6+UpWiOgWJHbdf8XAt6oVfZ+Q1YejQJYJ
cUDHGjGDccZyZ4VmZGz4AZftCPUrDAWmnpVaS993sVYAAAAAAAA=

--Apple-Mail-55--591743894--
