From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] githooks.txt: Improve the intro section
Date: Mon, 25 Apr 2016 11:23:56 -0700
Message-ID: <xmqqr3dtlf7n.fsf@gitster.mtv.corp.google.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:24:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulAz-0002R9-QE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087AbcDYSYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 14:24:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754798AbcDYSYA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 14:24:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDA7015376;
	Mon, 25 Apr 2016 14:23:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WgN7am+4tzFN
	oWMIF12wNC1mjVo=; b=PQ87vBAhC9unhlEhVCL4NmXhIeSsAEZPkJwHFf92wyTx
	mi4eAAzzJbm2h9xUhx+48WhYVSqKRqodAcj8jy9IhRlJTdp8hpnsSl5BpJkIqDXt
	0sUwahj1ZXt4VehUfr5+pQyVAEa90ESOV8sXZyiGCOaYi+a0NSFPY0/d02xJlgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A56mm2
	1vOkyvSstvGVBeLSYED/AulvBOGCK6diPyupQrch3CGOnSFuJHnAQOjRabatL+SE
	fiih4dDQmQB9nBq7MIh2+vMn54X3ROSi2Eq4ymr0Ok3TENDa08EJGej63+EQ63+p
	d6mloa0Igfdx/QNT2thrnJJCY5yy2PXHxbFMM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C028115375;
	Mon, 25 Apr 2016 14:23:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1615D15373;
	Mon, 25 Apr 2016 14:23:58 -0400 (EDT)
In-Reply-To: <1461529229-15222-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 24 Apr
 2016 20:20:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0409152-0B12-11E6-8F19-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292537>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the documentation so that:
>
>  * We don't talk about "little scripts". Hooks can be as big as you
>    want, and don't have to be scripts, just call them "programs".
>
>  * We note what happens with chdir() before a hook is called, nothing
>    documented this explicitly, but the current behavior is
>    predictable. It helps a lot to know what directory these hooks wil=
l
>    be executed from.
>
>  * We don't make claims about the example hooks which may not be true
>    depending on the configuration of 'init.templateDir'. Clarify that
>    we're talking about the default settings of git-init in those case=
s,
>    and move some of this documentation into git-init's documentation
>    about the default templates.
>
>  * We briefly note in the intro that hooks can get their arguments in
>    various different ways, and that how exactly is described below fo=
r
>    each hook.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  Documentation/git-init.txt |  6 +++++-
>  Documentation/githooks.txt | 32 ++++++++++++++++++++------------
>  2 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 8174d27..cf37926 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -130,7 +130,11 @@ The template directory will be one of the follow=
ing (in order):
>   - the default template directory: `/usr/share/git-core/templates`.
> =20
>  The default template directory includes some directory structure, su=
ggested
> -"exclude patterns" (see linkgit:gitignore[5]), and sample hook files=
 (see linkgit:githooks[5]).
> +"exclude patterns" (see linkgit:gitignore[5]), and example hook file=
s.
> +
> +The example are all disabled by default. To enable a hook, rename it

"sample hooks are all disabled" would be better; if for some unknown
reason you are trying to avoid "sample hooks", "examples are all
disabled" may be acceptable.

> +by removing its `.sample` suffix. See linkgit:githooks[5] for more
> +info on hook execution.

Makes a first-time reader wonder if I am allowed to ignore the
sample and write my own from scratch, or if the only thing that is
allowed is to enable what is shipped with .sample suffix.

I wonder it would become less confusing if we placed even _less_
stress on these sample hooks; I find that saying we ship sample
hooks that are disabled is probably more confusing.

We do not ship any hook (hence nothing is enabled by definition);
there are a handful of sample files that you can use when adding
your own hook by either referencing them or taking them as-is, and
the latter can be done by removing .sample suffix, which is merely a
special case convenience.


> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a2f59b1..2f3caf7 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -13,18 +13,26 @@ $GIT_DIR/hooks/*
>  DESCRIPTION
>  -----------
> =20
> -Hooks are little scripts you can place in `$GIT_DIR/hooks`
> -directory to trigger action at certain points.  When
> -'git init' is run, a handful of example hooks are copied into the
> -`hooks` directory of the new repository, but by default they are
> -all disabled.  To enable a hook, rename it by removing its `.sample`
> -suffix.
> -
> -NOTE: It is also a requirement for a given hook to be executable.
> -However - in a freshly initialized repository - the `.sample` files =
are
> -executable by default.
> -
> -This document describes the currently defined hooks.
> +Hooks are programs you can place in the `$GIT_DIR/hooks` directory t=
o
> +trigger action at certain points. Hooks that don't have the executab=
le
> +bit set are ignored.

The last sentence is POSIXPERM only, though.

> +When a hook is called in a non-bare repository the working directory
> +is guaranteed to be the root of the working tree, in a bare reposito=
ry
> +the working directory will be the path to the repository. I.e. hooks
> +don't need to worry about the user's current working directory.

This sentence took me two reads until I mentally substituted "the
working directory" with "its working diretory", to realize that you
are talking about the cwd of the process that runs the hook.

While "is guaranteed" may be technically correct and we have no
intention to change it, it sounds unnecessarily strong.

    When a hook is invoked, it is run at the root of the working
    tree in a non-bare repository, or in the $GIT_DIR in a bare
    repository.

perhaps?

> +Hooks can get their arguments via the environment, command-line
> +arguments, and stdin. See the documentation for each below hook for
> +details.

"each below hook" sounds somewhat ungrammatical.
