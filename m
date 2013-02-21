From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: filter-branch env-filter example
Date: Thu, 21 Feb 2013 12:49:10 -0800
Message-ID: <7vsj4ptmt5.fsf@alter.siamese.dyndns.org>
References: <5126824A.2060903@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tadeusz Andrzej =?utf-8?Q?Kad=C5=82ubowski?= <yess@hell.org.pl>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8d5P-0002DW-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3BUUtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 15:49:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876Ab3BUUtN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 15:49:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10487BDD8;
	Thu, 21 Feb 2013 15:49:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WlJCzQnkd26/
	bb9tLnKlJvt4vOc=; b=D6P5pzMwjHGPrix1oR1My3E9LelZJh13QtE6K+tNU5L7
	ydp2r55k0tz/5LgqpNI7IYDCp66f7NKwYUw1t0n+q01VJO380OSBXbYq8vB9LQVb
	cfpBqWMB3lc9HOlxzxaDQin1LnI0qqNLg+3gxLyposZws/EM3HnXO4zJyouOpSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VNmeUx
	vDtl0YL8UT/V6KDcict8U9YwBrn7YjhwnTXXAnieXyNKVDjaZ7deKb8UwyRgDcaU
	bQhpY4j9W7RmEtYLUdUj7sA8iuzsjl6InDgW0/OBNvS3YBxaUi3yxaVzJyCAQvWX
	6X7IL1gfcQ4b28mYk1ZcDbmtLGgQRPRnbYwiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEABFBDD5;
	Thu, 21 Feb 2013 15:49:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2579BDCC; Thu, 21 Feb 2013
 15:49:11 -0500 (EST)
In-Reply-To: <5126824A.2060903@hell.org.pl> ("Tadeusz Andrzej =?utf-8?Q?Ka?=
 =?utf-8?Q?d=C5=82ubowski=22's?= message of "Thu, 21 Feb 2013 21:23:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2582125A-7C68-11E2-9B19-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216798>

Tadeusz Andrzej Kad=C5=82ubowski  <yess@hell.org.pl> writes:

> filter-branch --env-filter example that shows how to change the email
> address in all commits before publishing a project.
>
> Signed-off-by: Tadeusz Andrzej Kad=C5=82ubowski <yess@hell.org.pl>
> ---

Assuming that the result formats well both as html and manpage, the
added example looks good to me.  I somehow suspect that there is a
patch-mangling going on, though.

>  Documentation/git-filter-branch.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-=
filter-branch.txt
> index e50ee2f..660bd32 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -329,6 +329,27 @@ git filter-branch --msg-filter '
>  ' HEAD~10..HEAD
>  --------------------------------------------------------
>  +The `--env-filter` option can be used to modify committer and/or au=
thor
> +identity.  For example, if you found out that your commits have the =
wrong
> +identity due to a misconfigured user.email, you can make a correctio=
n,
> +before publishing the project, like this:
> +
> +
> +--------------------------------------------------------
> +git filter-branch --env-filter '
> +	if test "$GIT_AUTHOR_EMAIL" =3D "root@localhost"
> +	then
> +		GIT_AUTHOR_EMAIL=3Djohn@example.com
> +		export GIT_AUTHOR_EMAIL
> +	fi
> +	if test "$GIT_COMMITTER_EMAIL" =3D "root@localhost"
> +	then
> +		GIT_COMMITTER_EMAIL=3Djohn@example.com
> +		export GIT_COMMITTER_EMAIL
> +	fi
> +' -- --all
> +--------------------------------------------------------
> +
>  To restrict rewriting to only part of the history, specify a revisio=
n
>  range in addition to the new branch name.  The new branch name will
>  point to the top-most revision that a 'git rev-list' of this range
