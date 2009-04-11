From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add "list" and "rm" sub commands to tg-depend
Date: Sat, 11 Apr 2009 17:40:04 +0200
Message-ID: <36ca99e90904110840g35fa3b37m45f0286cb1f99db6@mail.gmail.com>
References: <20090407133329.57b06727.weiny2@llnl.gov>
	 <20090408080824.GF8940@machine.or.cz>
	 <20090408083955.GA28482@pengutronix.de>
	 <20090408091949.8a648d83.weiny2@llnl.gov>
	 <20090409124337.GA6034@pengutronix.de>
	 <20090409091021.5a7ded79.weiny2@llnl.gov>
	 <36ca99e90904091101l6dd1685y5be70dd77bf52b57@mail.gmail.com>
	 <20090409201515.GA4218@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ira Weiny <weiny2@llnl.gov>,
	Brian Behlendorf <behlendorf1@llnl.gov>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 17:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsfLk-0005Sg-OG
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 17:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbZDKPkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757015AbZDKPkJ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 11:40:09 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58424 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359AbZDKPkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 11:40:06 -0400
Received: by fxm2 with SMTP id 2so1466618fxm.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p6s3o17Dln1vsjXOVQEBZ0ZUY0x02E772hV/Chb6BbE=;
        b=KonSPcXu1A5UjTNmUsaUjNM4oBMNW6MSH33kZheMYxTaGT8gI6E8UrxAjaA0QowPfe
         LQD/W4PcHIbKpYRrO3Qq64qYwstM6w9gJbYcF9Np2azpL7pIkvIU2+MVO1noCeKM8gFv
         3o6ruxhnWzbC8BDrGvXi5GSB25M031uR2DWiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m7h8E+x+DOC2AHkk+VBT86TO9AiYy30tqlzuk3eHNBCS6pvRQcl5nxnsRVDKheYFBL
         4mM5zw6T5oyXdvY1kaKNTeXWyVPo7GAi3kIwSttgKsnVcdu00Jpti12IsOAgtrWMnwkJ
         IfHZhxBVXMeHpcnSlfBOPcDwb2pzCctWFn1eE=
Received: by 10.223.126.10 with SMTP id a10mr1328080fas.17.1239464404475; Sat, 
	11 Apr 2009 08:40:04 -0700 (PDT)
In-Reply-To: <20090409201515.GA4218@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116300>

2009/4/9 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Apr 09, 2009 at 08:01:04PM +0200, Bert Wesarg wrote:
>> 2009/4/9 Ira Weiny <weiny2@llnl.gov>:
>> > On Thu, 9 Apr 2009 14:43:37 +0200
>> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>> >> You might want to check
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 http:// thread.gmane.org/gmane.comp.version-=
control.git/114581
>> >
>> > Ah this brings up more issues I had not thought about... =C2=A0:-(=
 =C2=A0But perhaps
>> > Bert's work could be used to help implement "rm". =C2=A0Thoughts?
>> No, it wont help. Because the base and tip of the topic should not
>> changed in respect to the old state (expect for .topdeps of course).
>>
>> If you really want to remove a dependency, you need to revert a merg=
e
>> of this dep from the topic base. which is not possible today, or may=
be
>> I have just an idea for this:
>>
>> =C2=A0 'topic': the topic
>> =C2=A0 'base': =C2=A0the base of the topic, i.e. a merge from all de=
pendent
>> topics dep0, ..., depN
>>
>> say you want to remove dep0
>>
>> =C2=A0 1) merge all deps dep1, ..,depN into 'new-base'
>>
>> =C2=A0 2) merge 'new-base' into base with the merge driver 'theirs',=
 that
>> would overwrite all changes from dep0 in the 'base'
>>
>> =C2=A0 3) update 'topic' to the updated 'base'
>>
>> Any thoughts from someone who knows more than me?
> Some time ago I thought about a similar issue:
>
> I based a branch on top of the Linux tree of the ARM maintainer (in t=
he
> following called "rmk") and decided later to base it on top of Linus'
> tree. =C2=A0So I did ~:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout refs/top-bases/$branch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git merge -s theirs linus/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout $branch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -i s,rmk,linus, .topdeps
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add -f .topdeps
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m $commitmsg
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tg update
>
> When I thought about it with pencil and paper back then, I saw a prob=
lem
> with that approach. =C2=A0Now I invested some time now to verify it r=
eally
> exists: =C2=A0In fact I reverted the changes in the rmk/master branch=
=2E
> Consider Linus pulls from rmk and I update my topgit branch. =C2=A0Gu=
ess what
> happens? =C2=A0Linus' pull + my revert yield Linus' tree without rmk'=
s
> changes.
>
> Here is my recipe:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# prepare linus/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git init
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 'VERSION=3D2.6.28' > Makefile
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add Makefile; git commit -m 'v2.6.28'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git branch -m master linus/master
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# prepare rmk/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b rmk/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 'support for some machine' > arm.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add arm.c; git commit -m 'support for =
some machine'
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# new topgit branch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tg create t/test
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo change > lib.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add lib.c; git commit -m 'tralala'
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Linus goes on ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout linus/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 'VERSION=3D2.6.29-rc1' > Makefile
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add Makefile; git commit -m 'v2.6.29-r=
c1'
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# "rebase" test branch on linus/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout refs/top-bases/t/test
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git symbolic-ref HEAD refs/top-bases/t/tes=
t
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git merge --no-commit linus/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git read-tree linus/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm arm.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout t/test
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -i s/rmk/linus/ .topdeps
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add .topdeps; git commit -m 'change de=
p: rmk/master -> linus/master'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tg update
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Linus pulls from rmk
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout linus/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git merge rmk/master
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# update test to linus+rmk
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout t/test
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tg update
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# inspect:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff linus/master refs/top-bases/t/tes=
t
>
> The last command shows that refs/top-bases/t/test doesn't have arm.c
> :-/
>
> I'm sure the dependency deletion has exactly the same problem.
You're probably right. I just found the old discussion about
dependencies removal [1]:

On zo, 2008-09-21 at 16:24 +0200, Petr Baudis wrote:
> The problem is that you can undo the merge content, but not the histo=
ry
> information. So this revert can e.g. propagate even into branches whi=
ch
> still *should* depend on the other branch, you get into trouble when =
you
> want to make your branch depend on the other one anyway, etc.

On di, 2008-09-23 at 15:27 +0200, Petr Baudis wrote:
> what we can't make to work is just the
> most generic case, but e.g. if master is a *leaf* branch nothing else
> depends on and it can't get the branch through multiple paths, you ca=
n
> do the dependency removal rather easily (if it can get through multip=
le
> paths, you can still do it but you might have to deal with big
> conflicts).

Maybe the leaf solution could be done.  Only directly depending
branches from the transitive reduction should be removable.  This
would help for the 'tip'/'current' branch usecase, for collecting
topics.

Bert

[1] http://thread.gmane.org/gmane.comp.version-control.git/95458/focus=3D=
96093
>
> Best regards
> Uwe
