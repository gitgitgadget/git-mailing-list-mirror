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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5D91F462
	for <e@80x24.org>; Tue, 30 Jul 2019 13:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfG3NHG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 09:07:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46048 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfG3NHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 09:07:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so46542941qkj.12
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IsO1rwzHkpR2VF7/Rv1nnCtf11NOa3bK5/yrfr2X8+4=;
        b=Sxx6D7qJwmA8e1oE6qmLZ435svWC7LLxmMZS0KMKy6m82ptTJnDZUE2XBSkuBgrCro
         nNbz94of5EIVUJ11qgbUHWgUv+Fr+MDw46H1LPVLnFl1vkf/W+Vlghfvb5d/YUmk4iuN
         Xq/oCtX0Z9Q5DiPQGSQjohXbDqMnTnGux7d6tW2uiP3gPy6HsqZqEK5TzdTi0OmRmDfq
         bQjvI4xI/GUhJ3Ycr9/elW2NUCpOjKyJfjoyrs9MgnLvqVBcACUqSF5HSzNf5HRTGODH
         1U15W46DZK7ZS6ZoCpHQApWFl4AQHSNGvtp0adbxUiaHCmwvw5y+8vLL0UxU7wer7JHb
         skdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IsO1rwzHkpR2VF7/Rv1nnCtf11NOa3bK5/yrfr2X8+4=;
        b=SnTKXG3uKq/UaDTT6zUBiSS7VSYdwAdlrle4gul2ifHhhnW6A1p3W5RIqf/kfa1p7y
         6HcKpfgrfd+tySGdxkDZZKsWBzPixPiWmT9H4abaoVmS+qnOXL6Vb0zIghX5mwJPrCH2
         WMPBv4jrUMtf83jscCIy6LNMCHYdbn35pbwn58473FQ789IAjX/DbH0biT75vTVpb+Ck
         0QMimNAMLHKlfoFsUiwELQoBql2I4qWkQHkTBr6PUCJRUHS33bQoFhD0qz9j7yLrX5gF
         9E27+RusdQOdTJ4hB+44DSUA7eD/O0hR6XLg9UuYuMGyfA9GjytT7eclzdVrlH6q/MXI
         MiRw==
X-Gm-Message-State: APjAAAUO00Fyw/isANK3SMK6F+eC7rYHd72bXP521OKWQYtHFsHp9jUF
        s2rcgjspk3nSovCp/SIccFW4nAlV
X-Google-Smtp-Source: APXvYqyU9qU62AGkGfWFt4n8MWhKac7Av7Kcudt+y8nENrptQdEdzg3gaGXxTlYBDLs5HDOe87QyzA==
X-Received: by 2002:a37:4cd2:: with SMTP id z201mr67716008qka.284.1564492023901;
        Tue, 30 Jul 2019 06:07:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9049:226e:5210:8681? ([2001:4898:a800:1012:417d:226e:5210:8681])
        by smtp.gmail.com with ESMTPSA id o21sm26651136qtq.16.2019.07.30.06.07.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 06:07:03 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.23.0-rc0)
Message-ID: <9991a0b8-ae4d-beef-2d8a-a3a38773e181@gmail.com>
Date:   Tue, 30 Jul 2019 09:07:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the test coverage report for the changes in v2.23.0-rc0 since v2.22.0.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/v2.23.0-rc0.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/v2.23.0-rc0.txt

---

apply.c
85c3713d 1187) cp = skip_tree_prefix(p_value, second, line + llen - second);

archive.c
50ddb089 421) err = get_tree_entry(ar_args->repo,
50ddb089 422)      &tree->object.oid,

blame.c
1fc73384 990) return;
a07a9776 1599) continue;
ae3f36de 2416) continue;

builtin/am.c
97387c8b 1662) die("unable to read from stdin; aborting");
6e7baf24 2336) die(_("interactive mode requires patches on the command line"));

builtin/bisect--helper.c
7877ac3d 574) retval = error(_("invalid ref: '%s'"), start_head.buf);
7877ac3d 575) goto finish;

builtin/blame.c

builtin/branch.c
1fde99cf 841) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"

builtin/checkout.c
d16dc428 1345) warning(_("you are switching branch while bisecting"));
3ec37ad1 1370) die(_("'%s' cannot be used with '%s'"), "--discard-changes", "--merge");
c9c935f6 1508) BUG("make up your mind, you need to take _something_");
183fb44f 1540) opts->checkout_index = 0;
183fb44f 1550) BUG("these flags should be non-negative by now");
c9c935f6 1611) die(_("could not resolve %s"), opts->from_treeish);

builtin/clean.c
b09364c4 198) warning_errno(_(msg_warn_lstat_failed), path->buf);

builtin/clone.c
14954b79 407) die_errno(_("failed to create directory '%s'"), pathname);
14954b79 409) die_errno(_("failed to stat '%s'"), pathname);
ff7ccc8c 428) die_errno(_("failed to start iterator over '%s'"), src->buf);
ff7ccc8c 466) strbuf_setlen(src, src_len);
ff7ccc8c 467) die(_("failed to iterate over '%s'"), src->buf);

builtin/commit-graph.c
c2bc6e6a 203) return 1;

builtin/commit.c
e103f727 1694) return 1;

builtin/env--helper.c
b4f207f3 23) die(_("unrecognized --type argument, %s"), arg);
b4f207f3 67) default_int = 0;
b4f207f3 82) default_ulong = 0;
b4f207f3 90) BUG("unknown <type> value");

builtin/fast-export.c
e80001f8 85) reencode_mode = REENCODE_ABORT;
e80001f8 86) return 0;
e80001f8 100) return error("Unknown reencoding mode: %s", arg);

builtin/fetch.c
cdbd70c4 88) fetch_show_forced_updates = git_config_bool(k, v);
cdbd70c4 89) return 0;
377444b4 1011) warning(_("It took %.2f seconds to check forced updates. You can use '--no-show-forced-updates'\n"),
377444b4 1013) warning(_("or run 'git config fetch.showForcedUpdates false' to avoid this check.\n"));

builtin/gc.c

builtin/log.c
f0596ecc 219) warning("%s\n", _(warn_unspecified_mailmap_msg));
13cdf780 895) return 0;

builtin/merge.c
f3f8311e 1291) usage_msg_opt(_("--quit expects no arguments"),

builtin/multi-pack-index.c

builtin/pull.c
3883c551 556) argv_array_push(&args, "--show-forced-updates");
3883c551 558) argv_array_push(&args, "--no-show-forced-updates");

builtin/rebase.c
d559f502 759) ret = error(_("could not remove '%s'"),
d559f502 1645) error(_("could not remove '%s'"),
906b6394 1797) die(_("--reschedule-failed-exec requires "

builtin/worktree.c
1de16aec 297) BUG("How come '%s' becomes empty after sanitization?", sb.buf);

builtin/write-tree.c
76a7bc09 53) die("%s: prefix %s not found", me, tree_prefix);

commit-graph.c
118bd570 277) chunk_repeated = 1;
118bd570 347) warning(_("commit-graph has no base graphs chunk"));
118bd570 348) return 0;
5c84b339 401) break;
d4f4d60f 550) BUG("NULL commit-graph");
d4f4d60f 553) die(_("invalid commit position. commit-graph is likely corrupt"));
d4f4d60f 613) die(_("invalid commit position. commit-graph is likely corrupt"));
6c622f9f 1057) continue;
ef5b83f2 1179) error(_("error opening index for %s"), packname.buf);
ef5b83f2 1180) return -1;
4c9efe85 1219) continue;
b2c83060 1242) display_progress(ctx->progress, ctx->approx_nr_objects);
6c622f9f 1331) error(_("failed to write correct number of base graph ids"));
6c622f9f 1332) return -1;
238def57 1364) error(_("unable to create leading directories of %s"),
238def57 1366) return -1;
6c622f9f 1376) error(_("unable to create '%s'"), ctx->graph_name);
6c622f9f 1377) return -1;
6c622f9f 1451) return -1;
6c622f9f 1477) error(_("unable to open commit-graph chain file"));
6c622f9f 1478) return -1;
135a7123 1489) error(_("failed to rename base commit-graph file"));
6c622f9f 1509) error(_("failed to rename temporary commit-graph file"));
6c622f9f 1510) return -1;
c523035c 1539) break;
c523035c 1554) ctx->num_commit_graphs_after = 1;
c523035c 1555) ctx->new_base_graph = NULL;
1771be90 1631) die(_("unexpected duplicate commit id %s"),
1771be90 1632)     oid_to_hex(&ctx->commits.list[i]->object.oid));
c2bc6e6a 1806) ctx->oids.alloc = split_opts->max_commits;
e103f727 1842) error(_("the commit graph format cannot write %d commits"), count_distinct);
e103f727 1843) res = -1;
e103f727 1844) goto cleanup;
e103f727 1853) error(_("too many commits to write graph"));
e103f727 1854) res = -1;
e103f727 1855) goto cleanup;

config.c
07b2c0ea 283) return 0;
2e43cd4c 998)     value, name, cf->name, _(error_type));
2e43cd4c 1007)     value, name, cf->name, _(error_type));
2e43cd4c 1010)     value, name, cf->name, _(error_type));
2e43cd4c 1013)     value, name, cf->name, _(error_type));

delta-islands.c
bdbdf42f 467) fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);

dir-iterator.c
3012397e 88) warning_errno("error closing directory '%s'",
fa1da7d2 122) warning_errno("failed to stat '%s'", iter->base.path.buf);
fa1da7d2 137) goto error_out;
3012397e 152) warning_errno("error reading directory '%s'",
fa1da7d2 154) if (iter->flags & DIR_ITERATOR_PEDANTIC)
fa1da7d2 155) goto error_out;
fa1da7d2 166) if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
fa1da7d2 167) goto error_out;
c9bba372 188) int saved_errno = errno;
c9bba372 190) errno = saved_errno;
c9bba372 191) warning_errno("error closing directory '%s'",

fast-import.c
d3b4705a 2565) char *buf = read_object_with_reference(the_repository,
d3b4705a 2566)        &n->oid,

fetch-pack.c
5a88583b 914) else if (args->depth > 0 || is_repository_shallow(the_repository))
0778b293 928) print_verbose(args, _("Server supports %s"), "multi_ack");
0778b293 936) print_verbose(args, _("Server supports %s"), "side-band");
5a88583b 974) } else if (args->deepen_since)
5a88583b 979) } else if (args->deepen_not)
5a88583b 983) else if (args->deepen_relative)

grep.c
de99eb0c 1784) BUG("grep call which could print a name requires "

kwset.c
08e04506 45) BUG("Cannot allocate a negative amount: %ld", size);

list-objects-filter-options.c
5c03bc8b 94) strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);

match-trees.c
90d34051 294) if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))

midx.c
d01bf2e6 478) close_pack(packs->info[packs->nr].p);
d01bf2e6 479) FREE_AND_NULL(packs->info[packs->nr].p);
19575c7c 738) BUG("object %s is in an expired pack with int-id %d",
19575c7c 865) error(_("did not see pack-file %s to drop"),
19575c7c 867) drop_index++;
19575c7c 868) missing_drops++;
19575c7c 869) i--;
19575c7c 876) result = 1;
19575c7c 877) goto cleanup;
19575c7c 1194) return 0;
19575c7c 1209) continue;
ce1e4a10 1248) return 0;
ce1e4a10 1275) continue;
ce1e4a10 1295) continue;
ce1e4a10 1297) continue;
ce1e4a10 1329) return 0;
ce1e4a10 1350) error(_("could not start pack-objects"));
ce1e4a10 1351) result = 1;
ce1e4a10 1352) goto cleanup;
ce1e4a10 1369) error(_("could not finish pack-objects"));
ce1e4a10 1370) result = 1;
ce1e4a10 1371) goto cleanup;

name-hash.c
568a05c5 348) assert(begin >= 0);
568a05c5 350) int mid = begin + ((end - begin) >> 1);

oidset.c

packfile.c
8434e85d 372) strbuf_release(&buf);
8434e85d 373) return;
921d49be 1303) COPY_ARRAY(poi_stack, small_poi_stack, poi_stack_nr);
921d49be 1713) COPY_ARRAY(delta_stack, small_delta_stack,

pager.c
cd1096b2 197) fputs("\r\033[K", stderr);

progress.c
5b12e312 121) fprintf(stderr, "  %s%s", counters_sb->buf,
5b12e312 127) fprintf(stderr, "%s:\n  %s%s",

range-diff.c
44b67cb6 33) return size;
44b67cb6 95) strbuf_release(&contents);
b66885a3 117) die(_("could not parse git header '%.*s'"), (int)len, line);
b66885a3 135)     patch.old_mode != patch.new_mode)
b66885a3 136) strbuf_addf(&buf, " (mode change %06o => %06o)",
44b67cb6 181) strbuf_addstr(&buf, line);

read-cache.c
7bd9631b 2201) src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);

ref-filter.c
2582083f 94) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
28438e84 1501) strbuf_addstr(&desc, _("no branch"));
b31e2680 1967) break;

refs.c
1de16aec 111) sanitized->buf[sanitized->len-1] = '-';
1de16aec 170) if (sanitized)
1de16aec 171) strbuf_addch(sanitized, '-');
1de16aec 173) return -1;
1de16aec 178) strbuf_complete(sanitized, '/');
1de16aec 215) BUG("sanitizing refname '%s' check returned error", refname);

sequencer.c
37e9ee5c 293) ret = -1;
37e9ee5c 311) ret = error(_("could not remove '%s'"), buf.buf);
ed5b1ca1 2198)  (*bol == ' ' || *bol == '\t'))
ed5b1ca1 2201) ret = -1;
6a1f9046 2668) in_progress_error = _("revert is already in progress");
6a1f9046 2669) in_progress_advice =
6a1f9046 2671) break;
6a1f9046 2678) BUG("unexpected action in create_seq_dir");
de81ca3f 2777) return error(_("cannot resolve HEAD"));
de81ca3f 2860) if (!rollback_is_safe())
de81ca3f 2861) goto give_advice;
de81ca3f 2873) BUG("unexpected action in sequencer_skip");
de81ca3f 2877) return error(_("failed to skip the commit"));

server-info.c
f4f476b6 110) ret = -1;
f4f476b6 111) goto out;
f4f476b6 123) goto out;
f4f476b6 125) goto out;
f4f476b6 134) if (uic.cur_fp)
f4f476b6 135) fclose(uic.cur_fp);

sh-i18n--envsubst.c
568a05c5 252)   size_t j = j1 + ((j2 - j1) >> 1);

sha1-file.c
709dfa69 784) return;
709dfa69 792) warning(_("invalid line while parsing alternate refs: %s"),
709dfa69 794) break;
709dfa69 817) goto out;
709dfa69 819) goto out;
709dfa69 825) goto out;

strbuf.c
8f354a1f 818) strbuf_addf(buf,
8f354a1f 850) Q_("%u byte/s", "%u bytes/s", (unsigned)bytes),

t/helper/test-dir-iterator.c
fa1da7d2 24) die("invalid option '%s'", *argv);
fa1da7d2 28) die("dir-iterator needs exactly one non-option argument");
150791ad 46) printf("[?] ");

t/helper/test-match-trees.c
90d34051 23) shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);

upload-pack.c
62b89d43 534) if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
d0229abd 537) o = lookup_object(the_repository, &oid);

wt-status.c
0a53561a 1114) strbuf_addf(&sb, _("\n"

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	b4f207f3 env--helper: new undocumented builtin wrapping git_env_*()
Ævar Arnfjörð Bjarmason	2e43cd4c config.c: refactor die_bad_number() to not call gettext() early
Ariadne Conill	f0596ecc log: add warning for unspecified log.mailmap setting
Barret Rhoden	ae3f36de blame: add the ability to ignore commits and their changes
Barret Rhoden	1fc73384 blame: optionally track line fingerprints during fill_blame_origin()
Barret Rhoden	a07a9776 blame: use the fingerprint heuristic to match ignored lines
Daniel Ferreira	150791ad dir-iterator: add tests for dir-iterator API
Denton Liu	13cdf780 format-patch: teach format.notes config option
Denton Liu	07b2c0ea config: learn the "onbranch:" includeIf condition
Derrick Stolee	b2c83060 commit-graph: extract fill_oids_from_all_packs()
Derrick Stolee	4c9efe85 commit-graph: extract fill_oids_from_commit_hex()
Derrick Stolee	ef5b83f2 commit-graph: extract fill_oids_from_packs()
Derrick Stolee	6c622f9f commit-graph: write commit-graph chains
Derrick Stolee	5c84b339 commit-graph: load commit-graph chains
Derrick Stolee	118bd570 commit-graph: add base graphs chunk
Derrick Stolee	1771be90 commit-graph: merge commit-graph chains
Derrick Stolee	3883c551 pull: add --[no-]show-forced-updates passthrough
Derrick Stolee	238def57 commit-graph: extract write_commit_graph_file()
Derrick Stolee	d4f4d60f commit-graph: prepare for commit-graph chains
Derrick Stolee	c523035c commit-graph: allow cross-alternate chains
Derrick Stolee	cdbd70c4 fetch: add --[no-]show-forced-updates argument
Derrick Stolee	377444b4 fetch: warn about forced updates in branch listing
Derrick Stolee	ce1e4a10 midx: implement midx_repack()
Derrick Stolee	19575c7c multi-pack-index: implement 'expire' subcommand
Derrick Stolee	d01bf2e6 midx: refactor permutation logic and pack sorting
Derrick Stolee	8434e85d repack: refactor pack deletion for future use
Derrick Stolee	e103f727 commit-graph: return with errors during write
Derrick Stolee	135a7123 commit-graph: add --split option to builtin
Derrick Stolee	c2bc6e6a commit-graph: create options for split files
Dimitriy Ryazantcev	8f354a1f l10n: localizable upload progress messages
Elijah Newren	e80001f8 fast-export: do automatic reencoding of commit messages only if requested
Emily Shaffer	de99eb0c grep: fail if call could output and name is null
Eric Wong	f4f476b6 update-server-info: avoid needless overwrites
Jeff Hostetler	0a53561a status: warn when a/b calculation takes too long
Jeff King	7bd9631b read-cache: drop unused parameter from threaded load
Jeff King	709dfa69 object-store.h: move for_each_alternate_ref() from transport.h
Jeff King	62b89d43 upload-pack: rename a "sha1" variable to "oid"
Jeff King	d0229abd object: convert lookup_object() to use object_id
Jeff King	bdbdf42f delta-islands: respect progress flag
Jeff King	6e7baf24 am: drop tty requirement for --interactive
Jeff King	97387c8b am: read interactive input from stdin
Jeff King	76a7bc09 cmd_{read,write}_tree: rename "unused" variable that is used
Johannes Schindelin	906b6394 rebase --am: ignore rebase.rescheduleFailedExec
Johannes Schindelin	7877ac3d bisect--helper: verify HEAD could be parsed before continuing
Johannes Schindelin	b09364c4 clean: show an error message when the path is too long
Johannes Schindelin	08e04506 kwset: allow building with GCC 8
Matheus Tavares	14954b79 clone: extract function from copy_or_link_directory
Matheus Tavares	3012397e dir-iterator: refactor state machine model
Matheus Tavares	fa1da7d2 dir-iterator: add flags parameter to dir_iterator_begin
Matheus Tavares	c9bba372 dir-iterator: use warning_errno when possible
Matheus Tavares	ff7ccc8c clone: use dir-iterator to avoid explicit dir traversal
Matthew DeVore	28438e84 ref-filter: sort detached HEAD lines firstly
Matthew DeVore	5c03bc8b list-objects-filter-options: error is localizeable
Nguyễn Thái Ngọc Duy	d16dc428 switch: allow to switch in the middle of bisect
Nguyễn Thái Ngọc Duy	3ec37ad1 switch: add --discard-changes
Nguyễn Thái Ngọc Duy	50ddb089 tree-walk.c: remove the_repo from get_tree_entry()
Nguyễn Thái Ngọc Duy	1de16aec worktree add: sanitize worktree names
Nguyễn Thái Ngọc Duy	c9c935f6 restore: take tree-ish from --source option instead
Nguyễn Thái Ngọc Duy	5a88583b fetch-pack: print all relevant supported capabilities with -v -v
Nguyễn Thái Ngọc Duy	f3f8311e merge: add --quit
Nguyễn Thái Ngọc Duy	90d34051 match-trees.c: remove the_repo from shift_tree*()
Nguyễn Thái Ngọc Duy	d3b4705a sha1-file.c: remove the_repo from read_object_with_reference()
Nguyễn Thái Ngọc Duy	0778b293 fetch-pack: move capability names out of i18n strings
Nguyễn Thái Ngọc Duy	183fb44f restore: add --worktree and --staged
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom
Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches
Phillip Wood	37e9ee5c sequencer: return errors from sequencer_remove_state()
Phillip Wood	ed5b1ca1 status: do not report errors in sequencer/todo
Phillip Wood	d559f502 rebase --abort/--quit: cleanup refs/rewritten
René Scharfe	568a05c5 cleanup: fix possible overflow errors in binary search, part 2
René Scharfe	921d49be use COPY_ARRAY for copying arrays
Rohit Ashiwal	de81ca3f cherry-pick/revert: add --skip option
Rohit Ashiwal	6a1f9046 sequencer: add advice for revert
SZEDER Gábor	cd1096b2 pager: add a helper function to clear the last line in the terminal
SZEDER Gábor	5b12e312 progress: use term_clear_line()
Taylor Blau	b31e2680 ref-filter.c: find disjoint pattern prefixes
Thomas Gummerer	b66885a3 range-diff: add section header instead of diff header
Thomas Gummerer	44b67cb6 range-diff: split lines manually
Thomas Gummerer	85c3713d apply: only pass required data to git_header_name

