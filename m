From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct the docs about GIT_SSH.
Date: Tue, 26 Mar 2013 07:52:19 -0700
Message-ID: <7v8v5ausbg.fsf@alter.siamese.dyndns.org>
References: <1363907200-12850-1-git-send-email-danfuzz@milk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Bornstein <danfuzz@milk.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 15:52:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKVF5-0002AS-9o
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 15:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759794Ab3CZOwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 10:52:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758311Ab3CZOwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 10:52:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EAE8A442;
	Tue, 26 Mar 2013 10:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bZ7bxqJ9TriS5wt0trETROn3u/Y=; b=qY7qcT
	+5opGdPHQwkH0Qs4VdkI9frAcpDb1onWDNF2QhaXxHALJDqP5HTAVnMSACGhJJFd
	7En64zdayx6duarMK+ktbxDvVoN39pA0zq2GIaLhypcYfvs5dFxPAE4DZ9274wJ7
	mg9GASMYny20EqGY3lmC6hrfmKGJesHS++yOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EqUUz//L5fWulnQx0Nuyd57Q/6ptk1WL
	0T+uwNaL/pCdK5Ez1O0b1GMSa8YXG+lAq/xQLJgeUBpwJ/mmcp+8IgYbIEsYgBS4
	s9m4pIZ9hbHlx1dCr1DdaIiUWh6Qjgj5kYtRH6tkaKrQcLmcmHhJ0kWR+I/QG8zM
	1jvuGtzdpBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03B63A441;
	Tue, 26 Mar 2013 10:52:22 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DC80A440; Tue, 26 Mar 2013
 10:52:21 -0400 (EDT)
In-Reply-To: <1363907200-12850-1-git-send-email-danfuzz@milk.com> (Dan
 Bornstein's message of "Thu, 21 Mar 2013 23:06:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3544644-9624-11E2-8BDE-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219160>

Dan Bornstein <danfuzz@milk.com> writes:

> In particular, it can get called with four arguments if you happen to
> be referring to a repo using the ssh:// scheme with a non-default port
> number.
>
> Signed-off-by: Dan Bornstein <danfuzz@milk.com>
> ---
>  Documentation/git.txt |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Looks good.  Thanks.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7efaa59..4307d62 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -774,9 +774,12 @@ other
>  	If this environment variable is set then 'git fetch'
>  	and 'git push' will use this command instead
>  	of 'ssh' when they need to connect to a remote system.
> -	The '$GIT_SSH' command will be given exactly two arguments:
> -	the 'username@host' (or just 'host') from the URL and the
> -	shell command to execute on that remote system.
> +	The '$GIT_SSH' command will be given exactly two or
> +	four arguments: the 'username@host' (or just 'host')
> +	from the URL and the shell command to execute on that
> +	remote system, optionally preceded by '-p' (literally) and
> +	the 'port' from the URL when it specifies something other
> +	than the default SSH port.
>  +
>  To pass options to the program that you want to list in GIT_SSH
>  you will need to wrap the program and options into a shell script,
