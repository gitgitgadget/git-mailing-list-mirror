Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061429E0E5
	for <git@vger.kernel.org>; Sat, 23 May 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779524352; cv=none; b=q4t4kcCdT/oM8Bv8GdSB7a3ox99oaNSWgxgi40Mxp5gS+dwWTveNkQXX+jyuqjLIVFlHmFCp2GY1HW4O67apg4t9AdpHydMJJ+mpTCC/nFNt+8AV+pUCvFuFFsAiUZM8udXH5q2jopImibDE1H4IBYSnUDmouyGUWWLqFTGZ2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779524352; c=relaxed/simple;
	bh=HSVIdeCSXlw1L9hsUZmrGy/8c3kGa6V1wJ5dUGEewdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrdSU1Vnn5TaOk5D5739fzpWmUhmTDlOyMuman/cOjh252CMONeyVUXdNdyCt0ZGa9qs1kjD+gkYYD2oVyH+5iarWoj5HMBGqvp18R4Yieom86wRtF6a7ap6nQEPL3uSZ7UDvzYIYEhXzQhI0XKJY31ivlTxB455GUf3WKnEGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gMw5v1MtBzRnlL;
	Sat, 23 May 2026 10:18:59 +0200 (CEST)
Message-ID: <b332c7d9-c86b-4d4b-a873-1600d910a237@kdbg.org>
Date: Sat, 23 May 2026 10:18:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] git-gui: guard set/unset of GIT_DIR and
 GIT_WORK_TREE
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-2-mlevedahl@gmail.com>
 <e5a9a410-bf62-4afd-9560-2dea01fe936b@kdbg.org>
 <eb748327-6652-4477-82bb-9db9f8388ec0@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <eb748327-6652-4477-82bb-9db9f8388ec0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.05.26 um 13:54 schrieb Mark Levedahl:
> The manual page is incomplete: if the repository has set core.worktree=/somehere, that is
> the root of the worktree and the current directory is always ignored. git rev-parse will
> report /somewhere as the answer to --show-toplevel regardless of current directory, even
> if inside the gitdir, and even if GIT_DIR is used.
> 
> The user can override with GIT_WORK_TREE, and if so we must keep GIT_WORK_TREE in the
> environment if it was set. [...]

Oh, well, these intricacies! Let's scrap my patch and keep yours.

The other patch that removes cd $_gitworktree from do_gitk should still
be good, I think.

-- Hannes

