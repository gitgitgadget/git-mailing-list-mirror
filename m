From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/40] whitespace: remediate t1006-cat-file.sh
Date: Sat, 06 Aug 2011 10:56:00 -0700
Message-ID: <7vmxfm1l1r.fsf@alter.siamese.dyndns.org>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-3-git-send-email-jon.seymour@gmail.com>
 <20110806092856.GB7645@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 06 19:56:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpl6Z-0006vQ-3Y
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 19:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588Ab1HFR4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 13:56:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756401Ab1HFR4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 13:56:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1905B4EDE;
	Sat,  6 Aug 2011 13:56:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0yzcUvXM1W4b6KTf7D4QoGty4sE=; b=x3lMNL
	2kSyfVupbiYWLrYobG95wbrgf2Rb+7v3G3QuRWxvuQ30TnIZitRQwR1QDe9jJT7Q
	FlRkz/Bq1F4F9S1HEqwMx+hOPH8/Trr3sjUI733yMnLIqMKouzP9AKTOltu2xWTM
	w4jY59O3YqWKbRCckuaEvotXEINwjAv7KLSdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ab1HudEPSyrbbd0jki0Y8Mw5fx6wvL9U
	Qg2zlKwXgWE0n+1kdqBbvGijch3b4LNjnDl5rmzh7AzPlfnqm3cJwDmqwKeBpFhD
	hV7HY8Wpe5QEIx4zW+eftqFnkqTz3gN+QXeSjnW+aKw4Jht8mgR5Q5MjASI7oRIJ
	ZmEvF3dFH5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10C0C4EDD;
	Sat,  6 Aug 2011 13:56:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70D874EDC; Sat,  6 Aug 2011
 13:56:02 -0400 (EDT)
In-Reply-To: <20110806092856.GB7645@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 6 Aug 2011 03:28:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5956D848-C055-11E0-9334-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178887>

Jeff King <peff@peff.net> writes:

> Yes, this indent with spaces violates our coding style policy. However,
> the 4-space indentation does, too (and the space between function name
> and parentheses). The "right" way is according to our policy is:
>
>   maybe_remove_timestamp() {
>           if test -z "$2"; then
>                   echo_without_newline "$1"

Hmm, I have always thought that our shell scripts preferred the above to
be spelled this way instead:

	maybe_remove_timestamp () {
		if test -z "$2"
		then
			echo_without_newline "$1"

> So I have to wonder if this automated indentation is really worthwhile.

That I agree with.

> I dunno. I'm not against a one-time cleanup,...

I actually am slightly against it. One-time whole-tree clean-up can never
happen without downside as _some_ parts of the tree always have patches to
conflict with it in flight. One-time decision to clearly spell out the
rules and cleaning the tree over time, fixing parts that are not actively
touched one at a time, is probably feasible, though.
