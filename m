From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/5] Documentation/reset: separate options by mode
Date: Fri, 16 Jul 2010 13:43:23 -0700
Message-ID: <7v7hkvrwd0.fsf@alter.siamese.dyndns.org>
References: <cover.1279273256.git.trast@student.ethz.ch>
 <0bfc95a7c144ccc811b58321a33caf89d20495e1.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 16 22:43:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZrkx-0000fZ-Tj
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 22:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919Ab0GPUne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 16:43:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758829Ab0GPUnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 16:43:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 121A7C5750;
	Fri, 16 Jul 2010 16:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UWkxnXVvsRelcjTDZODLS4EK4mc=; b=M//lW3
	xj/O9GqbIlXOG8A8eABWWbHtsDRC4vlFTHE8o1Fp55HO5iY15yz7bL6GoqQQ3rg5
	q5uoHacrRLtbt+cTRAvkHdn6c9W/w6+R3+ri7/vhdY5PAxnDukwa/NWTLJ+ldZUg
	79kgThGnj1xgJaOD7XTFyxAugnbOWl0HZIUvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFLKHfyJIYw/YtfUhr9x24dG513Uge/H
	y5n10o+sH/qi1yDYaONBCNwVuOm8ZY52TZVYk51IOOBEb6rcjvUwE7I7ufElRaW7
	xToUzpmnAsCRru6hPJEJUIB0vpvifA//N7eVZX+VhhZkmK3I9jET29YDcJCg31KT
	xni/yRBEi9Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D480C574E;
	Fri, 16 Jul 2010 16:43:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00910C574B; Fri, 16 Jul
 2010 16:43:25 -0400 (EDT)
In-Reply-To: <0bfc95a7c144ccc811b58321a33caf89d20495e1.1279273256.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 16 Jul 2010 11\:44\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA27E956-911A-11DF-9917-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151169>

Thomas Rast <trast@student.ethz.ch> writes:

> Remove all but -q from the OPTIONS section, and instead explain the
> options separated by usage mode, since they only apply to one each.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>
> fixup! Documentation/reset: separate options by mode
> ---
>  Documentation/git-reset.txt |   58 +++++++++++++++++++++++-------------------
>  1 files changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index dbb810d..46b2d2a 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -8,29 +8,38 @@ git-reset - Reset current HEAD to the specified state
>  SYNOPSIS
>  --------
>  [verse]
> -'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
>  'git reset' [-q] [<commit>] [--] <paths>...
>  'git reset' --patch [<commit>] [--] [<paths>...]
> +'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
>  
>  DESCRIPTION
>  -----------
> +Sets the current branch to the specified <commit> and optionally
> +resets the index and working tree to match.  The <commit> defaults to
> +HEAD in all forms.

With a careless reading of this paragraph, I got an impression that HEAD
is always affected, but I happen to know that is not the case ;-).

 - "reset" is primarily about resetting the index and the --soft option
   can be used to optionally not to do this.

   . with paths, the command is about fixing up the index contents for
     given specific paths, to prepare for the next commit.  HEAD is not
     moved.

   . without paths, the command is about changing what commit to build
     your next commit on, i.e. HEAD is moved.

> +'git reset' [-q] [<commit>] [--] <paths>...::
> +	This form resets the index entries for all <paths> to their
> +	state at the <commit>.  (It does not affect the worktree, nor
> +	the current branch.)
> ++
> +This means that `git reset <paths>` is the opposite of `git add
> +<paths>`, provided that the <paths> were already tracked.

The above is a clearer description of "with-path" mode than what we
currently have.  I doubt that we need ", provided that...", though.  

"git reset HEAD frotz" from a head commit without frotz gets rid of frotz
from the index, no?
