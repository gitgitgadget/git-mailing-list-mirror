From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 09:23:09 -0700
Message-ID: <7vfvxgqp3m.fsf@alter.siamese.dyndns.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
	<7v38thwn6l.fsf@alter.siamese.dyndns.org>
	<BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
	<7v1u91uw95.fsf@alter.siamese.dyndns.org>
	<08847FEAFB00489695F31AA651F5EA2E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue May 21 18:23:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UepLK-0000YK-GS
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab3EUQXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 12:23:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3EUQXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 12:23:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA962069D;
	Tue, 21 May 2013 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MDsiSOqqfiM2WutmsgsKqh5zLiU=; b=Ww0Y1+
	ll8jqttqfIaKgGcQCTgKnrePjsHmEELpcY7zJ0Fz7RyPpjjEQejwZ6PGL50plTfk
	DGNgn2GrE9SPdwkUtRMtmVSrVQhrktryWYGiW1F46kPDxAmXjqiRovgkKIUt/SwV
	QaJAWGXumty6NOsRgOZ9DClxuBJHG5DsGjBVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZiNhIt3/G6Ko6zTGBfeUlDFs+jgNIJJu
	9t+VLfRU1zYvSWAVGlcVOSkR11OOAhkthV0J0xut9lVRG1mKWWt8QqSGRSxX0RXV
	lgy+ZfhcAsYu+mloR4DG8OZEzdm9PezXcgDXU9d/cPzh0i4tXYTDwO7fpYQ8VLda
	+TuA6VE9vK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1223D2069C;
	Tue, 21 May 2013 16:23:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3950120687;
	Tue, 21 May 2013 16:23:11 +0000 (UTC)
In-Reply-To: <08847FEAFB00489695F31AA651F5EA2E@PhilipOakley> (Philip Oakley's
	message of "Tue, 21 May 2013 08:47:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAC9517E-C232-11E2-B896-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225036>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Monday, May 20, 2013 11:22 PM
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> So we can have a branch whose remote is '.'
>>> _and_ a remote whose URL is '.'
>>
>> Yes, and they are two separate concepts.
> Thank you of the confirmation.
>
>>
>> "git fetch" while on "mywork" branch with this:
>>
>>    [branch "mywork"]
>>        remote = git://git.k.org/pub/scm/git/git.git
>>        merge = refs/heads/master
>>
>> without having any named remote whose remote.$name.url is set to
>> that URL may happen to work but it is by accident as far as I know.
> Interesting. Any thoughts on which way it should be
> documented/deprecated?

If "leave it as-is" is not an option, I personally would prefer
mentioning "this happens to work, but do not rely on it" in the
passing.  I do not see any immediate need to break things for people
discovered that this happens to work and who decided that they have
no need for a remote tracking branch for the particular remote this
branch happens to integrate with.  By making that choice, they may
be forgoing the use of @{u}, but they won't be inconvenienced as
"git fetch" will leave what they need @{u} for in FETCH_HEAD, i.e.
instead of doing

	git fetch
	git log [-p] ..@{u}
        git merge @{u} ;# or git rebase @{u}

as a "verify in the middle" replacement for "git pull [--rebase]",
they can do

	git fetch
	git log [-p] ..FETCH_HEAD
        git merge FETCH_HEAD ;# or git rebase FETCH_HEAD

just fine.

The "do not rely on it" is primarily because there are more familiar
ways invented later (namely, use a named remote instead of writing a
real URL, with remote tracking branches).  I do not think we would
want to deliberately sabotage the people who currently use such a
setting, but I do not see a strong reason to recommend it to people
who are new to Git, either, *unless* they need to fetch from many
different places and do not want to have remote tracking branches
because the only time they care about the state of their remotes is
immediately after they fetched.

>>> Can there be a clash with a named remote that is actually '.', where
>>> the push/fetch is actually a no-op?
>>
>> Nobody sane would do it in the first place, so...
>
> Oh I don't know. I don't think 'sanity' comes into it any more than
> common sense' is common. It's easy to fall into the inverse
> Kruger-Dunning mode where those in the know don't realise how much
> they know, and how 'stupid' those that don't can be (that'd be me;-).

How would you even express such a remote named "." in the first
place?  "git remote add" would not let you say:

	$ git remote add . git://some.where.xz/some/repo.git
        fatal: '.' is not a valid remote name

and even if you add configuration variables by hand, it would not
look like this:

	[remote "."]
        	fetch = +refs/heads/*:refs/remotes/./*

You would want some real token between "refs/remotes/" and the
trailing "/*" instead, so...

> All this 'what's a dot-repo and where can I use it' came about because
> of an answer that give it's use as a 'trick'.
>
> On Sat, May 4, 2013 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com>
> wrote:
>> Another trick is to use "git push":
>>         git push . $production_sha1:refs/heads/master

It all falls out naturally from the "Git is distributed and no
repository is special" principle.  I think that word "trick" merely
refers to "those who do not realize that the local repository is not
all that special and merely is _a_ repository just like anybody
else's may not realize they can do this", nothing more.

> Filipe gave 'git fetch .' in [PATCH 1/3] fetch: add --allow-local
> option, 16 May 2013

That patch came from a mistaken suggestion from me that was
retracted with

    http://article.gmane.org/gmane.comp.version-control.git/224729
