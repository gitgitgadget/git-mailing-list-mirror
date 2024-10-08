Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86563BBCB
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358705; cv=none; b=pn9yAJuYIZKWvMGcyjlOtbtwG94Slqwl18sA/JbQyqBm24EIfgPLOvIoCuwb5jv3SXayZVBJ9dQVypS0x1Bj8gllOSTdcjuxtsAJphqAvQxEPJQ5DQ/NX7rovfajR09XKtR93SA4evZNrcGRaVgSALYdXzJrqzWQeY+cM2rvcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358705; c=relaxed/simple;
	bh=i/FToDMlJQ1QoUPpG9oqYOcAtAhRkxV6YqivASKBdvQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rkq+V9WDTeI9Tgl9yHr9Z00SGd07jwHdlYGhHQutIfqeclTQxPzeR0Y2cnJ3k5ot6x6cUhuORbGvpz1I+IJfGSqZyFzZX6NFj7mzl5sfYennIyTyXjrOU0gSalcuvu+cupBQ2uYqBjK3W3007yOmJR/h9OwIOVGxCCm08R0TY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1CZscPk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1CZscPk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so5924388a12.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 20:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358702; x=1728963502; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldF0OtitYZyfYvLmhl2N8NxbjjI5Mj4Z3IPrtpkFtbI=;
        b=N1CZscPkQub68HURNT4zmdosAQDmyk29qOaQZfwx9oKq/N9cCkBMBo9LJtZ9tDhUTM
         MYiqXnfjI0b/2U+34Vmbeirfp43DmftWc5K/bYr50CXax2pymI18WZilYSBjJ7lK8TES
         ztMkxksg4Y/uiS3T20o4RcqU3nkpOGqJA4t9yKKywGSR47f7f7LnF2MyA0KWVR1SeWSF
         DEyVS43NJijMPRCxkLpBnu2wr08GW6rM54phI1v23x6Iie8uUfyhY4901gQgxdYac7dR
         RNLx0fdZ/2mzYsbVH8jm84VExLjIjZ7AQ82XvnWmJf986gds+r3aJyMh60VLzZywgWnK
         Xy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358702; x=1728963502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldF0OtitYZyfYvLmhl2N8NxbjjI5Mj4Z3IPrtpkFtbI=;
        b=QyCRxvzObDH2Z45O04BBS5IZot0ekUBzrl+2B/A7JE3YpLHwxCviGVC6Z3by2pEzIA
         tBhFYw2G3cZQwDp3gF7WDtL/jRWVvR8UeUJoflOc+Oee55knmS5rkHHLb96IFLbDNUJl
         DjihiKhwtg7mR1v6FbxtmdccVbBv8gfCzdV+IgRQBt1UOVT3kO32J9oS5i1xcuEw0DYh
         HYWGUVNFTyqgIJIogVvjUKsiPVdP4w0joIyasnRgR+ejk7z4QOiGTQwcDidW3hQhNrHO
         xF59YciES5MMZ3/iNhiSNTABTwKvgVcQO1RRP5mouLKnlBZeOPRy4o0WMjzX5ERlNCB0
         DvpA==
X-Gm-Message-State: AOJu0YwY+ai45QqBSBkEQywR17wIx734WeS402lZb6E76dhX2F8E4PmF
	4giYPXV8E9rzBP/xVbilrMz1qCBlX4X4NjvWpYyabeZ8X+Gy8343yU+oyQ==
X-Google-Smtp-Source: AGHT+IHR1zjruA2U14TYhAWR9ZSFHnULk/uydBdMv8hV/JuSxUz9OMAcIaOq4fVPjooPuRf9Acws6g==
X-Received: by 2002:a05:6402:268d:b0:5c8:9e36:ccaf with SMTP id 4fb4d7f45d1cf-5c8d2ed2e6bmr11484160a12.33.1728358701281;
        Mon, 07 Oct 2024 20:38:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05ecbe0sm3893512a12.78.2024.10.07.20.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:38:20 -0700 (PDT)
Message-Id: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 03:38:14 +0000
Subject: [PATCH v3 0/5] Support server option from configuration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
    blanet <bupt_xingxin@163.com>

We manage some internal repositories with numerous CI tasks, each requiring
code preparation through git-clone or git-fetch. These tasks, triggered by
post-receive hooks, often fetch the same copy of code concurrently using
--depth=1, causing extremely high load spikes on our Git servers.

To reduce performance impacts caused by these tasks, we plan to deploy a
specially designed pack-objects-hook [1]. This hook would allow the packs
generated by git-pack-objects(during git-clone or git-fetch) to be reused.
Since not all clone/fetch operations will benefit from this caching (e.g.,
pulls from developer environments), clients need to pass a special
identifier to indicate whether caching should be enabled. Using server
options [2] is suitable for this purpose.

However, server options can only be specified via the command line option
(via --server-option or -o), which is inconvenient and requires
modifications to CI scripts. A configuration-based approach is preferable,
as it can be propagated through global configuration (e.g. ~/.gitconfig) and
avoids compatibility issues with older Git versions that don't support
--server-option.

This patch series introduces a new multi-valued configuration,
remote.<name>.serverOption, similar to push.pushOption, to specify default
server options for the corresponding remote.

 * Patches 1~3 contain the main changes for introducing the new
   configuration.
 * Patch 4 fixes a issue for git-fetch not sending server-options when
   fetching from multiple remotes.
 * Patch 5 is a minor fix for a server options-related memory leak.

 1. https://git-scm.com/docs/git-config#Documentation/git-config.txt-uploadpackpackObjectsHook
 2. https://git-scm.com/docs/gitprotocol-v2#_server_option

Xing Xin (5):
  transport: introduce parse_transport_option() method
  remote: introduce remote.<name>.serverOption configuration
  transport.c::handshake: make use of server options from remote
  fetch: respect --server-option when fetching multiple remotes
  ls-remote: leakfix for not clearing server_options

 Documentation/config/remote.txt |  10 +++
 Documentation/fetch-options.txt |   3 +
 Documentation/git-clone.txt     |   3 +
 Documentation/git-ls-remote.txt |   3 +
 builtin/fetch.c                 |   2 +
 builtin/ls-remote.c             |   1 +
 builtin/push.c                  |   9 +--
 remote.c                        |   6 ++
 remote.h                        |   3 +
 t/t5702-protocol-v2.sh          | 133 ++++++++++++++++++++++++++++++++
 transport.c                     |  15 ++++
 transport.h                     |   4 +
 12 files changed, 184 insertions(+), 8 deletions(-)


base-commit: 6258f68c3c1092c901337895c864073dcdea9213
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1776%2Fblanet%2Fxx%2Fadd-server-option-from-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1776/blanet/xx/add-server-option-from-config-v3
Pull-Request: https://github.com/git/git/pull/1776

Range-diff vs v2:

 1:  c95ed5e0dd5 = 1:  b44face42e1 transport: introduce parse_transport_option() method
 2:  2474b4c69d6 ! 2:  3c6b129d368 remote: introduce remote.<name>.serverOption configuration
     @@ Documentation/config/remote.txt: remote.<name>.partialclonefilter::
       	database, use the `--refetch` option of linkgit:git-fetch[1].
      +
      +remote.<name>.serverOption::
     -+	When no `--server-option=<option>` argument is given from the command
     -+	line, git will use the values from this configuration as a default list of
     -+	server options for this remote.
     ++	The default set of server options used when fetching from this remote.
     ++	These server options can be overridden by the `--server-option=` command
     ++	line arguments.
      ++
      +This is a multi-valued variable, and an empty value can be used in a higher
      +priority configuration file (e.g. `.git/config` in a repository) to clear
     @@ remote.c
       
       enum map_direction { FROM_SRC, FROM_DST };
       
     -@@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     - 	struct remote *ret;
     - 	struct remotes_hash_key lookup;
     - 	struct hashmap_entry lookup_entry, *e;
     -+	struct string_list server_options = STRING_LIST_INIT_DUP;
     - 
     - 	if (!len)
     - 		len = strlen(name);
      @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
       	ret->name = xstrndup(name, len);
       	refspec_init(&ret->push, REFSPEC_PUSH);
       	refspec_init(&ret->fetch, REFSPEC_FETCH);
     -+	ret->server_options = server_options;
     ++	string_list_init_dup(&ret->server_options);
       
       	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
       		   remote_state->remotes_alloc);
     @@ remote.c: static void remote_clear(struct remote *remote)
       
       static void add_merge(struct branch *branch, const char *name)
      @@ remote.c: static int handle_config(const char *key, const char *value,
     - 					 key, value);
       	} else if (!strcmp(subkey, "vcs")) {
     + 		FREE_AND_NULL(remote->foreign_vcs);
       		return git_config_string(&remote->foreign_vcs, key, value);
      +	} else if (!strcmp(subkey, "serveroption")) {
      +		return parse_transport_option(key, value,
 3:  a7f3e458501 = 3:  f0835259b06 transport.c::handshake: make use of server options from remote
 4:  39ee8dbef78 = 4:  420b15d9f37 fetch: respect --server-option when fetching multiple remotes
 5:  39c07a6c8ee ! 5:  2528d929c7e ls-remote: leakfix for not clearing server_options
     @@ Commit message
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## builtin/ls-remote.c ##
     -@@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv, const char *prefix)
     +@@ builtin/ls-remote.c: int cmd_ls_remote(int argc,
       	transport_ls_refs_options_release(&transport_options);
       
       	strvec_clear(&pattern);

-- 
gitgitgadget
