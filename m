From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Tue, 27 Aug 2013 15:32:20 -0700
Message-ID: <xmqqppsyahor.fsf@gitster.dls.corp.google.com>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
	<20130827205125.GA23783@sigill.intra.peff.net>
	<xmqqbo4ic0ap.fsf@gitster.dls.corp.google.com>
	<20130827214808.GA26350@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 28 00:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VERoK-00058b-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 00:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab3H0WcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 18:32:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141Ab3H0WcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 18:32:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E7503C263;
	Tue, 27 Aug 2013 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+T4o/ItdsYuc/KCZggN84m5/Xg=; b=saDmJi
	tFo023+uHmGA8jE7fLjT6ESFY4vz+xxsA8RhkeuOTxRf+NfRrpRS8Wh2RpDoY7uh
	nw5082YG1fcV69aygl/l54mmh6EaIvQg36gdNg/gbxsGxcsfzkcvjT33nvhfEHyT
	zLiGxVqT6I6hk2RY/P9M59zeLuptxUDJgSxy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f47c93QehRvKnKXbFk72++Kl+szO2Swo
	8H5fvCT++1KOiOZ4m1+G20Cd9c6UN/KOTwfxZs7AEaY8wWJxeJa1y8uFsS9bUP49
	wCWvF3uzP0G7tTzeeXvMAawHMOm3wH4hWK2x15mGteVUPD6xHzgiPeeg/gJdf+kq
	EoSobftaSak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4273D3C261;
	Tue, 27 Aug 2013 22:32:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C7683C25E;
	Tue, 27 Aug 2013 22:32:22 +0000 (UTC)
In-Reply-To: <20130827214808.GA26350@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 27 Aug 2013 17:48:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8A7F0FD0-0F68-11E3-B9AA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233167>

Jeff King <peff@peff.net> writes:

> I don't feel too strongly either way. I mostly kept the range checks for
> --int because that is how the code already worked, and I assumed that
> was what was desired. But given what I know of the history of the config
> code, it is probably a completely random side effect of how it is
> implemented. :)

;-)

> I can try to prepare a series going in that direction (we still need to
> fix the internal truncation that currently happens, though).

Yeah, allowing range checks to allow those who do set using "git
config" from the command line to protect themselves is in theory
a good idea, but in practice that means they need to know the
internal type (and they need to know to pass --int in the first
place), so it may be a losing proposition.

> I do not know if it is so serious a fix that you need to go back to
> v1.8.2 series, but I think it is definitely maint-worthy. I was worried
> initially that the second part of the patch would involve too much
> refactoring for maint, but it actually turned out pretty simple.
>
> I'll prepare a squashed version that I think should be suitable for
> maint.

Thanks.
