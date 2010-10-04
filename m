From: Stephan Hugel <urschrei@gmail.com>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 5 Oct 2010 00:04:51 +0100
Message-ID: <AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
	<201010041851.46838.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 01:05:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2u5d-0007r0-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 01:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab0JDXEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 19:04:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55259 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176Ab0JDXEw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 19:04:52 -0400
Received: by wwj40 with SMTP id 40so4839954wwj.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cm6CjD5HjvU/b3a+AGUdYVs7NZQnpupinDDfKA9qEUU=;
        b=QP9+bhvVT1qZTIVHU/eqbnkTx/Vk/M7qU9opg7WrifQuPMNxKYlhsaQCYdI1edoora
         0fo4TcCVjtI5lxSA3qLmNjx7emHqQOfUrmhbOPr6EVU/zfH/x6c/+tKbkawTI1NROxyW
         hB9QPSkmFBukU1yUC7e+9dpojuJ7fD5ZSFhBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B6+8J9ODFLZYY5Za24TThnMy9lmsX3u06x8KCm1qfVUVAICsDQMVsdsUUvEfbeJ4Dc
         mlclB0miURyctU1ene6O7s5biLUZLlc+zWZa8d1XUuQxQEGip9o6AWIIevVxwDaX0UcW
         /u5tPcSSV8BDM+8HrDcBOk9B334dPRD8CjAq8=
Received: by 10.216.235.106 with SMTP id t84mr8399557weq.46.1286233491546;
 Mon, 04 Oct 2010 16:04:51 -0700 (PDT)
Received: by 10.216.230.232 with HTTP; Mon, 4 Oct 2010 16:04:51 -0700 (PDT)
In-Reply-To: <201010041851.46838.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158142>

On 4 October 2010 23:51, Daniel Johnson <computerdruid@gmail.com> wrote=
:
> On Monday 04 October 2010 18:13:21 Stephan Hugel wrote:
>> Hello, git list.
>> I seem to be unable to verify tags I create and sign using the git -=
s
>> command in 1.7.3.1
>> Existing tags (i.e. created with 1.7.2.x, using the same key and Gnu=
PG
>> version) can be verified, but attempts to verify created tags result
>> in the following:
>>
>> object 791abd4848d86ea98071f35bbce4d4b274ef0788
>> type commit
>> tag v1.4
>> tagger name <name@host.com> 1286228562 +0100
>>
>> Better header detection and regex
>> -----BEGIN PGP MESSAGE-----
>> Version: GnuPG v1.4.9 (Darwin)
>>
>> iD8DBQBMqkph8Y2TgZsQ1pARAgxrAJ40ATxZw219CWI6FCaDAtbY8UHdoACePF6Q
>> PyNkf67w7AA8hkQqLAYGcyI=3D
>> =3DVLWl
>> -----END PGP MESSAGE-----
>> gpg: Signature made Mon =C2=A04 Oct 22:42:57 2010 IST using DSA key =
ID 9B10D690
>> gpg: BAD signature from "name <name@host.com>"
>> error: could not verify the tag 'v1.4'
>>
>>
>> I have confirmed that my key is valid (have
>> signed/encrypted/decrypted/verified using it after this error
>> occurred). I have also tried to create a tag using a newly-created
>> key, with the same result. I have attempted to created signed tags i=
n
>> multiple repos. Is this a known bug?
>
> I can't reproduce this:
>
> $ git --version
> git version 1.7.3.1
> $ git tag -s test_tag -m "test_message"
> $ git tag -v test_tag
> object dbc2fa2a8507f258a353238cde2d9ba5894a8296
> type commit
> tag test_tag
> tagger Daniel Johnson <ComputerDruid@gmail.com> 1286231912 -0400
>
> test_message
> gpg: Signature made Mon 04 Oct 2010 06:38:38 PM EDT using DSA key ID =
4A094EDC
> gpg: Good signature from "Daniel Johnson <ComputerDruid@gmail.com>"
>
> Is this not what you are doing? do you have any more info about what =
you are
> doing to cause this failure?
>

Daniel,
Those are the exact steps I'm using.

When I run tag -v on existing tags, I don't see the

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.9 (Darwin)

iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
yZeXw/EddYrfdad/VvOrL1o=3D
=3D/0PJ
-----END PGP MESSAGE=E2=80=94=E2=80=94

block. It's only present on tags created using the current version.
I've also just upgraded to GnuPG 1.4.10, but the result is the same.
I'm not sure how else I can determine where the problem arises; I'm
using the git and GnuPG versions for OS X built by homebrew, and GnuPG
is happy to use the same key for en/decryption and signing. I've also
verified that none of the subkeys are expired, and that the trust db
is OK.

--=20

steph
