From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 17:46:27 -0500
Message-ID: <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-fou
 ndation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-24--689911772; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:47:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5QK-0004tH-G0
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbYAUWqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbYAUWqv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:46:51 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:35926 "EHLO
	randymail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754882AbYAUWqu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 17:46:50 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a10.g.dreamhost.com (Postfix) with ESMTP id F3FBF10FC22;
	Mon, 21 Jan 2008 14:46:38 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71363>


--Apple-Mail-24--689911772
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 5:34 PM, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>>
>> I'm really surprised that, after all of this, you're still horribly
>> misunderstanding my argument. I never said it was invisible. NEVER.
>
> You said it was invisible when you treat things "as text". Here's the
> quote:
>
> 	.. when you treat filenames as text, it DOESN'T MATTER if the
> 	string gets normalized ..
>
> Without ever apparently realizing that "as text" is part of the  
> problem in
> itself. What is "text" to one person is gibberish to another.

Which is actually a good argument as to why filenames should be  
enforced as UTF-8.

> In particular, the biggest reason to not normalize is that you don't  
> know
> it's text or Unicode in the first place. Which is why git doesn't do  
> it.

Sure, I understand why git doesn't do it. I'm saying in a system which  
uses unicode top-to-bottom, which you can create if you're using HFS+  
only, can do it. On HFS+ you know the filename is unicode.

> And no, even with filenames you don't know that they are "text".  
> People
> encode stuff in them. And people don't always use UTF-8.

Again, I was talking about a system that used unicode top-to-bottom.  
On HFS+ you have to use UTF-8 for your filename or it simply won't work.

> Of course, you could ask everybody to create OS X-only programs that  
> know
> that under OS X, you only have a subset of filenames. If so, you're
> complaining about the wrong tool. Especially when the whole point of  
> the
> tool was to be distributed (not to mention coming from an  
> environment that
> simply doesn't have the same silly limitations OS X has).
>
> So here's a few clues:
>
> - "as text" isn't "as unicode": it may well be Latin1 or EUC-JP or
>   something. Yes, it's still used. Git doesn't care, and very  
> consciously
>   has avoided forcing character sets, even if the *default* (and  
> notice
>   how it's overridable) commit message encoding may be utf-8.
>
> - In fact, even in unicode, the difference between "identical" and
>   "equivalent" strings exists, and even in the standard, unicode
>   strings are very much defined to be arbitrary codepoint sequences,  
> not
>   normalized.
>
> So even for the very specific case of unicode text, it's simply not  
> true
> that "it doesn't matter if the string gets normalized". The unicode  
> spec
> itself talks about cases where even canonical normalization makes a
> difference.
>
> Search for this quote:
>
>  "Not all processes are required to respect canonical equivalence. For
>   example:
>
>    * A function that collects a set of the General_Category values
>      present in a string will and should produce a different value for
>      <angstrom sign, semicolon> than for <A, combining ring above,  
> greek
>      question mark>, even though they are canonically equivalent.
>    * A function that does a binary comparison of strings will also  
> find
>      these two sequences different."
>
> and notice that first case. Even things that are *very*much* aware of
> Unicode text do actually have cases where canonical equivalence  
> doesn't
> mean crud.

I find it amusing that you keep arguing against having git treat  
filenames as unicode when, if you had actually taken my advice and  
read my previous email talking about "ideal" vs "practical", you'd  
realize that I was not suggesting git should. I was simply describing  
why having the filesystem specifically treat filenames as utf-8 isn't  
a problem when the entire system is unicode-aware, and thus showing  
how the problems that are cropping up in git aren't because the  
filesystem treats filenames as unicode, but rather because the  
filesystem treats filenames differently than other filesystems. In  
other words, I was trying to illustrate that HFS+ isn't wrong, it's  
just different, and the difference is causing the problem.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-24--689911772
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
DxcNMDgwMTIxMjI0NjI3WjAjBgkqhkiG9w0BCQQxFgQULGeQ5k2TMxz5Cv+qXyXFfAYlCVIwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAJSTy6V94N+oiLzB4OC/UBmoaP/9ST8ZLWfaRPMm92THnfV3QE79eObhy6jvyXT+QUfkR+ix
Q1BPERqo0dXFjbORWJyVsRDfPe20PkJPXDCoKqeUBcrtB8lEa03PHnkzPL5i1W48D4Ai4n+Zv6aS
OjnX3NG5rQUe0/WOeSRdUUqgx+xbd4AXmWe4jlMPLcUqFMn3zAmfS0NwhBJeyUIrTnB5GDeGyd0r
sDZn1Gg1j2hyPpwUPuhPYlVgKG6YAq9jcWkNeYOGLzwLAOQaHOsD+XKFizek1otH4/AI5rh3v7cr
hvvhezB6YlC2rzWrp70HwuRkYUHSOuDKWRqYhkWDOcMAAAAAAAA=

--Apple-Mail-24--689911772--
