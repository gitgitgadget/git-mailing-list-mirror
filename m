Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605A41FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 21:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbcKYVZy (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 16:25:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36048 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbcKYVZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 16:25:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so9431990wma.3
        for <git@vger.kernel.org>; Fri, 25 Nov 2016 13:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vbZ0jGr97bo2T7/u/5SDIKWY7BzSa7Cez8BPLunzjLQ=;
        b=ZMVaDyAqzA9X5lFS/msVovyOPyu/ywz4ERQ635puKcow8938nyz+O13oOAnhvlSfvg
         fp4kCZKKDOt/0E/SQ0zrf40iD/XiOJ3TeV6W5FkjBpbpT3CVezjxkAnhD/K1Ia1a7Yxn
         16ObvrcyGA04cYd39Pu8xwsK/LcUtqQTr/jsdpicIbSLTkhJCctVF0D4js/3TcnMjJ8N
         1a2ovSE1uY5WTqxeGWjHN2f9Uab76B0BEILGu36pziHAOyaPYQ1M2MsaAmf0PCumnVpj
         sekdHOQ+hbq+LkgF8VsDXymAI+UgxfX717Ca1wZbZQ05bKRjnYsLx+1o38yXzqagiTGW
         oHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vbZ0jGr97bo2T7/u/5SDIKWY7BzSa7Cez8BPLunzjLQ=;
        b=Ku1i2GmEspZqPGYALFpmCcMyDoT2hTiNTfIvF6qYNliqxkQ6t/TQ1kCBN+m3geIbEm
         See0mnSZB6PdAT71d3D90NrGJ+lEZX39EGKvLGCNjZdR9K76aOnccD5//WqNyQymSbRx
         jDcqKLgbujibBfX8RrWkZvlehkJ5024Roc3d1/nFWOJxkPMgjugWkkr7Rj5/K58tEI9N
         BYa4V5cPyHqT4CudjzLTDcheRY2qEnzZZplCDs04qfVJBcEXCkmzRJIaCATmswm+sNAC
         yEKh5a5R1Zvz5Tx95hV2bNQf59x7NkMBQivO3LX4XieT+hD0KPJoZtES5X2O8cIn20Kw
         1dGg==
X-Gm-Message-State: AKaTC01WXUu1kWAbdRHgFVreWdz/rpVn/3BaS5NDLui6Q/0mB/itUDXMN+FxJjtc4397pQ==
X-Received: by 10.28.209.67 with SMTP id i64mr9777520wmg.48.1480109085739;
        Fri, 25 Nov 2016 13:24:45 -0800 (PST)
Received: from [192.168.1.26] (adan31.neoplus.adsl.tpnet.pl. [83.11.249.31])
        by smtp.googlemail.com with ESMTPSA id g10sm48861263wjw.18.2016.11.25.13.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2016 13:24:44 -0800 (PST)
Subject: Re: [PATCH v3 2/2] difftool: implement the functionality in the
 builtin
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1479938494.git.johannes.schindelin@gmx.de>
 <cover.1480019834.git.johannes.schindelin@gmx.de>
 <ac91e4818cfb5c5af6b5874662dbeb61cde1f69d.1480019834.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2994b0d6-4b6c-84e7-d0d5-257bcae3be98@gmail.com>
Date:   Fri, 25 Nov 2016 22:24:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <ac91e4818cfb5c5af6b5874662dbeb61cde1f69d.1480019834.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.11.2016 o 21:55, Johannes Schindelin pisze:

> The current version of the builtin difftool does not, however, make full
> use of the internals but instead chooses to spawn a couple of Git
> processes, still, to make for an easier conversion. There remains a lot
> of room for improvement, left for a later date.
[...]

> Sadly, the speedup is more noticable on Linux than on Windows: a quick
> test shows that t7800-difftool.sh runs in (2.183s/0.052s/0.108s)
> (real/user/sys) in a Linux VM, down from  (6.529s/3.112s/0.644s), while
> on Windows, it is (36.064s/2.730s/7.194s), down from
> (47.637s/2.407s/6.863s). The culprit is most likely the overhead
> incurred from *still* having to shell out to mergetool-lib.sh and
> difftool--helper.sh.

Does this mean that our shell-based testsuite is not well suited to be
benchmark suite for comparing performance on MS Windows?

Or does it mean that "builtin-difftool" spawning Git processes is the
problem?
 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/difftool.c | 670 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 669 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 53870bb..3480920 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -11,9 +11,608 @@
>   *
>   * Copyright (C) 2016 Johannes Schindelin
>   */
> +#include "cache.h"
>  #include "builtin.h"
>  #include "run-command.h"
>  #include "exec_cmd.h"
> +#include "parse-options.h"
> +#include "argv-array.h"
> +#include "strbuf.h"
> +#include "lockfile.h"
> +#include "dir.h"
> +
> +static char *diff_gui_tool;
> +static int trust_exit_code;
> +
> +static const char *const builtin_difftool_usage[] = {
> +	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
> +	NULL
> +};
> +
> +static int difftool_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "diff.guitool")) {

Shouldn't you also read other configuration variables, like "diff.tool",
and it's mergetool fallbacks ("merge.guitool", "merge.tool")?

> +		diff_gui_tool = xstrdup(value);
> +		return 0;
> +	}
> +
> +	if (!strcmp(var, "difftool.trustexitcode")) {
> +		trust_exit_code = git_config_bool(var, value);
> +		return 0;
> +	}

Why you do not need to check "difftool.prompt"?  And "mergetool.*" fallbacks?

> +
> +	return git_default_config(var, value, cb);
> +}
> +
> +static int print_tool_help(void)
> +{
> +	const char *argv[] = { "mergetool", "--tool-help=diff", NULL };
> +	return run_command_v_opt(argv, RUN_GIT_CMD);

This looks a bit strange to me, but I guess this is to avoid recursively
invoking ourself, and { "legacy-difftool", "--tool-help", NULL }; isn't
that much better.

> +}
> +
> +static int parse_index_info(char *p, int *mode1, int *mode2,
> +			    struct object_id *oid1, struct object_id *oid2,
> +			    char *status)

  There are only two hard things in Computer Science:
  cache invalidation and naming things.
    -- Phil Karlton

Why did you name function that parses "diff --raw" output (aka "diff-tree"
output) parse_index_info() instead of parse_raw_diff() or parse_diff_tree()?
I went searching for `update-index --index-info` formats...

This is not that important, because this function is file-static; though
future developers would thank you for more descriptive naming.

ADDED: Disregard this, I see this function is about index (?) part of
raw diff, that is only a part of "git diff --raw -z" output.  Though...

> +{
> +	if (*p != ':')
> +		return error("expected ':', got '%c'", *p);
> +	*mode1 = (int)strtol(p + 1, &p, 8);
> +	if (*p != ' ')
> +		return error("expected ' ', got '%c'", *p);

Nitpicking.

I guess because this error shouldn't really happen, and because current
implementation is transient, we don't need to worry about better error
messages (was it problem with parsing, or was it unexpected character).

For example '10064x', or '10064\n' would fail parse, but it is not
space that we were expecting...

> +	*mode2 = (int)strtol(p + 1, &p, 8);
> +	if (*p != ' ')
> +		return error("expected ' ', got '%c'", *p);
> +	if (get_oid_hex(++p, oid1))
> +		return error("expected object ID, got '%s'", p + 1);
> +	p += GIT_SHA1_HEXSZ;
> +	if (*p != ' ')
> +		return error("expected ' ', got '%c'", *p);
> +	if (get_oid_hex(++p, oid2))
> +		return error("expected object ID, got '%s'", p + 1);
> +	p += GIT_SHA1_HEXSZ;
> +	if (*p != ' ')
> +		return error("expected ' ', got '%c'", *p);
> +	*status = *++p;
> +	if (!status || p[1])
> +		return error("unexpected trailer: '%s'", p);
> +	return 0;
> +}
> +
> +/*
> + * Remove any trailing slash from $workdir
> + * before starting to avoid double slashes in symlink targets.
> + */

Err... that's not what add_path() does, in its current implementation.
It doesn't remove trailing slashes, but it checks if there is trailing
slash, and if there isn't, it adds it as separator before adding path.

Or was it original comment from the Perl implementation?  It look
like this, with '$workdir'...  If it is meant to be straight copy
of comment from legacy-difftool, a note would be nice.

> +static void add_path(struct strbuf *buf, size_t base_len, const char *path)

Naming: I think strbuf_addpath() would be a better name, but I guess
it is a matter of taste.

> +{
> +	strbuf_setlen(buf, base_len);
> +	if (buf->len && buf->buf[buf->len - 1] != '/')
> +		strbuf_addch(buf, '/');
> +	strbuf_addstr(buf, path);
> +}
> +
> +/*
> + * Determine whether we can simply reuse the file in the worktree.
> + */
> +static int use_wt_file(const char *workdir, const char *name,

Should it be 'name' or 'pathname'?

> +		       struct object_id *oid)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct stat st;
> +	int use = 0;
> +
> +	strbuf_addstr(&buf, workdir);
> +	add_path(&buf, buf.len, name);

With proposed rename, it would IMVVVHO looks better

  +	strbuf_addstr(&buf, workdir);
  +	strbuf_addpath(&buf, buf.len, name);

But that is a matter of taste (again, the function is file-local).

> +
> +	if (!lstat(buf.buf, &st) && !S_ISLNK(st.st_mode)) {
> +		struct object_id wt_oid;
> +		int fd = open(buf.buf, O_RDONLY);
> +
> +		if (!index_fd(wt_oid.hash, fd, &st, OBJ_BLOB, name, 0)) {
> +			if (is_null_oid(oid)) {
> +				oidcpy(oid, &wt_oid);
> +				use = 1;
> +			} else if (!oidcmp(oid, &wt_oid))
> +				use = 1;
> +		}
> +	}
> +
> +	strbuf_release(&buf);
> +
> +	return use;
> +}

[...]

> +static int ensure_leading_directories(char *path)
> +{
> +	switch (safe_create_leading_directories(path)) {
> +		case SCLD_OK:
> +		case SCLD_EXISTS:
> +			return 0;
> +		default:
> +			return error(_("could not create leading directories "
> +				       "of '%s'"), path);
> +	}
> +}

Nice function, I wonder if it would be useful in other places.

> +
> +static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
> +			int argc, const char **argv)
> +{
> +	char tmpdir[PATH_MAX];
> +	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
> +	struct strbuf rpath = STRBUF_INIT, buf = STRBUF_INIT;

Nitpicking.

To be symmetric, it could be reordered like this:

  +	struct strbuf info = STRBUF_INIT, buf = STRBUF_INIT;
  +	struct strbuf lpath = STRBUF_INIT, rpath = STRBUF_INIT;

See: lpath, rpath; ldir, rdir; ldir_len, rdir_len.

> +	struct strbuf ldir = STRBUF_INIT, rdir = STRBUF_INIT;
> +	struct strbuf wtdir = STRBUF_INIT;
> +	size_t ldir_len, rdir_len, wtdir_len;

[...]
> +	argv_array_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
> +			 NULL);
> +	for (i = 0; i < argc; i++)
> +		argv_array_push(&child.args, argv[i]);
> +	if (start_command(&child))
> +		die("could not obtain raw diff");
> +	fp = xfdopen(child.out, "r");
> +
> +	/* Build index info for left and right sides of the diff */
> +	i = 0;
> +	while (!strbuf_getline_nul(&info, fp)) {
> +		int lmode, rmode;
> +		struct object_id loid, roid;
> +		char status;
> +		const char *src_path, *dst_path;
> +		size_t src_path_len, dst_path_len;
> +
> +		if (starts_with(info.buf, "::"))
> +			die(N_("combined diff formats('-c' and '--cc') are "
> +			       "not supported in\n"
> +			       "directory diff mode('-d' and '--dir-diff')."));
> +
> +		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
> +				     &status))

After rename it would read as:

  +		if (parse_raw_diff(info.buf, &lmode, &rmode, &loid, &roid,
  +				   &status))

Though now I see that you parse here index information of raw diff
(I think)... so disregard my musings.

> +			break;
> +		if (strbuf_getline_nul(&lpath, fp))
> +			break;
> +		src_path = lpath.buf;
> +		src_path_len = lpath.len;
> +
> +		i++;
> +		if (status != 'C' && status != 'R') {
> +			dst_path = src_path;
> +			dst_path_len = src_path_len;
> +		} else {
> +			if (strbuf_getline_nul(&rpath, fp))
> +				break;
> +			dst_path = rpath.buf;
> +			dst_path_len = rpath.len;
> +		}


[...]
> +	/*
> +	 * Changes to submodules require special treatment.This loop writes a

Here and in few other places you are missing space after full stop.

  +	 * Changes to submodules require special treatment. This loop writes a


> +	 * temporary file to both the left and right directories to show the
> +	 * change in the recorded SHA1 for the submodule.
> +	 */
> +	hashmap_iter_init(&submodules, &iter);
> +	while ((entry = hashmap_iter_next(&iter))) {
> +		if (*entry->left) {
> +			add_path(&ldir, ldir_len, entry->path);
> +			ensure_leading_directories(ldir.buf);
> +			write_file(ldir.buf, "%s", entry->left);
> +		}
> +		if (*entry->right) {
> +			add_path(&rdir, rdir_len, entry->path);
> +			ensure_leading_directories(rdir.buf);
> +			write_file(rdir.buf, "%s", entry->right);
> +		}
> +	}
> +
> +	/*
> +	 * Symbolic links require special treatment.The standard "git diff"

Same here.

> +	 * shows only the link itself, not the contents of the link target.
> +	 * This loop replicates that behavior.
> +	 */

Best,
-- 
Jakub Narębski

