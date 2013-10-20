From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v8] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible
Date: Sun, 20 Oct 2013 04:49:14 +0300
Message-ID: <BB9AEFCE-0E64-4EAA-8DEA-9A8125B8C553@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com> <79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com> <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com> <FB9897CC-EDC7-4EBB-8DAB-140CEB5F93B3@gmail.com> <C876399C-9A78-4917-B0CF-D6519C7162F6@gmail.com> <87mwm5vkue.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 20 03:49:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXi8s-0005Ig-Iv
	for gcvg-git-2@plane.gmane.org; Sun, 20 Oct 2013 03:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab3JTBtN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Oct 2013 21:49:13 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:40631 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3JTBtM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Oct 2013 21:49:12 -0400
Received: by mail-la0-f54.google.com with SMTP id gx14so559234lab.41
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 18:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w2heINDVZYkqjvu+yDEnwcaoC01AetFxLdMXY7aga+M=;
        b=e++7SmlEUfAALDKtdF1cWoe1ZJUeDjSDFr9tefwcg66gNs3h87HLF6Rs950JanQ5A6
         oubIa5niLkixiVztkxU3OWuFIXABBq8iMejZPLjV9S2gUSMBGuOaLqzZuHqbmXPl75Vu
         ASs0Jj/wJ5Ai4QKbShwWKkwxCetbkEew0+SSr0SZ063hr1zYTJ0n1egZxJ3dlkTje1rt
         K/wUMFk5fec8atYue7tJMZexuqyfDes9667izuIVCPFgmmiXXXS9fmxZKbaIi5hzl5Kd
         h9he7RuajpQy/lxqZur/bVJM9jrz0J5SVgHnPSFG1/k5d0gcsdbMrE1HM79DdMNopj5p
         TaPw==
X-Received: by 10.112.146.200 with SMTP id te8mr6518794lbb.32.1382233750843;
        Sat, 19 Oct 2013 18:49:10 -0700 (PDT)
Received: from [192.168.0.14] (cs27064221.pp.htv.fi. [89.27.64.221])
        by mx.google.com with ESMTPSA id vo1sm7091573lbb.1.2013.10.19.18.49.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Oct 2013 18:49:10 -0700 (PDT)
In-Reply-To: <87mwm5vkue.fsf@linux-k42r.v.cablecom.net>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236411>

Hello Thomas

> Can you briefly describe what you changed in v7 and v8, both compared=
 to
> earlier versions and between v7 and v8?
On v7, <sfx>'s basename part is tried to kept. On v7, whole <sfx> part =
is tried to kept.
=46or example, in case below:
   parent_path{sourceDirectory =3D> DestinationDirectory}path1/path2//l=
onglongFilename.txt
 On v7, this can be like:
   =E2=80=A6{...ceDirectory =3D> =E2=80=A6onDirectory}.../longlongFilen=
ame.txt
On v8, it will be like:
   =E2=80=A6{...irectory =3D> =E2=80=A6irectory}path1/path2/longlongFil=
ename.txt


This change is based on the review from Junio below.
(I myself is not sure what is the better way.)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
On Oct 17, 2013, at 10:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if distributing the burden of truncation equally to
> three parts so that the resulting pieces are of similar lengths is
> really a good idea.  Between these two
>=20
> 	{...SourceDirectory =3D> ...nationDirectory}...ileThatWasMoved=20
> 	{...ceDirectory =3D> ...ionDirectory}nameOfTheFileThatWasMoved
>=20
> that attempt to show that the file nameOfTheFileThatWasMoved was
> moved from the longSourceDirectory to the DestinationDirectory, the
> latter is much more informative, I would think.


On Oct 18, 2013, at 1:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
>=20
>> In the "[PATCH v7]", I changed to keep filename part of suffix to ha=
ndle
>> above case, but not always keep directory part because I feel totall=
y
>> keeping all part of long suffix including directory name may cause o=
utput like:
>>    =E2=80=A6{=E2=80=A6 =3D> =E2=80=A6}=E2=80=A6ongPath1/LongPath2/na=
meOfTheFileThatWasMoved=20
>> And, above may be worse than:
>>   ...{...ceDirectory =3D> =E2=80=A6ionDirectory}.../nameOfTheFileTha=
tWasMoved
>> I think.
>=20
> I am not sure if I agree.
>=20
> Losing LongPath2 part may be more significant data loss than losing
> a single bit that says the change is a rename, as the latter may not
> quite tell us what these two directories were anyway.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Also, I guess Junio might be suspicious to the idea to keep arrow("=3D>=
") itself, maybe ?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
(From What's cooking in git.git (Oct 2013, #04; Fri, 18))
- diff.c: keep arrow(=3D>) on show_stats()'s shortened filename part to=
 make rename visible

Attempts to give more weight on the fact that a filepair represents
a rename than showing substring of the actual path when diffstat
lines are not wide enough.

I am not sure if that is solving a right problem, though.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks!

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 19, 2013, at 9:24 AM, Thomas Rast <tr@thomasrast.ch> wrote:

> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
>=20
>> "git diff -M --stat" can detect rename and show renamed file name li=
ke
>> "foofoofoo =3D> barbarbar".
>>=20
>> Before this commit, this output is shortened always by omitting left=
 most
>> part like "...foo =3D> barbarbar". So, if the destination filename i=
s too long,
>> source filename putting left or arrow can be totally omitted like
>> "...barbarbar", without including any of "foofoofoo =3D>".
>> In such a case where arrow symbol is omitted, there is no way to kno=
w
>> whether the file is renamed or existed in the original.
>>=20
>> Make sure there is always an arrow, like "...foo =3D> ...bar".
>>=20
>> The output can contain curly braces('{','}') for grouping.
>> So, in general, the output format is "<pfx>{<mid_a> =3D> <mid_b>}<sf=
x>"
>>=20
>> To keep arrow("=3D>"), try to omit <pfx> as long as possible at firs=
t
>> because later part or changing part will be the more important part.
>> If it is not enough, shorten <mid_a>, <mid_b> trying to have the sam=
e
>> maximum length.
>> If it is not enough yet, omit <sfx>.
>>=20
>> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
>> Test-added-by: Thomas Rast <trast@inf.ethz.ch>
>> ---
>=20
> Can you briefly describe what you changed in v7 and v8, both compared=
 to
> earlier versions and between v7 and v8?
>=20
> It would be very nice if you could always include such a "patch
> changelog" after the "---" above.  git-am will ignore the text betwee=
n
> "---" and the diff, so you can write comments for the reviewers there
> without creating noise in the commit message.
>=20
> Also, please keep reviewers in the Cc list for future discussion/patc=
hes
> so that they will see them.
>=20
> --=20
> Thomas Rast
> tr@thomasrast.ch
