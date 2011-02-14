From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 15:45:17 -0800
Message-ID: <7vfwrqqiya.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net>
 <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
 <vpqr5bath2z.fsf@bauges.imag.fr>
 <20110214223557.GA13070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 00:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp874-0001WA-RQ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab1BNXpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 18:45:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab1BNXpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 18:45:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C65F42A2;
	Mon, 14 Feb 2011 18:46:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGeCeHre9OTA5ZxWH5hJmKvgxts=; b=dUnig5
	GjRoD/VwPl0z9FfwGIdyIVIHmf1FtArYtCrdXA++azvJ+5x7egDxX3qkDsm37T4V
	4j5AaZXuaW9Rvwjs22e3F2KTAjd84aH4507dCxUUjB9rX7R4jRaxAgUqAHh+VbFA
	IKQaVxU5xSojhlDP2Y2TCebPI7pY/9eHXxF3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o82F7YTLPKpA7O0G8m51Tz9AwKZy5FUz
	XRKRHv4PI93BmQXHycp8mp9ALMKxom38MT2HFsMR8qQN+xLn4fN0ajcsofp5tXbw
	flKwK+PHCmmeho0nLC5COpIjQgE5AFLWbzili5db1DGtwlGwZfQyKeSrdIh5rVxa
	iiAhGsywqbA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B91544292;
	Mon, 14 Feb 2011 18:46:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA2294286; Mon, 14 Feb 2011
 18:46:22 -0500 (EST)
In-Reply-To: <20110214223557.GA13070@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 14 Feb 2011 17\:35\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A942AF06-3894-11E0-B999-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166797>

Jeff King <peff@peff.net> writes:

> I like this one, too. It lays out what is happening and what the
> possible choices are....

Heh, I see others sorted this out while I was looking the other way ;-)
Care to roll an appliable patch?
