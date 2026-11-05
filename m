Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890916;
	b=gdO1OGowkRFOJ1N/ZobepKYcb4aYR538uBnGVkAU4sEU56ZA8n8gH0mw3thMxkH78FVT
	 EW8mflr1pN1qS31CVRVZ9Qi4c4GL8JnAOGYlTLuJzuMyeADmSGStLoIRlejBZ257qnHqI
	 Pwj7gEBFBfiSf2XbbF9S3bntL7wKq9V/vjzvAmu1Cqkc/xFIM8Bk2Sp7Ffx9ScbqyDUw8
	 ZYntnlCaKxOjlxd8/F5diKsh9OazMbWpdjpyDs/f9cmp5mWNUCiQgSX625m08dNAgMo4e
	 Dw2sAzUQQqqsfumuvufD2ZTZiHflq7PyMk5SvWd3+9grl/N6/l64P04hlofbVdkoh9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FB8VamKrqnmd54tZatH4ohs6GMQM7Aezf7gRWTTTQT0=;
	b=JM9G2wyTvoJa+W5Ld1rR+rv46IjHMbei5zijWpZ/8qR/QBhOptsnr7dreZanSHrZtnAY
	 c8o7PrjwuonJCv2QYqdQEpCEvw2ofxf1T73e9kt6rVUvnj8azDWRNxWhUV2Xp1j7ps/lc
	 GiCadmlA5AAK3qVOV+IIZ7ERE+jkS91coKZBwcLFFW15vS0WNOrpxfMfZ9YAOZbnK3zmS
	 ALGUb8d0RwR57e6GQfjPKs4AlTeG/836wGem0OmdCdXgRh6dgt8PnlpA+yUJ0e16ukSTh
	 xjwROCh0KQb2TEkN0vfhwmKrblfFvvz2W8xJOo5b8TpsmkAhp4ck1TQ7CfdMK43MP2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZlzUWFBG;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA197606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA197606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZlzUWFBG
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53bb57f1310so20648791cf.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890915; x=1794495715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FB8VamKrqnmd54tZatH4ohs6GMQM7Aezf7gRWTTTQT0=;
        b=ZlzUWFBGhMVczWY4k059Mf0GDRgoQktAaLZIckJkuaVYuyErb8Trnwf/s3yjR7Ecr8
         tCTwv9fzhDXgtsfPx8NrnScka1FYvawbM0jq8dM/H+XMaMYwoQVpcauZbk+G1ExusIRQ
         wTuXphBJ20DmkR5ff+E+NJlQW2WaNkmEitBTu6weUzRuJT1rgTIncB9pzdXedgnXzZfT
         7tYvEUOhODJFY4F1JRteupjwXdCJ4csbC467ksLqBym+gnTZYFPkEZGTFZAcUG2PPuEA
         ZVJAOtj4u63ZiIBNJur9sFmkLRF1jlwk6rf3uA/v/V0JG5YBmx4Ibp3z354jzW7Z+SEa
         5VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890915; x=1794495715;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FB8VamKrqnmd54tZatH4ohs6GMQM7Aezf7gRWTTTQT0=;
        b=ihCOq8KKPT6mW6hJPLshL1AuC04UdLX4mXqAxAyVX+1p4DYYcOd8qOMsaJngzjp8OX
         9ftJzvEAuvY4bNLuBBeYz0JFedJ2FtdJa8neb+HTEHF+9q/r1G8ktvuIE3IWOT3PmK25
         KFRRcybdH0u2MPR8J5KYLplXW3z2RKaGql6MeR9Tewf5flByosB4owQ3gStvkY7nUFEv
         YJIQyU//fBYtVobj6jSW60yuNidM46aIf63hvsVGZNcepj7rEx5eA3fwIyECEKXj01l8
         g475r2ZLRKvptqFnF31lnR8wwbJjKIQk2IWFOweTO6sh+xa2QfPuYKkzLvcQAX+o5qO0
         lt2A==
X-Forwarded-Encrypted: i=1; AKwUvBy/CDkM69E0kZJloPgAj4c1KUxXsV/xZV/J+34KvrbjZnQnUTNDVhPI79EEad6EjsMhv08=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UQw7NFLWc+1+cxs3NW7idY5AhmIGT4MM64pbJq32Uzk7QkmZC
	HbkQODw41nbozbIA9kYZmhqyVgRPe77FIeDEXXqUsRhbvEldI4swbTVb
X-Gm-Gg: AYBFou37ilsaFbmbWePs2x1UDJXCT5Ed2y8LE2gFq6sD0AIla5uKtA03110qeGfhC2D
	Twf7eI5Tc5PimTBGdVE6FOe9chzq61ugarH9D/882t0iki7uQyeXRaUSrTNad0YZj9HiW1FaBEz
	7kbknq+DnM7HQhRO2gl3s8vRcjot9fAZSWhNFcq/UzzIfGwzDFmoY2g0f5VPbfT7HQspmynPs0P
	b9858anWfBuZhN4SixS+TaM1rzH6volC9VJV3ZhzNr7Cv2W3POlqjljJDkAU/0M7tVCQkGUQ363
	kg8+lmdpeY7F15DUOnkLvzlPW7Pc46lJCUV2HWe/iMwREM+P0b6fnZyvKjKgUW6mvSGOuqtqJwL
	ab+gbJZKHTewAMbkTiln1/nr9BklgBGtevJADRcw6mmywpBONdqRF8v8a92tyb5HENEEkKzzI3E
	oCZ6ql/jc+k4de8UNE/xNWtYEeGOOV+uujgYyI7i7wy7LVahTGe1H41mn+igCj3dn0YMc3oyLAl
	xUxo5x8jxG47WIiwOCMSEcI4iK2RNpCfi/BDlLEc/ULLLUk5/1Uy2G6bhrVAJVs3Zvg773c+7Xl
	SDUebVfdXDyPaXmYaZwocQTOFKK1TfcA5QlbORcHtjwfBpdaA1t9578qWZGIiqDS4sjnjDjNC1V
	ts6OINHoD9SxNuAJlzHlxYLywlHLQOyxBR1VHKYVKCLW8Kmym26wJTX+3L5aIjWGZ8TSxKtGMl8
	B/KqynhyR1qDY6FplVcSMD7UgPn6LAVg9F+ri5hKTNkx8IpDFrVWrG
X-Received: by 2002:a05:622a:e0d6:10b0:54a:755d:6fd4 with SMTP id d75a77b69052e-54a755d73e6mr92922321cf.9.1793890914436;
        Thu, 05 Nov 2026 07:01:54 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm53570241cf.20.2026.11.05.07.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:01:53 -0800 (PST)
Message-ID: <c724ab00-dfb8-4e81-8bd7-89702bea51b4@gmail.com>
Date: Thu, 5 Nov 2026 10:01:52 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsmonitor: check the untracked cache after a trivial
 response
To: Ilia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Ilia <ki.stfu@gmail.com>
References: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/2026 11:19 AM, Ilia via GitGitGadget wrote:
> From: Ilia K <ki.stfu@gmail.com>
> 
> When the monitor sends a trivial response ("/"), for example after
> the daemon restarted or lost events, refresh_fsmonitor() marks every
> index entry dirty, which is saved in the index. For the untracked
> cache it only clears the in-memory flag use_fsmonitor. The valid bits
> of the cached directories are saved unchanged, although nothing
> checks them anymore: valid_cached_dir() does not lstat() a valid
> directory while the monitor is trusted.

Sorry that I declared "mailing list bankruptcy" and didn't see your patch
when I was preparing mine [1] for the same issue.

[1] https://lore.kernel.org/git/pull.2295.git.1793806679163.gitgitgadget@gmail.com/

...
> Check every cached directory against its stat data before the cache
> is saved next to such a token, as valid_cached_dir() does without a
> monitor, and invalidate the ones that changed or disappeared. Doing
> this at write time skips commands that do not write the index, and
> sparse index writes, which drop the fsmonitor extension anyway.
> The cost is one lstat() per cached directory, once per trivial
> response.

This is the main difference between your patch and mine. My patch does a
full clear of the untracked cache, but you do the more efficient thing to
only clear the entries that don't match the filesystem info.

This is visible when running p7527-bulitin-fsmonitor.sh on Linux with a
small setting in fs.inotify.max_user_watches, causing the builtin fsmonitor
to always fail. My "clear everything" patch gets a 50-75% penalty on the
untracked cache tests while yours has no measurable impact.

For this reason, I think your approach is better and worth the slight
increase in code complexity.

> +static int invalidate_stale_dirs(struct untracked_cache *uc,
> +				 struct untracked_cache_dir *ucd,
> +				 struct index_state *istate,
> +				 struct strbuf *path)
> +{
> +	struct stat st;
> +	size_t len = path->len;
> +	int nr_invalidated = 0;
> +	unsigned int i;
> +
> +	if (ucd->valid &&
> +	    (lstat(path->buf, &st) ||
> +	     match_stat_data_racy(istate, &ucd->stat_data, &st))) {
> +		invalidate_one_directory(uc, ucd);
> +		nr_invalidated++;
> +	}
> +
> +	for (i = 0; i < ucd->dirs_nr; i++) {
> +		/* not written to the index, see write_one_dir() */
> +		if (!ucd->dirs[i]->recurse)
> +			continue;
> +		strbuf_addch(path, '/');
> +		strbuf_addstr(path, ucd->dirs[i]->name);
> +		nr_invalidated += invalidate_stale_dirs(uc, ucd->dirs[i],
> +							istate, path);

I'm conditioned to worry about recursive calls without depth limits, but
I suppose that we are limited by the untracked cache data structure itself,
which was presumably created recursively without hitting stack limits.

We could make this iterative using a stack-based data structure, but that
would be more complicated than this is worth, probably. These are not used
in server environments and the .git/index file shouldn't be considered
"unsafe" or else we have bigger safety problems.

> +		strbuf_setlen(path, len);
> +	}
> +
> +	return nr_invalidated;
> +}
> +
> +int untracked_cache_invalidate_stale_dirs(struct index_state *istate)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	const char *worktree;
> +	int nr_invalidated;
> +
> +	if (!istate->untracked || !istate->untracked->root)
> +		return 0;
> +
> +	/*
> +	 * The index is also read and written by commands that do not
> +	 * run in the top-level directory of the worktree.
> +	 */
> +	worktree = repo_get_work_tree(istate->repo);
> +	if (!worktree)
> +		return 0;

I wonder if this is the right response if we fail to get a worktree. Maybe
we should invalidate the entire untracked cache in this case, along with a
warning that we couldn't evaluate the worktree? Or should we return -1 to
signal an error?

> +
> +	strbuf_addstr(&path, worktree);
> +	nr_invalidated = invalidate_stale_dirs(istate->untracked,
> +					       istate->untracked->root,
> +					       istate, &path);
> +	strbuf_release(&path);
> +	return nr_invalidated;
> +}
...
> +/*
> + * Invalidate every cached directory that no longer exists or whose
> + * stat data no longer matches the working tree. valid_cached_dir()
> + * skips this check while the file system monitor is trusted.
> + * Returns the number of invalidated directories.
> + */
> +int untracked_cache_invalidate_stale_dirs(struct index_state *);

We could update this doc comment if we return negative on error.

> diff --git a/read-cache.c b/read-cache.c
> index c4cf08a3a3..00c9960c8e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3034,6 +3034,22 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  	    istate->untracked) {
>  		strbuf_reset(&sb);
>  
> +		/*
> +		 * The monitor could not say what changed (see the trivial
> +		 * response in refresh_fsmonitor()), so nothing kept the
> +		 * valid bits up to date. Check them before they are saved
> +		 * next to the new token, which later commands trust even
> +		 * when this command did not look for untracked files.
> +		 */
> +		if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
> +		    istate->fsmonitor_last_update &&
> +		    !istate->untracked->use_fsmonitor) {
> +			int nr = untracked_cache_invalidate_stale_dirs(istate);
> +
> +			trace2_data_intmax("index", istate->repo,
> +					   "extension/untr/invalidated", nr);
> +		}

This surprised me, that you're computing this in do_write_index(). I suppose
that this avoids doing this computation unless the index is written, but is
it possible that between refresh_fsmonitor() and do_write_index() that the
untracked cache is read and used to determine what this index update should
be?

I used a coding agent to explore my concerns in this space, and it couldn't
find an example where doing this in refresh_fsmonitor() would be better than
its current placement.

> +# After a trivial response ("/") the monitor cannot vouch for the
> +# untracked cache. Even a command that does not look for untracked
> +# files must drop the stale entries, or the next "git status" trusts them.

nit: Generally, we don't need these comments because the tests should be
self-documenting.

> +test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
> +	test_when_finished "rm -rf trivial err" &&
> +	git init trivial &&
> +	(
> +		cd trivial &&
> +		mkdir -p dir/sub &&
> +		echo tracked >dir/sub/tracked &&
> +		git add dir &&
> +		git commit -m initial &&
> +		git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-none" &&
> +		# Version 1 only, or the hook prints a version complaint
> +		# on stderr at every query.
> +		git config core.fsmonitorHookVersion 1 &&
> +		git config core.untrackedCache true &&
> +		# With "normal", invalidating one path also invalidates
> +		# its parents, and the stale parent below is never seen.
> +		git config status.showUntrackedFiles all &&
> +		echo untracked >dir/sub/untracked &&
> +		echo "?? dir/sub/untracked" >../expect &&
> +		git status --porcelain >../actual &&
> +		test_cmp ../expect ../actual &&
> +		git status --porcelain >../actual &&
> +		test_cmp ../expect ../actual &&
> +
> +		# The monitor misses the removal of dir/sub. "git add other"
> +		# gets the trivial response and does not touch the entries
> +		# of dir and dir/sub by itself.
> +		rm -r dir/sub &&
> +		echo other >other &&
> +		git -c core.fsmonitor="$TEST_DIRECTORY/t7519/fsmonitor-all" \
> +			add other &&
> +		cat >../expect <<-\EOF &&
> +		 D dir/sub/tracked
> +		A  other

I initially thought that this difference in left-padding was a typo, but
it is functional. We need a space before D and a space after A to signal
the different states.

> +		EOF
> +		git status --porcelain >../actual 2>../err &&
> +		test_must_be_empty ../err &&
> +		test_cmp ../expect ../actual &&
> +
> +		# Invalidate the entry of dir/sub. The stale entry of dir then
> +		# makes "git status" open the removed directory and warn.
> +		git update-index --remove dir/sub/tracked &&
> +		cat >../expect <<-\EOF &&
> +		D  dir/sub/tracked
> +		A  other

And of course now the deletion is staged. Good.

> +		EOF
> +		git status --porcelain >../actual 2>../err &&
> +		test_must_be_empty ../err &&
> +		test_cmp ../expect ../actual
> +	)
> +'

> +# After a restart the daemon sends a trivial response ("/"), because it
> +# cannot know what changed while it was down. Even a command that does
> +# not look for untracked files must then drop the stale untracked cache
> +# entries, or the next "git status" trusts them.

same nit: comments shouldn't be necessary here.

> +test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
> +	test_when_finished "stop_daemon_delete_repo test_trivial" &&
> +
> +	git init test_trivial &&
> +	mkdir -p test_trivial/dir/sub &&
> +	echo tracked >test_trivial/dir/sub/tracked &&
> +	git -C test_trivial add dir &&
> +	git -C test_trivial commit -m initial &&
> +	git -C test_trivial config core.fsmonitor true &&
> +	git -C test_trivial config core.untrackedCache true &&
> +	echo untracked >test_trivial/dir/sub/untracked &&
> +
> +	# The first status starts the daemon and builds the untracked
> +	# cache, the second one trusts it.
> +	echo "?? dir/sub/untracked" >expect &&
> +	git -C test_trivial status --porcelain >actual &&
> +	test_cmp expect actual &&
> +	git -C test_trivial status --porcelain >actual &&
> +	test_cmp expect actual &&
> +
> +	# Remove dir/sub while no daemon is running. "git add" then
> +	# starts a new daemon, receives its trivial response, and does
> +	# not look for untracked files.
> +	git -C test_trivial fsmonitor--daemon stop &&
> +	rm -r test_trivial/dir/sub &&
> +	echo other >test_trivial/other &&
> +	GIT_TRACE2_EVENT="$PWD/trace_trivial" \
> +		git -C test_trivial add other &&
> +	have_t2_data_event fsm_client query/trivial-response <trace_trivial &&
> +	git -C test_trivial fsmonitor--daemon status &&
> +
> +	cat >expect <<-\EOF &&
> +	 D dir/sub/tracked
> +	A  other
> +	EOF
> +	git -C test_trivial status --porcelain >actual 2>err &&
> +	test_must_be_empty err &&
> +	test_cmp expect actual
> +'

Overall, this patch appears to solve the same problem that pointed me in
this direction. I don't see any issues worth re-rolling this patch, so it
LGTM.

Thanks,
-Stolee
