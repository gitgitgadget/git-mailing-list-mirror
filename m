From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Wed, 23 Apr 2014 14:30:46 -0700
Message-ID: <xmqq4n1jybqx.fsf@gitster.dls.corp.google.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
	<1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
	<38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
	<xmqqa9bbzwc0.fsf@gitster.dls.corp.google.com>
	<535829dd861b1_24448772ece1@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4kr-0006Gb-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbaDWVav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:30:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbaDWVau (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:30:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 002AE7E634;
	Wed, 23 Apr 2014 17:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v1NII4b/joDlFg4MTp0McMrSjL4=; b=Ubx6nx
	eBty1Qb+n9KyvDpmxjVwk1WU4wrFGlis9yG5LzXOKlTFrZ759/ptEQT/BS/APn9Q
	4+EGwNJJFmaq0+dn3y4fSS8cIbE8NuSM9S1V3HNBI8VTrevZQ5mRY4BxdCn3FF9Q
	booeykFiHFIKD3vBXmfWu9BzO097cBQc/O5lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SlDW8ILmDmVi5oBsojhzL6KZWKdt7Qag
	0I9+XpidF6Vi8HWX7ZRw3RYAswlDpquzw6pBrCT9TgJ92EP16hRHqqoRlb5r7KCw
	ojCiIORX+86DGPX8zQiIcKmeYHNAu6jidCk/RZXTPgw8+8CflIU2OxzVxJmlS7kJ
	3jThpSLoQq4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE57A7E633;
	Wed, 23 Apr 2014 17:30:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F8397E631;
	Wed, 23 Apr 2014 17:30:48 -0400 (EDT)
In-Reply-To: <535829dd861b1_24448772ece1@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 23 Apr 2014 16:00:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 89428CBE-CB2E-11E3-9BFA-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246902>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The very unlikely issue that nobody has reported about hg multiple heads and gc
> I just fixed, and the issue he just reported about 'foo' and 'foo/bar' is newly
> reported, and there's no easy way to fix this.

I would not judge on likelyhood, but I would say that 'foo' vs
'foo/bar' is something that falls into the same category as "if you
want your project to be cross-platform, don't have paths Foo and foo
both tracked, as some people have to work on case insensitive
systems".

In other words, I think it is perfectly fine as long as the users
are made aware of these issues.  One way to deal with such a project
may be to allow users to map 'foo' to 'foo_' to make room for
'foo/bar', but lack of such a feature is not grave enough to block
it from being used---it would be unreasonable to demand the ref
mapping to be implemented before the command is given to the end
users.
