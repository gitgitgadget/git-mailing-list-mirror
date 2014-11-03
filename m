From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 11:02:42 -0800
Message-ID: <xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMuH-0001m8-UL
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbaKCTDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:03:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753456AbaKCTCw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6214F1BDF7;
	Mon,  3 Nov 2014 14:02:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QMm7yH0iA96BxIoXQCszniWyu0I=; b=t8h7Pe
	ziIEWFXI88o1uIGGXIbxLP791T9MOjOxCC2QEcFqUiuqDCRrPulnoIgptW/9HKpR
	q3iQY7foCu864qxylP9HX8sV8DGCZ/8yAXnBjHjFy084TzUJz7HefQs74jRSDt8E
	W6wE6gDS4iN8TsJ6cb8AK5FHehvk136XNTveM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f9Rqzqg6Zq+B3OAKstgE42rwhvBR6MYg
	fxJ+5/YUwRjuB5935gAuo/S6LsKRgN9KcEyTEfcSML+IlNqhe3qkd0D4b80rtP0Q
	PDFyL6S/TQkdUla8pXxMQiHKJPeZHWm5QdetmIYtvCszpC7aYZi7DdePIbmr82pB
	TEkct00hN5A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 594AB1BDF1;
	Mon,  3 Nov 2014 14:02:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC9601BDEF;
	Mon,  3 Nov 2014 14:02:44 -0500 (EST)
In-Reply-To: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz> (Michal
	Sojka's message of "Mon, 3 Nov 2014 11:09:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE727EFE-638B-11E4-AC4E-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> The documentation says that submodule.$name.update can be overridden by
> --checkout only if its value is `none`. This is not true, because both
> implementation and documentation of --checkout specifies that the
> override applies to all possible values.
>
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
> ---
>  Documentation/git-submodule.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 8e6af65..84ab577 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -158,7 +158,7 @@ update::
>  	checkout the commit specified in the index of the containing repository.
>  	This will make the submodules HEAD be detached unless `--rebase` or
>  	`--merge` is specified or the key `submodule.$name.update` is set to
> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> +	`rebase`, `merge` or `none`. This can be overridden by specifying
>  	`--checkout`. Setting the key `submodule.$name.update` to `!command`
>  	will cause `command` to be run. `command` can be any arbitrary shell
>  	command that takes a single argument, namely the sha1 to update to.

Thanks.  This looks sensible, judging only from the text (iow I
didn't check if there were legitimate reason why rebase/merge
settings should not be overriden from the command line).

Jens?
