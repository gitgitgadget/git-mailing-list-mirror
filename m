From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rsync a *bunch* of git repos
Date: Tue, 10 Jan 2012 14:30:06 -0800
Message-ID: <7v39bn9onl.fsf@alter.siamese.dyndns.org>
References: <20120110211548.GD10255@titan.lakedaemon.net>
 <201201102124.q0ALOowL026941@no.baka.org>
 <25207BDC675840DEA94AA2B04D6783BD@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jason" <git@lakedaemon.net>,
	"Seth Robertson" <in-gitvger@baka.org>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 23:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkkCw-0007VN-S9
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 23:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616Ab2AJWaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 17:30:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab2AJWaL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 17:30:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBE7B7B65;
	Tue, 10 Jan 2012 17:30:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eVrEWKBDPEmjZBT4d/GNbVlFZkc=; b=n+pist
	iU+MkriywMAlVDyup8q5aJhpDgZcZa4fxz9JCSH3OsLOxLIu/bbmVtuS4/A6Frdd
	I0PzGwUPoEf9EOxmEHR+m6WhF0d3xWGw9O7bXlw/4Kdi6QxfGMxAJ7r6V4NWtcZI
	5O6nCidkdoqzqN4MkYaFMRuP6sXr2NWiIOciA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wdf9KFJ4eF/JLORKz74nEtkX0WC4Dl9w
	fUXfxjyt5NWVQjwxYDBkSmhP6495M1MR7LipqBB2/iUD10cbgey+w2J2hI4pOCAL
	fpLDNrllbbj7E5sSL21EdR3chscgznWuS6tk1jl8F9PzIorVPQp9GQIhpDgBKbW6
	1o+4VKf9HqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDEBE7B64;
	Tue, 10 Jan 2012 17:30:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47D967B62; Tue, 10 Jan 2012
 17:30:08 -0500 (EST)
In-Reply-To: <25207BDC675840DEA94AA2B04D6783BD@PhilipOakley> (Philip Oakley's
 message of "Tue, 10 Jan 2012 22:00:50 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6AC9BFE-3BDA-11E1-B0EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188298>

"Philip Oakley" <philipoakley@iee.org> writes:

> I think there is an exception for certain git submodule setups with
> local repos, where the gitdir link is hard coded to the absolute
> machine path. There has been some discussion on the list recently
> about trying to cover this case.

But if you read the original post carefully, all repositories involved are
under /home before the transition, and they will move to the exact same
place under /home anyway, so I do not think the discussion you have in
mind would apply to this case.

The only thing that is needed after the move would be to run

	git update-index --refresh

in all of the repositories, I think.
