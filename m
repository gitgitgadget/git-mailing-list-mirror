From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 14:47:01 -0700
Message-ID: <xmqq4n1iv1re.fsf@gitster.dls.corp.google.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
	<xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
	<87tx9ia5zq.fsf@fencepost.gnu.org>
	<xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
	<20140424213529.GB7815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, d9ba@mailtor.net, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 23:47:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRUl-0000so-P5
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 23:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbaDXVrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 17:47:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbaDXVrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 17:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 423488012E;
	Thu, 24 Apr 2014 17:47:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NB0cJZ6jrVqQdYdhdqOnkjI9HTg=; b=tJ2Yd0
	93dgqHoV6w3sGE0CXjsHzomHKnWERKrnxiiIXAuRZTnon3J92QBBYmLyeDMrkL8R
	kgK+QF/tnnxzlTW79wOTWd/lCNH1KiR3DELiqYD7Rb2zfK/Ln3f525JrnJhKatXm
	G4a/kpr83Z0gjfefNP7ahxPmCcYqIk/SWVrBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mMhBLPWhEv9C/sCA86ZwF/ttRAzDltR3
	evgnukHcbJLHsxPXP5slci+ps75zUh4BR6AzWIqjbgncyHTpNIZmhrUKfmqd2R2f
	3CSdgtVc+D2tyZTowFi5uRD2zfcn4iDetXGVAa9hM5V1u0N1VlAAa4CT6sGl0aMO
	7QOOqkCKE1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 258B88012D;
	Thu, 24 Apr 2014 17:47:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D65C88012B;
	Thu, 24 Apr 2014 17:47:02 -0400 (EDT)
In-Reply-To: <20140424213529.GB7815@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Apr 2014 17:35:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F89983DA-CBF9-11E3-9551-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247012>

Jeff King <peff@peff.net> writes:

> I would think it's the opposite. Long lines look _horrible_ without
> "-S", as they get wrapped at awkward points. Using "-S" means that long
> lines don't bug you, unless you really want to scroll over and see the
> content.
>
> I really think the right solution here is to teach less to make it more
> obvious that there is something worth scrolling over to. Here's a very
> rough patch for less, if you want to see what I'm thinking of.

Yes, I think that was suggested as an issue worth bringing up with
less maintainers earlier in the thread already (and that was why I
didn't repeat it).  If we were in the business of updating less to
suit many users' needs (the needs of our users included), we may
even want to advocate turning R on by default.

And I do agree that the "chopped marker" would be a very sensible
thing to show in the "-S" output; I would have chosen "$" myself for
that to match an existing practice in (setq truncate-lines t) in
Emacs, though.
