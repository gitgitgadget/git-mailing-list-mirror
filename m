Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB8E1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIZAvW (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:51:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33434 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeIZAvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:51:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id 84-v6so2684654qkf.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ixebRm64/27X3Wk0FSMZeKZEf1YSIZ5+6/Ixyofqf4Y=;
        b=PEXtcKBvMHenc77dI8Xv1ik58e8HkucRKyeltgANeg7sjeOFwswMd6s1aWTozhzzQr
         /m0wGYhcpBgIw90xKh2p2790JBJI0GhLu5+C7IeDQBIf+SDM9DuP3dNW2tSlokDD7Nne
         0cNHHEHNhEkwDNAmvmtEMkOF1wFEs+d5lRWArczdjVoMIWYdzM+FWt0awpNhWSISqrK6
         x4C4SQbzVXHeCIEIyi1UhFuDhRW6UzUwYSZg0AGKj8+gPPiabt9XKjQ674eegxtdO7Ly
         zfzGrN4rNNTvnQnxxgNXyY1VUzd1RiVh0pRd1fPMxI3r/Grb1aJ/vI3zUm/4LuwCNc5a
         2Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ixebRm64/27X3Wk0FSMZeKZEf1YSIZ5+6/Ixyofqf4Y=;
        b=bS5Jas4qrnDToTVCUe/MY4bqNVQh091X74Na36TpL56wR4DmkdDY8MyGDSArnJEXAC
         dKUQ3Mx9B81svLDZfZPSIFtUKvIgeY9urlMU8BDbhKguk/nB214T4Gs8RcWJYEwBUJa0
         fJiUyW7UWSEMd7dhaHUAZOVZx5xqceDG3sVEIHzZbkxHtZEAKforL04FBVCX5voDaEid
         autqhunS2NHtWR8aFAN7TYWnfHZxDNF4RspfJvC5U/+cHhFjnQDarSl2S7zA5v/hlMZg
         4EBk6X6Rg3+azTGmI1dj5Qz2hFrXd3/CAoio/jXEuKBhhcEViM5eNcRX33t8aI5Xv8Tt
         MZ/A==
X-Gm-Message-State: ABuFfoh02q8ENl4Y9sXQM12e+xfGlC2YlRXJECxk4eaDROuVvKdk4I6t
        o7DmFqxQ+3HaL44ytHrsinbbHSDL
X-Google-Smtp-Source: ACcGV61LFfyBW/zpbzuTvhJRxQH3sKYbQy+thO/WYoHRfqSgK+PoZz3GRrY+43pTqpz1EuEtnz3neg==
X-Received: by 2002:a37:a20d:: with SMTP id l13-v6mr1671450qke.297.1537900946593;
        Tue, 25 Sep 2018 11:42:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:78b6:4100:eb3b:b0cf? ([2001:4898:8010:0:61ec:4100:eb3b:b0cf])
        by smtp.gmail.com with ESMTPSA id u27-v6sm1984184qki.85.2018.09.25.11.42.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:42:25 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Tuesday, Sept 25)
To:     Git List <git@vger.kernel.org>
Message-ID: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
Date:   Tue, 25 Sep 2018 14:42:24 -0400
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
diff A B' to discover _new_ lines of code that are not covered.

This report takes the output of these results after running on four 
branches:

         pu: 80e728fa913dc3a1165b6dec9a7afa6052a86325

        jch: 0c10634844314ab89666ed0a1c7d36dde7ac9689

       next: 76f2f5c1e34c4dbef1029e2984c2892894c444ce

     master: fe8321ec057f9231c26c29b364721568e58040f7

master@{1}: 2d3b1c576c85b7f5db1f418907af00ab88e0c303

I ran the test suite on each of these branches on an Ubuntu Linux VM, 
and I'm missing some dependencies (like apache, svn, and perforce) so 
not all tests are run.

I submit this output without comment. I'm taking a look especially at my 
own lines to see where coverage can be improved.

Thanks,

-Stolee

---

master@{1}..master:

builtin/remote.c
5025425dfff     (   Shulhan     2018-09-13 20:18:33 +0700 
864)            return error(_("No such remote: '%s'"), name);
commit-reach.c
b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700 
559)                    continue;
b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700 
569)                    from->objects[i].item->flags |= assign_flag;
b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700 
570)                    continue;
b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700 
576)                    result = 0;
b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700 
577)                    goto cleanup;
cat: compat#mingw.c.gcov: No such file or directory
ll-merge.c
d64324cb60e     (Torsten Bögershausen   2018-09-12 21:32:02 +0200       
379)                    marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
remote-curl.c
c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700 
181)            options.filter = xstrdup(value);

master..next:

fsck.c
fb8952077df     (René Scharfe   2018-09-03 14:49:26 +0000 
212)            die_errno("Could not read '%s'", path);
midx.c
56ee7ff1565     (Derrick Stolee 2018-09-13 11:02:13 -0700 
949)            return 0;
cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700 
990)                    midx_report(_("failed to load pack-index for 
packfile %s"),
cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700 
991)                                e.p->pack_name);
cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700 
992)                    break;

next..jch:

blame.c
a470beea39b     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:21 +0200       
113)             !strcmp(r->index->cache[-1 - pos]->name, path))
a470beea39b     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:21 +0200       
272)            int pos = index_name_pos(r->index, path, len);
a470beea39b     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:21 +0200       
274)                    mode = r->index->cache[pos]->ce_mode;
commit-graph.c
5cef295f283     (Derrick Stolee 2018-08-20 18:24:32 +0000 
67)             return 0;
20fd6d57996     (Derrick Stolee 2018-08-20 18:24:30 +0000 
79)             return 0;
config.c
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2301)           if (is_bool)
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2302)                   return val ? 0 : 1;
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2304)                   return val;
diff.c
b78ea5fc357     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:19 +0200       
4117) add_external_diff_name(o->repo, &argv, other, two);
http-push.c
2abf3503854     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:38 +0200       
1928)           repo_init_revisions(the_repository, &revs, 
setup_git_directory());
list-objects-filter-options.c
7c8a0cecc49     (Matthew DeVore 2018-09-21 13:32:04 -0700 
55)                     if (errbuf) {
7c8a0cecc49     (Matthew DeVore 2018-09-21 13:32:04 -0700 
56)                             strbuf_addstr(
7c8a0cecc49     (Matthew DeVore 2018-09-21 13:32:04 -0700 
60)                     return 1;
ba72cca605f     (Matthew DeVore 2018-09-21 13:32:03 -0700 86)     if 
(errbuf)
list-objects-filter.c
22e9b63e620     (Matthew DeVore 2018-09-21 13:32:02 -0700 
47)             BUG("unknown filter_situation: %d", filter_situation);
7c8a0cecc49     (Matthew DeVore 2018-09-21 13:32:04 -0700 100)    default:
7c8a0cecc49     (Matthew DeVore 2018-09-21 13:32:04 -0700 
101)            BUG("unknown filter_situation: %d", filter_situation);
22e9b63e620     (Matthew DeVore 2018-09-21 13:32:02 -0700 
152)            BUG("unknown filter_situation: %d", filter_situation);
22e9b63e620     (Matthew DeVore 2018-09-21 13:32:02 -0700 
257)            BUG("unknown filter_situation: %d", filter_situation);
22e9b63e620     (Matthew DeVore 2018-09-21 13:32:02 -0700 
438)            BUG("invalid list-objects filter choice: %d",
list-objects.c
f447a499dbb     (Matthew DeVore 2018-08-13 11:14:28 -0700 
197)                    ctx->show_object(obj, base->buf, ctx->show_data);
preload-index.c
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
73)                     struct progress_data *pd = p->progress;
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
75) pthread_mutex_lock(&pd->mutex);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
76)                     pd->n += last_nr - nr;
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
77) display_progress(pd->progress, pd->n);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
78) pthread_mutex_unlock(&pd->mutex);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
79)                     last_nr = nr;
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
93)             struct progress_data *pd = p->progress;
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
95) pthread_mutex_lock(&pd->mutex);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
96)             display_progress(pd->progress, pd->n + last_nr);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
97) pthread_mutex_unlock(&pd->mutex);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
128)            pd.progress = start_delayed_progress(_("Refreshing 
index"), index->cache_nr);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
129)            pthread_mutex_init(&pd.mutex, NULL);
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
140)                    p->progress = &pd;
prio-queue.c
2d181390f3c     (Derrick Stolee 2018-09-17 21:08:43 -0700 
94)             return queue->array[queue->nr - 1].data;
read-cache.c
ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04 +0200       
1535)                   display_progress(progress, i);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1754)   strbuf_setlen(name, name->len - len);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1755)   ep = cp + strlen((const char *)cp);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1792)           const unsigned char *cp = (const unsigned char *)name;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1795)           previous_len = previous_ce ? previous_ce->ce_namelen : 0;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1796)           strip_len = decode_varint(&cp);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1797)           if (previous_len < strip_len) {
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1798)                   if (previous_ce)
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1799)                           die(_("malformed name field in the 
index, near path '%s'"),
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1800) previous_ce->name);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1802)                           die(_("malformed name field in the index 
in the first path"));
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1804)           copy_len = previous_len - strip_len;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1805)           name = (const char *)cp;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1829)           memcpy(ce->name, previous_ce->name, copy_len);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1830)           memcpy(ce->name + copy_len, name, len + 1 - copy_len);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
1831)           *ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
9928a34be6b     ( Ben Peart     2018-09-12 16:18:59 +0000 
1954)                   munmap((void *)p->mmap, p->mmap_size);
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
1955)                   die("index file corrupt");
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
1996)           mem_pool_init(&istate->ce_mem_pool,
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2034)static 
void *load_cache_entries_thread(void *_data)
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2036)   struct 
load_cache_entries_thread_data *p = _data;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2038)   
p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool,
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2039)           p->offset, p->nr, p->mmap, p->start_offset, p->previous_ce);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2040)   return 
NULL;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2043)static 
unsigned long load_cache_entries_threaded(int nr_threads, struct 
index_state *istate,
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2046)   struct 
strbuf previous_name_buf = STRBUF_INIT, *previous_name;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2053)   if 
(istate->name_hash_initialized)
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2054)           BUG("the name hash isn't thread safe");
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2056)   
mem_pool_init(&istate->ce_mem_pool, 0);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2057)   if 
(istate->version == 4)
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2058)           previous_name = &previous_name_buf;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2060)           previous_name = NULL;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2062)   
ce_per_thread = DIV_ROUND_UP(istate->cache_nr, nr_threads);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2063)   data = 
xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2070)   
consumed = thread = 0;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2071)   for (i 
= 0; ; i++) {
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2080)           if (i % ce_per_thread == 0) {
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2081)                   struct load_cache_entries_thread_data *p = 
&data[thread];
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2083)                   p->istate = istate;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2084)                   p->offset = i;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2085)                   p->nr = ce_per_thread < istate->cache_nr - i ? 
ce_per_thread : istate->cache_nr - i;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2086)                   p->mmap = mmap;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2087)                   p->start_offset = src_offset;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2090)                   if (istate->version == 4) {
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2091) 
mem_pool_init(&p->ce_mem_pool,
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2092) 
estimate_cache_size_from_compressed(p->nr));
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2095)                           if (previous_name->len) {
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2096) p->previous_ce = mem_pool__ce_alloc(p->ce_mem_pool, 
previous_name->len);
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2097) p->previous_ce->ce_namelen = previous_name->len;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2098) memcpy(p->previous_ce->name, previous_name->buf, previous_name->len);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2101) 
mem_pool_init(&p->ce_mem_pool,
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2102) 
estimate_cache_size(mmap_size, p->nr));
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2105)                   if (pthread_create(&p->pthread, NULL, 
load_cache_entries_thread, p))
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2106)                           die("unable to create 
load_cache_entries_thread");
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2109)                   if (++thread == nr_threads)
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2110)                           break;
9928a34be6b     ( Ben Peart     2018-09-12 16:18:59 +0000 
2113)           ondisk = (struct ondisk_cache_entry *)(mmap + src_offset);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2116)           flags = get_be16(&ondisk->flags);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2118)           if (flags & CE_EXTENDED) {
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2120)                   ondisk2 = (struct ondisk_cache_entry_extended 
*)ondisk;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2121)                   name = ondisk2->name;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2123)                   name = ondisk->name;
13e1b78757a     (Nguyễn Thái Ngọc Duy   2018-09-12 16:18:57 +0000       
2125)           if (istate->version != 4) {
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2129)                   len = flags & CE_NAMEMASK;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2130)                   if (len == CE_NAMEMASK)
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2131)                           len = strlen(name);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2132)                   src_offset += (flags & CE_EXTENDED) ?
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2133) 
ondisk_cache_entry_extended_size(len) :
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2134)                           ondisk_cache_entry_size(len);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2136)                   src_offset += (name - ((char *)ondisk)) + 
expand_name_field(previous_name, name);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2139)   for (i 
= 0; i < nr_threads; i++) {
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2140)           struct load_cache_entries_thread_data *p = data + i;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2141)           if (pthread_join(p->pthread, NULL))
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2142)                   die("unable to join load_cache_entries_thread");
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2143)           mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2144)           consumed += p->consumed;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2147)   
free(data);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2148)   
strbuf_release(&previous_name_buf);
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 2150)   return 
consumed;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2217)                   nr_threads = cpus;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2222)           nr_threads = 3;
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2225)           extension_offset = read_eoie_extension(mmap, mmap_size);
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2226)           if (extension_offset) {
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2228)                   p.src_offset = extension_offset;
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2229)                   if (pthread_create(&p.pthread, NULL, 
load_index_extensions, &p))
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2230)                           die(_("unable to create 
load_index_extensions_thread"));
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2231)                   nr_threads--;
ad570c680bc     ( Ben Peart     2018-09-12 16:18:56 +0000 
2235)           src_offset += load_cache_entries_threaded(nr_threads, 
istate, mmap, mmap_size, src_offset);
4ee45bacad0     ( Ben Peart     2018-09-12 16:18:55 +0000 
2248)           die(_("unable to join load_index_extensions_thread"));
9928a34be6b     ( Ben Peart     2018-09-12 16:18:59 +0000 3288)static 
unsigned long read_eoie_extension(const char *mmap, size_t mmap_size)
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3306)   if 
(mmap_size < sizeof(struct cache_header) + EOIE_SIZE_WITH_HEADER + 
the_hash_algo->rawsz)
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3307)           return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3310)   index 
= eoie = mmap + mmap_size - EOIE_SIZE_WITH_HEADER - the_hash_algo->rawsz;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3311)   if 
(CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3312)           return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3313)   index 
+= sizeof(uint32_t);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3316)   
extsize = get_be32(index);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3317)   if 
(extsize != EOIE_SIZE)
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3318)           return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3319)   index 
+= sizeof(uint32_t);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3325)   offset 
= get_be32(index);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3326)   if 
(mmap + offset < mmap + sizeof(struct cache_header))
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3327)           return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3328)   if 
(mmap + offset >= eoie)
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3329)           return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3330)   index 
+= sizeof(uint32_t);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3341)   
src_offset = offset;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3342)   
the_hash_algo->init_fn(&c);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3343)   while 
(src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
9928a34be6b     ( Ben Peart     2018-09-12 16:18:59 +0000 
3351)           extsize = get_be32(mmap + src_offset + 4);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3354)           if (src_offset + 8 + extsize < src_offset)
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3355)                   return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3357)           the_hash_algo->update_fn(&c, mmap + src_offset, 8);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3359)           src_offset += 8;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3360)           src_offset += extsize;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3362)   
the_hash_algo->final_fn(hash, &c);
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3363)   if 
(hashcmp(hash, (const unsigned char *)index))
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3364)           return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3367)   if 
(src_offset != mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER)
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 
3368)           return 0;
8d44e69943e     ( Ben Peart     2018-09-12 16:18:53 +0000 3370)   return 
offset;
rebase-interactive.c
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
61)             return error_errno(_("could not read '%s'."), todo_file);
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
65)             strbuf_release(&buf);
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
66)             return -1;
a9f5476fbca     (Alban Gruin    2018-08-10 18:51:35 +0200 
74)             return error_errno(_("could not read '%s'."), todo_file);
a9f5476fbca     (Alban Gruin    2018-08-10 18:51:35 +0200 
78)             strbuf_release(&buf);
a9f5476fbca     (Alban Gruin    2018-08-10 18:51:35 +0200 
79)             return -1;
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
85)             return -1;
refs.c
4a6067cda51     (Stefan Beller  2018-08-20 18:24:16 +0000 
1405)           return 0;
revision.c
2abf3503854     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:38 +0200       
1529)           if (ce_path_match(istate, ce, &revs->prune_data, NULL)) {
2abf3503854     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:38 +0200       
1535)           while ((i+1 < istate->cache_nr) &&
2abf3503854     (Nguyễn Thái Ngọc Duy   2018-09-21 17:57:38 +0200       
1536)                  ce_same_name(ce, istate->cache[i+1]))
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2931)           return;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2934)           return;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2937)           c->object.flags |= UNINTERESTING;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2940)           return;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2943)           mark_parents_uninteresting(c);
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2966)           return;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2969)           return;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
2974)           return;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 3018)   case 
REV_SORT_BY_COMMIT_DATE:
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
3019)           info->topo_queue.compare = compare_commits_by_commit_date;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
3020)           break;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 3021)   case 
REV_SORT_BY_AUTHOR_DATE:
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 3022) 
init_author_date_slab(&info->author_date);
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
3023)           info->topo_queue.compare = compare_commits_by_author_date;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
3024)           info->topo_queue.cb_data = &info->author_date;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
3025)           break;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
3038)                   continue;
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 3048) 
record_author_date(&info->author_date, c);
6c04ff30019     (Derrick Stolee 2018-09-21 10:39:32 -0700 
3086)           if (!revs->ignore_missing_links)
6c04ff30019     (Derrick Stolee 2018-09-21 10:39:32 -0700 
3087)                   die("Failed to traverse parents of commit %s",
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 3088) 
oid_to_hex(&commit->object.oid));
4943d288495     (Derrick Stolee 2018-09-21 10:39:36 -0700 
3096)                   continue;
sequencer.c
65850686cf0     (Alban Gruin    2018-08-28 14:10:40 +0200 
2276)           return;
65850686cf0     (Alban Gruin    2018-08-28 14:10:40 +0200 
2373)           write_file(rebase_path_quiet(), "%s\n", quiet);
2c58483a598     (Alban Gruin    2018-08-10 18:51:33 +0200 
3371)                   return error(_("could not checkout %s"), commit);
4df66c40b08     (Alban Gruin    2018-08-10 18:51:34 +0200 
3385)           return error(_("%s: not a valid OID"), orig_head);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4750)           return -1;
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4753)           return -1;
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4759)           return error_errno(_("could not read '%s'."), todo_file);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4762)           todo_list_release(&todo_list);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4763)           return error(_("unusable todo list: '%s'"), todo_file);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4782)           todo_list_release(&todo_list);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4783)           return -1;
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4787)           return error(_("could not copy '%s' to '%s'."), todo_file,
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4791)           return error(_("could not transform the todo list"));
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4820)           return error(_("could not transform the todo list"));
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4823)           return error(_("could not skip unnecessary pick commands"));
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4829)           return -1;
strbuf.c
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
127)                    --sb->len;
wt-status.c
f3bd35fa0dd     (Stephen P. Smith       2018-09-05 17:53:29 -0700       
671)                    s->committable = 1;

jch..pu:

builtin/bisect--helper.c
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
43)             free((void *) terms->term_good);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
162)            if (get_oid_commit(commit, &oid))
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
163)                    return error(_("'%s' is not a valid commit"), 
commit);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
164)            strbuf_addstr(&branch, commit);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
172)                    error(_("Could not check out original HEAD '%s'. 
Try "
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
174)                    strbuf_release(&branch);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
175)                    argv_array_clear(&argv);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
176)                    return -1;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
215)            error(_("Bad bisect_write argument: %s"), state);
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
216)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
220)            error(_("couldn't get the oid of the rev '%s'"), rev);
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
221)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
226)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
230)            error_errno(_("couldn't open the file '%s'"), 
git_path_bisect_log());
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
231)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 242)fail:
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 243)    retval 
= -1;
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
323)            yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
324)            if (starts_with(yesno, "N") || starts_with(yesno, "n"))
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
327)            goto finish;
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
336)            error(_("You need to start by \"git bisect start\". You "
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
341)            goto fail;
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 345)fail:
35f7ca528ae     (Pranit Bauva   2017-10-27 15:06:37 +0000 
387)            return error(_("--bisect-term requires exactly one 
argument"));
35f7ca528ae     (Pranit Bauva   2017-10-27 15:06:37 +0000 
400)                    error(_("BUG: invalid argument %s for 'git 
bisect terms'.\n"
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
416)            return -1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
419)            goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
423)            goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 427)fail:
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 428)    retval 
= -1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
466)                    no_checkout = 1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
488)                     !one_of(arg, "--term-good", "--term-bad", NULL)) {
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
489)                    return error(_("unrecognised option: '%s'"), arg);
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
523)            if (get_oid("HEAD", &head_oid))
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
524)                    return error(_("Bad HEAD - I need a HEAD"));
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
539)                            error(_("checking out '%s' failed. Try 
'git "
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
559)                            return error(_("won't bisect on 
cg-seek'ed tree"));
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
562)                    return error(_("Bad HEAD - strange symbolic ref"));
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
570)            return -1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
588)                    goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
598)                    goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
606)            goto fail;
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
686)                    return error(_("--bisect-reset requires either 
no argument or a commit"));
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
690)                    return error(_("--bisect-write requires either 4 
or 5 arguments"));
20edf353b72     (Pranit Bauva   2017-10-27 15:06:37 +0000 
697)                    return error(_("--check-and-set-terms requires 3 
arguments"));
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
703)                    return error(_("--bisect-next-check requires 2 
or 3 arguments"));
builtin/blame.c
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 922)    case 
DATE_HUMAN:
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
924)            blame_date_width = sizeof("Thu Oct 19 16:00");
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
925)            break;
builtin/gc.c
3029970275b     (Jonathan Nieder        2018-07-16 23:57:40 -0700       
461)            ret = error_errno(_("cannot stat '%s'"), gc_log_path);
3029970275b     (Jonathan Nieder        2018-07-16 23:57:40 -0700       
462)            goto done;
3029970275b     (Jonathan Nieder        2018-07-16 23:57:40 -0700       
470)            ret = error_errno(_("cannot read '%s'"), gc_log_path);
3029970275b     (Jonathan Nieder        2018-07-16 23:57:40 -0700       
585)                            exit(128);
builtin/submodule--helper.c
df255b8cac7     (Brandon Williams       2018-08-08 15:33:22 -0700       
914)            usage(_("git submodule--helper gitdir <name>"));
date.c
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
113)            die("Timestamp too large for this system: %"PRItime, time);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
216)            if (tm->tm_mon == human_tm->tm_mon) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
217)                    if (tm->tm_mday > human_tm->tm_mday) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
219)                    } else if (tm->tm_mday == human_tm->tm_mday) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
220)                            hide.date = hide.wday = 1;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
221)                    } else if (tm->tm_mday + 5 > human_tm->tm_mday) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
223)                            hide.date = 1;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
231)            gettimeofday(&now, NULL);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
232)            show_date_relative(time, tz, &now, buf);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
233)            return;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
246)            hide.seconds = 1;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
247)            hide.tz |= !hide.date;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
248)            hide.wday = hide.time = !hide.year;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
262)            strbuf_rtrim(buf);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
287)            gettimeofday(&now, NULL);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
290)            human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 886)static int 
auto_date_style(void)
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 888)    return 
(isatty(1) || pager_in_use()) ? DATE_HUMAN : DATE_NORMAL;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
909)            return DATE_HUMAN;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
911)            return auto_date_style();
sha1-array.c
7007a318a68     (Stefan Beller  2018-09-11 16:49:44 -0700 
90)                             oidcpy(&array->oid[dst], &array->oid[src]);
string-list.c
6fecf7cd01a     (Stefan Beller  2018-09-11 16:49:43 -0700 
86)             BUG("tried to remove an item from empty string list");
6fecf7cd01a     (Stefan Beller  2018-09-11 16:49:43 -0700 
89)             free(list->items[list->nr - 1].string);
6fecf7cd01a     (Stefan Beller  2018-09-11 16:49:43 -0700 
92)             free(list->items[list->nr - 1].util);
submodule-config.c
cc3e30d6aea     (Antonio Ospite 2018-09-17 16:09:32 +0200 
716)            return CONFIG_INVALID_KEY;
89039393db8     (Antonio Ospite 2018-09-17 16:09:33 +0200 
731)            warning(_("Could not update .gitmodules entry %s"), key);
submodule.c
bab609b4dc1     (Stefan Beller  2018-09-11 16:49:50 -0700 
1369)                   string_list_pop(&spf->retry, 0);
bab609b4dc1     (Stefan Beller  2018-09-11 16:49:50 -0700 
1370)                   goto retry_next;
bab609b4dc1     (Stefan Beller  2018-09-11 16:49:50 -0700 
1429)           warning(_("Could not get submodule repository for 
submodule '%s' in repository '%s'"),
bab609b4dc1     (Stefan Beller  2018-09-11 16:49:50 -0700 
1430)                     sub->path, spf->r->worktree);
df255b8cac7     (Brandon Williams       2018-08-08 15:33:22 -0700       
1884)           die(_("could not create directory '%s'"), new_gitdir.buf);
wrapper.c
7e621449185     (Pranit Bauva   2017-10-27 15:06:37 +0000 
701)            die_errno(_("could not stat %s"), filename);
wt-status.c
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1949)                   if (s->state.rebase_in_progress ||
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 1950) 
s->state.rebase_interactive_in_progress)
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1951)                           branch_name = s->state.onto;
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1952)                   else if (s->state.detached_from)
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1953)                           branch_name = s->state.detached_from;

