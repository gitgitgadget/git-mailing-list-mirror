Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8471F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbfA3TFN (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:05:13 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:38764 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727760AbfA3TFM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 14:05:12 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UIudpf029962;
        Wed, 30 Jan 2019 11:05:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-type : from : message-id : subject : date : in-reply-to : cc : to
 : references; s=20180706; bh=pQOFHPR31sPP6+FCb9/Vf5/6LIqbJI6Cn7i0iUOkQ1M=;
 b=j32g5+m7KJJuoC28gCMRHgri6LhYFyT3id+2Op/kfFwClxa0C4P6o7h8vAEiKenG9fSr
 MJLDOmppC/yfIK4WXa4pBcS20TE1lW2SeYfKLUN18bHNoM1MKfMKOK46aYqsmnUlVv2I
 Rt0JdspqmBfhpb5m0JHAmhrFDIU0H2v77iEssgsyf+tspYkfgXJQA7i8eywQYCiDSsqo
 icR4J2l9T99fcsNaKf9AQH+bcdVhPMyyoA+s69JYpHyhlV8eM09jynzb6cH+ybiDFCPC
 U85N/41+OK7FTly9e0+82i3LZAoAGzwdA1i+S7K3bbbNWLSPCjralMFmOmEO2BCOgTbv UQ== 
Received: from mr2-mtap-s01.rno.apple.com (mr2-mtap-s01.rno.apple.com [17.179.226.133])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0ss4k3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 11:05:01 -0800
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_88zu/2fcdFPTdUtGFFuY1g)"
Received: from nwk-relayp-sz02.apple.com
 (nwk-relayp-sz02.apple.com [17.128.113.117]) by mr2-mtap-s01.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500MHTRODJJ70@mr2-mtap-s01.rno.apple.com>; Wed,
 30 Jan 2019 11:05:01 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500300RGS2600@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:05:00 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: cde6a04dae4707faf9fc200f9b459f9d
X-Va-R-CD: ca029025e396ee10c82cdcd2be6f1045
X-Va-CD: 0
X-Va-ID: d411e9fe-de57-4825-93d9-ff9733973d56
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: cde6a04dae4707faf9fc200f9b459f9d
X-V-R-CD: ca029025e396ee10c82cdcd2be6f1045
X-V-CD: 0
X-V-ID: b9a5790a-3f5e-46c1-8d57-fe5411fdd3f1
Received: from process_milters-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500100REE0W00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:04:58 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_14:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM50021FROANY50@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:04:58 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Message-id: <EC84411B-52FF-471B-BDDB-D004DFB4CE97@apple.com>
Subject: Re: [PATCH (Apple Git) 03/13] t0500: New regression test for git add
 of a path that contains a .git directory
Date:   Wed, 30 Jan 2019 11:04:58 -0800
In-reply-to: <nycvar.QRO.7.76.6.1901301355140.41@tvgsbejvaqbjf.bet>
Cc:     git@vger.kernel.org, peff@peff.net
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-4-jeremyhu@apple.com>
 <nycvar.QRO.7.76.6.1901301355140.41@tvgsbejvaqbjf.bet>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_14:,,
 signatures=0
X-Proofpoint-AD-Result: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Boundary_(ID_88zu/2fcdFPTdUtGFFuY1g)
Content-type: text/plain; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT



> On Jan 30, 2019, at 05:12, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Jeremy,
> 
> On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:
> 
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> 
> As Eric pointed out, commits with such a vanishing commit message are
> very, very sad commits. And somewhere, a kitten dies every time you submit
> such a commit.

Yes.  I removed the commit message once upstream git finally fixed the issue and the commit message no longer applied.  I didn't add a new verbose message because I was under the impression the git community did not want to receive any contribuitions (bug reports, feedback, upstreamed patches) from Apple, and the radar provided all the reference I needed.  If that situation is changing (as it seems to possibly be), I'm happy to update this with details about the issue.  Here's the thread from 2011-2014 about the issue.


--Boundary_(ID_88zu/2fcdFPTdUtGFFuY1g)
Content-type: message/rfc822; x-unix-mode=0644;
 name="Re: [PATCH git] setup: Do not strip trailing _ from paths.eml"
Content-disposition: attachment;
 filename="Re: [PATCH git] setup: Do not strip trailing _ from paths.eml"

Date: Mon, 22 Sep 2014 14:46:40 -0700
From: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: Re: [PATCH git] setup: Do not strip trailing / from paths
In-reply-to: <5616AB22-EF27-4989-8394-65F5CE691AD6@apple.com>
To: martinerikwerner@gmail.com, pclouds@gmail.com, gitster@pobox.com,
 Junio C Hamano <gitster@pobox.com>, carenas@sajinet.com.pe
Message-id: <36630E0E-3B48-4C15-A1EB-FD2917A697A7@apple.com>
MIME-version: 1.0 (Mac OS X Mail 8.0 \(1985.6\))
Content-type: multipart/signed;
 boundary="Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0";
 protocol="application/pkcs7-signature"; micalg=sha1
X-Smtp-Server: phonehome.apple.com:jeremyhu
X-Universally-Unique-Identifier: 6563D6AA-7D96-4F90-9074-0694B34C1A76
References: <80D13461-9FBE-4228-8927-C1D36B3ACDE4@apple.com>
 <B697F375-DCDA-401E-A45B-0E80550F0054@apple.com>
 <7vzkh7fmmp.fsf@alter.siamese.dyndns.org>
 <6DE7C010-AF6B-4C22-9771-A4F94D59609D@apple.com>
 <5616AB22-EF27-4989-8394-65F5CE691AD6@apple.com>


--Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

FWIW, it seems that this bug was addressed by =
ddc2a6281595fd24ea01497c496f88c40a59562f

Thanks Martin, now we're no longer carrying around an extra patch for =
our build of git ;)

--Jeremy

> On Oct 17, 2011, at 14:55, Jeremy Huddleston <jeremyhu@apple.com> =
wrote:
>=20
> ping.  Did you get my response below with extra details?  I just got a =
duplicate bug report, so it apparently effects people...
>=20
> Please let me know if I can be of further assistance.
>=20
> On Oct 11, 2011, at 2:17 PM, Jeremy Huddleston wrote:
>=20
>> Thanks for your response Junio.  The text of the original bug report =
is below.
>>=20
>> I created a git bisect test script which bisected the problem and =
found out that the difference was that the trailing / was removed by =
your code change.  git treats paths with a trailing / differently.  I =
don't know *why* it treats them differently, but it does.
>>=20
>> There's nothing "special" about JustDoItGit.tar.bz2 except that it =
contains a .git dir and has a file layout that works with the bisect =
script I wrote.  You can test this yourself by:
>>=20
>> mkdir -p ~/tmp/PR-10238070
>> cd ~/tmp/PR-10238070
>> tar xjf JustDoItGit.tar.bz2
>> cd ~/git-checkout
>> /path/to/test_10238070.sh
>>=20
>> Here's the original report:
>>=20
>> I've tracked the cause of '<rdar://problem/10160992> ##snipped =
title##' down to a regression in git.
>>=20
>> Unzip the attached JustDoItGit.zip project and replace the path in =
the following commands to the unzipped location on your system:
>>=20
>> #delete git in /usr/bin/git
>> sudo rm -r /usr/bin/git
>> #link it to /usr/local/bin/git since that's where ditto will place =
the new bits
>> sudo ln -s /usr/local/bin/git /usr/bin/git
>>=20
>> # first, install git 1.7.3.2 to verify that the bug does not =
reproduce
>> sudo ditto ~rc/Software/Slate/Roots/Git/Git-14~19.root/ /
>> sudo rm -r /Users/<you>/MyGitRepo.gitdir
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir init --bare --quiet
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ add -- =
/Users/<you>/Desktop/JustDoItGit/ =
/Users/<you>/Desktop/JustDoItGit/JustDoItGit/JustDoItGitAppDelegate.h =
/Users/<you>/Desktop/JustDoItGit/JustDoItGitTests
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ commit =
-m "Hello."
>>=20
>> The expected result of the commit is something like "18 files =
changed, 7364 insertions". If that's what you get, great, now keep =
going.
>>=20
>> sudo rm -r /Users/<you>/MyGitRepo.gitdir
>> # install the slate version of git, 1.7.5.4
>> sudo ditto ~rc/Software/Slate/Roots/Git/Git-19.root~2/ /
>> sudo rm -r /Users/<you>/MyGitRepo.gitdir
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir init --bare --quiet
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ add -- =
/Users/<you>/Desktop/JustDoItGit/ =
/Users/<you>/Desktop/JustDoItGit/JustDoItGit/JustDoItGitAppDelegate.h =
/Users/<you>/Desktop/JustDoItGit/JustDoItGitTests
>> git --git-dir=3D/Users/<you>/MyGitRepo.gitdir --work-tree=3D/ commit =
-m "Hello."
>>=20
>> The expected result is what's above, something like "18 files =
changed, 7364 insertions". But the actual result is that only the root =
folder "/Users/<you>/Desktop/JustDoItGit is added
>>=20
>> This is a problem because it subsequently causes =
<rdar://problem/10160992> ##snipped title##
>>=20
>> =85 and therefore breaks Xcode's snapshots feature.
>>=20
>> <JustDoItGit.tar.bz2><test_10238070.sh>
>>=20
>> On Oct 11, 2011, at 10:45, Junio C Hamano wrote:
>>=20
>>> Jeremy Huddleston <jeremyhu@apple.com> writes:
>>>=20
>>>> real_path will strip the trailing / from provided paths.  This =
fixes
>>>> a regression introduced in 18e051a3981f38db08521bb61ccf7e4571335353
>>>=20
>>> What is the breakage? The above does not explain why stripping the =
'/' is
>>> a wrong thing, and which caller that used to work is broken by that
>>> behaviour.
>>>=20
>>> A new test block in some of the t/t[0-9]*.sh script to demonstrate =
the
>>> breakage and fix to explain and justify your fix better, please?
>>>=20
>>>>=20
>>>> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
>>>> ---
>>>>=20
>>>> Here's an updated version that should be a bit more portable and =
warning-free.
>>>>=20
>>>> setup.c |   10 +++++++++-
>>>> 1 files changed, 9 insertions(+), 1 deletions(-)
>>>>=20
>>>> diff --git a/setup.c b/setup.c
>>>> index 61c22e6..e3a8ae3 100644
>>>> --- a/setup.c
>>>> +++ b/setup.c
>>>> @@ -10,8 +10,16 @@ char *prefix_path(const char *prefix, int len, =
const char *path)
>>>> 	char *sanitized;
>>>> 	if (is_absolute_path(orig)) {
>>>> 		const char *temp =3D real_path(path);
>>>> -		sanitized =3D xmalloc(len + strlen(temp) + 1);
>>>> +		sanitized =3D xmalloc(len + strlen(temp) + 2);
>>>> 		strcpy(sanitized, temp);
>>>> +
>>>> +		temp =3D strrchr(path, '\0');
>>>> +		temp--;
>>>> +		if (*temp =3D=3D '/') {
>>>> +			char *s =3D strrchr(sanitized, '\0');
>>>> +			s[0] =3D '/';
>>>> +			s[1] =3D '\0';
>>>> +		}
>>>> 	} else {
>>>> 		sanitized =3D xmalloc(len + strlen(path) + 1);
>>>> 		if (len)
>>>=20
>>=20
>=20


--Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMYDCCBiQw
ggUMoAMCAQICAwjX0jANBgkqhkiG9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
MB4XDTE0MDIwMjA3NDkxNFoXDTE1MDIwMjIyMzIyMVowQDEbMBkGA1UEAwwSamVyZW15aHVAYXBw
bGUuY29tMSEwHwYJKoZIhvcNAQkBFhJqZXJlbXlodUBhcHBsZS5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCs/FRWSmiSFp31NL8sK5WUBkjRon8LF/fN6GMOGfc22/hjr0nHRuyf
jgAS7PcS+3d2Lctzxo0XafFe9KqNKlyigOLoWt+3OznLKPrMhfOyO3TeYAZw8qV6GkVW7aE3IEUa
n3EDD/fp878tDkRnJLR3JliT910CNjB7kkJZNrVhVG4Blm/WfR0sjwHCmxwBCwTrUIWmItgjfiBV
YTS8EtsO9fsstxUEUWw/BfrKteloDdZKChDgsU3d7e7VXoxrPPgs1vZkzimIzBC/d8I0LFFG3cfh
g6A2jXd7B1Nw7RQMFJYnlM65Aw3w/AOVILAY275anOX9uV/ipdNU+H/978wPAgMBAAGjggLYMIIC
1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
HQYDVR0OBBYEFMcuWXwlJvxAGpIm3uh2Vbg0rl/7MB8GA1UdIwQYMBaAFFNy7ZKc4NrLAVx8fpY1
TvLUuFGCMB0GA1UdEQQWMBSBEmplcmVteWh1QGFwcGxlLmNvbTCCAUwGA1UdIASCAUMwggE/MIIB
OwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9w
b2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhv
cml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUg
Q2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5
LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9m
IHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8v
Y3JsLnN0YXJ0c3NsLmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUF
BzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYB
BQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNh
LmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQAD
ggEBADouKlHJdkf8gg3eUEfdWNFuvgVH2mNunCzbCqaKg7CddZa0fiNslqExM2MLxAmlAYsRE3yy
8XLEnk6MjVYST8eRA2CnHHb6GUbf02GGwdpzEXQ0F9s9+2dBMsWshsFUrpcGiDDgsnkQnX8RbWvl
c9ffpOt06p+LjoAmEbKoTOI4aopu6tyk82Kcv7CjQ58/XBGO5Z80QDm//lEjhFFK8Ab0ayZAQBLF
wDubnz9ZTBLactBCbkauNU29c8hexW3JPgca6JpK4jK53xK1mnF1yCgCvFNJ3V0EaSqFCzX8iGZx
uewQDYAuenhU5sxHglEtP7hPJTNLyf9z72xQcrZ3Ci8wggY0MIIEHKADAgECAgEfMA0GCSqGSIb3
DQEBCwUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQsw
CQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0
YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5
IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDH
CYPMzi3YGrEppC4Tq5a+ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0t
svVCk6U9b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIq
u54qzHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX
9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/4ebf
eZuCYKzN2P8O2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8EBTADAQH/
MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHwYDVR0jBBgw
FoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsGAQUFBzABhhtodHRw
Oi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9z
ZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDCBgAYDVR0g
BHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1l
ZGlhdGUucGRmMA0GCSqGSIb3DQEBCwUAA4ICAQCOgcqzJYsauaYgW9ZtyUQ0XyDV0CCOTk/E1qnm
c/M7Hvb7e31GR2j1SxXlmJY/AfQQNrh4Rn8mbT7cn9J2LZxTyoO8Ykl1/2qRNemxX2HbR5Gt6rqT
IIGadfjmZrQHUTv00Yo+Qtm1dqPpCH/udy31mr9rcOqSAsXyTvR645ex22KN/pd7pfWFQeUlShvF
i5jApKZu7YtWeCzmBdGOQBt3fAKmEt/+WlFkDf2UDeATK7l0iRhWBWAQ8bu40wWwVvZdpuLv7PNH
vo5CfT/Vw13jrHJQrHQLWOBdgv5Dh++o+n8IgASi8eOeAZEzLbpLbPzy7c6yMt+6FdFE4spJnBQl
0pnNYEJPsc9ubxrPw9+lXvC/tgPie4nVGD/NwNcEuCS4G+EOyRc5f5aizviAzPgBh/XLo6H4Oz45
dh3cg6txTp+3gM9mTzfsxs3rOfxPKytUJ07JPbSLIu0ESD3QAU54QvCJjmjY1ZAfSRlCdgQF8FSw
eQ6vUhHZxoslnUu2vX2/k38vA9sLjgPZnrVdIVJazzBwpibWUWxWQIzpUKyoTDOYRN9UGpdhxejp
H1YbRNJ76oI+nS7d/O9csUmIdd3NDgRepGT0fUoIo9xmYQMBDbBEiNOuVoNAUUqArVgekcQE88CM
iBoA/xpvLj6fnL/TrUqw0cDYxqYTfjEPNaFYeTGCA28wggNrAgEBMIGUMIGMMQswCQYDVQQGEwJJ
TDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlm
aWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAwjX0jAJBgUrDgMCGgUAoIIBrzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNDA5MjIyMTQ2NDFaMCMGCSqGSIb3DQEJBDEWBBTV/l5RMROl
BmwQMI+JbJBma4bY8DCBpQYJKwYBBAGCNxAEMYGXMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2ln
bmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGll
bnQgQ0ECAwjX0jCBpwYLKoZIhvcNAQkQAgsxgZeggZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVu
dCBDQQIDCNfSMA0GCSqGSIb3DQEBAQUABIIBAFKDKMZw3Ax9Xnq5++xsJebMXmnSSwEp9jY/t6lM
rfmmT3IQJyNlIiizX+B+TgwsGuc463AxN+hZIA75OAYa3gV6UdkITmzRwIezT/EubmEJzCmCbcd5
feB7qeiHb3KMmVr2V2KzuHMDLxWErOGupSSTrmk+aDBt5NhDAUev1mdvU1jZTnm8tr4korSGwCMe
bh1D+QTknWzE0pJV8ACT+I3GnSF+vdVrdNrXX0p23yepMndCQHdUxx+2LkmzbWtUbe+tCnbNLwQh
d31gWGflzNy2H/CRbmzdOnS8uwpW6abV8f2N5qGKWQuVRbhuMKuSx7zgdveNBIzjdWfBhIGQCC8A
AAAAAAA=
--Apple-Mail=_5EEC33B4-8A87-41A2-9C62-ABA420AC41A0--

--Boundary_(ID_88zu/2fcdFPTdUtGFFuY1g)
Content-type: text/plain; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT



The problem was related to real_path not stripping the trailing '/' from paths which confused clients of prefix_path().  This caused the behavior used in the script to fail.  The issue was eventually fixed in ddc2a6281595fd24ea01497c496f88c40a59562f, so all that remains is our test for the original issue.  This test script mimics the behavior of the Xcode snapshotting feature that triggered the problem, which is what uncovered the original issue.

>> +test_expect_success '<rdar://problem/10238070> -- git add of a path that contains a .git directory' '
>> +	rm -rf .git &&
>> +	mkdir -p orig/sub/dir/otherdir &&
>> +	cd orig/sub &&
>> +	echo "1" > dir/file &&
>> +	echo "2" > dir/otherdir/file &&
>> +	git init --quiet &&
>> +	git add -A &&
>> +	git commit -m "Initial Commit" --quiet &&
>> +	cd - > /dev/null &&
>> +	git init --bare --quiet "${TESTROOT}/git_dir.git" &&
>> +	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ add -f -- "${TESTROOT}/orig/sub/" &&
>> +	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ add -f -- "${TESTROOT}/orig/" &&
>> +	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ commit -m "Commit." |
>> +		grep -q "2 files changed, 2 insertions"
>> +'
> 
> Let's try to waste some time and reverse engineer what this test is about,
> shall we?
> 
> So first the .git directory is removed. I really have to wonder why
> because we seem to do pretty much everything after that outside of that
> directory, so I bet that the test would do the exact same thing without
> mucking with that .git directory.
> 
> The some submodule with nested directories is set up (we could do this
> much easier by using `mkdir orig && git init orig/sub && test_commit -C
> orig/sub 1 && mkdir orig/sub/dir & test_commit -C orig/sub dir/2`, but
> let's look further before suggesting a better way to implement this).
> 
> Then a bare directory is created *somewhere*, and then the submodule as
> well as its parent directory is added.
> 
> Finally, a commit is created with that new index.
> 
> So is the problem that this test tries to catch that a directory
> containing a submodule is added together with its .git directory?
> 
> I could understand that, I would understand that you would add a
> regression test to catch this, but since it is added with
> `test_expect_success`, I would expect this regression to be fixed for a
> long time (and probably be committed together with a regression test that
> verifies the very same as your new test).
> 
> Okay, so I give up on analyzing this further and simply go back to the
> indicated commit introducing the regression, and applying your patch on
> top, to see whether it fails. Because there is nothing Apple-specific
> about it, I'll do this in an Ubuntu VM (because I have no Apple hardware
> handy, so the only way for me to debug this on macOS would be via Azure
> Pipelines, which is tedious and slow).
> 
> But no, this test fails with or without 18e051a3981f (setup: translate
> symlinks in filename when using absolute paths, 2010-12-27) reverted.
> 
> So the ball is squarely back in your court: care to explain what the
> haggling heck your patch is trying to achieve?
> 
> Thanks,
> Johannes
> 
>> +
>> +test_done
>> -- 
>> 2.20.0 (Apple Git-115)
>> 
>> 


--Boundary_(ID_88zu/2fcdFPTdUtGFFuY1g)--
