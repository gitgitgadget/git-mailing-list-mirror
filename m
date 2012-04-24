From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 11:54:08 -0700
Message-ID: <CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
	<nnghaw93v8n.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: dag@cray.com
X-From: git-owner@vger.kernel.org Tue Apr 24 20:54:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMksR-0007Pa-MU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 20:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab2DXSyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 14:54:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59718 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab2DXSyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 14:54:09 -0400
Received: by yhmm54 with SMTP id m54so634326yhm.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LVH6swlYtnMH7uOaoPqrCsRZ2a+2lN1XqqBmfGZVSrY=;
        b=pOsY5GaSbj98tebQCvMPgxeXtOoqg9IlbxWl/ShI8vEruv4n8nzHu4R96609/H3m0F
         1xxuY8G9+e3/Txt2WtbAfAL8ZUJX7HdnDrGEjmbTmKbEcKlZygA2GDuFZzKBaVnnr0Tq
         hJcNb8iZPlHV1whiDBk8+o1zPCcvRnAl6VgDEd4qCxL7iAUS91mH0KRyyH6/fzV7QFtk
         YKVOJr2ZhIBoMvlN0v1UGgN/1QgLBzoKRx9fxjL80gdtOAmoSw8KIVLxBUciDyXhuvp9
         PSJlVEMZRMJcbVPxifWDMT5l+6Vbd4Dtp6ilfQLISMDd+J8WTRcQRQ0gZ31qULZ8nVN7
         Cybw==
Received: by 10.236.170.199 with SMTP id p47mr4694648yhl.114.1335293648533;
 Tue, 24 Apr 2012 11:54:08 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 24 Apr 2012 11:54:08 -0700 (PDT)
In-Reply-To: <nnghaw93v8n.fsf@transit.us.cray.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196235>

On 24 April 2012 10:17,  <dag@cray.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> I'm assuming that if you have subproject S in umbrella project U and=
 a
>> branch "topic" in U then that same branch should exist in S.
>
> No, I think that is actually very rare. =C2=A0If topic branches reall=
y should
> be mirrored then U and S should be one repository. =C2=A0They are too=
 closely
> coupled to be separated. =C2=A0But see the but about git-subtree and =
topic
> branches below.

Too closely coupled? I do not think breaking up a project into a set
of libraries makes everything tightly coupled. I would argue the
opposite. :-) Anyway, you answer my concern below.

>>> Of course, this is entirely driven by git-subtree's model of actual=
ly
>>> incorporating subproject history into one big umbrella repository.
>>> There is no separation between the subprojects and umbrella project=
s.
>>> It's one giant history. =C2=A0Therefore, push/pull to/from subproje=
cts are
>>> explicit operations. =C2=A0That's probably not the best model for e=
very
>>> situation but I find it very nice.
>>
>> I do not have enough (okay, any) experience with subtree to comment =
on
>> that. The first part seems just what I want. I'm not sure about the
>> explicit pushing/pulling part. That sounds too much like asking for
>> the sort of problems that scared us away from submodules. Hopefully,
>> I'm dead wrong. :-)
>
> With subtrees, a topic branch in the umbrella project WILL be reflect=
ed
> in the subproject because it is really one big repository. =C2=A0It's=
 a
> little inconvenient to subtree push a new tag at the moment. =C2=A0Yo=
u have
> to do a subtree split to a new branch and then push the branch to the
> original component repository. =C2=A0That's one thing I want to impro=
ve in
> the short term. =C2=A0I have found a need for then when creating rele=
ase
> tags.

Okay, that would work fine. I have no problem with a bit of extra work
here. (In fact, this is probably where I would *want* a bit of extra
control.)

What would happen if you had a bunch of commits in the umbrella
project and then did a push? Would that error out? Are there
protections in place to prevent developers from making silly mistakes
like that?

> But still, it seems odd to me that you'd create a topic branch in U a=
nd
> then want to push it to a separate S repository. =C2=A0Topic branches=
 are by
> nature ephemeral and I have never had a need to do something like tha=
t.
> It just seems to go against the grain of what a topic branch is. =C2=A0=
As I
> said above, release tags and such are in a different category and tha=
t
> is the main target of the subtree push enhancements I want to make.

I had not realized all changes would simply be part of the umbrella
project. Given that, a topic branch in each subproject's repo is
unnecessary.

Cheers,
Hilco
