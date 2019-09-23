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
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C061F464
	for <e@80x24.org>; Mon, 23 Sep 2019 14:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfIWOAl (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 10:00:41 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:45333 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfIWOAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 10:00:41 -0400
Received: by mail-qk1-f182.google.com with SMTP id z67so15438689qkb.12
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qu2pqwO3oQIBo8XHN09wf/VXuvNa/5zEKlYi94NYGQo=;
        b=OH4ekwvrwNflSoNFUkWz+hmPBuRwXgrqd6xO1WSsoXXue6wSWvO1N+2Cgtph6RzJTo
         afcZuC+6LzgQeoQlEd2csTV/8vXo4OK5CLdvZLHyZ9TYrnBlE3/saiWE03qJzcjBbc8q
         5jkGcXT/ndKiDyXgWnfv+jxTe+SR9VjrwbKIyeDQhymfwEZ3AUKHeBlzh4LTocLGVGr9
         bp81Eps9AeoM7VzT5xVp9kSkbqWIpjvFJIlu5pdHz/Hjz7Cx6AROpVvPu4Il1cZEiKys
         XCwsw/NZ8s29MDNhfr4x8bZ91p63rua448O87UNAkkRElbEZ3Eczbl2Pa9bjL/g+K9ht
         b5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qu2pqwO3oQIBo8XHN09wf/VXuvNa/5zEKlYi94NYGQo=;
        b=G6hvWv5FQ8WbPBADUUuZu51FRTRJuTZqq6pJsE2dze/QE2WbWtjhh4pr7B4ecxmezJ
         fGAK8FnmcjKLpcicne0CnrzHaq2tMNBM40U8F6P4ncIHIyzXU5v7fpIlLMsMWhvtW1oB
         TKgmbVlGBO6xW8B9tSHjcs8Tk++Ky9ROyOcJe4XI6UVMSBc1GfauXkDWOc+8qDi8dteJ
         Io+zJMJbFvbLBgf1OdhLxIjTtDPEyLovXXPAOhwaODC652UYZxjGsdxk3K06gf6yf0N3
         177Vqg4JvJS9O4d0EFCJAtw7RAN7ZTPnJokOIRvd70zM71zvhK0naKjtJg9eHH/3B0Ne
         isTg==
X-Gm-Message-State: APjAAAV/QWMrSX3TM3wYoAuffnwAm0o7moua4nuK0BJfvOodMM8f7OBJ
        3VvLaSY8K9j/U5ANnl6+mtH19DvYIp0=
X-Google-Smtp-Source: APXvYqyfIRo8UeYtFYbMC2TX8C3+gBU1uVC5G/AYbKoFl37J74bTcRko4c/ANxS7uBsQAb0h1IXxgA==
X-Received: by 2002:a37:b4c2:: with SMTP id d185mr17707540qkf.450.1569247240022;
        Mon, 23 Sep 2019 07:00:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8434:a619:c799:e8af? ([2001:4898:a800:1010:356a:a619:c799:e8af])
        by smtp.gmail.com with ESMTPSA id g31sm7212954qte.78.2019.09.23.07.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 07:00:38 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Sept 19)
From:   Derrick Stolee <stolee@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <9fdd15ab-b2dc-f5fa-9969-90bd57014ff5@gmail.com>
Cc:     rohit.ashiwal265@gmail.com, philip.wood123@gmail.com,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Message-ID: <1ed86989-9ba2-0cd7-b6f7-654d1943b1d7@gmail.com>
Date:   Mon, 23 Sep 2019 10:00:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <9fdd15ab-b2dc-f5fa-9969-90bd57014ff5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 10:23 AM, Derrick Stolee wrote:
> Here is today's test coverage report.

And I took a close look at the report, looking for interesting cases
that are not covered. Most of the uncovered lines were due to simple
refactors or error conditions. I point out a few below that took a
bit of digging to consider.

> sequencer.c
> ccafcb32 884) static char *read_author_date_or_null(void)
> ccafcb32 888) if (read_author_script(rebase_path_author_script(),
> ccafcb32 890) return NULL;
> ccafcb32 891) return date;

This method was added by this commit, but is not tested.
> ccafcb32 983) int res = -1;
> ccafcb32 984) struct strbuf datebuf = STRBUF_INIT;
> ccafcb32 985) char *date = read_author_date_or_null();
> ccafcb32 987) if (!date)
> ccafcb32 988) return -1;
> ccafcb32 990) strbuf_addf(&datebuf, "@%s", date);
> ccafcb32 991) res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
> ccafcb32 993) strbuf_release(&datebuf);
> ccafcb32 994) free(date);
> ccafcb32 996) if (res)
> ccafcb32 997) return -1;

These lines are inside an 'if (opts->committer_date_is_author_date)'
block, and there is another block that _is_ covered.

(Philip already pointed this out in his review. Thanks!)

> 7258d3d1 912) static void push_dates(struct child_process *child)
> 7258d3d1 914) time_t now = time(NULL);
> 7258d3d1 915) struct strbuf date = STRBUF_INIT;
> 7258d3d1 917) strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
> 7258d3d1 918) argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
> 7258d3d1 919) argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
> 7258d3d1 920) strbuf_release(&date);
> 7258d3d1 921) }
> 7258d3d1 1016) push_dates(&cmd);
> 7258d3d1 1488) res = -1;
> 7258d3d1 1489) goto out;
> 7258d3d1 3605) push_dates(&cmd);

Similarly, the "push_dates()" method is not covered.

---

> builtin/pack-objects.c
> 7c59828b 2694) (reuse_packfile_bitmap &&
> 7c59828b 2695)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

This change to obj_is_packed(oid) is a small change in a
really big commit. Here is the change:

@@ -2571,7 +2706,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 
 static int obj_is_packed(const struct object_id *oid)
 {
-       return !!packlist_find(&to_pack, oid, NULL);
+       return packlist_find(&to_pack, oid, NULL) ||
+               (reuse_packfile_bitmap &&
+                bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
 }

So, every time this is called, the || is short-circuited because
packlist_find() returns true.

Does this change the meaning of this method? obj_is_packed() would
only return true if we found the object specifically in the to_pack
list. Now, we would also return true if the object is in the bitmap
walk.

If this is only a performance improvement, and the bitmap_walk_contains()
method would return the same as packlist_find(), then should the order
be swapped? Or rather, should reuse_packfile_bitmap indicate which to use
as the full result?

> d35b73c5 2847) allow_pack_reuse = git_config_bool(k, v);
> d35b73c5 2848) return 0;

I initially thought that introducing an untested config setting is
generally not a good idea, but allow_pack_reuse is on by default.
This config setting is just a safety valve to turn the feature _off_
if necessary.

--- 
> builtin/checkout.c
> 65c01c64 766) strbuf_add_unique_abbrev(&old_commit_shortname,
> 65c01c64 767)  &old_branch_info->commit->object.oid,
> 65c01c64 769) o.ancestor = old_commit_shortname.buf;

The entire point of this commit is to modify the output during
a 'git checkout -m' in a detached HEAD case. Odd that a test
was not added to demonstrate the expected output change.

Since the point of the test coverage report is to find places
where a bug may exist or may appear later, this block may be
small enough to ignore.

> cache-tree.c
> 724dd767 619) cache_tree_free(&index_state->cache_tree);
> 724dd767 620) cache_tree_valid = 0;
> 724dd767 633) return WRITE_TREE_PREFIX_ERROR;
> 724dd767 653) fprintf(stderr, "BUG: There are unmerged index entries:\n");
> 724dd767 654) for (i = 0; i < index_state->cache_nr; i++) {
> 724dd767 655) const struct cache_entry *ce = index_state->cache[i];
> 724dd767 656) if (ce_stage(ce))
> 724dd767 657) fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
> 724dd767 658) (int)ce_namelen(ce), ce->name);
> 724dd767 660) BUG("unmerged index entries when writing inmemory index");

These uncovered lines were moved during a refactor, which means they
were uncovered before. Lots of strange branching happening here, but
it must be in very rare cases.
 
> connect.c
> ebb8d2c9 921) path = host - 2; /* include the leading "//" */

> setup.c
> e2683d51 952)     !is_dir_sep(dir->buf[min_offset - 1])) {
> e2683d51 953) strbuf_addch(dir, '/');
> e2683d51 954) min_offset++;

(These lines are artifacts of not running test coverage on Windows.)

> promisor-remote.c

(We have discussed the test coverage for multiple promisor remotes before.)
 
---

Thanks, everyone. Things are looking good.

-Stolee

