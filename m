From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:23:48 -0500
Message-ID: <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org> <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-11-1049412750; micalg=sha1; protocol="application/pkcs7-signature"
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mark Junker" <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 06:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFNEk-0006Wm-Ae
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 06:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYAQFXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 00:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbYAQFXx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 00:23:53 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:58860 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750960AbYAQFXw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 00:23:52 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 95F6C109E8B;
	Wed, 16 Jan 2008 21:23:49 -0800 (PST)
In-Reply-To: <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70829>


--Apple-Mail-11-1049412750
Content-Type: text/plain;
	charset=UTF-8;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 16, 2008, at 11:51 PM, Martin Langhoff wrote:

> On Jan 17, 2008 5:30 PM, Kevin Ballard <kevin@sb.org> wrote:
>> Those of us who grew up on a case-insensitive filesystem don't find
>> there to be any problem with it. I can count on one hand the number =20=

>> of
>
> I guess you haven't used unix tools much. The ever-popular HEAD perl
> utility (which does an HTTP HEAD against a URL), when installed,
> silently overwrites the head shell utility, which is used for all
> sorts of things, some even in startup scripts. Ooops! I've been hit by
> this more than once - and if you google for it, it hurt a lot of
> people.

I can imagine. However, I've never been hit by such a situation. This =20=

doesn't mean a case-insensitive filesystem is a problem per se, it =20
means interactions between a case-insensitive and a case-sensitive =20
filesystem can be a problem. That doesn't mean either way is "correct" =20=

it just means both don't work well together.

I like ice cream, and I like steak, but I sure don't think a mixture =20
of steak and ice cream would go well together. Do you?

>> That's only true if you don't know what type of filesystem you're on.
>> And, in the vast majority of cases (in fact, a content tracker is the
>> only exception I can think of), it doesn't matter. If the user said
>
> Hmmm. Many important tools - that I wouldn't want to ever fail! - have
> similar needs to git. Backup/restore and file replication tools for
> example.

Both of which would be replicating the directory contents, not a =20
listing of files specified by the user. If, as a user, I were to say =20
"please replicate file FOO" and the file was really called "foo", I =20
wouldn't be in the least surprised to see the tool take me at my word =20=

and produce a file called "FOO" with the contents of "foo". But in =20
general, things like this operate on the filesystem, not on the user =20
args.

>>> This is why case-insensitivity is so hard: you have a very real
>>> "aliasing"
>>> on the filesystem level, where all those really *different*
>>> pathnames end
>>> up being the same thing.
>>
>> I don't see that as being a problem. Think of it, if you will, as if
>> every single file simply had an implicit hardlink for every possible
>> case or normalization variant. The whole point of the filename is =20
>> that
>
> Ok - but how do you track the directory then (in git's terms, the
> tree). There's no way to tell what the user wants. Does the user want
> a copy of the file with different capitalization, or is the OS playing
> games?

If I say "track FOO", I probably mean it. So go ahead and track "FOO", =20=

even if you end up tracking the contents of file "foo". I certainly =20
won't blame the tool for doing what I told it.

>> it is meta-information, used as an identifier and not as actual
>> content, and thus it is perfectly fine for it to be a real string,
>> subject to interpretation,
>
> I don't think you *actually* want it subject to interpretation.

Sure I do. I find it  very convenient, for example, to say "cd =20
documents/school" when I really want to go to "Documents/School". =20
Similarly, if I'm trying to reference gitweb/tests/M=C3=A4rchen, I'm =
quite =20
happy to not have to figure out what normalization the filename is =20
using and attempt to replicate that (especially as I have no idea =20
which normalization my input mechanism uses - unlike Linus, I don't =20
have a key dedicated to =C3=A4, and even if I did I wouldn't necessarily =
=20
expect it to use precomposed vs decomposed). I can't think of a single =20=

reason why I'd want to be able to have 2 different files named =20
"M=C3=A4rchen" on my disk. On the other hand, treating unicode =20
normalization as significant can pose security risks - how am I to =20
know that the file that is named "foo.txt" is really the same file =20
"foo.txt" that I last saw? Someone I know on IRC sent me this =20
image[1], which shows 6 files all apparently named "foo.txt" on a disk =20=

image. This is possible because on a case-sensitive HFS+ volume, the =20
file system doesn't ignore ignorables when comparing filenames (it =20
does on a case-insensitive HFS+ system), and so all of those filenames =20=

look identical up until you actually pipe their names through xxd and =20=

look at the byte sequence. When this sort of tomfoolery is possible, I =20=

simply cannot trust the names of any of my files anymore.

[1]: http://sailor=E6=9C=88.com/imgs/ignorable.png

>> Again, as someone who grew up in a case-insensitive world, there's no
>> problems here. I wish I could tell you that it causes problems, I =20
>> wish
>> I could agree with you, but I can't.
>
> Probably because you have been surrounded by tools that have a lot of
> extra code to cope with the case insensitive way of life, and learned
> to not do things that are completely valid, just to avoid trouble.
> Which is ok, but I don't think it makes the OS design decision

Extra code? I don't think so. The only reason I'd need extra code is =20
if I were attempting to explicitly detect the "real" filename for a =20
user-supplied argument, by scanning the directory contents until I =20
found a file that was equivalent to the given argument. But there's no =20=

reason to do that. None of the code I've ever written, or any of the =20
code I've ever seen, has had to do any extra work because it was on a =20=

case-insensitive filesystem. I contribute to a packaging system for =20
the Mac called MacPorts, and I've never seen any patches on any of the =20=

4000+ ports to handle case insensitivity (granted, I haven't looked at =20=

every port, but I've looked at a significant fraction). It's a =20
complete non-issue.

The content of files is sacred. The filename is only there to provide =20=

a handle to locate the contents. I don't see any problem with =20
expanding the equivalency scope of the filename to accept multiple =20
encodings and cases. The only arguments I can see that have any =20
validity at all are the ones that sound like "we use case-sensitive =20
filesystems, and your case-insensitivity and normalization are causing =20=

problems with our tools! Conform to our world!". As I said above, this =20=

isn't a problem of case-insensitivity or normalization, it's a problem =20=

of interaction between two incompatible viewpoints. All I want to do =20
is make git play nicer in an HFS+ world, and this would be far easier =20=

if you guys were willing to admit this is a problem that should be =20
solved in the tool rather than a problem with the system.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-11-1049412750
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
DxcNMDgwMTE3MDUyMzQ4WjAjBgkqhkiG9w0BCQQxFgQUoX8GnUmjIuC4GyBQHsRLi7vcYHkwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAMKGzx3R2iPA6M4Db07scyvL42n2PNw220AkIkOK8u6qGVBQadhg3F1G1GtNLIMUTlmnC8Pa
ixjdhNfagQ1OLLYHqE5nPb5bz+bcfQM3St4GsWgIsQhZy3xAPzOxlDrxo/Nl9R9TfjADn5WJ/PZd
7Bu42bliHKKcQCim9btLFOH/ASqZu/DCMp6gcRZsXrgbvfoRLvsKAKgq1Q6BIk8/p1cXAcO/2vaG
HSBqHzfE0d/tztnFv+v9hNLUOVfoT6Bw8MWBLTMVe9YDvMEHuS64WouDzuXJUvFbs6roRhE/yyVN
r+a/U25poIK8SG8O9SkWfRWehnUkncJEY63bw3dtaNMAAAAAAAA=

--Apple-Mail-11-1049412750--
