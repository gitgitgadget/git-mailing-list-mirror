Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03DA209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 21:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbdIKVkS (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 17:40:18 -0400
Received: from mout.web.de ([212.227.15.3]:63597 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbdIKVkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 17:40:17 -0400
Received: from [192.168.178.36] ([91.20.62.83]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1Fua-1dcKzx0bsW-00tC3f; Mon, 11
 Sep 2017 23:40:09 +0200
Subject: Re: [PATCH 06/34] clone: release strbuf after use in remove_junk()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175005.20756-7-l.s.r@web.de>
 <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
 <0884b528-d455-09c6-0eaf-d2af50077a98@web.de>
 <20170910073002.hg6tqgm2z7owqr2u@sigill.intra.peff.net>
 <7a30c171-22c8-4ae3-3e15-3f4eea893127@web.de>
 <20170910173826.jopzzt5cpc2i3c6m@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1c0918c7-8630-e545-6c34-ab03995797bb@web.de>
Date:   Mon, 11 Sep 2017 23:40:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170910173826.jopzzt5cpc2i3c6m@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:vsEOsbtWSTR0sFaqPUX7LODj2/In/03tbitTc4HZ6qmbhoiFKM2
 bvjlQMsij3oLE3oFbeo4qYVSuuyVr/5eXx0rZPzHNeoPJxQ4xZ7GlmYrbZEwLQI5Rf86/Dq
 lyFiC1cjVbRGERxaWomBegx/tYz5kNpfCTmpWCsj/yJ8dIk4p1813TKbtSHLbtX06k6GlPC
 Q4L8JEWa7LJU0xxEaNWfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M5Hz9Hb4fqI=:KkU8OT6ykhIq/mOvZaR/wX
 LXPajpMl1utt89p4zWc2AG3dQx68fM0OkH0SkeUzbQZqwb9cChTI1XPFY3wyu0c+WyyeDmLz9
 aio2Cj4nFvTwsLL4fY4snawMVUaV7LHkwPl91TPBl8/tgf4Ums/ofFwOpD2F+1Gifrr+tJA1T
 jBhYBvESOLpI9asDRG+YmdLzdsBiiKNINRKTuKRgv0WO83iFy3mOajC27oR60qR5RNu1FuLKv
 fGJhaxkSSPkucH05eGq9HSLYfI5rUtlO9Knd4BwOLD7MbQN4lTrrKQ44VD6+KOgYjB9MC1RMg
 XNGPvMbashvT0/AUT+szAlRQmgGPERUQY8v8jGI9Xz7AF1ow11piawzOY3/n7Wd7hMFEcnQvZ
 2lHvPFPk8JwDm5IRlRVBUCnxNOt+XMIY3Lere3UHbjhbG47ujABvk4jhp4is9Gv6+mMY/LpKw
 7yyGZzrKEBUuLtxd1WdgZoFThzhKJT+EMIX2XdLMNSVUu+ZarSTrIHyKG3hGFECB1b3IA4wYF
 MyBt12u6WFZXCq3OSDeKp/3he60JN25eV+REZf12E6IZyJr24Vl/05EwBK7qBGDOfWKLwqeKj
 N8y5XNnCMiKmsqfBL9r4bJE2g/H3fwWj1+1iJUkU+6xdzbl0DQcMoX0dNR6xISPjs0q7bPn74
 WskPmvQoyixktBoXQl1i8rJdWhuXUprWyxNqVBXEYWhfUGNrqbb+yCc5GT61hVfqHP/W13R3/
 6/EoRpvztFaHLA14XhM140FxF/3WIiC4u/FwmuBTWcXF2Ot7qwr46Fc05zvQ4qkf8Jd/PMKwE
 i/lzIYauYcJ0hYVTjHCDfrQ9nOPwuWE1BP0T3XDm+1LroFN/9E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.09.2017 um 19:38 schrieb Jeff King:
> On Sun, Sep 10, 2017 at 12:37:06PM +0200, René Scharfe wrote:
> 
>>> And in fact, being called from a signal handler means we should
>>> generally avoid touching malloc or free (which could be holding locks).
>>> That would mean preferring a leak to strbuf_release(). Of course that is
>>> the tip of the iceberg. We call strbuf_addstr() here, and
>>> remove_dir_recursively() will grow our buffer.
>>
>> And we call opendir(3), readdir(3), and closedir(3), which are also not
>> listed as async-safe functions by POSIX [1].
> 
> Good point. I don't know how dangerous those are in the real-world
> (i.e., is POSIX leaving an out for some implementations, or are they
> really unsafe on common platforms like Linux).

No idea.

>>> So I actually wonder if junk_git_dir and junk_work_tree should be
>>> pre-sized strbufs themselves. And that makes the leak "go away" in the
>>> eyes of leak-checkers because we hold onto the static strbufs until
>>> program exit.
>>
>> We could start with a small buffer and expand it to match the path
>> length of written files as we go.
> 
> Yes, but I didn't want to touch each code site that creates a file,
> which is a lot more invasive. I expect expanding to 4096 (or PATH_MAX)
> would be sufficient in practice.

Perhaps it is in most cases.  Having certainty would be better.  We can
leave unpack_trees() untouched and instead traverse the tree beforehand,
in order to find the longest path.  Perhaps we can do something similar
for init_db().

> I'd also note that the current code isn't _remotely_ async safe and
> nobody's complained. So I'm perfectly happy doing nothing, too. I care
> a bit more about the tempfile.c interface because it's invoked a lot
> more frequently.

I guess clones are not interrupted very often during checkout; same
with worktree creation.  So perhaps nasty things could happen with a
low probability, but nobody tried hard enough to hit that case?

>> Deletion without readdir(3) requires us to keep a list of all written
>> files and directories, though.  Perhaps in the form of an append-only
>> log; the signal handler could then go through them in reverse order
>> and remove them.  Or is there a better way?
> 
> No, I think that's how you'd have to do it. The implementation isn't all
> that bad, but hitting every file-creation would be invasive. I'd
> almost rather bail to exec-ing "rm -rf $dir", but we probably can't do
> _that_ in a signal-handler either. :)

Well, fork(2), execve(2), and waitpid(2) are on the list, so actually
you can.

mingw_spawnvpe(), which is used by start_command() on Windows,
allocates memory, though.  Preparing environment and argument list
in advance and just calling CreateProcess() in the signal handler
might work.

René
