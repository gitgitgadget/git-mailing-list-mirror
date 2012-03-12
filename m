From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Mon, 12 Mar 2012 12:06:48 -0700
Message-ID: <7vfwddskon.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7AaB-0005kh-8C
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab2CLTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:06:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105Ab2CLTGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 15:06:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 741F57796;
	Mon, 12 Mar 2012 15:06:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NbLWqjs/BiFm9eIFIzCf2Gx93+s=; b=jfBiIl
	6984uOpjqwqSZ8nEx68pmd8DGjgfIkyTfKNRwggnuerBssZ8L1quDibXq0XXew7L
	GRfoqSNlpsASPzKm+btrZ0pv2KiMyQFHS6GbdA3EH+14WPUokYdhUla241OLQRNX
	0tSpULCBdOnYB2yALkXJhEdIa2AbuR7Z9hTyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QdRAnbD+4oIKJ3F+ssLUXGYIEO6Ymr5Y
	xcu8gBlAzbjvv8LD+nPodjpBVYIKg2sBVQ6xUzrf+p4ZxdElkSvPMrVFRlrI8Ubi
	FOabNDAt4FjMSjZgY5RG4AsPYT/YOPcTprNrSElfMp/cUcVw9jjVQvo/3OsQqKpy
	LsK9gFlcR+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B66D7795;
	Mon, 12 Mar 2012 15:06:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7148D7794; Mon, 12 Mar 2012
 15:06:50 -0400 (EDT)
In-Reply-To: <20120312183725.GA2187@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Mar 2012 14:37:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85CFD8CA-6C76-11E1-A3EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192925>

Jeff King <peff@peff.net> writes:

> ... This is not a push.default issue,
> but I think it is somewhat related, and maybe worth discussing along
> with the topic of asymmetry. ...
> I've mostly trained my fingers to type "git push
> <my-publish-repo>", but I do occasionally forget.

In an assymmetric set-up, you would typically push into one place
but update from one or more places, so it might make sense to make
it easier to say "git push" and "git pull $there".  But that does
not solve the fundamental issue, I would think.

> Do other people with
> asymmetric workflows find this annoying? Do they not care? Or are many
> fewer people doing asymmetric things than I think?

I think it is not "they do not care", but "they do not have a good
solution".  I do not think of anything offhand, either.

> While I'm ranting, there's another weirdness I noticed. If I have
> push.default set to upstream, and config like this:
>
>   [branch "foo"]
>      remote = origin
>      merge = refs/heads/master
>
> then typing "git push" will go to foo's master branch. But if I type
> "git push other-remote", then it will go to other-remote's master
> branch. Which makes no sense to me. The upstream is foo's master, and
> now we are making guesses about how the names on each side are the same.
> Is this an intentional behavior?

Because "upstream" is meant to be "For the branch I am on, you know
how the branches map between the remote repository, so you already
know what the right thing to do---do it" mode, the correct "guess"
in your case is to error out and say "Nah, you are not talking with
your upstream, so I do not have any clue what branches you want to
push out and how. As you said that the push.default is upstream, not
matching, I refuse to even do the matching push in your case.  This
is an error. Be more specific".

> Actually, this is the thing that scares me the most about "upstream" as
> a default, because in this case, you are implicitly performing the
> equivalent of a fast-forward merge. So that's handy if you are a new
> user who wants to publish your work back to the master branch. But that
> has two problems:
>
>   1. If you are a new user who does like the implicit merge, you
>   may find it convenient not to have to learn about ... << and we
>   shouldn't discourage them from learning as it will be needed
>   anyway >>
>
>   2. If you are a new user who _doesn't_ want to do the merge, but
>   instead wants to publish your work-in-progress topic, then the
>   implicit merge-back-to-master behavior is wrong and dangerous.
>   << the newbie may push -f ruining the work of others >>

I agree with both points.  Also there is a cross-variant issue of
the above two:

	If a new user hears "not fast-forward, first pull and then
	push again", that will be done on a topic branch, merging
	'master' back and then pushing the result to 'master',
	leaving the 'master' of the user behind.

> So far a lot of the discussion has focused on "what is the most sensible
> default for the most number of people". But I wonder if a better
> question is "what is the default that is the least likely to do
> something dangerous and embarrassing". People who use git enough to say
> "wow, I don't like this default for my workflow" are probably at the
> point that they can configure push.default themselves.

I do not think "the most number of people" is a high-priority issue,
but "least damage" default may not be necessarily the best.

Obviously, "nothing" is the least-damage option, and looking at how
even people on this list cannot decide between current and upstream,
I actually am very tempted to suggest it as the new default.
