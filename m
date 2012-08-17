From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Fri, 17 Aug 2012 10:40:35 -0700
Message-ID: <7vk3wxv2lo.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
 <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
 <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
 <7vipcj2w9f.fsf@alter.siamese.dyndns.org>
 <7vehn72vyl.fsf@alter.siamese.dyndns.org> <87pq6rw77l.fsf@thomas.inf.ethz.ch>
 <502CC4E7.5060508@alum.mit.edu> <87k3wzujuy.fsf@thomas.inf.ethz.ch>
 <7v628i3jiu.fsf@alter.siamese.dyndns.org> <874no1hnfg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:40:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2QXM-0007Fq-Up
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab2HQRkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:40:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab2HQRki (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:40:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3608C78F9;
	Fri, 17 Aug 2012 13:40:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2jtGmYuI8k0mhee9BQEn0Cmcpr0=; b=GgkOhI
	rH/UmIWNP28IsLDoFf73gSs9YpLsA9wBb7e00payl4gonlpxG5HnUh3zH1P8TCKW
	AAIt85lCZZKuo5t3MwF00WTr674gUV8rIierRAdOkPx6CaVnY1893ES7qgJ8gSvH
	07c8oomGO6J6CCiM7njxju0VFJn8NuPRQ+Sj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=upvQTPECYd0LDm8d0L4KvdE+ZcgFQbDL
	4/mCoyTiYFt5/bV5aO6DurUQv7+QX7BWFN+wgiopP4djpmZQo/PFgAJubsW4KsJ9
	VEQ7jbBxhlIyUrrUPXwR+ihpcgf1PO85twHRI0Kf/6n3YlNy9SoVHD7Mit8Atq8D
	Ac9aei1nL5I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2361078F8;
	Fri, 17 Aug 2012 13:40:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80FA178F7; Fri, 17 Aug 2012
 13:40:37 -0400 (EDT)
In-Reply-To: <874no1hnfg.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 17 Aug 2012 11:34:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7C4793E-E892-11E1-AB64-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203632>

Thomas Rast <trast@inf.ethz.ch> writes:

> I hope I got that right.  The order of commits is still entirely
> determined by the choice of "any tentative source", but the algorithm
> should now stream nicely once the generation numbers are known.

Thanks for an intereseting read.

Even though generation numbers are not always a good subsitute for
timestamps depending on the use (see the other message), the algorithm
to compute "topo-order" can take advantage of the generation numbers
when they are available, as you illustrated in your message.

We may want to think about adding a new field to the commit object,
with a fallback mechanism to an external "cache" that is generated
on-demand.

Once the mechanism is in place so that any caller of parse_commit()
can depend on having a reliable .generation field in the commit
object it receives from the function, we can start updating various
traversal algorithms to take advantage of this new information.
