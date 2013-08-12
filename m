From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 10:22:07 -0700
Message-ID: <7vob92zuww.fsf@alter.siamese.dyndns.org>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <davidj@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 19:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8voz-0002pH-FH
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 19:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab3HLRWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 13:22:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725Ab3HLRWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 13:22:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1758238AD4;
	Mon, 12 Aug 2013 17:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=CKxAGiuIqkBxbtCZJ8b9rhWoUyo=; b=cF2aDAW0JZbjmoCvexKo
	s9Z2ZeqW1rwVFUBbWrqmgNS2b/Hven5gCWq1cNN3Gt4qiJrisw12LeKpxmQExCIZ
	+iMeqrvVkClX4axT778JqcuYCPQzdqD/gTQHZSgiUa1LJpWi/oCygHTe+fsW8+wt
	wY/H/bo0LbVGC1edQVyW7/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EwGlZ+5L/TTpIHR82BCixI0r65P2RZew6Kx28k+KqFdUZ/
	iiEcU51L+8shwrTEQNfXeHhLeRu3szCcBTBvmoAVxixz27usjsbu6q22+gEquYC7
	TW4WotAjhKHWykQPBL3z2Ca0GeP9P0DEjJOYqIM47iICCHmTl5JyihaqswXZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F23438ACD;
	Mon, 12 Aug 2013 17:22:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FE5538AC8;
	Mon, 12 Aug 2013 17:22:13 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA5314FA-0373-11E3-AE82-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232201>

David Jeske <davidj@gmail.com> writes:

> @Junio - to put the issue in the context of your previous comments on
> the topic... way back when you made a comment about warnings during
> commits to detached heads..
>
> http://git.661346.n2.nabble.com/RFC-Detached-HEAD-reminder-on-commit-td834710.html#a834959
>
>> If we _really_ don't want newbies to shoot themselves in the foot, we
>> probably can issue a loud warning when they detach there HEAD.
>> Oh, wait,... we already do that.
>
> The reason this rationale doesn't ring true for me, is that it is
> *very* common for me to checkout a detached-head and there is nothing
> odd or dangerous about it.

You do not have to say that to me _now_ ;-) because after makinng
the above ancient comment others have corrected me, I agreed with
them, and we no longer rely on that "you are detaching, danger
ahead" warning.

With the same line of reasoning, the place where users make commits
on detached HEAD is not where the danger arises, either; the real
danger is where you switch out of the detached HEAD state, and I
think we do give a loud warning there.
