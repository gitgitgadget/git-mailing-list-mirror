Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cENQoDDE"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF710D
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 19:04:39 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C47761C9A9B;
	Sat, 25 Nov 2023 22:04:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qPreL0vQGrGo9ksDjy3i/BB5BVVaGTBE6IVcDq
	Bsm3o=; b=cENQoDDEQ2zlbFxzpEEzNyLBJFb5wf0t17ICwRC7cWcZkP5O0EREux
	o05XzHlHRTgNEr48XXR3m6pg2WoHp9NK+2rj0wAP673HsbGvF7xntaj7n2QALJD+
	Dewma0raKJ/ZauUyiuRIdz0nG8B+RCpQNlucsoJxFetQKL/43+9Po=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA9E31C9A9A;
	Sat, 25 Nov 2023 22:04:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 077001C9A99;
	Sat, 25 Nov 2023 22:04:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Krause <mk+copyleft@pimpmybyte.de>
Cc: git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: make the gitfile syntax easier to discover
In-Reply-To: <20231124194711.563720-1-mk+copyleft@pimpmybyte.de> (Marcel
	Krause's message of "Fri, 24 Nov 2023 20:47:12 +0100")
References: <20231124194711.563720-1-mk+copyleft@pimpmybyte.de>
Date: Sun, 26 Nov 2023 12:04:33 +0900
Message-ID: <xmqqr0kd5i66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 872B54E2-8C08-11EE-A3AE-25B3960A682E-77302942!pb-smtp2.pobox.com

Marcel Krause <mk+copyleft@pimpmybyte.de> writes:

> It took way too long for me to find the syntax expected for a gitfile.
> My search engine found the gitglossary manpage which defined the term
> but had no hints about syntax.
> Thus here I add a mention of gitrepository-layout.

Everything you wrote is not very interesting or relevant story we
want to see in order to explain and justify this change.  The title
itself is sufficient, i.e. it had poor visibility, and you fix it by
giving it better visibility.

A more relevant is why you needed to find out what the former should
be in the first place.  "git submodule init" and "git worktree add"
would create them as necessary without you needing to know about the
exact implementation.

> Signed-off-by: Marcel Krause <mk+copyleft@pimpmybyte.de>
> ---
>  Documentation/gitrepository-layout.txt | 8 ++++----
>  Documentation/glossary-content.txt     | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index 1a2ef4c150..c52b8564e3 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -23,10 +23,10 @@ A Git repository comes in two different flavours:
>  
>  *Note*: Also you can have a plain text file `.git` at the root of
>  your working tree, containing `gitdir: <path>` to point at the real
> -directory that has the repository.  This mechanism is often used for
> -a working tree of a submodule checkout, to allow you in the
> -containing superproject to `git checkout` a branch that does not
> -have the submodule.  The `checkout` has to remove the entire
> +directory that has the repository.  This mechanism is called a 'gitfile'
> +and is often used for a working tree of a submodule checkout, to allow
> +you in the containing superproject to `git checkout` a branch that
> +does not have the submodule.  The `checkout` has to remove the entire
>  submodule working tree, without losing the submodule repository.

Do not unnecessary rewrap existing text, only to insert a few words,
to force reviewers read a lot more than needed.

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 5a537268e2..e5f55bf670 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -184,6 +184,7 @@ current branch integrates with) obviously do not work, as there is no
>  [[def_gitfile]]gitfile::
>  	A plain file `.git` at the root of a working tree that
>  	points at the directory that is the real repository.
> +	See linkgit:gitrepository-layout for the syntax.

Running "git grep linkgit:gitrepository-layout" would help you find
the right way to spell this one, I think.

Thanks.
