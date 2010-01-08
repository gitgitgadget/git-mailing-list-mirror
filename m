From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 08 Jan 2010 08:45:55 -0800
Message-ID: <7vskag1r5o.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:46:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHyZ-00061n-DJ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab0AHQqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011Ab0AHQqJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:46:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab0AHQqI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:46:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1CFC8F656;
	Fri,  8 Jan 2010 11:46:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=0yHuuQ4xwQaoWP4DyYW9vXB39TQ=; b=ORZ0Fk
	qS2H6OJAgeXd5XIqxlKhaPyos5Ep4v4iHqvA66xOi/Mc5qooMSqPtcz48dJcb39H
	jxWa/AzxuwJOSPMkfT3HZQoPqqnYnFf34Q/PiybEgaq2r91EZCGBiYC/PHoZ8ETk
	P+4VfRH4+CWZdL0VgX0z/w3Z/ov0bNCfs0zjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ceiMZVu8VZuJTpxaGHt7Ps3tStPxftjZ
	rJaUheH2Ma3+9u7Dq7+BfG3BvWFhJYXFqWcmr7x1aZmJTM7g33IKh7jkxWjGdE7I
	ZP3jzVuZnneDPTg+LClEs7Id1eC8Tbm58niRpvw/JaOrmuQ3iuBjYPiGjKB24OKy
	c+wQPwAhco0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78B4F8F655;
	Fri,  8 Jan 2010 11:46:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ED1D8F652; Fri,  8 Jan
 2010 11:45:56 -0500 (EST)
In-Reply-To: <20100108164132.GA6171@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 8 Jan 2010 11\:41\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E68725C-FC75-11DE-B97B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136457>

Jeff King <peff@peff.net> writes:

> Well, yes, if you wanted to compare apples to apples. But actually, my
> point in showing "status" at all was to note that Michael's statement
> that they would be the same is wrong.
>
> But just looking at the ls-files output, do you not agree that there is
> a bug?

If I agreed, I wouldn't have suggested _you_ to cd up and use pathspec,
but instead would have suggested to patch ls-files to make it do so for
you.

You can see it as a feature that you can use to check what would happen
if you stopped ignoring the directory from the higher level.  With a patch
to always cd-up and use pathspec, that will become impossible.

Maybe nobody needs such a feature (I don't), in which case we can declare
it as a bug.  But I wasn't ready to do so myself when I wrote the message
you are responding to, and I still am not.
