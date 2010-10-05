From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 05 Oct 2010 10:00:25 +0200
Message-ID: <4CAADB19.30707@drmicha.warpmail.net>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>	<201010041851.46838.ComputerDruid@gmail.com>	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>	<201010041959.48336.ComputerDruid@gmail.com> <AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Stephan Hugel <urschrei@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 10:00:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P32Rh-0006YT-BC
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 10:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab0JEIAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 04:00:14 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60276 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755968Ab0JEIAN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 04:00:13 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CEACB492;
	Tue,  5 Oct 2010 04:00:12 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 05 Oct 2010 04:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Jb2C/TY/GSI/WDYW4AFHRyBXPAY=; b=p71MgWjnr/X8jkEv9DON6AmJyg/IRE6F2EUs1SN23Dth4iM4nhvFi4TOMadBrcm9UtQR8DOZBsxBVMLRtDirO1gxN4ji86LcIyvi9l7Az/ECC4D7D+L6ABo4q0B5LZx0IjP0uwaByeI0fQWH+ZDB1nWw8VeIdcGKi7WWlKg732g=
X-Sasl-enc: gsmAZyZJQb6pCnIecvFv5BuTK5mklNyLHDR2Hay1AKqv 1286265612
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 38378406B36;
	Tue,  5 Oct 2010 04:00:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158175>

Stephan Hugel venit, vidit, dixit 05.10.2010 02:17:
> On 5 October 2010 00:59, Daniel Johnson <computerdruid@gmail.com> wro=
te:
>> On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:
>>> Daniel,
>>> Those are the exact steps I'm using.
>>>
>>> When I run tag -v on existing tags, I don't see the
>>>
>>> -----BEGIN PGP MESSAGE-----
>>> Version: GnuPG v1.4.9 (Darwin)
>>>
>>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
>>> yZeXw/EddYrfdad/VvOrL1o=3D
>>> =3D/0PJ
>>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>>
>>> block. It's only present on tags created using the current version.
>>> I've also just upgraded to GnuPG 1.4.10, but the result is the same=
=2E
>>> I'm not sure how else I can determine where the problem arises; I'm
>>> using the git and GnuPG versions for OS X built by homebrew, and Gn=
uPG
>>> is happy to use the same key for en/decryption and signing. I've al=
so
>>> verified that none of the subkeys are expired, and that the trust d=
b
>>> is OK.
>>
>> If you have the tests available, can you try running t7004 to see if=
 it fails
>> there too?
>>
> I rebuilt and installed from source
> Passed all 105 tests in t7004-tag.sh
> Problem remains with tags I create
>=20
> This would seem to imply a problem with my key, even though nothing
> else is complaining about it.

Here's a very basic way to check: If foo is your tag, do

git cat-file tag foo > a
git cat-file tag foo > a.sig

=46rom the file "a", delete the signature (everything lines between and
including "-----BEGIN/END PGP SIGNATURE-----"), invoking an editor or
your favorite sed/awk/perl magic.

a is the data on which git invoked gpg for signing the tag. (I'm not
sure why gpg can't notice the inline sig directly but that doesn't
matter; maybe because it is none ;))

Now, gpg --verify a.sig should check the signature a.sig for a. Doing
that, maybe with --verbose, you may find out whether the tag object is
bogus or git misunderstands gpg's response. If your key is on a key
server you can also share the file a.sig with us so that we can check.

Michael
