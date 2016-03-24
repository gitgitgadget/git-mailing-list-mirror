From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Wed, 23 Mar 2016 22:17:05 -0700
Message-ID: <xmqqh9fwbgku.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
	<1458775426-2215-1-git-send-email-gitster@pobox.com>
	<20160324005849.GA8167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 06:17:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aixdx-0000Bn-TF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 06:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbcCXFRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 01:17:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754198AbcCXFRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 01:17:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39E684393C;
	Thu, 24 Mar 2016 01:17:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kEm8YPSGNtRzstd/hdD3T7dcsu4=; b=KngxeW
	PSwgaw3bk3ttdSBj3Ro4CoZuzYQwToXBiGrOvlwTze3DUOJf86SXwwDTr5HHVGDJ
	A+HL3883NYliscawSzYCI0MYpLHn+Kuft8A6ItM/b954Tlvwl1vYKl4BHr1Ntnb0
	BvrUYVD2dHmtf9ZxA1764pO8ifO1Swbn68Jh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AF8kc/z0qM3Gw1yHzdMuTLVKwT76zhZ8
	K+LvTorFYupWjoDgpZjBqUgiPhLr5qxbo4iJcRLFk0jkZBXi79Gr4dDHb8kabawa
	HB+vwEMxU0opXRrdklSJ6zXma9/n+zuyONvtFXl6lYpB2JhDesK4H1mshtju9P31
	ue+yLiIsulA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31FAD4393B;
	Thu, 24 Mar 2016 01:17:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A23764393A;
	Thu, 24 Mar 2016 01:17:06 -0400 (EDT)
In-Reply-To: <20160324005849.GA8167@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 23 Mar 2016 20:58:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6D4C962-F17F-11E5-A51F-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289710>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 23, 2016 at 04:23:41PM -0700, Junio C Hamano wrote:
>
>> So here is the third try (previous round is found at $gmane/289166
>> and the very first one is at $gmane/288987).
>
> Is the plan to merge these as-is? The ordering is a bit funny (introduce
> breakage, then repair it), and I think the first patch still breaks
> t4201.8 (which is then repaired in the fourth one).

I do not have a firm plan yet.  This was one of those "during the
pre-release freeze, instead of reviewing shiny new toys by others
too early, spend leftover time to tie loose ends" attempts ;-)

I'd agree that the "final" version should do our usual "progressive
improvement, never stepping back one and then forward two", but I
wanted to see what the endgame state would look like first, and by
doing the incremental "the first one gets it 80% right, and fix it
up with follow-up patches" I didn't have to worry about at what
point I need to take the authorship of which patch.
