From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 17:04:21 -0700
Message-ID: <7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 02:04:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmC4a-0008Ue-KN
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 02:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab3FKAEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 20:04:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36217 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab3FKAEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 20:04:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 434DB272FE;
	Tue, 11 Jun 2013 00:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wtb8BpakErtWNf4sKjkrMlYxU4I=; b=uGBpS3
	JH+wWwKfQaUJHcCwWHRm4qx99fkr3y/X09UXGB5dNdJckQqLuNJ5fyudc4Y+aJZN
	mO9V2IzbfRb47fMtewHGhz5wZGQ8GwnL1AUj26/JBQTKdjuuYpKuEK6K9esl6rjS
	U61DjwCxrkBDRr/tJcCxlaivnLZidlTngtEXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Id6HCqtt/g8Fg1wR7wno9wB66IqDyVUS
	yn3ePLG4BC4KkNHdjC3Xod2L0Mj+AOhYkZTnBebvXC2QbMs9U2L37+PeEfj8ZcDV
	0/3HqMVVEeh+G+0YinDrv31gn3cGa9I/ZGti/CMQyvXRN5l9lTepeAwCjr7fNqLg
	rSqX1ILkcR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A6D272FC;
	Tue, 11 Jun 2013 00:04:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7875D272FB;
	Tue, 11 Jun 2013 00:04:22 +0000 (UTC)
In-Reply-To: <CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 10 Jun 2013 18:51:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78753E8E-D22A-11E2-A3A6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227406>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> *1* ... which is a very reasonable thing to do.  But moving
>>     sequencer.o to builtin/sequencer.o is *not* the way to do this.
>
> By now we all know what is the *CURRENT* way to do this; in other
> words, the status quo, which is BTW all messed up, because builtin/*.o
> objects depend on each other already.

builtin/*.o are allowed to depend on each other.  They are by
definition builtins, meant to be linked into a single binary.

> We are discussing the way it *SHOULD* be. Why aren't you leaning on that?

And I do not see the reason why builtin/*.o should not depend on
each other.  It is not messed up at all.  They are meant to be
linked into a single binary---that is what being "built-in" is.

A good way forward, the way it *SHOULD* be, is to slim the builtin/*.o
by moving parts that do not have to be in the single "git" binary
but are also usable in standalone binaries out of them.

And that is what I just suggested.
