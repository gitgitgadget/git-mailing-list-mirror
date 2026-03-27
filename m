Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27982384258
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640939; cv=none; b=O/6NwmVjTxJtajwPYnAlmEPdALwyv67MgmWnu0E/6c5w9dKZTlHXRREx+BMG0adOkBK/MzUEscdWsRB9RtY6WoznPFTqbfwbEPX7B66JDwJW+OVx6k/RizYVkBVIxhfr0g7zqXpp3tAy8BUd/k5YUh7wOUf8T8dkpq7aWMSuATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640939; c=relaxed/simple;
	bh=ezXj5DlRzm6UEGuaEJsVfcP6vQCqrGGEQwxdR0PKFgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWwwuOpB0Nnyh1DMpHkWyvUGFaZQndaQk5HxzBGpWZ8vGMl+mqHMLz+4rhENu+dSKIfGgi7+05EwBMaw6xtm1fYwluxpbNyO/sCjiRoGOpnSFejSQFLeLZkEZ6j3fQP+Jjg9pDRALvo8AoQDwOClk7nuwOTN6WwAn3k1SB7135g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=P/hENv19; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="P/hENv19"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774640929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly5g/CSuZIZmfRhaPHAzzguwb/C1wbqk37/27bkaeHc=;
	b=P/hENv19GiM6lSA5Di6oizyPCJBcqBhTI7TPDhsWWkrFUPbgdVRIEBdsG4g6KKxZApb9Nv
	lS5BFBiRqIrdH6NDs1+qWY9eRAPsLCetCGZV8F0scL4HODR/1CqSfqR2Dc0EnX4XEHCom9
	w8wrhO0TuK8dd3rsqwMVDE9uiwQVqYJ6S3Pmkjir3BP3gKq8SBZjywxq3/QfmAkpW4fiKC
	OnAyHwAsKuXoP0t5ePFbAlNEwxMY3JgBlXBc5dJXfPweIw6dZfZ0wk/fYD5U4lBBFB3Zm9
	tC/SSm5+9OfEegeln8m2nhNfxjNBkhjDAhwKJDPyPEUWz2BS+j/w7yJZebtntQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] format-patch: remove wrapping and update docs
Date: Fri, 27 Mar 2026 20:48:08 +0100
Message-ID: <cover.1774640789.git.mroik@delayed.space>
In-Reply-To: <20260326200643.20251-1-mroik@delayed.space>
References: <20260326200643.20251-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

This series adds the missing default value for --commit-list-format in
the documentation and removes unconditional wrapping from the commit
list entries.

This series is based on top of 41688c1a23 (The 21st batch, 2026-03-25)
with the following series merged into it:
  - mf/format-patch-commit-list-format at 36c16a5b7f (format-patch:
    --commit-list-format without prefix, 2026-03-23)

[1/2] docs: fix --commit-list-format related entries (Mirko Faina)
[2/2] format-patch: removing unconditional wrapping (Mirko Faina)

 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc | 24 ++++++++++++------------
 builtin/log.c                       |  9 ++-------
 3 files changed, 15 insertions(+), 20 deletions(-)

-- 
2.53.0.1181.g1066ffbbbe

