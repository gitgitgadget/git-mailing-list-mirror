From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Thu, 20 Feb 2014 10:22:19 -0800
Message-ID: <xmqq61o97ig4.fsf@gitster.dls.corp.google.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
	<20140215085355.GA15461@lanh>
	<xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
	<20140218193520.GB1048@serenity.lan>
	<xmqqtxbwdwt2.fsf@gitster.dls.corp.google.com>
	<530581D5.4040507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 20 19:23:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGYHA-0005mY-0e
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 19:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbaBTSXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 13:23:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbaBTSXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 13:23:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 901BE6D069;
	Thu, 20 Feb 2014 13:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bxDV8grBti58AF1DcWIPPIWbRJs=; b=LiAUnJ
	Q1zd2U7j/gSiDvNbL2Qcf/s94IpsnCGxQwmiHl9Z820Jrj24uB5PPNXB41HFVhwu
	wwPkY1X8LLoK+qoka0+bKJKfWWAbFup9UwPn+pXNtE8TSZYbT6d875g4HOTQwx/0
	bUfhppu4h8TsyfDvguVqRVCkYTO2liDcAv51E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xrX49oRk/ws2pczggEQADJJZmIDByCBB
	5mAsmDfCmGEYVKa3VVQ8uUv1jg3XtuGKsYNxXbw28bVc/mZDvrBYweg2DkIDKFY3
	j9nkYV5kCR3eCbBpQiiPdr7muk3bz8dk3PZAvnrAkjkIW/KwYDMOj1RwdlG5eH9r
	BUSq56CuMjI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14A506D033;
	Thu, 20 Feb 2014 13:22:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB5486D002;
	Thu, 20 Feb 2014 13:22:27 -0500 (EST)
In-Reply-To: <530581D5.4040507@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 20 Feb 2014 05:17:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F4057ED4-9A5B-11E3-A319-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242438>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I wonder whether we could give a way to specify a reference in an
> unambiguous, canonical fashion like I expected, for example by using a
> leading slash: "/refs/heads/mybranch".  This could be a way for the user
> to ask for DWIMming to be turned off without having to resort to
> plumbing commands like update-ref.  This wouldn't necessarily solve the
> problem, but it would at least lead the new user to type
>
>     git branch /refs/heads/mybranch
>
> instead of the ambiguous command above, which Git could either accept or
> reject in good conscience rather than having to speculate about what the
> user *really* meant.  I think that supporting absolute reference names
> like this would also be useful for scripts, which otherwise probably
> often have subtle failure modes if the user has defined reference names
> that are ambiguous, modulo DWIM, with the reference that the script
> intended.

I do agree that things start to become confusing to the end users
when we tell refnames and object names apart and behave differently,
e.g. "git checkout master" vs "git checkout master^0" (this example
uses a disambiguation syntax that is related to but different from
what you brought up).

For the <name> in "git branch <name> [<commit>]" (but not <commit>),
I do not see much value in allowing the users to say "refs/heads/"
in the first place---all the local branch refs are to be created in
refs/heads/ anyway and "git branch /refs/tags/bar" (if we were to
allow your notation to name an absolute ref) will have to be checked
and signaled as an error.

Even though there is no reason to forbid a ref to be named in such a
way at the lowest machinery level (read: at the sha1_name.c layer)
[*1*], I would say it would be better to at least warn users when
they create such a ref with Porcelain commands like "branch",
"checkout -b", etc., or even outright forbid.

In other contexts, however, it _might_ make sense, but I am somewhat
skeptical.  For example, if you have a branch 'foo' (whose ref being
refs/heads/foo) and a branch 'refs/heads/foo' (whose ref being
refs/heads/refs/heads/foo) at the same time, you need some way to
clarify that you mean the former, and one way to do so may be

	git branch newfoo /refs/heads/foo

and removing the latter would be

	git branch -D /refs/heads/refs/heads/foo

perhaps.  But this starts to sound like a workaround to a problem
that the user ended up having such a strangely named branch in the
first place, not a useful feature.

[Footnote]

*1* The way refs are used and the specific meanings given to some of
    the hierarchies under refs/ by the core-git Porcelain is not
    fundamental to the data model of Git.  Git the SCM by convention
    uses refs/heads/ for branches, and it is perfectly fine for Git
    the SCM to enforce its own policy like that to its end users and
    forbid creating and using any ref outside that hierarchy as a
    local branch (e.g. checking it out), but I'd prefer it if we can
    keep the lower level "a general filesystem to build SCM on top"
    layer as separate from such policy decision as possible.
