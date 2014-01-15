From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: check-ref-format and rev-parse can not handle branches with an @ in their name combined with @{u}
Date: Tue, 14 Jan 2014 23:46:58 -0800
Message-ID: <7v1u091ybx.fsf@alter.siamese.dyndns.org>
References: <52D5C296.7050906@lge.com>
	<xmqqvbxm2kmg.fsf@gitster.dls.corp.google.com>
	<20140115050003.GA27237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 08:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3LBT-00076e-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 08:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbaAOHqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 02:46:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbaAOHqi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 02:46:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C90475DE1A;
	Wed, 15 Jan 2014 02:46:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kLEFELbYw+hFx9erW8pBkmaMU3A=; b=R8QMmt
	AaYBXNifxIHDTjRj1uc0pw+yalv/QK6qDpCTNFyZMl0vr+wSRdTi8EKzbH5IW0UC
	HtJQwaQqI+yKVo0OHJemiO9o5XijpZLXB7oEIzy5//ysWf9jKhPRxrz9SoR7HydE
	NRh99bQb8iGfzbjxhKRefu6+YepeoqnEvYwnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkIRFQBobuCWgbzNdfdqWiOGEkM8Mfsi
	296SdWUBB8BfOuQcUis/Ll0mieP5mzOHC2UXNNRY2ReKL7EqAKuG2JF/jC/DE9yd
	Cg5iAVPy4jax8/T8K5KqgtCxXEnfiobv8L9ZqadBfmA543uhoYOZD3oZQXFGX0th
	Bm7SlT/gcpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B572C5DE13;
	Wed, 15 Jan 2014 02:46:37 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAC195DE0C;
	Wed, 15 Jan 2014 02:46:36 -0500 (EST)
In-Reply-To: <20140115050003.GA27237@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2014 00:00:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 297C8D9C-7DB9-11E3-B6A9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240435>

Jeff King <peff@peff.net> writes:

> Is that what "--branch" does? I have never used it, but the manpage
> seems to suggest it is about _parsing_ (which, IMHO, means it probably
> should have been an option to rev-parse, but that is another issue
> altogether).

Ahh, of course you are right.  I never use it, and somehow thought
it was just prepending refs/heads/ to its arguments, but it seems to
want to do a lot more than that.
