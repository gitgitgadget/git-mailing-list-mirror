From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: workaround zsh COMPREPLY bug
Date: Thu, 26 Jan 2012 14:00:05 -0800
Message-ID: <7v4nvi2kgq.fsf@alter.siamese.dyndns.org>
References: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@imag.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 23:00:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqXMf-0002Qn-EC
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 23:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab2AZWAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 17:00:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712Ab2AZWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 17:00:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C703A744A;
	Thu, 26 Jan 2012 17:00:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EslchZLuSUuQVdfMpW91l2VbEO4=; b=vt1UqF
	l6Y2gF64MPRH18XzccwvI7R91iI1fZhjVujeTRA1hkT6rs572pJcT3aF7lpMVryC
	7kLoHk+ykaVWp1vTHoDaloCO8ubjjRcTZHzFoOhj7BPhLGYjmqQSGTswR90ObiHw
	8KRbRfC+Ar5hz9+mHxe10gq0Q+WCXf+AWyxb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1EuqyONGaKB/Ys5Qaba1d4SNj/1ZMIT
	eB1IMrKL4xZ65VB1l6PT1JfDhmst/XVlHj8s5G4XUW+npDKcqV5PPXE/606HO0ja
	24xrAUb9eq3v+pHI8EzYlTfchH5oekoGAbcbc4hyQluwcrX5+HyCYsMInphNQsnm
	mVB4zOBclJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD42B7449;
	Thu, 26 Jan 2012 17:00:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26B537445; Thu, 26 Jan 2012
 17:00:07 -0500 (EST)
In-Reply-To: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Wed, 25 Jan 2012 03:37:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BD65218-4869-11E1-9C60-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189166>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> zsh adds a backslash (foo\ ) for each item in the COMPREPLY array if IFS
> doesn't contain spaces. This issue has been reported[1], but there is no
> solution yet.
> ...
> Once zsh is fixed, we should conditionally disable this workaround to
> have the same benefits as bash users.
>
> [1] http://www.zsh.org/mla/workers/2012/msg00053.html
> [2] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=commitdiff;h=2e25dfb8fd38dbef0a306282ffab1d343ce3ad8d

That 2e25dfb8 only says:

    Rocky Bernstein: 29135 (plus tweaks): compgen -W in bash completion

without any explanation, which is not very useful.

Do you have a bug tracker ID or something for [1] above, with which I can
amend the patch as Matthieu suggests?
