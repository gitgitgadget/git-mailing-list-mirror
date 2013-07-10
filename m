From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for status_printf
Date: Tue, 09 Jul 2013 23:17:05 -0700
Message-ID: <7va9lvszvi.fsf@alter.siamese.dyndns.org>
References: <20130710001659.GA11643@sigill.intra.peff.net>
	<20130710002328.GC19423@sigill.intra.peff.net>
	<7vmwpvt28j.fsf@alter.siamese.dyndns.org>
	<20130710052859.GA5339@sigill.intra.peff.net>
	<7vip0jt1sy.fsf@alter.siamese.dyndns.org>
	<20130710054050.GA7206@sigill.intra.peff.net>
	<7vehb7t0zs.fsf@alter.siamese.dyndns.org>
	<20130710061115.GA11741@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 08:17:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwniE-0006IP-10
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 08:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab3GJGRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 02:17:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab3GJGRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 02:17:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E067287C8;
	Wed, 10 Jul 2013 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GC4q26+OuR2iCIKxAq9ZnxyeGIA=; b=EcisKM
	EsFrroLsSpR/bkhPTtRHN8yGVgA4vuxGs/kDp73OQQyKWSC1z5cl4PapdskkRKi7
	kgtXd28dcVwSmg1Sd0txFI2D5N7k5QZ/PXwli0bCgWjJKNgpKygT3bnCN+cLNSQz
	afCgyJjHoUD+PAtFNRppjk22rtdlXPSu640k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aNKqdUKeD8K11xrYmVAPvIwZ+Jcc2dvq
	9APncOVgMRNnZjNU7QIeEH2KAeP8SSu49uMC0Sr16UG9iPnb57gbTcjtM2BPKtkn
	tnWsGZqdXF1ZxrMfeGjIlr6wI4hUiwabq3Zh3pcDT81tcMXRGr6/jqSLiixKaOh6
	e46Ty2Uv5tE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32853287C7;
	Wed, 10 Jul 2013 06:17:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91D73287C3;
	Wed, 10 Jul 2013 06:17:06 +0000 (UTC)
In-Reply-To: <20130710061115.GA11741@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jul 2013 02:11:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 586D9C16-E928-11E2-B7E4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230029>

Jeff King <peff@peff.net> writes:

> If you want to keep refactoring this, I don't mind, but I kind of feel
> like we are going down a rabbit hole for very little gain.

Right, and right.  The rewrite to move _ln to "\n" was wrong, and
this is too much hassle for too little gain.  If we were to do
something, I agree that it would be the best to have dedicated
"empty-output" function.
