Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445741F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJQVeo (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 17:34:44 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:45323 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 17:34:44 -0400
Received: by mail-vs1-f54.google.com with SMTP id g201so20743140vsd.12
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=faN2O/vZ0Di1W9+5DShaMPHp2RV10PIvZl58z+kmacc=;
        b=Ji+8dvfSSzFafdn2+AmVTi4vAlsw4ErYvjwN+6a59PHWHAejjOvJSWTT4a4jeVblg4
         u14QUAwmDVztYbFs1S2Y/rxbBUljS82fBKfZ31BrXBhmPNMOjkIPz0UpF8tr//QYUaQa
         4R0bgOeblx7VxT4F4Zf+b1et1NxEK82VJwhhw63BYISqOYsi3EIRtSiZUOP88uClCsF+
         Dvp+K6THsrhuA9aYqym9eQqhza5OBoEA5GiZUQUvek7GwxtfYeVOUDVR5h6kf4ZTiJS5
         26Ugtbd30lLcEkcc/pXxjK2ALkvekRDGPuEBTsufVsHoQzyA/yGVR/VYeMHqepa2Qwe+
         Mx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=faN2O/vZ0Di1W9+5DShaMPHp2RV10PIvZl58z+kmacc=;
        b=IHO5p6fgN128Z/41jO9gwO+cjvCx/dxy5HDzpckVTLIdGKjGFF3DGmwzSF4tMuEhA8
         edmVzB8l+Ow9kZoA8/4fSMWaqg9JtoqIAmS6UIx8SrdIvkXDzlQNrfJOcDH5niC+drze
         jvp8caahWmatQCWLyfSwAin+0mBXy3hBhF2VI/1NwJQY5xoCYMcQZAlSoMAC/v+onyet
         qinWNJLnr/OvkF3H4uclvHu+p8jHbg5ZIg6rbnkPwDlVWtgthUcYeEgbzKHRldDwwIA1
         z1TtOw6h+Hs4zgZXoeHwAkk5V7iYI9Pmhhwe6wdGdto5itZCzMTjJ805OaMhWpnICz35
         DkJw==
X-Gm-Message-State: ABuFfoiXzeaIzn8PrMIFJyYkO24zBvLC01m4szGlIvVD2f4Ht0Y39ToH
        Eromon/9GYRIBSSOTMd/HgM97a7p
X-Google-Smtp-Source: ACcGV60rPAGTAnSmxaMsgtYTkYB2J3FlBSkNhJHeVbX9YVVMxzwQklN4OhdDsNjvg70aloWFSVE3CA==
X-Received: by 2002:a67:7b56:: with SMTP id w83mr10621253vsc.152.1539783535640;
        Wed, 17 Oct 2018 06:38:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8586:348a:8c9:d17b? ([2001:4898:8010:0:6ebc:348a:8c9:d17b])
        by smtp.gmail.com with ESMTPSA id l26sm3669100vsa.10.2018.10.17.06.38.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:38:55 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Wednesday, Oct 17)
Message-ID: <8dc21d96-eaf9-cd23-20be-6249e356c7d4@gmail.com>
Date:   Wed, 17 Oct 2018 09:38:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to ensure new code is reasonably covered by the test suite, 
we now have contrib/coverage-diff.sh to combine the gcov output from 
'make coverage-test ; make coverage-report' with the output from 'git 
diff A B' to discover _new_lines of code that are not covered. This 
report ignores lines including "BUG(".

This report takes the output of these results after running on four 
branches:

         pu: 9b314678659b2d0a69e4ca4f77444ba66f158564
             (build is broken)

        jch: e6b0db6626cabc387dd5a8c60088421ce65e1686
             (build is broken)

       next: 3377e82b59874c0e626c00f29bf7526a27f29d65

     master: a4b8ab5363a32f283a61ef3a962853556d136c0e

master@{1}: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf

I ran the test suite on each of these branches on an Ubuntu Linux VM, 
and I'm missing some dependencies (like apache, svn, and perforce) so 
not all tests are run

Thanks,
-Stolee


Uncovered Code in 'next' (3377e82) but not in 'master' (a4b8ab5)
----------------------------------------------------------------

blame.c
a470beea39  113)  !strcmp(r->index->cache[-1 - pos]->name, path))
a470beea39  272) int pos = index_name_pos(r->index, path, len);
a470beea39  274) mode = r->index->cache[pos]->ce_mode;

builtin/am.c
2abf350385 1414) repo_init_revisions(the_repository, &rev_info, NULL);

builtin/archive.c
e001fd3a50 builtin/archive.c  78) die(_("git archive: expected ACK/NAK, 
got a flush packet"));
e001fd3a50 builtin/archive.c  80) if (starts_with(reader.line, "NACK "))
e001fd3a50 builtin/archive.c  81) die(_("git archive: NACK %s"), 
reader.line + 5);
e001fd3a50 builtin/archive.c  82) if (starts_with(reader.line, "ERR "))
e001fd3a50 builtin/archive.c  83) die(_("remote error: %s"), reader.line 
+ 4);
e001fd3a50 builtin/archive.c  84) die(_("git archive: protocol error"));
e001fd3a50 builtin/archive.c  89) die(_("git archive: expected a flush"));
fb19d32f05 builtin/archive.c  99) if (version != discover_version(&reader))
fb19d32f05 builtin/archive.c 100) die(_("git archive: received different 
protocol versions in subsequent requests"));

builtin/rev-list.c
7c0fe330d5 builtin/rev-list.c 227) die("unexpected missing %s object '%s'",
7c0fe330d5 builtin/rev-list.c 228)     type_name(obj->type), 
oid_to_hex(&obj->oid));

builtin/upload-archive.c
e001fd3a50 builtin/upload-archive.c 111) if (version == protocol_v0 || 
version == protocol_v1)
e001fd3a50 builtin/upload-archive.c 112) packet_write_fmt(1, "NACK 
unable to spawn subprocess\n");
e001fd3a50 builtin/upload-archive.c 113) else if (version == protocol_v2)
e001fd3a50 builtin/upload-archive.c 114) error_clnt("unable to spawn 
subprocess\n");

config.c
c780b9cfe8 2298) return val;
c780b9cfe8 2301) if (is_bool)
c780b9cfe8 2302) return val ? 0 : 1;
c780b9cfe8 2304) return val;

diff.c
b78ea5fc35 4128) add_external_diff_name(o->repo, &argv, other, two);

help.c
26c7d06783 help.c         500) static int get_alias(const char *var, 
const char *value, void *data)
26c7d06783 help.c         502) struct string_list *list = data;
26c7d06783 help.c         504) if (skip_prefix(var, "alias.", &var))
26c7d06783 help.c         505) string_list_append(list, var)->util = 
xstrdup(value);
26c7d06783 help.c         507) return 0;
26c7d06783 help.c         530) printf("\n%s\n", _("Command aliases"));
26c7d06783 help.c         531) ALLOC_ARRAY(aliases, alias_list.nr + 1);
26c7d06783 help.c         532) for (i = 0; i < alias_list.nr; i++) {
26c7d06783 help.c         533) aliases[i].name = alias_list.items[i].string;
26c7d06783 help.c         534) aliases[i].help = alias_list.items[i].util;
26c7d06783 help.c         535) aliases[i].category = 1;
26c7d06783 help.c         537) aliases[alias_list.nr].name = NULL;
26c7d06783 help.c         538) print_command_list(aliases, 1, longest);
26c7d06783 help.c         539) free(aliases);

http-backend.c
fb19d32f05 646) argv[1] = ".";
fb19d32f05 647) argv[2] = NULL;

list-objects-filter-options.c
bc5975d24f  55) if (errbuf) {
bc5975d24f  56) strbuf_addstr(
bc5975d24f  60) return 1;
cc0b05a4cc  86) if (errbuf)

list-objects-filter.c
list-objects.c
f447a499db 197) ctx->show_object(obj, base->buf, ctx->show_data);

oidset.c
8b2f8cbcb1 29) kh_del_oid(&set->set, pos);
8b2f8cbcb1 30) return 1;

preload-index.c
ae9af12287  73) struct progress_data *pd = p->progress;
ae9af12287  75) pthread_mutex_lock(&pd->mutex);
ae9af12287  76) pd->n += last_nr - nr;
ae9af12287  77) display_progress(pd->progress, pd->n);
ae9af12287  78) pthread_mutex_unlock(&pd->mutex);
ae9af12287  79) last_nr = nr;
ae9af12287  93) struct progress_data *pd = p->progress;
ae9af12287  95) pthread_mutex_lock(&pd->mutex);
ae9af12287  96) display_progress(pd->progress, pd->n + last_nr);
ae9af12287  97) pthread_mutex_unlock(&pd->mutex);
ae9af12287 128) pd.progress = start_delayed_progress(_("Refreshing 
index"), index->cache_nr);
ae9af12287 129) pthread_mutex_init(&pd.mutex, NULL);
ae9af12287 140) p->progress = &pd;

read-cache.c
ae9af12287 1490) progress = start_delayed_progress(_("Refresh index"),
ae9af12287 1491)   istate->cache_nr);
ae9af12287 1533) display_progress(progress, i);
ae9af12287 1566) display_progress(progress, istate->cache_nr);
ae9af12287 1567) stop_progress(&progress);
252d079cbd 1778) const unsigned char *cp = (const unsigned char *)name;
252d079cbd 1782) strip_len = decode_varint(&cp);
77ff1127a4 1783) if (previous_ce) {
77ff1127a4 1784) previous_len = previous_ce->ce_namelen;
77ff1127a4 1785) if (previous_len < strip_len)
252d079cbd 1786) die(_("malformed name field in the index, near path '%s'"),
77ff1127a4 1787) previous_ce->name);
77ff1127a4 1788) copy_len = previous_len - strip_len;
77ff1127a4 1790) copy_len = 0;
252d079cbd 1792) name = (const char *)cp;
252d079cbd 1798) len += copy_len;
252d079cbd 1819) if (copy_len)
252d079cbd 1820) memcpy(ce->name, previous_ce->name, copy_len);
252d079cbd 1821) memcpy(ce->name + copy_len, name, len + 1 - copy_len);
252d079cbd 1822) *ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
abb4bb8384 1959) munmap((void *)p->mmap, p->mmap_size);
abb4bb8384 1960) die(_("index file corrupt"));
77ff1127a4 2001) mem_pool_init(&istate->ce_mem_pool,
77ff1127a4 2041) static void *load_cache_entries_thread(void *_data)
77ff1127a4 2043) struct load_cache_entries_thread_data *p = _data;
77ff1127a4 2047) for (i = p->ieot_start; i < p->ieot_start + 
p->ieot_blocks; i++) {
77ff1127a4 2048) p->consumed += load_cache_entry_block(p->istate, 
p->ce_mem_pool,
77ff1127a4 2049) p->offset, p->ieot->entries[i].nr, p->mmap, 
p->ieot->entries[i].offset, NULL);
77ff1127a4 2050) p->offset += p->ieot->entries[i].nr;
77ff1127a4 2052) return NULL;
77ff1127a4 2055) static unsigned long load_cache_entries_threaded(struct 
index_state *istate, const char *mmap, size_t mmap_size,
77ff1127a4 2060) unsigned long consumed = 0;
77ff1127a4 2063) if (istate->name_hash_initialized)
77ff1127a4 2066) mem_pool_init(&istate->ce_mem_pool, 0);
77ff1127a4 2069) if (nr_threads > ieot->nr)
77ff1127a4 2070) nr_threads = ieot->nr;
77ff1127a4 2071) data = xcalloc(nr_threads, sizeof(*data));
77ff1127a4 2073) offset = ieot_start = 0;
77ff1127a4 2074) ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
77ff1127a4 2075) for (i = 0; i < nr_threads; i++) {
77ff1127a4 2076) struct load_cache_entries_thread_data *p = &data[i];
77ff1127a4 2079) if (ieot_start + ieot_blocks > ieot->nr)
77ff1127a4 2080) ieot_blocks = ieot->nr - ieot_start;
77ff1127a4 2082) p->istate = istate;
77ff1127a4 2083) p->offset = offset;
77ff1127a4 2084) p->mmap = mmap;
77ff1127a4 2085) p->ieot = ieot;
77ff1127a4 2086) p->ieot_start = ieot_start;
77ff1127a4 2087) p->ieot_blocks = ieot_blocks;
77ff1127a4 2090) nr = 0;
77ff1127a4 2091) for (j = p->ieot_start; j < p->ieot_start + 
p->ieot_blocks; j++)
77ff1127a4 2092) nr += p->ieot->entries[j].nr;
77ff1127a4 2093) if (istate->version == 4) {
77ff1127a4 2094) mem_pool_init(&p->ce_mem_pool,
77ff1127a4 2097) mem_pool_init(&p->ce_mem_pool,
77ff1127a4 2101) err = pthread_create(&p->pthread, NULL, 
load_cache_entries_thread, p);
77ff1127a4 2102) if (err)
77ff1127a4 2103) die(_("unable to create load_cache_entries thread: 
%s"), strerror(err));
77ff1127a4 2106) for (j = 0; j < ieot_blocks; j++)
77ff1127a4 2107) offset += ieot->entries[ieot_start + j].nr;
77ff1127a4 2108) ieot_start += ieot_blocks;
77ff1127a4 2111) for (i = 0; i < nr_threads; i++) {
77ff1127a4 2112) struct load_cache_entries_thread_data *p = &data[i];
77ff1127a4 2114) err = pthread_join(p->pthread, NULL);
77ff1127a4 2115) if (err)
77ff1127a4 2116) die(_("unable to join load_cache_entries thread: %s"), 
strerror(err));
77ff1127a4 2117) mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
77ff1127a4 2118) consumed += p->consumed;
77ff1127a4 2121) free(data);
77ff1127a4 2123) return consumed;
77ff1127a4 2192) nr_threads = cpus;
abb4bb8384 2196) extension_offset = read_eoie_extension(mmap, mmap_size);
abb4bb8384 2197) if (extension_offset) {
abb4bb8384 2200) p.src_offset = extension_offset;
abb4bb8384 2201) err = pthread_create(&p.pthread, NULL, 
load_index_extensions, &p);
abb4bb8384 2202) if (err)
abb4bb8384 2203) die(_("unable to create load_index_extensions thread: 
%s"), strerror(err));
abb4bb8384 2205) nr_threads--;
77ff1127a4 2214) ieot = read_ieot_extension(mmap, mmap_size, 
extension_offset);
77ff1127a4 2217) src_offset += load_cache_entries_threaded(istate, mmap, 
mmap_size, src_offset, nr_threads, ieot);
77ff1127a4 2218) free(ieot);
abb4bb8384 2232) int ret = pthread_join(p.pthread, NULL);
abb4bb8384 2233) if (ret)
abb4bb8384 2234) die(_("unable to join load_index_extensions thread: 
%s"), strerror(ret));
3255089ada 2775) ieot_blocks = nr_threads;
77ff1127a4 2776) if (ieot_blocks > istate->cache_nr)
77ff1127a4 2777) ieot_blocks = istate->cache_nr;
3255089ada 2785) ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
3255089ada 2786) + (ieot_blocks * sizeof(struct index_entry_offset)));
77ff1127a4 2787) ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
3255089ada 2794) free(ieot);
3b1d9e045e 2795) return -1;
3255089ada 2821) ieot->entries[ieot->nr].nr = nr;
3255089ada 2822) ieot->entries[ieot->nr].offset = offset;
3255089ada 2823) ieot->nr++;
3255089ada 2829) if (previous_name)
3255089ada 2830) previous_name->buf[0] = 0;
3255089ada 2831) nr = 0;
3255089ada 2832) offset = lseek(newfd, 0, SEEK_CUR);
3255089ada 2833) if (offset < 0) {
3255089ada 2834) free(ieot);
3255089ada 2835) return -1;
3255089ada 2837) offset += write_buffer_len;
3255089ada 2847) ieot->entries[ieot->nr].nr = nr;
3255089ada 2848) ieot->entries[ieot->nr].offset = offset;
3255089ada 2849) ieot->nr++;
3255089ada 2861) free(ieot);
3b1d9e045e 2862) return -1;
3255089ada 2876) struct strbuf sb = STRBUF_INIT;
3255089ada 2878) write_ieot_extension(&sb, ieot);
3255089ada 2879) err = write_index_ext_header(&c, &eoie_c, newfd, 
CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
3255089ada 2880) || ce_write(&c, newfd, sb.buf, sb.len) < 0;
3255089ada 2881) strbuf_release(&sb);
3255089ada 2882) free(ieot);
3255089ada 2883) if (err)
3255089ada 2884) return -1;
3b1d9e045e 3372) static size_t read_eoie_extension(const char *mmap, 
size_t mmap_size)
3b1d9e045e 3390) if (mmap_size < sizeof(struct cache_header) + 
EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)
3b1d9e045e 3391) return 0;
3b1d9e045e 3394) index = eoie = mmap + mmap_size - EOIE_SIZE_WITH_HEADER 
- the_hash_algo->rawsz;
3b1d9e045e 3395) if (CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
3b1d9e045e 3396) return 0;
3b1d9e045e 3397) index += sizeof(uint32_t);
3b1d9e045e 3400) extsize = get_be32(index);
3b1d9e045e 3401) if (extsize != EOIE_SIZE)
3b1d9e045e 3402) return 0;
3b1d9e045e 3403) index += sizeof(uint32_t);
3b1d9e045e 3409) offset = get_be32(index);
3b1d9e045e 3410) if (mmap + offset < mmap + sizeof(struct cache_header))
3b1d9e045e 3411) return 0;
3b1d9e045e 3412) if (mmap + offset >= eoie)
3b1d9e045e 3413) return 0;
3b1d9e045e 3414) index += sizeof(uint32_t);
3b1d9e045e 3425) src_offset = offset;
3b1d9e045e 3426) the_hash_algo->init_fn(&c);
3b1d9e045e 3427) while (src_offset < mmap_size - the_hash_algo->rawsz - 
EOIE_SIZE_WITH_HEADER) {
3b1d9e045e 3435) memcpy(&extsize, mmap + src_offset + 4, 4);
3b1d9e045e 3436) extsize = ntohl(extsize);
3b1d9e045e 3439) if (src_offset + 8 + extsize < src_offset)
3b1d9e045e 3440) return 0;
3b1d9e045e 3442) the_hash_algo->update_fn(&c, mmap + src_offset, 8);
3b1d9e045e 3444) src_offset += 8;
3b1d9e045e 3445) src_offset += extsize;
3b1d9e045e 3447) the_hash_algo->final_fn(hash, &c);
3b1d9e045e 3448) if (!hasheq(hash, (const unsigned char *)index))
3b1d9e045e 3449) return 0;
3b1d9e045e 3452) if (src_offset != mmap_size - the_hash_algo->rawsz - 
EOIE_SIZE_WITH_HEADER)
3b1d9e045e 3453) return 0;
3b1d9e045e 3455) return offset;
3255089ada 3475) static struct index_entry_offset_table 
*read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
3255089ada 3477)        const char *index = NULL;
3255089ada 3483)        if (!offset)
3255089ada 3484)        return NULL;
3255089ada 3485)        while (offset <= mmap_size - 
the_hash_algo->rawsz - 8) {
3255089ada 3486)        extsize = get_be32(mmap + offset + 4);
3255089ada 3487)        if (CACHE_EXT((mmap + offset)) == 
CACHE_EXT_INDEXENTRYOFFSETTABLE) {
3255089ada 3488)        index = mmap + offset + 4 + 4;
3255089ada 3489)        break;
3255089ada 3491)        offset += 8;
3255089ada 3492)        offset += extsize;
3255089ada 3494)        if (!index)
3255089ada 3495)        return NULL;
3255089ada 3498)        ext_version = get_be32(index);
3255089ada 3499)        if (ext_version != IEOT_VERSION) {
3255089ada 3500)        error("invalid IEOT version %d", ext_version);
3255089ada 3501)        return NULL;
3255089ada 3503)        index += sizeof(uint32_t);
3255089ada 3506)        nr = (extsize - sizeof(uint32_t)) / 
(sizeof(uint32_t) + sizeof(uint32_t));
3255089ada 3507)        if (!nr) {
3255089ada 3508)        error("invalid number of IEOT entries %d", nr);
3255089ada 3509)        return NULL;
3255089ada 3511)        ieot = xmalloc(sizeof(struct 
index_entry_offset_table)
3255089ada 3512)        + (nr * sizeof(struct index_entry_offset)));
3255089ada 3513)        ieot->nr = nr;
3255089ada 3514)        for (i = 0; i < nr; i++) {
3255089ada 3515)        ieot->entries[i].offset = get_be32(index);
3255089ada 3516)        index += sizeof(uint32_t);
3255089ada 3517)        ieot->entries[i].nr = get_be32(index);
3255089ada 3518)        index += sizeof(uint32_t);
3255089ada 3521)        return ieot;
3255089ada 3524) static void write_ieot_extension(struct strbuf *sb, 
struct index_entry_offset_table *ieot)
3255089ada 3530)        put_be32(&buffer, IEOT_VERSION);
3255089ada 3531)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3534)        for (i = 0; i < ieot->nr; i++) {
3255089ada 3537)        put_be32(&buffer, ieot->entries[i].offset);
3255089ada 3538)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3541)        put_be32(&buffer, ieot->entries[i].nr);
3255089ada 3542)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3544) }

revision.c
2abf350385 1525) if (ce_path_match(istate, ce, &revs->prune_data, NULL)) {
2abf350385 1531) while ((i+1 < istate->cache_nr) &&
2abf350385 1532)        ce_same_name(ce, istate->cache[i+1]))

split-index.c
e3d837989e 335) ce->ce_flags |= CE_UPDATE_IN_BASE;

transport-helper.c
fb19d32f05  643) if (!data->connect && !data->stateless_connect)

transport.c
wt-status.c
f3bd35fa0d  671) s->committable = 1;
73ba5d78b4 1953) if (s->state.rebase_in_progress ||
73ba5d78b4 1954)     s->state.rebase_interactive_in_progress)
73ba5d78b4 1955) branch_name = s->state.onto;
73ba5d78b4 1956) else if (s->state.detached_from)
73ba5d78b4 1957) branch_name = s->state.detached_from;

Commits introducing uncovered code:
Ben Peart      3255089ad: ieot: add Index Entry Offset Table (IEOT) 
extension
Ben Peart      3b1d9e045: eoie: add End of Index Entry (EOIE) extension
Ben Peart      77ff1127a: read-cache: load cache entries on worker threads
Ben Peart      abb4bb838: read-cache: load cache extensions on a worker 
thread
Ben Peart      c780b9cfe: config: add new index.threads config setting
Josh Steadmon      e001fd3a5: archive: implement protocol v2 archive command
Josh Steadmon      fb19d32f0: archive: allow archive over HTTP(S) with 
proto v2
Matthew DeVore      7c0fe330d: rev-list: handle missing tree objects 
properly
Matthew DeVore      bc5975d24: list-objects-filter: implement filter tree:0
Matthew DeVore      cc0b05a4c: list-objects-filter-options: do not 
over-strbuf_init
Matthew DeVore      f447a499d: list-objects: store common func args in 
struct
Nguyễn Thái Ngọc Duy      252d079cb: read-cache.c: optimize reading 
index format v4
Nguyễn Thái Ngọc Duy      26c7d0678: help -a: improve and make --verbose 
default
Nguyễn Thái Ngọc Duy      2abf35038: revision.c: remove implicit 
dependency on the_index
Nguyễn Thái Ngọc Duy      a470beea3: blame.c: rename "repo" argument to "r"
Nguyễn Thái Ngọc Duy      ae9af1228: status: show progress bar if 
refreshing the index takes too long
Nguyễn Thái Ngọc Duy      b78ea5fc3: diff.c: reduce implicit dependency 
on the_index
René Scharfe      8b2f8cbcb: oidset: use khash
Stephen P. Smith      73ba5d78b: roll wt_status_state into wt_status and 
populate in the collect phase
Stephen P. Smith      f3bd35fa0: wt-status.c: set the committable flag 
in the collect phase
SZEDER Gábor      e3d837989: split-index: don't compare cached data of 
entries already marked for split index


Uncovered Code in 'master' (a4b8ab5) but not in 5a0cc8a
-------------------------------------------------------

builtin/gc.c
3029970275 builtin/gc.c 461) ret = error_errno(_("cannot stat '%s'"), 
gc_log_path);
3029970275 builtin/gc.c 470) ret = error_errno(_("cannot read '%s'"), 
gc_log_path);
fec2ed2187 builtin/gc.c 495) die(FAILED_RUN, pack_refs_cmd.argv[0]);
fec2ed2187 builtin/gc.c 498) die(FAILED_RUN, reflog.argv[0]);
3029970275 builtin/gc.c 585) exit(128);
fec2ed2187 builtin/gc.c 637) die(FAILED_RUN, repack.argv[0]);
fec2ed2187 builtin/gc.c 647) die(FAILED_RUN, prune.argv[0]);
fec2ed2187 builtin/gc.c 654) die(FAILED_RUN, prune_worktrees.argv[0]);
fec2ed2187 builtin/gc.c 658) die(FAILED_RUN, rerere.argv[0]);

builtin/pack-objects.c
2fa233a554 builtin/pack-objects.c 1512) hashcpy(base_oid.hash, base_sha1);
2fa233a554 builtin/pack-objects.c 1513) if 
(!in_same_island(&delta->idx.oid, &base_oid))
2fa233a554 builtin/pack-objects.c 1514) return 0;

commit-graph.c
5cef295f28   67) return 0;
20fd6d5799   79) return 0;

midx.c
e43d2dcce1  285) if (hasheq(oid.hash,
e43d2dcce1  286)    p->bad_object_sha1 + the_hash_algo->rawsz * i))

refs.c
4a6067cda5 1405) return 0;

Commits introducing uncovered code:
Derrick Stolee      20fd6d579: commit-graph: not compatible with grafts
Derrick Stolee      5cef295f2: commit-graph: not compatible with 
uninitialized repo
Jeff King      2fa233a55: pack-objects: handle island check for 
"external" delta base
Jeff King      e43d2dcce: more oideq/hasheq conversions
Jonathan Nieder      302997027: gc: do not return error for prior errors 
in daemonized mode
Jonathan Nieder      fec2ed218: gc: exit with status 128 on failure
Stefan Beller      4a6067cda: refs.c: migrate internal ref iteration to 
pass thru repository argument
