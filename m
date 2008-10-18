From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Better explain git-commit --author
 implications
Date: Fri, 17 Oct 2008 21:55:05 -0700
Message-ID: <7vfxmuec46.fsf@gitster.siamese.dyndns.org>
References: <48F95974.3010503@devslashzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Abhijit Bhopatkar <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 06:56:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr3rh-0002LZ-Gn
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 06:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbYJREzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 00:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbYJREzX
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 00:55:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYJREzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 00:55:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D0D218C023;
	Sat, 18 Oct 2008 00:55:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6E12D8C020; Sat, 18 Oct 2008 00:55:12 -0400 (EDT)
In-Reply-To: <48F95974.3010503@devslashzero.com> (Abhijit Bhopatkar's message
 of "Sat, 18 Oct 2008 09:05:16 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F67B39D0-9CD0-11DD-96C7-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhijit Bhopatkar <bain@devslashzero.com> writes:

> '--author' changes the author name and email, but the
> documentation was not clear that it will not affect the
> '--signoff' option which will still use the user's name and
> email from the git settings.
>
> Signed-off-by: Abhijit Bhopatkar <bain@devslashzero.com>
> ---
>  Documentation/git-commit.txt |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index eb05b0f..17b69fa 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -78,7 +78,8 @@ OPTIONS
>  	Override the author name used in the commit.  You can use the
>  	standard `A U Thor <author@example.com>` format.  Otherwise,
>  	an existing commit that matches the given string and its author
> -	name is used.
> +	name is used. This has no effect on singoff line which will
> +	still use commiter name and email .
>
>  -m <msg>::
>  --message=<msg>::
> @@ -95,6 +96,7 @@ OPTIONS
>  -s::
>  --signoff::
>  	Add Signed-off-by line at the end of the commit message.
> +	'--author' option has no effect on this line.

I think it is much clearer if you do not say what does _not_ affect
things, but instead say what does.  So let's do this instead.

        --signoff::
                Add Signed-off-by line by the committer at the end of the commit
                log message.


And no other changes.

By making it clear that signoff is about the committer, it would be clear
that --author (or GIT_AUTHOR_NAME environment variable) would not affect
it.
