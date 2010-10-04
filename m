From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 04 Oct 2010 10:29:43 -0700
Message-ID: <7vlj6d988o.fsf@alter.siamese.dyndns.org>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com>
 <1285967766.6750.2.camel@gandalf.stny.rr.com>
 <4CA9815D.3040801@drmicha.warpmail.net>
 <20101004075015.GN28679@pengutronix.de>
 <4CA98EF1.1050102@drmicha.warpmail.net>
 <20101004085050.GQ28679@pengutronix.de>
 <4CA99E43.1000204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 04 19:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2orU-0001uj-90
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab0JDR37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 13:29:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab0JDR36 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 13:29:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F762DBB2C;
	Mon,  4 Oct 2010 13:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G2p8EppyoVMKVIeEGNi4LUBLa9w=; b=vAf4+O
	WvqVlAagl6zHudlzX9Qu2klmep/qoHamn1Y7uKTzQ9tpIRUAfx08OnJqgtjP1Px3
	1hNBeSnIZnRSWdsckLtjyNcMOxxSIj7krww8D+cAnjh9BgXHCu+W692EowTPnAIg
	jrl9DoAmLVwjX/7dVpknUCOYRWKEsQLa442YE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XCKQ9HXg1EIXC0ZpUX4CEu8n0ZDMuGqQ
	rLL4MJvpyP3z7HW2OQccnqRvyG8SsM/pRFHUqbfB/mSfSfRbcYCtjAlXQFEu5yzK
	0KtKV0Ygq4Hz9bbf7WmSDCcdO8xsSmp0hREcmp2DHoygYjooEZiFtJMYoYAjJUDN
	vu3KwiN5Ltw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C53DBB1F;
	Mon,  4 Oct 2010 13:29:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9FCBDBB1B; Mon,  4 Oct
 2010 13:29:45 -0400 (EDT)
In-Reply-To: <4CA99E43.1000204@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 04 Oct 2010 11\:28\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FEB9BE14-CFDC-11DF-BE0B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158070>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> I choosed to write "overwritten" instead of "updated" to make it clearer
>> that it makes no sence to push into these branches from a different
>> source.  Should this be noted more explicit?
>
> "update" may be more Git lingo but I think either is fine. "overwritten"
> makes it clearer this is not a repo to do development in...

In a repository with remote.origin.mirror set to true, "git fetch origin"
does not seem to prune a ref that has been removed from the origin.  I
think that is a design bug, albeit a minor one ("git fetch -p origin" can
fix, but "-p" should not be necessary).  A "mirror"'s purpose is to, ehh,
mirror a remote so that local people can share it as a nearby copy.

A wording that also implies this automatic deletion of a stale ref would
be nice; "overwritten" does not exactly sound like that, though.
