From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: merge -s ours question
Date: Mon, 8 Mar 2010 18:33:17 -0500
Message-ID: <76718491003081533r441506e9n48afee2021e7bad4@mail.gmail.com>
References: <76718491003081426j4329e322we91fc6fe13f2d03@mail.gmail.com>
	 <7vhboql8uu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:35:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoySH-0001Do-Qk
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919Ab0CHXdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 18:33:20 -0500
Received: from mail-iw0-f176.google.com ([209.85.223.176]:59775 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0CHXdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 18:33:18 -0500
Received: by iwn6 with SMTP id 6so3009173iwn.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/TspOpUpAy26eiBRXyFaA0sfhYc81e1raq9IyEGftKs=;
        b=IoY/qWXuc9JhWOk2+xc4RtK92TcaJCR7yV0FIuCG+f0ju0pRhKqsfx0etBw1in8NCs
         WKV6U23EM8Kw1mUWlA1xt9DpFOqTCFeXlzoi5j6N4D/uX7Ze1U7wlr0/fpPRIgNpGWVW
         thdOTVdna2uBqvjCAH1Ux9q67GNiROMKd4i7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C+KoKHwXpvFN5QjZuwwAiedN+HVonSt8bBnwGjHW5lL4N+N7LPPti50CItQaZV99yQ
         IWZIA9G/Su3d7yomJQchqqhlvR8ebPXVdmCuyNN+0Xbgb/GNR7O/8JfpbnupML31uOMz
         /c+Y1R4obUMJdKSqry6ZyLzdeeQY0DqTLLjNU=
Received: by 10.231.169.145 with SMTP id z17mr318884iby.83.1268091197388; Mon, 
	08 Mar 2010 15:33:17 -0800 (PST)
In-Reply-To: <7vhboql8uu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141816>

On Mon, Mar 8, 2010 at 5:57 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> It took a lot of work, but I backported everything newer than A usin=
g rebase
>> and cherry-pick, and omitting the merges, giving me a dev' clean of =
merges
>> from upstream:
>>
>> =C2=A0 =C2=A0 =C2=A0dev' =C2=A0 o--A'--B' ... Y'
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/
>> =C2=A0upstream 1--2--3--4--5
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 \ =C2=A0 =C2=
=A0 \
>> =C2=A0 =C2=A0 =C2=A0 dev =C2=A0 o--A--x--B--x ... Y
>
> I understand that at this point "dev'" is the moral equivalent of wha=
t you
> called "dev1" in the next picture.
>
>> upstream 1--2--3--4--5
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \
>> =C2=A0 =C2=A0 dev2 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 o--o-=
-o--o
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 dev1 =C2=A0 =C2=A0 o--o--o--o--o
>
> It is unclear what commits on dev2 branch are about in this picture. =
=C2=A0Are
> they replay of what you have on dev1? =C2=A0Or are they about a featu=
re that is
> different from what dev1 does, perhaps using what dev1 have already d=
one,
> or perhaps totally independent of dev1?
>
> If "dev1" and "dev'" are the moral equivalents, and dev2 wants to use=
 what
> dev1 did _and_ what is in updated upstream (i.e. dev2 cannot build wi=
thout
> either dev1 nor some of the feature/fix in "2"..."5"),

Sorry I was unclear in my diagrams, and you guessed correctly, dev2
needs both dev1 and newer commits from upstream. So a correct "ideal"
picture would've been:

upstream 1--2--3--4--5.
          \            \
    dev2   \            o--o--o--o
            \          /
    dev1     o--o--o--o--o


Now, development will continue on all three branches, with dev2
needing changes from both dev1 and upstream. In fact, dev1 may also
periodically need changes from upstream, but for the foreseeable
future, dev1 will be based on an older version of upstream than dev2.

> then I would
> probably build a history that looks like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0o--o--o dev2 (builds on top of dev1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .--* =C2=A0 m=
erge between dev1 and upstream
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0/
> =C2=A0 =C2=A0 =C2=A0o--o--o--o =C2=A0/ =C2=A0 dev1
> =C2=A0 =C2=A0 / =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A01--2--3--4--5 =C2=A0 =C2=A0 upstream
>
> and give a pull request to the upstream for "*" to incorporate the fu=
lly
> cooked work done on dev1.

Okay. One detail I left out is that dev1 and dev2 will never go
upstream. They are forever downstream. Hopefully at some point dev1
and dev2 can be based on the same upstream commit, but for now dev2
will periodically be merging from dev1 and will remain on a newer
upstream commit than dev1. (Periodically, both dev1 and dev2 may merge
from upstream, but it will be the case that dev1 merges from an older
upstream commit than dev2.)

> Also if "dev'" and "dev1" are the moral equivalents, then the merge "=
*"
> above _should_ match exactly what you had at "Y" in "dev" in the orig=
inal
> mergy history. =C2=A0So after creating "*", you may want to do a regu=
lar merge
> (IOW, I don't think "-s ours" is necessary if you rebuilt "dev1" righ=
t)
> between it and 'dev' to create "M" that should result in the same tre=
e:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .--* =C2=A0 m=
erge between dev1 and upstream
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0/ \
> =C2=A0 =C2=A0 =C2=A0o--o--o--o =C2=A0/ =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0dev1
> =C2=A0 =C2=A0 / =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0 \
> =C2=A0 =C2=A01--2--3--4--5 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0=
upstream
> =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =
\
> =C2=A0 =C2=A0 =C2=A0o--A--x--B--x-..-Y--M =C2=A0 =C2=A0dev
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0o--o--o dev2'
>
> and build "dev2'" on "dev" instead; but you probably cannot offer "de=
v" to
> be pulled to the upstream due to the criss-cross mess (that was the w=
hole
> reason you did "dev1" in the first place), and doing so would make "d=
ev2'"
> unpullable for the same reason. =C2=A0So I don't see much point in do=
ing that
> merge "M" nor keeping "dev" branch around, once you verified that "*"=
 and
> "Y" matches to make sure your rebuilt dev1 has what dev has, and it i=
s
> what dev should have looked like in the first place.
>
> If you want to keep merging from dev1 to dev2 because dev1 is still n=
ot
> ready, you might want to choose to rebase dev2 on top of dev1 instead=
=2E

Okay. I think I have more work ahead of me creating '*'. I was trying
to avoid having to do that. It is actually composed of multiple merges
with some fairly complex resolutions, but maybe rerere-train and
rerere can help me here.

j.
