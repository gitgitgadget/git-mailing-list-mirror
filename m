From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Clarify documentation on the "ours" merge strategy.
Date: Wed, 11 Nov 2009 23:55:09 -0800
Message-ID: <7vvdhggote.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
 <7vskckn5b4.fsf@alter.siamese.dyndns.org> <20091111213049.GJ27518@vidovic>
 <200911120037.11901.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 12 08:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8UWk-0005MF-M5
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 08:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbZKLHzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 02:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbZKLHzX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 02:55:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZKLHzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 02:55:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC1E19B80C;
	Thu, 12 Nov 2009 02:55:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wg0UJp96W25/edRTSUM3HBLOhYQ=; b=pa61ot
	/kYd4WYRA+fIuy0xN+VWRVOkRm6iNZJYVugZmFqdz32r0tNitz7/jdowcFcBdMl0
	c6iOrixqkjbv1L4MAPqGM4VFufNXGbWTshPt4eClSrJXFK4Q3qifY9UDPivSywc6
	MXBe+0Tp3m6Mb2Y8Gk8tpp2G66LyaNyddiFiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oTAllN/nQd1aDuYQIIJZE5mxcPZV1ks4
	c2kJ94/CG8+P+iKJRfVnigIpinxuyWOOn0epjB0JmK7ArJ+yZauclZa15zvGaY3v
	pkVPMMRTHG8c6LskW+lIrAPWS5Tkay5e1Mln+GbBuCROA4A0L/lY3NWLpPVSE6bk
	TfV4XvEbZ9A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 615DA9B80A;
	Thu, 12 Nov 2009 02:55:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6D369B809; Thu, 12 Nov 2009
 02:55:10 -0500 (EST)
In-Reply-To: <200911120037.11901.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu\, 12 Nov 2009 00\:37\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B97CAE88-CF60-11DE-9F1D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132742>

Thomas Rast <trast@student.ethz.ch> writes:

> Then again, I'm not sure if resolve vs. recursive makes a difference
> in a rebase.  Octopus is weird for a two-head merge, I'm not sure why

 ...

> +	If there is no `-s` option 'git-merge-recursive' is used
> +	instead.  This implies --merge.
> ++
> +Due to the peculiarities of 'git-rebase' (see \--merge above) the only
> +built-in strategy that is actually useful is 'subtree'.

"recursive is just a slower and sometimes buggier alternative to resolve
but can handle renames" may mean "people do not have much reason to choose
resolve over recursive".  But that is quite different from "resolve is not
useful here _due to_ the peculiarities of rebase".  Wouldn't anybody who
thinks "resolve vs. recursive would not make a difference in a rebase"
also think "resolve vs. recursive would not make a difference anywhere"?

58634db (rebase: Allow merge strategies to be used when rebasing,
2006-06-21) added "-m" and "-s" to rebase to solve the problem of rebasing
against an upstream that has moved files.  What the commit actually did
was to use recursive (by default) while giving longer rope to the users by
choosing other strategies with "-s", without making any judgement as to
why other strategies may possibly be useful.

Perhaps there is some different issue at the root of this one.  Why would
anybody be tempted to say "-s ours" while running a rebase?  What did the
user want to see it do (instead of being a no-op because "ours" by
definition ignores the tree the change is replayed from)?

It is easy to dismiss it as a user misconception and it also is tempting
to think that it would be helped with updated description of "ours" to
dispel that misconception, but there may be some user wish that is totally
different from "ours merge" strategy but still can be validly labelled
using a word "ours" by somebody who does not know the way the word "ours"
is used in the git land, and satisfying that unknown user wish might be
the real solution to this issue.
