From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Tue, 02 Jul 2013 13:00:01 -0700
Message-ID: <7v38rwlola.fsf@alter.siamese.dyndns.org>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ed Hutchins <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 22:00:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu6kG-0002l6-LO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 22:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab3GBUAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 16:00:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231Ab3GBUAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 16:00:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0D2D2B19E;
	Tue,  2 Jul 2013 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jQkbAvxAlment5851rPy1EORSqM=; b=DeLrD/
	xXYabpHX6R7ESMT7WA3Ta7oLiZ7cmy0luAOHp9KyoRgwoeBuroOvv79QKj1dny18
	xp7sib/xWtaXn+j0VaqpUbKdv9ZKxfB5SU3ZL9NSBr8kcn9bjYWcTq/13Tl+863X
	i1dxNUVXAT3Yk2Hz8CqPVE/ceyjXduDVBUpn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F4WNssHq0E2i+i0trDt79nk3qsN1SlHL
	nWnN8DZ/EdsuUqaSygvY92viHINZzw1QHAi0LbEQ1Bj9PQPLnxEVwuLN5lH/lkVT
	o7y9A8jbjS2wIXidIh6jqldBbqC7akAlCVXByCzmAo5z0a8AVjhIbmamBNvAw00i
	d27rxIa0wpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E9972B198;
	Tue,  2 Jul 2013 20:00:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1CB62B18F;
	Tue,  2 Jul 2013 20:00:02 +0000 (UTC)
In-Reply-To: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	(Ed Hutchins's message of "Tue, 2 Jul 2013 12:37:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBAB6836-E351-11E2-A44A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229424>

Ed Hutchins <eh@demeterr.com> writes:

> I realize that branch names are ephemeral repo-specific things, but it
> would be really useful to be able to determine what branch a commit
> was authored from (as a hint to ancestry graph layout tools, for
> example).

Hmm.  I think the current thinking so far is that it is harmful to
engrave that information in the commit object, exactly for the
reason you stated upfront: these names are local in the repository
the commit was created, and do not have any global meaning.

> Is there any way to do this currently, is it planned, or
> would it be deemed useful enough to be worth adding to each commit
> object?

No, no, and no, not because it is not just useful enough but it may
be actively harmful.
