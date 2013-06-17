From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! push: switch default from "matching" to "simple"
Date: Mon, 17 Jun 2013 12:40:24 -0700
Message-ID: <7vhagwcyqf.fsf@alter.siamese.dyndns.org>
References: <1371492079-19283-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 21:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UofI0-00019X-8G
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 21:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab3FQTk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:40:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584Ab3FQTk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:40:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F43228ADF;
	Mon, 17 Jun 2013 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SyJjXf+EIRR/lSjrqqQ/gNJ0QR4=; b=JdLj9c
	slpcLht7mkmtOe0SUlUvRx6wJJXMPS7++Td6mXXctOasiQzGpbyDUPJWbgmnGPGQ
	aZEfZ6MYe8mtYXdbFwpgrez+knCSrI3h8JghCRISY+3VZtXYoD2zIOhWP6xdSUDJ
	IpiqXXVdJRBWOrORPGBVGMdWnYirZ3M/8dOg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJnt6XZ+Ozy9h5WTMR0G3+NpbAt218+f
	X/tbl1qpGTiQXjAsOt2yCQtCRydJHilZIFlMsWNuk7DsNHdUq1dlfzVmLDVzajPz
	bK1SED54HFP6iuVa26w8q9P3THAsyCdLFxww9EJk55G0tkhlZOfALzlYGMloEA7O
	qA+h4NyluD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03CA528ADE;
	Mon, 17 Jun 2013 19:40:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CD8E28ADC;
	Mon, 17 Jun 2013 19:40:26 +0000 (UTC)
In-Reply-To: <1371492079-19283-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 17 Jun 2013 20:01:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C23C2A90-D785-11E2-854F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228104>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This is to be squashed into jc/push-2.0-default-to-simple
>
> (Noticed while writing the other patch about --force)

Thanks.

Note that this has to further change if Ram's triangular push fix
comes before 2.0.

I am not sure if these original two lines are necessary.  Wouldn't
it more appropriate to just drop the "Without additional configuration"
and go straight to "The default behaviour of this command..."?

>  Documentation/git-push.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 9b9e7d1..81b875b 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -381,8 +381,10 @@ Examples
>  	configured for the current branch).
>  
>  `git push origin`::
> -	Without additional configuration, works like
> -	`git push origin :`.
> +	Without additional configuration, pushes the current branch to
> +	the configured upstream (`remote.origin.merge` configuration
> +	variable) if it has the same name as the current branch, and
> +	errors out without pushing otherwise.
>  +
>  The default behavior of this command when no <refspec> is given can be
>  configured by setting the `push` option of the remote, or the `push.default`
