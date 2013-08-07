From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Wed, 07 Aug 2013 10:50:37 -0700
Message-ID: <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<52027B17.7040602@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 19:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V77sn-00016c-OO
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 19:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694Ab3HGRup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 13:50:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932144Ab3HGRup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 13:50:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2B3376B4;
	Wed,  7 Aug 2013 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+Zb5tpaVxZnM9XlyYc9I9uCi9U=; b=CLVQzi
	un6YLnK59kjDHnWvnLCbO1vHUZEYJ/TR2YpkO8znebdwPFBeUkBCJ1jsKHkeemNA
	rZAmYR/6fyGUXJf7FVlxt2VA5ZQqL9ycwZnXtgOX7dXsvRZNsR8SAlIpKMrtoTij
	rSMMKM3HsjxYDAUpPW+F/PoP/Puy+Rnif1AdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+FuOn/ueC/qdNRonPjAJjdFbbvWQm3D
	p/xnxrDYL7s1/Lb3cYt+bqcqKCqcKkI50OB8rk5/Q6Z5JK0Dgb9eVjeF4t3cJYmH
	ut1hsdNL5OO3Woy1z1IqlTJp04xqzySwj8jzhABozOzLBqxPrfTXllf6xvBm4XrK
	K7MY++LdBlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD470376B1;
	Wed,  7 Aug 2013 17:50:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6E37376AC;
	Wed,  7 Aug 2013 17:50:39 +0000 (UTC)
In-Reply-To: <52027B17.7040602@googlemail.com> (Stefan Beller's message of
	"Wed, 07 Aug 2013 18:51:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF53927C-FF89-11E2-8CDA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231839>

Stefan Beller <stefanbeller@googlemail.com> writes:

> I'd deprecate it first for a year or such and remove it then.
> In the meantime we could implement already remove the code
> and change it to:
>
> + int cmd_whatchanged(int argc, const char **argv, const char *prefix)
> + {
> + 	return cmd_log(argc, argv, prefix)
> + }
>
> Also we should make sure everything git whatchanged can do,
> can easily be done with git log <options>.

That's even worse than "deprecating".

Your first step already changes the behaviour for people who really
use the command, without telling them _why_ the behaviour has
suddenly changed at all, while not helping *ANYBODY*.

The only thing it does is to scratch an irrelevant itch by people
who peek the codebase and find an old command whose existence does
not even hurt them.  They may have too much time on their hand, but
that is not an excuse to waste other people's time by adding extra
makework on our plate, or changing the behaviour for people who use
the command without explanation.

Feeling irritated somewhat...
