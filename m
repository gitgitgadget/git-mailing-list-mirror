From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 23:54:16 +0200
Message-ID: <op.uv3ogqin1e62zd@merlin.emma.line.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
 <7veit9m8cs.fsf@alter.siamese.dyndns.org> <863a9oz8lh.fsf@blue.stonehenge.com>
 <4A43A6B3.5020407@gmx.de> <7v3a9ogr8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJwtq-0002FF-Hn
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 23:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbZFYVyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 17:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZFYVyT
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 17:54:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:47360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750720AbZFYVyS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 17:54:18 -0400
Received: (qmail invoked by alias); 25 Jun 2009 21:54:20 -0000
Received: from g227148096.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.227.148.96]
  by mail.gmx.net (mp069) with SMTP; 25 Jun 2009 23:54:20 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+rtlM/WxqrPhfGVLORjcENwR4eEx8HRa7K4cq8gP
	WEQ4U5xXG3l2v+
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id BF20C9462F;
	Thu, 25 Jun 2009 23:54:16 +0200 (CEST)
In-Reply-To: <7v3a9ogr8f.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122247>

Am 25.06.2009, 19:25 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> Matthias Andree <matthias.andree@gmx.de> writes:
>
>> Could we ditch the current git-pull --append description? Can then =20
>> please somebody rewrite this paragraph? This somebody must have =20
>> completely understood
>
>> (1) what this feature is good for (practically speaking)
>>
>> (2) how it works (technically speaking, to provide reference =20
>> information)
>>
>> That would be much more useful, and the use would last longer :-)
>>
>> I don't dare ask Junio directly.
>
> But if you run blame and mailing list archive search, you would disco=
ver
> that "fetch --append" was my invention.  After all, the entire Octopu=
s
> idea originates from me at 211232b (Octopus merge of the following fi=
ve
> patches., 2005-05-05).  It is interesting to realize that it was actu=
ally
> a Pentapus made on the day of 5/5/5 ;-)

=46air enough, but I hadn't looked at who wrote it because more people =
than =20
just the original author can be able to write it. In fact, I've drifted=
 =20
into doing that. Suggestions at the very end if you're not interested i=
n =20
the rationale, but if you are only interested the solution. :-)

I've seen your later message on the octopus merges, and therefore sugge=
st =20
that we get this --append stuff documented first.

> I thought I was going to take blame on the incomprehensive documentat=
ion
> and pass it on to me being non-native speaker/writer of English, but =
the
> situation is bit funny.  Documentation/fetch-options.txt says this:

Neither am I a native writer, why bother=E2=80=A6 it's more important t=
o write =20
things clearly than to polish things, and writing something correctly f=
rom =20
the beginning is a very hard problem. Writing something that works, and=
 =20
later polish, are two simpler problems.
Language isn't the concern here, but understanding the feature is.

>     -a::
>     --append::
>             Append ref names and object names of fetched refs to the
>             existing contents of `.git/FETCH_HEAD`.  Without this
>             option old data in `.git/FETCH_HEAD` will be overwritten.
>
> Perhaps there has a cut&paste error?  I haven't looked.

Nevermind, that's irrelevant. The key problem is that Linus could not t=
ell =20
 from this description that it was the feature he was looking for. So l=
et's =20
fix that and make documentation clearer. Particularly: let's fix the =20
git-fetch manpage, let's untangle it from git-pull, and let git-pull =20
reference the git-fetch description rather than copy it.

This quoted section "Append ref... overwritten." explains how the beast=
 =20
works technically. So what? What is it good for?  What can I do with it=
?  =20
You made FETCH_HEAD the focus point of the description, but that's not =
the =20
point. (It may be the point of the implementation, but I don't care).

In order for a reader to understand this feature from the docs, he must=
 =20
know what FETCH_HEAD is good for in the whole git context (as a =20
requisite), but that is just a diversion, not the key point.

The point is that you can mark several branches for merge, or in other =
=20
words, accumulate other tips/heads that you want to merge, before doing=
 =20
the merge. It is useful for merges of more than one branch at a time, =20
"octopus merges" or similar.


Preface: the next comments don't mean to criticize what you are =20
presenting, but just to select which should and which shouldn't go in t=
he =20
reference manual, and if yes, where. I think we've got the whole =20
description organized backwards, let's fix that, too.

>  (2) "git fetch" leaves list of <commit object, repo, branch, flag> f=
or
>      each ref fetched from repository in .git/FETCH_HEAD, where flag =
=20
> tells
>      if it is meant for merging.  "git pull" runs "git fetch", reads =
from
>      this file to learn which ones to pass to "git merge".  The
>      information also is given to "git fmt-merge-msg" to come up with=
 the
>      message.

This is a technical detail - this belongs into a separate FETCH_HEAD =20
document in section 5 (file formats).

>      Usually "git fetch" first empties the existing contents of the f=
ile
>      and stores the list of refs it fetched.  With --append, it doesn=
't
>      empty the file; refs fetched by the previous invocation of "git
>      fetch" will be kept and the refs it fetched are appenede.

OK. Also for later, so I know how it differs from regular behaviour.

So, this is technically more comprehensive, but that leaves the old =20
question unanswered - what is FETCH_HEAD good for?

Let's change roles (or perspective) for a moment, for the sake of clari=
ty =20
and usability: I am just a Git user. I don't want to hack Git. I couldn=
't =20
care less about implementation details such as FETCH_HEAD, I only need =
to =20
know how I can tell Git to merge branches foo, bar, baz into master in =
one =20
single merge.

>      So:
>
> 	$ git fetch one a
>       $ git fetch --append two b
>       $ git pull --apend three c
>
>      will end up having all the three refs from different repositorie=
s in
>      .git/FETCH_HEAD.  I.e.
>
> 	branch a, from repo one, to be merged
> 	branch b, from repo two, to be merged
> 	branch c, from repo three, to be merged
>
>      when "git fetch" run by the the last "git pull" returns.  "git p=
ull"
>      reads the file and learn what to give to "git fmt-merge-msg" (to=
 =20
> come
>      up with the message for the merge commit) and "git merge" (to cr=
eate
>      the merge commit).

Let's leave git pull out of this picture. If you mention it, you must =20
explain the interaction between pull and fetch, but you don't want this=
 =20
here. You only want to explain the interaction between fetching more th=
an =20
one branch and merging all of them.

"git pull" (at bird eye's view) is just a short-cut for "git fetch =20
something" and "git merge with somehow configured branch" (somehow =3D =
=20
implicitly through setting up tracking branches, or clone), or explicit=
ly =20
through git branch, or git remote -- let's leave this aside.

So, here's my first stab at it (just content, not ASCIIDOC markup, as I=
'm =20
not fluent in ASCIIDOC and you can easily do that when merging later) -=
 =20
feel free to correct edit, rewrite, amend to it...

I'm not sure


=46ETCH_HEAD(5)
-------------------------------------------------
This file in the git directory records which heads have been downloaded=
, =20
 from where, and for what purpose. Each line in this file is one =20
TAB-delimited record with three fields. From left to right, these field=
s =20
contain:

1 - the commit of the remote head
2 - "not-for-merge" if the branch is not meant to be merged, otherwise,=
 =20
this field remains empty
3 - branch 'xxx' of UUU, where xxx and UUU are the remote repository's =
=20
refname and base URL, respectively.

This file is written by git-fetch and used by git-merge.
-------------------------------------------------



git-fetch(1)
-------------------------------------------------
=2E..
      -a::
      --append::
	This option allows you to fetch and accumulate multiple remote refs fo=
r =20
future merging.  Normally, git-fetch records the latest fetch for a lat=
er =20
merge, by writing them to .git/FETCH_HEAD (there can be multiple record=
ed =20
heads in FETCH_HEAD although the name suggests there were just one).  T=
he =20
--append option lets git-fetch keep, rather than delete, prior contents=
 of =20
the file.  This can be ueful when consolidating multiple topic branches=
 in =20
one single merge (a so-called octopus merge, see git-merge(1)). Example=
:

> 	$ git fetch one a
>       $ git fetch --append two b
>       $ git pull --append three c

(git pull first runs git fetch --append three c, and then git merge wit=
h =20
all remotes that have been recorded for merging in .git/FETCH_HEAD).

=2E..
You can use git-pull as short-cut for the all too common =20
"git-fetch"-"git-merge" sequence.
-------------------------------------------------


NOTE: git-fetch accepts command lines without refspec. These mark fetch=
ed =20
heads as "not-for-merge". IOW, a refspec is needed that heads are marke=
d =20
as for-merge. I haven't found this documented in git-fetch.

--=20
Matthias Andree
