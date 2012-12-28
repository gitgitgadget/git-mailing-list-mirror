From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lockless Refs?
Date: Fri, 28 Dec 2012 09:15:52 -0800
Message-ID: <7vhan6jdx3.fsf@alter.siamese.dyndns.org>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <50DAB447.8000101@alum.mit.edu> <201212271611.52203.mfick@codeaurora.org>
 <201212280750.14695.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Shawn Pearce <sop@google.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 18:16:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TodXd-0005Zi-6A
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 18:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab2L1RP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 12:15:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693Ab2L1RP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 12:15:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3545AA507;
	Fri, 28 Dec 2012 12:15:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kcJvg7PY3BRv4UiMS9zONX+30vs=; b=Oy0T3h
	mi0/gQzg7jnulIHoQKSdONKnQTOFkN9rFWE8TEnnJQHbhFo+73TTrNRyFVQKe06R
	v2SGnjiDSxZirlPSm/K3o05MNiS1Xju+ItnSYj5YlPDh3KAlGYaiP76bZmoeomqW
	6q6X+0BVt/hsVdhBv7ta9Oi1aN6REeMvSEwO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pkOgh5CBzvhCVUGVCjzjZA1M9cGF9MdT
	yiKuG9e0kec1047Rbem+U9DFUbH0s5NTaPIIQxRinBdvLjSViP2rI15LFi3vFrBH
	2tPv5RGXaUzMPu0UsTj1WlNQ2n7rzzmgd1ZFsiLzaW9dLBb9yA7Gl4OWdhLC1vKV
	fb66bUhVopk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20BD5A506;
	Fri, 28 Dec 2012 12:15:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E2ECA503; Fri, 28 Dec 2012
 12:15:53 -0500 (EST)
In-Reply-To: <201212280750.14695.mfick@codeaurora.org> (Martin Fick's message
 of "Fri, 28 Dec 2012 07:50:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C35246E-5112-11E2-ACEC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212247>

Martin Fick <mfick@codeaurora.org> writes:

> Hmm, actually I believe that with a small modification to the 
> semantics described here it would be possible to make multi 
> repo/branch commits work....
>
> Shawn talked about adding multi repo/branch transaction 
> semantics to jgit, this might be something that git wants to 
> support also at some point?

Shawn may have talked about it and you may have listened to it, but
others wouldn't have any idea what kind of "multi repo/branch
transaction" you are talking about.  Is it about "I want to push
this ref to that repo and push this other ref to that other repo",
in what situation will it be used/useful, what are the failure
modes, what are failure tolerances by the expected use cases, ...?

Care to explain?
