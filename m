From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to send a warning message from git hosting server?
Date: Sun, 05 Apr 2015 13:18:47 -0700
Message-ID: <xmqqzj6mcorc.fsf@gitster.dls.corp.google.com>
References: <CAFT+Tg-Gwr9EemFv88+=Ao21dGYe73D-CDiT4mXU4kuP-niOSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: "Yi\, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yer0Q-000679-Gm
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 22:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbbDEUSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 16:18:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752384AbbDEUSt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 16:18:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1866B45785;
	Sun,  5 Apr 2015 16:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8X7WgO1qfL5n7f6ZvhqQQ7UsNI=; b=ET+gJh
	GiEBSXIXmeMcrfkF2Za3FN0e/r6birRLN7/1LUhLibQlOwxgxnuui8ecWdjatLNu
	baVBwlzfflaFU8EDYwm5WBC1/PmwTBOuiWrfXam3MTM5q4XWB/rQCF3xBV4oF2fc
	XLZtknOhL+0RzOS7tDHl0/yAqiuECrHJiW3A4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghjqlBOOBn3A0nsv55bO/M2qgB334YpH
	bSJPnGAvx0x0eMByKRKJIqZgWgEFTag7sl8oykHcQdNGNNB1nIP5dqiLjYB+v+Q8
	b6oZxX50SfDSrj4AYHa8S5v+bsXnoyXx72W/+0K6Da7Oyyskwv2E9iQwYf6t6eQN
	wcLuGvTdLIA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F37545784;
	Sun,  5 Apr 2015 16:18:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 820504577E;
	Sun,  5 Apr 2015 16:18:48 -0400 (EDT)
In-Reply-To: <CAFT+Tg-Gwr9EemFv88+=Ao21dGYe73D-CDiT4mXU4kuP-niOSw@mail.gmail.com>
	(EungJun Yi's message of "Mon, 6 Apr 2015 00:04:43 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7D31320-DBD0-11E4-BAA1-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266818>

"Yi, EungJun" <semtlenori@gmail.com> writes:

> Hello. I am serving a git hosting service for my company.
>
> Sometimes I want to send a warning message to users who use my
> service; e.g. the service will be shutdown tomorrow for a while
> temporary.
>
> I know it is possible to a remote message by hooks or HTTP body if an
> error occured. But it seems that there is no hooks for git-fetch and
> git does not print HTTP body if there is no error.
>
> I want a way to response a remote message when a client send any kind
> of request. Is it possible?

I do not offhand know if there are such hooks, but I would imagine
that I'd be mightily annoyed if I were forced to interact with such
a server.  I may not have a need to pull anything for a few days,
working on my changes, and then I'd find out when the service is
already down.  I may pull many times a day, and for a few days of
pre-announcement period, I'd be forced to see the same message over
and over.  I may have a cron job to fetch down the changes made by
coworkers in other timezones while I am sleeping so that I can start
my day from an up-to-date state, but it is very likely I would say
"fetch --quiet" in the cron job because I want it to be quiet unless
there is an error.

I'd appreciate if the Gitmasters at the company sent an e-mail
addressed to git-users@mycompany.xz instead.
