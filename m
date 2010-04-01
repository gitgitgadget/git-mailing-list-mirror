From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 31 Mar 2010 21:52:52 -0700
Message-ID: <7vd3yjsriz.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de> <4BA104C7.5020207@web.de>
 <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
 <7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de>
 <32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com>
 <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
 <4BA3329E.6050304@web.de> <4BB21F6D.7070804@web.de>
 <7vd3ylv4oq.fsf@alter.siamese.dyndns.org>
 <p2nf3271551003302058ve6b54731h1bea42b5c6605928@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Michael Witten <mfwitten@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 06:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxCP4-0003w7-8L
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 06:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab0DAExI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 00:53:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0DAExF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 00:53:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7857BA70B0;
	Thu,  1 Apr 2010 00:53:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=g6ZfT2ay7fYOUQ28iSgVjGEsXD4=; b=EjdxtL3AoGyAsLQl6mDnYiJ
	Ba9MdjN544a80TE/GSkesuVeRRoQ2mcA8dOm7xntMWVDO2jsvZoMJG2eyNmAJU9U
	7qoL+MA4dE8jQRTcB0KXJOf7w90CYAJYRvHHjy2gElIFXfyUdfWIHkZvGUbOOjuM
	/cZ5RSf5xheQ747/o4n8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hHo1Vk9MbQsDDEmKIRFqo39xrgfwO3Botq+olfQdLAUWtJieO
	RR8AGTaQqYFP/0BgsX20x2Cy9yInY7v2m561SLKvpaou5i73SChHRQvHFgA/zi2C
	bAvit/9c4vy5jA97ioA7w5VA+3ORMj6TSsjW/2VLAscif6ieRjkAaTFx2U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AED6A70AE;
	Thu,  1 Apr 2010 00:53:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C8EFA70AD; Thu,  1 Apr
 2010 00:52:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7273E6AC-3D4A-11DF-A05A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143707>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> On Wed, Mar 31, 2010 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +such a case, you may want retry the command after recording the local
>> +changes (1) in a temporary commit on the current branch, or (2) by using
>> +"git stash". Alternatively, use "-m" option to force a merge.
>
> Couple of things: Is (1) really an option?

Of course; otherwise I wouldn't have written it, but another option (0)
would be:

    (0) if you are in the middle of working something for the current
    branch, finish it first before switching to other task.

But that would go without saying.

> The user will have to go
> through documentation on rewriting history, which I find completely
> unnecessary to just switch branches.

I think you are thinking backwards.  If the user always does a perfect job
before making each and every commit, she doesn't ever need to learn
"amend".  Otherwise, she will learn "amend" way before learning to switch
between branches to work on different things at the same time.

IOW, by the time the user learns branch switching, I expect she at least
knows about "amend" (if not rebase-i/filter-branch), and that is all that
is necessary to restart from a WIP commit when she comes back.
