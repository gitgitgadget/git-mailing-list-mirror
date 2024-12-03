Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73FB13B59B
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195426; cv=none; b=CqLGBIqpuTaEO+0WDxITVKn25VrdBxmMRjTFN8H+G8Iw3Hot0StE9v3EyY5NA/9euUt9kLXniBo2BTGmu3oC0A1WKndn3a9a1/RZzeNr0fZcLt6nethu77jqDGxa4d65eSEuol4RPtsMLMGRK1gzkhhhZeN8z7R6bLwfB/KOexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195426; c=relaxed/simple;
	bh=+KpeYRhcD62pS/R1qLkSprkdZOxwNcwdNAyWhs2DKpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lB4b50yFnRCwuOB2LgIgZSCiz1tmbrj4JvO3S76/LfEPzH0iHGu0ftBSKn0j+DidEQm9NxX5573AG/3TVSBZhCC6Xe/M2Tw91jYv3rbnY3nbdiZe9PA3jIOoGZWfeD34MjPfEYIFNDMvG0Wb+YX0UZPHGi1/d3yLXt1qyyfUwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=stmmu6ek; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="stmmu6ek"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EC391140220;
	Mon,  2 Dec 2024 22:10:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 02 Dec 2024 22:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733195422; x=1733281822; bh=twJ9CNNZjkLytKc4CtQW8tKOcfTHJVH0pPM
	J+BWnrHU=; b=stmmu6ekcP8wxIpED3kZGDh8Ihnj9nG7hhYdOKEJrzNExiBgBgB
	gSmbUMWoNE9Yi1rrpVFHqfyFhsX0eb7b4iFk4DAK27vv+NABpvPinE41n7bVAl5h
	kaf0RqI1Gu/8hGnl8VqMoQgdUyJ/JGx5HP09m49sX6BQVmXfK7EGhdgSXZJsLiiT
	zQCPwjNB5IAuEQQ7p0G2iIYAvMBC+KKCR1rPJg0I+E0fgNcG4FSPCjoP/5hfF3At
	SKfyEU0AWEjiAKWOlOnVdQhv21EOAwTZwSiV0h1Nqxn/ufOQmTrLkQfWD8TORYbD
	7UDC0ak0bd/HP5Fy0Xt45VEcqwZzqiz4SyA==
X-ME-Sender: <xms:nnZOZ3wXVR9V3yXUkyjAmBnWi7-YJDMula8OTVjCXMV7guAXPWY7xQ>
    <xme:nnZOZ_SDmkDr2bKyKaFtAPnOl8YaCT9JidwP0oGg0HaS9uYMUPE0Hy1Y5x95QJUg5
    bKciMYAS4H109kAyQ>
X-ME-Received: <xmr:nnZOZxW_p4gXLYq6g5x4rfTCorrZ6mfF8pEN14kiXfkEbCWlOA_7wkmPLfSGNLqluyPSVJzf49Q-gGAMECIId5tlrB8mMI-Uzf8pMTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nnZOZximWIdy0sXsNYgg5VKKv1ZSnOL5zbIUROPdYDk-ah87Qi757Q>
    <xmx:nnZOZ5AMXHCTOFv8hJvWs_3eZa3jg-ZFwZ56JIuK0DPKv4Tbmh5rAA>
    <xmx:nnZOZ6JVIYBwaHkqVwxmRzHrtASzgSSqVOWr5ezPtAq55BK-ouBovg>
    <xmx:nnZOZ4CTFmHvkfVXSqU-Ol5enE8ncQpuj2ynaW-140Kmi0d8Fa9gpQ>
    <xmx:nnZOZ08S96-6LFKWWPkuXAKaFoHTESO3OrJzzrpGRHd8ARvTdmIKglMX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 22:10:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com
Subject: Re: [PATCH 3/3] index-pack: commit tree during outgoing link check
In-Reply-To: <2f2f0db78bf85c14ef132e1924ab5021298aace3.1733170252.git.jonathantanmy@google.com>
	(Jonathan Tan's message of "Mon, 2 Dec 2024 12:18:40 -0800")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<2f2f0db78bf85c14ef132e1924ab5021298aace3.1733170252.git.jonathantanmy@google.com>
Date: Tue, 03 Dec 2024 12:10:20 +0900
Message-ID: <xmqqa5ddfomb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Subject: Re: [PATCH 3/3] index-pack: commit tree during outgoing link check

> Commit c08589efdc (index-pack: repack local links into promisor packs,
> 2024-11-01) seems to contain an oversight in that the tree of a commit
> is not checked.

I am having a hard time linking the subject with the statement.  The
verb "commit" should probably be something else, as you are not
creating a tree object while checking, but I am not sure?

> The fix slows down a fetch from a certain repo at
> $DAYJOB from 2m2.127s to 2m45.052s, but in order to make the fetch
> correct, it seems worth it.

And "the fix" is not described so a reader is left wondering.  Is
the fix for an oversight of not checking merely to check it?  IOW,
is

    c08589efdc made outgoing links to be checked for commits, but
    failed to do so for trees.  Make sure we check both

what is happening?

> In order to test this, we could create server and client repos as
> follows...
>
>  C   S
>   \ /
>    O
>
> (O and C are commits both on the client and server. S is a commit
> only on the server. C and S have the same tree but different commit
> messages.)
>
> ...and then, from the client, fetch S from the server.
>
> In theory, the client declares "have C" and the server can use this
> information to exclude S's tree (since it knows that the client has C's
> tree, which is the same as S's tree).

OK.

> However, it is also possible for
> the server to compute that it needs to send S and not O, and proceed
> from there;

If O, C, and S have all identical trees, then wouldn't such a test
work well?  At that point it does not matter which between O and C 
the server bases its decision to send S but not S's tree on, no?

In any case, will queue.  Thanks.


> therefore the objects of C are not considered at all when
> determining what to send in the packfile. In order to prevent a test of
> client functionality from having such a dependence on server behavior, I
> have not included such a test.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 58d24540dc..338aeeadc8 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -838,6 +838,7 @@ static void do_record_outgoing_links(struct object *obj)
>  		struct commit *commit = (struct commit *) obj;
>  		struct commit_list *parents = commit->parents;
>  
> +		record_outgoing_link(get_commit_tree_oid(commit));
>  		for (; parents; parents = parents->next)
>  			record_outgoing_link(&parents->item->object.oid);
>  	} else if (obj->type == OBJ_TAG) {
