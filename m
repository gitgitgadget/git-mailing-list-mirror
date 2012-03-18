From: =?UTF-8?B?UGF2ZWwgUG9zcMOtxaFpbA==?= <pospispa@gmail.com>
Subject: Re: git push default behaviour?
Date: Sun, 18 Mar 2012 11:26:09 +0100
Message-ID: <CADDfn-Jwh1Uyw1J4qmOv6PFzHF8JM5Lgg_dKcCoa+LvT-fk70Q@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<CAAGHeXHWfEAym63jXFNvcBddp00joBzNuFEjhKZpqDQcn1d0kA@mail.gmail.com>
	<CAFsnPqpS7srjHu1Wnx60qcwN_PV83uxvtWoniFBgRH2MjJzzzA@mail.gmail.com>
	<CAAGHeXFFrHnDz-SA8V2awBpi3Cwfxj_C3p=N16qZZFEW3L5Vtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 11:26:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9DJa-0007v1-Dv
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 11:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab2CRK0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 06:26:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64453 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab2CRK0J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2012 06:26:09 -0400
Received: by iagz16 with SMTP id z16so7854054iag.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 03:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=lhYBwtH8M6jD3eLNegSnKrqkysWK/kRSuDqFr1yei7w=;
        b=mX4FYrdS4qYl7p+rPkQfLeat7l9hr33rlhodHLHh8IvyUMaVDvAazwzx3TBURujrDc
         ZvinKIAqQMNPlhJa9jCqgAsTaRs2WqLC1uh6b40Mk1f6+osYUngcSiSllkAg5dGg0ksq
         1LRLMAXlP91o/CsaN7gbfo8FB0rN8yTxND2SUZMufQNqqWOvje+u8mlln4k/TJJnypcm
         pKteNC0rVwFkBj3e5xRoBeECvqY4E6RZJfxXaFbE9RBXZ37ITTPZGeDtV+l6ti3P4yDe
         cCDTCA/8O8RMLV1wIMWoVDci63mxzHZQwkxDl3gIGWOhu9kUCFRhMmDJNy7KwX7qupWA
         5URw==
Received: by 10.50.159.198 with SMTP id xe6mr4051695igb.74.1332066369306; Sun,
 18 Mar 2012 03:26:09 -0700 (PDT)
Received: by 10.42.142.194 with HTTP; Sun, 18 Mar 2012 03:26:09 -0700 (PDT)
In-Reply-To: <CAAGHeXFFrHnDz-SA8V2awBpi3Cwfxj_C3p=N16qZZFEW3L5Vtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193377>

Hi,
I consider myself a little bit experienced git newbie. I use git 1.7.5.=
4
I use git for 9 month in this way:
1. copy a released version from a centralized versioning control
system (this VCS does not have any git interface) to my local git repo
2. do work in git in my-branch
3. copy current work-in-progress reconfiguration from VCS to git
4. rebase my-branch onto current work-in-progress
5. copy my work to VCS
Therefore, no usage of push/pull.

I created my first public repo in which I share the released versions
of 4 development streams in 4 independent branches with my colleagues.
My usual workflow is:
1.=C2=A0copy a released version from VCS to my local git repo
2. git add .
3. git commit
4. git tag <release-name>
5. git push <my-public-repo> HEAD
6. git push=C2=A0<release-name>
I expected that push is meant (even after reading man git-push) to be
used in this way:
1. do some work in my-branch
2. merge it to master
3. git push
and this will push only the changes in the master branch I am
currently switched on.

Now, I realized that git push default is not "upstream" (the behaviour
I expected) but is "matching" that brings more automation (I assume
git community wants to achieve as much automation as possible).

I agree with=C2=A0Sebastien=C2=A0that current git push.default is too m=
uch
automation for newbies that "upstream" would be a better default for
newbies.

I came across an inconvenience in man git-push. There is no
Configuration section that will inform about the push.default
configuration parameter and educate the reading about various push
behaviours. I know that there is man git-config but it's too long and
it's too tedious to read all git configuration options.

Maybe, adding the Configuration section to man git-push will help.

Best regards,
Pavel Pospisil


On Sat, Mar 17, 2012 at 10:51 AM, Sebastien Douche <sdouche@gmail.com> =
wrote:
>
> On Sat, Mar 17, 2012 at 10:38, Jeremy Morton <jeremy@configit.com> wr=
ote:
> >> I made many Git presentation and managed a lot of training[1] and =
the
> >> first thing I explain on the configuration is :
> >>
> >> 1. set your name and email
> >> 2. change the default push option[2]
> >
> > So, that would seem to be a rather strong indication that the defau=
lt
> > push option is a bad one. =C2=A0:-)
>
> True. Never understood why matching is the default value :). Btw,
> thank you for the discussion, I forgot to do that :(.
>
> --
> Sebastien Douche <sdouche@gmail.com>
> Twitter: @sdouche / G+: +sdouche
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
