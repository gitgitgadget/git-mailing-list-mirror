From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/15] user-manual: Update for
 receive.denyCurrentBranch=refuse
Date: Sun, 10 Feb 2013 13:24:47 -0800
Message-ID: <7vd2w7uajk.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4eOt-0006uL-SD
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab3BJVZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:25:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756486Ab3BJVZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:25:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DCB2C2AB;
	Sun, 10 Feb 2013 16:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+MWzdIlXOG6wTrE0Au8NYx/tLxE=; b=whVLLJ
	G0rzsEToa5nv4gY2ZtkOj1F+iSJk8+251OCh6UR+JJr1rowMfqcXz2o7oXTKkY9p
	bd//uF92vFNHyzittN8ftWknQDnrKVg+MU+UTFydvW2Ed4ImyNI+mUbGqeVdZzI1
	IpU9mEccPGlQbHugArVtMJG8Az1SZLx8qhoO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PWT7Gmg3scT5liRH6+GIdUEb4Z5Lkh7G
	r/uUo/1YY93mch1A5NYjXEdQwOkOBL+s1ubrWtCb4MPowo9Drg9a+zQeEAT9NBk5
	eR5YyH4/Nv7JxNUrZoUbAr2CGEMLcS2fSZ/7abk41W351kQjYd+ymK2iknHe9dBF
	f4ilJtWg7Rw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA20C292;
	Sun, 10 Feb 2013 16:24:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C85B3C253; Sun, 10 Feb 2013
 16:24:50 -0500 (EST)
In-Reply-To: <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F81977C-73C8-11E2-948A-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215935>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> acd2a45 (Refuse updating the current branch in a non-bare repository
> via push, 2009-02-11) changed the default to refuse such a push, but
> it forgot to update the docs.
>
> 7d182f5 (Documentation: receive.denyCurrentBranch defaults to
> 'refuse', 2010-03-17) updated Documentation/config.txt, but forgot to
> update the user manual.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 222545b..8524c08 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1988,8 +1988,10 @@ handling this case.
>  Note that the target of a "push" is normally a
>  <<def_bare_repository,bare>> repository.  You can also push to a
>  repository that has a checked-out working tree, but the working tree
> -will not be updated by the push.  This may lead to unexpected results if
> -the branch you push to is the currently checked-out branch!
> +will not be updated by the push.  To protect against this, pushes to
> +the currently checked-out branch of a repository are denied by
> +default.  See the description of the receive.denyCurrentBranch option
> +in linkgit:git-config[1] for details.

Nobody else felt the same logic gap between "will not be updated"
and "to protect against this" I sensed while reading this?

I would not be surprised if some readers felt as if "then why not
update it instead of rejecting?" were a valid question, without a
bit more explanation.

	You can also push to a repository that has a working tree,
	but a push to the currently checked out branch is denied for
	two reasons:

        (1) if the push were allowed to update the working tree to
            match the pushed commit, it will overwrite and lose the
            work in progress in the working tree;

	(2) the push does _not_ update the working tree for the
	    above reason, but then if the push were allowed to
	    update the tip of the branch, the next commit made based
	    on the work done in the working tree will be based on
	    the state of the tree _before_ the push but will be
	    recorded as a descendant of the pushed commit, reverting
	    changes to the contents made by the pushed commit.
	
	If you want to handle the above two risks yourself (e.g. you
	can promise that you will never make changes to the files in
	the working tree or make commit from the working tree, and
	install a post-push hook that does "git reset --hard" to
	match the working tree state to the commit that was pushed),
	you can override this by setting receive.denyCurrentBranch.

It almost makes me wonder if it also makes sense to supersede the
denyCurrentBranch setting with a new receive.currentBranch variable
(setting it to "deny" is equivalent to setting denyCurrentBranch to
true), and make "receive.currentBranch = reset" to allow a push and
always run "git reset --hard" afterwards.

If we were to do so, I would strongly be against adding "checkout"
mode that does "git reset --keep" instead of "--hard". Those who can
accept the unconditional ovewriting with "reset --hard" are the only
ones that are safe if "push" updated the tip of the branch and the
working tree.  Updating the working tree with a "reset --keep" may
appear safe because it will catch the case where a file that needs
updating by "push" is modified, but that is an incorrect assumption.
It does not mean nobody has the contents in the editor buffer with
changes yet to be written out.  An automated update to the working
tree condition has to be allowed only to a repository with nobody
sitting at the keyboard editing files in there.
