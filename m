Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600880038
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093885; cv=none; b=HZhsFyH16sWydIZ6zNwIaDwRPQ5xr7xFWlHBJdPv+kwAOa5ezXIA/4a7wpYnTxGHvtmcZaJImDRTzcCciBCvNeErQvfeYN2Y17/0er5OjdfxAxYPWkQZyFXp5uT0qbfTOCAAJfdoxXGrX7EJUzjHeYQ7mOLk2QwJh7rsj51etZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093885; c=relaxed/simple;
	bh=WYRM6wyff+20KFjQl8qJ7HpOU5N9qHrlpNCaA0RWhno=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A1YAWhAZ9JfchCKA/w/oIinN3N1FEc4sugXtfT4wchpqSLl6l3/uD8JMpu5M+x4KCHMuWWuCE8T/8iK9lfe9cc6GWNPuggMO8k4QAB9LaGdZnjvurK/IW7jy49vvXoXz7XDVnmMtu86QWqlCP/Oq1os2Sjr6K3sMbARI6r1Lj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPxjsUYz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPxjsUYz"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso43623091fa.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093881; x=1727698681; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02H85lhZU9IJ9wZ1YxKwIBj2MFkv32MBKXN7V5+U/xA=;
        b=EPxjsUYzHfMZwuaCe4I7ag8pG6kAXD+hUiagV3GxUQbZ5EXWt1OSg/rPXcvbT//RDQ
         bUFDiu2bitiLfCRWicPaxZumm0abFCibQVYyJW04wD61rB9gU1w8dFHnTtjjZyPAhshR
         xor0vEcZ71aaohijc29VedTi2TohnEcYXpJLzhleSp8gT7Wh5uj/039DcM4C7eB5czLo
         KNbma4yZ3Zaj+hTuGoZgQxrF+Wx0xa5HW/44a+z7ssFp0c96XiOi+tbcRHcjRfCIRDUv
         Cnk7xbvtc3v+7o/hYbqTxdNBvOP3aVcShHHAfrkdLVFe45DE78rcesSmwvU1d7EPArQ4
         piHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093881; x=1727698681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02H85lhZU9IJ9wZ1YxKwIBj2MFkv32MBKXN7V5+U/xA=;
        b=QOwmrAdYijBsDCApcWb+6NnaeUHwJEJC4Qb1kxMSLLz5+XzL1QdrrsRgy2Tbo46vFx
         TCpe3rR5vOmlBCobg3wn9sNMFqnsgfdRW93oETjdK+jwnaebtLez9Y/DM76+BNBcislb
         XBkRK69gbMDToy33oSEnPmXHeE9sbvuH54PY79PYWN471ZqBzkE4IDRnbS4iUoL0BQwh
         BffRk9GvtieV/KWIVa/L+dpA1Mee/lC4hl3ipdct7D0OXbnqJ0TcBjtdZLDwTrjwMuBy
         sJR/5CSP2odk5XnC1wVB0CviguIg+LcWCWVVimLyXCFE7WL0X5+E03YBHAmd2oGQh7wq
         4SSw==
X-Gm-Message-State: AOJu0Yw5BYMILLd8v677ELA54uru4ueNls1sqbfnZZBfYxqq3LxYc0iG
	PUOHcEC+KVA4o+iT5xJ5IT+YtSykxhLVekeVJy0NIh9Gp05nTlV7t5tTsA==
X-Google-Smtp-Source: AGHT+IFMTefZDZeKpkTWSiY7BVz5VsunwarySGAncEy5TfjP19QUEv01BV1iCS5+/a8SfMh4pzd9Sw==
X-Received: by 2002:a2e:9fca:0:b0:2f3:ecdd:2b8d with SMTP id 38308e7fff4ca-2f7cc366476mr41436511fa.16.1727093880229;
        Mon, 23 Sep 2024 05:18:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5c3d18cb0sm855187a12.77.2024.09.23.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:17:59 -0700 (PDT)
Message-Id: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:17:53 +0000
Subject: [PATCH v2 0/5] Support server option from configuration
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
    blanet <bupt_xingxin@163.com>

We have multiple internal repositories configured with a huge number of CI
tasks, each requiring code preparation (either via clone or fetch). These CI
tasks, triggered by post-receive hooks, often fetch the same code (usually
using --depth=1) concurrently.

To reduce performance impacts on the git server caused by these tasks, we
want to deploy a special designed pack-objects-hook. This hook would allow
the packs generated by git-pack-objects to be reused. Since not all
clone/fetch operations will benefit from this caching (e.g., pulls from
developers' environments), clients need to pass a special identifier to
indicate whether caching should be enabled for a particular operation. Using
server options is a suitable method for this.

However, server options can only be specified via the command line option
(via --server-option or -o), which is inconvenient and requires CI script
modifications. A configuration-based approach is easier to propagate (by
changing the global configuration ~/.gitconfig) and avoids issues with older
Git versions that don't support --server-option.

This patch series introduces a new multi-valued configuration,
remote.<name>.serverOption, similar to push.pushOption, to specify default
server options for the corresponding remote.

 * Patch 1~3 is the main change for introducing the new configuration.
 * Patch 4 fixes a issue for git-fetch not sending server-options when
   fetching multiple remotes.
 * Patch 5 is a minor fix for a server options-related memory leak.

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
 remote.c                        |   7 ++
 remote.h                        |   3 +
 t/t5702-protocol-v2.sh          | 133 ++++++++++++++++++++++++++++++++
 transport.c                     |  15 ++++
 transport.h                     |   4 +
 12 files changed, 185 insertions(+), 8 deletions(-)


base-commit: 4590f2e9412378c61eac95966709c78766d326ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1776%2Fblanet%2Fxx%2Fadd-server-option-from-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1776/blanet/xx/add-server-option-from-config-v2
Pull-Request: https://github.com/git/git/pull/1776

Range-diff vs v1:

 1:  5c8f3c166a5 ! 1:  c95ed5e0dd5 transport: add parse_transport_option() method
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    transport: add parse_transport_option() method
     +    transport: introduce parse_transport_option() method
      
     -    Introduce the `parse_transport_option()` method used to parse
     -    `push.pushOption` configuration values. This method will be further
     -    utilized in subsequent commits to parse a newly added
     -    `fetch.serverOption` configuration for fetches, which aligns with the
     -    design pattern of `push.pushOption`.
     +    Add the `parse_transport_option()` method to parse the `push.pushOption`
     +    configuration. This method will also be used in the next commit to
     +    handle the new `remote.<name>.serverOption` configuration for setting
     +    server options in Git protocol v2.
      
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## builtin/push.c ##
      @@ builtin/push.c: static int git_push_config(const char *k, const char *v,
     + 			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
     + 		recurse_submodules = val;
       	} else if (!strcmp(k, "push.pushoption")) {
     - 		if (!v)
     - 			return config_error_nonbool(k);
     +-		if (!v)
     +-			return config_error_nonbool(k);
      -		else
      -			if (!*v)
      -				string_list_clear(&push_options_config, 0);
      -			else
      -				string_list_append(&push_options_config, v);
     -+		parse_transport_option(v, &push_options_config);
     - 		return 0;
     +-		return 0;
     ++		return parse_transport_option(k, v, &push_options_config);
       	} else if (!strcmp(k, "color.push")) {
       		push_use_color = git_config_colorbool(k, v);
     + 		return 0;
      
       ## transport.c ##
      @@ transport.c: int is_transport_allowed(const char *type, int from_user)
       	BUG("invalid protocol_allow_config type");
       }
       
     -+void parse_transport_option(const char *option, struct string_list *transport_options)
     ++int parse_transport_option(const char *var, const char *value,
     ++			   struct string_list *transport_options)
      +{
     -+	if (!*option)
     ++	if (!value)
     ++		return config_error_nonbool(var);
     ++	if (!*value)
      +		string_list_clear(transport_options, 0);
      +	else
     -+		string_list_append(transport_options, option);
     ++		string_list_append(transport_options, value);
     ++	return 0;
      +}
      +
       void transport_check_allowed(const char *type)
     @@ transport.h: void transport_print_push_status(const char *dest, struct ref *refs
       /* common method used by transport-helper.c and send-pack.c */
       void reject_atomic_push(struct ref *refs, int mirror_mode);
       
     -+/* common method to parse push-option for pushes or server-option for fetches */
     -+void parse_transport_option(const char *option, struct string_list *transport_options);
     ++/* common method to parse push-option or server-option from config */
     ++int parse_transport_option(const char *var, const char *value,
     ++			   struct string_list *transport_options);
      +
       #endif
 2:  7e2d5c504d7 < -:  ----------- builtin/fetch.c: add fetch.serverOption configuration
 -:  ----------- > 2:  2474b4c69d6 remote: introduce remote.<name>.serverOption configuration
 3:  7c3ebda513d ! 3:  a7f3e458501 builtin/clone.c: recognize fetch.serverOption configuration
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    builtin/clone.c: recognize fetch.serverOption configuration
     +    transport.c::handshake: make use of server options from remote
      
     -    Teach git-clone to recognize the `fetch.serverOption` configuration as a
     -    default list of server options to send for Git protocol v2, if server
     -    options are not explicitly set via the command line.
     +    Utilize the `server_options` from the corresponding remote during the
     +    handshake in `transport.c` when Git protocol v2 is detected. This helps
     +    initialize the `server_options` in `transport.h:transport` if no server
     +    options are set for the transport (typically via `--server-option` or
     +    `-o`).
      
     -    Note that `builtin/clone.c:cmd_clone` originally read the git config
     -    twice via `builtin/clone.c:git_clone_config`, which would duplicate
     -    server options if parsing logic were added there. Upon investigation, it
     -    was found that the first config read is unnecessary since all the global
     -    variables it sets are actually used after the second config read.
     -    Therefore, the first config read is replaced with a simple
     -    `config.c:git_default_config`.
     +    While another potential place to incorporate server options from the
     +    remote is in `transport.c:transport_get`, setting server options for a
     +    transport using a protocol other than v2 could lead to unexpected errors
     +    (see `transport.c:die_if_server_options`).
      
     -    Tests and documentation have been updated accordingly.
     +    Relevant tests and documentation have been updated accordingly.
      
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
     + ## Documentation/fetch-options.txt ##
     +@@ Documentation/fetch-options.txt: endif::git-pull[]
     + 	unknown ones, is server-specific.
     + 	When multiple `--server-option=<option>` are given, they are all
     + 	sent to the other side in the order listed on the command line.
     ++	When no `--server-option=<option>` is given from the command line,
     ++	the values of configuration variable `remote.<name>.serverOption`
     ++	are used instead.
     + 
     + --show-forced-updates::
     + 	By default, git checks if a branch is force-updated during
     +
       ## Documentation/git-clone.txt ##
      @@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
       	unknown ones, is server-specific.
       	When multiple ++--server-option=++__<option>__ are given, they are all
       	sent to the other side in the order listed on the command line.
      +	When no ++--server-option=++__<option>__ is given from the command
     -+	line, the values of configuration variable `fetch.serverOption`
     ++	line, the values of configuration variable `remote.<name>.serverOption`
      +	are used instead.
       
       `-n`::
       `--no-checkout`::
      
     - ## builtin/clone.c ##
     -@@ builtin/clone.c: static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
     - static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
     - static int option_filter_submodules = -1;    /* unspecified */
     - static int config_filter_submodules = -1;    /* unspecified */
     --static struct string_list server_options = STRING_LIST_INIT_NODUP;
     -+static struct string_list config_server_options = STRING_LIST_INIT_DUP;
     -+static struct string_list option_server_options = STRING_LIST_INIT_DUP;
     - static int option_remote_submodules;
     - static const char *bundle_uri;
     - 
     -@@ builtin/clone.c: static struct option builtin_clone_options[] = {
     - 		   N_("specify the reference format to use")),
     - 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
     - 			N_("set config inside the new repository")),
     --	OPT_STRING_LIST(0, "server-option", &server_options,
     -+	OPT_STRING_LIST(0, "server-option", &option_server_options,
     - 			N_("server-specific"), N_("option to transmit")),
     - 	OPT_IPVERSION(&family),
     - 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
     -@@ builtin/clone.c: static int git_clone_config(const char *k, const char *v,
     - 		config_reject_shallow = git_config_bool(k, v);
     - 	if (!strcmp(k, "clone.filtersubmodules"))
     - 		config_filter_submodules = git_config_bool(k, v);
     -+	if (!strcmp(k, "fetch.serveroption")) {
     -+		if (!v)
     -+			return config_error_nonbool(k);
     -+		parse_transport_option(v, &config_server_options);
     -+		return 0;
     -+	}
     - 
     - 	return git_default_config(k, v, ctx, cb);
     - }
     -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	int hash_algo;
     - 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
     - 	const int do_not_override_repo_unix_permissions = -1;
     --
     -+	struct string_list *server_options = NULL;
     - 	struct transport_ls_refs_options transport_ls_refs_options =
     - 		TRANSPORT_LS_REFS_OPTIONS_INIT;
     - 
     - 	packet_trace_identity("clone");
     - 
     --	git_config(git_clone_config, NULL);
     -+	git_config(git_default_config, NULL);
     + ## Documentation/git-ls-remote.txt ##
     +@@ Documentation/git-ls-remote.txt: OPTIONS
     + 	character.
     + 	When multiple `--server-option=<option>` are given, they are all
     + 	sent to the other side in the order listed on the command line.
     ++	When no `--server-option=<option>` is given from the command line,
     ++	the values of configuration variable `remote.<name>.serverOption`
     ++	are used instead.
       
     - 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
     - 			     builtin_clone_usage, 0);
     + <repository>::
     + 	The "remote" repository to query.  This parameter can be
     +
     + ## t/t5702-protocol-v2.sh ##
     +@@ t/t5702-protocol-v2.sh: test_expect_success 'server-options are sent when using ls-remote' '
     + 	grep "server-option=world" log
     + '
       
     -+	server_options = option_server_options.nr ?
     -+			 &option_server_options : &config_server_options;
     -+
     - 	if (argc > 2)
     - 		usage_msg_opt(_("Too many arguments."),
     - 			builtin_clone_usage, builtin_clone_options);
     -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
     - 				     option_upload_pack);
     ++test_expect_success 'server-options from configuration are used by ls-remote' '
     ++	test_when_finished "rm -rf log myclone" &&
     ++	git clone "file://$(pwd)/file_parent" myclone &&
     ++	cat >expect <<-EOF &&
     ++	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/main
     ++	EOF
     ++
     ++	# Default server options from configuration are used
     ++	git -C myclone config --add remote.origin.serverOption foo &&
     ++	git -C myclone config --add remote.origin.serverOption bar &&
     ++	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
     ++		ls-remote origin main >actual &&
     ++	test_cmp expect actual &&
     ++	test_grep "ls-remote> server-option=foo" log &&
     ++	test_grep "ls-remote> server-option=bar" log &&
     ++	rm -f log &&
     ++
     ++	# Empty value of remote.<name>.serverOption clears the list
     ++	git -C myclone config --add remote.origin.serverOption "" &&
     ++	git -C myclone config --add remote.origin.serverOption tar &&
     ++	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
     ++		ls-remote origin main >actual &&
     ++	test_cmp expect actual &&
     ++	test_grep "ls-remote> server-option=tar" log &&
     ++	test_grep ! "ls-remote> server-option=foo" log &&
     ++	test_grep ! "ls-remote> server-option=bar" log &&
     ++	rm -f log &&
     ++
     ++	# Server option from command line overrides those from configuration
     ++	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
     ++		ls-remote -o hello -o world origin main >actual &&
     ++	test_cmp expect actual &&
     ++	test_grep "ls-remote> server-option=hello" log &&
     ++	test_grep "ls-remote> server-option=world" log &&
     ++	test_grep ! "ls-remote> server-option=tar" log
     ++'
     ++
     + test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
     + 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
     + 		ls-remote -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
     +@@ t/t5702-protocol-v2.sh: test_expect_success 'server-options are sent when fetching' '
     + 	grep "server-option=world" log
     + '
       
     --	if (server_options.nr)
     --		transport->server_options = &server_options;
     -+	if (server_options && server_options->nr)
     -+		transport->server_options = server_options;
     ++test_expect_success 'server-options from configuration are used by git-fetch' '
     ++	test_when_finished "rm -rf log myclone" &&
     ++	git clone "file://$(pwd)/file_parent" myclone &&
     ++	git -C file_parent log -1 --format=%s >expect &&
     ++
     ++	# Default server options from configuration are used
     ++	git -C myclone config --add remote.origin.serverOption foo &&
     ++	git -C myclone config --add remote.origin.serverOption bar &&
     ++	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
     ++		fetch origin main &&
     ++	git -C myclone log -1 --format=%s origin/main >actual &&
     ++	test_cmp expect actual &&
     ++	test_grep "fetch> server-option=foo" log &&
     ++	test_grep "fetch> server-option=bar" log &&
     ++	rm -f log &&
     ++
     ++	# Empty value of remote.<name>.serverOption clears the list
     ++	git -C myclone config --add remote.origin.serverOption "" &&
     ++	git -C myclone config --add remote.origin.serverOption tar &&
     ++	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
     ++		fetch origin main &&
     ++	git -C myclone log -1 --format=%s origin/main >actual &&
     ++	test_cmp expect actual &&
     ++	test_grep "fetch> server-option=tar" log &&
     ++	test_grep ! "fetch> server-option=foo" log &&
     ++	test_grep ! "fetch> server-option=bar" log &&
     ++	rm -f log &&
     ++
     ++	# Server option from command line overrides those from configuration
     ++	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
     ++		fetch -o hello -o world origin main &&
     ++	git -C myclone log -1 --format=%s origin/main >actual &&
     ++	test_cmp expect actual &&
     ++	test_grep "fetch> server-option=hello" log &&
     ++	test_grep "fetch> server-option=world" log &&
     ++	test_grep ! "fetch> server-option=tar" log
     ++'
     ++
     + test_expect_success 'warn if using server-option with fetch with legacy protocol' '
     + 	test_when_finished "rm -rf temp_child" &&
       
     - 	if (filter_options.choice) {
     - 		const char *spec =
     -
     - ## t/t5702-protocol-v2.sh ##
     -@@ t/t5702-protocol-v2.sh: test_expect_success 'warn if using server-option with fetch with legacy protocol
     - test_expect_success 'server-options are sent when cloning' '
     - 	test_when_finished "rm -rf log myclone" &&
     +@@ t/t5702-protocol-v2.sh: test_expect_success 'server-options are sent when cloning' '
     + 	grep "server-option=world" log
     + '
       
     -+	# Specify server options from command line
     - 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
     - 		clone --server-option=hello --server-option=world \
     - 		"file://$(pwd)/file_parent" myclone &&
     -+	test_grep "server-option=hello" log &&
     -+	test_grep "server-option=world" log &&
     ++test_expect_success 'server-options from configuration are used by git-clone' '
     ++	test_when_finished "rm -rf log myclone" &&
     ++
     ++	# Default server options from configuration are used
     ++	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
     ++		-c remote.origin.serverOption=foo -c remote.origin.serverOption=bar \
     ++		clone "file://$(pwd)/file_parent" myclone &&
     ++	test_grep "clone> server-option=foo" log &&
     ++	test_grep "clone> server-option=bar" log &&
      +	rm -rf log myclone &&
     - 
     --	grep "server-option=hello" log &&
     --	grep "server-option=world" log
     -+	# Specify server options from fetch.serverOption config
     ++
     ++	# Empty value of remote.<name>.serverOption clears the list
      +	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
     -+		-c fetch.serverOption=hello -c fetch.serverOption=world \
     ++		-c remote.origin.serverOption=foo -c remote.origin.serverOption=bar \
     ++		-c remote.origin.serverOption= -c remote.origin.serverOption=tar \
      +		clone "file://$(pwd)/file_parent" myclone &&
     -+	test_grep "server-option=hello" log &&
     -+	test_grep "server-option=world" log &&
     ++	test_grep "clone> server-option=tar" log &&
     ++	test_grep ! "clone> server-option=foo" log &&
     ++	test_grep ! "clone> server-option=bar" log &&
      +	rm -rf log myclone &&
      +
     -+	# Cmdline server options take a higher priority
     ++	# Server option from command line overrides those from configuration
      +	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
     -+		-c fetch.serverOption=hello -c fetch.serverOption=world \
     -+		clone --server-option=foo=bar \
     ++		-c remote.origin.serverOption=tar \
     ++		clone --server-option=hello --server-option=world \
      +		"file://$(pwd)/file_parent" myclone &&
     -+	test_grep ! "server-option=hello" log &&
     -+	test_grep ! "server-option=world" log &&
     -+	test_grep "server-option=foo=bar" log
     ++	test_grep "clone> server-option=hello" log &&
     ++	test_grep "clone> server-option=world" log &&
     ++	test_grep ! "clone> server-option=tar" log
     ++'
     ++
     + test_expect_success 'warn if using server-option with clone with legacy protocol' '
     + 	test_when_finished "rm -rf myclone" &&
     + 
     +@@ t/t5702-protocol-v2.sh: test_expect_success 'warn if using server-option with clone with legacy protocol
     + 	test_grep "server options require protocol version 2 or later" err
       '
       
     - test_expect_success 'warn if using server-option with clone with legacy protocol' '
     ++test_expect_success 'server-option configuration with legacy protocol is ok' '
     ++	test_when_finished "rm -rf myclone" &&
     ++
     ++	env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
     ++		-c remote.origin.serverOption=foo -c remote.origin.serverOption=bar \
     ++		clone "file://$(pwd)/file_parent" myclone
     ++'
     ++
     ++test_expect_success 'invalid server-option configuration' '
     ++	test_when_finished "rm -rf myclone" &&
     ++
     ++	test_must_fail git -c protocol.version=2 \
     ++		-c remote.origin.serverOption \
     ++		clone "file://$(pwd)/file_parent" myclone 2>err &&
     ++	test_grep "error: missing value for '\''remote.origin.serveroption'\''" err
     ++'
     ++
     + test_expect_success 'upload-pack respects config using protocol v2' '
     + 	git init server &&
     + 	write_script server/.git/hook <<-\EOF &&
     +
     + ## transport.c ##
     +@@ transport.c: static struct ref *handshake(struct transport *transport, int for_push,
     + 	data->version = discover_version(&reader);
     + 	switch (data->version) {
     + 	case protocol_v2:
     ++		if ((!transport->server_options || !transport->server_options->nr) &&
     ++		    transport->remote->server_options.nr)
     ++			transport->server_options = &transport->remote->server_options;
     + 		if (server_feature_v2("session-id", &server_sid))
     + 			trace2_data_string("transfer", NULL, "server-sid", server_sid);
     + 		if (must_list_refs)
 4:  8962031f999 < -:  ----------- builtin/ls-remote.c: recognize fetch.serverOption configuration
 -:  ----------- > 4:  39ee8dbef78 fetch: respect --server-option when fetching multiple remotes
 -:  ----------- > 5:  39c07a6c8ee ls-remote: leakfix for not clearing server_options

-- 
gitgitgadget
