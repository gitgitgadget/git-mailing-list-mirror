From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 23:22:16 -0700
Message-ID: <7vk4ypb71j.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021030608.GA18997@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 08:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Uag-0006az-M3
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 08:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbZJUGWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 02:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbZJUGWY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 02:22:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZJUGWX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 02:22:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE16661E3A;
	Wed, 21 Oct 2009 02:22:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=+MWgOtmdaCIMC2PO0h/4a5gWf
	LU=; b=t29SKEHLw/VIyI1tRb3cPQXxUnVbBh2E7zBs9do6jpl3sgCyJzp7Rh5fH
	HD7aDNHiQU11QpI0gER3dDpgyggzJyLQRWb1d23A52xqBBjSqGWr5EP7nh1bA5fM
	sfZTioHbbD31aP2xlZdqk26l5QOrP/yDCtsA0mGsYKnLZxCMVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=VRb4fLcLeke9WDxM4Xm
	HvbGXb45HDfvU4iPMQKNySJBMlTDdd2gazSo0optmv5gHRkvorOHJul2vYZWNDEe
	h99NsHWT5l6+RbaaiptGvSWnlHoxwDylW+GP+2Xk5TO45C20bUfwQijcQ7hUP/q8
	2tAjsh6MOaJq4LYbkx3gl+E8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A4F61E34;
	Wed, 21 Oct 2009 02:22:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CB4D61E30; Wed, 21 Oct
 2009 02:22:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 183A68C4-BE0A-11DE-9EA1-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130885>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> So that's ten days of #git. I left out a bunch of duplications (most
> were "pull =3D=3D fetch", "pull =3D=3D update" and "pull to update
> non-checked-out branch").

Interesting; this shows that people who do not understand what "pull" d=
oes
expect different behaviour from "pull", use the word "pull" to express
what they want to happen, expect other people interpret the word to mea=
n
the way they think it does.  At the same time, judging from different
behaviour expected by these people, push/pull asymmetry does not seem t=
o
have much to do with the confusion.  If the verb used by people who kno=
w
git to call this operation were "distim", these people would also say
"distim" and expect different things from it.  I would foresee exactly =
the
same problem if the verb were "update" for that matter.

It is just natural, as everybody learns a new language by listening how
others talk and by imitating them.

Another thing I noticed while lurning on the #git channel for the past =
few
days is that too much flexibility actually hurts new people.  They do n=
ot
want flexibility, but want to follow a set recipe.  It just overwhelms =
to
get too much flexibility upfront without enough guidance.

And there are too much historical flexibility that remain merely for
historical reasons.  We more or less killed the concept of separate obj=
ect
store and $GIT_DIR (i.e.one objects/ directory shared between more than
one .git/ directories) when we made receive-pack aware of alternate
repository information---it used to be that objects/ directory did not
belong to a single set of refs/ hierarchy, but now it does and the
receiving end of "git push" uses that knowledge to tell the sender what
not to send in order to minimize the transfer.  We will be gradually
killing other kinds of historical flexibility that do not buy much in
practice anymore, and that would reduce the issue of overwhelming
flexibility.

=46or example, I am in favor of deprecating the "pull $there $src:$dst"
notation.  Before we standardized on the separate remote layout, it was
sometimes handy to be able to use $dst that is a local branch, but thes=
e
days, especially when repository $there has remote.$there.fetch mapping
configured so that we can compute from $src what remote tracking branch=
 we
should store the fetched commit, the flexibility is more confusing than=
 it
is useful.  "pull $there $src" (and "pull $there $src1 $src2" to build =
an
octopus) should stay, but even there, it probably is a good idea for th=
ese
notations to start updating remote tracking branches for $src ($src1 an=
d
$src2 in the octopus case) if the repository is configured to track the=
m
anyway, to match what "pull $there" that uses the default configuration
does.

I am actually even Ok, at least in the long run (like in 3 years), if w=
e
were to deprecate the refspecs with colon given on the command line to
"pull" and "fetch" altogether [*1*].  The rule will become "if you are
going to use tracking branches to store what you fetch, you _must_ alwa=
ys
have the tracking mapping defined in remote.$there.fetch configuration,
and the location where one particular branch from the remote is stored =
is
always determined by that mapping."  It robs us the flexibility to fetc=
h
my 'next' and store it to your 'next' branch today and to your 'mext'
branch tomorrow, and instead you would need to first fetch and then do =
an
explicit "git branch mext origin/next" if you really want to do so, but=
 I
think the flexibility outlived its usefulness --- the primary value of
these kinds of flexibility is to experiment with various workflows and =
UI
concepts they allow, but I think we have gained enough experience to st=
art
judging what works (and is useful) and what doesn't (and is Ok to make =
it
much more cumbersome to make or even impossible to do).


[Footnote]

*1* Except perhaps when deleting branches from the remote with "push", =
but
even there we _could_ force people to do a deleting push separate from
normal push and say "push --delete $there $this $and $that".
