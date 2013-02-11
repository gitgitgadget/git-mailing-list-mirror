From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] shell doc: emphasize purpose and security model
Date: Sun, 10 Feb 2013 23:10:44 -0800
Message-ID: <7vhaljpbpn.fsf@alter.siamese.dyndns.org>
References: <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin> <20130211055752.GF15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:11:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4nXj-00069W-LG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3BKHKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:10:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372Ab3BKHKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:10:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A063BD2F;
	Mon, 11 Feb 2013 02:10:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F+A4iU6zLjwBndcHoz2UOlbKIAI=; b=pmRdyM
	PtE2UKKfq6jNeOkr/7HjWgnD+9QOIInJU/AzvT3T6HmUUNxRMI3ror+wMXLdfh5R
	GBkL9+HaaWmpFYHOwXprP4TYIySGcYcdu9uhMsTTEz26+mRdhUBe4d3oUQAV2Eqz
	YML9bfJs08uNrqccdGkyTtCf4LDHatyaPkDTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kRI6ts4M4I4W0EG7A2hAP/K9GZ18osZx
	o56CZqaOxRZX/VnKc4LIEC7kDspUjVQR1KVZZnti0FimrLcWYQTz3OioBWz57wYP
	P86g0JoKCXbxiTFjvLAi1wjGO4l2+CODVQbqvOv1YOQGGpWsKDnWiJw+BFc5gBPk
	bSgqZcEy+jc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FA23BD2E;
	Mon, 11 Feb 2013 02:10:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7242BD2D; Mon, 11 Feb 2013
 02:10:46 -0500 (EST)
In-Reply-To: <20130211055752.GF15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 21:57:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 283310CC-741A-11E2-8E3C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216007>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
> index 9b925060..4fe93203 100644
> --- a/Documentation/git-shell.txt
> +++ b/Documentation/git-shell.txt
> @@ -9,25 +9,61 @@ git-shell - Restricted login shell for Git-only SSH access
>  SYNOPSIS
>  --------
>  [verse]
> -'git shell' [-c <command> <argument>]
> +'chsh' -s $(which git-shell) git

<review type="nitpick" mode="posix-police">
Please don't use "which" in scripts.  Perhaps "command -v" is more
suitable here.
</review>

Otherwise looks good to me.  Thanks.

> +'git clone' `git@localhost:/path/to/repo.git`
> +'ssh' `git@localhost`
>  
>  DESCRIPTION
>  -----------
>  
> +This is a login shell for SSH accounts to provide restricted Git access.
> +It permits execution only of server-side Git commands implementing the
> +pull/push functionality, plus custom commands present in a subdirectory
> +named `git-shell-commands` in the user's home directory.
> +
> +COMMANDS
> +--------
> +
> +'git shell' accepts the following commands after the '-c' option:
> +
> +'git receive-pack <argument>'::
> +'git upload-pack <argument>'::
> +'git upload-archive <argument>'::
> +	Call the corresponding server-side command to support
> +	the client's 'git push', 'git fetch', or 'git archive --remote'
> +	request.
> +'cvs server'::
> +	Imitate a CVS server.  See linkgit:git-cvsserver[1].
> +
> +If a `~/git-shell-commands` directory is present, 'git shell' will
> +also handle other, custom commands by running
> +"`git-shell-commands/<command> <arguments>`" from the user's home
> +directory.
> +
> +INTERACTIVE USE
> +---------------
> +
> +By default, the commands above can be executed only with the '-c'
> +option; the shell is not interactive.
> +
> +If a `~/git-shell-commands` directory is present, 'git shell'
> +can also be run interactively (with no arguments).  If a `help`
> +command is present in the `git-shell-commands` directory, it is
> +run to provide the user with an overview of allowed actions.  Then a
> +"`git> `" prompt is presented at which one can enter any of the
> +commands from the `git-shell-commands` directory, or `exit` to close
> +the connection.
> +
> +Generally this mode is used as an administrative interface to allow
> +users to list repositories they have access to, create, delete, or
> +rename repositories, or change repository descriptions and
> +permissions.
> +
> +SEE ALSO
> +--------
> +ssh(1),
> +linkgit:git-daemon[1],
> +contrib/git-shell-commands/README
>  
>  GIT
>  ---
