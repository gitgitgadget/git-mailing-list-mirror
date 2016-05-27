From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add instructions to help setup gmail 2FA
Date: Fri, 27 May 2016 14:06:57 -0700
Message-ID: <xmqqpos7p5vy.fsf@gitster.mtv.corp.google.com>
References: <1464381597-27634-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 23:07:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6OyM-0003kE-DR
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 23:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbcE0VHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 17:07:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756506AbcE0VHB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 17:07:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFFC71FBBA;
	Fri, 27 May 2016 17:06:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UWfbtmpMc7zOIUY2lsHp5g6jnJM=; b=LeTqkX
	BOFwX/OCJqQjd0NG+OzuwJN2TOIxdwLOVICtwJ1Zwf8WxAMx10ZjaNM64VZQgunV
	E/8w3N45YzASNit8vxoh6RH8HdLle2NmOcawWdZSb+j209BJhu6TD7VvqJpLu9xC
	3vtE1R9fdMilzCnOHpiKnJQZRS3v0sMZmoaTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nz3Gt/yJvg9teEoK45krHtlc673Pr0KI
	p/fhASk1OMJ7z6Vo917pVh8jgGL2CgamllmpdIaSrJWI941OJ1jmefTYfLzxCbZj
	4BnmwFfbhUgoS8n+gGm2ZwakcIvuHXakULhTbeK+L/sS5VFURc9p47PLBtefghkE
	IJrTEyF/4oc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8FA51FBB9;
	Fri, 27 May 2016 17:06:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6867D1FBB8;
	Fri, 27 May 2016 17:06:59 -0400 (EDT)
In-Reply-To: <1464381597-27634-1-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 27 May 2016 16:39:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F39A346A-244E-11E6-A0DB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295796>

Michael Rappazzo <rappazzo@gmail.com> writes:

> For those who use two-factor authentication with gmail, git-send-email
> will not work unless it is setup with an app-specific password. The
> example for setting up git-send-email for use with gmail will now
> include information on generating and storing the app-specific password.
> ---

Sounds good.  We'd need your sign-off in order to be able to use
this patch, though.

>  Documentation/git-send-email.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 771a7b5..edbba3a 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -450,6 +450,19 @@ edit ~/.gitconfig to specify your account settings:
>  		smtpUser = yourname@gmail.com
>  		smtpServerPort = 587
>  
> +If you have multifactor authentication setup on your gmail acocunt, you will
> +need to generate an app-specific password for use with 'git send-email'. Visit
> +https://security.google.com/settings/security/apppasswords to setup an
> +app-specific password.  Once setup, you can store it with the credentials
> +helper:
> +
> +	$ git credential fill
> +	protocol=smtp
> +	host=smtp.gmail.com
> +	username=youname@gmail.com
> +	password=app-password
> +
> +
>  Once your commits are ready to be sent to the mailing list, run the
>  following commands:
