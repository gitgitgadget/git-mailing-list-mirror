From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 15:39:36 -0500
Message-ID: <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LSU.1.00.0801161531030.17650@racer.site> <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org> <alpine.LSU.1.00.0801161629580.17650@racer.site> <m33asxn2gt.fsf@roke.D-201>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-4-1017960909; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFF43-00045n-M4
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYAPUjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbYAPUjl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:39:41 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:48477 "EHLO
	randymail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753931AbYAPUjj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 15:39:39 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a10.g.dreamhost.com (Postfix) with ESMTP id 0D18110EBF7;
	Wed, 16 Jan 2008 12:39:37 -0800 (PST)
In-Reply-To: <m33asxn2gt.fsf@roke.D-201>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70744>


--Apple-Mail-4-1017960909
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 16, 2008, at 11:46 AM, Jakub Narebski wrote:

>>> More like, Mac OS X has standardized on Unicode and the rest of the
>>> world hasn't caught up yet. Git is the only tool I've ever heard =20
>>> of that
>>> has a problem with OS X using Unicode.
>>
>> No.  That's not at all the problem.  Mac OS X insists on storing =20
>> _another_
>> encoding of your filename.  Both are UTF-8.  Both encode the _same_
>> string.  Yet they are different, bytewise.  For no good reason.
>
> To be more exact encoding used to _create_ file differs from encoding
> returned when _reading directory_...
>
>> Stop spreading FUD.  Git can handle Unicode just fine.  In fact, =20
>> Git does
>> not _care_ how the filename is encoded, it _respects_ the user's =20
>> choice,
>> not only of the encoding _type_, but the _encoding_, too.
>
> ...which means that sequence of bytes differ. And Git by design is
> (both for filenames and for blob contents) encoding agnostic.
>
> HFS+ is just _stupid_. And unfortunately Git doesn't support stupid
> filesystems (e.g. case insensitive filesystems) well.

There's two different ways to do filesystem encodings. One is to have =20=

the fs simply not care about encoding, which is what the linux world =20
seems to prefer. Sure, this is great in that what you create the file =20=

with is what you get back, but on the other hand, given an arbitrary =20
non-ASCII file on disk, you have absolutely no idea what the encoding =20=

should be and you can't display it without making assumptions (yes you =20=

can use heuristics, but you're still making assumptions). Filesystems =20=

like HFS+ that standardize the encoding, on the other hand, make it =20
such that you always know what the encoding of a file should be, so =20
you can always display and use the filename intelligently. It also =20
means it plays much nicer in a non-ASCII world, since you don't have =20
to worry about different normalizations of a given string referring to =20=

different files (it's one thing to be case-sensitive, but claiming =20
that "f=F6o" and "f=F6o" are different files just because one uses a =20
composed character and the other doesn't is extremely user-=20
unfriendly). On the other hand, what you create the file with may not =20=

be what you read back later, since the name has been standardized. =20
It's hard to say one is better than the other, they're just different =20=

ways of doing it. However, I have noticed that everybody who's voiced =20=

an opinion on this list in favor of the encoding-agnostic approach =20
seem to be unwilling to accept that any other approach might have =20
validity, to the extent of calling an OS/filesystem that does things =20
different stupid or insane. This strikes me as extremely elitist and =20
risks alienating what I expect to be a fast-growing group of users =20
(i.e. OS X users).

I'm willing to give Linus a free pass on calling other OS's stupid and =20=

insane, as I don't think Linux would exist as it does today without =20
his strong opinions, but I don't think this should give carte blanche =20=

to the rest of the community for this inflammatory behavior.

I should note that I'm only taking the time to discuss this because, =20
despite the fact that I'm new to git, I really like it and I want it =20
to work better. And one area that it has a problem with is the de-=20
facto filesystem on my OS of choice. However, attempts to discuss the =20=

problem invariable end up with multiple people calling my OS stupid =20
and insane simply because it differs in a particular design decision. =20=

This is not a good way to build a community or to build a better =20
product, and I hope it can be improved.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-4-1017960909
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
DxcNMDgwMTE2MjAzOTM2WjAjBgkqhkiG9w0BCQQxFgQUuScxkPA7r0Wl5te6T/P3cHH01lwwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBABN6HrOkHmo1b8aQFJZVmeYT33sNo1DySfhbmJJZCWBf2x1LfHdqFzdGlo/jlE62w64/3pQJ
65UC7Od0vMO0Hlo9BKC0Iv45oW4aDqEOqED6Stik6jPGFUMhkrga69yvhlnjXMqcNHqZJutKGGBj
YmC/aJEIskijWvgOtcX2cmVsE6pQMl1mDd29G9iWGQEtSvAe/9h78SnEg0LdSLBF3l9oq0Tsb+S1
731HjI5v+oNLPUPtvu9Z8cO9GPdGicIpobyxAzY7tpRCbjUUhAQZlm0Z+KoA2SXj86Jr6JEo1xYa
qcxJrf3AlgR1h1spP4AuLZfVFrM4TZEBatJOqky+AJMAAAAAAAA=

--Apple-Mail-4-1017960909--
