Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF1E1F424
	for <e@80x24.org>; Wed,  9 May 2018 00:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933175AbeEIAaD (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 20:30:03 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:44747 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeEIAaC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 20:30:02 -0400
Received: by mail-pf0-f179.google.com with SMTP id q22so24740025pff.11
        for <git@vger.kernel.org>; Tue, 08 May 2018 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NyR+dPQbjt4euiNUAu6/ELnJWShoZ1lmMMTod+ZVW00=;
        b=ci/ehdel3rWqfXFw+JXMyNuo+5j8Of81BS5J0yAcSvkce0ZFIUy6G9e+ZYirClJl0w
         pnVnvB86bK4lqllkr/GwFzMIiv/tgbvvdzr2hRRILSQ60uNjwDuNcZf7BOMcSlSdm0WQ
         hiO9ylGgWTZFw2VC565lpmgZHNsUvh5GtWZjLhvi4C7eF8mqJ6HAdYBnK2FNYQYGU08o
         EGsoFq/Uzw7v6CkiqSUZnRjSuy/A3VwB33Twy4DKTqeyCO5gwqCkZd429nZxOrpIJUm+
         Fs9P4+vVZ3VgzI5rZtarGOuyCVC8SeGp+YWSd13MMgkjyyqKkNMCOJHGQKgV5/wvI9/i
         TUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NyR+dPQbjt4euiNUAu6/ELnJWShoZ1lmMMTod+ZVW00=;
        b=cTmGgudQIbW1WickbdgaQ6Z6nUUu2Gzwm4ppZqkrCAnXogR+FB3PCTMGuV6Zk7pcTu
         fktYaO5/6ryqq4NGcQwUJCY4rtBNq2jjjSSYYzQDhYwYIrAjlg7qKs8TA4N/II+6icmY
         HgZMARpn810beG6odV0n5I5IR9pyOX4nHgtMshCSngeQ79uoqC4k4mbRDxJjuuLv40X9
         v7MT3xTGu8tCXwsREeUy37zAxPz3PXezly5aS97XcTnc2vHx3FZblNjefpfRdaWbSZ9E
         atVRUwxoh35Bhhjr0JzbyNb+K6ua8MQNvdMi/wjY5v6siAbfCyUYHyB1tWYU/9qxd/mH
         iMSg==
X-Gm-Message-State: ALQs6tCvDeFzUfzGfkRbW171iX7k1yJSLbnaoUCCQpY5w7K7wqcd5iwn
        5G+1U2YS56MJukQSEPnXuquV0TIjc9g=
X-Google-Smtp-Source: AB8JxZroQzWBB/i6Je3nIu6zS3mT81X8Vpddx+0cVpWuLDXfx7p3uZusuaGTzC+5/T262TdUoFsZPA==
X-Received: by 2002:a65:5509:: with SMTP id f9-v6mr34619606pgr.317.1525825800780;
        Tue, 08 May 2018 17:30:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f29sm52493839pff.169.2018.05.08.17.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 17:29:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, pc44800@gmail.com
Subject: [PATCHv2 0/4] Rebooting pc/submodule-helper-foreach
Date:   Tue,  8 May 2018 17:29:48 -0700
Message-Id: <20180509002952.172347-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180503005358.89082-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* rebased onto origin/master
* dropped leftover "toplevel" variable from experimentation
* reworded the commit message for the first patch extensively
* dropped the third patch
* see "branch-diff" below.

v1:
The "What's cooking" email carried this series for some time now:
> * pc/submodule-helper-foreach (2018-02-02) 5 commits
>  - submodule: port submodule subcommand 'foreach' from shell to C
> - submodule foreach: document variable '$displaypath'
>  - submodule foreach: clarify the '$toplevel' variable documentation
>  - submodule foreach: document '$sm_path' instead of '$path'
>  - submodule foreach: correct '$path' in nested submodules from a subdirectory
> 
>  Expecting a response to review comments
>  e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>

I reworded the commit message of the first patch and nearly confused
myself again, as "toplevel" doesn't refer to the "topmost" superproject,
just the direct superproject of the submodule.

However I think the code of the first patch is correct as originally presented.
Just the wording of the commit message was changed to explain the reasoning
more extensively.

With this series, we get
* keep the invariant of $toplevel + $path to be an absolute path that is
  correctly pointing at the submodule. "git -C $toplevel config" + $name
  allowing to ask configuration of the submodule.  
* $displaypath will have the relative path form $pwd to the submodule root.
* better documentation.

In later patches we could add $topmost, that points at the superproject
in which the command was started from, and $path_from_topmost, that would
be the relative path from $topmost to the submodule, potentially skipping
intermediate superprojects.

Thanks,
Stefan

Prathamesh Chavan (4):
  submodule foreach: correct '$path' in nested submodules from a
    subdirectory
  submodule foreach: document '$sm_path' instead of '$path'
  submodule foreach: document variable '$displaypath'
  submodule: port submodule subcommand 'foreach' from shell to C

 Documentation/git-submodule.txt |  15 ++--
 builtin/submodule--helper.c     | 144 ++++++++++++++++++++++++++++++++
 git-submodule.sh                |  40 +--------
 t/t7407-submodule-foreach.sh    |  38 ++++++++-
 4 files changed, 190 insertions(+), 47 deletions(-)

-- 
2.17.0.255.g8bfb7c0704

1:  0c5f405db24 ! 1:  85f91b48379 submodule foreach: correct '$path' in nested submodules from a subdirectory
    @@ -12,45 +12,38 @@
         submodule path inside the submodule. This value is of little use and is
         hard to document.
     
    -    There are three different possible solutions that have more value:
    -    (a) The path value is documented as the path from the toplevel of the
    -        superproject to the mount point of the submodule. If 'the' refers to
    -        the superproject holding this submodule ('sub' holding 'nested'),
    -        the path would be expected to be path='nested'.
    -    (b) In case 'the' superproject is referring to the toplevel, which
    -        is the superproject in which the original command was invoked,
    -        then path is expected to be path='sub/nested'.
    -    (c) The documentation explains $path as [...] "relative to the
    -        superproject", following 091a6eb0fe (submodule: drop the
    -        top-level requirement, 2013-06-16), such that the nested submodule
    -        would be expected as path='../sub/nested', when "the" superproject
    -        is the superproject, where the command was run from
    -    (d) or the value of path='nested' is expected if we take the
    -        intermediate superproject into account. [This is the same as
    -        (a); it highlights that the documentation is not clear, but
    -        technically correct if we were to revert 091a6eb0fe.]
    +    Also, in git-submodule.txt, $path is documented to be the "name of the
    +    submodule directory relative to the superproject", but "the
    +    superproject" is ambiguous.
     
    -    The behavior for (c) was introduced in 091a6eb0fe (submodule: drop the
    -    top-level requirement, 2013-06-16) the intent for $path seemed to be
    -    relative to $cwd to the submodule worktree, but that did not work for
    -    nested submodules, as the intermittent submodules were not included in
    -    the path.
    +    To resolve both these issues, we could:
    +    (a) Change "the superproject" to "its immediate superproject", so
    +        $path would be "nested" instead of "../nested".
    +    (b) Change "the superproject" to "the superproject the original
    +        command was run from", so $path would be "sub/nested" instead of
    +        "../nested".
    +    (c) Change "the superproject" to "the directory the original command
    +        was run from", so $path would be "../sub/nested" instead of
    +        "../nested".
     
    -    If we were to fix the meaning of the $path using (a), (d) such that "path"
    -    is "the path from the intermediate superproject to the mount point of the
    -    submodule", we would break any existing submodule user that runs foreach
    -    from non-root of the superproject as the non-nested submodule
    -    '../sub' would change its path to 'sub'.
    +    The behavior for (c) was attempted to be introduced in 091a6eb0fe
    +    (submodule: drop the top-level requirement, 2013-06-16) with the intent
    +    for $path to be relative from $pwd to the submodule worktree, but that
    +    did not work for nested submodules, as the intermittent submodules
    +    were not included in the path.
     
    -    If we were to fix the meaning of $path using (b) such that "path"
    -    is "the path from the topmost superproject to the mount point of the
    -    submodule", then we would break any user that uses nested submodules
    -    (even from the root directory) as the 'nested' would become 'sub/nested'.
    +    If we were to fix the meaning of the $path using (a), we would break
    +    any existing submodule user that runs foreach from non-root of the
    +    superproject as the non-nested submodule '../sub' would change its
    +    path to 'sub'.
     
    -    If we were to fix the meaning of $path using (c) such that "path"
    -    is "the display path from where the original command was invoked to the
    -    submodule", then we would break users that rely on the assumption that
    -    "$toplevel / $path" is the absolute path of the submodule.
    +    If we were to fix the meaning of $path using (b), then we would break
    +    any user that uses nested submodules (even from the root directory)
    +    as the 'nested' would become 'sub/nested'.
    +
    +    If we were to fix the meaning of $path using (c), then we would break
    +    the same users as in (b) as 'nested' would become 'sub/nested' from
    +    the root directory of the superproject.
     
         All groups can be found in the wild.  The author has no data if one group
         outweighs the other by large margin, and offending each one seems equally
    @@ -60,13 +53,6 @@
         the feedback loop is short and the changed behavior can be adapted to
         quickly unlike some automation that can break silently.
     
    -    Another argument in favor of (a) is the consistency of the variables
    -    provided, "$toplevel / $path" gives the absolute path of the submodule,
    -    with 'toplevel' (both the variable as well as the documentation) referring
    -    to the immediate superproject of the submodule.
    -
    -    Documentation of the variable is adjusted in a follow-up patch.
    -
         Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
         Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
2:  ae5e280a8d3 ! 2:  3a2cb4e0b01 submodule foreach: document '$sm_path' instead of '$path'
    @@ -28,9 +28,10 @@
     -	$path is the name of the submodule directory relative to the
     -	superproject, $sha1 is the commit as recorded in the superproject,
     -	and $toplevel is the absolute path to the top-level of the superproject.
    -+	$sm_path is the path of the submodule as recorded in the superproject,
    -+	$sha1 is the commit as recorded in the superproject, and
    -+	$toplevel is the absolute path to the top-level of the superproject.
    ++	$sm_path is the path of the submodule as recorded in the immediate
    ++	superproject, $sha1 is the commit as recorded in the immediate
    ++	superproject, and $toplevel is the absolute path to the top-level
    ++	of the immediate superproject.
     +	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
     +	variable is now a deprecated synonym of '$sm_path' variable.
      	Any submodules defined in the superproject but not checked out are
3:  23a5f04f846 < -:  ----------- submodule foreach: clarify the '$toplevel' variable documentation
4:  3efed1cdb80 ! 3:  3f4686e8395 submodule foreach: document variable '$displaypath'
    @@ -22,12 +22,14 @@
     +	The command has access to the variables $name, $sm_path, $displaypath,
     +	$sha1 and $toplevel:
      	$name is the name of the relevant submodule section in `.gitmodules`,
    - 	$sm_path is the path of the submodule as recorded in the superproject,
    -+	$displaypath contains the relative path from the current working
    -+	directory to the submodules root directory,
    - 	$sha1 is the commit as recorded in the superproject, and
    - 	$toplevel is the absolute path to its direct superproject, such that
    - 	$toplevel/$sm_path is the absolute path of the submodule.
    + 	$sm_path is the path of the submodule as recorded in the immediate
    +-	superproject, $sha1 is the commit as recorded in the immediate
    ++	superproject, $displaypath contains the relative path from the
    ++	current working directory to the submodules root directory,
    ++	$sha1 is the commit as recorded in the immediate
    + 	superproject, and $toplevel is the absolute path to the top-level
    + 	of the immediate superproject.
    + 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
     
     diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
     --- a/t/t7407-submodule-foreach.sh
5:  2b17d6891b3 ! 4:  0c677680928 submodule: port submodule subcommand 'foreach' from shell to C
    @@ -23,7 +23,6 @@
     +	int argc;
     +	const char **argv;
     +	const char *prefix;
    -+	char *toplevel;
     +	int quiet;
     +	int recursive;
     +};
    @@ -42,7 +41,7 @@
     +
     +	displaypath = get_submodule_displaypath(path, info->prefix);
     +
    -+	sub = submodule_from_path(&null_oid, path);
    ++	sub = submodule_from_path(the_repository, &null_oid, path);
     +
     +	if (!sub)
     +		die(_("No url found for submodule path '%s' in .gitmodules"),
    @@ -69,6 +68,7 @@
     +	*/
     +	if (info->argc == 1) {
     +		char *toplevel = xgetcwd();
    ++		struct strbuf sb = STRBUF_INIT;
     +
     +		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
     +		argv_array_pushf(&cp.env_array, "sm_path=%s", path);
    @@ -86,9 +86,10 @@
     +		* existing PATH variable. Hence, to avoid that, we expose
     +		* path via the args argv_array and not via env_array.
     +		*/
    ++		sq_quote_buf(&sb, path);
     +		argv_array_pushf(&cp.args, "path=%s; %s",
    -+				path, info->argv[0]);
    -+
    ++				 sb.buf, info->argv[0]);
    ++		strbuf_release(&sb);
     +		free(toplevel);
     +	} else {
     +		argv_array_pushv(&cp.args, info->argv);
    @@ -116,9 +117,6 @@
     +		if (info->quiet)
     +			argv_array_push(&cpr.args, "--quiet");
     +
    -+		if (info->toplevel)
    -+			argv_array_pushf(&cpr.args, "--toplevel=%s", info->toplevel);
    -+
     +		argv_array_pushv(&cpr.args, info->argv);
     +
     +		if (run_command(&cpr))
    @@ -141,8 +139,6 @@
     +		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
     +		OPT_BOOL(0, "recursive", &info.recursive,
     +			 N_("Recurse into nested submodules")),
    -+		OPT_STRING(0, "toplevel", &info.toplevel, N_("path"),
    -+			   N_("path from the top level of the invocation")),
     +		OPT_END()
     +	};
     +
