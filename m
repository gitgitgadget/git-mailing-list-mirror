Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A221F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfF0RfT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:35:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37075 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0RfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:35:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so2443721qkl.4
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=k67YGAfAr+NXQHsOlNFEJl2Tx9hMy276mSIdVEZl+Tg=;
        b=i0NXy4ZQbIOR8tvWDmWv+DjsL+A8idC5YQLzGB1fAj4vKOlhgoy3Ga7lE9c0ZfghQy
         waMjn61I/4IwjxO+drefL47YNwB09rj1plXxgoN6cMQKb+6nNyG7yNcJBjgV7/CVoG6J
         Ps/Ja4jb1NrH3IbJUSxFMUVKth2pHdt6ieTs6i03IREagOks8xleol3qijtX0Pa8RlFR
         9F0iRbNMfhgFTSgyH4g5KkK9VD5hBCe2JJg4q9aQPHP0La/vgWLUJOiKeLN6ChC3TenE
         3LGaQr+onhOzkg/yUX/BYZpaydoKL8VZt4SM99XjkG3JViEzyp3tpjMp+AdyRznZsNni
         kMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k67YGAfAr+NXQHsOlNFEJl2Tx9hMy276mSIdVEZl+Tg=;
        b=NhJcimNylq1/nLmLsbfBLfeNqgMYCvA0RH+P1L5L9lCvSZMnfNBFxX2qr4/hYNRNLO
         ub3mgCEYYzuJh6M4iiZUXX8U83uT1BjdENC6c8t/Z8xDfUrKmaZyq5eWFVSI98wuI7J0
         LtIdlXR0d6eoZrGHSg9sd2Ytc81jUak6izSS4yla4DeTLLA0ahKG33t2T1VY1NxIFq2s
         4+iB+/5dt0jdutEqxUpuPXW2mIrxEJSVgfmOICEeyOrHLverfN87Lkv6n7h5MmPV9mMq
         LalH2oHRybI4N1apKv7H3jdpmTeirFLGDWbeAE1B+HhtQLQiC69dya01MflEu6hpyP29
         Z++g==
X-Gm-Message-State: APjAAAXdUqQ0cjUhmcLlmVUtMgv3vdEbdLbT86wnSelj8Z2Fi63WYRJx
        1v3pxXZWvDVaEWZTOUic7q1pkkNy
X-Google-Smtp-Source: APXvYqzawK7kT3gXG6uxks7p+zA0eCza+VKiGDjyyKl5kWlepSOgcB95odYYWT9ZyntYnpAtw6ScIg==
X-Received: by 2002:ae9:c106:: with SMTP id z6mr4661567qki.285.1561656918506;
        Thu, 27 Jun 2019 10:35:18 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9905:3db8:5a6f:f512? ([2001:4898:a800:1010:4a3b:3db8:5a6f:f512])
        by smtp.gmail.com with ESMTPSA id g53sm1540354qtk.65.2019.06.27.10.35.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:35:17 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thurs. June 27)
From:   Derrick Stolee <stolee@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
Message-ID: <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
Date:   Thu, 27 Jun 2019 13:35:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some interesting sections I found when examining the test coverage
report. I am only highlighting these sections because they seem to include
non-trivial logic. In some cases, maybe the code isn't needed.

On 6/27/2019 1:05 PM, Derrick Stolee wrote:
> promisor-remote.c
> db27dca5 25) die(_("Remote with no URL"));
> 48de3158 61) warning(_("promisor remote name cannot begin with '/': %s"),
> 48de3158 63) return NULL;
> faf2abf4 93) previous->next = r->next;
> 4ca9474e 108) return git_config_string(&core_partial_clone_filter_default,
> fa3d1b63 139) return 0;
> 9e27beaa 202) static int remove_fetched_oids(struct repository *repo,
> 9e27beaa 206) int i, remaining_nr = 0;
> 9e27beaa 207) int *remaining = xcalloc(oid_nr, sizeof(*remaining));
> 9e27beaa 208) struct object_id *old_oids = *oids;
> 9e27beaa 211) for (i = 0; i < oid_nr; i++)
> 9e27beaa 212) if (oid_object_info_extended(repo, &old_oids[i], NULL,
> 9e27beaa 214) remaining[i] = 1;
> 9e27beaa 215) remaining_nr++;
> 9e27beaa 218) if (remaining_nr) {
> 9e27beaa 219) int j = 0;
> 9e27beaa 220) new_oids = xcalloc(remaining_nr, sizeof(*new_oids));
> 9e27beaa 221) for (i = 0; i < oid_nr; i++)
> 9e27beaa 222) if (remaining[i])
> 9e27beaa 223) oidcpy(&new_oids[j++], &old_oids[i]);
> 9e27beaa 224) *oids = new_oids;
> 9e27beaa 225) if (to_free)
> 9e27beaa 226) free(old_oids);
> 9e27beaa 229) free(remaining);
> 9e27beaa 231) return remaining_nr;
> 9e27beaa 248) if (remaining_nr == 1)
> 9e27beaa 249) continue;
> 9e27beaa 250) remaining_nr = remove_fetched_oids(repo, &remaining_oids,
> 9e27beaa 252) if (remaining_nr) {
> 9e27beaa 253) to_free = 1;
> 9e27beaa 254) continue;
> 9e27beaa 262) free(remaining_oids);

Christian: this section continues to be untested, but I think you were
working on creating tests for this.

> repo-settings.c
> 0a01e977 13) int rate = git_config_int(key, value);
> 0a01e977 14) if (rate >= 3) {
> 0a01e977 15) UPDATE_DEFAULT(rs->core_commit_graph, 1);
> 0a01e977 16) UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
> c5c84f32 17) UPDATE_DEFAULT(rs->index_version, 4);
> 3172404b 19) if (rate >= 5) {
> 3172404b 20) UPDATE_DEFAULT(rs->pack_use_sparse, 1);
> 0a01e977 22) return 0;

These are mine. Since no one has been complaining about the design
of core.featureAdoptionRate in ds/early-access [1], I'll move forward
to add some tests for this setting. It may come in the form of a
GIT_TEST_ADOPTION_RATE environment variable so it has wider coverage
across the test suite. I may even add explicit tests that demonstrate
the new defaults enabled by core.featureAdoptionRate are overridden by
explicit config settings. index.version is a good candidate.

[1] https://public-inbox.org/git/pull.254.v2.git.gitgitgadget@gmail.com/

> t/helper/test-match-trees.c
> 3fe87a7f 23) shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);

Duy: here is another example of a conversion to "struct repository *" but
since it is using the_repository here it is definitely safe (no worse than before).

> builtin/fetch.c
> cdbd70c4 88) fetch_show_forced_updates = git_config_bool(k, v);
> cdbd70c4 89) return 0;

Mine again. I should explicitly test the fetch.showForcedUpdates config option,
especially against the '--no-show-forced-updates' argument (to show the argument
wins).

> builtin/pull.c
> 3883c551 556) argv_array_push(&args, "--show-forced-updates");
> 3883c551 558) argv_array_push(&args, "--no-show-forced-updates");

Not sure if this is super-important to test. It's a simple argument pass-through.
But also maybe I change my 'git fetch' tests to be 'git pull' tests and it covers
the 'git fetch' builtin at the same time.

> dir.c
> 3b2385cf 2840) static void jw_object_untracked_cache_dir(struct json_writer *jw,
> 3b2385cf 2845) jw_object_bool(jw, "valid", ucd->valid);
> 3b2385cf 2846) jw_object_bool(jw, "check-only", ucd->check_only);
> 3b2385cf 2847) jw_object_stat_data(jw, "stat", &ucd->stat_data);
> 3b2385cf 2848) jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
> 3b2385cf 2849) jw_object_inline_begin_array(jw, "untracked");
> 3b2385cf 2850) for (i = 0; i < ucd->untracked_nr; i++)
> 3b2385cf 2851) jw_array_string(jw, ucd->untracked[i]);
> 3b2385cf 2852) jw_end(jw);
> 3b2385cf 2854) jw_object_inline_begin_object(jw, "dirs");
> 3b2385cf 2855) for (i = 0; i < ucd->dirs_nr; i++) {
> 3b2385cf 2856) jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
> 3b2385cf 2857) jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
> 3b2385cf 2858) jw_end(jw);
> 3b2385cf 2860) jw_end(jw);
> 3b2385cf 2861) }
> 3b2385cf 2958) jw_object_inline_begin_object(jw, "root");
> 3b2385cf 2959) jw_object_untracked_cache_dir(jw, uc->root);
> 3b2385cf 2960) jw_end(jw);

Duy: I know you were working on some tests for these options. This is specifically
in the "untracked cache" mode, so enabling the cache with at least one entry and
running --debug-json should be sufficient.

> pack-bitmap-write.c
> 05805d74 378) static struct ewah_bitmap *find_reused_bitmap(const struct object_id *oid)
> d2bc62b1 385) hash_pos = kh_get_oid_map(writer.reused, *oid);
> 05805d74 425) reused_bitmap = find_reused_bitmap(&chosen->object.oid);
> 05805d74 432) reused_bitmap = find_reused_bitmap(&cm->object.oid);

Peff: it is interesting that these portions are not covered previously. (Your change
is clearly mechanical and does not change the correctness.) In particular, lines 425
and 432 are in two blocks of an if/else with one further inside a loop. The loop
should always have at least one run, so this if/else isn't even covered.

> read-cache.c
> 8eeabe15 1752) ret = error(_("index uses %.4s extension, which we do not understand"),
> ee70c128 1754) if (advice_unknown_index_extension) {
> ee70c128 1755) warning(_("ignoring optional %.4s index extension"), ext);
> ee70c128 1756) advise(_("This is likely due to the file having been written by a newer\n"
> 272b3f2a 2026) jw_object_true(jw, "assume_unchanged");
> 272b3f2a 2030) jw_object_true(jw, "skip_worktree");
> 272b3f2a 2032) jw_object_intmax(jw, "stage", ce_stage(ce));
> f0f544da 2309) ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
> f0f544da 3651) static struct index_entry_offset_table *read_ieot_extension(
> f0f544da 3673) return do_read_ieot_extension(istate, index, extsize);

Duy: more JSON output cases that could be interesting to cover.

> t/helper/test-example-decorate.c
> 0ebbcf70 29) one = lookup_unknown_object(&one_oid);
> 0ebbcf70 30) two = lookup_unknown_object(&two_oid);
> 0ebbcf70 59) three = lookup_unknown_object(&three_oid);

Peff: again interesting that these lines you refactored were not covered, especially
because they are part of a test helper. Perhaps the tests they were intended for are
now defunct?
 
> t/helper/test-oidmap.c
> 11510dec 52) if (get_oid(p1, &oid)) {
> 11510dec 53) printf("Unknown oid: %s\n", p1);
> 11510dec 54) continue;
> 11510dec 58) FLEX_ALLOC_STR(entry, name, p2);
> 11510dec 59) oidcpy(&entry->entry.oid, &oid);
> 11510dec 62) oidmap_put(&map, entry);

Christian: this block looks like the test-oidmap helper never uses the "add"
subcommand. Is that correct?

> 11510dec 97) if (get_oid(p1, &oid)) {
> 11510dec 98) printf("Unknown oid: %s\n", p1);
> 11510dec 99) continue;
> 11510dec 103) entry = oidmap_remove(&map, &oid);
> 11510dec 106) puts(entry ? entry->name : "NULL");
> 11510dec 107) free(entry);

Similarly, this block means we are not using the "remove" subcommand.


Thanks,
-Stolee
