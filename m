From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git pull --rebase with strategy ours doesn't work (possibly bug)
Date: Mon, 13 Jun 2011 08:01:37 -0700
Message-ID: <7v8vt5rd0u.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=jLQf6Wp-qqYoy7kND2M1=WRyxXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry S. Kravtsov" <idkravitz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 17:01:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW8eG-0006dW-VL
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 17:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab1FMPBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 11:01:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab1FMPBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 11:01:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE9554447;
	Mon, 13 Jun 2011 11:03:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I7m44V+K/Sbo3cxYC/2v7rMEe2U=; b=fPg0Vd
	evtLdoUmT9XF1faU2p2osQ4+h/m0ymt8xNQhFj1T5cx1dYrutAmGaJDH20uZYSMg
	CZQ4fQi8BAioKu23Wvc3ql1oHQou9a+/cKiay2wTYH4aLUg0yecVuvSGCP3hAvf7
	5ZIY0T4J/XtVXrLrmWc7rVK2MkJ9MPHdfOywI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1u9cSiWc5X2la3gJQMAUYqv/9gIhoJ6
	S7WCiNCo/A+FS6DRfRABFIEReWIyfLJz3R0gi0SfkXRM7+dJgEJjwJqpabYDQT5Z
	e1e2Sw60G2Gmd2jMMHPn2LQ3snnpGfjUnu+Wt3fb7HN+qOyaUwU0OTuQRRBcoSv3
	DdZCewK5png=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F0D84445;
	Mon, 13 Jun 2011 11:03:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7AC174442; Mon, 13 Jun 2011
 11:03:49 -0400 (EDT)
In-Reply-To: <BANLkTi=jLQf6Wp-qqYoy7kND2M1=WRyxXg@mail.gmail.com> (Dmitry S.
 Kravtsov's message of "Mon, 13 Jun 2011 14:05:31 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59CE6F18-95CE-11E0-900A-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175711>

"Dmitry S. Kravtsov" <idkravitz@gmail.com> writes:

> and from git-rebase man page I read, that strategy ours allows us to
> discard conflicing changes in favor
> of ours.

That is not what the "ours" strategy is about. When merging another
history into our history, the strategy marks the other history "merged"
while using our tree as the result of the merge, without using _anything_
from their history.

It is not a way to take whatever that happen to merge cleanly textually
but use our change in only the conflicting parts.  You are probably
confusing it with 'ours' option of the recursive strategy, that is used in
"git merge -Xours".
