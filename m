From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Improve documentation of update subcommand
Date: Mon, 23 Feb 2015 12:13:20 -0800
Message-ID: <xmqqvbiss7xb.fsf@gitster.dls.corp.google.com>
References: <87egpgdaac.fsf@steelpick.2x.cz>
	<1424698360-10952-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Mon Feb 23 21:13:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPzNh-0002DF-Kx
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 21:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbbBWUNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 15:13:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752410AbbBWUNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 15:13:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D5033A690;
	Mon, 23 Feb 2015 15:13:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5AOlBnJQyOn8YQVq9mh/SoBtN5k=; b=Wblz9x
	n9CoSMfU1bpeWFNoYi0OI1wqfOpuq60d9thXsrPOfRD4w3knQpOZ3agDe02l/2Vf
	aL5q9Ji8GvJmp2kdtzs8aypIbe95ySNJJ23wNN0fMtTR7whRYBzblQSXQ+y4IBGR
	ObmYRwBacgloazjVXNygWYeovEji0AoAj9CeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OQRu2IQy2IZLcCuzg4OWzzh8QRFux/Fj
	q0M14lUdVxu9llKY4ZV6+muSBM8G8hN+HWmgIQFccDLpXOdlJZ2IeAAoQBTryllW
	aLqiKdIbVuDj3rkmdQuMv8MsYBjT6f9uxrx2T5IMIcBRojPueQXx6Xn0UjDWqU2n
	yPor1e+1AgQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 237843A68F;
	Mon, 23 Feb 2015 15:13:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79F5F3A68E;
	Mon, 23 Feb 2015 15:13:21 -0500 (EST)
In-Reply-To: <1424698360-10952-1-git-send-email-sojkam1@fel.cvut.cz> (Michal
	Sojka's message of "Mon, 23 Feb 2015 14:32:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69F59C74-BB98-11E4-BFD8-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264293>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> The documentation of 'git submodule update' has several problems:

Thanks, this round looks much better.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ae6791d..fb2ae37 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2411,12 +2411,17 @@ status.submodulesummary::
>  
>  submodule.<name>.path::
>  submodule.<name>.url::
> +	The path within this project and URL for a submodule. These
> +	variables are initially populated by 'git submodule init';
> +	edit them to override the URL and other values found in the
> +	`.gitmodules` file. See linkgit:git-submodule[1] and
> +	linkgit:gitmodules[5] for details.
> +

The sentence "edit them to override" talks about "other values",
which in the original wanted to cover not just "path" but "update"
as well.  By splitting 'update' into its own entry, "edit them to
override" is lost from 'update'.

But stepping back a bit, "edit them to override" applies to all
configuration variables.  The user edits the configuration file to
customize things.  I wonder if we even need to say this for .path
and url in the first place?

    Note: not a request to remove it because I hinted so, but a
    request for comments and discussion, as I do not have a firm
    opinion.

>  submodule.<name>.update::
> -	The path within this project, URL, and the updating strategy
> -	for a submodule.  These variables are initially populated
> -	by 'git submodule init'; edit them to override the
> -	URL and other values found in the `.gitmodules` file.  See
> -	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
> +	The default updating strategy for a submodule. This variable
> +	is populated by `git submodule init` from the
> +	linkgit:gitmodules[5] file. See description of 'update'
> +	command in linkgit:git-submodule[1].




> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 8e6af65..067d616 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -154,27 +154,51 @@ If `--force` is specified, the submodule's work tree will be removed even if
>  it contains local modifications.
>  
>  update::
> -	Update the registered submodules, i.e. clone missing submodules and
> -	checkout the commit specified in the index of the containing repository.
> -	This will make the submodules HEAD be detached unless `--rebase` or
> -	`--merge` is specified or the key `submodule.$name.update` is set to
> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> -	`--checkout`. Setting the key `submodule.$name.update` to `!command`
> -	will cause `command` to be run. `command` can be any arbitrary shell
> -	command that takes a single argument, namely the sha1 to update to.
>  +
> +--
> +Update the registered submodules to match what the superproject
> +expects by cloning missing submodules and updating the working tree of
> +the submodules. The "updating" can be done in several ways depending
> +on command line options and the value of `submodule.<name>.update`
> +configuration variable. Supported update methods are:

If you read the description of "--remote" (sorry, I didn't notice it
until I formatted the result of this patch and tried to read the
whole thing), we already use "update procedure" to mean these modes
of updates collectively.  Either use "update procedures" here (and
everywhere else in this patch where it is called "update method"),
or adjust the existing "update procedure" to "update method".
Either way is fine, but because "update procedure" is not wrong
per-se, I think it would be better to use that phrasing that may
already be familiar with the "git submodule" users.
