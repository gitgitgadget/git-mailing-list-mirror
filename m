From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Listing commits that are _exclusively_ available on a given
 branch
Date: Fri, 23 Mar 2012 10:38:32 -0700
Message-ID: <7vaa37usiv.fsf@alter.siamese.dyndns.org>
References: <CALKQrge-=XExhwxuC14uynpuuO3W+f4YO4=X7kFUx33F3HtnyQ@mail.gmail.com>
 <20120323170640.GA12881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8Rm-0004hZ-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab2CWRig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:38:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224Ab2CWRif (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:38:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F20616C2E;
	Fri, 23 Mar 2012 13:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EPmbvQHs4RF/9buYP8Jj159MCe0=; b=iF5baB
	/4KM67wuKiT5FZbyil1G1DZcJLo+a56tRh2BVvlGH/AVzFUoW6wZxk2oVhT8KweS
	4o1IIOWTVFMdS7mPoTHml4YTQ9Oyhzn4fn/y9Cu6qh2MNguhKQ42gmPr6tgngVsS
	rpMprvG4kLzaAiWkVBmxzqgBw/EUsDHu6nyKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgfW7QhA5YkZ0vPLsVyGM3eOHghpTjvR
	sa9WDsvPFpr4QRLkj+3fwZBNmViJmM76tDciGllwfakT3IG3A6sCTcMWgTUrpjZw
	hmtvRxTsgcZE8fgg+5SGoZbz/rjXj+oMKLFE+TXHTJ1jiDzrf7h6CZcDH0zCzEJD
	Wnxdit9ZMmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9A256C2D;
	Fri, 23 Mar 2012 13:38:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81C7C6C2B; Fri, 23 Mar 2012
 13:38:34 -0400 (EDT)
In-Reply-To: <20120323170640.GA12881@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 23 Mar 2012 13:06:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03BBD414-750F-11E1-B4D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193778>

Jeff King <peff@peff.net> writes:

> No, I think that is the only way to do it. The algorithm run by rev-list
> in that case should be optimal, so there is nothing to improve there.
> Syntactically, it's a little bit of a pain because there is no way to
> tell rev-list "--all, except for this one branch" short of using grep.
> We could add a new syntax for that, but I'm not sure what it would look
> like (or if it would be any easier on the eyes than what you have).

We discussed --exclude-refs="refs/tags/expermental-*" that would affect
how --all, --heads, and friends are processed several weeks ago, didn't
we?
