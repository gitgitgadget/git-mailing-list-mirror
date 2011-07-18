From: knittl <knittl89@googlemail.com>
Subject: Re: How to do a fast-forward merge without a checkout?
Date: Mon, 18 Jul 2011 18:24:37 +0200
Message-ID: <CACx-yZ3_nZT61GXqE4uF5JRVekrqFKT4++spEKpL3vPdM8Nh8Q@mail.gmail.com>
References: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
 <CACx-yZ1H5UfA9SeaGy-Ph+20BEsewJe7_78wQsr92Y09skSWHA@mail.gmail.com> <CAF_dkJAx4mK26HcarMtRosy=MU8DgKx9aHWXXbTMK9kG=1LZWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 18:25:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiqcy-0004QS-HG
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab1GRQY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 12:24:58 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61182 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1GRQY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 12:24:58 -0400
Received: by vxh35 with SMTP id 35so1741071vxh.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ONxY7cKyUpXH8MChn8CJITrogLQmQUXflWYN1xp17cg=;
        b=iialxYOtIZgw9Q9NOZGDaUjr8OavVnRAettR/l65d25cYBFwRUPGPXryzDON6ggE8l
         gYFhLzwMMAXLBx6mT/TZKWpLkOUTiVysVq0r1aDZJcX6+2ZbwpxmtJkntFAw3kZHWZPm
         Xu5fP9ICT5dl4lP3pdYnpF3IbrAPcGh78uZaY=
Received: by 10.52.76.105 with SMTP id j9mr6824279vdw.220.1311006297111; Mon,
 18 Jul 2011 09:24:57 -0700 (PDT)
Received: by 10.52.106.163 with HTTP; Mon, 18 Jul 2011 09:24:37 -0700 (PDT)
In-Reply-To: <CAF_dkJAx4mK26HcarMtRosy=MU8DgKx9aHWXXbTMK9kG=1LZWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177382>

On Mon, Jul 18, 2011 at 6:13 PM, Patrick Doyle <wpdster@gmail.com> wrot=
e:
> On Mon, Jul 18, 2011 at 12:08 PM, knittl <knittl89@googlemail.com> wr=
ote:
>> On Mon, Jul 18, 2011 at 4:18 PM, Patrick Doyle <wpdster@gmail.com> w=
rote:
>>> [=85]
>>>
>>> $ git push
>>> [=85]
>>> To somehost:path/to/repo
>>> =A0 e1004df..bad8767 =A0wpd -> wpd
>>> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast-forward)
>>> error: failed to push some refs to 'somehost:path/to/repo'
>>> To prevent you from losing history, non-fast-forward updates were r=
ejected
>>> Merge the remote changes (e.g. 'git pull') before pushing again. =A0=
See the
>>> 'Note about fast-forwards' section of 'git push --help' for details=
=2E
>>>
>>
>> another way to avoid pushing the master branch is to explicitely nam=
e
>> the branch to push (wpd):
>>
>> =A0 =A0$ git push origin wpd
>>
> Thanks... I thought of that, but being basically lazy and not wanting
> to have to type all of those extra characters every time I did a "git
> push", I wanted to figure out a better way.

I can understand your laziness ;)

> Seth Milliken posted a great explanation and alternative solution in =
a
> comment to a blog post I found at
> http://ken-blog.krugler.org/2010/02/25/git-failed-to-push-some-refs-t=
he-multiple-branch-variant/.
> =A0He suggested doing:
>
> $ git config remote.origin.push HEAD
>
> So that "git push" would default to only pushing the current branch.
> I like that approach to my underlying problem as well.

I prefer to use

    $ git config --global push.default current

which tells git to push the current branch to a branch of the same
name (for every repository). Another possible (and useful) value is
"upstream"/"tracking": push the current branch to it's upstream. Have
a look at the git config manpage for more options.

> But I stand in awe of Hanne's solution (#2) for it's brevity, the fac=
t
> that it does _exactly_ what I was asking about, and that the
> capability is already baked into git.

Yup, pushing into the current repository to fast-forward branches
without checkout is quite neat indeed :)

Daniel

--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
