From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Thu, 13 Nov 2014 23:49:16 -0800
Message-ID: <xmqq1tp643yb.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	<xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
	<xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
	<xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
	<xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 08:49:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpBdK-0002oD-PD
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 08:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbaKNHtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 02:49:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754394AbaKNHtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 02:49:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF2EC11AB1;
	Fri, 14 Nov 2014 02:49:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T8W4d2di0dZg8Bud9acKBgUjxM8=; b=cFlxzM
	IvmmbOSldmXSFSel+/kQKiy2lvYG91//EF9edfk539nHlGr9cafKEpKPjt4iGPB6
	vaoEeNryj4pNhXTxR0eNUvkIqBnwg8N7HybHF5b8ubZNK8q5yXiQ5LA3ch8IfhLZ
	jzkMMrWmaBH7ZDvomLuiZFz4ypmeNOtjV4rvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tRvRx/WWDoJEDLe9K9SQf409Tmvg06gC
	p18qqZ/tU7hhNPpVIYBTMHzJ7q8DCPQoj7nqkvJNa7lT7t8Tt/Pa5c+IEbjnPdwq
	UTOT3pSFZtasDxG6XfZBosK3ga4/OMXHlfakxkTj/tdj7EXZtNRNM/kRFPirIowL
	oLD8Ip3ABc4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C44C411AAF;
	Fri, 14 Nov 2014 02:49:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C84611AAD;
	Fri, 14 Nov 2014 02:49:17 -0500 (EST)
In-Reply-To: <xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Nov 2014 13:06:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC3143DC-6BD2-11E4-A773-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I agree that a new value "mergeInstead" or something should be
>> invented when/if different workflows want a looser semantics.
>> People would rely not only on "being able to push when clean" but
>> also on "being safely prevented from pushing when not" (and that is
>> where my earlier comment to test both sides comes from).  Loosening
>> the check to an existing "updateInstead" would break users who have
>> been using updateInstead.
>
> And thinking about the names again, I have a feeling that
> updateInstead and mergeInstead are both probably misnomer.

Let me take this part back.  After all, I do not think I would
design the mechanism to implement an alternative logic that decides
when it is safe to allow the update of the ref and to reflect the
changes to the working tree, and that actually does the checkout to
the working tree by using a new value like mergeInstead.  So we
would only need a single name, and updateInstead is not too bad.

The word "update" is so heavily loaded in the context of accepting a
push (i.e. it is unclear what update we are talking about---updating
the ref that we normally refuse to update?  updating the index?
updating the working tree?  Some combination of them?), so as a
single word, "checkoutInstead" may probably be a better one, though.
Upon hearing "checkout", by definition anybody would know that we
are involving the working tree.

The mechanism I would employ when doing an alternative logic,
possibly looser one but does not necessarily so, would be to have a
hook script "push-to-checkout".  When denyCurrentBranch is set to
updateInstead, if there is no such hook, the "working tree has to be
absolutely clean and we would do a 'read-tree -m -u $old $new'
(which is the same as 'reset --hard $new' under the precondition)"
you implemented will be used as the "logic that decides when it is
safe, and that does the checkout to the working tree".  When the
"push-to-checkout" hook exists, however, we just invoke that hook
with $new as argument, and it can decide when it is safe in whatever
way it chooses to, and it can checkout the $new to the working tree
in whatever way it wants.  The users of "mergeInstead" (now a dead
and unnecessary name) mode would just have a single-liner

	#!/bin/sh
	git reset --keep "$1" --

in there, as this single command would both decide when it is safe
and does the safe (according to its own definition) updating of the
working tree.

In your other example (not the "deploy to live website" one) of
unidirectional SSH connection, you would be able to connect from
machine A to machine B but not the other way, so while sitting on
machine A you would typically have one SSH session to have an
interactive shell session running on machine B.  You may have local
modification on machine B but your changes to history on machine A
cannot be pulled, so you would emulate it by pushing from A into B.
In such a case, unlike the "live website" example, it would be
useful to loosen the condition even more than "reset --keep" (which
is an equivalent of "checkout -B $current_branch $new_commit").

In such a case, what you want to do is to simulate "git pull" that
could conflict and give you a chance to resolve with a push in the
reverse direction.  You want to run an equivalent of the same
"checkout -B" command but with the "-m" option when accepting such a
push.

There are other definitions of what is safe and how update should
happen depending on the user, and such a logic can be placed in the
push-to-checkout hook without harming other users.
