From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 20 Jun 2012 12:31:42 -0700
Message-ID: <7va9zxvkyp.fsf@alter.siamese.dyndns.org>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
 <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehp9x3yz.fsf@alter.siamese.dyndns.org> <vpqpq8t96zw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:31:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQd2-0000Lo-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757904Ab2FTTbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:31:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757885Ab2FTTbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:31:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A451F99E9;
	Wed, 20 Jun 2012 15:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FizZCrCdjVBwSq7ZqhBdp6MmJ5k=; b=G4TnOP
	APtzp7LBHfFpCqynlT2lR7FAUJA0oevfAVGRjbDLOhHQuMBuulGaMDqu4ItcWTQS
	seICfIxP1qwsvzq8pX+ZJQuJB3lJs2kP12gok6wZOxKTlMrVG71m6VP9McR2ff1u
	o/A8qim7t0MNznzj9ce29R40nWvbg0i3BJjmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Alq9IlA2KXWTdr1bcYXitrYcwnsCfFjA
	F/xpRM/6VXicDzBexZp6WsXztmG1E3NxHmMPkaXAqXsLDhfelC+p/Ya4gey4r2Ac
	oN+zHbWPMwzTCzE+wOElp4rmoFm7FDB20VHLmb9baZTOewnvgK6Yg+qxP5hLghmt
	kk8FFvWjfqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BBA399E8;
	Wed, 20 Jun 2012 15:31:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30E8D99E7; Wed, 20 Jun 2012
 15:31:44 -0400 (EDT)
In-Reply-To: <vpqpq8t96zw.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 20 Jun 2012 20:24:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9174B736-BB0E-11E1-A510-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200338>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> So, the long term goal is really to switch to 'simple', but people who
> use different versions of Git won't be able to use it before a few
> years. These people have several options:
>
> 1) Keep push.default unset. This is not acceptable because they don't
>    want the big fat warning each time they push.

Yes, to them one of 'simple', 'current' or 'upstream' would be
sensible (but they need to read up on them to see which one they
want).

> 2) Set push.default to 'matching', to keep the old behavior and squelsh
>    the warning. If they go this way, they will never see the default
>    change.

This is not the audience of the quoted part of the message i.e. "If
you want to use it before default changes".  These people fall into
the "If you want to keep the current default, set push.default to
'matching'" category, so it is irrelevant to the discussion.

> 3) Set push.default to 'current', in which case they have the same
>    behavior as 'simple', except for the safety feature of 'simple'
>    (refuse to push when the name doesn't match the upstream). They can't
>    expect anything better anyway since they are sometimes using a
>    machine which doesn't support 'simple' anyway.

And they will be frozen to 'current' even after their sysadmins
update the version of git that support 'simple'.  

Telling somebody who would blindly follow what was suggested to use
'current' is what bothers me.
