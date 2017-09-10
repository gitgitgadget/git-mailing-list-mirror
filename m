Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DE41FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 06:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbdIJG1p (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 02:27:45 -0400
Received: from mout.web.de ([212.227.17.11]:62620 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbdIJG1o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 02:27:44 -0400
Received: from [192.168.178.36] ([91.20.62.83]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4IAh-1dZwlT3735-00rtDf; Sun, 10
 Sep 2017 08:27:40 +0200
Subject: Re: [PATCH 06/34] clone: release strbuf after use in remove_junk()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175005.20756-7-l.s.r@web.de>
 <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0884b528-d455-09c6-0eaf-d2af50077a98@web.de>
Date:   Sun, 10 Sep 2017 08:27:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:K63U/qprlVKkR8ZhFNrWVfsEjr1izu1S1OaWkfhYz4VXa0VjV+0
 5tKIlzx3u07GBKqu9MQuDviNBfOzHHrGT3C4WIu82GQiJcCAlVRNG5OD/7MXTMP98FsoC1h
 dF8psTfnhVl+d4HzfKBVpYc/2zG1UmPqpkfQO8y6qAqbqIOI3OMJeRww/sv/9lHsnSERlMb
 ghzGnYuM9wPa12wGPgAfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:esR5QWxiwaM=:NIgwikzamTsspPgiiRMnBU
 nc8k9A3Lihkt8qtUVbNZoga1guost2B00DoFaoNA2VUaRLsXKKmyjGKT4fJqdZlyVTZou99rn
 Fzr9i6001j/6zPCUC4B/n7qTCnKs3d5khWbLAUGZMJp5csilWlVzP2Ub/iwKK09bsrVy5RLPv
 2ll5YxPYRXzr7bCSSY0yQ70PPNcX75uS8rumBhAa/Spb13enWHxJ+h0CHsmn+F13gMHYKEMkc
 hOEOprDLGjGF6fhdWj8Zb/F90bmBASZkPlIDKAe4x2GKYcDcwP7eiCpjH3zGP60w73dRB/V6a
 CrljdRxC+RD/Or79dd8NqJALJX1nV3tb7b1nWaun1fIcrwQEa6CN7MI7rNL3Mw+K/rLUFvuRV
 ko/o9FISn8elh+UUKX28aZul2TH+e3hRr0zqZg0rGoMxV9O9eUR4GIvZg8/D67jOw86cU0zXd
 OjduIogO1p84wAdIYVsbkUNgGzUYE3PpismQUow1W2IqyjOB7YFMAG/W+GVRruKGz2Inu4ils
 1xrZ1BQhSrB8c0KRQ5itJ7aOYbJI2bD17pehZ85n81dZnuTAdWwINJB7dNRA9a4slEVgCv9KA
 9OnM3+0bddOfQqjHBT2OFcZiyWC0Ray0Y5xrshOCbfPG9vomwR/Jfj6xivhEIG4fvLzK628u0
 c+XusQBgr7oS0FNW7RFYRjjC0AfwRexkMXerW+8+WzxhC+rx6d4jrfyPlFcWrq/nunf5CxuBA
 xC6ILIj08+Yz1m0ayEGXCW51h2okkwKrC5dnD0TdAYbmWPh91KbEp/iwJqZ5MQgyh9thFmeZV
 bzufveK2CUALH2glY1s1MbOt+7u6WmwyMOz+4yLkKhi74A2dnU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.09.2017 um 21:51 schrieb Junio C Hamano:
> Rene Scharfe <l.s.r@web.de> writes:
> 
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   builtin/clone.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 8d11b570a1..dbddd98f80 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -487,28 +487,28 @@ N_("Clone succeeded, but checkout failed.\n"
>> ...
>>   	if (junk_git_dir) {
>>   		strbuf_addstr(&sb, junk_git_dir);
>>   		remove_dir_recursively(&sb, 0);
>>   		strbuf_reset(&sb);
>>   	}
>>   	if (junk_work_tree) {
>>   		strbuf_addstr(&sb, junk_work_tree);
>>   		remove_dir_recursively(&sb, 0);
>> -		strbuf_reset(&sb);
>>   	}
>> +	strbuf_release(&sb);
>>   }
> 
> The code definitely needs a _release() at the end, but I feel
> lukewarm about the "if we are about to _release(), do not bother to
> _reset()" micro-optimization.  Keeping the existing two users that
> use sb as a (shared and reused) temporary similar would help those
> who add the third one or reuse the pattern in their code elsewhere.

That's not intended as an optimization, but as a promotion -- the reset
is moved to the outer block and upgraded to a release.  The result is
consistent with builtin/worktree.c::remove_junk().

> We could flip the "be nice to the next user by clearing after use"
> pattern to "clear any potential cruft before you use", i.e.
> 
> 	if (...) {
> 		strbuf_reset(&sb);
> 		strbuf_addstr(&sb, ...);
> 	}
> 	if (...) {
> 		strbuf_reset(&sb);
> 		strbuf_addstr(&sb, ...);
> 	}
> 	strbuf_release(&sb);
> 
> but that still tempts us for the same micro-optimization at the
> beginning where sb hasn't been used since STRBUF_INIT, so it is not
> a real "solution".

If code reuse is the goal then a different micro-optimization is more
of a hindrance IMHO: Reusing the same strbuf for both deletions.  A
deletion function that takes a plain string and handles strbuf
formalities for the caller would have avoided the leak, be easier to
use for deleting a third file and probably not have a measurable
performance impact due to the low number of calls.

René
