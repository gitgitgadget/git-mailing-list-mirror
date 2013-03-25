From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/commit-tree: mention -S option
Date: Mon, 25 Mar 2013 13:06:28 -0700
Message-ID: <7v7gkvxn0b.fsf@alter.siamese.dyndns.org>
References: <14b024f9ee5c6319a0ff1f700f52d29b2464764f.1364240065.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 21:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDfX-0000Ms-0P
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061Ab3CYUGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:06:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801Ab3CYUGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:06:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCB00B41D;
	Mon, 25 Mar 2013 16:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cuxv6a+E1rGwQlxCCQrlNd5Csus=; b=NK/2wu
	qRE9bBapTJ41XEXt3G+/ztYOgVnp9xX9NDhtRr0ZoskEeZ8scGM88h02kBxvaUcx
	+Vv3c1EUx7AdJGEp1czTZjBpHmZymbgXlQKzDuwQhMonjMU7A4M1AiugZuFHqUOg
	6/iNafeoNSTg2MWuJprSkP0tAQ5NZovp6knw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/FIMMHLXDqlT6dfIdxrYhYxipz/uduu
	iwdo5i7J7b8dqwPBtOb9CCl2YmHgfWtjsg2Mt4Kdd0dioFCfUuavAPWxOcRh+//i
	WmK8FqMZHinNnvy9m0LusQmgBuDeB8yRRM1weU3J+qImtc+zz9CKagnxmmJ8Zm72
	WI9iCL4uBAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1EC2B41C;
	Mon, 25 Mar 2013 16:06:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 155F8B41B; Mon, 25 Mar 2013
 16:06:29 -0400 (EDT)
In-Reply-To: <14b024f9ee5c6319a0ff1f700f52d29b2464764f.1364240065.git.brad.king@kitware.com> (Brad King's message of "Mon, 25 Mar 2013 15:39:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B93E942-9587-11E2-8FE7-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219074>

Brad King <brad.king@kitware.com> writes:

> Commit ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) added the
> -S option and documented it in the command usage.  Then commit 098bbdc3
> (Add -S, --gpg-sign option to manpage of "git commit", 2012-10-21)
> documented it in the porcelain manpage.  Use wording from the porcelain
> to document the option in the plumbing manpage too.
> ---

Thanks; sign-off?

>  Documentation/git-commit-tree.txt |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
> index 86ef56e..62f7b53 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -10,7 +10,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit-tree' <tree> [(-p <parent>)...] < changelog
> -'git commit-tree' [(-p <parent>)...] [(-m <message>)...] [(-F <file>)...] <tree>
> +'git commit-tree' [(-p <parent>)...] [-S<keyid>] [(-m <message>)...]
> +		  [(-F <file>)...] <tree>
> +
>  
>  DESCRIPTION
>  -----------
> @@ -52,6 +54,9 @@ OPTIONS
>  	Read the commit log message from the given file. Use `-` to read
>  	from the standard input.
>  
> +-S<keyid>::
> +	GPG-sign commit.
> +
>  
>  Commit Information
>  ------------------
