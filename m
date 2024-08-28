Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1A4D108
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864902; cv=none; b=IncTapMFl98yEmrexG3mxahV2c1Cr6tpW66jK18u9EkThJSvt8Bh6hyOyy8detR+mAVwH8vSBKOAZj5C0ECO9KXntA8xeSVNWNQtaj/kM7cQPR/XiYYusjCgrLO5mFJ7ceS6sn9GiliBSLIy7nsL8h1tqr7aS50PASP4uIH/4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864902; c=relaxed/simple;
	bh=+QEUwEmjDeIIalkipqgH3Qz/QofUv4sTC0CcBQcu6gM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d1e3mzJ7qnARUqEjOeVSXBTMtHHAswQf3kDmRU3QO0I1HCwJPSriNW/QlEaHgO1BBa1hGQkFsRcKwUE8tVqo2V7E6u3EdWurn8U7mYdWWs8+hSjuI7hk/Kreyqs2SJnfND7uxzl/fC/3M79Og+L8MkQuCKJjWpDPrq8RajItUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pZiq3phn; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pZiq3phn"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA0643BE27;
	Wed, 28 Aug 2024 13:08:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+QEUwEmjDeIIalkipqgH3Qz/QofUv4sTC0CcBQ
	cu6gM=; b=pZiq3phn0qjgv43Iodjg6J+wTGlOyvmegARly2WxD6MqKFMIMoESR/
	3Iv2gdAlrNmbnSXCkjFCbJnuTyWMDyCXn7nJNKC8D5SKMzHuOvjlkD9M81QIL7WL
	J8OwrQYfSSR1yC+5dljeObXwaYPZ5MpDb7GT37d+Ni103bZoxV5a4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B28943BE26;
	Wed, 28 Aug 2024 13:08:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33A7B3BE25;
	Wed, 28 Aug 2024 13:08:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ToBoMi <tobias.boesch@miele.com>
Subject: Re: [PATCH v2] git gui: add directly calling merge tool from gitconfig
In-Reply-To: <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com> (ToBoMi
	via GitGitGadget's message of "Wed, 28 Aug 2024 08:31:56 +0000")
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
	<pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
Date: Wed, 28 Aug 2024 10:08:15 -0700
Message-ID: <xmqq7cc01sow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E5A5120-6560-11EF-BC3B-BF444491E1BC-77302942!pb-smtp20.pobox.com

"ToBoMi via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: deboeto <tobias.boesch@miele.com>

Use the same ident (human readable name plus e-mail address) you
have on your Signed-off-by: line below for this "From: " in-body
header.

> git gui can open a merge tool when conflicts are
> detected (Right click in the diff of the file with
> conflicts).
> The merge tools that are allowed to
> use are hard coded into git gui.
>
> If one wants to add a new merge tool it has to be
> added to git gui through a source code change.
> This is not convenient in comparison to how it
> works in git (without gui).
>
> git itself has configuration options for a merge tools
> path and command in the git config.
> New merge tools can be set up there without a
> source code change.

Even if you configure an unknown tool, it would not get any benefit
from what git-{diff,merge}tool--lib.sh gives the known diff/merge
backends, would it?  Instead of a more thorough support for known
tools done in setup_tool(), an unknown tool would be handled by
setup_user_tool() in git-mergetool-lib.sh which gives somewhat
degraded support.

So "can be set up without" may be true, but giving an impression
that a tool that is set up like so would work just like a known tool
is misleading.

By the way, we do ask contributors to avoid overly long lines,
50-col limt is a bit overly short and makes the resulting text
harder to read than necessary.

> Those options are used only by pure git in
> contrast to git gui. git calls the configured
> merge tools directly from the config while git
> Gui doesn't.
>
> With this change git gui can call merge tools
> configured in the gitconfig directly without a
> change in git gui source code.
> It needs a configured merge.tool and a configured
> mergetool.cmd config entry.

OK.

> gitconfig example:
> [merge]
> 	tool = vscode
> [mergetool "vscode"]
> 	path = the/path/to/Code.exe
> 	cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
>
> Without the mergetool.cmd configuration and an
> unsupported merge.tool entry, git gui behaves
> mainly as before this change and informs the user
> about an unsupported merge tool, but now also
> shows a hint to add a config entry for the tool
> in gitconfig.
>
> If a wrong mergetool.cmd is configured by accident
> it is beeing handled by git gui already. In this

"is beeing" -> "is being", but "it gets handled by Git GUI already"
should be sufficient.

> case git gui informs the user that the merge tool
> couldn't be opened. This behavior is preserved by
> this change and should not change.
>
> Beyond compare 3 and Visual Studio code were
> tested as manually configured merge tools.

Quote proper nouns for readability?  E.g. 

    "Beyond Compare 3" and "Visual Studio Code" were ...

Thanks.
