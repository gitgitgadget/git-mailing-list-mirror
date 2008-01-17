From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 08:44:37 -0500
Message-ID: <15C01F6E-052B-401C-B189-833CBAB20787@sb.org>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org> <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com> <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org> <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com> <AD012876-3B4A-41EE-8CCB-F60D5C812903@gmail.com> <17846BF5-1215-4C28-8BBC-2C745A053156@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-12--1068021330; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Mitch Tishmack <mitcht.git@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 14:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFV3R-0005E7-4s
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 14:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbYAQNom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 08:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYAQNom
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 08:44:42 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:37889 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751904AbYAQNol (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 08:44:41 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 4E688AF827;
	Thu, 17 Jan 2008 05:44:40 -0800 (PST)
In-Reply-To: <17846BF5-1215-4C28-8BBC-2C745A053156@wincent.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70862>


--Apple-Mail-12--1068021330
Content-Type: text/plain;
	charset=WINDOWS-1252;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 17, 2008, at 5:22 AM, Wincent Colaiuta wrote:

> El 17/1/2008, a las 8:11, Mitch Tishmack escribi=F3:
>
>> I was going to post this earlier, but wanted to search the archives =20=

>> first. Here are the commands assuming you don't want to or can't =20
>> partition a drive and format as ufs (I don't care for HFS+ much). I =20=

>> can't believe I didn't find the command in the git list archives, =20
>> so voil=E0:
>>
>> $ hdiutil create -size 300m -fs UFS foo.dmg
>> =
..........................................................................=
.....
>> created: /Users/mitch/foo.dmg
>> $ hdiutil attach foo.dmg
>> /dev/disk2          	GUID_partition_scheme          =09
>> /dev/disk2s1        	Apple_UFS                      	/Volumes/=20
>> untitled
>> $ cd /Volumes/untitled && git clone git://git.kernel.org/pub/scm/=20
>> git/git.git
>> ... snipped ...
>> $ cd git && git status
>> # On branch master
>> nothing to commit (working directory clean)
>>
>> After git clone in HFS+ land...
>> $ git status
>> # On branch master
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #	gitweb/test/Ma=CC=88rchen
>> nothing added to commit but untracked files present (use "git add" =20=

>> to track)
>>
>> Should I just add this to the wiki?
>
> Definitely.
>
>> Then we can all go back to ignoring the insane filesystems.
>
> While it's a nice workaround, it really is just that (a workaround) =20=

> because performance will be suboptimal in a repository running on a =20=

> disk image (and many of switched to Git because of its speed).

Not only is it suboptimal, it's also not acceptable, plain and simple. =20=

If an individual wants to do that, sure, but it's simply not an =20
appropriate solution in general for this problem. I certainly don't =20
want to have to attach a disk image every time I want access to =20
anything I keep in a git repo, nor do I want to be restricted to =20
keeping everything within a certain filesystem on disk. Additionally, =20=

while I'm not certain it's impossible, it's certainly very difficult =20
to attach a disk image without anybody logged into the system at the =20
GUI, as diskarbitrationd won't be running.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-12--1068021330
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
DxcNMDgwMTE3MTM0NDM4WjAjBgkqhkiG9w0BCQQxFgQUo5xWK0Z4YQTR5BkoSEXy8PlUwFgwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAG9kCqHzTwwZewgO5KFyfjF2H1ORziqiJ+g9zJ1kVhN6zoi9t3cHQ4GIqNEXpS1U33LI7t6A
KxJ3HLGZTWiquzQR3XXg2nzyGLe+HAK0nRxWM821zol6ZrCmy6GmHKkg1CkUP3DjUeAWWW6KA6p4
PQFN4hflAUgA1BUYXdpfh/j18PiEkHl2DlcJpSX6ey6cqwujTqxpxNhWcacZJcPMVv4+hGGH75fw
F9zZ3mXj2n2Von8c4APQzhiT+rNSOVa9h63NirXhcDcDwnEGWBnRnDJ6EJmC4R9MGT4zM2LHG4Ks
4l+brh73dQ6vy7sJYDnVcQhLBnMfmB8xMMBNswiX8/YAAAAAAAA=

--Apple-Mail-12--1068021330--
