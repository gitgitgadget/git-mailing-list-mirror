From: Fairuzan Roslan <fairuzan.roslan@gmail.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 11:22:28 +0800
Message-ID: <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr> <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> <vpqiof14qu8.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_8CD5EF2B-B52E-4560-81A0-24F596EE0677"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: gitster@pobox.com, git@vger.kernel.org, tboegi@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 17 04:22:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNYkG-0008Cz-5o
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 04:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbbBQDWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 22:22:36 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35680 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbbBQDWe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 22:22:34 -0500
Received: by padfa1 with SMTP id fa1so2972495pad.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 19:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=gTsaPwOqxsXYYCaW/+YdrlTJlrxO3n8gKv/bVXdXvGI=;
        b=jNb7JKk2wOuTuAPNOgbp6zth57LuJWRB3SqeXKQkODyqVdGwI9eLdRvH2cl4jYlj9Q
         DzU/TrEPbZ4KQb9uAXJU3z66qSvFHGJGZ/3PAFS5xe+q1+8yIQJjzJhtmhuY0KCT0Rgb
         nIgQ23kbj/iWiavfbSwIMgwiFkzvswZdt676HSJq9Zgr2JOUvvg/z7c4+eM/Dw8ej3YJ
         1asy/ezEVG8H9heDQWG+hEy4PBfcTPDCZtYDc8+PGK3Vkggiqfz0WpyRu2A7XQqo3s2K
         IrQ+/Iy/UDHsZJnmrNCEodfiXiraCUbo8vWLoj/M+eEOqSgrIJsCd1YOhXPNIhEKnvOi
         AQwg==
X-Received: by 10.66.62.137 with SMTP id y9mr45523995par.87.1424143353704;
        Mon, 16 Feb 2015 19:22:33 -0800 (PST)
Received: from [192.168.88.200] (brk-24-241.tm.net.my. [202.188.24.241])
        by mx.google.com with ESMTPSA id v5sm16174549pdh.9.2015.02.16.19.22.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Feb 2015 19:22:32 -0800 (PST)
X-Pgp-Agent: GPGMail 2.5b5
In-Reply-To: <vpqiof14qu8.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263929>


--Apple-Mail=_8CD5EF2B-B52E-4560-81A0-24F596EE0677
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 17, 2015, at 3:08 AM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>=20
> [ Please, don't top post on this list ]
>=20
> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>=20
>> I don=E2=80=99t see the issue for the owner of his/her own file to =
have write
>> access.
>=20
> Object and pack files are not meant to be modified. Hence, they are
> read-only so that an (accidental) attempt to modify them fails.
>=20
>> Setting tmp idx & pack files to read-only even for the file owner is
>> not a safety feature.
>=20
> Yes it is. If you do not think so, then please give some arguments.
>=20
>> You should at least give the user the option to set the permission in
>> the config file and not hardcoded the permission in the binary.
>=20
> This is the kind of thing I meant by "investigate alternate =
solutions".
> I have no AFP share to test, so it would help if you answered the
> question I asked in my previous message:
>=20
>>> On Feb 17, 2015, at 2:23 AM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>>>=20
>>> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>>>=20
>>>> Hi,
>>>>=20
>>>> Somehow the =E2=80=9Cint mode =3D 0444;=E2=80=9D in odb_mkstemp =
(environment.c) are
>>>> causing a lot of issues (unable to unlink/write/rename) to those
>>>> people who use AFP shares.
>>>=20
>>> Is it a problem when using Git (like "git gc" failing to remove old
>>> packs), or when trying to remove files outside Git?
>=20
> (BTW, why did you try to write/rename pack files?)
>=20
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

I think its easier if I just show you=E2=80=A6

OS : OS X 10.10.0 - 10.10.2
Client :  git version 1.9.3 (Apple Git-50) and git version 2.2.1
AFP share : //user@hostname._afpovertcp._tcp.local/installer on =
/Volumes/installer (afpfs, nodev, nosuid, mounted by user)

1. git clone example

$ git clone https://github.com/robbyrussell/oh-my-zsh.git
Cloning into 'oh-my-zsh'...
remote: Counting objects: 11830, done.
remote: Total 11830 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (11830/11830), 2.12 MiB | 481.00 KiB/s, done.
Resolving deltas: 100% (6510/6510), done.
warning: unable to unlink =
/Volumes/installer/oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: =
Operation not permitted
error: unable to write sha1 filename =
/Volumes/installer/oh-my-zsh/.git/objects/pack/pack-cceafdc9ef02bc58844138=
ba543ec6cc38252bb1.pack: Operation not permitted
fatal: cannot store pack file
fatal: index-pack failed

$ ls -l oh-my-zsh/.git/objects/pack
total 5008
-rw-------  1 user  staff       32 Feb 17 09:59 =
pack-cceafdc9ef02bc58844138ba543ec6cc38252bb1.keep
-r--r--r--  1 user  staff   332312 Feb 17 09:59 tmp_idx_oUN1sb
-r--r--r--  1 user  staff  2223007 Feb 17 09:59 tmp_pack_zjPxuc

$ rm -rf oh-my-zsh/.git/objects/pack/tmp_*
rm: oh-my-zsh/.git/objects/pack/tmp_idx_oUN1sb: Operation not permitted
rm: oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: Operation not permitted

Detail Errors:
1. delete_ref_loose (refs.c) -> unlink_or_msg (wrapper.c) -> "unable to =
unlink %s: %s"
2. move_temp_to_file (sha1_file.c ) -> =E2=80=9Cunable to write sha1 =
filename %s: %s=E2=80=9D

2. git pull example

Textual git:master $ git pull
remote: Counting objects: 435, done.
remote: Compressing objects: 100% (398/398), done.
remote: Total 435 (delta 219), reused 18 (delta 12)
Receiving objects: 100% (435/435), 1.22 MiB | 756.00 KiB/s, done.
Resolving deltas: 100% (219/219), done.
warning: unable to unlink .git/objects/pack/tmp_pack_vDaIZa: Operation =
not permitted
error: unable to write sha1 filename =
.git/objects/pack/pack-977a2dc0f4be3996dc1186e565a30d55d14b5e87.pack: =
Operation not permitted
fatal: cannot store pack file
fatal: index-pack failed

Textual git:master $ ls -l .git/objects/pack/tmp_*
-r--r--r--  1 user  staff    13252 Feb 17 10:51 =
.git/objects/pack/tmp_idx_uhnicb
-r--r--r--  1 user  staff  1275487 Feb 17 10:51 =
.git/objects/pack/tmp_pack_vDaIZa

=3D Same explanation as git clone example

3. git gc example

Textual git:master $ git gc
Counting objects: 49691, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (11347/11347), done.
fatal: unable to rename temporary pack file: Operation not permitted
error: failed to run repack

Textual git:master $ ls -l .git/objects/pack/tmp_*
-r--r--r--  1 user  staff   1392420 Feb 17 10:58 =
.git/objects/pack/tmp_idx_77nr1b
-r--r--r--  1 user  staff  96260304 Feb 17 10:58 =
.git/objects/pack/tmp_pack_RlAZc9

Detail Error:
1. finish_tmp_packfile (pack-write.c) -> die_errno(=E2=80=9Cunable to =
rename temporary pack file=E2=80=9D);


If you insist on setting the tmp idx & pack file permission to 0444 at =
least give it a u+w permission whenever you try to unlink and rename it =
so it won=E2=80=99t fail.

Regards,
Fairuzan






--Apple-Mail=_8CD5EF2B-B52E-4560-81A0-24F596EE0677
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJU4rP0AAoJEKrU1IvC77KVTA0IAKFu7W50gOhMl8VLIKnEQyM2
rc9ckjDi9UyLmPM+l+bbaKeHg97Z8NBS+G0jGuMYhMglDTzDN4d7GwfH2YICN/ZJ
bHhDl866vmnQif9vVtxSs9lv2Xvrico8F1QnQm9Cx6/8fQuIlvxYVUjiqs9iY3W+
WZ38AobuUQ2cU8zy9Sy3528FttTXfLG5ggj5lKKyC1e4jjzLqHU2vT7sWv9HLgNV
MWCF3L2Lno9zlU2PmWmWnils7DPhbsmIRkGuT0Or4k7q+QkvMeGBL1BapQFnJ+MD
KQ6+80jm15+Mv/taXXnzyBpOROE+eJI2+1CIsqu2axlky18sBWTkx3Tfrt7BOh0=
=/v0Q
-----END PGP SIGNATURE-----

--Apple-Mail=_8CD5EF2B-B52E-4560-81A0-24F596EE0677--
