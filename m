From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] submodule: Fix documentation of update subcommand
Date: Wed, 18 Feb 2015 15:44:39 -0800
Message-ID: <xmqqbnkq23a0.fsf@gitster.dls.corp.google.com>
References: <xmqqvbj0yx6c.fsf@gitster.dls.corp.google.com>
	<1424299716-21138-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Thu Feb 19 00:44:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOEIR-0003Yu-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 00:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbbBRXom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 18:44:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751634AbbBRXom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 18:44:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F1013A78A;
	Wed, 18 Feb 2015 18:44:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6HzQ9WAMW0uPmD8nTQAc95FEbM=; b=Jy90pq
	kJqWHaztNLD0WNWujF47EURX8gH66+GxdswoFJwOxr82HNA22VhS8oj6jOd/0SpT
	ZpdRGrxMYVRbAVqcR1FSmR7RNEHzJfpHDQmUtHT0HWawYj+dHWi+Yvls0pWeTC4W
	PPFflbCkWuyMf9QVr71Mv2SMnKh1M8DRgXSkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HOyHJdbItqJTQRNIkHjrkx6Gu2ekiK3/
	ca8kN+Szy6twnu+4lyqKnNTeMK/dgOfIAnW4fve+iioAwpslu66Kp2qLTaObb8JA
	Tvo5jm3A+rIXZqYsX8uKAMNgZ73cxu9tYhUOp2jnZ7I8CrN43sgO43QIkpZ1KgCC
	zBGMnlJYgsE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55B193A789;
	Wed, 18 Feb 2015 18:44:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 972FC3A788;
	Wed, 18 Feb 2015 18:44:40 -0500 (EST)
In-Reply-To: <1424299716-21138-1-git-send-email-sojkam1@fel.cvut.cz> (Michal
	Sojka's message of "Wed, 18 Feb 2015 23:48:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B3D03C0-B7C8-11E4-9BF8-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264073>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> The documentation of 'git submodule update' has several problems:
>
> 1) It says that submodule.$name.update can be overridden by --checkout
>    only if its value is `none`.

Hmm, I do not read the existing sentence that way, though.  The
"only if" above is only in your head and not in the documentation,
no?  The way I understand it is that the explanation does not even
bother to say that it is overridable when update is set to something
that clearly corresponds to --option (e.g. 'update=rebase' is for
people too lazy to type --rebase from the command line), but because
it is unclear when it is set to 'update=none', it specifically
singles out that case.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ae6791d..f30cbbc 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2411,12 +2411,29 @@ status.submodulesummary::
>  
>  submodule.<name>.path::
>  submodule.<name>.url::
> +	The path within this project and URL for a submodule. These
> +	variables are initially populated by 'git submodule init';
> +	edit them to override the URL and other values found in the
> +	`.gitmodules` file. See linkgit:git-submodule[1] and
> +	linkgit:gitmodules[5] for details.
> +

OK.

>  submodule.<name>.update::
> -	The path within this project, URL, and the updating strategy
> -	for a submodule.  These variables are initially populated
> -	by 'git submodule init'; edit them to override the
> -	URL and other values found in the `.gitmodules` file.  See
> -	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
> +	The default updating strategy for a submodule, used by `git
> +	submodule update`. This variable is populated by `git
> +	submodule init` from linkgit:gitmodules[5].
> +
> +	If the value is 'checkout' (the default), the new commit
> +	specified in the superproject will be checked out in the

Have you formatted this?  I _think_ this change would break the
typesetting by having an empty line there.

> +	submodule on a detached HEAD.
> +	If 'rebase', the current branch of the submodule will be
> +	rebased onto the commit specified in the superproject.
> +	If 'merge', the commit specified in the superproject will be
> +	merged into the current branch in the submodule. If 'none',
> +	the submodule with name `$name` will not be updated by
> +	default.
> +	If the value is of form '!command', it will cause `command` to
> +	be run. `command` can be any arbitrary shell command that
> +	takes a single argument, namely the sha1 to update to.

I have a feeling that it is better to leave the explanations of
these values in git-submodule.txt (i.e. where you took the above
text from) and say "see description of 'update' command in
linkgit:git-submodule[1]" here to avoid duplication.

>  submodule.<name>.branch::
>  	The remote branch name for a submodule, used by `git submodule
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 8e6af65..c92908e 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -154,14 +154,13 @@ If `--force` is specified, the submodule's work tree will be removed even if
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
> +	Update the registered submodules to match what the superproject
> +	expects by cloning missing submodules and updating the working
> +	tree of the submodules....

This part is better than the original.

>  The "updating" can take various forms
> +	and can be configured in .git/config by the
> +	`submodule.$name.update` key or by explicitely giving one of
> +	'--checkout' (the default), '--merge' or '--rebase' options. See
> +	linkgit:git-config[1] for details.

Because submodule.<name>.update is interesting only to those who run
"git submodule update", and also the command line options that
interact with the setting are only described here not in config.txt,
I think it is better to have the description of various modes here.

And the description, if it is done here, can clarify the precedence
(i.e. command line trumps configuration) and semantics
(i.e. configuration 'update=checkout' and option --checkout are both
to trigger the same behaviour), perhaps like this:

	The updating can be done in one of three ways:

        checkout;; detaches the HEAD in the submodule at the commit
            that is recorded by the superproject.  This is done when
            --checkout option is given, or no option is given, and
            submodule.<name>.update is unset, or if it is set to
            'checkout'.
        rebase;; EXPLAIN IN A SIMILAR WAY, talk about --rebase,
            'rebase', etc.
        merge;; EXPLAIN IN A SIMILAR WAY, talk about --merge,
            'merge', etc.

        When no option is given and submodule.<name>.update is set
        to 'none', the submodule is not updated.

It would be awkward to talk about --option in any of the other pages
like config.txt and gitmodules.txt, but the relationship between the
options and configurations must be explained somewhere, so....
