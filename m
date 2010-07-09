From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Handling tags/branches after git-svn fetch during SVN to Git 
	conversion
Date: Thu, 8 Jul 2010 20:34:10 -0700
Message-ID: <AANLkTimDSO6CeClHlrLlFQbYbXOhSPJMUUn24nlmP1-8@mail.gmail.com>
References: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com> 
	<AANLkTinAhxIKD6U3u4OpPnt5kDMPGTyhDhhCRaFtU-gA@mail.gmail.com> 
	<AANLkTilnoIyrKg4PLSL71RDU-vyvIeNEtJ8STkOd9Lcq@mail.gmail.com> 
	<AANLkTilNLjTn1FyRqqz5xmOi4rOnSIwMUy6dOb0c0sRt@mail.gmail.com> 
	<AANLkTilJ9tAO6Zf9whowApqhcpXU8Qvm31Z9RrQ3QaS6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 05:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX4MG-0001T7-9b
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab0GIDeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 23:34:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39599 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0GIDeb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 23:34:31 -0400
Received: by qyk35 with SMTP id 35so167083qyk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 20:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5A1fpPQUTUxUuKzd/r+ybuYPlxpBAJJfOjKg3nNaMYs=;
        b=rCQVP1MncNGDtrqOHojbkeBArRo5L3lPhGytqSVPDjtdG/BvxcZ5xtu+sn+Xz3fntX
         UYW8clz0ONdBDUkPRXz4TqwUoziTPDaqel1qMQn8hfn7Ksn93yHTuebhfALP/zgwZTvj
         pGqqs3G4f0Xm/2To2Ll9JTHrpM+QQpDdg1o34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aKBlxFIjTI7pQtiMeen10x7uchNqwSoLkMn7sGY2Jrinbat609VAA5RfdATO3YjNhK
         ORUPlyOX/KUn9AxkLFgqu9G0VHQHdgIxYq9FD7CVw27jZWLAxxCiPp7UQkavgBOdtaJ9
         vRjwe9NeIX3wXgWGGkVweWnSsrd5n5gyYMJXE=
Received: by 10.224.114.150 with SMTP id e22mr424670qaq.311.1278646470278; 
	Thu, 08 Jul 2010 20:34:30 -0700 (PDT)
Received: by 10.229.25.4 with HTTP; Thu, 8 Jul 2010 20:34:10 -0700 (PDT)
In-Reply-To: <AANLkTilJ9tAO6Zf9whowApqhcpXU8Qvm31Z9RrQ3QaS6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150638>

On Thu, Jul 8, 2010 at 20:18, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> Thanks. Yea I was just looking at the man page trying to find the
> notation with the colon separated ref names.
>
> Is ":refs/heads/branch-foo" equivalent to just saying ":branch-foo" i=
n
> the remote Git repo? Do I need the refs/heads piece?
>

That really depends on whether or not branch-foo already exists or
not.  From what I remember, if you use the <local>:<remote> syntax,
then you need the refs/heads bit if the branch doesn't already exist.

> I'm trying to understand what a usual "git push origin branch-foo"
> equates to using your syntax.
>

It's equivalent to:
  git push origin refs/heads/branch-foo:refs/heads/branch-foo
  git push origin branch-foo:refs/heads/branch-foo
  # If branch-foo already exists on the remote end, it's also the same =
as:
  git push origin refs/heads/branch-foo:branch-foo
  git push origin branch-foo:branch-foo

> On Thu, Jul 8, 2010 at 11:09 PM, Jacob Helwig <jacob.helwig@gmail.com=
> wrote:
>> remote2 would be the name of your remote repo, yes.
>>
>> origin/branch-foo would be equivalent to svn/branch-foo in your loca=
l
>> repo, if you did "git branch -a". =C2=A0It should be the name of one=
 of the
>> git-svn created branches.
>>
>> refs/heads/branch-foo is telling git where to store the reference fo=
r
>> the branch within remote2. =C2=A0It does not need to exist already, =
and
>> should not in your case.
>>
>> The git-push man page has more in-depth explanations, if you're inte=
rested.
>>
>> On Thu, Jul 8, 2010 at 20:01, Bradley Wagner
>> <bradley.wagner@hannonhill.com> wrote:
>>> In your example, does "remote2" represent the name of my remote Git
>>> repo? What is "origin/branch-foo" and does the path
>>> "refs/heads/branch-foo" need to actually exist in my .git directory=
?
>>>
>>> On Thu, Jul 8, 2010 at 10:54 PM, Jacob Helwig <jacob.helwig@gmail.c=
om> wrote:
>>>> On Wed, Jul 7, 2010 at 06:36, Bradley Wagner
>>>> <bradley.wagner@hannonhill.com> wrote:
>>>>> Do I need to convert these remote tags/branches into local Git
>>>>> tags/branches before pushing them to my remote Git repo or is the=
re a
>>>>> way to push remote branches directly to my remote Git repo?
>>>>>
>>>>
>>>> You don't need to "convert" the branches to local ones. =C2=A0git-=
push will
>>>> accept any ref your local repo knows about when you do a push. =C2=
=A0For
>>>> example "git push remote2 origin/branch-foo:refs/heads/branch-foo"
>>>> works just fine, even if you don't have a "local" branch called
>>>> "branch-foo", and it will push the branch-foo branch out to the
>>>> remote2 remote repository.
>>>>
>>>> The tags, you'll need to convert to _actual_ tags, instead of just
>>>> branches under a tags/ namespace. =C2=A0Unless you're fine with th=
em
>>>> staying as pseudo-tags, then you can just push them out as you wou=
ld
>>>> any other branch.
>>>>
>>>> -Jacob
>
