From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix spelling of "occurred"
Date: Fri, 10 Jun 2016 14:15:58 -0700
Message-ID: <xmqqd1noeodt.fsf@gitster.mtv.corp.google.com>
References: <CAFZEwPMgYCau=LxdtjZ2WVJXp91mXYG5bc=0X0mo_eJ+eYqLHA@mail.gmail.com>
	<1465585526-32187-1-git-send-email-peter@colberg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Peter Colberg <peter@colberg.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 23:16:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBTmi-0000Q7-Vt
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 23:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbcFJVQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 17:16:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752133AbcFJVQD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 17:16:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C74724819;
	Fri, 10 Jun 2016 17:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rmJRiB8ZKKSXiCPerWln+XJO8RQ=; b=RWGh0q
	ZKZhZyLzG/wDZ5EqHN3cdMzt5T3TMj0TM+TKHAP4g4H0EkkTfB8Ap3QtxQnO/WvP
	+T7/ilaPy5bgceN3VkvbDlKo5FN15BOwQaLoxdTRitcAnSHbF1T3k9EuBV/kCt9U
	wWIa+qUwRJTGgfklDMVkd57K55YfiyughRLTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trBCf+1SLTie5aZFZQFeaftYY/Vo1jvj
	otvMbij6/Q+kOrqFBmg4GpVNz2M4xGtBzoKDlarb99Pkub6JzTSmQC/bfDpuwV7H
	2a/YcYnfR2QxPNkQ/8Huaqc9q9SJvoQxJZ1r0hvt6oIl3Fs5wnwjRwF3WBGc0UhN
	XerDjAGC0c8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EFC224818;
	Fri, 10 Jun 2016 17:16:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAF0B24817;
	Fri, 10 Jun 2016 17:15:59 -0400 (EDT)
In-Reply-To: <1465585526-32187-1-git-send-email-peter@colberg.org> (Peter
	Colberg's message of "Fri, 10 Jun 2016 15:05:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8787CF6E-2F50-11E6-B392-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297076>

Peter Colberg <peter@colberg.org> writes:

> Signed-off-by: Peter Colberg <peter@colberg.org>
> ---
>  config.c | 2 +-
>  refs.h   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index f51c56b..d7ce34b 100644
> --- a/config.c
> +++ b/config.c
> @@ -1281,7 +1281,7 @@ static void git_config_raw(config_fn_t fn, void *data)
>  		 * something went really wrong and we should stop
>  		 * immediately.
>  		 */
> -		die(_("unknown error occured while reading the configuration files"));
> +		die(_("unknown error occurred while reading the configuration files"));
>  }

For this one, I am tempted to say that it may be better to remove
the verb altogether, which would lead to a more concise error
message.

In any case, we need to postpone this until the next cycle, as it is
too late to change message strings now, as it would leave no time
for i18n/l10n team to adjust their work.

The other patch to the comment could be taken now if we wanted to,
though.

Thanks.

>  static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
> diff --git a/refs.h b/refs.h
> index 9230d47..56089d5 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -345,7 +345,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>   *     msg -- a message describing the change (for the reflog).
>   *
>   *     err -- a strbuf for receiving a description of any error that
> - *         might have occured.
> + *         might have occurred.
>   *
>   * The functions make internal copies of refname and msg, so the
>   * caller retains ownership of these parameters.
