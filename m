From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Mon, 17 Jun 2013 07:27:20 -0700
Message-ID: <7vwqpshkxj.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
	<8738shi2ht.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 17 16:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoaP3-0008M1-HO
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 16:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab3FQO1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 10:27:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308Ab3FQO1X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 10:27:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75DB028AA4;
	Mon, 17 Jun 2013 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U0s0K88YWHdcgvVZtvyQzcf7BVQ=; b=ycJuhc
	Sc2D+h73YpYdsnWpQZ6kOtVo4ccS8lkhnSA2uL0RJt9WqjipvWfLYbJsdnKqX7a0
	EP3rr7ddjpJiM9uh3AycxBL4p8AEq33VQIbjacOJgYvV180p2Sk+ZqxBw9brvDVP
	W+SWk6IDy7SlpRLzWzLeOFwjSfoWLlVd5ODkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OB6sHy00S2Sh7R2kLaogqSWzIdovYnFj
	eEhbYBBQLDWj/9dC6RwklEeBJkxv7qyEqqLMJ7Ojmgs0bjDK+uxUgDb2WyK93NkQ
	tXvfD4qQVCO/RU3Ram+4VBT6/+TnMpQiXBom2nQBAzYQQs59BdO3H+xSMLtFBFDK
	1CTtRngP+dU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B5FC28AA3;
	Mon, 17 Jun 2013 14:27:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE70B28AA2;
	Mon, 17 Jun 2013 14:27:21 +0000 (UTC)
In-Reply-To: <8738shi2ht.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 17 Jun 2013 10:07:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05D1BC24-D75A-11E2-B179-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228073>

Thomas Rast <trast@inf.ethz.ch> writes:

> Conveniently enough we have seen both already ;-)  Andrew's version for
> commit.c could use a bit of refactorization, since it inserts the same
> code in two places, but then it's about the same complexity as the
> change for rebase.
>
> I'm not sure it's worth arguing about whether the "fixup! fixup!"  is a
> symptom of some underlying problem, and changing rebase is only tapering
> over the symptom; or whether it's actually a useful distinction.

If they are about the same complexity, then my instict tells me that
it is a better design not to strip on the writing side.

Thanks.
