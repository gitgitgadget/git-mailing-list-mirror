From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] replace: add --graft option
Date: Mon, 19 May 2014 11:34:54 -0700
Message-ID: <xmqqoayt1usx.fsf@gitster.dls.corp.google.com>
References: <20140518182939.5260.91202.chriscool@tuxfamily.org>
	<5379D1EF.8040203@alum.mit.edu>
	<20140519111940.GB17492@sigill.intra.peff.net>
	<xmqqvbt11y15.fsf@gitster.dls.corp.google.com>
	<20140519173505.GA28673@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 20:35:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmSOy-0003RU-04
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 20:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbaESSfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 14:35:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58648 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803AbaESSe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 14:34:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D491C15D16;
	Mon, 19 May 2014 14:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3X3cB12NqNqvTUiN7LaUYwCGY+M=; b=GhAz0i
	lEhTRvUfLDYood0/Yq7gUVRizclVOxrEnfX3Q/17Z/E0/+l/k5aJEM0OlSYhrfLx
	qhbGhS2tMkVCf7FaBc+5j02rTRp+VZAy942xgEFR6bh1fYZQaBHrggS+RAAYEsXb
	AO1c9Gg5bZoGKbkWEQ93DXTeee4rwb6HLnU5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZVzDNXIp1QT2geFhktGmevQZ0iiI2NbJ
	YMS4ef1CQks7fXHKYGCLmoTO71kGEw/Au30HmtQEmDYBbndz1sNup+YbGXVJn8QA
	L5rcFLnVs6mDDUiHXgJnbCuELPF3l+spgrbI06MqrR+BQBTZQVrA3KiUxgnjaQ6D
	xNYBawAbaho=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C771015D15;
	Mon, 19 May 2014 14:34:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BA10615D0E;
	Mon, 19 May 2014 14:34:55 -0400 (EDT)
In-Reply-To: <20140519173505.GA28673@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 19 May 2014 13:35:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46346388-DF84-11E3-B36E-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249610>

Jeff King <peff@peff.net> writes:

> On Mon, May 19, 2014 at 10:25:10AM -0700, Junio C Hamano wrote:
>
>> The headers up to committer are cast in stone in their ordering, and
>> I do not immediately see how loosening it would be beneficial.
>> 
>> Unless you are trying to give users a new way to record exactly the
>> same commit in twenty-four (or more) ways with their own object
>> names, that is ;-)
>
> Sorry, I didn't mean to imply that people can do what they want with
> that ordering. Implementations that reorder the headers are stupid and
> wrong, and should be fixed.

Yeah, that was the only thing I meant to say, and what you said in
the rest of message makes sense to me.  I very much like the
approach to parse line-by-line, noticing products from stupid and
wrong implementations and warning or erroring out against them,
while allowing an option to be lenient to help users who want to fix
their repositories contaminated with such objects.
