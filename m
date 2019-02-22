Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C408020248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfBVWZD (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43980 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVWZD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so3072249ede.10
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zt9GkPI8vSmpHQrd/im0fRSMeXo5wM226xOiWebWF1w=;
        b=aff8qwvIjB9v/gYJvYGG/c4GQi+sRvxNc12HDwjIpe1JrHrQW0o1knL93mXer4Qr83
         NBTNgoTEaW1o2x3pdmg4QwT/O4TUD34eRNKqiG/s3+HSyWyL01XRhYzogMoR9V/WMEDi
         pvh9CT2uvhr6qZQvfHzyJpaea2uTzeNa+QcjtpZxG3qx2S8jkGjzNIl38MQc7TjX/Ipa
         9IfyuctASxIYTggTQEY478ft1ZXP3zmShgLY7yFquYydnhj1a9E3w797SMNTp1f/Qegf
         18eIWdE/HsLNEJNkWbxUopZVRiq0yb411U+Q9rR1cHCxHOmYWkBSY8diAp9Y2u2YT24I
         oZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zt9GkPI8vSmpHQrd/im0fRSMeXo5wM226xOiWebWF1w=;
        b=rc3UOqLdTk8bDA850xAFSOi8Bx88Z2t2w4iRmCP9yHy6D4H03H0YxK1VKJ9/UgdFY/
         3iw/xsMMKFmfYgbqDJoAm3L6pX+Ze5etD7fpi0zQOnbKnLRv97RbXLGc7wMbehf/+RXS
         B5rRPe6xnZ4F9XxRg+Wg+Wd3YQ3bqYahAOS7ElDOR83+H7M3C1pTw4yIhH2ye9nVn5Yd
         BD1sWU2Q3bNlc8TsRdQh0Krde+LK/Sr0aoyhtvm33fSJcbLFK62mwDbVN2Wn22v8MQpb
         bw+DOBz8bQ0cSbmkvfFXLT55hYC97FlQtVojY+v9pMC3QTuG/aDMbbaCgcB/Bp3lla+T
         Sojw==
X-Gm-Message-State: AHQUAuaB3JD1M2Lk7EjdVsf0qBfNrME+5PnSffV3z61nF1Kc58in5wF2
        m9C50LvEY+X2izvHG3gDhvZXHyDd
X-Google-Smtp-Source: AHgI3IYuA9W77Qf+ZYF573NH/AbZxKOq4w/BSJgxX898xW8u1BOrXvkehGDkyZWWQZ/aVeSLDaDCUQ==
X-Received: by 2002:a50:941a:: with SMTP id p26mr5127575eda.220.1550874300058;
        Fri, 22 Feb 2019 14:25:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm705412edb.54.2019.02.22.14.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:24:59 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:24:59 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:43 GMT
Message-Id: <pull.108.v7.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 00/15] Trace2 tracing facility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V7 addresses: [] squashes in the fixup for windows process ancestry
calculation. [] adds optional socket_type parameter to the unix domain
socket syntax. [] allow unix domain socket syntax to try both stream and
dgram if socket_type not specified. [] add Perl prereq checks for JSON:PP in
trace2 tests. [] minor clang-format cleanup.

Thanks Jeff

Cc: gitster@pobox.comCc: peff@peff.netCc: avarab@gmail.com

Derrick Stolee (1):
  trace2:data: pack-objects: add trace2 regions

Jeff Hostetler (14):
  trace2: Documentation/technical/api-trace2.txt
  trace2: create new combined trace facility
  trace2: collect Windows-specific process information
  trace2:data: add trace2 regions to wt-status
  trace2:data: add editor/pager child classification
  trace2:data: add trace2 sub-process classification
  trace2:data: add trace2 transport child classification
  trace2:data: add trace2 hook classification
  trace2:data: add trace2 instrumentation to index read/write
  trace2:data: add subverb to checkout command
  trace2:data: add subverb to reset command
  trace2:data: add subverb for rebase
  trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
  trace2: add for_each macros to clang-format

 .clang-format                            |    2 +-
 Documentation/technical/api-trace2.txt   | 1350 ++++++++++++++++++++++
 Makefile                                 |   15 +-
 builtin/am.c                             |    1 +
 builtin/checkout.c                       |    7 +
 builtin/pack-objects.c                   |   16 +-
 builtin/rebase.c                         |   17 +
 builtin/receive-pack.c                   |    4 +
 builtin/reset.c                          |    6 +
 builtin/submodule--helper.c              |    9 +-
 builtin/worktree.c                       |    1 +
 cache.h                                  |    1 +
 common-main.c                            |   13 +-
 compat/mingw.c                           |   11 +-
 compat/mingw.h                           |    3 +-
 compat/win32/trace2_win32_process_info.c |  147 +++
 config.c                                 |    2 +
 config.mak.uname                         |    2 +
 connect.c                                |    3 +
 editor.c                                 |    1 +
 exec-cmd.c                               |    2 +
 git-compat-util.h                        |    7 +
 git.c                                    |   65 ++
 pager.c                                  |    1 +
 read-cache.c                             |   51 +-
 remote-curl.c                            |    7 +
 repository.c                             |    2 +
 repository.h                             |    3 +
 run-command.c                            |   59 +-
 run-command.h                            |   13 +-
 sequencer.c                              |    2 +
 sh-i18n--envsubst.c                      |    3 +
 sub-process.c                            |    1 +
 submodule.c                              |   11 +-
 t/helper/test-parse-options.c            |    3 +
 t/helper/test-tool.c                     |    4 +
 t/helper/test-tool.h                     |    1 +
 t/helper/test-trace2.c                   |  273 +++++
 t/t0001-init.sh                          |    1 +
 t/t0210-trace2-normal.sh                 |  135 +++
 t/t0210/scrub_normal.perl                |   48 +
 t/t0211-trace2-perf.sh                   |  153 +++
 t/t0211/scrub_perf.perl                  |   76 ++
 t/t0212-trace2-event.sh                  |  236 ++++
 t/t0212/parse_events.perl                |  251 ++++
 trace2.c                                 |  761 ++++++++++++
 trace2.h                                 |  385 ++++++
 trace2/tr2_cfg.c                         |   90 ++
 trace2/tr2_cfg.h                         |   19 +
 trace2/tr2_cmd_name.c                    |   30 +
 trace2/tr2_cmd_name.h                    |   24 +
 trace2/tr2_dst.c                         |  252 ++++
 trace2/tr2_dst.h                         |   36 +
 trace2/tr2_sid.c                         |   67 ++
 trace2/tr2_sid.h                         |   18 +
 trace2/tr2_tbuf.c                        |   32 +
 trace2/tr2_tbuf.h                        |   23 +
 trace2/tr2_tgt.h                         |  133 +++
 trace2/tr2_tgt_event.c                   |  588 ++++++++++
 trace2/tr2_tgt_normal.c                  |  323 ++++++
 trace2/tr2_tgt_perf.c                    |  534 +++++++++
 trace2/tr2_tls.c                         |  164 +++
 trace2/tr2_tls.h                         |   97 ++
 transport-helper.c                       |    2 +
 transport.c                              |    1 +
 usage.c                                  |   31 +
 wt-status.c                              |   24 +-
 67 files changed, 6630 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/technical/api-trace2.txt
 create mode 100644 compat/win32/trace2_win32_process_info.c
 create mode 100644 t/helper/test-trace2.c
 create mode 100755 t/t0210-trace2-normal.sh
 create mode 100644 t/t0210/scrub_normal.perl
 create mode 100755 t/t0211-trace2-perf.sh
 create mode 100644 t/t0211/scrub_perf.perl
 create mode 100755 t/t0212-trace2-event.sh
 create mode 100644 t/t0212/parse_events.perl
 create mode 100644 trace2.c
 create mode 100644 trace2.h
 create mode 100644 trace2/tr2_cfg.c
 create mode 100644 trace2/tr2_cfg.h
 create mode 100644 trace2/tr2_cmd_name.c
 create mode 100644 trace2/tr2_cmd_name.h
 create mode 100644 trace2/tr2_dst.c
 create mode 100644 trace2/tr2_dst.h
 create mode 100644 trace2/tr2_sid.c
 create mode 100644 trace2/tr2_sid.h
 create mode 100644 trace2/tr2_tbuf.c
 create mode 100644 trace2/tr2_tbuf.h
 create mode 100644 trace2/tr2_tgt.h
 create mode 100644 trace2/tr2_tgt_event.c
 create mode 100644 trace2/tr2_tgt_normal.c
 create mode 100644 trace2/tr2_tgt_perf.c
 create mode 100644 trace2/tr2_tls.c
 create mode 100644 trace2/tr2_tls.h


base-commit: b5101f929789889c2e536d915698f58d5c5c6b7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/108

Range-diff vs v6:

  1:  4c006f4995 !  1:  8ac6acf88d trace2: Documentation/technical/api-trace2.txt
     @@ -122,10 +122,13 @@
      +
      +	Enables the target, opens and writes to the file in append mode.
      +
     -+`af_unix:<absolute-pathname>`::
     ++`af_unix:[<socket_type>:]<absolute-pathname>`::
      +
      +	Enables the target, opens and writes to a Unix Domain Socket
      +	(on platforms that support them).
     +++
     ++Socket type can be either `stream` or `dgram`.  If the socket type is
     ++omitted, Git will try both.
      +
      +== Trace2 API
      +
  2:  6bad326bbd !  2:  90e4e6af93 trace2: create new combined trace facility
     @@ -947,8 +947,7 @@
      +
      +	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_command_name_fl)
     -+			tgt_j->pfn_command_name_fl(file, line, name,
     -+						   hierarchy);
     ++			tgt_j->pfn_command_name_fl(file, line, name, hierarchy);
      +}
      +
      +void trace2_cmd_mode_fl(const char *file, int line, const char *mode)
     @@ -2080,37 +2079,103 @@
      +
      +#ifndef NO_UNIX_SOCKETS
      +#define PREFIX_AF_UNIX "af_unix:"
     -+#define PREFIX_AF_UNIX_LEN (8)
     ++#define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
     ++#define PREFIX_AF_UNIX_DGRAM "af_unix:dgram:"
     ++
     ++static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
     ++{
     ++	int fd;
     ++	struct sockaddr_un sa;
     ++
     ++	fd = socket(AF_UNIX, sock_type, 0);
     ++	if (fd == -1)
     ++		return errno;
     ++
     ++	sa.sun_family = AF_UNIX;
     ++	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
     ++
     ++	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
     ++		int e = errno;
     ++		close(fd);
     ++		return e;
     ++	}
     ++
     ++	*out_fd = fd;
     ++	return 0;
     ++}
     ++
     ++#define TR2_DST_UDS_TRY_STREAM (1 << 0)
     ++#define TR2_DST_UDS_TRY_DGRAM  (1 << 1)
      +
      +static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
      +					  const char *tgt_value)
      +{
     ++	unsigned int uds_try = 0;
      +	int fd;
     -+	struct sockaddr_un sa;
     -+	const char *path = tgt_value + PREFIX_AF_UNIX_LEN;
     -+	int path_len = strlen(path);
     ++	int e;
     ++	const char *path = NULL;
     ++
     ++	/*
     ++	 * Allow "af_unix:[<type>:]<absolute_path>"
     ++	 *
     ++	 * Trace2 always writes complete individual messages (without
     ++	 * chunking), so we can talk to either DGRAM or STREAM type sockets.
     ++	 *
     ++	 * Allow the user to explicitly request the socket type.
     ++	 *
     ++	 * If they omit the socket type, try one and then the other.
     ++	 */
      +
     -+	if (!is_absolute_path(path) || path_len >= sizeof(sa.sun_path)) {
     ++	if (skip_prefix(tgt_value, PREFIX_AF_UNIX_STREAM, &path))
     ++		uds_try |= TR2_DST_UDS_TRY_STREAM;
     ++
     ++	else if (skip_prefix(tgt_value, PREFIX_AF_UNIX_DGRAM, &path))
     ++		uds_try |= TR2_DST_UDS_TRY_DGRAM;
     ++
     ++	else if (skip_prefix(tgt_value, PREFIX_AF_UNIX, &path))
     ++		uds_try |= TR2_DST_UDS_TRY_STREAM | TR2_DST_UDS_TRY_DGRAM;
     ++
     ++	if (!path || !*path) {
      +		if (tr2_dst_want_warning())
     -+			warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
     -+				path, dst->env_var_name);
     ++			warning("trace2: invalid AF_UNIX value '%s' for '%s' tracing",
     ++				tgt_value, dst->env_var_name);
      +
      +		tr2_dst_trace_disable(dst);
      +		return 0;
      +	}
      +
     -+	sa.sun_family = AF_UNIX;
     -+	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
     -+	if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1 ||
     -+	    connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
     ++	if (!is_absolute_path(path) ||
     ++	    strlen(path) >= sizeof(((struct sockaddr_un *)0)->sun_path)) {
      +		if (tr2_dst_want_warning())
     -+			warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
     -+				path, dst->env_var_name, strerror(errno));
     ++			warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
     ++				path, dst->env_var_name);
      +
      +		tr2_dst_trace_disable(dst);
      +		return 0;
      +	}
      +
     ++	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
     ++		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
     ++		if (!e)
     ++			goto connected;
     ++		if (e != EPROTOTYPE)
     ++			goto error;
     ++	}
     ++	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
     ++		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
     ++		if (!e)
     ++			goto connected;
     ++	}
     ++
     ++error:
     ++	if (tr2_dst_want_warning())
     ++		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
     ++			path, dst->env_var_name, strerror(e));
     ++
     ++	tr2_dst_trace_disable(dst);
     ++	return 0;
     ++
     ++connected:
      +	dst->fd = fd;
      +	dst->need_close = 1;
      +	dst->initialized = 1;
     @@ -2124,19 +2189,8 @@
      +{
      +	struct strbuf buf = STRBUF_INIT;
      +
     -+	strbuf_addf(&buf, "trace2: unknown trace value for '%s': '%s'",
     ++	strbuf_addf(&buf, "trace2: unknown value for '%s': '%s'",
      +		    dst->env_var_name, tgt_value);
     -+	strbuf_addstr(
     -+		&buf,
     -+		"\n         If you want to trace into a file, then please set it"
     -+		"\n         to an absolute pathname.");
     -+#ifndef NO_UNIX_SOCKETS
     -+	strbuf_addstr(
     -+		&buf,
     -+		"\n         If you want to trace to a unix domain socket, prefix"
     -+		"\n         the absolute pathname with \"af_unix:\".");
     -+#endif
     -+
      +	warning("%s", buf.buf);
      +
      +	strbuf_release(&buf);
     @@ -2174,7 +2228,7 @@
      +		return tr2_dst_try_path(dst, tgt_value);
      +
      +#ifndef NO_UNIX_SOCKETS
     -+	if (!strncmp(tgt_value, PREFIX_AF_UNIX, PREFIX_AF_UNIX_LEN))
     ++	if (starts_with(tgt_value, PREFIX_AF_UNIX))
      +		return tr2_dst_try_unix_domain_socket(dst, tgt_value);
      +#endif
      +
     @@ -2817,8 +2871,7 @@
      +	jw_release(&jw);
      +}
      +
     -+static void fn_command_name_fl(const char *file, int line,
     -+			       const char *name,
     ++static void fn_command_name_fl(const char *file, int line, const char *name,
      +			       const char *hierarchy)
      +{
      +	const char *event_name = "cmd_name";
     @@ -3327,8 +3380,7 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_name_fl(const char *file, int line,
     -+			       const char *name,
     ++static void fn_command_name_fl(const char *file, int line, const char *name,
      +			       const char *hierarchy)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
     @@ -3747,8 +3799,7 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_name_fl(const char *file, int line,
     -+			       const char *name,
     ++static void fn_command_name_fl(const char *file, int line, const char *name,
      +			       const char *hierarchy)
      +{
      +	const char *event_name = "cmd_name";
  3:  12de7e42de !  3:  50f689dc95 trace2: collect Windows-specific process information
     @@ -35,6 +35,12 @@
      +#include <tlHelp32.h>
      +
      +/*
     ++ * An arbitrarily chosen value to limit the size of the ancestor
     ++ * array built in git_processes().
     ++ */
     ++#define NR_PIDS_LIMIT 10
     ++
     ++/*
      + * Find the process data for the given PID in the given snapshot
      + * and update the PROCESSENTRY32 data.
      + */
     @@ -52,7 +58,7 @@
      +}
      +
      +/*
     -+ * Accumulate JSON array:
     ++ * Accumulate JSON array of our parent processes:
      + *     [
      + *         exe-name-parent,
      + *         exe-name-grand-parent,
     @@ -64,21 +70,61 @@
      + *       and GetModuleFileNameEx() or QueryfullProcessImageName()
      + *       and that seems rather expensive (on top of the cost of
      + *       getting the snapshot).
     ++ *
     ++ * Note: we compute the set of parent processes by walking the PPID
     ++ *       link in each visited PROCESSENTRY32 record.  This search
     ++ *       stops when an ancestor process is not found in the snapshot
     ++ *       (because it exited before the current or intermediate parent
     ++ *       process exited).
     ++ *
     ++ *       This search may compute an incorrect result if the PPID link
     ++ *       refers to the PID of an exited parent and that PID has been
     ++ *       recycled and given to a new unrelated process.
     ++ *
     ++ *       Worse, it is possible for a child or descendant of the
     ++ *       current process to be given the recycled PID and cause a
     ++ *       PPID-cycle.  This would cause an infinite loop building our
     ++ *       parent process array.
     ++ *
     ++ * Note: for completeness, the "System Idle" process has PID=0 and
     ++ *       PPID=0 and could cause another PPID-cycle.  We don't expect
     ++ *       Git to be a descendant of the idle process, but because of
     ++ *       PID recycling, it might be possible to get a PPID link value
     ++ *       of 0.  This too would cause an infinite loop.
     ++ *
     ++ * Therefore, we keep an array of the visited PPIDs to guard against
     ++ * cycles.
     ++ *
     ++ * We use a fixed-size array rather than ALLOC_GROW to keep things
     ++ * simple and avoid the alloc/realloc overhead.  It is OK if we
     ++ * truncate the search and return a partial answer.
      + */
      +static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
      +{
      +	PROCESSENTRY32 pe32;
      +	DWORD pid;
     ++	DWORD pid_list[NR_PIDS_LIMIT];
     ++	int k, nr_pids = 0;
      +
      +	pid = GetCurrentProcessId();
     -+
     -+	/* We only want parent processes, so skip self. */
     -+	if (!find_pid(pid, hSnapshot, &pe32))
     -+		return;
     -+	pid = pe32.th32ParentProcessID;
     -+
      +	while (find_pid(pid, hSnapshot, &pe32)) {
     -+		jw_array_string(jw, pe32.szExeFile);
     ++		/* Only report parents. Omit self from the JSON output. */
     ++		if (nr_pids)
     ++			jw_array_string(jw, pe32.szExeFile);
     ++
     ++		/* Check for cycle in snapshot. (Yes, it happened.) */
     ++		for (k = 0; k < nr_pids; k++)
     ++			if (pid == pid_list[k]) {
     ++				jw_array_string(jw, "(cycle)");
     ++				return;
     ++			}
     ++
     ++		if (nr_pids == NR_PIDS_LIMIT) {
     ++			jw_array_string(jw, "(truncated)");
     ++			return;
     ++		}
     ++
     ++		pid_list[nr_pids++] = pid;
      +
      +		pid = pe32.th32ParentProcessID;
      +	}
  4:  5835edbd01 =  4:  40411100c3 trace2:data: add trace2 regions to wt-status
  5:  99d13ef478 =  5:  18ff59d6fe trace2:data: add editor/pager child classification
  6:  d7ce85b702 =  6:  ec7d7cd4c7 trace2:data: add trace2 sub-process classification
  7:  b70c289903 =  7:  485a4f2a68 trace2:data: add trace2 transport child classification
  8:  2a0da88579 =  8:  18659d61da trace2:data: add trace2 hook classification
  9:  bca6a7f0d6 =  9:  08be5aadbe trace2:data: add trace2 instrumentation to index read/write
 10:  68269ee060 = 10:  4e679241fc trace2:data: pack-objects: add trace2 regions
 11:  0191283fff = 11:  2a5aa3a8dc trace2:data: add subverb to checkout command
 12:  24d8d8d768 = 12:  ebaa9b1d80 trace2:data: add subverb to reset command
 13:  90cec071cf = 13:  3e6fee40b0 trace2:data: add subverb for rebase
 14:  b9f0c6fd66 ! 14:  398edb7738 trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
     @@ -767,6 +767,8 @@
      +test_description='test trace2 facility'
      +. ./test-lib.sh
      +
     ++perl -MJSON::PP -e 0 >/dev/null 2>&1 && test_set_prereq JSON_PP
     ++
      +# Add t/helper directory to PATH so that we can use a relative
      +# path to run nested instances of test-tool.exe (see 004child).
      +# This helps with HEREDOC comparisons later.
     @@ -802,7 +804,7 @@
      +#
      +# To the above, add multiple 'error <msg>' events
      +
     -+test_expect_success 'event stream, error event' '
     ++test_expect_success JSON_PP 'event stream, error event' '
      +	test_when_finished "rm trace.event actual expect" &&
      +	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 003error "hello world" "this is a test" &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
     @@ -839,7 +841,7 @@
      +#    P2: |--- TT trace2 004child
      +#    P3:      |--- TT trace2 001return 0
      +
     -+test_expect_success 'event stream, return code 0' '
     ++test_expect_success JSON_PP 'event stream, return code 0' '
      +	test_when_finished "rm trace.event actual expect" &&
      +	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
     @@ -926,7 +928,7 @@
      +
      +# Test listing of all "interesting" config settings.
      +
     -+test_expect_success 'event stream, list config' '
     ++test_expect_success JSON_PP 'event stream, list config' '
      +	test_when_finished "rm trace.event actual expect" &&
      +	git config --local t0212.abc 1 &&
      +	git config --local t0212.def "hello world" &&
     @@ -961,7 +963,7 @@
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'basic trace2_data' '
     ++test_expect_success JSON_PP 'basic trace2_data' '
      +	test_when_finished "rm trace.event actual expect" &&
      +	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 006data test_category k1 v1 test_category k2 v2 &&
      +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
 15:  93a25d09a1 = 15:  662201f49e trace2: add for_each macros to clang-format

-- 
gitgitgadget
