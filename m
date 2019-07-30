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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CBF21F462
	for <e@80x24.org>; Tue, 30 Jul 2019 13:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfG3NFl (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 09:05:41 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33434 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfG3NFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 09:05:40 -0400
Received: by mail-qk1-f172.google.com with SMTP id r6so46534559qkc.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6b3XIlmceEmraGF1rodR2RxZyDlfMvZ/ocz6VnUOHuY=;
        b=Bm+N2laGbTVMF1z75DKqMc38kG4ZpYEGoAEE4TnTFDSYuWHmKrjVEHmYrG/Fyh32ON
         vwXoUdlFYTmtnd/KAMjDwIfRma9e/FaaJbDXa0qjD4IgXbYEeZ7q0Tm/WgRHwFtKxmTY
         6BeLP4eM1vpwAH3H0P8llcXNSxXpdmYUDTREJaCfmn94r6o1swcCWwovOk6ziZ6tqhkZ
         GViwLw1OwWFTHItmsm2yZiPiYy8HtcdUI2gAZvi6Iz7XUD217/bfzK20WeOkwV+BYPTy
         WZfDHEGDpwMxANbC0NhWqnPzQtGjypvTrJ5SBShnPUaqaLoP6joRCNbWB6M8oljl2Ioc
         V0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6b3XIlmceEmraGF1rodR2RxZyDlfMvZ/ocz6VnUOHuY=;
        b=rvAfwVulZ2ZmxF8JeeXzT0EZfuvPDDi/dkmJBZWuMXSD7slOrgBf24VHkECwZBzysp
         OpNXoyagLjtBEtW+Ivup7mxUCGZp9qVb2/Cc06kLs1XQTTZ5C+YGEatwm3PNVZ2N8ysM
         taekvGtugVncX/mAtg326Vby+RHPxU2l/7d2GWyZ3F6fyaf3jV1gk1Q64q0FEq5xG+fU
         bOKwznbOwLSpdkV5LGZe6ms52uv7E1sloh+aQ9VJ3ph6PlDE45JmOf4TDMIXGi9MIlYV
         9FEqJt8CW7vjZJw25h80JEl0C/E/+p8AUcqxtdT8s/by+mwBXIaPrBVHUT8EaHphEfqN
         fh+w==
X-Gm-Message-State: APjAAAVjzyLe7zxjmW85KelYMTiAgJ6iQUiFIcyX3Haa4Ov7mlEo3B21
        eYE/ypmW6LIbCrnGkcJfM3AF9cDc
X-Google-Smtp-Source: APXvYqw+DD6x82oekKBt+cyzh7i1HjFjW0Yrc/uy7FBf4GxP+MtzZt4KhIgjpEfyazFSQogBpjj4Lw==
X-Received: by 2002:a37:5d87:: with SMTP id r129mr43596462qkb.388.1564491938027;
        Tue, 30 Jul 2019 06:05:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9049:226e:5210:8681? ([2001:4898:a800:1012:417d:226e:5210:8681])
        by smtp.gmail.com with ESMTPSA id q3sm28550372qkq.133.2019.07.30.06.05.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 06:05:37 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Tues. July 30)
Message-ID: <5ef69d4a-185a-ab19-f3fe-3889137843e6@gmail.com>
Date:   Tue, 30 Jul 2019 09:05:36 -0400
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

Here is today's test coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-07-30.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-07-30.txt

---

pu	fb32a9d64339806dc739b6bb31cfd2c975625636
jch	bef7796fdcfab7f3792366a5674796b886736576
next	4dedae46a21fbd9d3232915177485ac88f42884f
master	026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
master@{1}	9c9b961d7eb15fb583a2a812088713a68a85f1c0


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

builtin/fetch-pack.c

builtin/pack-objects.c
820a5361 859) BUG("configured exclusion wasn't configured");
820a5361 2794) die(_("value of uploadpack.blobpackfileuri must be "
820a5361 2797) die(_("object already configured in another "

builtin/rebase.c
f970f23b 388) strbuf_addstr(&buf, opts->strategy_opts);
6d5546c6 545) opts.flags |= REBASE_FORCE;
526c03b5 1302) goto done;
10572de1 1318) goto done;
f970f23b 1896) die(_("cannot combine '--rebase-merges' with "

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

fetch-pack.c
820a5361 1397) die("expected '<hash> <uri>', got: %s\n", reader->line);
820a5361 1402) die("expected DELIM");
820a5361 1529) die("fetch-pack: unable to spawn http-fetch");
820a5361 1533) die("fetch-pack: expected keep then TAB at start of http-fetch output");
820a5361 1538) die("fetch-pack: expected hash then LF at end of http-fetch output");
820a5361 1545) die("fetch-pack: unable to finish http-fetch");
820a5361 1549) die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
820a5361 1550)     uri, (int) the_hash_algo->hexsz,
820a5361 1551)     packfile_uris.items[i].string);

http-fetch.c

http.c
f9872202 2304) target ? hash_to_hex(target->hash) : base_url,

protocol.c

remote-curl.c

sequencer.c
968a7a61 840) free(kv.items[date_i].util);
6d5546c6 890) die(_("failed to read author date"));
6d5546c6 1007) char *date = read_author_date_or_die();
6d5546c6 1008) setenv("GIT_COMMITTER_DATE", date, 1);
6d5546c6 1009) free(date);
6d5546c6 1046) char *date = read_author_date_or_die();
6d5546c6 1047) argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s", date);
6d5546c6 1048) free(date);
6d5546c6 3601) char *date = read_author_date_or_die();
6d5546c6 3602) argv_array_pushf(&cmd.env_array,
6d5546c6 3604) free(date);

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 354) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1387) string_list_clear(&data->uri_protocols, 0);

wrapper.c

Commits introducting uncovered code:
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Junio C Hamano	f9872202 Merge branch 'jt/fetch-cdn-offload' into pu
Rohit Ashiwal	f970f23b rebase -i: add --ignore-whitespace flag
Rohit Ashiwal	6d5546c6 rebase -i: support --committer-date-is-author-date
Rohit Ashiwal	968a7a61 sequencer: add NULL checks under read_author_script


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

add-interactive.c
d31f31d1 20) static void init_color(struct repository *r, struct add_i_state *s,
d31f31d1 24) char *key = xstrfmt("color.interactive.%s", slot_name);
d31f31d1 27) if (!s->use_color)
d31f31d1 28) dst[0] = '\0';
d31f31d1 29) else if (repo_config_get_value(r, key, &value) ||
d31f31d1 30)  color_parse(value, dst))
d31f31d1 31) strlcpy(dst, default_color, COLOR_MAXLEN);
d31f31d1 33) free(key);
d31f31d1 34) }
d31f31d1 36) static int init_add_i_state(struct repository *r, struct add_i_state *s)
d31f31d1 40) s->r = r;
d31f31d1 42) if (repo_config_get_value(r, "color.interactive", &value))
d31f31d1 43) s->use_color = -1;
d31f31d1 45) s->use_color =
d31f31d1 46) git_config_colorbool("color.interactive", value);
d31f31d1 47) s->use_color = want_color(s->use_color);
d31f31d1 49) init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
ec4ddbf6 50) init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
253cdc20 51) init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
253cdc20 52) init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
253cdc20 53) init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
d31f31d1 55) return 0;
928e9d0d 58) static ssize_t find_unique(const char *string,
928e9d0d 61) ssize_t found = -1, i;
928e9d0d 63) for (i = 0; i < nr; i++) {
928e9d0d 64) struct prefix_item *item = list[i];
928e9d0d 65) if (!starts_with(item->name, string))
928e9d0d 66) continue;
928e9d0d 67) if (found >= 0)
928e9d0d 68) return -1;
928e9d0d 69) found = i;
928e9d0d 72) return found;
928e9d0d 83) static void list(struct prefix_item **list, size_t nr,
81e604c5 86) int i, last_lf = 0;
bcbdcd36 88) if (!nr)
bcbdcd36 89) return;
bcbdcd36 91) if (opts->header)
d31f31d1 92) color_fprintf_ln(stdout, s->header_color,
bcbdcd36 95) for (i = 0; i < nr; i++) {
bcbdcd36 96) opts->print_item(i, list[i], opts->print_item_data);
81e604c5 98) if ((opts->columns) && ((i + 1) % (opts->columns))) {
81e604c5 99) putchar('\t');
81e604c5 100) last_lf = 0;
81e604c5 103) putchar('\n');
81e604c5 104) last_lf = 1;
81e604c5 108) if (!last_lf)
bcbdcd36 109) putchar('\n');
928e9d0d 127) static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
81e604c5 131) struct strbuf input = STRBUF_INIT;
81e604c5 132) ssize_t res = LIST_AND_CHOOSE_ERROR;
928e9d0d 134) find_unique_prefixes(items, nr, 1, 4);
81e604c5 139) strbuf_reset(&input);
81e604c5 141) list(items, nr, s, &opts->list_opts);
253cdc20 143) color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
253cdc20 144) fputs("> ", stdout);
81e604c5 145) fflush(stdout);
81e604c5 147) if (strbuf_getline(&input, stdin) == EOF) {
81e604c5 148) putchar('\n');
81e604c5 149) res = LIST_AND_CHOOSE_QUIT;
81e604c5 150) break;
81e604c5 152) strbuf_trim(&input);
81e604c5 154) if (!input.len)
81e604c5 155) break;
ec4ddbf6 157) if (!strcmp(input.buf, "?")) {
ec4ddbf6 158) opts->print_help(s);
ec4ddbf6 159) continue;
81e604c5 162) p = input.buf;
81e604c5 164) size_t sep = strcspn(p, " \t\r\n,");
81e604c5 165) ssize_t index = -1;
81e604c5 167) if (!sep) {
81e604c5 168) if (!*p)
81e604c5 169) break;
81e604c5 170) p++;
81e604c5 171) continue;
81e604c5 174) if (isdigit(*p)) {
81e604c5 175) index = strtoul(p, &endp, 10) - 1;
81e604c5 176) if (endp != p + sep)
81e604c5 177) index = -1;
81e604c5 180) p[sep] = '\0';
928e9d0d 181) if (index < 0)
928e9d0d 182) index = find_unique(p, items, nr);
81e604c5 184) if (index < 0 || index >= nr)
253cdc20 185) color_fprintf_ln(stdout, s->error_color,
81e604c5 188) res = index;
81e604c5 189) break;
81e604c5 192) p += sep + 1;
81e604c5 193) }
81e604c5 195) if (res != LIST_AND_CHOOSE_ERROR)
81e604c5 196) break;
bcbdcd36 197) }
81e604c5 199) strbuf_release(&input);
81e604c5 200) return res;
bcbdcd36 216) static void add_file_item(struct file_list *list, const char *name)
bcbdcd36 220) FLEXPTR_ALLOC_STR(item, item.name, name);
bcbdcd36 222) ALLOC_GROW(list->file, list->nr + 1, list->alloc);
bcbdcd36 223) list->file[list->nr++] = item;
bcbdcd36 224) }
bcbdcd36 226) static void reset_file_list(struct file_list *list)
bcbdcd36 230) for (i = 0; i < list->nr; i++)
bcbdcd36 231) free(list->file[i]);
bcbdcd36 232) list->nr = 0;
bcbdcd36 233) }
bcbdcd36 235) static void release_file_list(struct file_list *list)
bcbdcd36 237) reset_file_list(list);
bcbdcd36 238) FREE_AND_NULL(list->file);
bcbdcd36 239) list->alloc = 0;
bcbdcd36 240) }
bcbdcd36 242) static int file_item_cmp(const void *a, const void *b)
bcbdcd36 244) const struct file_item * const *f1 = a;
bcbdcd36 245) const struct file_item * const *f2 = b;
bcbdcd36 247) return strcmp((*f1)->item.name, (*f2)->item.name);
bcbdcd36 256) static int pathname_entry_cmp(const void *unused_cmp_data,
bcbdcd36 260) const struct pathname_entry *e1 = entry, *e2 = entry_or_key;
bcbdcd36 262) return strcmp(e1->pathname,
bcbdcd36 275) static void collect_changes_cb(struct diff_queue_struct *q,
bcbdcd36 279) struct collection_status *s = data;
bcbdcd36 280) struct diffstat_t stat = { 0 };
bcbdcd36 283) if (!q->nr)
bcbdcd36 284) return;
bcbdcd36 286) compute_diffstat(options, &stat, q);
bcbdcd36 288) for (i = 0; i < stat.nr; i++) {
bcbdcd36 289) const char *name = stat.files[i]->name;
bcbdcd36 290) int hash = strhash(name);
bcbdcd36 296) entry = hashmap_get_from_hash(&s->file_map, hash, name);
bcbdcd36 297) if (entry)
bcbdcd36 298) file_index = entry->index;
bcbdcd36 300) FLEX_ALLOC_STR(entry, pathname, name);
bcbdcd36 301) hashmap_entry_init(entry, hash);
bcbdcd36 302) entry->index = file_index = s->list->nr;
bcbdcd36 303) hashmap_add(&s->file_map, entry);
bcbdcd36 305) add_file_item(s->list, name);
bcbdcd36 307) file = s->list->file[file_index];
bcbdcd36 309) adddel = s->phase == FROM_INDEX ? &file->index : &file->worktree;
bcbdcd36 310) adddel->seen = 1;
bcbdcd36 311) adddel->add = stat.files[i]->added;
bcbdcd36 312) adddel->del = stat.files[i]->deleted;
bcbdcd36 313) if (stat.files[i]->is_binary)
bcbdcd36 314) adddel->binary = 1;
bcbdcd36 318) static int get_modified_files(struct repository *r, struct file_list *list,
bcbdcd36 322) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
bcbdcd36 324) struct collection_status s = { FROM_WORKTREE };
bcbdcd36 326) if (repo_read_index_preload(r, ps, 0) < 0)
bcbdcd36 327) return error(_("could not read index"));
bcbdcd36 329) s.list = list;
bcbdcd36 330) hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
bcbdcd36 332) for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
bcbdcd36 334) struct setup_revision_opt opt = { 0 };
bcbdcd36 336) opt.def = is_initial ?
bcbdcd36 337) empty_tree_oid_hex() : oid_to_hex(&head_oid);
bcbdcd36 339) init_revisions(&rev, NULL);
bcbdcd36 340) setup_revisions(0, NULL, &rev, &opt);
bcbdcd36 342) rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
bcbdcd36 343) rev.diffopt.format_callback = collect_changes_cb;
bcbdcd36 344) rev.diffopt.format_callback_data = &s;
bcbdcd36 346) if (ps)
bcbdcd36 347) copy_pathspec(&rev.prune_data, ps);
bcbdcd36 349) if (s.phase == FROM_INDEX)
bcbdcd36 350) run_diff_index(&rev, 1);
bcbdcd36 352) rev.diffopt.flags.ignore_dirty_submodules = 1;
bcbdcd36 353) run_diff_files(&rev, 0);
bcbdcd36 356) hashmap_free(&s.file_map, 1);
bcbdcd36 359) QSORT(list->file, list->nr, file_item_cmp);
bcbdcd36 361) return 0;
bcbdcd36 364) static void populate_wi_changes(struct strbuf *buf,
bcbdcd36 367) if (ad->binary)
bcbdcd36 368) strbuf_addstr(buf, _("binary"));
bcbdcd36 369) else if (ad->seen)
bcbdcd36 370) strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
bcbdcd36 371)     (uintmax_t)ad->add, (uintmax_t)ad->del);
bcbdcd36 373) strbuf_addstr(buf, no_changes);
bcbdcd36 374) }
928e9d0d 377) static int is_valid_prefix(const char *prefix, size_t prefix_len)
928e9d0d 379) return prefix_len && prefix &&
928e9d0d 385) strcspn(prefix, " \t\r\n,") >= prefix_len &&	/* separators */
928e9d0d 386) *prefix != '-' &&				/* deselection */
928e9d0d 387) !isdigit(*prefix) &&				/* selection */
928e9d0d 388) (prefix_len != 1 ||
928e9d0d 389)  (*prefix != '*' &&				/* "all" wildcard */
928e9d0d 390)   *prefix != '?'));				/* prompt help */
928e9d0d 398) static void print_file_item(int i, struct prefix_item *item,
bcbdcd36 401) struct file_item *c = (struct file_item *)item;
bcbdcd36 402) struct print_file_item_data *d = print_file_item_data;
bcbdcd36 404) strbuf_reset(&d->index);
bcbdcd36 405) strbuf_reset(&d->worktree);
bcbdcd36 406) strbuf_reset(&d->buf);
bcbdcd36 408) populate_wi_changes(&d->worktree, &c->worktree, _("nothing"));
bcbdcd36 409) populate_wi_changes(&d->index, &c->index, _("unchanged"));
bcbdcd36 410) strbuf_addf(&d->buf, d->modified_fmt,
bcbdcd36 413) printf(" %2d: %s", i + 1, d->buf.buf);
bcbdcd36 414) }
d31f31d1 416) static int run_status(struct add_i_state *s, const struct pathspec *ps,
bcbdcd36 419) reset_file_list(files);
d31f31d1 421) if (get_modified_files(s->r, files, ps) < 0)
bcbdcd36 422) return -1;
bcbdcd36 424) if (files->nr)
928e9d0d 425) list((struct prefix_item **)files->file, files->nr, s, opts);
bcbdcd36 426) putchar('\n');
bcbdcd36 428) return 0;
f3665cfd 431) static int run_help(struct add_i_state *s, const struct pathspec *ps,
f3665cfd 434) const char *help_color = s->help_color;
f3665cfd 436) color_fprintf_ln(stdout, help_color, "status        - %s",
f3665cfd 438) color_fprintf_ln(stdout, help_color, "update        - %s",
f3665cfd 440) color_fprintf_ln(stdout, help_color, "revert        - %s",
f3665cfd 442) color_fprintf_ln(stdout, help_color, "patch         - %s",
f3665cfd 444) color_fprintf_ln(stdout, help_color, "diff          - %s",
f3665cfd 446) color_fprintf_ln(stdout, help_color, "add untracked - %s",
f3665cfd 449) return 0;
928e9d0d 456) static void print_command_item(int i, struct prefix_item *item,
253cdc20 459) struct print_command_item_data *d = print_command_item_data;
928e9d0d 461) if (!item->prefix_length ||
928e9d0d 462)     !is_valid_prefix(item->name, item->prefix_length))
928e9d0d 463) printf(" %2d: %s", i + 1, item->name);
253cdc20 465) printf(" %2d: %s%.*s%s%s", i + 1,
253cdc20 466)        d->color, (int)item->prefix_length, item->name, d->reset,
928e9d0d 467)        item->name + item->prefix_length);
81e604c5 468) }
ec4ddbf6 476) static void command_prompt_help(struct add_i_state *s)
ec4ddbf6 478) const char *help_color = s->help_color;
ec4ddbf6 479) color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
ec4ddbf6 480) color_fprintf_ln(stdout, help_color, "1          - %s",
ec4ddbf6 482) color_fprintf_ln(stdout, help_color, "foo        - %s",
ec4ddbf6 484) color_fprintf_ln(stdout, help_color, "           - %s",
ec4ddbf6 486) }
db07a815 488) int run_add_i(struct repository *r, const struct pathspec *ps)
d31f31d1 490) struct add_i_state s = { NULL };
81e604c5 492) struct list_and_choose_options main_loop_opts = {
f3665cfd 497) status = { { "status" }, run_status },
f3665cfd 498) help = { { "help" }, run_help };
81e604c5 499) struct command_item *commands[] = {
bcbdcd36 504) struct print_file_item_data print_file_item_data = {
bcbdcd36 507) struct list_options opts = {
bcbdcd36 510) struct strbuf header = STRBUF_INIT;
bcbdcd36 511) struct file_list files = { NULL };
bcbdcd36 513) int res = 0;
d31f31d1 515) if (init_add_i_state(r, &s))
d31f31d1 516) return error("could not parse `add -i` config");
253cdc20 522) if (s.use_color) {
253cdc20 523) data.color = s.prompt_color;
253cdc20 524) data.reset = s.reset_color;
253cdc20 526) data.color = "[";
253cdc20 527) data.reset = "]";
bcbdcd36 530) strbuf_addstr(&header, "      ");
bcbdcd36 531) strbuf_addf(&header, print_file_item_data.modified_fmt,
bcbdcd36 533) opts.header = header.buf;
74265dd7 535) repo_refresh_and_write_index(r, REFRESH_QUIET, 1);
d31f31d1 536) if (run_status(&s, ps, &files, &opts) < 0)
74265dd7 537) res = -1;
928e9d0d 540) i = list_and_choose((struct prefix_item **)commands,
81e604c5 542) if (i == LIST_AND_CHOOSE_QUIT) {
81e604c5 543) printf(_("Bye.\n"));
81e604c5 544) res = 0;
81e604c5 545) break;
81e604c5 547) if (i != LIST_AND_CHOOSE_ERROR)
81e604c5 548) res = commands[i]->command(&s, ps, &files, &opts);
81e604c5 549) }
bcbdcd36 551) release_file_list(&files);
bcbdcd36 552) strbuf_release(&print_file_item_data.buf);
bcbdcd36 553) strbuf_release(&print_file_item_data.index);
bcbdcd36 554) strbuf_release(&print_file_item_data.worktree);
bcbdcd36 555) strbuf_release(&header);
bcbdcd36 557) return res;

builtin/add.c
db07a815 196) return !!run_add_i(the_repository, pathspec);

builtin/cat-file.c
b14ed5ad 529) warning("This repository uses promisor remotes. Some objects may not be loaded.");

builtin/ls-files.c
272b3f2a 672) die(_("--debug-json cannot be used with other file selection options"));
272b3f2a 674) die(_("--debug-json cannot be used with %s"), "--resolve-undo");
272b3f2a 676) die(_("--debug-json cannot be used with %s"), "--with-tree");
272b3f2a 678) die(_("--debug-json cannot be used with %s"), "--debug");
272b3f2a 701) die("index file corrupt");

builtin/rev-list.c
cf9ceb5a 476) die(

cache-tree.c
fd335a21 606) ret = NULL; /* not the whole tree */

dir.c
3b2385cf 2840) static void jw_object_untracked_cache_dir(struct json_writer *jw,
3b2385cf 2845) jw_object_bool(jw, "valid", ucd->valid);
3b2385cf 2846) jw_object_bool(jw, "check-only", ucd->check_only);
3b2385cf 2847) jw_object_stat_data(jw, "stat", &ucd->stat_data);
3b2385cf 2848) jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
3b2385cf 2849) jw_object_inline_begin_array(jw, "untracked");
3b2385cf 2850) for (i = 0; i < ucd->untracked_nr; i++)
3b2385cf 2851) jw_array_string(jw, ucd->untracked[i]);
3b2385cf 2852) jw_end(jw);
3b2385cf 2854) jw_object_inline_begin_object(jw, "dirs");
3b2385cf 2855) for (i = 0; i < ucd->dirs_nr; i++) {
3b2385cf 2856) jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
3b2385cf 2857) jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
3b2385cf 2858) jw_end(jw);
3b2385cf 2860) jw_end(jw);
3b2385cf 2861) }
3b2385cf 2958) jw_object_inline_begin_object(jw, "root");
3b2385cf 2959) jw_object_untracked_cache_dir(jw, uc->root);
3b2385cf 2960) jw_end(jw);

list-objects-filter-options.c
f56f7642 44) BUG("filter_options already populated");
f56f7642 236) die(_("multiple filter-specs cannot be combined"));
cf9ceb5a 286) BUG("no filter_spec available for this filter");
e987df5f 321) return;

list-objects-filter.c
e987df5f 585) BUG("expected oidset to be cleared already");

list-objects.c
9430147c 210) ctx->show_object(obj, base->buf, ctx->show_data);

prefix-map.c
1f3e3049 48) break;
1f3e3049 61) continue; /* non-unique prefix */
1f3e3049 64) BUG("unexpected prefix length: %d != %d (%s != %s)",

promisor-remote.c
db27dca5 25) die(_("Remote with no URL"));
48de3158 61) warning(_("promisor remote name cannot begin with '/': %s"),
48de3158 63) return NULL;
faf2abf4 93) previous->next = r->next;
4ca9474e 108) return git_config_string(&core_partial_clone_filter_default,
fa3d1b63 139) return 0;
9e27beaa 202) static int remove_fetched_oids(struct repository *repo,
9e27beaa 206) int i, remaining_nr = 0;
9e27beaa 207) int *remaining = xcalloc(oid_nr, sizeof(*remaining));
9e27beaa 208) struct object_id *old_oids = *oids;
9e27beaa 211) for (i = 0; i < oid_nr; i++)
9e27beaa 212) if (oid_object_info_extended(repo, &old_oids[i], NULL,
9e27beaa 214) remaining[i] = 1;
9e27beaa 215) remaining_nr++;
9e27beaa 218) if (remaining_nr) {
9e27beaa 219) int j = 0;
9e27beaa 220) new_oids = xcalloc(remaining_nr, sizeof(*new_oids));
9e27beaa 221) for (i = 0; i < oid_nr; i++)
9e27beaa 222) if (remaining[i])
9e27beaa 223) oidcpy(&new_oids[j++], &old_oids[i]);
9e27beaa 224) *oids = new_oids;
9e27beaa 225) if (to_free)
9e27beaa 226) free(old_oids);
9e27beaa 229) free(remaining);
9e27beaa 231) return remaining_nr;
9e27beaa 248) if (remaining_nr == 1)
9e27beaa 249) continue;
9e27beaa 250) remaining_nr = remove_fetched_oids(repo, &remaining_oids,
9e27beaa 252) if (remaining_nr) {
9e27beaa 253) to_free = 1;
9e27beaa 254) continue;
9e27beaa 262) free(remaining_oids);

read-cache.c
8eeabe15 1754) ret = error(_("index uses %.4s extension, which we do not understand"),
ee70c128 1756) if (advice_unknown_index_extension) {
ee70c128 1757) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1758) advise(_("This is likely due to the file having been written by a newer\n"
272b3f2a 2028) jw_object_true(jw, "assume_unchanged");
272b3f2a 2032) jw_object_true(jw, "skip_worktree");
272b3f2a 2034) jw_object_intmax(jw, "stage", ce_stage(ce));
f0f544da 2311) ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
f0f544da 3653) static struct index_entry_offset_table *read_ieot_extension(
f0f544da 3675) return do_read_ieot_extension(istate, index, extsize);

repo-settings.c
bbd04cf0 20) UPDATE_DEFAULT(rs->pack_use_sparse, 1);

repository.c
74265dd7 279) int repo_refresh_and_write_index(struct repository *r,
74265dd7 282) struct lock_file lock_file = LOCK_INIT;
74265dd7 285) if (repo_read_index_preload(r, NULL, 0) < 0)
74265dd7 286) return error(_("could not read index"));
74265dd7 287) fd = repo_hold_locked_index(r, &lock_file, 0);
74265dd7 288) if (!gentle && fd < 0)
74265dd7 289) return error(_("could not lock index for writing"));
74265dd7 290) refresh_index(r->index, flags, NULL, NULL, NULL);
74265dd7 291) if (0 <= fd)
74265dd7 292) repo_update_index_if_able(r, &lock_file);
74265dd7 293) rollback_lock_file(&lock_file);
74265dd7 295) return 0;

sequencer.c
6a146bea 3368) (!opts->strategy || !strcmp(opts->strategy, "recursive")) ?

split-index.c
1f825794 29) goto done;

t/helper/test-prefix-map.c
1f3e3049 16) va_start(ap, fmt);
1f3e3049 17) fprintf(stderr, "%s:%d: ", file, (int)line_no);
1f3e3049 18) vfprintf(stderr, fmt, ap);
1f3e3049 19) fputc('\n', stderr);
1f3e3049 20) va_end(ap);
1f3e3049 22) failed_count++;

upload-pack.c
cf9ceb5a 148) sq_quote_buf(&buf, spec);

Commits introducting uncovered code:
Christian Couder	db27dca5 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	faf2abf4 promisor-remote: use repository_format_partial_clone
Christian Couder	4ca9474e Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	fa3d1b63 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	9e27beaa promisor-remote: implement promisor_remote_get_direct()
Christian Couder	48de3158 Add initial support for many promisor remotes
Christian Couder	b14ed5ad Use promisor_remote_get_direct() and has_promisor_remote()
Daniel Ferreira	bcbdcd36 built-in add -i: implement the `status` command
Derrick Stolee	bbd04cf0 repo-settings: pack.useSparse=true
Johannes Schindelin	6a146bea rebase -r: support merge strategies other than `recursive`
Johannes Schindelin	74265dd7 built-in add -i: refresh the index before running `status`
Johannes Schindelin	f3665cfd built-in add -i: implement the `help` command
Johannes Schindelin	81e604c5 built-in add -i: implement the main loop
Johannes Schindelin	ec4ddbf6 built-in add -i: support `?` (prompt help)
Johannes Schindelin	db07a815 Start to implement a built-in version of `git add --interactive`
Johannes Schindelin	d31f31d1 built-in add -i: color the header in the `status` command
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Matthew DeVore	f56f7642 list-objects-filter-options: move error check up
Matthew DeVore	9430147c list-objects-filter: encapsulate filter components
Matthew DeVore	e987df5f list-objects-filter: implement composite filters
Matthew DeVore	cf9ceb5a list-objects-filter-options: make filter_spec a string_list
Nguyễn Thái Ngọc Duy	3b2385cf dir.c: dump "UNTR" extension as json
Nguyễn Thái Ngọc Duy	fd335a21 cache-tree.c: dump "TREE" extension as json
Nguyễn Thái Ngọc Duy	272b3f2a ls-files: add --json to dump the index
Nguyễn Thái Ngọc Duy	8eeabe15 read-cache.c: dump common extension info in json
Nguyễn Thái Ngọc Duy	f0f544da read-cache.c: dump "IEOT" extension as json
Nguyễn Thái Ngọc Duy	1f825794 split-index.c: dump "link" extension as json
Slavica Djukic	928e9d0d built-in add -i: show unique prefixes of the commands
Slavica Djukic	253cdc20 built-in add -i: use color in the main loop
Slavica Djukic	1f3e3049 Add a function to determine unique prefixes for a list of strings


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducting uncovered code:


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

apply.c
85c3713d 1187) cp = skip_tree_prefix(p_value, second, line + llen - second);

builtin/clean.c
b09364c4 198) warning_errno(_(msg_warn_lstat_failed), path->buf);

builtin/clone.c
14954b79 407) die_errno(_("failed to create directory '%s'"), pathname);
14954b79 409) die_errno(_("failed to stat '%s'"), pathname);
ff7ccc8c 428) die_errno(_("failed to start iterator over '%s'"), src->buf);
ff7ccc8c 466) strbuf_setlen(src, src_len);
ff7ccc8c 467) die(_("failed to iterate over '%s'"), src->buf);

builtin/env--helper.c
b4f207f3 23) die(_("unrecognized --type argument, %s"), arg);
b4f207f3 67) default_int = 0;
b4f207f3 82) default_ulong = 0;
b4f207f3 90) BUG("unknown <type> value");

builtin/log.c
f0596ecc 219) warning("%s\n", _(warn_unspecified_mailmap_msg));

config.c
2e43cd4c 998)     value, name, cf->name, _(error_type));
2e43cd4c 1007)     value, name, cf->name, _(error_type));
2e43cd4c 1010)     value, name, cf->name, _(error_type));
2e43cd4c 1013)     value, name, cf->name, _(error_type));

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

range-diff.c
44b67cb6 33) return size;
44b67cb6 95) strbuf_release(&contents);
b66885a3 117) die(_("could not parse git header '%.*s'"), (int)len, line);
b66885a3 135)     patch.old_mode != patch.new_mode)
b66885a3 136) strbuf_addf(&buf, " (mode change %06o => %06o)",
44b67cb6 181) strbuf_addstr(&buf, line);

t/helper/test-dir-iterator.c
fa1da7d2 24) die("invalid option '%s'", *argv);
fa1da7d2 28) die("dir-iterator needs exactly one non-option argument");
150791ad 46) printf("[?] ");

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	b4f207f3 env--helper: new undocumented builtin wrapping git_env_*()
Ævar Arnfjörð Bjarmason	2e43cd4c config.c: refactor die_bad_number() to not call gettext() early
Ariadne Conill	f0596ecc log: add warning for unspecified log.mailmap setting
Daniel Ferreira	150791ad dir-iterator: add tests for dir-iterator API
Johannes Schindelin	b09364c4 clean: show an error message when the path is too long
Matheus Tavares	14954b79 clone: extract function from copy_or_link_directory
Matheus Tavares	ff7ccc8c clone: use dir-iterator to avoid explicit dir traversal
Matheus Tavares	3012397e dir-iterator: refactor state machine model
Matheus Tavares	fa1da7d2 dir-iterator: add flags parameter to dir_iterator_begin
Matheus Tavares	c9bba372 dir-iterator: use warning_errno when possible
Thomas Gummerer	85c3713d apply: only pass required data to git_header_name
Thomas Gummerer	44b67cb6 range-diff: split lines manually
Thomas Gummerer	b66885a3 range-diff: add section header instead of diff header

