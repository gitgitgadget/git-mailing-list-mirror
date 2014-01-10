From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5531: further "matching" fixups
Date: Fri, 10 Jan 2014 15:34:59 -0800
Message-ID: <xmqqzjn376n0.fsf@gitster.dls.corp.google.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093531.GD15720@sigill.intra.peff.net>
	<20140108102707.GA23145@sigill.intra.peff.net>
	<20140108104756.GA32078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 11 00:35:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1lbh-0007Fl-47
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 00:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757846AbaAJXfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 18:35:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbaAJXfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 18:35:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8051D623EB;
	Fri, 10 Jan 2014 18:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ecZ9rEUh2VOhbk3VgvaR6eJ3aj0=; b=Dly5m/
	Vaqe9X0H3J9a8HZ/7jInyajy3ddAjw/oa54VbyY4qZNTtRY5kkCpkuAo9KCOp2WE
	li1qFEQEcVrVpsJROmiG4Ld9pzYR93ZkmaIurF17mVP8oOXq/qzD9BfqEhNfz/ko
	TDbb16+iSGOSPvWHDRc8NSKM3dM5p+4nKLNfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eWwzdahFsqThKiErCYoERyn2q/u1L7Ay
	zqcQTlWrid1hAMcpHzHaW3TBegUQqjWziBsjSDXTzMUdAAVupBTsxKu+3rdgI9qm
	f85pwfFbO3JUXRnUpU+frhrTZoPjogvHlB9UhN01lrwwL09ET+wVbcKlyPymWWaT
	bJ7P+MvE2qs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFAF623E9;
	Fri, 10 Jan 2014 18:35:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2951623E7;
	Fri, 10 Jan 2014 18:35:03 -0500 (EST)
In-Reply-To: <20140108104756.GA32078@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jan 2014 05:47:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D476010A-7A4F-11E3-8912-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240321>

Jeff King <peff@peff.net> writes:

> ... but the
> failing test is actually somewhat broken in 'next' already.

Hmph, in what way?  I haven't seen t5531 breakage on 'next', with or
without your series...

> fixes it, and should be done regardless of the other series.
>
>  t/t5531-deep-submodule-push.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 8c16e04..445bb5f 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -12,6 +12,7 @@ test_expect_success setup '
>  	(
>  		cd work &&
>  		git init &&
> +		git config push.default matching &&
>  		mkdir -p gar/bage &&
>  		(
>  			cd gar/bage &&
