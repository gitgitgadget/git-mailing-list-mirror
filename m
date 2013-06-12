From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 13:23:32 +0200
Message-ID: <3cafe99fe3b868e6fc025110d324b9c8@ensibm.imag.fr>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
 <20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr>
 <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
 <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
 <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
 <51B857B0.5030603@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 13:23:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umj9R-0002GZ-7r
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 13:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315Ab3FLLXi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 07:23:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35005 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab3FLLXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 07:23:36 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CBNW6i012031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 13:23:32 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CBNXEc012168;
	Wed, 12 Jun 2013 13:23:33 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5CBNXpw021022;
	Wed, 12 Jun 2013 13:23:33 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5CBNWcc021020;
	Wed, 12 Jun 2013 13:23:32 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <51B857B0.5030603@ensimag.fr>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 13:23:32 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227598>

Le 2013-06-12 13:12, C=C3=A9lestin Matte a =C3=A9crit=C2=A0:
> Le 12/06/2013 12:17, Mathieu Li=C3=A9nard--Mayor a =C3=A9crit :
>> Now, I'm not sure if we should always display the list of commits
>> already applied and those left to apply. What I mean is that maybe=20
>> it
>> would be better to make status require a flag to display the two=20
>> lists.
>> Something like (not sure about the flag's name):
>>
>> $ git status --rebase-state
>> # HEAD detached from ecb9f3e
>> # Already applied 2 patches:
>> #     b170635... my_commit_message
>> #     b170635... my_commit_message
>> # You are currently editing a832578... my_commit_message [3/5] while
>> rebasing.
>> # 2 patches left to apply:
>> #    b170635... my_commit_message
>> #    b170635... my_commit_message
>> #   (use "git commit --amend" to amend the current commit)
>> #   (use "git rebase --continue" once you are satisfied with your=20
>> changes)
>> # ......
>> # ......
>>
>> What do you guys think ?
>
> I agree. When you're in the process of rebasing a big list of=20
> commits,
> it would produce a lot of not-so-useful output, when what you want to
> see is, most of the time, which commit you are currently editing.
> So, in my opinion, whole lists should not be displayed by default.
>
> Now, if I could suggest an improvement over that list: when you=20
> rebase
> some commits, I'm quite sure the history of what you already did is
> stored somewhere since you can revert it which git rebase --abort. It
> would be nice to improve that list by displaying these informations,=20
> like:
>
> $ git status --rebase-state
> # HEAD detached from ecb9f3e
> # Already applied 4 patches:
> #              b170635... my_commit_message
> #              b170635... my_commit_message
> # new:         b170635... my_commit_message
> # modified:    b170635... my_commit_message
> # reworded:    b170635... my_commit_message
> # You are currently editing a832578... my_commit_message [5/8] while
> rebasing.
> # 2 patches left to apply:
> #    b170635... my_commit_message
> #    b170635... my_commit_message
> #   (use "git commit --amend" to amend the current commit)
> #   (use "git rebase --continue" once you are satisfied with your=20
> changes)
> # ......
> # ......
>
> I have no idea how complicated it would be to do that, though.
> What do you think?

If i'm not mistaking, it shouldn't be too hard, since it's pretty close=
=20
to
the content of .git/rebase-merge/done:
    reword a832578 rm: better error message on failure for multiple=20
files
    edit fd0330b rm: introduce advice.rmHints to shorten messages

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
