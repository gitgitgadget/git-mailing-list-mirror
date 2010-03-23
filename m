From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 09:44:43 -0700
Message-ID: <7vtys72dj8.fsf@alter.siamese.dyndns.org>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
 <1269353235.14299.0.camel@kheops>
 <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
 <1269354326.14299.7.camel@kheops>
 <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sylvain@abstraction.fr, git@vger.kernel.org,
	howard@e-learndesign.co.uk
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 17:45:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu7E6-0002tX-U3
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 17:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab0CWQo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 12:44:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0CWQo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 12:44:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80920A46B7;
	Tue, 23 Mar 2010 12:44:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=thfWlvcKqjOb48YAl3zgPtjLQrw=; b=weA6V6
	saiQ5/vlK7RP+XvWtgK5EQ1lnp0wTubgKkIsRcWLgfYcwrAdL3eJZ9SpAsW4QbCx
	FHGQMcNkvoH+dhu7IYzGKFWRIUIOTkR3/yBY8+/Ow9N6SDqwKMFGObTe17isBc/n
	K1+eYG/6qFQYVD1sVaOcbvr1RoXTIayMDHuds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vj31oPybTPI0XVAajYTsE47l9bJIYYt+
	VmvLrqO6CiacptvEcdNTCznFy5MKSFGckUssG0PoyU1ttoYHxOCoDkj0eM1vMH/R
	ZkLanqFqKIev3vb+mqbNfu2Taop5D6eBTwCEwvb0/jxJNXSA2VNhNGnOqXFFCWj6
	YrfDijQYs8g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2C31A46B1;
	Tue, 23 Mar 2010 12:44:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE02CA4678; Tue, 23 Mar
 2010 12:44:44 -0400 (EDT)
In-Reply-To: <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com>
 (Scott Chacon's message of "Tue\, 23 Mar 2010 09\:05\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 659CD0DE-369B-11DF-9E65-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143030>

Scott Chacon <schacon@gmail.com> writes:

> Why would we teach someone to do that instead of just recommending the
> far less obscure 'git push -f'?  A leading '+' on the refspec is
> ridiculously confusing compared to "just tell it to force the push
> with -f".  Am I forgetting something?

I think "-f" would be simpler and easier for people who use only one
branch, as there is no "I want to disable only for this branch but still
want other branches checked" problem in such a case.

Once they graduate from that and start using more than one branches, "-f"
is too broad a brush that disables the check for everything you push out,
and you would want to teach "+" as a way to narrow the possible damage.

"git push -f origin this_branch_only" can be used to limit the risk, but
if they start from a short-and-lazy "git push -f" without arguments, their
finger would have harder time to learn it.  There is no such learning
curve issue for "+", as you cannot use it without saying for which branch
to disable the check.
