From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] Add new @ shortcut for HEAD
Date: Thu, 02 May 2013 09:49:48 -0700
Message-ID: <7vobct1g43.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-6-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_-S_BvQAa5b2+XpfM2-fJcEQ5EJa4RRtV1vQPEe1emA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 18:49:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwhf-0003oO-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 18:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760590Ab3EBQtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 12:49:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab3EBQtu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 12:49:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D20194D4;
	Thu,  2 May 2013 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eP59Xg0ApowxYZmyA6RwbCnoXSQ=; b=EY8PBb
	zRIdYHzT2t+/6+c4ev8Mxym3DgfxZnxOunZL6ZdnOd85ANKr1SvKzABo7K5WlrWe
	sQp01hO+3edSRpCCTP0EFZc52ITd9B1rmY9P1mHHg/gifNV923Unz0E7asTQmuba
	AsJSTcmJH0ZOr+I2CGOJcL+EkrOulrLR2s2+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NYVWNNBHZESYjc9muI4wESa9yIZremDh
	upVFweWO9GgnhSaVyfQl1wTRDrqNwwKhxk4qL7m/kDcR4EHa98AV5DZnyQi1SOws
	EjslrDYEK2EZIdTYmxDeMuZOsgcRf4GIZWE7TDgcjNnX4cWoeWYiYSiNNxZuYqrf
	czpWUFKTDZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEC93194D3;
	Thu,  2 May 2013 16:49:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67D3A194D0;
	Thu,  2 May 2013 16:49:49 +0000 (UTC)
In-Reply-To: <CACsJy8D_-S_BvQAa5b2+XpfM2-fJcEQ5EJa4RRtV1vQPEe1emA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 1 May 2013 09:03:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D94B84E-B348-11E2-99AD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223220>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, May 1, 2013 at 4:49 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
>> can't remove '{0}'?
>>
>> This patch allows '@' to be the same as 'HEAD'.
>>
>> So now we can use 'git show @~1', and all that goody goodness.
>>
>> Until now '@' was a valid name, but it conflicts with this idea, so lets
>> make it invalid. Very few people if any probably used this name, if they
>> did, they can rename it by using the full-path (e.g. refs/heads/@).
>
> People can write master short for refs/heads/master, but can't with
> refs/heads/@.

Is it a new problem?

You can not say HEAD to refer to refs/heads/HEAD, either.  To avoid
confusion, we teach "git branch HEAD $commit" to error out (but it
seems that "git checkout -b HEAD $commit" does not).

We probably would want to do the same for '@' when we refactor to
have a central place that knows what the "make sense as refnames at
the syntactic level, but are forbidden for operational purposes"
branch names are. And use it to update "git checkout -b".
