From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1300: document some aesthetic failures of the config
 editor
Date: Fri, 29 Mar 2013 13:00:31 -0700
Message-ID: <7vd2uinfhc.fsf@alter.siamese.dyndns.org>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
 <20130329172307.GA11099@sigill.intra.peff.net>
 <20130329175058.GA13506@sigill.intra.peff.net>
 <7vobe2nins.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Phil Haack <haacked@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 21:01:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULfU1-0005Tq-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 21:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab3C2UAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 16:00:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552Ab3C2UAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 16:00:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B77ADFAB7;
	Fri, 29 Mar 2013 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2LmtcnGIYcDLMoL/1qHb8NIO6JU=; b=VVq38t
	VxyBqJ/7NCcUs44oeU16ZcBXGkAESztRp75T7W0Revbu19BF8ByOKguexYQd1RvO
	R6J+9mOU2RBB23E0BngvCuD6Kd80yvUgbbcQH4cDVCn6PxByBmXpJW3/3ihYOW5h
	fPoBCxhTlYgV9o60YB78DlEYzHBbXFvVhVv6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i0xJYVre/SZcTQP7sFbcWIXfQBhc5MUX
	DdrxWeLBnQhR90ZP1eAtkvkZtZhkutUym0/QWEpjnB3jH4GPts1vsf6PDFhFh0Hk
	KoLao+EgbL7ZPyhu2BAgElxeuVaEpE0sVMkqzBJDBm43EKiFGMPD4FnzNdVI4+FI
	jdausUD+uGo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB026FAB6;
	Fri, 29 Mar 2013 20:00:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14D7FFAB3; Fri, 29 Mar 2013
 20:00:32 +0000 (UTC)
In-Reply-To: <7vobe2nins.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Mar 2013 11:51:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50713130-98AB-11E2-AA2A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219525>

Junio C Hamano <gitster@pobox.com> writes:

> ...  If we _were_ to remove the section header at this point,
> we should be removing the comment two out of three cases (if it is
> about section.key, it should go when section.key goes; if it is
> about section, it should go when section goes; if it is a more
> generic comment about this configuration file, it should stay).

The last case should end more like this:

	..., it should stay, but why are you writing a comment that
	is not specific to this section _inside_ the section in the
	first place???

Another case we have to worry about, if we were to remove an empty
section header is this case:

	# Now, let's list all the remotes I interact with.

        # This is where I push all the separate topics.
        [remote "github"]
		# fetch like everybody else without auth
		url = git://github.com/user/git
		# push with auth
                pushURL = github.com:user/git
		# publish the state of my primary working area as-is
                mirror

	# Traditional "canonical" one
	[remote "korg"]
        	url = k.org:/pub/scm/user/git

If I were to retire "github" account, removing the section while
keeping the comments would be confusing (I do not push all the
separate topics to korg).  Removing the section while removing the
comments that pertain to the section is impossible; "Now, let's list
all the remotes" should stay, "This is where I push" should go.

Removing only the keys and keeping the skelton around would give us:

	# Now, let's list all the remotes I interact with.

        # This is where I push all the separate topics.
        [remote "github"]
		# fetch like everybody else without auth
		# push with auth
		# publish the state of my primary working area as-is

	# Traditional "canonical" one
	[remote "korg"]
        	url = k.org:/pub/scm/user/git

which is still confusing, but at least the confusion is not spread
to adjacent sections.
