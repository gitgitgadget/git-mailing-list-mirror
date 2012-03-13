From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Tue, 13 Mar 2012 06:17:13 -0700
Message-ID: <7vehswljxi.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <vpqy5r44zg7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 13 14:17:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7RbN-00033o-1f
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab2CMNRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:17:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab2CMNRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:17:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6164B8A;
	Tue, 13 Mar 2012 09:17:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vuIMtxmqmK8CRDl0BYHGD3lo4M8=; b=wE2tZE
	hTlZgc5pQQL7VFqCqGxfgq9lGiXVQYISZ0CmLB7nb8jfHlp7mWV1w2SdfCptAh+u
	iO7O2cEof3bERMcKwXT0pDt3LxyWvyb5rog7i/zFZD1VPDREwnoFkxftcL2fQhHs
	wzZW/EJbZdI0EK1Tgd2vnBem3u8RDK8nuE7EE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fmbKxQv/nq2JKbKy2lXWJCZgdYhWSQX4
	rSR9+T8Dsj4LZl8V0S6EgpkhXItii2CqFRwJVCQ3yvrLz2moTtAKPEr324VF059+
	sFdouUXCgIUk1qzFcAj6Weuw+3ikeujN5WZ4wUyCRzrXP21NRMszgYkzKoClKiHA
	2vDceSVOgxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24EF64B89;
	Tue, 13 Mar 2012 09:17:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96DC04B85; Tue, 13 Mar 2012
 09:17:14 -0400 (EDT)
In-Reply-To: <vpqy5r44zg7.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 13 Mar 2012 10:34:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9A5D65A-6D0E-11E1-8555-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193023>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> There's a rule of thumb which works very well for beginners: when "git
> push" tells you to pull before, then pull before. This rule of thumb
> works, but only provided "push" and "pull" are symmetrical.

I actually think the "pull before push again" was written with only
CVS style non-branching workflow in mind, in other words, only to
help somebody who works on his master against the central master.
Obviously "push and pull are symmetrical" holds true for that single
branch workflow, but that does not mean a more complex workflow must
be symmetrical.

Even though I think 'upstream' will be a superset of what 'current'
wants to do in an ideal world where the user configures everything
right (hence it ought to be the better default between the two), I
do not think that the target audience "let's change the default"
folks are trying to help is those who set @{upstream} correctly
point the destination for a branch they want to push to and leave it
unset for a strictly private branch. If we choose the default that
would primarily make it efficient for people who can configure
everything right, we are missing the point of this discussion. I
think the target audience to be helped is the people who do not
(yet) do anything complex, and the point of this discussion is to
help them avoid getting surprised.

And by "surprised", I do not necessarily mean "dangerous". While we
should aim to avoid "dangerous", we should avoid "ununderstandable"
even more.

Pushing 'current' from a branch 'topic' forked from either 'master'
or 'origin/master' will create a new branch 'topic' at the central
repository. But that is straightforward and understandable. The user
will see what happened in the feedback from the command, and there
is no need for the user to be experienced enough to know the mapping
of @{upstream} to understand why it happened.  "I am on 'topic' and
I pushed, I created 'topic' there".  Very simple explanation exists.

On the other hand, the user needs to know not just 'branch' but also
understand the concept of @{upstream} in order to use 'upstream'
without surprise.  When something goes wrong, prerequisite knowledge
that is required to understand it is greater.  Also the current
implementation of 'upstream' has some weird semantics (or undesigned
bugs) pointed out by Peff, which would make it even more confusing.

That makes me suspect that 'current' might be a more appropriate
default between the two. From that simple default, those in the
"shared central repository" world can graduate to 'upstream' once
they know what an 'upstream' is and how to take advantage of
per-branch configuration.  Similarly, those in the "publish to be
pulled" world would graduate to 'matching'.
