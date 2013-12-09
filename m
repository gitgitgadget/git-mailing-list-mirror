From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] abspath: trivial style fix
Date: Mon, 09 Dec 2013 13:24:04 -0800
Message-ID: <xmqqeh5lwwej.fsf@gitster.dls.corp.google.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
	<1386482220-18558-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:24:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8JK-0001dY-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab3LIVYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:24:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab3LIVYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:24:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7483359988;
	Mon,  9 Dec 2013 16:24:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F6wzHB+C0fmjOeZe7pFB5/Omb4M=; b=fJxU/t
	/A9FMCIpbKPF1lp/G5ggWBC41u0bhM4kU9oUxEijn+miSACLNMlAItH7W5T9jzhg
	T4V+h/416Kyca9WjQlCKUASNIzU7yRP8QJc+ANlY6RAeuUM30YcWXbaZBjYyKrPQ
	CFvv7EWajIKtJPt4tbARpckuHp/DcK9jszQHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzs5CAS7aqW6MvU5M4YD0DQQQmBMQPPj
	mI11lkE7Zb2qJAGJ+PRDqUPC3Nd34p4oke56ILHqt1OupU82coSd8GWOPu7eqbND
	/grBPx/FIcU5AH/BVaLEpt9yohuGgE55/zMfUaOypxSyJApVlXWZXKIZF84U8ZdZ
	MkbMFnissLE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A58259987;
	Mon,  9 Dec 2013 16:24:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44B0359986;
	Mon,  9 Dec 2013 16:24:07 -0500 (EST)
In-Reply-To: <1386482220-18558-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 7 Dec 2013 23:56:56 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3C79E5A6-6118-11E3-8759-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239107>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  abspath.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/abspath.c b/abspath.c
> index e390994..8b3385a 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -143,7 +143,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
>  error_out:
>  	free(last_elem);
>  	if (*cwd && chdir(cwd))
> -		die_errno ("Could not change back to '%s'", cwd);
> +		die_errno("Could not change back to '%s'", cwd);

Will queue; thanks.

By the way, there are quite a few hits from

	git grep -e '\(die\|error\|warning\) (' -- \*.c

even if we ignore borrowed code that we do not want to touch up with
this kind of change.  Some may have overlapping changes in flight
that makes it better to leave them as they are for now, but some are
in reasonably quiescent areas.
