From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 23:07:25 -0500
Message-ID: <A4CE8450-E470-4F32-BCBD-05BF9A458D87@sb.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org> <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org> <85zlv5nvge.fsf@lola.goethe.zz> <B2E52451-5153-4EFD-ADBE-AACDCEF6169E@simplicidade.org> <D32FF2AF-EA90-4737-8320-836B52AF4612@wincent.com> <alpine.LSU.1.00.0801170106390.17650@racer.site> <alpine.LFD.1.00.0801161717160.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-9-1044829700; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Pedro Melo <melo@simplicidade.org>,
	David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 05:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFM35-0008Eg-Br
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 05:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYAQEHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 23:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbYAQEHg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 23:07:36 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:55272
	"EHLO randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752182AbYAQEHg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 23:07:36 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 46807EF2CC;
	Wed, 16 Jan 2008 20:07:31 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801161717160.2806@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70821>


--Apple-Mail-9-1044829700
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 16, 2008, at 8:41 PM, Linus Torvalds wrote:

> On Thu, 17 Jan 2008, Johannes Schindelin wrote:
>> On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
>>
>>> El 17/1/2008, a las 1:40, Pedro Melo escribi=F3:
>>>
>>>> That's the point I'm making. The fact that I need to set LANG =20
>>>> across
>>>> all users of a project is insane...
>>
>> FWIW if you use another filesystem, such as reiserfs or ext[2-4], the
>> filenames will be _unaffected_ by your particular setting of LANG.  =20=

>> They
>> will be stored byte-wise exactly like asked for.  That's why I call =20=

>> them
>> "sane".
>
> One of the advantages (the biggest one, in fact, apart from the =20
> obvious
> US-ASCII down-compatibility and the fact that you can do C-compatible
> NUL-terminated strings) of UTF-8 is that it's locale-independent, and
> doesn't care about LANG, because it's valid in all languages.
>
> And that's really important. It's important for a very simple reason:
> there is almost never such a thing as "a locale" except for US-=20
> ASCII. Once
> you move away from US-ASCII, it actually tends to be much more =20
> common that
> you have a *mixture* of locales - often in the same "document" - =20
> than to
> have one single locale.
>
> It very much happens even in filenames - people "mix" locales in =20
> trivial
> ways even within a single pathname component (non-US-ASCII filename, =20=

> but
> with a regular file extension), but much more interestingly they do so
> within a directory tree (ie you have have translation subdirectories =20=

> where
> the filenames themselves are in another language, and you can have =20
> full
> pathnames where different components are in different languages, for
> example).
>
> And UTF-8 is _wonderful_ for this, because LANG doesn't matter, and
> cannot matter, and thus mixing isn't a problem.
>
> Of course, you can screw it up. Locales still can change things like =20=

> sort
> order and capitalization etc, so even if you use UTF-8, you sure can =20=

> get
> into trouble with LANG and thinking that a per-session locale makes =20=

> sense.
>
> So choosing UTF-8 for the filesystem isn't wrong per se. It's a fine
> choice, and has no issues with LANG in itself. Limiting it to strictly
> valid UTF-8 encodings is also fine. Limiting it (further) to only
> character normalized UTF-8 is also fine.
>
> Most Linux filesystems don't limit it in any way, so you can make
> filenames that aren't valid UTF-8 at all, much less normalizing
> multi-character sequences.
>
> I personally think that's the best option, but I probably do so mostly
> because I know some people still use Latin1 as their only locale =20
> (and I
> suspect Asia will take decades before it has converted to UTF-8 and =20=

> will
> also have cases where they use other non-UTF locales).
>
> But enforcing clean UTF-8 is not a bad idea per se. Not allowing byte
> sequences that aren't a valid UTF-8 encoding (eg \xc0\xc0 is not a =20
> valid
> UTF-8 character) is fine.
>
> I wouldn't call people crazy for doing that, although it does mean =20
> that
> you cannot, for example, decide to write a Latin1 filename (which is =20=

> not
> necessarily a *good* idea in this day and age, but I think there's a
> difference between "that's not a good idea" and "you cannot do that").
>
> And even limiting the UTF-8 charset further to only the minimal
> representation of one particular glyph (ie not allowing multi-=20
> character
> sequences that can be represented more simply) may be even *more*
> big-brother, but would at least not cause the technical aliasing =20
> issues. I
> personally think that's so controlling as to be stupid (and has no =20
> real
> advantage), but hey, at least it doesn't *corrupt* anything silently.
>
> So I think that using UTF-8 as a character encoding is a *good* =20
> thing to
> do, and that automatically means that LANG shouldn't matter for =20
> filenames,
> but within that choice of UTF-8 there are still mistakes that you can
> make. Notably multi-character normalization and case-insensitivity.
>
> 			Linus

Alright, you've made your point, and I'm willing to concede at least =20
some of what you've said. So perhaps we can now move onto the more =20
relevant and practical issue of: HFS+, despite how stupid it may or =20
may not be, normalizes filenames (and is case-insensitive, which is a =20=

related issue). This causes a problem with git. How can this be solved?

I'm more than willing to do work to solve it, my biggest issue is I =20
don't believe I actually have the free time to learn the git internals =20=

well enough to actually do proper work on what I would assume is a =20
fairly performance-critical section of git's code. However, I would be =20=

happy to work with others who are perhaps more knowledgeable in this =20
area.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-9-1044829700
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
DxcNMDgwMTE3MDQwNzI1WjAjBgkqhkiG9w0BCQQxFgQUp0Z5Z2FCFf8Twetj4Mx5u3lIf14wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAFdrY1237gpdBdyx1p50gWaP3hiWdV/KICIUBWhmHH2Jksg5MbWEE1piibctrumrf4ag+Ytj
p5TxISMRwzebVPqz8LySTvTosC292SwEHvdvRkaRGfQ9jWPp0llkGdNXAj8e7pulzH4bR2b/NpLr
QLDTxgMpepfkgxvlYP+EyLELWap3ALig8fFLzR0gNv5xABvqyVNoNu5gGlkGSA3BCAMi/1MqDx3d
PzxqX404KSU9KwzfTvnKP68gDiJubRREbAOAT0uLpGEH+SXAu3nWrYgWwSYdkw8ugBSCTREzKhXi
1RAW6AT3rpa9CzDPke73LaBWa0Sz9M05fd2BcKkNg40AAAAAAAA=

--Apple-Mail-9-1044829700--
