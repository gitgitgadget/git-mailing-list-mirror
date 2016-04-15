From: Duy Nguyen <pclouds@gmail.com>
Subject: Parallel checkout (Was Re: 0 bot for Git)
Date: Fri, 15 Apr 2016 16:51:40 +0700
Message-ID: <20160415095139.GA3985@lanh>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
 <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
 <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 11:51:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar0Pf-0006s7-5O
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 11:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbcDOJvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 05:51:38 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33674 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcDOJve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 05:51:34 -0400
Received: by mail-pa0-f47.google.com with SMTP id zm5so54030948pac.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 02:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GVwxMQKV+PzqWMdcbliK1a0oUXsef57XCwtf4b6qNJ8=;
        b=EOcdGETyInOWelooG0hND2n02jEL+GiAEb3pBJmSTbziOeiG3ZWBiONvngVnJDqDhi
         /5rOsmYzYom49trETfhC4IUdpMf5WNr5yoJddBnPYLc9m4YSicR8Npv/0mqsMobkRuJV
         tE8A0wLFzMA80AHorrJa5bM+yAoCg1O300I+wzbCTJtQrdi5RWPstixDt0kSZ9zlIrHS
         wOl4yyuLZ+m1yG7hcGQnBdfJu4yFUm3W18FFiphTpSb/4c4DEPomNVxAjRUfhHq70oXi
         23kIFKwMXjdBjl+qAE2pNfuRCtdB5Xb5RZ5JwLH8u8tpj0Ui/3s1eUUWieVItP90lZl2
         1RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GVwxMQKV+PzqWMdcbliK1a0oUXsef57XCwtf4b6qNJ8=;
        b=h2h+ud9H7nsQTJF2ZxUT0M11cO6kZ9Up+ugwfPARBJTrhnztwq/0ZmoOyylMDLyew4
         iK/TeJhYuTGiOTpq8ej7Erv7eHGrmrBFhcKYDb08F+1DZnVdLksLkIPPj/nxpBt4MAno
         L0DOEjEK1Khoj/tCw/We9LySQaRPpzUF9gJnkqN01lrTNuyPJgz5GgrxF9yBRiJ6ddnY
         sc0aHfZilent6GBATzYSQkydRfVieKw0xRdMOaDEmFqIjU3M6bloug9FG+boTtniB1Ub
         ABKeVreT78U1gOUcXxtmVkef1O596knAPx2jTo5YHRwaR6wQm/3sMHAzmd4N9BpFfRws
         V0nQ==
X-Gm-Message-State: AOPr4FXu36YuGX0T/Lq204tbMgZvEUNT35p+AlIk2dOYBQvMAMOmwpT/O+P2OBtza/kczQ==
X-Received: by 10.66.232.4 with SMTP id tk4mr28328335pac.103.1460713893106;
        Fri, 15 Apr 2016 02:51:33 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id rw2sm63653884pab.30.2016.04.15.02.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2016 02:51:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 15 Apr 2016 16:51:40 +0700
Content-Disposition: inline
In-Reply-To: <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291600>

On Fri, Apr 15, 2016 at 12:04:49AM +0200, Christian Couder wrote:
> On Tue, Apr 12, 2016 at 4:59 PM, Stefan Beller <sbeller@google.com> wrote:
> > On Tue, Apr 12, 2016 at 2:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> >>> On Mon, Apr 11, 2016 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
> >>>> Hi Greg,
> >>>>
> >>>> Thanks for your talk at the Git Merge 2016!
> >>
> >> Huh? It already happened?? Any interesting summary to share with us?
> 
> There is a draft of an article about the first part of the Contributor
> Summit in the draft of the next Git Rev News edition:
> 
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md

Thanks. I read the sentence "This made people mention potential
problems with parallelizing git checkout" and wondered what these
problems were. And because it's easier to think while you test
something, to flesh out your thoughts, I wrote the below patch, which
does parallel checkout with multiple worker processes. I wonder if the
same set of problems apply to it.

The idea is simple, you offload some work to process workers. In this
patch, only entry.c:write_entry() is moved to workers. We still do
directory creation and all sort of checks and stat refresh in the main
process. Some more work may be moved away, for example, the entire
builtin/checkout.c:checkout_merged().

Multi process is less efficient than multi thread model. But I doubt
we could make object db access thread-safe soon. The last discussion
was 2 years ago [1] and nothing much has happened.

Numbers are encouraging though. On linux-2.6 repo running on linux and
ext4 filesystem, checkout_paths() would dominate "git checkout :/".
Unmodified git takes about 31s.


16:26:00.114029 builtin/checkout.c:1299 performance: 31.184973659 s: checkout_paths
16:26:00.114225 trace.c:420             performance: 31.256412935 s: git command: 'git' 'checkout' '.'

When doing write_entry() on 8 processes, it takes 22s (shortened by ~30%)

16:27:39.973730 trace.c:420             performance: 5.610255442 s: git command: 'git' 'checkout-index' '--worker'
16:27:40.956812 trace.c:420             performance: 6.595082013 s: git command: 'git' 'checkout-index' '--worker'
16:27:41.397621 trace.c:420             performance: 7.032024175 s: git command: 'git' 'checkout-index' '--worker'
16:27:47.453999 trace.c:420             performance: 13.078537207 s: git command: 'git' 'checkout-index' '--worker'
16:27:48.986433 trace.c:420             performance: 14.612951643 s: git command: 'git' 'checkout-index' '--worker'
16:27:53.149378 trace.c:420             performance: 18.781762536 s: git command: 'git' 'checkout-index' '--worker'
16:27:54.884044 trace.c:420             performance: 20.514473730 s: git command: 'git' 'checkout-index' '--worker'
16:27:55.319990 trace.c:420             performance: 20.948326263 s: git command: 'git' 'checkout-index' '--worker'
16:27:55.863211 builtin/checkout.c:1299 performance: 22.723118420 s: checkout_paths
16:27:55.863398 trace.c:420             performance: 22.854547640 s: git command: 'git' 'checkout' '--parallel' '.'

I suspect on nfs or windows, the gain may be higher due to IO blocking
the main process more.

Note that this for-fun patch is not optmized at all (and definitely
not portable). I could have sent a group of paths to the worker in a
single system call instead of one per call. The trace above also shows
unbalance issues with workers, where some workers exit early because
of my naive work distribution. Numbers could get a bit better.

[1] http://thread.gmane.org/gmane.comp.version-control.git/241965/focus=242020

-- 8< --
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 92c6967..7163216 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "cache-tree.h"
 #include "parse-options.h"
+#include "entry.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
@@ -179,6 +180,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (argc == 2 && !strcmp(argv[1], "--worker"))
+		return parallel_checkout_worker();
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_checkout_index_usage,
 				   builtin_checkout_index_options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index efcbd8f..51caad2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -20,6 +20,7 @@
 #include "resolve-undo.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "entry.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -236,7 +237,8 @@ static int checkout_merged(int pos, struct checkout *state)
 }
 
 static int checkout_paths(const struct checkout_opts *opts,
-			  const char *revision)
+			  const char *revision,
+			  int parallel)
 {
 	int pos;
 	struct checkout state;
@@ -357,6 +359,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	state.force = 1;
 	state.refresh_cache = 1;
 	state.istate = &the_index;
+	if (parallel)
+		start_parallel_checkout(&state);
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -367,11 +371,18 @@ static int checkout_paths(const struct checkout_opts *opts,
 			if (opts->writeout_stage)
 				errs |= checkout_stage(opts->writeout_stage, ce, pos, &state);
 			else if (opts->merge)
+				/*
+				 * XXX: in parallel mode, we may want
+				 * to let worker perform the merging
+				 * instead and send SHA-1 result back
+				 */
 				errs |= checkout_merged(pos, &state);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
 
+	errs |= run_parallel_checkout();
+
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
@@ -1132,6 +1143,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct branch_info new;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
+	int parallel = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -1159,6 +1171,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
+		OPT_BOOL(0, "parallel", &parallel,
+			 N_("parallel checkout")),
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
@@ -1279,8 +1293,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
-	if (opts.patch_mode || opts.pathspec.nr)
-		return checkout_paths(&opts, new.name);
+	if (opts.patch_mode || opts.pathspec.nr) {
+		uint64_t start = getnanotime();
+		int ret = checkout_paths(&opts, new.name, parallel);
+		trace_performance_since(start, "checkout_paths");
+		return ret;
+	}
 	else
 		return checkout_branch(&opts, &new);
 }
diff --git a/entry.c b/entry.c
index a410957..5e0eb1c 100644
--- a/entry.c
+++ b/entry.c
@@ -3,6 +3,36 @@
 #include "dir.h"
 #include "streaming.h"
 
+#include <sys/epoll.h>
+#include "pkt-line.h"
+#include "argv-array.h"
+#include "run-command.h"
+
+struct checkout_item {
+	struct cache_entry *ce;
+	struct checkout_item *next;
+};
+
+struct checkout_worker {
+	struct child_process cp;
+	struct checkout_item *to_complete;
+	struct checkout_item *to_send;
+};
+
+struct parallel_checkout {
+	struct checkout state;
+	struct checkout_worker *workers;
+	struct checkout_item *items;
+	int nr_items, alloc_items;
+	int nr_workers;
+};
+
+static struct parallel_checkout *parallel_checkout;
+
+static int queue_checkout(struct parallel_checkout *,
+			  const struct checkout *,
+			  struct cache_entry *);
+
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
 {
@@ -290,5 +320,299 @@ int checkout_entry(struct cache_entry *ce,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
+
+	if (!queue_checkout(parallel_checkout, state, ce))
+		/*
+		 * write_entry() will be done by parallel_checkout_worker() in
+		 * a separate process
+		 */
+		return 0;
+
 	return write_entry(ce, path.buf, state, 0);
 }
+
+int start_parallel_checkout(const struct checkout *state)
+{
+	if (parallel_checkout)
+		die("BUG: parallel checkout already initiated");
+	if (0 && state->force)
+		die("BUG: not support --force yet");
+	parallel_checkout = xmalloc(sizeof(*parallel_checkout));
+	memset(parallel_checkout, 0, sizeof(*parallel_checkout));
+	memcpy(&parallel_checkout->state, state, sizeof(*state));
+
+	return 0;
+}
+
+static int queue_checkout(struct parallel_checkout *pc,
+			  const struct checkout *state,
+			  struct cache_entry *ce)
+{
+	struct checkout_item *ci;
+
+	if (!pc ||
+	    !S_ISREG(ce->ce_mode) ||
+	    memcmp(&pc->state, state, sizeof(*state)))
+		return -1;
+
+	ALLOC_GROW(pc->items, pc->nr_items + 1, pc->alloc_items);
+	ci = pc->items + pc->nr_items++;
+	ci->ce = ce;
+	return 0;
+}
+
+static int item_cmp(const void *a_, const void *b_)
+{
+	const struct checkout_item *a = a_;
+	const struct checkout_item *b = b_;
+	return strcmp(a->ce->name, b->ce->name);
+}
+
+static int setup_workers(struct parallel_checkout *pc, int epoll_fd)
+{
+	int from, nr_per_worker, i;
+
+	pc->workers = xmalloc(sizeof(*pc->workers) * pc->nr_workers);
+	memset(pc->workers, 0, sizeof(*pc->workers) * pc->nr_workers);
+
+	nr_per_worker = pc->nr_items / pc->nr_workers;
+	from = 0;
+
+	for (i = 0; i < pc->nr_workers; i++) {
+		struct checkout_worker *worker = pc->workers + i;
+		struct child_process *cp = &worker->cp;
+		struct checkout_item *item;
+		struct epoll_event ev;
+		int to;
+
+		to = from + nr_per_worker;
+		if (i == pc->nr_workers - 1)
+			to = pc->nr_items;
+		item = NULL;
+		while (from < to) {
+			pc->items[from].next = item;
+			item = pc->items + from;
+			from++;
+		}
+		worker->to_send = item;
+		worker->to_complete = item;
+
+		cp->git_cmd = 1;
+		cp->in = -1;
+		cp->out = -1;
+		argv_array_push(&cp->args, "checkout-index");
+		argv_array_push(&cp->args, "--worker");
+		if (start_command(cp))
+			die(_("failed to run checkout worker"));
+
+		ev.events = EPOLLOUT | EPOLLERR | EPOLLHUP;
+		ev.data.u32 = i * 2;
+		if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, cp->in, &ev) == -1)
+			die_errno("epoll_ctl");
+
+		ev.events = EPOLLIN | EPOLLERR | EPOLLHUP;
+		ev.data.u32 = i * 2 + 1;
+		if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, cp->out, &ev) == -1)
+			die_errno("epoll_ctl");
+	}
+	return 0;
+}
+
+static int send_to_worker(struct checkout_worker *worker, int epoll_fd)
+{
+	if (!worker->to_send) {
+		struct epoll_event ev;
+
+		packet_flush(worker->cp.in);
+
+		epoll_ctl(epoll_fd, EPOLL_CTL_DEL, worker->cp.in, &ev);
+		close(worker->cp.in);
+		worker->cp.in = -1;
+		return 0;
+	}
+
+	/*
+	 * XXX: put the fd in non-blocking mode and send as many files
+	 * as possible in one go.
+	 */
+	packet_write(worker->cp.in, "%s %s",
+		     sha1_to_hex(worker->to_send->ce->sha1),
+		     worker->to_send->ce->name);
+	worker->to_send = worker->to_send->next;
+	return 0;
+}
+
+int parallel_checkout_worker(void)
+{
+	struct checkout state;
+	struct cache_entry *ce = NULL;
+
+	memset(&state, 0, sizeof(state));
+	/* FIXME: pass 'force' over */
+	for (;;) {
+		int len;
+		unsigned char sha1[20];
+		char *line = packet_read_line(0, &len);
+
+		if (!line)
+			return 0;
+
+		if (len < 40)
+			return 1;
+		if (get_sha1_hex(line, sha1))
+			return 1;
+		line += 40;
+		len -= 40;
+		if (*line != ' ')
+			return 1;
+		line++;
+		len--;
+		if (!ce || ce_namelen(ce) < len) {
+			free(ce);
+			ce = xcalloc(1, cache_entry_size(len));
+			ce->ce_mode = S_IFREG | ce_permissions(0644);
+		}
+		ce->ce_namelen = len;
+		hashcpy(ce->sha1, sha1);
+		memcpy(ce->name, line, len + 1);
+
+		if (write_entry(ce, ce->name, &state, 0))
+			return 1;
+		/*
+		 * XXX process in batch and send bigger number of
+		 * checked out entries back
+		 */
+		packet_write(1, "1");
+	}
+}
+
+static int receive_from_worker(struct checkout_worker *worker,
+			       int refresh_cache)
+{
+	int len, val;
+	char *line;
+
+	line = packet_read_line(worker->cp.out, &len);
+	val = atoi(line);
+	if (val <= 0)
+		die("BUG: invalid value");
+	while (val && worker->to_complete &&
+	       worker->to_complete != worker->to_send) {
+		if (refresh_cache) {
+			struct stat st;
+			struct cache_entry *ce = worker->to_complete->ce;
+
+			lstat(ce->name, &st);
+			fill_stat_cache_info(ce, &st);
+			ce->ce_flags |= CE_UPDATE_IN_BASE;
+		}
+		worker->to_complete = worker->to_complete->next;
+		val--;
+	}
+	if (val)
+		die("BUG: invalid value");
+	return 0;
+}
+
+static int finish_worker(struct checkout_worker *worker, int epoll_fd)
+{
+	struct epoll_event ev;
+	char buf[1];
+	int ret;
+
+	assert(worker->to_send == NULL);
+	assert(worker->to_complete == NULL);
+
+	ret = xread(worker->cp.out, buf, sizeof(buf));
+	if (ret != 0)
+		die("BUG: expect eof");
+	epoll_ctl(epoll_fd, EPOLL_CTL_DEL, worker->cp.out, &ev);
+	close(worker->cp.out);
+	worker->cp.out = -1;
+	if (finish_command(&worker->cp))
+		die("worker had a problem");
+	return 0;
+}
+
+static int really_finished(struct parallel_checkout *pc)
+{
+	int i;
+
+	for (i = 0; i < pc->nr_workers; i++)
+		if (pc->workers[i].to_complete)
+			return 0;
+	return 1;
+}
+
+/* XXX progress support for unpack-trees */
+int run_parallel_checkout(void)
+{
+	struct parallel_checkout *pc = parallel_checkout;
+	int ret, i;
+	int epoll_fd;
+	struct epoll_event *events;
+
+	if (!pc || !pc->nr_items) {
+		free(pc);
+		parallel_checkout = NULL;
+		return 0;
+	}
+
+	qsort(pc->items, pc->nr_items, sizeof(*pc->items), item_cmp);
+	pc->nr_workers = 8;
+	epoll_fd = epoll_create(pc->nr_workers * 2);
+	if (epoll_fd == -1)
+		die_errno("epoll_create");
+	ret = setup_workers(pc, epoll_fd);
+	events = xmalloc(sizeof(*events) * pc->nr_workers * 2);
+
+	ret = 0;
+	while (!ret) {
+		int maybe_all_done = 0, nr;
+
+		nr = epoll_wait(epoll_fd, events, pc->nr_workers * 2, -1);
+		if (nr == -1 && errno == EINTR)
+			continue;
+		if (nr == -1) {
+			ret = nr;
+			break;
+		}
+		for (i = 0; i < nr; i++) {
+			int is_in = events[i].data.u32 & 1;
+			int worker_id = events[i].data.u32 / 2;
+			struct checkout_worker *worker = pc->workers + worker_id;
+
+			if (!is_in && (events[i].events & EPOLLOUT))
+				ret = send_to_worker(worker, epoll_fd);
+			else if (events[i].events & EPOLLIN) {
+				if (worker->to_complete) {
+					int refresh = pc->state.refresh_cache;
+					ret = receive_from_worker(worker, refresh);
+					pc->state.istate->cache_changed |= CE_ENTRY_CHANGED;
+				} else {
+					ret = finish_worker(worker, epoll_fd);
+					maybe_all_done = 1;
+				}
+			} else if (events[i].events & (EPOLLERR | EPOLLHUP)) {
+				if (is_in && !worker->to_complete) {
+					ret = finish_worker(worker, epoll_fd);
+					maybe_all_done = 1;
+				} else
+					ret = -1;
+			} else
+				die("BUG: what??");
+			if (ret)
+				break;
+		}
+
+		if (maybe_all_done && really_finished(pc))
+			break;
+	}
+
+	close(epoll_fd);
+	free(pc->workers);
+	free(events);
+	free(pc);
+	parallel_checkout = NULL;
+	return ret;
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 9f55cc2..433c54e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -220,6 +220,7 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_marked_cache_entries(&o->result);
 	remove_scheduled_dirs();
 
+	/* start_parallel_checkout() */
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -234,6 +235,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 	}
+	/* run_parallel_checkout() */
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
-- 8< --
