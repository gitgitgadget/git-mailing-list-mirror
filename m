Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC438DC7
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674741; cv=none; b=c0WyGEZRzsDvyWNXViXVRt1yeQaHBvokZsIt1QfdTNY1CI0Axlrx1OMQPlcvK2/r6KojBjqKUaqZHB4a2Tm5XEXC2LOfkYj0Gz2swTZNMJW9InY+/6nL9vYHcgM0Xg7KYrzQ5tgSRcZYh4VyNNs3bIfYsbgAY4qubMloM+bIpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674741; c=relaxed/simple;
	bh=zI7W5PZpbKFJoga9ALkDEFMclmJMBa8qzBbv4fMljV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6XEQ9xyODEBvPtw0eKbR41TL9HVbkN1FYID5GzN20c79INOEG7J9WzTjmHzxF2wXnNv7c1D9REDZDtqMUWKdCFw0cjspJOZVBd32Cef/jTz2oyO3fOdh6zCr18FDOqeJMggiWh2t7tVcCsbsqVdLLtJMk2qlgTdIy3jcxpddeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CjQ0gLtj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CjQ0gLtj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EB7021398;
	Mon, 22 Jul 2024 14:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zI7W5PZpbKFJoga9ALkDEFMclmJMBa8qzBbv4f
	MljV0=; b=CjQ0gLtj9kSq9ObhM46EPpBSoUOQBjg/K4AXcML8WUdh/rFgALCCH4
	+dL3cf0rZG4rZVaoB3akbsyG+3yWZu5hl3mLn3rnYYA0J9OnTzbDRPtFyIvpP1bA
	gaS0nlezTwQoZJkfdV2wcKq0SF6CWTXslQbvEZasCsICF/88X0Lew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 070AE21397;
	Mon, 22 Jul 2024 14:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B03821396;
	Mon, 22 Jul 2024 14:58:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org,  Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: Unbalanced closing paren in help of git commit
In-Reply-To: <871q3nx7f3.fsf@posteo.net> (Tomas Nordin's message of "Sun, 21
	Jul 2024 12:21:04 +0000")
References: <87o7792xgu.fsf@posteo.net> <xmqqcynnejwl.fsf@gitster.g>
	<871q3nx7f3.fsf@posteo.net>
Date: Mon, 22 Jul 2024 11:58:54 -0700
Message-ID: <xmqqed7lb6dt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 72471118-485C-11EF-89A6-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Tomas Nordin <tomasn@posteo.net> writes:

> So then I make an attempt to provide a patch to remove that closing
> parenthesis. Please tell if it should be done differently somehow. The
> patch was done on top of maint.
>
> From 5da052f43b119949c0ac0c7c3047542bc7474c17 Mon Sep 17 00:00:00 2001
> From: Tomas Nordin <tomasn@posteo.net>
> Date: Sun, 21 Jul 2024 13:16:50 +0200
> Subject: [PATCH] doc: remove dangling closing parenthesis

We do not "attach" patches to an e-mail, like this.  Please visit 
https://lore.kernel.org/git/ and check patch messages from others.

An example:
  https://lore.kernel.org/git/e048ef54-5824-452d-ab1f-233581711f4e@web.de/

Your Subject: looks good.  It shows that the author read (at least
some parts of) Documentation/SubmittingPatches.

> * Documentation/git-commit.txt:
>   The second line of the synopsis, starting with [--dry-run] has a
>   dangling closing paren in the second optional group. Probably added by
>   misstake, so remove it.

We do not work file-by-file.  If any reader wants to know which
paths were affected, they can see the diffstat before the patch.

I think what you wrote is just fine otherwise; just drop the "*
Documentation/git-commit" line, dedent the body of the paragraph,
and typofix the "misstake".

Thanks.


> Signed-off-by: Tomas Nordin <tomasn@posteo.net>
> ---
>  Documentation/git-commit.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 89ecfc63a8..c822113c11 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> -	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
> +	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
