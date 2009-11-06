From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Thu, 05 Nov 2009 16:45:24 -0800
Message-ID: <7v8wek7a6z.fsf@alter.siamese.dyndns.org>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
 <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
 <1257295737457-3942366.post@n2.nabble.com>
 <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
 <1257315478920-3943388.post@n2.nabble.com>
 <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com>
 <20091104072709.GC24263@coredump.intra.peff.net>
 <7vhbtai2uy.fsf@alter.siamese.dyndns.org>
 <20091105074808.GA12114@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6CxX-0001Cm-Om
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759230AbZKFApf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 19:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759221AbZKFApf
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:45:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759211AbZKFApe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:45:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46D6E93C6E;
	Thu,  5 Nov 2009 19:45:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QqzS5UJJHfK3W4gLr6YBd8PVuz4=; b=O66ZJ8
	rGzxJ+iVUCmoeGmk9XXm/LrGit/zxwir15zMetXribJqZdncAdCsC+vdcTe7ybeL
	N2+0Mom5gr2aZysoERYKf0tzkMzrFQb0QqooiZGNDUSL5rhlepusNDhdaHYIzktv
	OvebNp9dzUQSkdhpg2INlQpPwDfQ7iqrfxwDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iA40gR+FEhn8O4X2wd/biYVQbIdx14hw
	63N38K1qeGfPezKXkLq/jE9j0HDhEDlY9vUcZZZKx38PMJShbKvyYjMWIKwpIEUq
	pkCis0fAEhFMUKEUlPNAEvgs1AJRFAf3ACbo+o/LwbaJ5wbFLrfDux2FpJBv23hO
	6RYB+Ppb1so=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EFB793C6D;
	Thu,  5 Nov 2009 19:45:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD39993C6A; Thu,  5 Nov 2009
 19:45:26 -0500 (EST)
In-Reply-To: <20091105074808.GA12114@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 5 Nov 2009 02\:48\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1C19E6C-CA6D-11DE-9F46-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132263>

Jeff King <peff@peff.net> writes:

>> Isn't it quite different?  What's in 'next' for 1.7.0 is to guess the
>> user's intention when:
>
> Sorry, yes, I just saw Sverre's comment and misread the original
> proposal.  Checking out "$remote/$branch" will still detach the HEAD,
> and I don't think anybody has a previous proposal to change that.

Heh, I think both of us forgot that we decided it is safe enough not to
wait for 1.7.0 already, because the situation this kicks in has always
resulted in an error.  We have it in master since e3de372 (Merge branch
'jc/checkout-auto-track', 2009-10-30).
