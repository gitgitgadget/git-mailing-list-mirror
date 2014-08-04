From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Mon, 04 Aug 2014 15:12:13 -0700
Message-ID: <xmqqa97jrjk2.fsf@gitster.dls.corp.google.com>
References: <1406994383-5076-1-git-send-email-philipoakley@iee.org>
	<1406994383-5076-2-git-send-email-philipoakley@iee.org>
	<xmqq38dctcmz.fsf@gitster.dls.corp.google.com>
	<F97E9146985F4449A937B9C5CCA1D7F5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 00:12:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEQUV-0001GV-2d
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 00:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbaHDWMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 18:12:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59088 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbaHDWMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 18:12:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A13182FCB1;
	Mon,  4 Aug 2014 18:12:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOfpGV9YrX2vkdWG2iqhNPKRyok=; b=b6cnRk
	x5ApRZRFzr+DRKeFboUJ8B4ov5X1DQHs3/pZt9skjShIhqBMKfSL+Yipx9p+y9vn
	DC8OxWHDhN2N4c3xAdwIlW6vK7/uWdnMz2axAs4A5QcfbDZYd8kcEH97HYPOVrD8
	BhikEw6YehdmAsX1AUR0qFhQ8gFzwYhjqKl7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fXbPQnqsS9EUgJPv7ehA+CHJwEuKO/Xv
	s0/OW7ENGOtLGGiMcZyxmR6O/n053M/Gf4i2WLtpgDQwA8jY7twV6Pdpk5Q46Axt
	X0ICzJEFJUa4nyIfbgRXonSE7HbhVYFojGBY5lzLIu1660o2Btc6855uB445HrB5
	WYDtyCYswPA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 95A822FCB0;
	Mon,  4 Aug 2014 18:12:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AC4C32FCA0;
	Mon,  4 Aug 2014 18:12:14 -0400 (EDT)
In-Reply-To: <F97E9146985F4449A937B9C5CCA1D7F5@PhilipOakley> (Philip Oakley's
	message of "Mon, 4 Aug 2014 22:51:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 63D345EE-1C24-11E4-A42F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254789>

"Philip Oakley" <philipoakley@iee.org> writes:

>> This however is backwards, no?  The history on 'origin/master' may
>> not be up-to-date in the sense that if you run 'git fetch' you might
>> get more, but it absolutely is up-to-date in the sense that it shows
>> what the origin has to the best of your repository's current
>> knowledge.
>
> I still think that the user/reader shouldn't be creating patches based
> on wherever someone else had got to, rather it should just be patches
> from their own feature branch.

You forked your topic branch off of the shared project history aka
origin/master and built some.  You may have sent some patches off of
your previous work to the upstream, and origin/master may or may not
have applied some of them since your topic forked from it.  The
patches you are sending out is from your own topic branch.

You may be cooking multiple topics, and your local 'master' branch,
which you never push back to 'origin/master', may contain any of
these branches.  You do not fork off a new topic out of there.  Best
case, you would fork from 'origin/master'; a bit worse case, you
have to fork from another of your topic branch that your new topic
has to depend on.

Nowhere I am assuming that "the reader is creating paches based on
wherever someone else had got to".  Sorry, but I have no idea what
you are complaining about.

> However the rest of your argument still
> stands with regard to accidental/unexpected conflicts with other
> upstream work, and the reader should ensure they are already up to
> date - maybe it needs a comment line to state that.

Sorry, but I am not sure how much you understood what I wrote.

The primary reason why 'origin' in the example should be replaced
with 'origin/master' is because that is the literal adjustment from
the pre-separate-remote world order to today's world order.  The
local branch 'origin' (more specifically, 'refs/heads/origin') used
to be what we used to keep track of 'master' of the upstream, which
we use 'refs/remotes/origin/master' these days.

	Side note: DWIMming origin to remotes/origin/HEAD to
	remotes/origin/master was invented to keep supporting this
	"'origin' keeps track of the default upstream" convention
	when we transitioned from the old world order to
	separate-remote layout.

And the reason why 'origin' should not be replaced with 'master' is
because your 'master' may already have patches from the topic you
are working on, i.e. in your current branch, that the upstream does
not yet have.  Running "git format-patch origin/master" will show
what needs to be accepted by the upstream from you to reproduce your
work in full; if you run "git format-patch master", it may miss some
parts that you already have in your local 'master' but not yet in
the upstream.

I never talked about conflicts, and I still think that it is
completely outside the scope of these examples.  Avoidance of
conflicts with the work that is already commited to your upstream
since you forked is the job for "rebase", not "format-patch".  The
reason why it is wrong to replace 'origin' in that text with 'master'
does not have anything to do with conflict avoidance.

Puzzled...
