From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 00:22:35 -0700
Message-ID: <7v63a99pok.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021063008.GA3349@glandium.org>
 <7v3a5db6ij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 09:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0VX8-0003ra-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 09:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbZJUHWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 03:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZJUHWs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 03:22:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZJUHWr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 03:22:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0360A7F75A;
	Wed, 21 Oct 2009 03:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=anhRv9VT+YoD
	TfOjMvzffzAZsa4=; b=JCqZ2vZG19AUoX2Q7GS/02PlZIDtWiX3EQQl8ySDcvTu
	sA2YeAszMdvA9Oh8E/kbeNlvybp4RiFUs6hNik1SObpK5ZwWtddsvgIvQAeu58m/
	UFhyoSfuB5WPrtDK7II1KSfmXfHH7q3WknVSJWoHem+rZBl+C6FbVG4Egk1mr04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NS4A4m
	74scSrKSRrqVxZ/Vd0i6iS9MSD3ai4ztPsa1htRlUPZtGRnPH6pR0WSu9QDyLUXs
	a0D7rQh5yBDj5zYiRhZJkjK7SMfUYsYDYoQePObLnkRh72KyPeQ7KK+meYChNKmt
	bTuLbH1xW3vhde18xVF0Dnka2uMXRasY/k+SM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6EF87F758;
	Wed, 21 Oct 2009 03:22:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D272C7F757; Wed, 21 Oct 2009
 03:22:37 -0400 (EDT)
In-Reply-To: <7v3a5db6ij.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 20 Oct 2009 23\:33\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 86BF8EDE-BE12-11DE-B9D9-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130891>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> BTW, shouldn't fetch be deprecated in favour of git remote update ?
>
> Why?  People will then be confused because half of them would expect
> "remote update" to somehow affect their working tree, and some others
> would expect their working tree reset to one of the branches from the
> remote, and it won't solve anything.  Oh, and it will irritate people=
 who
> are used to type "git fetch", too.

I think the above comment needs to be clarified, so that I will not
discourage you or other people who would want to pursue the part I omit=
ted
from my quote too much, which was:

> (this may require adding some features to git remote update, but you =
get
> the idea)

Now, I _personally_ think "git remote update" was a half-baked UI
experiment that failed, but as the maintainer I'll still give it benefi=
t
of doubt for a bit longer and let interested parties resurrect and perf=
ect
it, just in case it might turn out to be a good thing.  In the rest, wh=
en
I say "I think", pretend as if I said _personally_ (i.e. not speaking a=
s
the maintainer who already has given up on it).

I think the original "git remote add" was a good interface, similar to
"git config", as the management interface to the remote system used by =
the
everyday commands "fetch/pull/push".  The everyday commands use the rem=
ote
nicknames and their associated data stored in the configuration file.

While you can edit your configuration file directly to manage the remot=
es,
some people (and recipe book writers) prefer to have a specialized
management command.  "git remote add" is such a management interface th=
at
you use once and then you can forget about it.  Once you get your remot=
e
configured, the everyday commands will use the data in the configuratio=
n
file, and the commands you interract with your remotes will be these
everyday commands, not "git remote".

Some people thought that throwing everything that does something to rem=
ote
under "git remote" was a good idea, and "git remote update" was invente=
d.
It is a thin wrapper around "fetch" and does what "fetch" does.  You ne=
ed
to understand "fetch" (i.e. downloads the history and necessary objects=
,
and updates the remote tracking branches, without ever touching the wor=
k
tree) to understand "git remote update" anyway, and more importantly, y=
ou
need to understand what they do not do.

It is not even a typesaver.  "git fetch" updates from the default remot=
e,
so does "git remote update".  Personally I think the people who invente=
d
"git remote update" were misguided, and that is why I say it was a fail=
ed
UI experiment that failed, but that is hindsight talking [*1*].

After reading Bj=C3=B6rn's excerpts, it was clear to me that the names =
of the
commands have much less to do with the confusion [*2*] than I originall=
y
feared [*3*].  As long as the user needs the same kind of understanding=
 of
what the command does, I do not think changing the command name between
"git remote update" vs "git fetch" and calling everything that has
something to do with remote repositories "remote" would solve anything.
The users also need to understand how to make what these commands do an
integrated part in a larger workflow they use, so that they know what t=
o
do next, which is much more important issue, and at that point the name=
 of
the command is secondary---the concepts counts much more.

"git remote update" even has a slight downside in the "push moves from
here to there, pull moves from there to here" sense.  If you never have
seen git, "git remote update $there" may look like you are asking git t=
o
update the remote called $there, presumably with what you have.  That i=
s
quite opposite direction from how it actually move things.


[Footnote]

*1* The only thing "git remote update" does that "git fetch" does not i=
s
that it can serve as "fetch from everywhere" shorthand.  But that is
something we could have added to "git fetch".  So in that sense, I thin=
k
it may make even more sense to deprecate "remote update" and teach "fet=
ch"
how to do that.

*2* Granted, if our "pull" were named "push", the natural meaning of th=
e
word "push" that moves things from here to there (as opposed to there t=
o
here) may even confuse people, but both "pull" and "fetch" mean moving
things from farther to closer (and nothing more in the natural meaning)=
,
and the confusion expressed in the thread were not of that kind---nobod=
y
expected us to do anything that involves moving something we have to th=
e
remote, but the confusion was about what happens _after_ something was
moved from there to here.

*3* In a sense I somehow was hoping that the confusion was only about t=
he
push/pull asymmetry as some people claimed.  If it were, the problem wo=
uld
have been very easy to fix; you just do not let pull affect the work tr=
ee.
But the confused users were expecting the changes to be reflected to th=
eir
work trees, and the confusion was about how that is done.  Some wanted
their local changes blown away, some wanted their local histories also =
get
blown away, some wanted the changes integrated.
