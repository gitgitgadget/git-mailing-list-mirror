From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 17:11:41 -0700
Message-ID: <xmqqegx53txe.fsf@gitster.dls.corp.google.com>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
	<20140728103504.GB10737@peff.net>
	<xmqqtx614cea.fsf@gitster.dls.corp.google.com>
	<20140728173734.GA10309@peff.net> <20140728180157.GA11265@peff.net>
	<xmqqppgp4a7x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBv1M-00078P-Ks
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 02:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbaG2AL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 20:11:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52394 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbaG2ALz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 20:11:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E26B92D9CF;
	Mon, 28 Jul 2014 20:11:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vlb1XWY/BShAl5jgwdxIy8FE+aE=; b=yGxfRJ
	ELeFME5m812UopBfXXnUQp00H+heSRjtTm3e2f+ldhybdqUf4GLF1jjkWCbUsmW7
	+b09TVBn2KJYhQhqTSEHrWMh3X2/vvQ1sym4QW25yFs1l4/E0QGsHMIdrE9VeOMu
	G5GrpbiHT8Lu13lV2k3drZziT1roP4oFPUyS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d6ZZe5HjLjzE7oowqHUCFeo8BxW3Qx7/
	es5h8scO3gAJqTacjFpQcCX8MjkjzawMrO1+eES/D0cKENRjjd09jOV61hbX8SEM
	kg3UUwUejrJJhpKE1+/SZhyQDx0zzMWn22GttKvEthUhMzt6nspULnTF8VUOEBw1
	8ZY/F6bM5Mc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8A6D2D9CE;
	Mon, 28 Jul 2014 20:11:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99AD92D9C1;
	Mon, 28 Jul 2014 20:11:43 -0400 (EDT)
In-Reply-To: <xmqqppgp4a7x.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Jul 2014 11:19:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBF1FFA8-16B4-11E4-8CF2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254386>

Junio C Hamano <gitster@pobox.com> writes:

>>> Yeah, I'm fine with a straight revert, too (I think it is fine to keep
>>> in master, though). I think jk/alloc-commit-id is built right on top of
>>> the original commit-slab topic, so it should be easy to do either way.
>>> 
>>> Thanks for dealing with it.
>>
>> Whatever we do, perhaps it is worth applying the test below on top?
>
> Yeah, thanks.  I think that is a good idea.  I was preparing a patch
> to tuck your minimum reproduction at the end of 4202, but your version
> and placement makes good sense.

OK, I pushed out updated 'maint' and 'master'.  The former merges
a rebased version of jk/alloc-commit-id in to make the "reorganize
the way we manage the in-core commit data" topic, and the latter
reverts the "Use SSE to micro-optimize a leaf function to check the
format of a ref string".

Please give them some quick sanity check.

Thanks.
