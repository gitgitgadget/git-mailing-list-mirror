From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Tue, 01 Mar 2011 21:24:01 -0800
Message-ID: <7vwrkiccy6.fsf@alter.siamese.dyndns.org>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
 <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
 <7v7hckje4n.fsf@alter.siamese.dyndns.org>
 <20110301205424.GA18793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 06:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PueXs-0000kn-TP
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 06:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab1CBFYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 00:24:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1CBFYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 00:24:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 057A3491E;
	Wed,  2 Mar 2011 00:25:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jgIaw2GIsSJqjZkcNxpDBmMHeZE=; b=ukmarM
	GLLQRIX+MPAUnwrWgggMvs0HC1hKhRTtuzqMXaKr1R4bSCo0EkHvnPS8cUJwI9rA
	vX44y2tg5nI4dvrHHnU1Dbwc+SNV6AXs59WAjYAkjaXVNfZz4q5kmNxvcOXxxFmN
	mkX3W79ZL0ByjZUEKrF1GZ39Z1apDko3a6h4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y4G9FpS5u9WBo1gVNpY8lDlq7UtUWZFD
	E+44YKyCGmwu2gQqIP1JdpWvzxdqxmgesgqfzRgLBMnUJ7hQiBgmMnJ36ChAldTn
	FdUfzgBs7/9glIj6Db4EYPxN5uOicvKh81yCYZmcrH1GPYf7B5cC1pRe0zv+zVMX
	9l7zpSBLsUU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9227491C;
	Wed,  2 Mar 2011 00:25:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 507C74918; Wed,  2 Mar 2011
 00:25:22 -0500 (EST)
In-Reply-To: <20110301205424.GA18793@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 1 Mar 2011 15\:54\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BADB8BA-448D-11E0-A0E4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168292>

Jeff King <peff@peff.net> writes:

> So I'm curious what you think is missing in the balance you mentioned
> above.

I touched this in a separate message, I think...

> A few other things I noticed are:
> ...
>     I am so used to regular git output. But I think just using " %h %s",
>     e.g.:
>
>        1234abcd commit subject one
>        5678defa commit subject two

That would be better, I agree.

> ...
>     In other words, I think this safety valve is not just useful for
>     clueless people who make commits without realizing they're on a
>     detached HEAD. It is also useful for clueful people as a helpful
>     reminder that they may be leaving commits behind, and they can
>     ignore or deal with it as appropriate. I tend to ignore the
>     "Previous HEAD was..." message because it shows _every time_,
>     whether those are my new commits or not.

... never thought about this from that angle.  Perhaps you are right.

>   - Nit: you nicely use "%d commit%s" to handle the single/plural case
>     in the warning message, but then you "them" later on. It needs
>     (1 < lost) ? "them" : "it".

I actually don't like playing games like that, especially when i18n topic
is in flight.  Among the languages I know rules reasonably well, two has
the rule that a countable noun is spelled differently depending on the
number of that thing is one or more, and one spells the noun the same way
regardless of the number.  Who knows if git needs to be translated into a
language whose noun changes its shape three-way, depending on the number
being one, two, or more?
