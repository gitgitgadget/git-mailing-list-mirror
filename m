From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 14:50:33 -0700
Message-ID: <xmqqlhtwrufq.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
	<53795ef8e4023_10da88d30825@nysa.notmuch>
	<xmqqegzp1tl7.fsf@gitster.dls.corp.google.com>
	<537bbd6c1daf_a6f166b308b0@nysa.notmuch>
	<xmqqy4xwrw8o.fsf@gitster.dls.corp.google.com>
	<537bc8ea6ced9_1d08f2d2f8fd@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:50:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmrvn-0000KO-F2
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaETVuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:50:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55667 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbaETVui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:50:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10BAC18555;
	Tue, 20 May 2014 17:50:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9ZhIQfNv+UhVnFIMUcLGTh4l74=; b=evxU6C
	+7j+mUuwtt6KHCsDk41tNf3HpiAryERNqrH984ZsLIdW6ZU+HzVu185MPbqyXpzo
	xGjmol4ENghZEQLwOgrPZMzm05tGqEltIHS5QlvuXsH3jlfwipWa46GLLOvqggVk
	ynqNM2QdydWMLiG/+u5HZyE2GhLwdS/rhyRSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yA5+vKghdJJk/Y+1/C3593Aay9rzUMbE
	VAYhmw3Kh9FC1PVuJxYU0ElUTWydtaxH2T4bUjmk07DiN5+EO0HqLuz9FB/Fux8R
	QrZqGH0PIiVYPBnnNfmvYnjiwy25cy52gZMB/pn6UzMXagBhVkKJdXsf3k+C27Da
	kP5RDYHU40Y=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0796818554;
	Tue, 20 May 2014 17:50:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0E79F1854D;
	Tue, 20 May 2014 17:50:34 -0400 (EDT)
In-Reply-To: <537bc8ea6ced9_1d08f2d2f8fd@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 20 May 2014 16:28:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5C80B6A-E068-11E3-8F96-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249752>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> ...
>> > So to make it clear, I now request that you do:
>> >
>> >  1) Remove all the code.
>> ...
>> I'll do that, but just one thing to make sure---do you want the
>> helper to exit with status 0?
>
> It doesn't matter; if the remote helper doesn't respond to the commands
> transport-helper exits with 128.

You're right.

>> >  4) Re-add the following release note:
>> >
>> >     * "git push" via transport-helper interface (e.g. remote-hg) has
>> >       been updated to allow forced ref updates in a way similar to the
>> >       natively supported transports
>> 
>> I am not sure if this one is consistent with 1), as remote-hg will
>> no longer be with the release.
>
> Remove '(e.g. remote-hg)', the rest still applies.

True enough.

I was already deep in today's -rc4 tagging before this exchange, so
it may be a while until the result is pushed out, but as far as I
know the helpers are now stubs, and README no longer says "a random
version that will go stale is kept here merely for convenience".

As additional topics that touch contrib/remote-helpers/ need to be
reverted from 'next', the final pushout may take longer than usual.
We'll see.
