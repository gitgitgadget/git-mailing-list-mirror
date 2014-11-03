From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 13:35:32 -0800
Message-ID: <xmqqbnooq863.fsf@gitster.dls.corp.google.com>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>
	<xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
	<5457E7DF.5070500@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 22:35:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlPHn-0001tI-Q3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 22:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbaKCVfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 16:35:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752376AbaKCVff (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 16:35:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 513FA1A34F;
	Mon,  3 Nov 2014 16:35:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zVKVefDk7I1I6yDrFBWp4CLlmJk=; b=YDGIvv
	YivasySf1etX2n2zPJE1pACcf3okT76DxHcX4KEGE37R/TzJ9BpBk1grppQ+knhY
	aI3qz8hfLhe0Z4fpVgQtWedU/RV4rVU2uYcBVTeXfW+/w0jfUIvG1IMjDNQomBK4
	y39PmthL5QGQOCoXmLxTgQBHSLEhCoX3u4mjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQBJlnfpPnKxbYDAPjYPgAEzF+kiyr1o
	jgrHwz9U9Urj4WVPoS7Qxbyc3a6QRRug9ROYWxydzkULrHK3ymeT7sJqKblL/ncp
	eAhDqkQM014mPIZYVDAh+J+K+wtFogv0Z1k0sGV3k4rCc8IDjGjZGe9kNNpxqtuq
	IicwCEoM+wI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48BEA1A34E;
	Mon,  3 Nov 2014 16:35:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB5E71A34D;
	Mon,  3 Nov 2014 16:35:33 -0500 (EST)
In-Reply-To: <5457E7DF.5070500@web.de> (Jens Lehmann's message of "Mon, 03 Nov
	2014 21:38:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 578F2B08-63A1-11E4-920B-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This was introduced in e6a1c43aaf (document submdule.$name.update=none
> option for gitmodules), and I agree with Michal that we should fix it.
> But I think we should rather say "This can be overridden by specifying
> '--merge', '--rebase' or `--checkout`." here, as the other two options
> also override the update setting. So I think we should queue this:
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
> +	`rebase`, `merge` or `none`. This can be overridden by using '--merge',
> +	'--rebase' or
>  	`--checkout`. Setting the key `submodule.$name.update` to `!command`
>  	will cause `command` to be run. `command` can be any arbitrary shell
>  	command that takes a single argument, namely the sha1 to update to.
>
> Apart from that I'm all for it.

But read the whole thing again.  Isn't that a bit roundabout and
tortuous?

The paragraph is about the "update" subcommand, and then mentions
how the subcommand is affected by options and configuration.  And
"OVERRIDING" the topic of this thread is only about configuration.

Disecting what each sentence in the existing paragraph says:

    - This is about updating the submodule working tree to match
      what the superproject expects.

    - There can be three ways how it is "updated" (and one way to
      leave it not updated), by setting submodule.$name.update
      and/or giving --rebase, --merge or --checkout option, and one
      way to leave it not "updated" by setting .update=none.

    - The .update=none can be defeated with --checkout

which I think is a mess.

It is a fairly common and uniform pattern that command line options
override configured defaults, so I think it could be argued that
"you can override .update=none or .update=anything with command line
option" is not even worth saying.  Definitely not by piling yet
another "oh by the way, if you have this, things behave differently
again" on top of existing description.

	Update the registered submodules to match what the superproject
	expects by cloning missing submodules and updating the
	working tree of the submodules.  The "updating" can take
	various forms:

	(1) By default, or by explicitly giving `--checkout` option,
            the HEAD of the submodules are detached to the exact
            commit recorded by the superproject.

	(2) By giving `--rebase` or `--merge` option, the commit
            that happens to be checked out in the submodule's
            working tree is integrated with the commit recorded by
            the superproject by rebasing or merging, respectively.

	Setting submodule.$name.update configuration to `rebase` or
        `merge` will make `git submodule update` without these
        command line options to default to `--rebase` or `--merge`,
        respectively.

	Also, setting submodule.$name.update configuration to `none`
        marks the named submodule not updated by "submodule update"
        by default (you can still use `--checkout`, `--merge`, or
        `--rebase`).

Or something perhaps?  Or the detailed description of
submodule.$name.update should be dropped from here and refer the
reader to config.txt instead?
