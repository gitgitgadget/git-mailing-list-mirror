Received: from delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1011CBA
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916452; cv=none; b=c6EcCMfk2STYBJLFHSxynIWG86qBa5z0x0ZDrdAUrnhtlB6qTu8ZeZtaDDzqk6+DE6gM+ki87Z18iuYONwABFs0hzfPJu4OJRmwhLPQYPTD8abU6AIL83kEVWAiG8eq2H7v7U7e1JS9SWayT2OxB8Rfb8sKvrqjHMIRooAOhdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916452; c=relaxed/simple;
	bh=pqJYfe18eYNdENAxBqtGgAPU19k27u6bHIzGTzd7p88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq7Du9cPYQmkNyVzL1GhKKlSkQLXJFvdXjGn4FreX6jGxTff5wgCzQNUEVg5FHb7xm8GaeAfCF1EudRB0sGFkLXfftf4zKLtE3BKV7Tyotf2LBH/VHWQGWshHDhg4Nkn+WBR/ta6x3VxTqSgStWkNjWJShBlWB6MdlYC+ad/iv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=JPb5k0JM; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="JPb5k0JM"
Date: Tue, 31 Mar 2026 02:20:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774916442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMG9fUUvd/eQx8QXQpgyW0/FG+W+vx+d67yh8aNKjCw=;
	b=JPb5k0JMPFwtlryzDQLHwYjkI+SQ0aMotVQBBpCLvaQ+M3ZB0CpG5Yky2VaR4yjIhi+H99
	V/MJjwcVkfWYx46fctNgeHMmIt5/Mbfx0q78Ycm/uwaM88sMqAg08P8Qv0lxTZUhXrm8dJ
	WXMcmUqk1I7VkFH30qM4jtrVjxm2bwlGCI22i7DV9jV8vqeNPNRO22EM6n1tPQFS1JDt57
	nTFD8u0EEX0bpzqvfQ85Gw8vm1aioZAz39Q3OzkFAZsM+16Nt96Fe4r2RytajaAYnGfcJv
	zZeleGCgVURejadi5UTrntCj8A96PONEvenl5GdfLRUZO6bEheD6Q4P8sqi0Sw==
Authentication-Results: delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #12)
Message-ID: <acsRsp_dy1_Cd5Qp@exploit>
References: <xmqqcy0k6epp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy0k6epp.fsf@gitster.g>
X-Spamd-Bar: --

On Mon, Mar 30, 2026 at 05:10:42PM -0700, Junio C Hamano wrote:
> * mf/format-patch-commit-list-format-doc (2026-03-27) 3 commits
>  - format-patch: removing unconditional wrapping
>  - docs: fix --commit-list-format related entries
>  - Merge branch 'mf/format-patch-commit-list-format' into mf/format-patch-commit-list-format-doc
>  (this branch uses mf/format-patch-commit-list-format and mf/format-patch-cover-letter-format.)
> 
>  Doc updates.
> 
>  Will merge to 'next'.
>  source: <cover.1774640789.git.mroik@delayed.space>
>
> [...]
>
> * mf/format-patch-commit-list-format (2026-03-23) 9 commits
>   (merged to 'next' on 2026-03-24 at 0f5b6702eb)
>  + format-patch: --commit-list-format without prefix
>  + format-patch: add preset for --commit-list-format
>  + format-patch: wrap generate_commit_list_cover()
>  + format.commitListFormat: strip meaning from empty
>  + docs/pretty-formats: add %(count) and %(total)
>  + format-patch: rename --cover-letter-format option
>  + format-patch: refactor generate_commit_list_cover
>  + pretty.c: better die message %(count) and %(total)
>  + Merge branch 'mf/format-patch-cover-letter-format' into mf/format-patch-commit-list-format
>  (this branch is used by mf/format-patch-commit-list-format-doc; uses mf/format-patch-cover-letter-format.)
> 
>  Improve the recently introduced `git format-patch
>  --commit-list-format` (formerly `--cover-letter-format`) option,
>  including a new "modern" preset and better CLI ergonomics.
> 
>  Will merge to 'master'.
>  source: <cover.1774284699.git.mroik@delayed.space>
>
> [...]
>
> * mf/format-patch-cover-letter-format (2026-03-06) 5 commits
>   (merged to 'next' on 2026-03-09 at e872adca7b)
>  + docs: add usage for the cover-letter fmt feature
>  + format-patch: add commitListFormat config
>  + format-patch: add ability to use alt cover format
>  + format-patch: move cover letter summary generation
>  + pretty.c: add %(count) and %(total) placeholders
>  (this branch is used by mf/format-patch-commit-list-format and mf/format-patch-commit-list-format-doc.)
> 
>  "git format-patch --cover-letter" learns to use a simpler format
>  instead of the traditional shortlog format to list its commits with
>  a new --cover-letter-format option and format.commitListFormat
>  configuration variable.
> 
>  Waiting for the follow-on topic.
>  source: <cover.1772839973.git.mroik@delayed.space>

Hi, not sure how it works with incremental topics. Does this mean that
you won't merge mf/format-patch-cover-letter-format because it will be
merged anyway with mf/format-patch-commit-list-format? Does that mean
that you'll merge twice, once for mf/format-patch-commit-list-format and
a second time for mf/format-patch-commit-list-format-doc?

If that's the case I think you should not merge in
mf/format-patch-commit-list-format and wait for everything to be merged
with mf/format-patch-commit-list-format-doc. The latter is not just a
doc update, without it format-patch enforces the 72 character limit on
the commit list, not sure we want that in master.

Thank you
