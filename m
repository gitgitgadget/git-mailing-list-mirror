From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reword -M, when in `git log`s documention, to suggest
 --follow
Date: Thu, 31 Dec 2009 20:35:38 -0800
Message-ID: <7vhbr6phlx.fsf@alter.siamese.dyndns.org>
References: <1261428059-31286-1-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Fri Jan 01 06:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQZed-0006kZ-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 06:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885Ab0AAEfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 23:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802Ab0AAEfw
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 23:35:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab0AAEfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 23:35:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4128C9A1;
	Thu, 31 Dec 2009 23:35:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lubGlHYty2LmAC2YmQp9SDaM0A0=; b=U7/NPz
	ryNwwfT+bFgLTCUEE0qxI9Axvqy7rbD7aSiQwmDrrK5cTG+2+x8io+W+d8eJHI1c
	iBmdguQnmW2EwHp1mZYjdaj/WCxE3btzjkuX3Ihf791Rugd3SYaJDPslaTjbsni6
	9bVlpKF1uAR0ja3rdEaq3DnUN1N++LR8MkTdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=spB5phuPbSp8fXbNFjrowXlB1BJoePGC
	kL4xF2hn7y4qcIQtp16LPSyAyG/iuug/Ti27Q5QXI4yYwSDv7bmTE5yJxTdS5fIt
	h3Ta+hCmMSecjJPYp7Y0k1d3Kyx0gwOqSMLKGH0Da9x1r9UdMMWVOMdXh+Jeu2OY
	sFlAsEHjUds=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 768D88C9A0;
	Thu, 31 Dec 2009 23:35:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6E418C99F; Thu, 31 Dec
 2009 23:35:39 -0500 (EST)
In-Reply-To: <1261428059-31286-1-git-send-email-alex@chmrr.net> (Alex
 Vandiver's message of "Mon\, 21 Dec 2009 15\:40\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1EC1A528-F68F-11DE-AB93-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135996>

Alex Vandiver <alex@chmrr.net> writes:

> The documentation for `git log` is sadly misleading when it comes
> to tracking renames.  By far the most common option that users
> new to git want is the ability to view the history of a file
> across renames.  Unfortunately, `git log --help` shows:
>
>     NAME
>            git-log - Show commit logs
>     [...]
>     OPTIONS
>     [...]
>            -M
>                Detect renames.
>
> ...and most users stop reading there.  Unfortunately, what
> they're generally looking for comes significantly later:
>
>     [...]
>            --follow
>                Continue listing the history of a file beyond renames.
>
> Signed-off-by: Alex Vandiver <alex@chmrr.net>
> ---
>  Documentation/diff-options.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 8707d0e..bcbad88 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -175,7 +175,13 @@ endif::git-format-patch[]
>  	Break complete rewrite changes into pairs of delete and create.
>  
>  -M::
> +ifdef::git-log[]
> +	Show renames in diff output.  See `--follow` to track history
> +	across renames.

With "s/history/history of a single file/", I think the new wording makes
more sense.

> +endif::git-log[]
> +ifndef::git-log[]
>  	Detect renames.
> +endif::git-log[]

Also we probably should do s/Detect renames/Show renames in diff output/
to match the earlier change.

>  
>  -C::
>  	Detect copies as well as renames.  See also `--find-copies-harder`.
> -- 
> 1.6.6.rc0.363.g69d13.dirty
