From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Sun, 02 Sep 2007 18:09:09 +0200
Message-ID: <46DAE025.900@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigECD20048A3E84A04E2193027"
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 18:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRs0s-0000Mm-8H
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbXIBQJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbXIBQJV
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:09:21 -0400
Received: from esparsett.troll.no ([62.70.27.18]:49753 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbXIBQJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:09:20 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 06C027420A; Sun,  2 Sep 2007 18:09:19 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 95167741B1; Sun,  2 Sep 2007 18:09:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com>
X-Enigmail-Version: 0.95.3
OpenPGP: id=34EB4437
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57344>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECD20048A3E84A04E2193027
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Reece Dunn wrote:
> On 02/09/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
>> This gives us a significant speedup when adding, committing and stat'i=
ng files.
>> (Also, since Windows doesn't really handle symlinks, it's fine that st=
at just uses lstat)
>>
>> +               if (ext && (!_stricmp(ext, ".exe") ||
>> +                           !_stricmp(ext, ".com") ||
>> +                           !_stricmp(ext, ".bat") ||
>> +                           !_stricmp(ext, ".cmd")))
>> +                       fMode |=3D S_IEXEC;
>> +               }
>=20
> This breaks executable mode reporting for things like configure=20
> scripts and other shell scripts that may, or may not, be executable.=20
> Also, you may want to turn off the executable state for some of these
> extensions (for example if com or cmd were not actually executable=20
> files). This makes it impossible to manipulate git repositories=20
> properly on the MinGW platform.

Actually, you don't really need the EXEC bit for Git to work. I just
added it for completeness. (We _could_ remove that too, since it's
slowing us down slightly ;-)

Remember that Git isn't using MSys for its builtins, so MinGW Git
doesn't understand the MSys notion of executable files anyways.
The MinGW port actually peeks at the beginning of a file (ignoring exe
files), and sees if there's an interpreter there. If there is, it will
expand
    git-foo args...
into
    sh git-foo args...
and execute the command. So, it's not really affected by this change.

I haven't had any problems with this patch on my system, so could you
explain what you mean with 'this makes it impossible to manipulate git
repositories'?

> Would it be possible to use the git tree to manage the executable=20
> state? That way, all files would not have their executable state set=20
> by default on Windows. The problem with this is how then to set the=20
> executable state? Having a git version of chmod may not be a good=20
> idea, but then how else are you going to reliably and efficiently=20
> modify the files permissions on Windows?

The file-state-in-git-tree belongs in a different discussion. Have a
look at the '.gitignore, .gitattributes, .gitmodules, .gitprecious?,
=2Egitacls? etc.' and 'tracking perms/ownership [was: empty directories]'=

threads. Permissions are not a trivial topic, since systems represent
them differently. This patch just tries to reflect the read, write and
execute permissions as normal Windows would; and it only cares about
file extensions (and the PE header, if it exists).

Also note that my patch totally ignores the Group & Others part of the
permission bits. Again, we're on Windows so we don't really care. We
_could_ make it reflect the ACLs in Windows, but then we'd have to make
it optional, since that's _really_ slow to 'stat'.

> The rest of the patch looks good on a brief initial scan.

Thanks

--
=2Emarius


--------------enigECD20048A3E84A04E2193027
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG2uAqKzzXl/njVP8RAroaAKCF4pqOfLwxyocUTHKRWPD72YAwnwCg6Wro
ZSHuxw7HOzcV6VFnF9Bg9w4=
=3PRv
-----END PGP SIGNATURE-----

--------------enigECD20048A3E84A04E2193027--
