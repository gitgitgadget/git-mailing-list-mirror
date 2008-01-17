From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 19:09:59 -0500
Message-ID: <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-8-1030584087; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFILK-0006QB-Tf
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYAQAKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYAQAKE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:10:04 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:57333 "EHLO
	randymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751830AbYAQAKD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 19:10:03 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a7.g.dreamhost.com (Postfix) with ESMTP id 15B73B751D;
	Wed, 16 Jan 2008 16:10:00 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70780>


--Apple-Mail-8-1030584087
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 16, 2008, at 6:38 PM, Linus Torvalds wrote:

> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>>
>> There's a difference between "looks similar" as in "Polish" vs =20
>> "polish", and
>> actually is the same string as in "Ma<UMLAUT MODIFIER>rchen" vs =20
>> "M<A WITH
>> UMLAUT>rchen". Capitalization has a valid semantic meaning, =20
>> normalization
>> doesn't.
>
> That simply isn't true.
>
> Normalization actually has real semantic meaning. If it didn't, there
> would never ever be a reason why you'd use the non-normalized form =20
> in the
> first place.

My understanding is that normalization is there to help the computer. =20=

That doesn't give it any semantic meaning, because all normal forms of =20=

a given string still represent the exact same string to the user.

> Others have argued the exact same thing for capitalization. "A" is the
> same letter as "a". Except there is a distinction.

The argument for case insensitivity is different than the argument for =20=

normalization. I certainly hope you understand why they are different =20=

arguments, or there's really no point in going further.

> The same is true of "a<UMLAUT MODIFIER>" and "<a WITH UMLAUT>". Yes, =20=

> it's
> the same "chacter" in either case. Except when there is a distinction.
>
> And there *are* cases where there are distinctions. Especially inside
> computers. For one thing, you may not be talking about "characters on
> screen", but you may be talking about "key sequences". And suddenly
> "a<UMLAUT MODIFIER>" is a two-key sequence, and "<a WITH UMLAUT>" is a
> single-key sequence, and THEY ARE DIFFERENT.
>
> See?
>
> "a" and "A" are the same letter. But sometimes case matters.
>
> Multi-character UTF-8 sequences may be the same character. But =20
> sometimes
> the sequence matters.
>
> Same exact thing.

You're right, sometimes the sequence matters. As in key sequences. But =20=

we're not talking about key sequences, we're talking about strings. =20
Just because it matters sometimes doesn't mean it matters all the time.


>> 	The only way to argue that normalization is wrong is by =
providing a
>> good reason to preserve the exact byte sequence, and so far the =20
>> only reason
>> I've seen is to help git.
>
> Git doesn't care. Just use the *same* sequence everywhere. Make sure
> something doesn't change it. Because if something changes it, git will
> track it.

And how am I supposed to use the same sequence everywhere? When I type =20=

"M=E4rchen", I don't know which form I'm typing, nor should I. It's not =20=

something that I, as a user, should have to know. Especially if I pass =20=

this name through various other utilities before using it - I have no =20=

idea if another utility is going to end up normalizing the name, and =20
it shouldn't matter, as they are equivalent strings.

>> How do you figure? When I type "M=E4rchen", I'm typing a string, not =20=

>> a byte
>> sequence. I have no control over the normalization of the characters.
>> Therefore, depending on what program I'm typing the name in, I =20
>> might use the
>> same normalization as the filename, or I might miss. It's =20
>> completely out of my
>> control. This is why the filesystem has to step in and say "You =20
>> composed that
>> character differently, but I know you were trying to specify this =20
>> file".
>
> Pure and utter garbage.
>
> What you are describing is an *input method* issue, not a filesystem
> issue.
>
> The fact that you think this has anything what-so-ever to do with
> filesystems, I cannot understand.
>
> Here's an example: I can type M=E4rchen two different ways on my =20
> keyboard: I
> can press the '=E4' key (yes, I have one, I have a Swedish keyboard), =20=

> or I
> could press the '=A8' key and the 'a' key.
>
> See: I get '=E4' and '=E4' respectively.

On a US keyboard I only have one way of typing =E4, and I have no idea =20=

whether it ends up precomposed or decomposed in the resulting byte =20
stream. And I don't care. Because I'm typing characters, not bytes. I =20=

could be typing in a file in ISO-Latin-1 and I still wouldn't care, =20
because it looks the same to me. If my filesystem did make a =20
distinction between the normal forms, and I see that I have a file =20
named "M=E4rchen", how am I supposed to type that at my keyboard? I =20
don't know which normal form it's using.

The fact that you think the normalization of the string matters, I =20
don't understand.

> And as I send this email off, those characters never *ever* got =20
> written as
> filenames to any filesystem. But they *did* get written as part of
> text-files to the disk using "write()", yes.
>
> And according to your *insane* logic, that write() call should have
> converted them to the same representation, no?
>
>
> Hell no! That conversion has absolutely nothing to do with the =20
> filesystem.
> It's done at a totally different layer that actually knows what it is
> doing, and turned them both into \xc3\xa4 (and then, the email client
> probably will turn this into Latin1, and send it out as a single-byte
> '\xe4' character).
>
> See? Putting the conversion in the filesystem IS INSANE. You =20
> wouldn't make
> the filesystem convert the characters in the data stream (because it =20=

> would
> cause strange data conversion issues) AND FOR EXACTLY THE SAME =20
> REASON it
> shouldn't do it for filenames either!

What a fabulous straw man argument you just put together. I hope you =20
don't need me to point out why this argument is fundamentally flawed.

> And your claim that "you have no control over the normalization of
> characters" is simply insane. Of course you have. It's just not =20
> supposed
> to be at the filesystem level - whether it's a write() call or a =20
> creat()
> call!

I'm speaking as a user, and as such, I shouldn't even have to know =20
that it's possible to write the same character in multiple different =20
ways. As a user, HFS+ behaves exactly the way I want it to. You were =20
talking earlier about not messing with the "user data", but what is =20
the "user data"? It's the string, not the byte sequence. That's all I =20=

care about - the string. That's all the OS cares about, that's all any =20=

application I use cares about, and that's all git should care about.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-8-1030584087
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
DxcNMDgwMTE3MDAwOTYwWjAjBgkqhkiG9w0BCQQxFgQUfRSETo8WGZj5fwDmEeppoGzwbXswgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBABD0FO85nOd9TZAhu41kpUKLH3HpP6HHqSnayc5yqJoKRRVnRN6fdoGyCy8coEHINgtkv7T0
rzWLCzKD4/VjIch0NAUuiPZ/ZF/mvC7Yivvy5NvQ5db7mN2Bdb45EnsALaow2BifpsEeZar3uBxl
AbGQRytb8VGZQimukKyp/iUl8gIZW5lW671uGqNV4y2HRAzyeRRIo1TYzqQAxus9XM4CxEqAbI53
vcE5kxdL1gwAGRYEr+fyq8p9Sl+3k/50GLuFe6+Alo/C6pjRfOd5eL7h1UdkS2IxbKXu9dKWLJ5Y
JMslYbpln8e/1N2/YdOf9vcEyn5pDFjr/Blh5Q9pXhEAAAAAAAA=

--Apple-Mail-8-1030584087--
