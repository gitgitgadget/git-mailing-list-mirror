From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git issues with submodules
Date: Mon, 25 Nov 2013 13:01:45 -0800
Message-ID: <xmqq1u24xkjq.fsf@gitster.dls.corp.google.com>
References: <20131122151120.GA32361@sigill.intra.peff.net>
	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
	<CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>
	<20131122220953.GI4212@google.com> <52910BC4.1030800@web.de>
	<20131124005256.GA3500@sandbox-ub> <52922962.3090407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 25 22:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3I2-0003uv-JB
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab3KYVBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 16:01:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459Ab3KYVBt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 16:01:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11CB153BEA;
	Mon, 25 Nov 2013 16:01:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uBRReQhm/skqMpMlPxYv2a1a08c=; b=bzyZCQ
	9BxVNJYzas1+d3k32nKA82tmUqZoVET4jGfNMmmSCOTpPQpVazIf7qftSiC8sVA6
	L3SAgUhL7DnUi6fx0QkgAbjtDa0JGTQhZWC1OIOVyOiz4Ej6dwFNFGNwX1mulMlO
	tpQOCnbR+r0X6rO8LVRjRip8LLXTd7AGidoxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aKhZp3qDVsWrrB2PZixgBAA3POQ149z3
	QT9BZApcBwDubquYfrSjSqPrbu0x1eBEC2bCi+2sJ/MNoEDsdq2STkTuJTUdPhtW
	sk/dLpI62Vx6DPZeMYEuY7demaB4ILy7JiG8HzzjD+f469640zwjr+Xsrp0t6mP+
	qrXjnNhHims=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9BAE53BE9;
	Mon, 25 Nov 2013 16:01:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E25B53BE8;
	Mon, 25 Nov 2013 16:01:48 -0500 (EST)
In-Reply-To: <52922962.3090407@web.de> (Jens Lehmann's message of "Sun, 24 Nov
	2013 17:29:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC914A6C-5614-11E3-B479-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238355>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Looking good to me. Please add tests for "diff.ignoreSubmodules"
> and "submodule.<name>.ignore", the latter both in .gitmodules and
> .git/config. While doing some testing for this thread I found an
> inconsistency in git show which currently honors the submodule
> specific option only from .git/config and ignores it in the
> .gitmodules file ...

Sorry, but isn't that what should happen?  .git/config is the
ultimate source of the truth, and .gitmodules is a hint to prime
that when the user does "git submodule init", no?

> I'd suggest to also add the --ignore-submodules option in another
> patch on top, because the user should be able to override the
> configuration either way. And what about having the '-f' option
> imply '--ignore-submodules=none'?

Yeah, this sudden change of semantics, which I think is going in the
right direction in the longer run, does look like it may be robbing
from those from the "want specific revision, but not want to see the
cruft in the top-level" camp to pay those in the "floating" school.
At least, with "add -f", it allows people to add such ignored ones,
just like you can "git add -f cruft" when cruft is not tracked and
marked as ignored in the .gitignore mechansim.
