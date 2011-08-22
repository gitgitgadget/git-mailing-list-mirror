From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Merge after directory rename ?
Date: Mon, 22 Aug 2011 02:19:05 +0000
Message-ID: <CAMOZ1Bsb7UxYOFpRWh47+130upfD9_E=CMQtZd1NyUWPwWiW4A@mail.gmail.com>
References: <j2ru2h$cd$1@dough.gmane.org> <CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
 <CAMOZ1Bt8cP146xiDXfSA-naSOaS3AC8pUZgW12=3TMg2JGCD=w@mail.gmail.com> <j2s83l$eqg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 04:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvK73-0002KL-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 04:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab1HVCTh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 22:19:37 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:58401 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1HVCTg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 22:19:36 -0400
Received: by iye16 with SMTP id 16so9486256iye.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 19:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0PMB/0d4ZqpSeTvMLwVprpnI1qhg298Ukr4fUPOvhmE=;
        b=BVC2s2Nn0lPQaxqnAxf4GucHcvLOzgaL32yqJjQ3AFrHowHDr0GQl9aPSVyrEwzBrR
         Z2NukKj+zQIhixpDtze3Ir+kKlCh7+fL8nbc81gZDA8/+bhj/3wW4e39bzdba+nSCDnH
         qZBgmin1pTKzEcEUwqiLGVzaH0j3bcjR9QeTI=
Received: by 10.42.75.194 with SMTP id b2mr2084398ick.62.1313979575087; Sun,
 21 Aug 2011 19:19:35 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Sun, 21 Aug 2011 19:19:05 -0700 (PDT)
In-Reply-To: <j2s83l$eqg$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179835>

2011/8/22 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
> On Sun, 21 Aug 2011 23:53:34 +0000, Michael Witten wrote:
>> Importantly, note that I used only file names in my example,
>> specifically:
>>
>> =C2=A0 5. [master] =C2=A0rename dir1/file3 to dir3/file3
>>
>> rather than mirroring your example by writing:
>>
>> =C2=A0 5. [master] =C2=A0rename dir1 to dir3
>>
>> This is because git fundamentally tracks content, and paths are just=
 one
>> kind of content associated with another blob of content. Consequentl=
y,
>
> I know it tracks content, yet it puts effort to detect file renames.
> I want it to also detect directory renames, detecting it should be qu=
ite
> easy.
>
>> git really knows next to nothing about directories, so it's not too
>> surprising that git doesn't bother finding such a DIRECTORY rename
>> anyway (at most, git would detect a FILE rename, and your FILE
>> `dir1/file2' has nothing to do with, say, the FILE `dir1/file1' bein=
g
>> renamed `dir2/file1').
>>
>> Still, some command line switches could be useful to help the user
>> express to git what should be going on in a case such as yours.
>
> I would prefer it to be fully automatic :)

I assume the smiley is tongue-in-cheek; however, in case it is not: It
can't be automatic in general; did my examples mean nothing?

> Or at least detect/warn about tree conflict.

Did my examples mean nothing?

> Directory renames can happen quite frequently when working with Java/=
C#
> and it is unreasonable to expect that lazy user will have to keep tra=
ck of
> it manually (with huge number of files it's impossible).

Git doesn't know anything about Java/C#; that's the point.

In general, the user could make use of switches (as suggested). In
particular, perhaps there are merge hooks or merge drivers that could
be used or implemented for allowing a more environment-specific
handling of merges, a la GNU's ChangeLog merge driver:

  http://git.savannah.gnu.org/gitweb/?p=3Dgnulib.git;a=3Dblob;f=3Dlib/g=
it-merge-changelog.c

Also, see the configuration section of `git help merge'. Also look at
the tool `git mergetool'.
