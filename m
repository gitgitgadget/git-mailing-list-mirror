From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diffcore-pickaxe: respect --no-textconv
Date: Thu, 04 Apr 2013 11:10:15 -0700
Message-ID: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
References: <vpqd2uay9rq.fsf@grenoble-inp.fr>
 <20130404160359.GA25232@ruderich.org>
 <7vvc82i40a.fsf@alter.siamese.dyndns.org>
 <20130404175150.GA15630@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Ruderich <simon@ruderich.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:10:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNocc-0007Hp-2g
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764327Ab3DDSKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:10:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764326Ab3DDSKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:10:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A657813002;
	Thu,  4 Apr 2013 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rPYyPFKdnPU9uR4VYaBgsFeSRws=; b=K2F5X9
	pMPijFb4LEBnKZ9XwPzTjhoHocxIVQPKzMEM2Qew5Gkn339BUkKH3+LIx2p0bbnX
	BHnPHsD3yyzNRxKmZNgarIVch9cINBfxeqq+zALQzxWk/fO/f+sq2rQ16prM4/4w
	MLCjPnpPcgBhbzQITrfQZ799RoHYECo637rSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EwAxkyvDRUsGVPBdd+hdeiV19WJeqozB
	Th+LA8AetNxYxVirnnsvE4P8ScB/AvDeG+Jo/PIy6smiKzDk7lecw8ADYqzNFB6+
	EkZCDW+tFSRuYz62xwXK2iz7lqZltRo0U2kFHUuAC6dn5h5YGNBgfCJoA9D7ipTX
	tsiD27v7QGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C76413001;
	Thu,  4 Apr 2013 18:10:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01B0913FFB; Thu,  4 Apr
 2013 18:10:16 +0000 (UTC)
In-Reply-To: <20130404175150.GA15630@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 13:51:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E76E3186-9D52-11E2-8103-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220043>

Jeff King <peff@peff.net> writes:

> I'm OK with this as-is, but I would also be happy to see the re-ordering
> and extra cleanup I mentioned elsewhere.

Yeah, I agree that the order is the other way around.  2/2 could be
retitled to say that fill_one() no longer needs to touch, but swapping
the order with the extra clean-up would be much cleaner.

>
> But either way:
>
>   Acked-by: Jeff King <peff@peff.net>
>
> -Peff
