Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716DD1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 14:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfJUOP6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 10:15:58 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:35575 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUOP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 10:15:58 -0400
Received: by mail-qt1-f179.google.com with SMTP id m15so21306549qtq.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6t4ZwCuyjh1aTAOBR6441KVZ6Dyo8/Y77jiLbHJAd+E=;
        b=hmnJfDmb5uiHZxxNZ5wPGal7LWYyvE73KUgrUKLLaZhsQoUgAHfgAlRDdF95BRj7HA
         jKYuQagClqO523LeQLlKGQCjxzVrT0ocF6A/wrOClLr/sKf/3vgAhAxm+4Xmh9uWk2mM
         6bOKEZZ51XGEls4VD9rtk4jmjv0x2f/lLWm6ol5mJRfutOkb8LpOAh72mI0q+If0Mgt9
         IHmAugQSRkvpDpjDdFwcR+dkMvdoAjTNzbQkOc2STs8z/T2Cu56zopBvMzGT2/T+wUn8
         NBBtsPFX1BX+2UuXG4x/lFhS26hEMJuCFXoBQglQNXwpFf6gBJhcmPc7lKgHWWr/U0Uy
         274Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6t4ZwCuyjh1aTAOBR6441KVZ6Dyo8/Y77jiLbHJAd+E=;
        b=lEVQbxXuxtHPZtSi1DFwmz03Xsc5F8AAJ8sk776yIHlXVgLOXliGAvoJUSSpMSQz+t
         ErrkraJpYsnUmTwE3rYSRdU6J3xvpkFuVq0pF/lbSJg4qHRClfwFAuBlz1jw0/EAxDXW
         gNwoHglJKU9GEjNyGOD3YqsO93z4dOhANnfbL2FaxitB1DzcWCKoh1v68g/3rzih3agQ
         Kdlg6yUd7ZO7lLZPusMnF18wXFf4QuZxd2VUGV7qL64alth11tgaoLIloiFwlL/srvRN
         ZEoS9/2Oltd4gaall1EhhVDAbiOzCcoLzG49O1gITDewpptWo2t3TA3b+LWieD3SWUMD
         bi3Q==
X-Gm-Message-State: APjAAAWc30+vI1O6vPkWrSNH9wufdhQFF1KpXWFQ1swUvBQxXU7JDpRK
        xXro8Xv0lJf7gyxq3c6GscJY5FpWpTI=
X-Google-Smtp-Source: APXvYqwBlKJbOuGjLehUUE0tuI7WISelIu9KnA8upnF5scnF/GdEfuVOeGjOC+NoZGEPqH4MSBu3Rg==
X-Received: by 2002:ad4:4449:: with SMTP id l9mr24088247qvt.81.1571667354050;
        Mon, 21 Oct 2019 07:15:54 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4018:ebea:d287:d7b3? ([2001:4898:a800:1012:f14b:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id 18sm5134071qky.109.2019.10.21.07.15.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:15:53 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.24.0-rc0)
Message-ID: <ed8e65a2-72e8-210c-d4a4-eacdb5c7b0e8@gmail.com>
Date:   Mon, 21 Oct 2019 10:15:52 -0400
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

Here is today's test coverage report. You can find it at the normal place [1][2][3].

I set the "master@{1}" to be the maint branch, so this should cover all new code that
is not in the previous release.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-10-21.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-10-21.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2019-10-21-commits.txt

---

pu	936d5c92bfb989d706cc1899b1cd6afc5bc9c0df
jch	0926ab8072b48968d05b0ebb9cc3d8043722ddc1
next	954a862665455a25876e1113bd865d43a26facce
master	d966095db01190a2196e31195ea6fa0c722aa732
master@{1}	origin/maint


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Derrick Stolee	2a53e0ba clone: add --sparse mode
builtin/clone.c
2a53e0ba 752) error(_("failed to initialize sparse-checkout"));
2a53e0ba 753) result = 1;
2a53e0ba 1138) return 1;

Derrick Stolee	71b11117 sparse-checkout: update working directory in-process
builtin/sparse-checkout.c
71b11117 79) die(_("You need to resolve your current index first"));
71b11117 82) return 0;
71b11117 327) clear_pattern_list(pl);
71b11117 328) update_working_directory(NULL);
71b11117 329) return result;

Derrick Stolee	f7fc70e0 sparse-checkout: create 'init' subcommand
builtin/sparse-checkout.c
f7fc70e0 130) error(_("failed to set extensions.worktreeConfig setting"));
f7fc70e0 131) return 1;
f7fc70e0 142) error(_("failed to enable core.sparseCheckout"));
f7fc70e0 143) return 1;
f7fc70e0 197) return 1;

Derrick Stolee	60fa6324 sparse-checkout: init and set in cone mode
builtin/sparse-checkout.c
60fa6324 155) error(_("failed to enable core.sparseCheckoutCone"));
60fa6324 156) return 1;
60fa6324 355) return;

Derrick Stolee	2e706347 sparse-checkout: write using lockfile
builtin/sparse-checkout.c
2e706347 325) rollback_lock_file(&lk);
2e706347 326) free(sparse_filename);

Derrick Stolee	f2882439 sparse-checkout: create 'disable' subcommand
builtin/sparse-checkout.c
f2882439 435) die(_("failed to change config"));
f2882439 444) die(_("error while refreshing working directory"));

Derrick Stolee	1e2b195d sparse-checkout: create builtin with 'list' subcommand
builtin/sparse-checkout.c
1e2b195d 480) usage_with_options(builtin_sparse_checkout_usage,

Derrick Stolee	4d4f1c19 sparse-checkout: use hashmaps for cone patterns
dir.c
4d4f1c19 656) pl->use_cone_patterns = 0;
4d4f1c19 657) warning(_("unrecognized pattern: '%s'"), given->pattern);
4d4f1c19 658) goto clear_hashmaps;
4d4f1c19 680) hashmap_add(&pl->parent_hashmap, &translated->ent);
4d4f1c19 681) hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
4d4f1c19 682) free(data);
4d4f1c19 683) return;
4d4f1c19 687) warning(_("unrecognized negative pattern: '%s'"),
4d4f1c19 689) goto clear_hashmaps;
4d4f1c19 703) warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
4d4f1c19 705) hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
4d4f1c19 706) free(data);
4d4f1c19 707) free(translated);

Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
read-cache.c
ee70c128 1745) if (advice_unknown_index_extension) {
ee70c128 1746) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1747) advise(_("This is likely due to the file having been written by a newer\n"

Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
protocol.c

remote-curl.c
6da1f1a9 354) return 0;

Matheus Tavares	beebb9d2 object-store: allow threaded access to object reading
packfile.c
beebb9d2 1464) return;

sha1-file.c
beebb9d2 1431) return;
beebb9d2 1440) return;

Rohit Ashiwal	1406adc0 rebase -i: add --ignore-whitespace flag
builtin/rebase.c
1406adc0 1904) die(_("cannot combine '--rebase-merges' with "

Rohit Ashiwal	7c5b2e1d sequencer: allow callers of read_author_script() to ignore fields
sequencer.c
7c5b2e1d 832) free(kv.items[name_i].util);
7c5b2e1d 836) free(kv.items[email_i].util);
7c5b2e1d 840) free(kv.items[date_i].util);

Rohit Ashiwal	ccafcb32 rebase -i: support --committer-date-is-author-date
sequencer.c
ccafcb32 884) static char *read_author_date_or_null(void)
ccafcb32 888) if (read_author_script(rebase_path_author_script(),
ccafcb32 890) return NULL;
ccafcb32 891) return date;
ccafcb32 983) int res = -1;
ccafcb32 984) struct strbuf datebuf = STRBUF_INIT;
ccafcb32 985) char *date = read_author_date_or_null();
ccafcb32 987) if (!date)
ccafcb32 988) return -1;
ccafcb32 990) strbuf_addf(&datebuf, "@%s", date);
ccafcb32 991) res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
ccafcb32 993) strbuf_release(&datebuf);
ccafcb32 994) free(date);
ccafcb32 996) if (res)
ccafcb32 997) return -1;
ccafcb32 1425) return error(_("malformed ident line"));
ccafcb32 1427) return error(_("corrupted author without date information"));
ccafcb32 2579) opts->allow_ff = 0;
ccafcb32 2580) opts->committer_date_is_author_date = 1;

Rohit Ashiwal	7258d3d1 rebase -i: support --ignore-date
sequencer.c
7258d3d1 902) error(_("malformed ident line"));
7258d3d1 903) return NULL;
7258d3d1 912) static void push_dates(struct child_process *child)
7258d3d1 914) time_t now = time(NULL);
7258d3d1 915) struct strbuf date = STRBUF_INIT;
7258d3d1 917) strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
7258d3d1 918) argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
7258d3d1 919) argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
7258d3d1 920) strbuf_release(&date);
7258d3d1 921) }
7258d3d1 1016) push_dates(&cmd);
7258d3d1 1485) res = -1;
7258d3d1 1486) goto out;
7258d3d1 2584) opts->allow_ff = 0;
7258d3d1 2585) opts->ignore_date = 1;
7258d3d1 3610) push_dates(&cmd);



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
James Coglan	fbccf255 graph: automatically track display width of graph lines
graph.c
fbccf255 904) graph_line_write_column(line, col, '|');

James Coglan	0195285b graph: rename `new_mapping` to `old_mapping`
graph.c
0195285b 421) REALLOC_ARRAY(graph->old_mapping, graph->column_capacity * 2);

Jeff King	86d0d4b8 fsck: don't require object structs for display functions
builtin/fsck.c
86d0d4b8 64) type = oid_object_info(the_repository, oid, NULL);
86d0d4b8 309) printf_ln(_("unreachable %s %s"),
86d0d4b8 310)   printable_type(&obj->oid, obj->type),
86d0d4b8 311)   describe_object(&obj->oid));
86d0d4b8 367) fprintf_ln(stderr, _("Checking %s"), describe_object(&obj->oid));
86d0d4b8 425)    printable_type(&obj->oid, obj->type),
86d0d4b8 426)    describe_object(&obj->oid));
86d0d4b8 439)   describe_object(&commit->object.oid));

Jeff King	2eec891d fsck: drop blob struct from fsck_finish()
fsck.c
2eec891d 1027) if (is_promisor_object(oid))

Jeff King	61506cb2 fsck: don't require an object struct for report()
fsck.c
61506cb2 980) return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
61506cb2 991) return report(options, &obj->oid, obj->type,
61506cb2 994)       obj->type);
61506cb2 1029) ret |= report(options,

Jeff King	315f8012 fsck: accept an oid instead of a "struct blob" for fsck_blob()
fsck.c
315f8012 958) return report(options, oid, OBJ_BLOB,

Jeff King	bcc2d814 fsck: accept an oid instead of a "struct tag" for fsck_tag()
fsck.c
bcc2d814 837) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
bcc2d814 841) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
bcc2d814 848) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
bcc2d814 853) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
bcc2d814 857) ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
bcc2d814 863) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
bcc2d814 868) ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");

Jeff King	0b0d2303 remember commit/tag parse failures
tag.c
0b0d2303 152) FREE_AND_NULL(item->tag);

Jeff King	8c95edfc fsck: accept an oid instead of a "struct commit" for fsck_commit()
fsck.c
8c95edfc 781) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
8c95edfc 783) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
8c95edfc 790) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
8c95edfc 804) err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
8c95edfc 810) return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");

Jeff King	8645f45b fsck: don't require an object struct in verify_headers()
fsck.c
8645f45b 717) return report(options, oid, type,

Jeff King	cd896131 fsck: accept an oid instead of a "struct tree" for fsck_tree()
fsck.c
cd896131 622) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
cd896131 669) retval += report(options, oid, OBJ_TREE, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
cd896131 671) retval += report(options, oid, OBJ_TREE, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
cd896131 679) retval += report(options, oid, OBJ_TREE, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
cd896131 681) retval += report(options, oid, OBJ_TREE, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
cd896131 685) retval += report(options, oid, OBJ_TREE, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");

Jeff King	a3f8d23c fsck: unify object-name code
fsck.c
a3f8d23c 517) error("Unknown object type for %s",

Jeff King	bfd15918 fsck: use oids rather than objects for object_name API
fsck.c
bfd15918 400) fsck_put_object_name(options, &entry.oid, "%s%s/",
bfd15918 469) fsck_put_object_name(options, oid, "%s^%d",
bfd15918 472) fsck_put_object_name(options, oid, "%.*s~%d",
bfd15918 495) fsck_put_object_name(options, &tag->tagged->oid, "%s", name);

Jeff King	c78fe004 parse_commit_buffer(): treat lookup_commit() failure as parse error
commit.c
c78fe004 466) return error("bad graft parent %s in commit %s",

Jeff King	9828df75 fsck: only provide oid/type in fsck_error callback
builtin/fsck.c
9828df75 125) BUG("%d (FSCK_IGNORE?) should never trigger this callback",

Jeff King	9f77fdad fsck: don't require an object struct for fsck_ident()
fsck.c
9f77fdad 733) return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
9f77fdad 740) return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
9f77fdad 744) return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
9f77fdad 750) return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
9f77fdad 754) return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
9f77fdad 762) return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");

Jeff King	78d50148 parse_tag_buffer(): treat NULL tag pointer as parse error
tag.c
78d50148 179) return error("unknown tag type '%s' in %s",



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
brian m. carlson	6f119424 remote-curl: pass on atomic capability to remote side
remote-curl.c
6f119424 155) else if (!strcmp(value, "false"))
6f119424 156) options.atomic = 0;
6f119424 158) return -1;

transport-helper.c
6f119424 859) die(_("helper %s does not support --atomic"), name);

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

Jeff King	d35b73c5 pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
d35b73c5 2847) allow_pack_reuse = git_config_bool(k, v);
d35b73c5 2848) return 0;

Jeff King	934b7d0a pack-bitmap: introduce bitmap_walk_contains()
pack-bitmap.c
934b7d0a 903) return 0;

Jonathan Tan	5374a290 fetch-pack: write fetched refs to .promisor
fetch-pack.c
5374a290 770) BUG("name of pack lockfile should end with .keep (was '%s')",

Phillip Wood	49697cb7 move run_commit_hook() to libgit and use it there
sequencer.c
49697cb7 1137) arg1 = "commit";
49697cb7 1138) arg2 = commit;

William Baker	3444ec2e fsmonitor: don't fill bitmap with entries to be removed
fsmonitor.c
3444ec2e 20) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
3444ec2e 59) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
3444ec2e 87) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
3444ec2e 256) BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Alex Henrie	baed6bbb diffcore-break: use a goto instead of a redundant if statement
diffcore-break.c
baed6bbb 295) diff_q(&outq, p);

Ali Utku Selen	ddb3c856 shallow.c: don't free unallocated slabs
shallow.c
ddb3c856 157) continue;

Bert Wesarg	edefc318 format-patch: create leading components of output directory
builtin/log.c
edefc318 1785) die(_("could not create leading directories "

Brandon Casey	040a6551 cleanup: use internal memory allocation wrapper functions everywhere
stable-qsort.c
040a6551 58) char *tmp = xmalloc(size);

Brian Downing	43fe901b compat: Add simplified merge sort implementation from glibc
stable-qsort.c
43fe901b 59) msort_with_tmp(b, n, s, cmp, tmp);
43fe901b 60) free(tmp);

brian m. carlson	7e0d029f builtin/rev-parse: switch to use the_hash_algo
builtin/rev-parse.c
7e0d029f 735) abbrev = hexsz;

brian m. carlson	8d4d86b0 cache: remove null_sha1
builtin/submodule--helper.c
8d4d86b0 427) printf("%06o %s U\t", ce->ce_mode, oid_to_hex(&null_oid));

brian m. carlson	ce17feb1 path: add a function to check for path suffix
path.c
ce17feb1 1234) return -1;
ce17feb1 1238) return -1;
ce17feb1 1247) return -1;

brian m. carlson	28ba1830 builtin/replace: make hash size independent
builtin/replace.c
28ba1830 275) if (strbuf_read(&result, cmd.out, the_hash_algo->hexsz + 1) < 0) {

brian m. carlson	fabec2c5 builtin/receive-pack: switch to use the_hash_algo
builtin/receive-pack.c
fabec2c5 433) the_hash_algo->init_fn(&ctx);
fabec2c5 434) the_hash_algo->update_fn(&ctx, key_in, key_len);
fabec2c5 435) the_hash_algo->final_fn(key, &ctx);

Christian Couder	faf2abf4 promisor-remote: use repository_format_partial_clone
promisor-remote.c
faf2abf4 95) if (previous)
faf2abf4 96) previous->next = r->next;
faf2abf4 98) promisors = r->next ? r->next : r;
faf2abf4 99) r->next = NULL;
faf2abf4 100) *promisors_tail = r;
faf2abf4 101) promisors_tail = &r->next;

Christian Couder	9e27beaa promisor-remote: implement promisor_remote_get_direct()
promisor-remote.c
9e27beaa 205) static int remove_fetched_oids(struct repository *repo,
9e27beaa 209) int i, remaining_nr = 0;
9e27beaa 210) int *remaining = xcalloc(oid_nr, sizeof(*remaining));
9e27beaa 211) struct object_id *old_oids = *oids;
9e27beaa 214) for (i = 0; i < oid_nr; i++)
9e27beaa 215) if (oid_object_info_extended(repo, &old_oids[i], NULL,
9e27beaa 217) remaining[i] = 1;
9e27beaa 218) remaining_nr++;
9e27beaa 221) if (remaining_nr) {
9e27beaa 222) int j = 0;
9e27beaa 223) new_oids = xcalloc(remaining_nr, sizeof(*new_oids));
9e27beaa 224) for (i = 0; i < oid_nr; i++)
9e27beaa 225) if (remaining[i])
9e27beaa 226) oidcpy(&new_oids[j++], &old_oids[i]);
9e27beaa 227) *oids = new_oids;
9e27beaa 228) if (to_free)
9e27beaa 229) free(old_oids);
9e27beaa 232) free(remaining);
9e27beaa 234) return remaining_nr;
9e27beaa 251) if (remaining_nr == 1)
9e27beaa 252) continue;
9e27beaa 253) remaining_nr = remove_fetched_oids(repo, &remaining_oids,
9e27beaa 255) if (remaining_nr) {
9e27beaa 256) to_free = 1;
9e27beaa 257) continue;
9e27beaa 265) free(remaining_oids);

Christian Couder	4ca9474e Move core_partial_clone_filter_default to promisor-remote.c
promisor-remote.c
4ca9474e 111) return git_config_string(&core_partial_clone_filter_default,

Christian Couder	b14ed5ad Use promisor_remote_get_direct() and has_promisor_remote()
builtin/cat-file.c
b14ed5ad 529) warning("This repository uses promisor remotes. Some objects may not be loaded.");

Christian Couder	fa3d1b63 promisor-remote: parse remote.*.partialclonefilter
promisor-remote.c
fa3d1b63 142) return 0;

Christian Couder	48de3158 Add initial support for many promisor remotes
promisor-remote.c
48de3158 61) warning(_("promisor remote name cannot begin with '/': %s"),
48de3158 63) return NULL;

Christian Couder	db27dca5 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
promisor-remote.c
db27dca5 25) die(_("Remote with no URL"));

Corentin BOMPARD	24bc1a12 pull, fetch: add --set-upstream option
builtin/fetch.c
24bc1a12 1429) warning(_("not setting upstream for a remote remote-tracking branch"));

Denton Liu	2b318aa6 rebase: refactor can_fast_forward into goto tower
builtin/rebase.c
2b318aa6 1273) goto done;

Denton Liu	c0efb4c1 rebase: fast-forward --onto in more cases
builtin/rebase.c
c0efb4c1 1289) goto done;

Derrick Stolee	50f26bd0 fetch: add fetch.writeCommitGraph config setting
repo-settings.c
50f26bd0 57) UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);

Derrick Stolee	aaf633c2 repo-settings: create feature.experimental setting
fetch-pack.c
aaf633c2 913) else if (args->depth > 0 || is_repository_shallow(r))

repo-settings.c
aaf633c2 43) r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
aaf633c2 55) UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
aaf633c2 56) UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);

Elijah Newren	65c01c64 checkout: provide better conflict hunk description with detached HEAD
builtin/checkout.c
65c01c64 766) strbuf_add_unique_abbrev(&old_commit_shortname,
65c01c64 767)  &old_branch_info->commit->object.oid,
65c01c64 769) o.ancestor = old_commit_shortname.buf;

Elijah Newren	941790d7 fast-export: handle nested tags
builtin/fast-export.c
941790d7 852) die(_("Error: Cannot export nested tags unless --mark-tags is specified."));
941790d7 864) tagged_mark = get_object_mark(tagged);

Elijah Newren	89a1f4aa dir: if our pathspec might match files under a dir, recurse into it
dir.c
89a1f4aa 374) return MATCHED_RECURSIVELY_LEADING_PATHSPEC;

Elijah Newren	b8f50e5b fast-import: add support for new 'alias' command
fast-import.c
b8f50e5b 2528) die("Invalid ref name or SHA1 expression: %s", objectish);
b8f50e5b 2554) return 0;
b8f50e5b 3118) die(_("Expected 'mark' command, got %s"), command_buf.buf);
b8f50e5b 3123) die(_("Expected 'to' command, got %s"), command_buf.buf);

Elijah Newren	3164e6bd fast-import: fix handling of deleted tags
fast-import.c
3164e6bd 2835) first_tag = t->next_tag;

Elijah Newren	ff1bfa2c merge-recursive: use common name for ancestors/common/base_list
merge-recursive.c
ff1bfa2c 3757)    oid_to_hex(merge_bases[i]));

Elijah Newren	98a1d3d8 merge-recursive: exit early if index != head
merge-recursive.c
98a1d3d8 3692) return -1;

Elijah Newren	208d6924 fast-export: add support for --import-marks-if-exists
builtin/fast-export.c
208d6924 1220) die(_("Cannot pass both --import-marks and --import-marks-if-exists"));

Elijah Newren	9822175d Ensure index matches head before invoking merge machinery, round N
builtin/merge-recursive.c
9822175d 68) die_resolve_conflict("merge");

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

Elijah Newren	f836bf39 merge-recursive: future-proof update_file_flags() against memory leaks
merge-recursive.c
f836bf39 960) ret = err(opt, _("cannot read object %s '%s'"),
f836bf39 962) goto free_buf;

Eric Wong	c8e424c9 hashmap: introduce hashmap_free_entries
t/helper/test-hashmap.c
c8e424c9 113) hashmap_free(&map);
c8e424c9 133) hashmap_free(&map);

Eric Wong	b94e5c1d hashmap_add takes "struct hashmap_entry *"
t/helper/test-hashmap.c
b94e5c1d 110) hashmap_add(&map, &entries[i]->ent);
b94e5c1d 123) hashmap_add(&map, &entries[i]->ent);

Eric Wong	87571c3f hashmap: use *_entry APIs for iteration
t/helper/test-lazy-init-name-hash.c
87571c3f 44) hashmap_for_each_entry(&the_index.dir_hash, &iter_dir, dir,
87571c3f 48) hashmap_for_each_entry(&the_index.name_hash, &iter_cache, ce,

Eric Wong	d22245a2 hashmap_entry_init takes "struct hashmap_entry *"
t/helper/test-hashmap.c
d22245a2 109) hashmap_entry_init(&entries[i]->ent, hashes[i]);
d22245a2 122) hashmap_entry_init(&entries[i]->ent, hashes[i]);

Eric Wong	28ee7941 hashmap_remove takes "const struct hashmap_entry *"
name-hash.c
28ee7941 100) hashmap_remove(&istate->dir_hash, &dir->ent, NULL);

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

Jeff King	5aa02f98 tree-walk: harden make_traverse_path() length computations
tree-walk.c
5aa02f98 194) BUG("too small buffer passed to make_traverse_path");
5aa02f98 199) BUG("traverse_info pathlen does not match strings");
5aa02f98 208) BUG("traverse_info ran out of list items");

Jeff King	9827d4c1 packfile: drop release_pack_memory()
wrapper.c
9827d4c1 31) die("Out of memory, strdup failed");
9827d4c1 45) if (!gentle)
9827d4c1 46) die("Out of memory, malloc failed (tried to allocate %lu bytes)",
9827d4c1 49) error("Out of memory, malloc failed (tried to allocate %lu bytes)",
9827d4c1 51) return NULL;
9827d4c1 117) die("Out of memory, realloc failed");
9827d4c1 133) die("Out of memory, calloc failed");

Jeff King	fbab552a commit-graph: bump DIE_ON_LOAD check to actual load-time
commit-graph.c
fbab552a 483) die("dying as requested by the '%s' variable on commit-graph load!",

Jeff King	90553847 tree-walk: drop oid from traverse_info
unpack-trees.c
90553847 1144) if (*info->prev->name)
90553847 1147) printf("%s", info->name);

Jeff King	3a37876b pack-objects: drop packlist index_pos optimization
pack-objects.c
3a37876b 185) BUG("duplicate object inserted into hash");

Jeff King	0dfed92d git-am: handle missing "author" when parsing commit
builtin/am.c
0dfed92d 1262) die(_("missing author line in commit %s"),
0dfed92d 1263)       oid_to_hex(&commit->object.oid));

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

Johannes Schindelin	e145d993 rebase -r: support merge strategies other than `recursive`
sequencer.c
e145d993 3306) (!opts->strategy || !strcmp(opts->strategy, "recursive")) ?

Johannes Schindelin	e2683d51 Fix .git/ discovery at the root of UNC shares
setup.c
e2683d51 952)     !is_dir_sep(dir->buf[min_offset - 1])) {
e2683d51 953) strbuf_addch(dir, '/');
e2683d51 954) min_offset++;

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

Matthew DeVore	cf9ceb5a list-objects-filter-options: make filter_spec a string_list
list-objects-filter-options.c
cf9ceb5a 276) BUG("no filter_spec available for this filter");

upload-pack.c
cf9ceb5a 148) sq_quote_buf(&buf, spec);

Matthew DeVore	f56f7642 list-objects-filter-options: move error check up
list-objects-filter-options.c
f56f7642 44) BUG("filter_options already populated");
f56f7642 226) die(_("multiple filter-specs cannot be combined"));

Matthew DeVore	9430147c list-objects-filter: encapsulate filter components
list-objects.c
9430147c 210) ctx->show_object(obj, base->buf, ctx->show_data);

Matthew DeVore	e987df5f list-objects-filter: implement composite filters
list-objects-filter-options.c
e987df5f 311) return;

list-objects-filter.c
e987df5f 594) BUG("expected oidset to be cleared already");

Mischa POSLAWSKY	8b3f33ef ref-filter: initialize empty name or email fields
ref-filter.c
8b3f33ef 1045) return xstrdup("");

Phillip Wood	a47ba3c7 rebase -i: check for updated todo after squash and reword
sequencer.c
a47ba3c7 3917) res = error_errno(_("could not stat '%s'"),
a47ba3c7 3923) res = -1; /* message was printed */

René Scharfe	1fd881d4 trace2: use warning() directly in tr2_dst_malformed_warning()
trace2/tr2_dst.c
1fd881d4 307) warning("trace2: unknown value for '%s': '%s'",

René Scharfe	dad3f060 tag: factor out get_tagged_oid()
pack-bitmap.c
dad3f060 712) object = parse_object_or_die(get_tagged_oid(tag), NULL);

René Scharfe	5cc6a4be http-push: simplify deleting a list item
http-push.c
5cc6a4be 984) prev->next = lock->next;

René Scharfe	59fa5f5a sha1-name: check for overflow of N in "foo^N" and "foo~N"
sha1-name.c
59fa5f5a 1172) return MISSING_OBJECT;
59fa5f5a 1178) return MISSING_OBJECT;

René Scharfe	71d41ff6 archive-tar: turn length miscalculation warning into BUG
archive-tar.c
71d41ff6 161) BUG("pax extended header length miscalculated as %"PRIuMAX

SZEDER Gábor	2bb74b53 Test the progress display
t/helper/test-progress.c
2bb74b53 48) die("need a title for the progress output");
2bb74b53 59) die("invalid input: '%s'\n", line.buf);
2bb74b53 67) die("invalid input: '%s'\n", line.buf);
2bb74b53 70) die("invalid input: '%s'\n", line.buf);

Thomas Gummerer	34933d0e stash: make sure to write refreshed cache
builtin/stash.c
34933d0e 1139) ret = -1;
34933d0e 1140) goto done;

Thomas Gummerer	8e4c8af0 push: disallow --all and refspecs when remote.<name>.mirror is set
builtin/push.c
8e4c8af0 611) die(_("bad repository '%s'"), repo);
8e4c8af0 627) die(_("--all and --tags are incompatible"));
8e4c8af0 629) die(_("--all can't be combined with refspecs"));
8e4c8af0 633) die(_("--mirror and --tags are incompatible"));
8e4c8af0 638) die(_("--all and --mirror are incompatible"));

Thomas Gummerer	22184497 factor out refresh_and_write_cache function
builtin/am.c
22184497 1695) die(_("unable to write index file"));

read-cache.c
22184497 1487) return -1;
22184497 1491) ret = -1;

Torsten Bögershausen	ebb8d2c9 mingw: support UNC in git clone file://server/share/repo
connect.c
ebb8d2c9 921) path = host - 2; /* include the leading "//" */


