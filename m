Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A882070D
	for <e@80x24.org>; Fri,  8 Jul 2016 15:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbcGHPBW (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 11:01:22 -0400
Received: from mout.web.de ([212.227.15.14]:61565 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754863AbcGHPBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 11:01:21 -0400
Received: from [192.168.209.22] ([195.252.60.88]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MT4xK-1atSZC3R0I-00SAMb; Fri, 08 Jul 2016 17:01:13
 +0200
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
To:	Junio C Hamano <gitster@pobox.com>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
 <1467100876-2803-1-git-send-email-tboegi@web.de>
 <xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
 <62eb3d75-126e-427b-8701-d490e80e3501@web.de>
 <xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
 <574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
 <xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
 <c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
 <xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <30eb6711-a559-155b-d068-c7ab94f32871@web.de>
Date:	Fri, 8 Jul 2016 17:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:viW/WBEp2IWARuI+HhkxswlJvA/wfPZOHsKmKMZkiZlyjb+t961
 X57WNBQVVDOfJdS/eWuTZxJa7H3I4Q0YLKBWDe4yq9+bUbD5UjJYfiqZucF9SgHGIA2EHx6
 yvVor2EZvDzJJRBmYVM4JuqhfmB8JhKmzhb1D+JHeKj75TXHfQFVgByiRcX0lUi0XejykR0
 emIEnBLK/uNoqwAZVqScg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:L3CEzXcETj8=:YoxzS9riAIvjZ9PGMtXkra
 hUr7I8bmMRaqlGD3aeDRUmJ/42gZywG8RGamrVZH/Wmb5Y6BJffDpDOVFXITCXdgRVAo4TN9Q
 XkyMc1fyIlMGIBfIU1wtHTPc6I3SaFOc/n7C+zJEETd5GAcZPmHG8/6lZq+UhCFiCWAMGzrDn
 Hz1t8icAYQW50Xv7b9OqlyJvT4+vxA9DS4CcnKuaYesc4W7dGrWFfBBlK+xLr2JmKX8qw+7Yd
 aI32y84ddBVNPFfvuki65su67N8nxFt1G81pssFJwfTNuig6DHzBxIM2Uckw83cJ7dH0ckwQy
 wVwqtOeuN9MWKeB4ImKqZSzIGd8kZAKhDTsOSCOsbD+xkf60Xa/kkcOv3gIdEHfPkQmCUgK7/
 MXlxI9oVQb56aDTbof9TkcfqFj0xevtfpNtnEb2NQvHLzu2ZI8/YQjGIROZ422f3B7SewpWAQ
 4xNYrqxlNHJjA22/V5sI4IM+d7flV6RrM7+DY1iDjrqIYQVnSLURX0U9gN1RfIZsrjbfetR+0
 7ffFYd5FSYI9JoPlyUn8pHt6XneQXSEJ01wsx2Anu9w1pPO+Wmwg6paGsBdrjW2RKsURICJqp
 pVlJ0qvCo2i9qN2SeYXaVJA3V3q9OB67Jm63oKOunc5rKpVgDeDKru38qaZtoALH6MD8yFLjB
 K93/HBs9AFLya9ICuFU7rNVkMzQ6WJwPDjQntXLcqJ1rpJfgfq0QkhSetOUpuLBhw4AuubnX9
 3SBIoUsCdX75SPquvCBYjyxTGhxooLOIYEiiOpx7hxYgY6bMHzOIZZDgAnzUegSvvDHAernVv
 RZ0Axfe
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/07/16 20:43, Junio C Hamano wrote:
 > Torsten Bögershausen <tboegi@web.de> writes:
 >
 >> This is the call stack:
 >>
 >> merge-recursive.c/add_cacheinfo(unsigned int mode, const unsigned 
char *sha1,
 >> 		const char *path, int stage, int refresh, int options)
 >> {
 >> 	struct cache_entry *ce;
 >> 	ce = make_cache_entry
 >> 	if (!ce)
 >> 		return error(_("addinfo_cache failed for path '%s'"), path);
 >> 	return add_cache_entry(ce, options);
 >> }
 >> #Calls
 >> read-cache.c/make_cache_entry(path=file sha1=0x99b633 stage=0)
 >>
 >>
 >> struct cache_entry *make_cache_entry(unsigned int mode,
 >> 		const unsigned char *sha1, const char *path, int stage,
 >> 		unsigned int refresh_options)
 >> {
 >>         [snip]
 >> 	ret = refresh_cache_entry(ce, refresh_options);
 >> 	if (ret != ce)
 >> 		free(ce);
 >> 	return ret;
 >> }
 >>
 >> #Calls
 >> refresh_cache_ent(&the_index, ce, options, NULL, NULL);
 >>
 >> #Calls
 >> ie_modified()
 >>
 >> #Calls
 >> read-cache.c/ie_match_stat()
 >>
 >> #Calls
 >> changed |= ce_modified_check_fs(ce, st);
 >>
 >> #Calls
 >> ce_compare_data(path=file sha1=0x99b633)
 >>
 >> #Calls
 >> index_fd(..., ..., ce->name, ...)
 >> #Note the sha is lost here, the parameter sha is the output.
 >>
 >> Deep down, has_cr_in_index(path) will look at ad55e2 instead,
 >> which is wrong.
 > The call to add_cacheinfo() is made with 99b633 to record the 3-way
 > merge result to the index in this callchain:
 >
 >  merge_trees()
 >  -> git_merge_trees()
 >  -> process_renames() # does nothing for this case
 >  -> process_entry()
 >     -> merge_content()
 >        -> merge_file_special_markers()
 >           -> merge_file_1()
 >              -> merge_3way()
 >                 -> ll_merge() # correctly handles the renormalization
 >              -> write_sha1_file() # this is what gives us 99b633
 >     -> update_file() # this is fed the 99b633 write_sha1_file() computed
 >        -> update_file_flags()
 >           -> read_sha1_file() # reads 99b633
 >           -> convert_to_working_tree()
 >           -> write_in_full() # updates the working tree
 >           -> add_cacheinfo() # to record 99b633 at "file" in the index
 >
 > So refresh() may incorrectly find that 99b633 does not match what is
 > in the filesystem if it looks at _any_ entry in the index.  We know
 > we have written the file ourselves, so by definition it should match
 > ;-)

Does it, always ?
There was a lengthy discussion around January, if
git checkout -f
should always give a clean workspace.
(My suggestion was yes, please), but the conclusion
was to always check the other way around:
What would "git add" say ?
If the smudge/clean don't provide
a round trip, then the worktree should not be clean.

My understanding is, that after merge, the filters must be round trip
(and all other conversions), otherwise the merge willl fail.

In this case the merge fails because of a bug in Git.
