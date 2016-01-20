From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: remove unnecessary backslashes
Date: Wed, 20 Jan 2016 12:28:53 -0800
Message-ID: <xmqqmvs05722.fsf@gitster.mtv.corp.google.com>
References: <1453310497-7971-1-git-send-email-kraai@ftbfs.org>
	<20160120182421.GA27562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>,
	Matthew Kraai <matt.kraai@abbott.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:29:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzNF-0007rA-0c
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 21:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbcATU25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 15:28:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751892AbcATU2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 15:28:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CA313C2AE;
	Wed, 20 Jan 2016 15:28:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TuVRH5njZt74lWf9wg0pzZwrw1s=; b=gkYGJb
	E2zxE5DLGO6Bm7iNSha3T/R/Io8rXwR5zykVu3WKuVZ3CusVNMrlIWzm9wR9ZUKj
	afF5pw/3PsQ8t3yXK/eEiAKZOOn68DV+2MQusla5Y4OZLZoOsWoN8aV8FpGaTV/K
	WL4uI697EclM5jN00V31XqkY+csECNKINGXz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQ+fV8oBtPFnsHyRftD6ld2bLPBKs6O9
	pKWcKJX5TXyBjUJhZgZQFfiwj59sHmgOCvqhedeJ2NpMWrH+sONgR4xapYDX4ePu
	GRVlI8pWN2z1JmfbsL7yanvkO/1ibjQ4g9Aqnr5tLeorGG28Lr7FDZNS+Mdk994e
	ooKeUGHTdKE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE0743C2AD;
	Wed, 20 Jan 2016 15:28:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5CBE33C2AC;
	Wed, 20 Jan 2016 15:28:54 -0500 (EST)
In-Reply-To: <20160120182421.GA27562@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Jan 2016 13:24:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6CBB861E-BFB4-11E5-8F25-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284461>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 20, 2016 at 09:21:37AM -0800, Matt Kraai wrote:
>
>> From: Matthew Kraai <matt.kraai@abbott.com>
>> 
>> asciidoctor does not remove backslashes used to escape curly brackets from
>> the HTML output if the contents of the curly brackets are empty or contain
>> at least a <, -, or space.  asciidoc does not require the backslashes in
>> these cases, so just remove them.
>
> I think these backslashes may have been necessary in older versions of
> asciidoc, but I don't recall the details. Looks like we did a similar
> round of cleanups already in 4538a88256, so this is probably safe (and I
> verified with asciidoc 8.6.9 that the generated output is the same).
>
>> -'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
>> +'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
>
> I see you didn't tweak the middle one here, because it _does_ look like
> an attribute. Does asciidoctor actually remove the backslashes there?

A more important question is if it works without the backslashes.
If not-too-stale versions of asciidoc everybody uses these days are
all OK without braces quoted with backslashes, and if the same holds
true for asciidoctor, then we would want consistency here.

On the other hand, if this line must be spelled like the above to
please asciidoctor, i.e. the first and the last must not have
backslashes and the second must have backslashes, I'd have to say
we have a bigger problem.  Perhaps asciidoctor needs to be fixed
until normal people like we can rely on it.
