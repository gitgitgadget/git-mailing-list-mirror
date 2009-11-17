From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git remote: Separate usage strings for subcommands
Date: Mon, 16 Nov 2009 17:02:27 -0800
Message-ID: <7vocn2klp8.fsf@alter.siamese.dyndns.org>
References: <32c343770911151343y1ed0aak83b43a4ab57eb6ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 02:02:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NACSw-0000iq-DV
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 02:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbZKQBCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbZKQBCa
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 20:02:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbZKQBC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 20:02:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E43E2807F7;
	Mon, 16 Nov 2009 20:02:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=syf+rh9Q3FX/ARaWGoF73iN1t6s=; b=uZDsKi
	Elg1pOWqBRUyXd52b3RYkDIw/mCiMoUuP7Cveqbw6t2pn9yEt1k/JjzVgKMhz7hh
	K2fqRU6HPkWDgEcT/xOAgEK2+fq7TpZkkBI1uwWMeLy9G1Tj2Yc1HgTsumdJi2MB
	7EtKMjz5NBRUbFQ+LwF6TqjTTOxSU4jXZ6J9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofNjObKvt1+dEc83MowEA6ZVKV2m1ja1
	Po6sI5SGxktFAlZh1W2LRXqNA7rvvsDkUFj1KDlQWj1Ppeu0Z7HPYCcO2YptM+xM
	yHN+2P+TiJsnXofTZDXlboRS5d5FPAPz0tdl958J3RdetP1QTV8nYnWJ0DoO7FfS
	00d1FGlwTD4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0E0B807F3;
	Mon, 16 Nov 2009 20:02:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4DD7807F2; Mon, 16 Nov
 2009 20:02:29 -0500 (EST)
In-Reply-To: <32c343770911151343y1ed0aak83b43a4ab57eb6ab@mail.gmail.com> (Tim
 Henigan's message of "Sun\, 15 Nov 2009 16\:43\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2DC5FC8-D314-11DE-A4ED-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133049>

Tim Henigan <tim.henigan@gmail.com> writes:

> All usage strings are still only located at the top of file.  However,
> separate usage string arrays have been created for each subcommand.
>
> Does this look like a sane way to structure the code?
>
> If anyone else should be added to the CC list, please let me know.
>
>
>  builtin-remote.c |   57 +++++++++++++++++++++++++++++++++--------------------
>  1 files changed, 35 insertions(+), 22 deletions(-)
>
> diff --git a/builtin-remote.c b/builtin-remote.c
> index 0777dd7..ec65a4b 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -7,18 +7,35 @@
>  #include "run-command.h"
>  #include "refs.h"
>
> +#define REMOTE_BARE_USAGE	"git remote [-v | --verbose]"
> +#define REMOTE_ADD_USAGE	"git remote add [-t <branch>] [-m <master>]
> [-f] [--mirror] <name> <url>"
> +#define REMOTE_RENAME_USAGE	"git remote rename <old> <new>"
> +#define REMOTE_RM_USAGE		"git remote rm <name>"
> +#define REMOTE_SETHEAD_USAGE	"git remote set-head <name> [-a | -d | <branch>]"
> +#define REMOTE_SHOW_USAGE	"git remote show [-n] <name>"
> +#define REMOTE_PRUNE_USAGE	"git remote prune [-n | --dry-run] <name>"
> +#define REMOTE_UPDATE_USAGE	"git remote [-v | --verbose] update [-p |
> --prune] [group]"
> +
>  static const char * const builtin_remote_usage[] = {
> -	"git remote [-v | --verbose]",
> -	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
> -	"git remote rename <old> <new>",
> -	"git remote rm <name>",
> -	"git remote set-head <name> [-a | -d | <branch>]",
> -	"git remote show [-n] <name>",
> -	"git remote prune [-n | --dry-run] <name>",
> -	"git remote [-v | --verbose] update [-p | --prune] [group]",
> +	REMOTE_BARE_USAGE,
> +	REMOTE_ADD_USAGE,
> +	REMOTE_RENAME_USAGE,
> +	REMOTE_RM_USAGE,
> +	REMOTE_SETHEAD_USAGE,
> +	REMOTE_SHOW_USAGE,
> +	REMOTE_PRUNE_USAGE,
> +	REMOTE_UPDATE_USAGE,
>  	NULL
>  };
> ...
> +static const char * const builtin_remote_add_usage[] = {
> REMOTE_ADD_USAGE, NULL };
> ...

I am not sure about the value of reusing option string like this, and for
all other subcommands the same comment applies.  For example, in the case
of "remote add -h", you would use

"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>"

from REMOTE_ADD_USAGE, but ...

> @@ -70,7 +87,6 @@ static int add(int argc, const char **argv)
>  	int i;
>
>  	struct option options[] = {
> -		OPT_GROUP("add specific options"),
>  		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
>  		OPT_CALLBACK('t', "track", &track, "branch",
>  			"branch(es) to track", opt_parse_track),
> @@ -79,11 +95,11 @@ static int add(int argc, const char **argv)
>  		OPT_END()
>  	};
>
> -	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
> +	argc = parse_options(argc, argv, NULL, options, builtin_remote_add_usage,
>  			     0);

... the options list is used to reproduce the information in a major part
of that string already.  So I would prefer builtin_remote_add_usage[] to
be something like:

    "git remote add [<options>...] <name> <url>"

It is in line with a discussion we had earlier:

  http://thread.gmane.org/gmane.comp.version-control.git/129906/focus=130646
