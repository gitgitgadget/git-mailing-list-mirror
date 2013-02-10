From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/15] user-manual: Use git branch --merged
Date: Sun, 10 Feb 2013 13:37:01 -0800
Message-ID: <7v4nhju9z6.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <c8abf7a75a59302e6bdc66eee13eb2ec53b26b46.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4eac-0004p2-0T
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab3BJVhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:37:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755786Ab3BJVhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:37:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7B38BB36;
	Sun, 10 Feb 2013 16:37:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nSWTQG2tXr1p2JxWgJ70RboMq0E=; b=hq48T1
	NYlaCPxWNhG0J/OCLQVm7ZJFC34NiaISL2XF1LIHSN+ty6jyZ0oNW7x77medw0+E
	fJS+/arfOAUcw+8E51QcMeZiGYOqpFwX6HjiKaJYowqbfEQDBANt+ipc3hMvy4Fq
	LeykU07Q6FtjDkrFl2f8nUZa3zqx2mVGInjRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FU8ojcuRydGyQImPW1SMN5HokKkx4t7N
	IM7U3jI6l3AJEcyeOao10WD/RV7FGfVKbSzmXTwermtXIgTnojYMbcTixeDic6Py
	JOAOtM16t1Hkgb+4cVnSDb9Ndg3BBRw4ArQKUnJ6tL3SZNQim4mQU+BFJJ+JOYG3
	nE2CWipAZYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E30CBB2F;
	Sun, 10 Feb 2013 16:37:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA4BDBB24; Sun, 10 Feb 2013
 16:37:03 -0500 (EST)
In-Reply-To: <c8abf7a75a59302e6bdc66eee13eb2ec53b26b46.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0294E14C-73CA-11E2-953E-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215938>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> Use 'git branch --merged origin'.  This feature was introduced by
> 049716b (branch --merged/--no-merged: allow specifying arbitrary
> commit, 2008-07-08), after the documentation that's being replaced
> moved into the manual with 9e2163ea (user-manual: move
> howto/using-topic-branches into manual, 2007-05-13).
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 53f73c3..a8f792d 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2267,10 +2267,10 @@ then pulled by Linus, and finally coming back into your local
>  You detect this when the output from:
>  
>  -------------------------------------------------
> -$ git log origin..branchname
> +$ git branch --merged origin
>  -------------------------------------------------
>  
> -is empty.  At this point the branch can be deleted:
> +lists the branch.  At this point the branch can be deleted:

This is making things much less useful.  "branch --merged origin"
will show 47 different branches that you are *not* interested in the
flow of examples in this part of the tutorial.

Also, log origin..branchname allows you to notice a situation where
some but not all of the branch was merged, too.
