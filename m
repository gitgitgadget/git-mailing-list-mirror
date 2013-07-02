From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge: handle --ff/--no-ff/--ff-only as a tri-state option
Date: Tue, 02 Jul 2013 13:12:14 -0700
Message-ID: <7vsizwk9gh.fsf@alter.siamese.dyndns.org>
References: <20130701070143.GB17269@suse.cz> <51D197AD.1070502@alum.mit.edu>
	<20130701195407.GK17269@suse.cz> <51D2927F.3040207@alum.mit.edu>
	<20130702144757.GG5317@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 02 22:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu6w1-0004fI-VI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 22:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab3GBUMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 16:12:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab3GBUMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 16:12:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3B802B9E9;
	Tue,  2 Jul 2013 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CCFzWE1U5wm7Bz8xfln+dYc/h3k=; b=s1WWkw
	w7fzQg2C+kf2zGsK7QUWYT30s8zGYQJXBamBEkfJivOsOCYU6ITA/PfZ4zdAAAO9
	eXV7bD+Wca5K7nkSwvfTxgL0FnWBznq6kah3pFC1l1LLAgt0IN5ldTtrnJYutklI
	Ih0ktq5VHUs0Xu6Y3f5y3pJ8y6VFVrq0Px9zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OKLX7NGX82F8fEtcJKBXaOLPiCZBKu0l
	Lt+TxFlxJrB6xdoYrzHDEUbvwg9VJMzxGLJHKwpt9u3QRxcLXKbvGkGp3FUm1jpK
	lP14GN/+y2UF0DTzZAY+lvkFfv4kjxhEEIszpD6RnOFTkXVNKpjoFC25S7oqIo7x
	0/DPuOg6nU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A79A72B9E4;
	Tue,  2 Jul 2013 20:12:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2414B2B9E2;
	Tue,  2 Jul 2013 20:12:16 +0000 (UTC)
In-Reply-To: <20130702144757.GG5317@suse.cz> (Miklos Vajna's message of "Tue,
	2 Jul 2013 16:47:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0BDF120-E353-11E2-90F7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229425>

Miklos Vajna <vmiklos@suse.cz> writes:

>>     if (fast_forward == FF_ONLY)
>>         fast_forward = FF_ALLOW;
>
> Do we really want --no-ff-only? I would rather just disable it, see the
> updated patch.

Sounds sane.

>> I'm no options guru, but I think it would be possible to implement --ff
>> and --no-ff without callbacks if you choose constants such that
>> FF_NO==0, something like:
>
> Indeed, done.

Yup, looks good.

> Actually there is also --no-squash, used by e.g. git-pull internally.
> You definitely don't want a five-state option. :-) So for now I would
> rather let --squash/--no-squash alone.

Sensible for this patch.

Will replace what was queued.  Thanks.
