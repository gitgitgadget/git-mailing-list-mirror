From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Mon, 16 Jul 2012 20:40:24 -0700
Message-ID: <7v1ukbys0n.fsf@alter.siamese.dyndns.org>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <7vipdn1qb7.fsf@alter.siamese.dyndns.org>
 <20120717031727.GA20945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:40:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqyeJ-0002Ry-I4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 05:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab2GQDka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 23:40:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab2GQDk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 23:40:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B4358B8C;
	Mon, 16 Jul 2012 23:40:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/kImSADCt/fHA6wcKp3SAwsceVw=; b=Ag4NVp
	AwUBJRyzM22zK/QBnZkhX5FdMurGlUf///PfD+4o2IvCG5lNaOycbEn1xH7eQOKp
	uhwqdN4x3SandaoGQldHb16Q4lOQf0Qvm64ln/fB2/veOiyaoQi8vONv2MHJqc7s
	/cduKvDLABgBkXcfBVAtzk0dWeJgmUlBmIOJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DbzCoP9aaqhcYdgLtFZqrnCtg741AAXw
	fE+pTMQ0yaPu2BqFh/FRiIX1JKJ9lXAktV2LYQ6QzzCrHNgOMhwMuo6imiFUbANL
	+oOb3XYLyGWYK6TQGI4Z0IGy69ZhJ6mrQQeKP5GNmWi0edmTBQEV+tX5svXF6WNb
	tNP8UGbz3wc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 076B88B8B;
	Mon, 16 Jul 2012 23:40:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A50A8B88; Mon, 16 Jul 2012
 23:40:25 -0400 (EDT)
In-Reply-To: <20120717031727.GA20945@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 16 Jul 2012 23:17:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 253B1A8E-CFC1-11E1-A2D5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201585>

Jeff King <peff@peff.net> writes:

> ... But whatever we call it, I think it is an
> improvement.

I didn't say it makes things worse in any way, did I?

I was reacting on the Subject: line because that will what I later
have to work from when reading shortlog, summarizing changes, etc.

> ... I don't think one more option is going to
> break the camel's back, but I wonder if "rev-list -h" could use some
> cleanup. E.g., maybe drop seldom used stuff like --bisect-vars, format
> similar options on a single line to save space, and add in some missing
> options.

Sounds good.  The manpage also needs some cleaning up, I would
think, to omit things that may happen to work (primarily because a
lot of code is shared with "log") but do not have to, for example.
