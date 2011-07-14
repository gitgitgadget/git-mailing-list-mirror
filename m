From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 14:30:30 -0700
Message-ID: <7vaacg35zd.fsf@alter.siamese.dyndns.org>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <7vmxgg38xz.fsf@alter.siamese.dyndns.org>
 <20110714204122.GB28548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 23:30:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhTUW-0004j1-Nm
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 23:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab1GNVaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 17:30:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab1GNVac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 17:30:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0828A4FAB;
	Thu, 14 Jul 2011 17:30:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ZQYABBNkJfZ1t/q9QDZNu3In7A=; b=Z2oio1
	gI+TuNk4zBZ0UzsszMA6B3XKX1QDI9GUrss9r0EYzeDA8lsiVlK7qEHQcyurzliA
	G2gwW73hjQPFroXzpdyk4ooXxwBFHjGFVymeR1Ztxe5I1nIsml/tghxDSKsTBC2S
	u4iB34aet4x6xNZb91XKmYN3ITLsyqmsDXduQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ziyg1bRwlP+8BEP6mSqClEANIoyPYIiy
	u5s/ndvzJ41B4ZlDSbLwQLaGZD2KviKGLGQ7zWUQKiwitl9VfKmzBlseXB5eEd/5
	S28B5NXWTjWaCXgHEDTmjuLUIUACwIe+hLakC5AOHeylzbLtjjzN/Qgv1l0hrItJ
	AVt2mYt/hTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0036B4FAA;
	Thu, 14 Jul 2011 17:30:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E93C4FA8; Thu, 14 Jul 2011
 17:30:31 -0400 (EDT)
In-Reply-To: <20110714204122.GB28548@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Jul 2011 16:41:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8064B8B2-AE60-11E0-B237-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177180>

Jeff King <peff@peff.net> writes:

> It should actually work in that scenario, at least with replace refs,...
> regenerate it. Another run ...

I know; that is what I called "doubt it would really work". Having to
regenerate twice does not count as working.

> However, there are two issues:
>
>   1. I don't think grafts have a "respect grafts" flag in the same way;
>      I haven't looked at how the packing code decides not to respect
>      them, but the "stir graft info into the checksum" data should use
>      the same check.

I do not think graft and object transfer meshes well at all, so I wouldn't
worry about it.
