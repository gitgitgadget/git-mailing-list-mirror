From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] SubmittingPatches: add convention of prefixing
 commit messages
Date: Sun, 16 Dec 2012 15:15:10 -0800
Message-ID: <7vobhtpp1d.fsf@alter.siamese.dyndns.org>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
 <1355686561-1057-2-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 00:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkNQj-0001eA-S5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 00:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab2LPXPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 18:15:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab2LPXPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 18:15:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A54FA4F9;
	Sun, 16 Dec 2012 18:15:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B1Lk+cw5ys4I5xRIYZRLY2ME2TU=; b=I+/rEi
	pcDSw5aTfGpJfUPm27LJCM6TMNTjO1By+A9FyCQpDrjYbCKQ9/7KfFd6P24EoC5Z
	6vyjZaAfmpNM9DlpDKzghU0XwD82GyTsKo99+II4jAN2pezQnRPnTjsP+G0LuLkI
	ttOploQJhvhhAAPzQtSBTdjXSbN/rduT8m9HM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kOdEGV9cftTcvj9F/Z2ha7ge2MO5uD+W
	kcn3UNPq00ta0lq9zbWkoo4hpmI01anOJJXr9MPW6qqnVytp3folchbhzI41fCR7
	h2Jjc9mCKu3MFQmTpSfJFF5o57YfLf6YTf7wEJnMzqy8NI+T4G2NbAFIaGBohaqn
	bH8nJp1CrwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56B4BA4F7;
	Sun, 16 Dec 2012 18:15:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A537FA4F4; Sun, 16 Dec 2012
 18:15:11 -0500 (EST)
In-Reply-To: <1355686561-1057-2-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Sun, 16 Dec 2012 19:35:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70E0472E-47D6-11E2-922E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211618>

Adam Spiers <git@adamspiers.org> writes:

> Conscientious newcomers to git development will read SubmittingPatches
> and CodingGuidelines, but could easily miss the convention of
> prefixing commit messages with a single word identifying the file
> or area the commit touches.
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  Documentation/SubmittingPatches | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 0dbf2c9..c107cb1 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -9,6 +9,14 @@ Checklist (and a short version for the impatient):
>  	- the first line of the commit message should be a short
>  	  description (50 characters is the soft limit, see DISCUSSION
>  	  in git-commit(1)), and should skip the full stop
> +	- it is also conventional in most cases to prefix the
> +	  first line with "area: " where the area is a filename
> +	  or identifier for the general area of the code being
> +	  modified, e.g.
> +	  . archive: ustar header checksum is computed unsigned
> +	  . git-cherry-pick.txt: clarify the use of revision range notation
> +	  (if in doubt which identifier to use, run "git log --no-merges"
> +	  on the files you are modifying to see the current conventions)

Thanks; I have to wonder if these details should be left in the
longer version to keep the "short" one short, though.

We should probably add "learn from good examples." (aka "read 'git
log' output and the pattern should be obvious to you") as the first
item to this list, too.

>  	- the body should provide a meaningful commit message, which:
>  	  . explains the problem the change tries to solve, iow, what
>  	    is wrong with the current code without the change.
