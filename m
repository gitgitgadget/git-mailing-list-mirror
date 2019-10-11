Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82DDB1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 13:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJKNdO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 09:33:14 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:37049 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfJKNdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 09:33:14 -0400
Received: by mail-qk1-f178.google.com with SMTP id u184so8880989qkd.4
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sXfWk7TNiSRIoS0TG3zQrzAhPhWKpQQ49Gy0Za0Nov0=;
        b=ZA3zwvCVE/SC1RkO2Nsowu5dfZ866Xt+qfLQ9MwJXAXcQgkHPES6x1Kazr0sRRjvas
         DAy2//DVaEjvjabiMA0QONvRb+KzahEGYa95rcv7ZWSmis9Tlx7Dvl4DkdMk30hFC82E
         PFaTUKqXW7JOm7r8MrwBM7B6KHfNfc5/XgQzfekIDbxAYvePmNGDVtHIPT8sOd4Azwf3
         6WCDQDYu5QhOQXXH21P9LMXj+9QglVj2DZSDAgGX7F/QL80ir5IKsmtukqOioONmlgNk
         t52TRhGILjnRTdvQh2GO3nx1FtT0ws15uuJnfdg5qm0qk0cMrrQGvJqPAUNI97/Km2nD
         5Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sXfWk7TNiSRIoS0TG3zQrzAhPhWKpQQ49Gy0Za0Nov0=;
        b=Z8JG6+ZmBDUmL8Jg+rq2ll7hPX6nQs/BmoZ1TnPmdlY7NmmXyfBEaYenRQvAT+4GFu
         yfOZr3u1cT0oXo2KVXtPJ3M/F+05P+4FBq8wE9S59MHCxXBi0m64CbtIfP3b3DWay8Ho
         8uimmwxztVpGeCvTOnbhZqnqUJSExF631vacLx6RYjy0wi7LAk7drbBmSelFsQWsy857
         i249XWY35g6+t5l8Dkx3lPyTkG0wufxbopITdmG8XqscrQ22ns+bTCO/THW1ds5MKu4g
         qxvNnHfWNYr9ahfaCMv7aX0vL2z/Wt8AxExqVIEAjabWDkf3W+gFCwPEU+UUaOlhhbfL
         g+ZA==
X-Gm-Message-State: APjAAAWfePU7mo4pM+GYGFOscpUOLUrAPvMdPQl/0gAHh2lnQrE/xPYJ
        Jf2UKywZ7NKlSrxYueZ5mLXt1ti/UO4=
X-Google-Smtp-Source: APXvYqx4H8ZkK3HPSTICGHyCBsVZ6FNChuKk7YoveAHGG6x5LBTw9x2eAT9c4yPaxcBxi3mKJFMzSg==
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr15681891qkf.434.1570800792317;
        Fri, 11 Oct 2019 06:33:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2da2:a6da:62ea:75d9? ([2001:4898:a800:1012:ded5:a6da:62ea:75d9])
        by smtp.gmail.com with ESMTPSA id o52sm5779350qtf.56.2019.10.11.06.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 06:33:11 -0700 (PDT)
To:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (October 11)
Message-ID: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
Date:   Fri, 11 Oct 2019 09:33:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report. The usual report format is
available online [1], [2]. The report listed below is a new format
that groups lines by the commit that introduced them [3]. Thanks
Peff for the feedback on that idea.

Note: the pu branch does not build due to interactions between
ds/sparse-cone and ew/hashmap, so no coverage is reported.

-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-10-11.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-10-11.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2019-10-11-commits.txt


pu	ef2d425e4a47a663fe2d4a09888b231d2e3b973e
jch	d1237310799dc8d0e6bb8d079c2803e120cac8cc
next	b869b98d4c7f0f91d905d76a6c8ba9b8799289b6
master	08da6496b61341ec45eac36afcc8f94242763468
master@{1}	4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducting uncovered code:


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducting uncovered code:
William Baker	070a4226 fsmonitor: don't fill bitmap with entries to be removed
fsmonitor.c
070a4226 20) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
070a4226 59) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
070a4226 87) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
070a4226 256) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducting uncovered code:
Elijah Newren	65c01c64 checkout: provide better conflict hunk description with detached HEAD
builtin/checkout.c
65c01c64 766) strbuf_add_unique_abbrev(&old_commit_shortname,
65c01c64 767)  &old_branch_info->commit->object.oid,
65c01c64 769) o.ancestor = old_commit_shortname.buf;

Elijah Newren	ff1bfa2c merge-recursive: use common name for ancestors/common/base_list
merge-recursive.c
ff1bfa2c 3757)    oid_to_hex(merge_bases[i]));

Elijah Newren	f836bf39 merge-recursive: future-proof update_file_flags() against memory leaks
merge-recursive.c
f836bf39 960) ret = err(opt, _("cannot read object %s '%s'"),
f836bf39 962) goto free_buf;

Elijah Newren	3164e6bd fast-import: fix handling of deleted tags
fast-import.c
3164e6bd 2835) first_tag = t->next_tag;

Elijah Newren	b8f50e5b fast-import: add support for new 'alias' command
fast-import.c
b8f50e5b 2528) die("Invalid ref name or SHA1 expression: %s", objectish);
b8f50e5b 2554) return 0;
b8f50e5b 3118) die(_("Expected 'mark' command, got %s"), command_buf.buf);
b8f50e5b 3123) die(_("Expected 'to' command, got %s"), command_buf.buf);

Elijah Newren	724dd767 cache-tree: share code between functions writing an index as a tree
cache-tree.c
724dd767 619) cache_tree_free(&index_state->cache_tree);
724dd767 620) cache_tree_valid = 0;
724dd767 633) return WRITE_TREE_PREFIX_ERROR;
724dd767 653) fprintf(stderr, "BUG: There are unmerged index entries:\n");
724dd767 654) for (i = 0; i < index_state->cache_nr; i++) {
724dd767 655) const struct cache_entry *ce = index_state->cache[i];
724dd767 656) if (ce_stage(ce))
724dd767 657) fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
724dd767 658) (int)ce_namelen(ce), ce->name);
724dd767 660) BUG("unmerged index entries when writing inmemory index");

Elijah Newren	98a1d3d8 merge-recursive: exit early if index != head
merge-recursive.c
98a1d3d8 3692) return -1;

Elijah Newren	9822175d Ensure index matches head before invoking merge machinery, round N
builtin/merge-recursive.c
9822175d 68) die_resolve_conflict("merge");

Elijah Newren	208d6924 fast-export: add support for --import-marks-if-exists
builtin/fast-export.c
208d6924 1220) die(_("Cannot pass both --import-marks and --import-marks-if-exists"));

Elijah Newren	941790d7 fast-export: handle nested tags
builtin/fast-export.c
941790d7 852) die(_("Error: Cannot export nested tags unless --mark-tags is specified."));
941790d7 864) tagged_mark = get_object_mark(tagged);

Eric Wong	28ee7941 hashmap_remove takes "const struct hashmap_entry *"
name-hash.c
28ee7941 100) hashmap_remove(&istate->dir_hash, &dir->ent, NULL);

Eric Wong	d22245a2 hashmap_entry_init takes "struct hashmap_entry *"
t/helper/test-hashmap.c
d22245a2 109) hashmap_entry_init(&entries[i]->ent, hashes[i]);
d22245a2 122) hashmap_entry_init(&entries[i]->ent, hashes[i]);

Eric Wong	b94e5c1d hashmap_add takes "struct hashmap_entry *"
t/helper/test-hashmap.c
b94e5c1d 110) hashmap_add(&map, &entries[i]->ent);
b94e5c1d 123) hashmap_add(&map, &entries[i]->ent);

Eric Wong	c8e424c9 hashmap: introduce hashmap_free_entries
t/helper/test-hashmap.c
c8e424c9 113) hashmap_free(&map);
c8e424c9 133) hashmap_free(&map);

Eric Wong	87571c3f hashmap: use *_entry APIs for iteration
t/helper/test-lazy-init-name-hash.c
87571c3f 44) hashmap_for_each_entry(&the_index.dir_hash, &iter_dir, dir,
87571c3f 48) hashmap_for_each_entry(&the_index.name_hash, &iter_cache, ce,

Jeff King	7c59828b pack-objects: improve partial packfile reuse
builtin/pack-objects.c
7c59828b 1136) return 1;
7c59828b 2694) (reuse_packfile_bitmap &&
7c59828b 2695)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

pack-bitmap.c
7c59828b 791) return; /* broken packfile, punt */
7c59828b 808) return;
7c59828b 811) return;
7c59828b 823) return;
7c59828b 861) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

Jeff King	934b7d0a pack-bitmap: introduce bitmap_walk_contains()
pack-bitmap.c
934b7d0a 903) return 0;

Jeff King	d35b73c5 pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
d35b73c5 2847) allow_pack_reuse = git_config_bool(k, v);
d35b73c5 2848) return 0;

Johannes Schindelin	d54dea77 fetch: let --jobs=<n> parallelize --multiple, too
builtin/fetch.c
d54dea77 113) fetch_parallel_config = git_config_int(k, v);
d54dea77 114) if (fetch_parallel_config < 0)
d54dea77 115) die(_("fetch.parallel cannot be negative"));
d54dea77 116) return 0;
d54dea77 1566) static int fetch_failed_to_start(struct strbuf *out, void *cb, void *task_cb)
d54dea77 1568) struct parallel_fetch_state *state = cb;
d54dea77 1569) const char *remote = task_cb;
d54dea77 1571) state->result = error(_("Could not fetch %s"), remote);
d54dea77 1573) return 0;

Johannes Schindelin	be5d88e1 test-tool run-command: learn to run (parts of) the testsuite
t/helper/test-run-command.c
be5d88e1 66) static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
be5d88e1 69) struct testsuite *suite = cb;
be5d88e1 71) if (suite->next >= suite->tests.nr)
be5d88e1 72) return 0;
be5d88e1 74) test = suite->tests.items[suite->next++].string;
be5d88e1 75) argv_array_pushl(&cp->args, "sh", test, NULL);
be5d88e1 76) if (suite->quiet)
be5d88e1 77) argv_array_push(&cp->args, "--quiet");
be5d88e1 78) if (suite->immediate)
be5d88e1 79) argv_array_push(&cp->args, "-i");
be5d88e1 80) if (suite->verbose)
be5d88e1 81) argv_array_push(&cp->args, "-v");
be5d88e1 82) if (suite->verbose_log)
be5d88e1 83) argv_array_push(&cp->args, "-V");
be5d88e1 84) if (suite->trace)
be5d88e1 85) argv_array_push(&cp->args, "-x");
be5d88e1 86) if (suite->write_junit_xml)
be5d88e1 87) argv_array_push(&cp->args, "--write-junit-xml");
be5d88e1 89) strbuf_addf(err, "Output of '%s':\n", test);
be5d88e1 90) *task_cb = (void *)test;
be5d88e1 92) return 1;
be5d88e1 95) static int test_finished(int result, struct strbuf *err, void *cb,
be5d88e1 98) struct testsuite *suite = cb;
be5d88e1 99) const char *name = (const char *)task_cb;
be5d88e1 101) if (result)
be5d88e1 102) string_list_append(&suite->failed, name);
be5d88e1 104) strbuf_addf(err, "%s: '%s'\n", result ? "FAIL" : "SUCCESS", name);
be5d88e1 106) return 0;
be5d88e1 109) static int test_failed(struct strbuf *out, void *cb, void *task_cb)
be5d88e1 111) struct testsuite *suite = cb;
be5d88e1 112) const char *name = (const char *)task_cb;
be5d88e1 114) string_list_append(&suite->failed, name);
be5d88e1 115) strbuf_addf(out, "FAILED TO START: '%s'\n", name);
be5d88e1 117) return 0;
be5d88e1 125) static int testsuite(int argc, const char **argv)
be5d88e1 127) struct testsuite suite = TESTSUITE_INIT;
be5d88e1 128) int max_jobs = 1, i, ret;
be5d88e1 131) struct option options[] = {
be5d88e1 145) memset(&suite, 0, sizeof(suite));
be5d88e1 146) suite.tests.strdup_strings = suite.failed.strdup_strings = 1;
be5d88e1 148) argc = parse_options(argc, argv, NULL, options,
be5d88e1 151) if (max_jobs <= 0)
be5d88e1 152) max_jobs = online_cpus();
be5d88e1 154) dir = opendir(".");
be5d88e1 155) if (!dir)
be5d88e1 156) die("Could not open the current directory");
be5d88e1 157) while ((d = readdir(dir))) {
be5d88e1 158) const char *p = d->d_name;
be5d88e1 160) if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
be5d88e1 161)     !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
be5d88e1 162)     !ends_with(p, ".sh"))
be5d88e1 163) continue;
be5d88e1 166) if (!argc) {
be5d88e1 167) string_list_append(&suite.tests, p);
be5d88e1 168) continue;
be5d88e1 171) for (i = 0; i < argc; i++)
be5d88e1 172) if (!wildmatch(argv[i], p, 0)) {
be5d88e1 173) string_list_append(&suite.tests, p);
be5d88e1 174) break;
be5d88e1 177) closedir(dir);
be5d88e1 179) if (!suite.tests.nr)
be5d88e1 180) die("No tests match!");
be5d88e1 181) if (max_jobs > suite.tests.nr)
be5d88e1 182) max_jobs = suite.tests.nr;
be5d88e1 184) fprintf(stderr, "Running %d tests (%d at a time)\n",
be5d88e1 187) ret = run_processes_parallel(max_jobs, next_test, test_failed,
be5d88e1 190) if (suite.failed.nr > 0) {
be5d88e1 191) ret = 1;
be5d88e1 192) fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
be5d88e1 193) for (i = 0; i < suite.failed.nr; i++)
be5d88e1 194) fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
be5d88e1 197) string_list_clear(&suite.tests, 0);
be5d88e1 198) string_list_clear(&suite.failed, 0);
be5d88e1 200) return !!ret;
be5d88e1 209) exit(testsuite(argc - 1, argv + 1));

Josh Steadmon	87db61a4 trace2: write discard message to sentinel files
trace2/tr2_dst.c
87db61a4 136) strbuf_setlen(&path, base_path_len);
87db61a4 137) strbuf_addf(&path, ".%d", attempt_count);

Josh Steadmon	83e57b04 trace2: discard new traces if target directory has too many files
trace2/tr2_dst.c
83e57b04 90) ret = 1;
83e57b04 91) goto cleanup;
83e57b04 145) strbuf_release(&path);
83e57b04 146) if (tr2_dst_want_warning())
83e57b04 147) warning("trace2: not opening %s trace file due to too "
83e57b04 151) return 0;

Junio C Hamano	360c7ba3 transport: push codepath can take arbitrary repository
transport.c
360c7ba3 1200) trace2_region_leave("transport_push", "push_submodules", r);



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducting uncovered code:
Alex Henrie	baed6bbb diffcore-break: use a goto instead of a redundant if statement
diffcore-break.c
baed6bbb 295) diff_q(&outq, p);

Ali Utku Selen	ddb3c856 shallow.c: don't free unallocated slabs
shallow.c
ddb3c856 157) continue;

Brandon Casey	040a6551 cleanup: use internal memory allocation wrapper functions everywhere
stable-qsort.c
040a6551 58) char *tmp = xmalloc(size);

Brian Downing	43fe901b compat: Add simplified merge sort implementation from glibc
stable-qsort.c
43fe901b 59) msort_with_tmp(b, n, s, cmp, tmp);
43fe901b 60) free(tmp);

brian m. carlson	fabec2c5 builtin/receive-pack: switch to use the_hash_algo
builtin/receive-pack.c
fabec2c5 433) the_hash_algo->init_fn(&ctx);
fabec2c5 434) the_hash_algo->update_fn(&ctx, key_in, key_len);
fabec2c5 435) the_hash_algo->final_fn(key, &ctx);

brian m. carlson	28ba1830 builtin/replace: make hash size independent
builtin/replace.c
28ba1830 275) if (strbuf_read(&result, cmd.out, the_hash_algo->hexsz + 1) < 0) {

brian m. carlson	7e0d029f builtin/rev-parse: switch to use the_hash_algo
builtin/rev-parse.c
7e0d029f 735) abbrev = hexsz;

brian m. carlson	8d4d86b0 cache: remove null_sha1
builtin/submodule--helper.c
8d4d86b0 427) printf("%06o %s U\t", ce->ce_mode, oid_to_hex(&null_oid));

Denton Liu	2b318aa6 rebase: refactor can_fast_forward into goto tower
builtin/rebase.c
2b318aa6 1273) goto done;

Denton Liu	c0efb4c1 rebase: fast-forward --onto in more cases
builtin/rebase.c
c0efb4c1 1289) goto done;

Derrick Stolee	50f26bd0 fetch: add fetch.writeCommitGraph config setting
repo-settings.c
50f26bd0 57) UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);

Elijah Newren	89a1f4aa dir: if our pathspec might match files under a dir, recurse into it
dir.c
89a1f4aa 374) return MATCHED_RECURSIVELY_LEADING_PATHSPEC;

Jeff Hostetler	da4589ce trace2: trim whitespace in region messages in perf target format
trace2/tr2_tgt_perf.c
da4589ce 459) strbuf_addf(&buf_payload, "label:%s", label);
da4589ce 460) if (fmt && *fmt) {
da4589ce 461) strbuf_addch(&buf_payload, ' ');
da4589ce 462) maybe_append_string_va(&buf_payload, fmt, ap);
da4589ce 479) strbuf_addf(&buf_payload, "label:%s", label);
da4589ce 480) if (fmt && *fmt) {
da4589ce 481) strbuf_addch(&buf_payload, ' ' );
da4589ce 482) maybe_append_string_va(&buf_payload, fmt, ap);

Jeff Hostetler	371df1be trace2: cleanup column alignment in perf target format
trace2/tr2_tgt_perf.c
371df1be 88) fl_end_col = buf->len + TR2FMT_PERF_FL_WIDTH;
371df1be 90) if (file && *file) {
371df1be 91) struct strbuf buf_fl = STRBUF_INIT;
371df1be 93) strbuf_addf(&buf_fl, "%s:%d", file, line);
371df1be 95) if (buf_fl.len <= TR2FMT_PERF_FL_WIDTH)
371df1be 96) strbuf_addbuf(buf, &buf_fl);
371df1be 98) size_t avail = TR2FMT_PERF_FL_WIDTH - 3;
371df1be 99) strbuf_addstr(buf, "...");
371df1be 100) strbuf_add(buf,
371df1be 101)    &buf_fl.buf[buf_fl.len - avail],
371df1be 105) strbuf_release(&buf_fl);
371df1be 108) while (buf->len < fl_end_col)
371df1be 111) strbuf_addstr(buf, " | ");

Jeff Hostetler	e3443055 trace2: cleanup whitespace in normal format
trace2/tr2_tgt_normal.c
e3443055 189) strbuf_addf(&buf_payload, "alias %s -> ", alias);
e3443055 190) sq_append_quote_argv_pretty(&buf_payload, argv);
e3443055 201) strbuf_addf(&buf_payload, "child_start[%d]", cmd->trace2_child_id);
e3443055 204) strbuf_addstr(&buf_payload, " cd ");
e3443055 206) strbuf_addstr(&buf_payload, ";");
e3443055 214) strbuf_addch(&buf_payload, ' ');
e3443055 216) strbuf_addstr(&buf_payload, "git ");
e3443055 217) sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
e3443055 242) if (exe) {
e3443055 244) strbuf_addch(&buf_payload, ' ');
e3443055 246) sq_append_quote_argv_pretty(&buf_payload, argv);

Jeff Hostetler	742ed633 trace2: cleanup whitespace in perf format
trace2/tr2_tgt_perf.c
742ed633 302) strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
742ed633 303) sq_append_quote_argv_pretty(&buf_payload, argv);
742ed633 304) strbuf_addch(&buf_payload, ']');
742ed633 335) strbuf_addstr(&buf_payload, "git");
742ed633 336) if (cmd->argv[0])
742ed633 337) strbuf_addch(&buf_payload, ' ');
742ed633 391) strbuf_addstr(&buf_payload, "argv:[");
742ed633 392) if (exe) {
742ed633 393) strbuf_addstr(&buf_payload, exe);
742ed633 394) if (argv[0])
742ed633 395) strbuf_addch(&buf_payload, ' ');
742ed633 397) sq_append_quote_argv_pretty(&buf_payload, argv);
742ed633 398) strbuf_addch(&buf_payload, ']');

Jeff King	0dfed92d git-am: handle missing "author" when parsing commit
builtin/am.c
0dfed92d 1262) die(_("missing author line in commit %s"),
0dfed92d 1263)       oid_to_hex(&commit->object.oid));

Jeff King	fbab552a commit-graph: bump DIE_ON_LOAD check to actual load-time
commit-graph.c
fbab552a 483) die("dying as requested by the '%s' variable on commit-graph load!",

Jeff King	3a37876b pack-objects: drop packlist index_pos optimization
pack-objects.c
3a37876b 185) BUG("duplicate object inserted into hash");

Johannes Schindelin	e2683d51 Fix .git/ discovery at the root of UNC shares
setup.c
e2683d51 952)     !is_dir_sep(dir->buf[min_offset - 1])) {
e2683d51 953) strbuf_addch(dir, '/');
e2683d51 954) min_offset++;

Phillip Wood	a47ba3c7 rebase -i: check for updated todo after squash and reword
sequencer.c
a47ba3c7 3918) res = error_errno(_("could not stat '%s'"),
a47ba3c7 3924) res = -1; /* message was printed */

René Scharfe	59fa5f5a sha1-name: check for overflow of N in "foo^N" and "foo~N"
sha1-name.c
59fa5f5a 1172) return MISSING_OBJECT;
59fa5f5a 1178) return MISSING_OBJECT;

René Scharfe	1fd881d4 trace2: use warning() directly in tr2_dst_malformed_warning()
trace2/tr2_dst.c
1fd881d4 218) warning("trace2: unknown value for '%s': '%s'",

René Scharfe	dad3f060 tag: factor out get_tagged_oid()
pack-bitmap.c
dad3f060 712) object = parse_object_or_die(get_tagged_oid(tag), NULL);

SZEDER Gábor	2bb74b53 Test the progress display
t/helper/test-progress.c
2bb74b53 48) die("need a title for the progress output");
2bb74b53 59) die("invalid input: '%s'\n", line.buf);
2bb74b53 67) die("invalid input: '%s'\n", line.buf);
2bb74b53 70) die("invalid input: '%s'\n", line.buf);

Thomas Gummerer	34933d0e stash: make sure to write refreshed cache
builtin/stash.c
34933d0e 1137) ret = -1;
34933d0e 1138) goto done;

Thomas Gummerer	8e4c8af0 push: disallow --all and refspecs when remote.<name>.mirror is set
builtin/push.c
8e4c8af0 609) die(_("bad repository '%s'"), repo);
8e4c8af0 625) die(_("--all and --tags are incompatible"));
8e4c8af0 627) die(_("--all can't be combined with refspecs"));
8e4c8af0 631) die(_("--mirror and --tags are incompatible"));
8e4c8af0 636) die(_("--all and --mirror are incompatible"));

Thomas Gummerer	22184497 factor out refresh_and_write_cache function
builtin/am.c
22184497 1695) die(_("unable to write index file"));

read-cache.c
22184497 1487) return -1;
22184497 1491) ret = -1;

Torsten Bögershausen	ebb8d2c9 mingw: support UNC in git clone file://server/share/repo
connect.c
ebb8d2c9 921) path = host - 2; /* include the leading "//" */


