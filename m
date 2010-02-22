From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] improve documentation on mirroring
Date: Sun, 21 Feb 2010 22:54:42 -0800
Message-ID: <7viq9prc99.fsf@alter.siamese.dyndns.org>
References: <1266819758-5572-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:57:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjSCI-0004NN-Do
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 07:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab0BVGyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 01:54:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab0BVGyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 01:54:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 918589BB17;
	Mon, 22 Feb 2010 01:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HDBkjpyIjNKBfsVfiRguWSwUBEk=; b=anB5q+
	i3uwhYcyHOXmo0AyQExQ+KMHUX5Fssgo5SoDeO4KWYlCJcPHkiPToRG2ioERqchL
	F5UNi3iQQrjlfYa6wSgU13BASggbDbt0VCw22gGzLzEwtc7r1m7noYvX0obz9M5v
	Xg6/z1qcZYyT4FgOAuStdcRNJuTaMu9R+hn+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v/DsxLbPilJEVZx2Act1c9Sq8mPLzzTb
	rVo9a65jD2FWwp1pQjGUazeAVdBEAgEg/adHqxnYVwcZe5N62vpeCAwmQtCNpJet
	ZujfNS/kKQOR0W3SUI60NCexEyCBoEDOWVNIv3m8f4uZ1aT1HU4AfghMA1LplW22
	Fi3UYLiGq3o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C7719BB16;
	Mon, 22 Feb 2010 01:54:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8D3B9BB11; Mon, 22 Feb
 2010 01:54:45 -0500 (EST)
In-Reply-To: <1266819758-5572-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Mon\, 22 Feb 2010 14\:22\:38 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B6192DE-1F7F-11DF-81E3-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140635>

Tay Ray Chuan <rctay89@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 664de6b..e87c06e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1479,6 +1479,8 @@ remote.<name>.push::
>  remote.<name>.mirror::
>  	If true, pushing to this remote will automatically behave
>  	as if the `\--mirror` option was given on the command line.
> +	(See the `\--mirror` option to the `add` command to
> +	linkgit:git-remote[1] for more details on mirroring.)

Please call that "add" a subcommand.  My first quick glance made me go
"Huh?  git add --mirror?".  The same goes for your git-clone docco update.

> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 3fc599c..c2c25fd 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -60,11 +60,11 @@ multiple branches without grabbing all branches.
>  With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
>  up to point at remote's `<master>` branch. See also the set-head command.
>  +
> +With `\--mirror`, the fetch refspec for this remote is setup such that
> +fetched refs are not stored in the 'refs/remotes/' namespace (the default),
> +but in 'refs/heads/'.  The configuration variable `remote.<name>.mirror` is
> +also set to true, so that `git push` will always behave as if `\--mirror`
> +was passed.  This option only makes sense in bare repositories.

It is way suboptimal to say "refs/remotes/ namespace (the default)" here.
The reader either (1) knows by default tracking branches will fall under
refs/remotes and wants to find out what this funny --mirror mode does, or
(2) does not know where they go by default, and does not expect that the
description to the non-default --mirror mode is the place to learn about
it.

The culprit is the introductory description for the `add` option; it does
not start by explaining what happens by default when _no_ options are
given.  Once you fix _that_ problem, it would be clear to the reader that
the description of each option talks primarily about how the option makes
command behave differently from the default, and you can say something
like:

	With --mirror, all branches from the remote side are configured to
        be stored under the same name, i.e. refs/heads/<branch> at remote
        goes to refs/heads/<branch>.

without even mentioning what the default is again and again.  The
description of `-t` also talks about "instead of the default..."; it can
go if you follow this strategy.
