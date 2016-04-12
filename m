From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ident: make the useConfigOnly error messages more informative
Date: Tue, 12 Apr 2016 16:19:30 -0700
Message-ID: <xmqq37qqo1od.fsf@gitster.mtv.corp.google.com>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
	<1459366183-15451-2-git-send-email-redneb@gmx.com>
	<xmqqlh4zr492.fsf@gitster.mtv.corp.google.com>
	<20160330232552.GA31861@zeno>
	<xmqqmvpdgf4n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marios Titas <redneb@gmx.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:19:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7at-0000em-5m
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbcDLXTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:19:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934186AbcDLXTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:19:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2127F55011;
	Tue, 12 Apr 2016 19:19:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dLJxM6q+QBxJDymkDKEHvalmvqo=; b=T/YPF8
	vXP2DMUpCIM+U3C4BU1lZMc8KZcMfI6U3Mf1JgsCqOA4bUKLSR400Hx5b8lzxRVC
	WXjFDE7X/OgfU/YjlJhZMWvaZlsIQHXj99xmS7O9YHAyWLTp3mfE5H9BI6zNvqhh
	87JmdPL8Onogk/QbfzOMlie2ES/qTsvf6TdMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w06EGIduSvOOihNTyIN0aRDh/frONUw/
	oUjLiipoERztH3vGJ2lOZhu9g10KAr2YtHjMK67OsmfNxJT2zIXX4b3fu/C8eL09
	EKeeMZgdPtdXkVJhd9JgSUfGIM8vJwBlTm3eNE8zY78J86IC6pTOvajKLnQXKei9
	L7DIlcdK3Io=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A28755010;
	Tue, 12 Apr 2016 19:19:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9419C5500C;
	Tue, 12 Apr 2016 19:19:31 -0400 (EDT)
In-Reply-To: <xmqqmvpdgf4n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Apr 2016 15:04:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02E17A40-0105-11E6-9358-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291322>

Junio C Hamano <gitster@pobox.com> writes:

> Marios Titas <redneb@gmx.com> writes:
>
>> Yeah, maybe informative is not the right word. What I meant is that it
>> directs the user to do the "git config user.name" thing, which is
>> likely the most appropriate course of action in this situation. In any
>> event, I think printing the env_hint message would be really helpful
>> in this case.
>
> OK, let's do this, then.
>
> Thanks.

A friendly ping asking for an Ack.

> -- >8 --
> From: Marios Titas <redneb@gmx.com>
> Date: Wed, 30 Mar 2016 22:29:43 +0300
> Subject: [PATCH] ident: give "please tell me" message upon useConfigOnly error
>
> The env_hint message applies perfectly to the case when
> user.useConfigOnly is set and at least one of the user.name and the
> user.email are not provided.
>
> Additionally, use a less descriptive error message to discourage
> users from disabling user.useConfigOnly configuration variable to
> work around this error condition.  We want to encourage them to set
> user.name or user.email instead.
>
> Signed-off-by: Marios Titas <redneb@gmx.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ident.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index b2521ff..c766127 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -352,8 +352,10 @@ const char *fmt_ident(const char *name, const char *email,
>  		int using_default = 0;
>  		if (!name) {
>  			if (strict && ident_use_config_only
> -			    && !(ident_config_given & IDENT_NAME_GIVEN))
> -				die("user.useConfigOnly set but no name given");
> +			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
> +				fputs(env_hint, stderr);
> +				die("no name was given and auto-detection is disabled");
> +			}
>  			name = ident_default_name();
>  			using_default = 1;
>  			if (strict && default_name_is_bogus) {
> @@ -375,8 +377,10 @@ const char *fmt_ident(const char *name, const char *email,
>  
>  	if (!email) {
>  		if (strict && ident_use_config_only
> -		    && !(ident_config_given & IDENT_MAIL_GIVEN))
> -			die("user.useConfigOnly set but no mail given");
> +		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
> +			fputs(env_hint, stderr);
> +			die("no email was given and auto-detection is disabled");
> +		}
>  		email = ident_default_email();
>  		if (strict && default_email_is_bogus) {
>  			fputs(env_hint, stderr);
