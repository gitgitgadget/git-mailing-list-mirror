From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: warn about 'branch name' rather than 'local
 branch'
Date: Fri, 29 Jan 2010 13:42:44 -0800
Message-ID: <7vvdekh9kb.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com>
 <1264799342-11093-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:43:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaycH-0006vH-15
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab0A2Vm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209Ab0A2Vmz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:42:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab0A2Vmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:42:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6FEA95D3B;
	Fri, 29 Jan 2010 16:42:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oFipT+lW3spUxnWlgJKuyVQRtiU=; b=Wzob2x
	teF+UFT7Y5/k2X4ZNw14UbLJ1vtYnzyHZifwFyAIW4v33YJWrgpwYvPNlKPa8/Ke
	1hd40FWeknaiVc8qJO4CC405I8SsgODHqTk28clkCy1a8NAikFV6XR78ACQT5Vid
	TQ8+pJFsSXFDjhymzL9U1hQ35qfGh5aotXNu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wy8hpxormEHhCQ8gGLyVcYIdqZWolE3k
	/mGbGM+QbceVoIMqXH5ISzoZqd1pcwANs4EkyB2xb5lge2GkCs7mKxYMOgDb9YRH
	0uRPSSfcNHR9SX08gR2A0rA1bqYE1oLiZfDzMMcWcwietF6LHSM/Kqdgfr9lm0to
	FRAo5N+HT/o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82E4595D37;
	Fri, 29 Jan 2010 16:42:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9796C95D2D; Fri, 29 Jan
 2010 16:42:45 -0500 (EST)
In-Reply-To: <1264799342-11093-1-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Fri\, 29 Jan 2010 22\:09\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F82A874-0D1F-11DF-8B45-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138372>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> These days, you can say "git checkout topic" to automagically create
> a local "topic" branch that forks from "origin/topic" remote tracking
> branch when you have one, thanks to Dscho's UI improvement ideas. As
> such it is more appropriate to say that the user is checking out
> something that is not a branch name, rather than saying it is not a
> 'local branch'.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
>   Junio, I used part of your reply as the commit message, is that ok?
>
>   Only change is s/local branch/branch name/.

I explained why I think that is not solving the real problem.  To a user
faced with an unexpected detached HEAD situation, it is not very important
to explain how we were forced to detach (i.e. because you didn't tell me
to switch to a branch).
