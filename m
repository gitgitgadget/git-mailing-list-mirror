From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] comment for a long #ifdef
Date: Mon, 04 Apr 2016 10:54:18 -0700
Message-ID: <xmqq4mbh5kfp.fsf@gitster.mtv.corp.google.com>
References: <5701BCC1.9050306@mail.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ivan Pozdeev <vano@mail.mipt.ru>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8hl-0000OX-D7
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbcDDRyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:54:21 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752058AbcDDRyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:54:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DCE84F94C;
	Mon,  4 Apr 2016 13:54:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YbaFXF60LYO6bMFb6Xezzu5iEic=; b=h5ieeH
	/+Z3K4uCIrhM4iRhD7VgvVip9PLrsYT5sg2Uv9UR5RnWeReQWFK8t+ThLJwWuh4I
	i6cklLQSBc+RX8ksPD4EgGEk0bBzYzEWUY8rQ+rOCIgLnZvWgJ6XAZ7pm0VmQWna
	4Cenwhm107PlI3FT91AawCH3rxV38/pAMEkTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cMIgIiImyiZ0Odm1SOQSvvQOtSOpG2pE
	QEyuhGgtuzUWhfH3T0GSpR7eSIcQ4DnjA4O9nmioYXQ3vS+N6K5gQ8UQ0LiAiel1
	U1y85axkQ41ZSqPmQ0widEEd3Nc3HXAZHErpIPAVimcEI+o0ys0Z8FhNc1GQItw6
	F0gSobCtjEE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04DD04F94B;
	Mon,  4 Apr 2016 13:54:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 76B524F948;
	Mon,  4 Apr 2016 13:54:19 -0400 (EDT)
In-Reply-To: <5701BCC1.9050306@mail.mipt.ru> (Ivan Pozdeev's message of "Mon,
	4 Apr 2016 04:00:49 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 41726242-FA8E-11E5-85D0-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290711>

Ivan Pozdeev <vano@mail.mipt.ru> writes:

> ---
> compat/poll/poll.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

As Eric pointed out, please sign-off your patch.

> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index db4e03e..5eb0280 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -441,7 +441,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
> }
>
> return rc;
> -#else
> +#else /* #ifndef WIN32_NATIVE */
> static struct timeval tv0;
> static HANDLE hEvent;
> WSANETWORKEVENTS ev;
> @@ -622,5 +622,5 @@ restart:
> }
>
> return rc;
> -#endif
> +#endif /* #ifndef WIN32_NATIVE */
> }
> -- 
> 1.9.5.msysgit.1

There also is an #ifndef/#else/#endif in abspath.c that is larger
than a typical patch context; could you include a fix for that, too?
