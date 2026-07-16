Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA41313283
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196505; cv=none; b=F8f3UES5Ztq+V022RAu7On4noe5EXME0kLdNNN+aBHz7FT5Q/KsarbO1s1Aig0Srkmc7p9zVEBx9r3rKuQ7iDLxKZz43CEUNmT+/xg81ptQ2aDTwIu6U1x6O9sOkc9HkFo/9LEIlVqTDHkDairEzUZU7VQlGlAnqNzmLlQuXJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196505; c=relaxed/simple;
	bh=4FIbcz0LvKA3znHOXx5bnDdlp/PB159am9dNATNfCHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8j32umKTfE+r/JQM9K1Yi0QtTQ5s+IPxcX9QMS89WUDswzWcciyz3h8NpFpJN/UtEFW7PAiPjGg1prXE8YJOFVMMw20842/ShJylktU6eI9OI88+/+UYpmblyavPgTi0ti/Fx0KEJW8X6A072eiAVIkZC1qsnjaqvlMOnhW+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nnqImRx5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=csdkGSeq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nnqImRx5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="csdkGSeq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFA817A019A;
	Thu, 16 Jul 2026 06:08:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784196502;
	 x=1784282902; bh=g2ZnxvIFfi2OYj8yjcsrRGszEHpBXJALXVNNXkFgff8=; b=
	nnqImRx53RXOmEEVskl5GOgNghYfAj72eBCkgpuqeXr+Lo/5MrckFGit/KK3orvX
	570mor6KXtMClYtshbBBioSpNVjZoT52m8nYcLEdyS+FM849gM95HrwizR+9xUZL
	tz2ot3MpM1l8y/eg1e8KtgMRBMSzy5qq2V+c+Zsaetwqku/rmzid/AN4yIEaAt3z
	9svhtE1rJsgTvgvT5o3cMFnTMd7bliej4XjZ6O+1gbyT57sqaNF4PhtA5U9efvYG
	lozEQV6JzvfskLAFZ+J01biPn8tvqY+p8phuk7PiTRxCRQas8mhp4CcDoW+9t/0y
	M7QQmOHhgA3ZaEvgVlShmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784196502; x=
	1784282902; bh=g2ZnxvIFfi2OYj8yjcsrRGszEHpBXJALXVNNXkFgff8=; b=c
	sdkGSeq5BpUDztSsOsRT+HoBILfzW0nCFeHiTxlg305ybyhg/8zRWGjjD76wAwC+
	dV4vDlIv/DS3P6Y5BRoVEgMF3ewmnSK/3z7f88Xhar4BicJEPhlz5tHKEPsh34aN
	SWeaw88hbZAYhZcUwCUbNmzWyp2xSmLanpdFNr8SEbOkoV8Gzq7NfumXcFVQ0zfL
	T8ASs0rAjhkxeMEIgRbeQkVKxy7if/ahMY4jCCmlA0oalylNAZvc2iHRp2NJTiag
	4XghJ3kV2/KZotI2es9CB7c3eW5J0a+vREBSQmzA8mDV8n7xJpeevLMkWktJl3Ic
	rf9HLVuByXBZUJLeeXmkw==
X-ME-Sender: <xms:lq1Yagzrg8LFINIB4QP4q7jLY33FNzacJZ6Cp1XxIxwYwr2UbhP5BA>
    <xme:lq1YauT5UOObUdcBGN9-VMEpO88WsJB5PARE-Tz9CjrZAdmF_F4zcI2RgE76FDkIF
    UBVW9PMvQJKWnKe4w7vXyLSGnOJlX4abPS57MT0SxwIM1WgeItFjA>
X-ME-Received: <xmr:lq1Yao_Ma8iZ5INnSlwIjPM0tAYYjL3H5Sd3EqJHPcTnRauaxNEfjulHSZ392rMaXlTZuCN43I4fuHleJKpmbpIdV1Ji3my8tuTloNHT>
X-ME-Proxy-Cause: dmFkZTGj5/6XbeL8AfTJqF3bdK8JMpkG9zbuRm5v10uUiinMT1ahT86UiRm+Sfy6ZmOfNM
    58XQ3/L6qY4avPSiRLaRztYrW7ZS+Q4ZPZ8gfA0S6tnC3Z6vu1tK8Iq+DbsCCrmpUGKBDM
    pRhzirOZYmJotQFjBxvt+/DNf+LY6Ced/AVQTwu1ZM69+smYKsjbiDAeRaLe/Kp+cCtUyz
    7AgO3EHvK47VU31xZxThMdxv13fh58C4YBmSbnCOCxMyAcRwx3HZUWyAUPe2vkQmz+ZTgP
    OZLFABcIRO+70yau6rLT0P32PTylm7phmBW6dYk4fXig4EvZUxwf7qsodxUxN62GnIlkJ0
    aTATGWSHE2KcwghvOazo/xOJpeJYyCQzw7qMnXo2/iu4hqxdj54IvFmwifynE1uK5L9bNT
    QhQ7TcOuoDuyHuFc65nODVH/nQzxRvEzKgBMzJQtlN7vl2DJcgFGyUQGxQcJJL/xaFzTmE
    BLJbmqbdEavaILkIp2jJvQak28UtVmdqrPvCFtmu7bRD16XgL5iVuaTeTVQnTDNkVktWnr
    7UdjyCIwWvUn19M9WRHaFvnz23UkaVChcXwhmPtp/SJD6HxtzqXVoOAwR0K+g+zPPIvPhZ
    aRzAb/1h5/13eK3g5uD6/TP6FuKhdK3oYm4c9mUDERZTyAriu7kT3nhBIxXg
X-ME-Proxy: <xmx:lq1YasuQOqYuBRjnERSq3H7vMNhVgPddNrZDXCqej1SwU9cQimMQ0w>
    <xmx:lq1YagNZ7WzF2RQ6lI3OdUgym2QgT8kd0zDSnGBd0Qn0vlBXWsh1xA>
    <xmx:lq1Yaph4f3r1hMLkBiNxPKce4-RlPtBvOnAVkcWiu0yCYTosBsCJgg>
    <xmx:lq1Yaq693DFGqtPWlkLoNSCjwkWDCpBaxBzAEckb5ntmaXLEgLC1YQ>
    <xmx:lq1YakewEMBBXdUxcX0EUpvecVtNvJvsSBJietIRwp2TOrOPPre528Ue>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:08:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 877a1ab4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 10:08:19 +0000 (UTC)
Date: Thu, 16 Jul 2026 12:08:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Emin =?utf-8?B?w5Z6YXRh?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Greg Hewgill <greg@hewgill.com>,
	Micheil Smith <micheil@brandedcode.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Emin =?utf-8?B?w5Z6YXRh?= <eminozata@proton.me>
Subject: Re: [PATCH] stash: add 'rename' subcommand
Message-ID: <alitkCsplW_DIaRw@pks.im>
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>

On Thu, Jul 16, 2026 at 08:31:45AM +0000, Emin Özata via GitGitGadget wrote:
> From: =?UTF-8?q?Emin=20=C3=96zata?= <eminozata@proton.me>
> 
> There is no way to change the message of a stash entry after the
> fact.  The only option is dropping the entry and re-storing it by
> hand, which moves it to the top of the stash list and gets fiddly
> for deeper entries.
> 
> Add 'git stash rename <message> [<stash>]', defaulting to the
> latest entry like the other subcommands do.  It reads the object id
> and reflog message of the target entry and of the entries above it,
> drops them all like 'git stash drop' would, and stores them back in
> the same order, with the new message going to the target.  Position,
> contents and the reflog chain stay as they were.
> 
> The command checks every entry it is about to rewrite and refuses
> to start if one of them does not look like a stash commit, which
> can only happen when refs/stash was written to by hand.  Finding
> that out halfway through the sequence would lose entries.  Should a
> write-back fail anyway, the entry's object id is reported so it can
> be recovered with 'git stash store', and the command only reports
> success when the reflog ended up in the requested state.
> 
> This was proposed before: in 2010, as a "git reflog update" command
> that edited reflog entries in place [1].  When it came up again in
> 2013 [2], Junio rejected it on the grounds that reflogs are
> append-only recovery logs, and that whoever really cares about a
> stash message can pop and re-stash [3].  Michael Haggerty pointed
> out in that thread that refs/stash does not fit the description:
> its reflog is the primary data store for stash entries, and 'git
> stash drop' rewrites it all the time [4].  So this patch stays away
> from the reflog machinery entirely and does the suggested
> pop-and-re-stash workaround mechanically, without the detour
> through the working tree.

Hm. It's good to refer to to previous discussions. But I think it would
make sense to also document why explicitly _you_ want to have this
functionality. Like, what use case does it enable that you currently
cannot have right now? How is this different to what was proposed back
then that should make us reconsider whether or not to include it now?

> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index 50bb89f483..03f2e03096 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -163,6 +164,12 @@ with no conflicts.
>  	created by `export`, and add them to the list of stashes.  To replace the
>  	existing stashes, use `clear` first.
>  
> +`rename [-q | --quiet] <message> [<stash>]`::
> +	Change the message of a single stash entry.  The entry keeps its
> +	position and its contents.  _<stash>_ must name an entry by
> +	index (e.g. `stash@{1}`); renaming refreshes the reflog
> +	timestamps of the entry and of the entries above it.

I think "rename" is a bit of a misleading name, doubly so with the
recently introduced `git refs rename` feature that renames a reference.
I'd suggest "reword" instead.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index c4809f299a..94e66d6074 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1190,6 +1204,166 @@ out:
[snip]
> +static int do_rename_stash(struct stash_info *info, size_t idx,
> +			   const char *msg, int quiet)
> +{
> +	struct rename_data data = { .want = idx + 1 };
> +	size_t i, missing = 0;
> +	int ret = -1;
> +
> +	refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository),
> +					 ref_stash, collect_rename_entries,
> +					 &data);
> +	if (data.nr <= idx) {
> +		error(_("%s does not exist"), info->revision.buf);
> +		goto cleanup;
> +	}
> +
> +	if (!oideq(&info->w_commit, &data.entries[idx].oid)) {
> +		error(_("%s changed concurrently; try again"),
> +		      info->revision.buf);
> +		goto cleanup;
> +	}
> +
> +	/* refuse up front; do_store_stash() would die halfway through */
> +	for (i = 0; i < data.nr; i++) {
> +		struct commit *stash = lookup_commit_reference(the_repository,
> +							       &data.entries[i].oid);
> +
> +		if (!stash || check_stash_topology(the_repository, stash)) {
> +			error(_("%s does not look like a stash commit"),
> +			      oid_to_hex(&data.entries[i].oid));
> +			goto cleanup;
> +		}
> +	}

This loop here has potentially-quadratic runtime. Not so much with the
"files" backend, where we'll simply append the data to the log. But with
the reftable backend we'll basically end up writing each reflog entry
into a new table, and we'll end up compacting the tables many times
over.

> +
> +	while (missing <= idx) {
> +		if (drop_reflog_entry("stash@{0}"))
> +			goto restore;
> +		missing++;
> +	}

Same here, this will not perform well if you have a huge reflog.

We really should do all of this atomically, where we ideally delete the
old reflog and create the new reflog in a single transaction.

Thanks!

Patrick
