From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 30 Mar 2010 16:10:27 -0700
Message-ID: <7vhbnxs8ws.fsf@alter.siamese.dyndns.org>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
 <20100330230211.GC608@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Lars R. Damerow" <lars@pixar.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwka8-0000No-PZ
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab0C3XKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 19:10:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab0C3XKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 19:10:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD0D2A6AAA;
	Tue, 30 Mar 2010 19:10:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZR4qjh5fvFraUIB4Jg6twpTXDzg=; b=BeTg/K
	/oqI5k0yCKD9l1k+a+oMcAGKV8oWMWwYIOWFcF6frdtwky5Ww869QSIAC76HXS9W
	0AAs2edRMjWU/Vfsk88ox6kyqYuU6dyMfQDVGEhN+t+jO38xHNV7pD9tK98MycnN
	WrvsCik2kGob7ULCDa9zzdF7DiBdbkXzRk1E4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G5yJ4CoA/xYLr15TvWNJ35PJoI4VcBaQ
	1mT62OQXzUZlDSlEyHAcuvbRWwefAybfWfRW6P8ZPioNlsPF617/IbHhN3imcsTv
	jSZB/I6UEqgMY71lh04klmofsivCCpZkiBL2yCVhzmVqvGCMj6Qve2Kps+7nwjTv
	NGKj0lIxKjU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AFF6A6AA9;
	Tue, 30 Mar 2010 19:10:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BC7EA6AA4; Tue, 30 Mar
 2010 19:10:28 -0400 (EDT)
In-Reply-To: <20100330230211.GC608@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 30 Mar 2010 19\:02\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71D2F0AC-3C51-11DF-8650-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143620>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 30, 2010 at 03:43:01PM -0700, Linus Torvalds wrote:
>
>> I realize that I'm late to the party, but I do wonder if the "one 
>> filesystem" mode shouldn't be the default, rather than be enabled by a 
>> config option? IOW, just switch the meaning of the config option the other 
>> way.
>
> Fashionably late, of course. I agree with your reasoning that it is
> a more sane default. The only thing that would make me hesitate on it
> now is that it is a behavior change. I suspect the group we would be
> breaking is small or even zero, though.

Yeah, I think I agree with the reasoning, and it is not even _late_, as
the feature hasn't escaped the lab yet.
