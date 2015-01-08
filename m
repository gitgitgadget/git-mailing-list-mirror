From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote: Remove -v/--verbose option from git remote show synopsis
Date: Thu, 08 Jan 2015 11:47:43 -0800
Message-ID: <xmqqwq4xdpgg.fsf@gitster.dls.corp.google.com>
References: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:48:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9J3x-0004Mh-2I
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 20:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbbAHTsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 14:48:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751707AbbAHTsC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 14:48:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE4D42E92F;
	Thu,  8 Jan 2015 14:48:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5uxu1VYvxRdzUbMD3BFAoeIo+bY=; b=wvm7YI
	xXi9mDZORpDBAJ+LEWbUwQ31MpurC8OomstKq+2OfZ4iWl/riH+OwamPm/I7ZfQI
	D0oTokloDSPdOjpJqmJ41/DHfrdaiLjyImi1jBtLP/+hd+bwrUs5M0vIMEu300W0
	dLRY/T+xdxfdUn39aiz3nBTbc4JRmp6/NWh9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZIfdzIlgWqTMfa0t7eppoX4pkAzoqzkn
	z/6VZrnfY8DttvR9r7FKJqMJmrm3c8NXmSSP2B07zos1hvlC0LUVuWmLNHEdCSDF
	UcPN8JiJfJlDdkdnoe8s9K8fMogUzcG8WooRgAYDaI/LZ+MtSl9bOk8WiO/H+sYB
	LGrPpaHALn8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C08142E92E;
	Thu,  8 Jan 2015 14:48:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1B592E919;
	Thu,  8 Jan 2015 14:47:44 -0500 (EST)
In-Reply-To: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Thu, 8 Jan 2015 23:57:43 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 372103E4-976F-11E4-99F9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262214>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> git remote show doesn't use -v/--verbose option
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>

Thanks.  

I think these two patches should be squashed into one (which I can
do locally without asking you to resend) but they are good changes.
The subcommand does not just "not use", but it does not even support
(i.e. it throws an error when the option is given).

> ---
>  builtin/remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 46ecfd9..978c645 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
>  	N_("git remote rename <old> <new>"),
>  	N_("git remote remove <name>"),
>  	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
> -	N_("git remote [-v | --verbose] show [-n] <name>"),
> +	N_("git remote show [-n] <name>"),
>  	N_("git remote prune [-n | --dry-run] <name>"),
>  	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
>  	N_("git remote set-branches [--add] <name> <branch>..."),
