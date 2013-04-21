From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
Date: Sun, 21 Apr 2013 12:06:51 -0700
Message-ID: <7vip3fsnxw.fsf@alter.siamese.dyndns.org>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
	<1366534252-12099-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 21:07:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTzbG-00015A-Ri
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 21:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab3DUTGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 15:06:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039Ab3DUTGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 15:06:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9882A17828;
	Sun, 21 Apr 2013 19:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=inWeDhvplppm37RN8dM7/VwGVDE=; b=b1va4druIXYJjB7MMTSr
	f1VOiw9KVxJrfKb7roRClWI1Mc/n9z3aNxAaRmI7cfi9A5JlsIQ4gNWjODoOAN2L
	ILPSOGbCOUluauja4FhuGeWZw1X0TWpY/gCBlujqaIXM3UxFt13Do1rH0DXqsLmf
	99Ed5Ds0ELkddxPpEH2KwPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oVTTaPkbW72uU0aI81jc3muLf0KVZeH5mquRhAQFiz72Sp
	h/J42yoRYV6OOTcLWa43BPncRaU0o6NK0uIa1Tym/G6SWMkmWefGsny5/PcanV7b
	efNVNAuQD5Lhhc26OCk31d5fMgjYMIV+sEAMFrzmEB670EpZnlaPBa96YLJBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 905FE17827;
	Sun, 21 Apr 2013 19:06:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9627517824;
	Sun, 21 Apr 2013 19:06:52 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A064358A-AAB6-11E2-AC9C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221966>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index c7f7f51..2a66518 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
>  SYNOPSIS
>  --------
>  [verse]
> -git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
> -'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] <commit>...
> +git log --pretty=short | 'git shortlog' [<options>]
> +'git shortlog' [<options>] [<revision range>] [[\--] <path>...]

You will need to update what you added in [PATCH 2/7] to
builtin/shortlog.c to match this in this patch.

>  DESCRIPTION
>  -----------
> @@ -56,6 +56,23 @@ OPTIONS
>  If width is `0` (zero) then indent the lines of the output without wrapping
>  them.
>  
> +<revision range>::
> +	Consider only commits in the specified revision range.  When no
> +	<revision range> is specified, it defaults to 'HEAD' (ie. the
> +	whole history leading to the current commit).  master..next
> +	specifies all the commits reachable from 'next, but not from
> +	'master'. For a complete list of ways to spell
> +	<revision range>, see the "Specifying Ranges" section of
> +	linkgit:gitrevisions[7].

Match the text you modified in 'log.txt' in [PATCH 5/7], perhaps?

> +[\--] <path>...::
> +	Consider only commits that are enough to explain how the files
> +	that match the specified paths came to be.  See "History
> +	Simplification" below for details and other simplification
> +	modes.

Have you read the resulting "git shortlog --help"?  Do we even have
"below"?

> ++
> +Paths may need to be prefixed with "\-- " to separate them from
> +options or the revision range, when confusion arises.
>  
>  MAPPING AUTHORS
>  ---------------
