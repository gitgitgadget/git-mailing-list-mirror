From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] submodule: Improve documentation of update subcommand
Date: Fri, 20 Feb 2015 15:31:21 -0800
Message-ID: <xmqqlhjsxira.fsf@gitster.dls.corp.google.com>
References: <87d255zt0j.fsf@steelpick.2x.cz>
	<1424371972-13393-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Sat Feb 21 00:31:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOx2e-0007Y3-DH
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 00:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbbBTXbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 18:31:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754759AbbBTXbX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 18:31:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF8D53AB7B;
	Fri, 20 Feb 2015 18:31:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jrf5SGLnsuY5wkMN90Le6fYHmNw=; b=V3gq30
	uWo53GUBWk7q7ynhGoQm7IoCLwzbxcQGykpom5NupbimWZdecO1m3hAMRssPS99U
	lIQ6ciSrl/QSaHc2r1yRq1oVy8nsVUYJP7DRWVWgP9RqcL/xFa+f0U/mk9UhDCNx
	zl5pvN+wbR0Z0Z0QjQODO1okEajDBCil0DAOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCX5RP9eozGffmoDLCP31/XlI981zYdo
	tmICQOXstZREN4Bm1pY31ttZUlUancCKnEj1qrcoDrlchenpHsI8w9GbRTvJ/+FK
	Ix7v/GakOhuX95pjRN5l58Hd7AiLanlp/fE8i5kCjwFo1nQsLPZmcTQPXNMp9ZTc
	YBpIOKHBJEg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5D053AB7A;
	Fri, 20 Feb 2015 18:31:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 383E03AB79;
	Fri, 20 Feb 2015 18:31:22 -0500 (EST)
In-Reply-To: <1424371972-13393-1-git-send-email-sojkam1@fel.cvut.cz> (Michal
	Sojka's message of "Thu, 19 Feb 2015 19:52:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94304012-B958-11E4-839F-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264196>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> This patch fixes all these problems. Now, submodule.$name.update is
> fully documented in git-submodule.txt and the other files just refer to

"Fix all these problems by documenting submodule.*.update in
git-submodule.txt and make everybody else refer to it" in imperative
mood, as if you are giving an order to the source to "be this way".
It would be sweeter and shorter that way.

> it. This is based on discussion between Junio C Hamano, Jens Lehmann and
> myself.

It's customary to just mention them on Helped-by: around here, I
think.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 8e6af65..72c6fb2 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -154,14 +154,36 @@ If `--force` is specified, the submodule's work tree will be removed even if
>  it contains local modifications.
>  
>  update::
> +	Update the registered submodules to match what the superproject
> +	expects by cloning missing submodules and updating the working
> +	tree of the submodules. The "updating" can be done in several
> +	ways depending on command line options and the value of
> +	`submodule.<name>.update` in .git/config:

No quoting around .git/config?  Actually, it is probably better not
to spell out that path.  "... and the value of the `...`
configuration variable" would be better.

> +	checkout;; the new commit recorded in the superproject will be
> +	    checked out in the submodule on a detached HEAD. This is

Drop "new".  It does not add anything to the description, and you
may even be checking out an old commit in the superproject.

> @@ -238,10 +261,11 @@ OPTIONS

Totally offtopic, but we may want a custom xfuncname for our AsciiDoc
documentation; we would want to see "--force::" not "OPTIONS" on the
above line, I would think.

>  	When running add, allow adding an otherwise ignored submodule path.
>  	When running deinit the submodule work trees will be removed even if
>  	they contain local changes.
> -	When running update, throw away local changes in submodules when
> -	switching to a different commit; and always run a checkout operation
> -	in the submodule, even if the commit listed in the index of the
> -	containing repository matches the commit checked out in the submodule.
> +	When running update and the checkout method is used, throw away
> +	local changes in submodules when switching to a different
> +	commit; and always run a checkout operation in the submodule,
> +	even if the commit listed in the index of the containing
> +	repository matches the commit checked out in the submodule.

This makes a reader wonder what --force would do when --merge or
--rebase is given from the command line (or specifiedy in the
configuration).  The original (unfortunately) did not have that
problem because it did not single out the --checkout mode.

The use of the phrase "the checkout method" is iffy, as nobody
defines what it is (I just said "--checkout mode" to mean the same
thing, but I do not think anybody defines it).  See below.


> @@ -302,7 +326,7 @@ the submodule itself.
>  	Checkout the commit recorded in the superproject on a detached HEAD
>  	in the submodule. This is the default behavior, the main use of
>  	this option is to override `submodule.$name.update` when set to
> -	`merge`, `rebase` or `none`.
> +	other value than `checkout`.

"... when set to a value other than `checkout`", would read better,
I would think.

> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index f6c0dfd..a51183c 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -38,18 +38,12 @@ submodule.<name>.url::
>  In addition, there are a number of optional keys:
>  
>  submodule.<name>.update::
> +	Defines what to do when the submodule is updated by the
> +	superproject. This is only used by `git submodule init` to
> +	initialize the variable of the same name in .git/config.
> +	Allowed values here are 'checkout', 'rebase', 'merge' or
> +	'none'. See description of 'update' command in
> +	linkgit:git-submodule[1] for their meaning.

Whatever word we decide to use, this may be a good place to
introduce it, perhaps like this (if we were to go with 'update
method'):

    submodule.<name>.update::

	Define the default update method for the named submodule,
	how the submodule is updated by "git submodule update"
	command in the superproject.

The enumeration of the allowed values is correct, I think, but we
might want to be very clear that we do not copy the !command form
and that is on purpose.
