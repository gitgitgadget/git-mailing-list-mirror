From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] transport-helper: fix remote helper namespace regression
Date: Fri, 10 May 2013 07:35:04 -0700
Message-ID: <7vr4he52ef.fsf@alter.siamese.dyndns.org>
References: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
	<1368187710-4434-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:35:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoPk-0001IY-2K
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab3EJOfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:35:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab3EJOfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:35:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B3DF1B381;
	Fri, 10 May 2013 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=grxbUpvQWEU0DzB3V1Y4DEcyv3I=; b=oNhcPL
	ht0lUrUsz+1E7adzzL9PsIXd3uvqaswiWuzfIAMZ4TP3lgYmr3QzNN3HDcw+c1Ug
	f6sVy9saCl6VpnJjY/vikFs4OkZ0FGWpDNBL7Cc2B5ByZAvGVslql4AW07uvACa/
	WPvMHQOe1uVmFqmzWD3Po7B0/yz2eOEupldQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tW/fU6rNsILjFE9HIQmwACyikZL7l6tE
	0uagT9ITCh4xSRS0Pjyb+aYPBlgvV/twlbw+HSnBg1NsFcXgD9Ts0Bqxo12cKXl3
	Z/22ucviAKcjMnI5WjdGigU8VgKOlKMMrCaMFUBjhYWMGFxX58xBZgikfoWtyVOD
	S4PzTl3Ll/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 238CC1B37F;
	Fri, 10 May 2013 14:35:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EC651B37E;
	Fri, 10 May 2013 14:35:06 +0000 (UTC)
In-Reply-To: <1368187710-4434-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 10 May 2013 07:08:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF20C434-B97E-11E2-B94C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223854>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit 664059f (transport-helper: update remote helper namespace)
> updates the namespace when the push succeeds or not; we should do it
> only when it succeeded.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> The regression is in 'next' so far.

Thanks.

As you may well know, anything in 'next' will stay there until 1.8.3
and then 'next' will rewound and rebuilt after that.  If you prefer,
we can do without "oops, the previous one was wrong and this is a
fix" follow-up patch like this and instead replace the faulty change
in the series when that happens.
