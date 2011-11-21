From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Tue, 22 Nov 2011 01:47:36 +0200
Message-ID: <CAMP44s3StLjb9KgBkRrG4nPqJD_ZjeSyFUwuP4A3b+mJKBgHWQ@mail.gmail.com>
References: <20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
	<CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
	<20111108181442.GA17317@sigill.intra.peff.net>
	<CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
	<20111111181352.GA16055@sigill.intra.peff.net>
	<CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
	<20111114122556.GB19746@sigill.intra.peff.net>
	<CAMP44s1G9jJyiis7z7XbPvW925E-u=0_-h9jJKkj2wyPS9o5ig@mail.gmail.com>
	<20111121214450.GA20338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 22 00:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSdaW-00009O-Oz
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 00:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab1KUXrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 18:47:40 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63675 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab1KUXrh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 18:47:37 -0500
Received: by ggnr5 with SMTP id r5so2932835ggn.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 15:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KK6pmJdsATYmg+bKJp36+RxVe/9Whcv5tMhKH9/V3oc=;
        b=CYPirB06RU1sAVev5TzRv+PIKQn6J48Jk82ig9XftpabYZp0iuyBWmTcPj17gG4Pac
         ldeMtEc1bAHwiJvXHypTF0vTKcEsOA4bmWOArn1Sjku7o22LlbQPid8NOQO0jOSs/3Z3
         iafunr4YTo3eTG5rAaa5WGsihBadV0tuD3Bvo=
Received: by 10.68.21.162 with SMTP id w2mr35752352pbe.25.1321919256757; Mon,
 21 Nov 2011 15:47:36 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Mon, 21 Nov 2011 15:47:36 -0800 (PST)
In-Reply-To: <20111121214450.GA20338@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185770>

On Mon, Nov 21, 2011 at 11:44 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 14, 2011 at 03:57:07PM +0200, Felipe Contreras wrote:
>
>> >> I'm not going to investigate the subtleties of these different se=
tups,
>> >> I'm going to put my common user hat and ask; how do I fetch as a
>> >> mirror?
>> >
>> > The problem with that question is that you haven't defined mirror.=
 Does
>> > that mean you just want pruning, or does it mean that you want you=
r
>> > local ref namespace to match that of the remote?
>>
>> Exactly, no mirror has been defined, because I don't want a mirror. =
A
>> mirror is supposed to have all the refs in sync all the time; that's
>> not what I want.
>
> I didn't mean "you didn't define a mirror in your config". I meant "y=
our
> question is not well-defined, because you haven't defined the term
> 'mirror'". IOW, I can't answer your question without knowing exactly
> what you meant.

I wasn't the one that brought the mirror up, you did:

> I think --prune wouldn't need renaming. If you fetch into tracking
> branches, then pruning would prune tracking branches. If you fetch as=
 a
> mirror (refs/*:refs/*), then you would prune everything.

So you should know what you meant :)

>> > BTW, right now there is "git remote add --mirror ...", which sets =
up the
>> > fetch refspec for you (in this case, mirror is "make your refs loo=
k like
>> > the remote's"). Perhaps rather than adding syntactic sugar to fetc=
h, it
>> > would be best to channel users into configuring a remote that sele=
cts
>> > from one of a few common setups (including different types of mirr=
ors).
>>
>> But that assumes that they would want the same refspec operation *al=
l
>> the time* which is not the case (at least for me). Sometimes I want =
to
>> update only existing branches, sometimes I want to fetch new branche=
s
>> too, sometimes I want to prune local branches, sometimes not.
>
> OK, then that means it must be a fetch command-line thing, not a
> configured thing. Though note that even leaving prune out, I don't th=
ink
> git does what you want (e.g., how are you fetching only to update
> existing branches?).

It should be possible to do a git fetch, so the remote tracking
branches are updated, and then compare those with the local ones. This
might not feel natural under 'git fetch' which is why I decided to use
'git remote sync'.

>> > No, you would just do "--prune", because your refspecs are _alread=
y_
>> > indicating that you are writing into the local namespace, and anyt=
hing
>> > you have locally would be deleted by the prune operation. I.e., th=
ere is
>> > no need for --prune-local in this scenario; --prune already does w=
hat we
>> > want.
>>
>> That's very risky. The user might forget that this is a mirror repo,
>> and delete the local branches unintentionally. Plus, it would be the=
n
>> impossible to prune remote tracking branches.
>
> Sorry, but I don't see how "--prune" is supposed to know what to prun=
e
> except through the refspecs that have been provided to it (either in
> configuration or on the command line). So what is:

That's why I suggested --prune-local.

> =C2=A0git fetch --prune <remote> refs/*:refs/*
>
> _supposed_ to do, if not prune your local namespace?

I thought 'git fetch --prune <remote_mirror>' would not prune the
local branches, but now I see that it does (currently), so nevermind.

>> > As a user, how do I resolve the situation? I might say topic-Y is
>> > obsolete and get rid of it. I might rebase it onto another branch.=
 Or I
>> > might declare it to have no upstream. But all of those are branch
>> > operations, not fetch operations.
>>
>> Yes, but that has nothing to do with the operation I want to achieve=
:
>> git remote sync. By which I mean synchronize the local branches with
>> the branches of a certain remote.
>
> Right. I was only trying to explain a case where you would want to pr=
une
> in the local namespace, when fetch is not configured to touch the loc=
al
> namespace. Which is the only use case I could think of for something
> named --prune-local. But let's forget it. My point was that it is not
> related to fetch, and I was just guessing at what you might want from
> --prune-local.

Basically 'git fetch --prune <remote> refs/*:refs/*', when the remote
is not configured as a mirror. But it would be nice to prune the
branches without having to update the local ones (for whatever
reason).

>> > So what I was trying to say was that either your fetch refspecs te=
ll
>> > fetch to write into your local branch namespace, or not. If they d=
o,
>> > then --prune is sufficient (with no -local variant required). If n=
ot,
>> > then touching your local branch namespace is outside the scope of =
fetch.
>>
>> I don't want this to be a *permanent* configuration. I see this
>> similar to --force. You can achieve the same by adding a + at the
>> beginning of the refspec, but this is something that should be
>> activated on a per-command basis, thus the option. I think this shou=
ld
>> be the same.
>
> Then you can tweak what is pruned on a per-command basis by providing
> alternate refspecs. Right now that would probably mean:
>
> =C2=A0git fetch --prune <remote> refs/*:refs/*
>
> or
>
> =C2=A0git fetch --prune <remote> refs/heads/*:refs/remotes/<remote>/*
>
> but as we discussed earlier in the thread, those can be made less sca=
ry
> with syntactic sugar.

Indeed, but those commands will also update the local branches.

--=20
=46elipe Contreras
