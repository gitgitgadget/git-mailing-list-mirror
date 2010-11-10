From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/git-pull: clarify configuration
Date: Wed, 10 Nov 2010 09:37:38 -0800
Message-ID: <7voc9xhyfx.fsf@alter.siamese.dyndns.org>
References: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 18:38:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGEcW-0006oa-C0
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab0KJRhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 12:37:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab0KJRhr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 12:37:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40F9C23EE;
	Wed, 10 Nov 2010 12:37:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ceVZFOquPSHLbtrQBH67mBTnB+k=; b=YcmypT
	bf2pWJCzHWoU2FoTWyfOQFZ6ix+bIw1mW8FL4ZvBUkMGFdBd9egM9bcMyvByYfk+
	Dx8+iBCLAWvoiXct+w6KsJDpcyPwGXiK5uvqRDIkXNACxf615WdxqHtRha19m2KP
	EY58seshEk3LCMAITohGQp0cQD4BIaKznZzto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=InMWNAJODx2fINY/iEGcrMkGxlImLjq7
	Ep/C/V3XWNA6JBAcBLsvZMDOywiHmsnDC432+VE6CYsHOe2g3GRmmugoPzaMVh3A
	uW/aECmk67xUpeuycXiI6gRw8lAGW8+LgFBMkigFcQvfMzmDcOt/gLI2XYbHGcgY
	J19lJQyc2Qg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1DFC423ED;
	Wed, 10 Nov 2010 12:37:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D2D223EA; Wed, 10 Nov 2010
 12:37:44 -0500 (EST)
In-Reply-To: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Wed\, 10 Nov 2010 08\:13\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BE9CA82-ECF1-11DF-8D44-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161164>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index c50f7dc..055126e 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -92,12 +92,15 @@ include::merge-options.txt[]
>  :git-pull: 1
>  
>  --rebase::
> -	Instead of a merge, perform a rebase after fetching.  If
> -	there is a remote ref for the upstream branch, and this branch
> -	was rebased since last fetched, the rebase uses that information
> -	to avoid rebasing non-local changes. To make this the default
> -	for branch `<name>`, set configuration `branch.<name>.rebase`
> -	to `true`.
> +	Instead of merging, rebase the current branch on top of the
> +	upstream branch after fetching.  If there is a remote-tracking
> +	branch corresponding to the upstream branch and the upstream
> +	branch was rebased since last fetched, the rebase uses that
> +	information to avoid rebasing non-local changes.
> +
> +	The default behavior is to merge rather than rebasing, but it
> +	can be overridden per branch with the `branch.<name>.rebase`
> +	configuration item (see git-config(1)).

The explanation looks correct in the sense that it does not say anything
incorrect, and the description of non-local change exclusion in the first
paragraph is more readable, I think.

But I am not sure if we want a separate paragraph here only to repeat a
half of what the second paragraph in the DESCRIPTION section already said.
The "default is merge" is implied by "Instead of merging" at the beginnig
of this part anyway.

Also have you tried to actually format this and checked the result before
submitting the patch?

Perhaps doing it like this may be better (no I didn't run AsciiDoc on it).


--rebase::
	Rebase the current branch on top of the upstream branch after
        fetching.  If there is a remote-tracking branch corresponding to
        the upstream branch and the upstream branch was rebased since last
        fetched, the rebase uses that information to avoid rebasing
        non-local changes.
+
See `branch.<name>.rebase` in linkgit:git-config[1] if you want to make
`git pull` always use `{litdd}rebase` instead of merging.
