From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] t7011: Mark fixed test as such
Date: Mon, 30 Nov 2009 08:56:52 +0700
Message-ID: <fcaeb9bf0911291756g1857fe32r8da8e50f0a137119@mail.gmail.com>
References: <0327ed3d7c4621f205d2d111254d716bd1b06c28.1259432535.git.git@drmicha.warpmail.net> 
	<fcaeb9bf0911290047t43ea3040x730e04baa81d8a98@mail.gmail.com> 
	<4B127DC0.4020108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 02:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEvW6-0003Ji-5f
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 02:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZK3B5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 20:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZK3B5H
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 20:57:07 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:37267 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZK3B5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 20:57:06 -0500
Received: by pwi3 with SMTP id 3so1876558pwi.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 17:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=r38Jobrpjffhpd1zweJsJQV2zVH+ChLhId5HE4yezIE=;
        b=BYt7OY9kh8e2RjoE5DxI8MwvN6Wri5yp17tO55gUI8yDEclbZCjQulMImKyGyzfh8q
         DSlFMTkFrH91/f+3DMCO4WA3KAUQOjdO/ZMEiGMy1GS5CCixW+s4Ps7iXAa1BFl6dZC6
         dj/0SH5GZvvNyGwHfHSQm+eGR05WL+IGurJ+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=S5QrPzacjhdr8k+bag1dmgVXEaZ3O5Cy7Pu5n1LGBeReBad/DWb5ztoM5+0bYRTT0s
         fJ2OJHggWFd1f2M7lnAA2RqXxroVUH3eVeZLGHI2f1jjV+Yu/0bbti2U13yDya6U8Zlj
         eKrieHlKlAPv8S6jw2arWwwUzs7vAHhn52354=
Received: by 10.115.84.9 with SMTP id m9mr6026749wal.163.1259546232065; Sun, 
	29 Nov 2009 17:57:12 -0800 (PST)
In-Reply-To: <4B127DC0.4020108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134043>

On Sun, Nov 29, 2009 at 8:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 29.11.2009 09:47:
>> On 11/29/09, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>>> Test 16/17 had been fixed since its introduction in b4d1690 (Teach =
Git
>>> =C2=A0to respect skip-worktree bit (reading part), 2009-08-20). So,=
 mark it as
>>> =C2=A0expect_success rather than expect_failure.
>>>
>>> =C2=A0Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>
>> No ACK. See below.
>>
>>> =C2=A0---
>>> =C2=A0I'm actually wondering about 17/17 as well.
>>> =C2=A0If commit is called with a file name then shouldn't it simply=
 commit the
>>> =C2=A0current state of the file in the worktree, no matter what the=
 index or
>>> =C2=A0skip-worktree say? I therefore think 17/17 should be expect_s=
uccess
>>> =C2=A0and have no test_must_fail.
>>
>> Both 16/17 and 17/17 ensure that Git won't look at files on worktree
>> if they are marked as skip-worktree (by definition of skip-worktree,
>> you can safely ignore worktree, otherwise you would not mark them as
>> such). 16/17 happens to pass, not because it does not touch worktree=
,
>> but because the base index does not have "1", which happens to is th=
e
>> same situation in 16/17 (test commit when "1" is gone). The result i=
s
>> OK but it is actually not (17/17 shows this clearer as it commits th=
e
>> worktree version).
>
> On 16/17, I really cannot agree. You explain that you expect the test=
 to
> succeed (we agree here), but that it succeeds for the wrong reasons. =
So
> it should be either "expect_success", or the test itself should be
> changed so that it really tests what it intends to, otherwise it rais=
es
> a wrong "FIXED". I suggested and submitted the former.

That was my bad in setting up the environment for 16/17. I will fix
that in the next roll of nd/sparse.

> On 17/17, it's not clear what should happen. "skip-worktree" says ign=
ore
> the worktree and look in the index instead of accessing worktree file=
s.
> But "git commit file" says ignore the index and stage and commit the
> file from the worktree directly. And that is exactly what happens:
>
> You say "git commit file".
> That means "ignore the index".
> That also means that git ignores the skip-worktree bit which is set i=
n
> the index.
> Therefore, file is committed with the content is has in the worktree.

To me, no command should break out skip-worktree mask. In reality I
would expect that case 17/17 only happens when a user accidentally
leaves a file that is marked skip-worktree and tries to commit it. An
error would be more appropriate to keep consistency with other
commands ("git diff HEAD -- 1" would show nothing before committing),
and to warn the user that he/she is stepping on the border. He/she can
then choose to extend worktree area if still wants to commit that
file. How does that sound?

> I'm going by the documentation for git-update-index and git-commit. I=
t
> could be that they are wrong, too, but they agree with the code, so
> what's the reference for saying both code and documentation are wrong=
?

Both code and documentation are for Git without skip-worktree. If you
agree with my reasoning above, I will update documentation to reflect
this too.
--=20
Duy
