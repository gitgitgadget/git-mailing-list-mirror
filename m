From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] improving advice message from "git commit" during a merge
Date: Wed, 27 Aug 2014 12:28:11 -0700
Message-ID: <xmqqmwapd96c.fsf@gitster.dls.corp.google.com>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
	<20140827191857.GB7561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:28:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMitO-0008T7-J4
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935687AbaH0T2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:28:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52903 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935548AbaH0T2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:28:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5622A35808;
	Wed, 27 Aug 2014 15:28:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H+aoyVdWTFVQIT0oYSMnpEe0b3I=; b=h+dQKl
	cg7evVXGHU77/VXOHfKGts/mrguSWg7Y/Li20FDxgvyiqUDWcjPBPzRSKKL0L63l
	bRBbs1VY6Qc60eC4RBg8m2sFnKKedSnyXc22kQOAbW5P9lAU1EfqorPQzkogcnRY
	h4fhlP33Cs9u3wFmcNfmaMUqoJ6EhdC1J7nEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcjm8pdHLUnCy9a6U3oFKV6/mSaM4AO9
	39bxNWMDh+ZTe6oliW8q+EaqEcG2qddS9O6fLYhN2QYaflpoF8omJc4E3hAGiT2l
	FqpYDHcTbbJ9jAUfgiabJvfP1wFe32RN8IIc+Eyswuk6vFTVN937QzRmdd7FbhnZ
	OVjkxm6mGu8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D6C435807;
	Wed, 27 Aug 2014 15:28:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 52F4535802;
	Wed, 27 Aug 2014 15:28:13 -0400 (EDT)
In-Reply-To: <20140827191857.GB7561@peff.net> (Jeff King's message of "Wed, 27
	Aug 2014 15:18:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 496A97DA-2E20-11E4-BB66-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256027>

Jeff King <peff@peff.net> writes:

>>  - When all the unmerged paths have their conflicts resolved in the
>>    working tree, we do not have to say "Fix them up in the work
>>    tree,".  We can instead say "You seem to have fixed them up in
>>    the work tree already," or something.
>
> How are you determining what has been resolved? By looking for "<<<<<<<"
> markers? That feels a little flaky, but I guess it would probably work
> well enough in practice.

I was going to say "whatever rerere does" by reusing whatever it has
already implemented.

> If we started using that heuristic, it would probably make sense to
> teach "git status" about it (and then maybe just have a failed "commit"
> rely on wt_status to produce the output).
>
>> I am not doing this myself soon, though.  Hint, hint...
>
> Me either, though it all seems like a sensible direction to me.
