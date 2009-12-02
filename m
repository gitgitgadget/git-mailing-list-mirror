From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 02 Dec 2009 10:58:39 -0800
Message-ID: <7vy6lldwyo.fsf@alter.siamese.dyndns.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091201171908.GA15436@Knoppix> <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
 <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com>
 <7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0912021050r4fd96ed4rf863917a965a42fb@mail.gmail.com>
 <7v3a3tfbsx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:59:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuPk-0006b6-9X
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZLBS6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 13:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbZLBS6q
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:58:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbZLBS6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 13:58:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2752E8493A;
	Wed,  2 Dec 2009 13:58:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pzamhE9gcOF4C4xRVQi9+e4YUPE=; b=P9Hbub
	4zrXpvZPO44iJsS2hIZnnGiTV80qW6TlSvt+D2bbzU3jouaaHFho+0k1t5AJFB6Z
	MCTmuprWBy9q/zg741XSxBqrVXePnjQ8bc9ozUY5z8/exc8qTgizoxTF2sCowJG7
	GIoUyJ2hFUk5JjwXQoV1whnuHR/ufGPbCGBJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/LcwJww+o9BjV+4/87/j0MULAK3O6Fv
	A7IQpSAStJ7Azd4R8k/JsXjiCyip7MQFkLNaAe0HwIICYh6Ul+GzOmTfXJQ7Ka6K
	FtZvFWmOfukR8zAwqVdDU9bM4YA7+gw04f7awXnesRwxpi0X+ONZvd6O8JqKm5uU
	/VYjR+5NwKg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D96CF84939;
	Wed,  2 Dec 2009 13:58:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA4FC84938; Wed,  2 Dec
 2009 13:58:41 -0500 (EST)
In-Reply-To: <7v3a3tfbsx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 02 Dec 2009 10\:52\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8DFC716-DF74-11DE-B7C1-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134372>

Junio C Hamano <gitster@pobox.com> writes:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
>
>> I don't see how what you are talking about is any different. With the
>> mapping the executable of the alternative implementation still needs
>> to have a different name, no?
>
> Sure, but please search for "second class citizen" in my message.

Also "extra level of indication".

I do not think "remote-curl" was the best name, and hindsight tells me
that "remote-walker" might have been a better name (it tells us how it
does it more clearly).

And I do not at all mind making the current hard-coded mapping from
http:// to remote-walker to an external table look-up, perhaps something
that can be controlled by .git/config, with a built-in default that is
hard-coded like the way we have now.

After all my main objection is against closing the door to others by one
particular implementation squating on "remote-http" name and refusing the
use of that nice, authoritative-sounding name by others.
