From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 12:25:52 -0500
Message-ID: <AE99FDAA-F8D3-49F7-A0B9-CDFCC4903824@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cix
 it.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801211151180.20753@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-9--709146700; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 18:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH0Ph-0006Ml-0G
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 18:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYAURZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbYAURZ5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 12:25:57 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:33713 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751109AbYAURZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 12:25:56 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id B8A1F8FF6D;
	Mon, 21 Jan 2008 09:25:53 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211151180.20753@xanadu.home>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71297>


--Apple-Mail-9--709146700
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 12:08 PM, Nicolas Pitre wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>
>> On Jan 21, 2008, at 9:14 AM, Peter Karlsson wrote:
>>
>>> I happen to prefer the text-as-string-of-characters (or code points,
>>> since you use the other meaning of characters in your posts),  
>>> since I
>>> come from the text world, having worked a lot on Unicode text
>>> processing.
>>>
>>> You apparently prefer the text-as-sequence-of-octets, which I tend  
>>> to
>>> dislike because I would have thought computer engineers would have
>>> evolved beyond this when we left the 1900s.
>>
>> I agree. Every single problem that I can recall Linus bringing up  
>> as a
>> consequence of HFS+ treating filenames as strings is in fact only a  
>> problem if
>> you then think of the filename as octets at some point. If you  
>> stick with
>> UTF-8 equivalence comparison the entire time, then everything just  
>> works.
>>
>> Granted, this is a problem when you have to operate on a filesystem  
>> that
>> thinks of filenames as octets, but as I said before, this doesn't  
>> mean the
>> HFS+ approach is wrong, it just means it's incompatible with  
>> Linus's approach.
>
> Linus' approach is _FAST_.
>
> Why do you think Git has now acquired a reputation of kicking asses  
> all
> around the SCM scene?
>
> The HFS+ approach might be fine if you think of it in terms of "the  
> user
> will be awfully confused if two file names are shown identically in  
> the
> File Open dialog box".  But it otherwise sucks big time when it  
> comes to
> high performance applications needing to deal with a huge amount of  
> file
> names at once.
>
> Normalization will always hurt performances.  This is an overhead.
> Sometimes that overhead might be insignificant and not be perceptible,
> but sometimes it is.  And Git is clearly in the later case.  
> Performances
> will be hurt big time the day it is made aware of that normalization.
> This is why there is so much resistance about it, especially when the
> benefits of normalizing file names are not shown to be worth their  
> cost
> in performance and complexity, as other systems do rather fine without
> it.

I agree, Linus's approach is indeed fast. And if speed is more  
important than treating filenames as text instead of octets, then so  
be it. This is a trade-off. But a trade-off doesn't mean one approach  
is "wrong", it just means the authors of HFS+ thought it was an  
acceptable trade-off. HFS+ wasn't designed to be a high-performance  
filesystem that deals with lots of files, it was designed to be a  
filesystem used by regular people on the Mac, and I believe treating  
filenames as text is a good choice in this scenario. Unfortunately,  
this does mean git has to do extra work to behave correctly on this  
system.

Now, to move on to actually coming up with a solution. Unfortunately I  
don't know enough about the internals of git to really evaluate the  
proposed ideas myself, or to write a patch. Hopefully I'll come up  
with the time to acquire the necessary knowledge, but until then I can  
only participate in these higher-level discussions.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-9--709146700
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
DxcNMDgwMTIxMTcyNTUzWjAjBgkqhkiG9w0BCQQxFgQU1zZtpRVVstSunboK7z4U3r9L3uEwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAI+yXtaO4nl5yHLpNS0F+lTcAaWQ7NXf7W/1ei2A8JVCpU2NRe1UzjNMEZorasgyJ7FuB3ar
noGx5S8I6A3Q6H/wr1s3eKOFeP1KwlGMqf9MCXL+cWjehqH4D3SzEQxWzuZCkrQy8gMMOpkgusPK
5H+hmgQtpVHZB4DT9PDAcAe+g4GXuCMZJVTZzIG8bWgvag06xD5swUBVi7EidRpHtqCs918rEjAH
CW8qed0aiwarTiMYq8zDZ+65zDsPu10/sRHfwqc88TNWX+2utUyT7Hd0orT9f+3U1f4Etu5ee4bH
snmwrG0Yofr8/TG4ZY4kSK+6AEYmamAICwZHfDSyjlcAAAAAAAA=

--Apple-Mail-9--709146700--
