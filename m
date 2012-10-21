From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add -S, --gpg-sign option to manpage of "git commit"
Date: Sun, 21 Oct 2012 13:15:16 -0700
Message-ID: <7vbofvfup7.fsf@alter.siamese.dyndns.org>
References: <20121021195455.43D8F7D4C@ralph.oxix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Jones <tom@oxix.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 22:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ1wt-0001Jk-BF
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 22:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab2JUUPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 16:15:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634Ab2JUUPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 16:15:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A577D87CB;
	Sun, 21 Oct 2012 16:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6gH+IdvO7GWSLNiNe0WewnjBNnQ=; b=moHHO0
	zYS0J+HzQvttjlorVYgEYblz+C1VrT0hIbFZqiu+owDqWm2Fs+QSX1csbDKCwC2n
	SqAJFxPEJ9rIZ7GbdN7Un8Uqm9mrrz307G4D4BJ+Niu7kqMigZ4IbMKlxB2ve4xs
	MEWxwOVMfE5hu4VGxIawRvBqUVpHBG0BLc7I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IvkJ/npN1AlKZqj5Cvnn7S45Y7edIdQh
	C0e4oHeZjePR60SbmDM+RoqX+tTW9ooata78T1zCrh9LIPB7EfH+Wl5ah0eZxg87
	QX7M5zE6lvU3vAFB6ANzxlQ7HeCaXxT3nAmJ9omlDamPeO9pp1lv1b7CRzd0w/Mr
	Ag/Sy3mT9TI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9269987CA;
	Sun, 21 Oct 2012 16:15:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0103987C6; Sun, 21 Oct 2012
 16:15:17 -0400 (EDT)
In-Reply-To: <20121021195455.43D8F7D4C@ralph.oxix.org> (Tom Jones's message
 of "Sun, 21 Oct 2012 20:46:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08366096-1BBC-11E2-B6EF-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208144>

Tom Jones <tom@oxix.org> writes:

> git commit -S, --gpg-sign was mentioned in the program's help message,
> but not in the manpage.
>
> This adds an equivalent entry for the option in the manpage.
> ---

Sign off?

>  Documentation/git-commit.txt |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 9594ac8..0e0a22c 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
> -	   [-i | -o] [--] [<file>...]
> +	   [-i | -o] [--] [-S[keyid]] [<file>...]

Are you sure about this?  The order, described in "git help cli", of
the command line arguments is options (such as -F <file>
-S[<keyid>]) first, then revs (irrelevant for "git commit" and lack
of it in this manual is correct), and then paths.  Optionally "--"
can be used to mark the beginning of "paths" part (e.g. "git commit
-- -S" or "git commit ./-S" is used when you want to commit a file
whose name is "-S").




>  DESCRIPTION
>  -----------
> @@ -276,6 +276,10 @@ configuration variable documented in linkgit:git-config[1].
>  	commit message template when using an editor to prepare the
>  	default commit message.
>  
> +-S[<keyid>]::
> +--gpg-sign[=<keyid>]::
> +	GPG-sign commit.
> +
>  \--::
>  	Do not interpret any more arguments as options.
