Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010102023C
	for <e@80x24.org>; Fri,  8 Jul 2016 07:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbcGHHxA (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 03:53:00 -0400
Received: from mout.web.de ([212.227.15.14]:55380 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbcGHHw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 03:52:58 -0400
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M8oFY-1b9MJK18ns-00C8ch; Fri, 08 Jul 2016 09:52:34
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
Message-ID: <2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
Date:	Fri, 8 Jul 2016 09:52:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9TLSwimVwvtfouHyLLSz1ypnKaS5sgyQ5+JKo001efRb7iO48Or
 241wMUAggY7kmVAg0K26xRU1xH3B1kf9cV3Wp8I2biMHwiwAaEd13gWQ8/4wHxmYRlmHqVf
 +pK8q2U3wkgPIR21+aIdjcuFuj1BzAah0dmTIlmM35xovyZ1RL9lOhIq/Jj7W/dSv5bH573
 O8kZEpcIKqmIhVBK3GZSQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Txdr+OFM4ns=:P90yUyvlqQHq572/bCNth1
 yEEpBiw/rrQhVCJ5+5S+ORuQeYJByqXN2/hHoFINKAclxCcAbYlpLgOCkKv0Ef6tlsuClhVNO
 nVP0f802QnVCHvCOvxOiMgrpadJDkf5MyolR0N9c0qjPKjssSmz3kRD6jD7gC8tzU0VLC6FEz
 twaiRag8UfPY1uZ5dRFLqdMrzUJ/t5Up9+icRFS/mr+LMLwU7jr66GtG0Y7Azu5pNmfokDGOT
 VOWrBumR1HmJSjHQn7Gij+ToUPMwg8CpAhY4MC8Zr9mA5l23drMFcveMXubw+C8WLgz56phoD
 LpZKVfFXjUJTvblhRRCy63kQP9iEf2G4W7FkbpP7+lq12Sj8+0gSVD40u2GP56BvL/YChmfrl
 1m/1wcE1G2X9gFqJHq/Qv7/626p0z+sZRs9kVPJ2X2WNAoo9uDtW8XRz0W/0Yhklhxvn6+19N
 R0b54k0Xv9pwSl9kWy7xa0+j1BEfyKjFm7PYPURR9mk0T9I/VZfF8+QmewY5thONitCtxhgpL
 pG1o/dcKpdKgu8+T8rXnfM4ujxnv5ESBxSDQ1pwWJyeJrgJALmNfblPlhFkE/h464i1L5J71G
 pLTyvIOm1uBt2RpQMHwMV4v9bSfedpKjxIFPOVdQg5oUoKsavOjYIylp+SIc0WFPoyzvd6NPK
 g3o0WiI3/oeuXy7jKRv9KCn/K92y6pGD48eI3Db31O8uNWPl0GTX0ExJPDNv+wboybY0o6rpx
 pAlVxvwHdyr/2Cw6oXjNYaRsq9IASDUBsCncVAS3/mmq0MhnvyKc0yeLrowtHBkrwFrDb+Ffh
 Z2jtu7O
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/07/16 20:43, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
>> This is the callstack:
>>
>> merge-recursive.c/add_cacheinfo(unsigned int mode, const unsigned char *sha1,
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
>>          [snip]
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
>   merge_trees()
>   -> git_merge_trees()
>   -> process_renames() # does nothing for this case
>   -> process_entry()
>      -> merge_content()
>         -> merge_file_special_markers()
>            -> merge_file_1()
>               -> merge_3way()
>                  -> ll_merge() # correctly handles the renormalization
>               -> write_sha1_file() # this is what gives us 99b633
>      -> update_file() # this is fed the 99b633 write_sha1_file() computed
>         -> update_file_flags()
>            -> read_sha1_file() # reads 99b633
>            -> convert_to_working_tree()
>            -> write_in_full() # updates the working tree
>            -> add_cacheinfo() # to record 99b633 at "file" in the index
>
> So refresh() may incorrectly find that 99b633 does not match what is
> in the filesystem if it looks at _any_ entry in the index.  We know
> we have written the file ourselves, so by definition it should match
> ;-) Even though I am not sure why that should affect the overall
> correctness of the program (because we have written the correct
> result to both working tree and to the index), this needs to be
> fixed.
>
> I am however not convinced passing the full SHA-1 is a good
> solution.
It seems at least that this is the correct way to do it.
> The make_cache_entry() function may be creating a cache
> entry to stuff in a non-default index (i.e. not "the_index"), but
> its caller does not have a way to tell it which index the resulting
> cache entry will go, and calls refresh_cache_entry(), which always
> assumes that the caller is interested in "the_index", so what
> add_cacheinfo() does by calling make_cache_entry() feels wrong in
> the first place.  Also, the call from update_file_flags() knows that
> the working tree is in sync with the resulting cache entry.
>
> Perhaps update_file_flags() should not even call add_cacheinfo()
> there in the first place?  I wonder if it should just call
> add_file_to_index()---after all, even though the current code
> already knows that 99b633 _is_ the result it wants in the index, it
> still goes to the filesystem and rehashes.
>
> I dunno.  I really do not like that extra sha1 argument added all
> over the callchain by this patch.
>
> Or did you mean other calls to add_cacheinfo()?
I didn't mean too much - the whole call chain touches code where I am not able to
comment on details.
I'm happy to test other implementations, if someone suggests a path, so to say.




