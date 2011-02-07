From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 03:07:00 +0300
Message-ID: <AANLkTi=A-rh+wfg7O4KryydxVuorM8nkuGYmpbgVfVJp@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102061711.45460.johan@herland.net>
	<AANLkTi=gd5iu0i=ggqJC++N_rL+nU6RO9PNw=jMpT0NH@mail.gmail.com>
	<201102062312.51655.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 01:07:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmEdK-0008OL-Pu
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 01:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab1BGAHD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 19:07:03 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47449 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab1BGAHB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Feb 2011 19:07:01 -0500
Received: by qwa26 with SMTP id 26so3135969qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FeAAp0cNHtBMVu+e/mxEVZzv33DM8ifaWL8DKJ3nOlI=;
        b=dfPYw2c308hacqjoYFsvmqPcn5XTGOow5FFOpGjGpsnoXecFKXtXQHyBTWK/KCFVF7
         /sL64RhHBj+2GrFmFt6wzWJZCx1IbvFPW1kr0ObZEh9xfLzAOGTGmGArBo2zzEAZ1MR1
         eMUIYoz6r7rOWc38QeQPeUMFxXfWmEORATboU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BQvVp3ZgxBsRTwAfUKrQ/JbwETIMvoOm1eSs+3wq8qheGxPfOS1s8YCOabuYlCwGMh
         v81U3tsEeHvxesUD7G7vsntT1wK2BAn3jQNJia6OfopI3VD1B6ggEMY7gK2vboWE7iAI
         WQKc1dz8fjwfuvn7OX9XUudHtv6j3Uh9AudNo=
Received: by 10.229.220.133 with SMTP id hy5mr12260873qcb.269.1297037220580;
 Sun, 06 Feb 2011 16:07:00 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Sun, 6 Feb 2011 16:07:00 -0800 (PST)
In-Reply-To: <201102062312.51655.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166217>

On Sun, Feb 06, 2011 at 11:12:51PM +0100, Johan Herland wrote:
>
> Yes, technically git 1.7.4 is a myth. However, by convention, we all =
agree
> what "v1.7.4" points to, and nobody seriously believe they can get aw=
ay with
> pointing "v1.7.4" somewhere else.

There are two sorts of tags:
- local tags, which are never intended to be shared with others but use=
d
  by users to mark some points in the working repository.
- global tags, which are just _social_convention_ about what the curren=
t
  project considers as official versions. Without social convention, th=
ey
  make no sense.

> The core of this discussion is where we want to place Git in the spac=
e
> between "technically correct" and "socially conventional", where the =
former
> means owning up to the fact that each repo really is its own namespac=
e, and
> there's no way around that in a proper DVCS, and the latter means bui=
lding
> social convention into our tools, thereby making it harder to deal wi=
th the
> few unconventional cases (like my two semi-related repos case).

Tags like words are social convention, which are used for communication
between people participated in a project. But accordingly to you, it
seems somehow "technically correct" to invent their own words in Humpty
Dumpty's ways:

'When I use a word,' Humpty Dumpty said, in rather a scornful tone, 'it
means just what I choose it to mean =97 neither more nor less.'

I am afraid you got the wrong idea about "proper DVCS", because DVCS
does not imply that there is no social convention. It just means that
there is no single authority that dictates everything. Like with words,
there is no single authority that assigns meaning to new words, but
that does not mean that you cannot just say "When I use a word... "
if you want to be understood by others.

>
> AFAICS, my proposal does not harm the common case (unambiguous tags a=
re
> still interpreted unambiguously, even if they may exist in multiple
> namespaces), while it _does_ help the uncommon case (by allowing ambi=
guous
> tags to co-exist in the same repo).

It hurts the common case in a few ways:
1. It breaks existing user scripts
2. It complicates things for users (as Matthieu wrote above).
3. git fetch cannot report a tag clash if it happens

>
> Granted, if we leave all tags in a single namespace, I can still work=
 around
> this by manually futzing with the configured refspecs to create ad ho=
c
> namespaces. But I _really_ hate it when I'm forced to hack around the=
 tool,
> because the tool thinks it "knows better".

I believe that the right interface when the common case is simple, but
an uncommon case is still possible to handle. I don't think that
currently git meets this criterion, but making tag namespaces based on
the remote name strikes me as a really bad idea. Tags are attributes of
a project and not particular remote.

>
> > But, IMHO, it is a myth that having different
> > namespaces solves the problem, because in _most_ cases, you really =
want
> > to have a single namespace _semantically_, so you can communicate w=
ith
> > other people using this tag name.
>
> My proposal tries very hard to present a single namespace _semantical=
ly_ to
> the user in the common case (when tags are unambiguous). I'd even go =
as far
> as proposing that "git tag -l" should by default list only a single
> shortened tag name in the cases where there are multiple unambiguous
> alternatives.

IMHO, it is very confusing, especially for people whose script was
suddenly broken by those namespaces.

>
> Alternatively, I'd suggest a compromise (already mentioned elsewhere =
in this
> thread) where we add a config variable tags.preferredRemote (defaults=
 to
> "origin") which allows you to directly select which namespace you con=
sider
> official. You could even implement this as physically copying
> refs/remotes/${tag.preferredRemote}/tags/* into refs/tags/*.

It seems you do not understand the problem that I am trying to say all
way along: there is more than one repo from which I fetch tags, and
because they are belong to the same project, they should be in the same
namespace.

So, IMHO, the proper solution should be ability to specify the desired
namespace for any remote repository, like this:

remote.<name>.tagNameSpace =3D foo

So, those who want to have many namespaces should be able to that
easily, but forcing multiple namespaces on those who have a single
namespace semantically is simple wrong. Not to mention that it breaks
existing scripts for no good reason.

>
> > > In that case it would be wrong of gitk to display "v1.0". Instead=
 it
> > > should_ display a longer, unambiguous name, e.g. "origin/v1.0".
> >
> > But it is still ambiguous because my "origin" may be different from
> > yours origin. It is only unambiguous when it look at it _locally_ b=
ut
> > that makes it completely useless for communication with other peopl=
e.
> > One project should have only one version with the same tag regardle=
ss
> > where it came from.
>
> Again, you are setting "technical correctness" up against "social
> convention". Technically, _any_ ref name whatsoever is repo-specific =
and
> "completely useless for communication with other people". The only th=
ing we
> can communicate unambiguously is SHA-1 object names. However, social
> conventions compel us to name our refs unambiguously and to use commo=
n sense
> when communicating, so that - in practice - everybody in the project =
knows
> exactly what is meant by "v1.0".

Public tags are purely social convention. If there is no convention,
they are completely meaningless, and we can use only SHA-1. Thus
speaking about technical correctness of tags makes no sense.


Dmitry
