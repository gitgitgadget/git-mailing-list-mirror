Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153901F404
	for <e@80x24.org>; Tue, 30 Jan 2018 22:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeA3W5V (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 17:57:21 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44167 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeA3W5U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 17:57:20 -0500
Received: by mail-qt0-f193.google.com with SMTP id l20so19445343qtj.11
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 14:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cosrfJRccUaPpa4d5fqgZLHxHx4ykKFI9cTiAU9+4jA=;
        b=tl/B4QWLKkT1+BMf6Kfd1Ay6DnddEEPXKMv7vUXgze8nsWG4Cpt8lqkpKz/RTladGr
         jBI8c4nWoHDk01j7j8pEQ5hvGmWeF5cM2Gho65IsXQdiyVqHUbSq/hT3q7QpY4DNwd8c
         GPnn7VZwlejOeN0nX/OStUsbKoGteqfqbEaS9NMDK0pSSC4Hg6Iq24TcT2V9PhHBDW2/
         kULQVWUD/V9MNR1UrlHD/OxUZMBvOOk5i40K00dnA+cHD0rghtie/4MrblhCW+T+sJdD
         eR7guO6WqjJWTbBspHyJPjL4OFuoQSmq25V3tERxcohvkAgFClvzKnkiHA+bINg1oEjc
         Ifzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cosrfJRccUaPpa4d5fqgZLHxHx4ykKFI9cTiAU9+4jA=;
        b=cQtPipXr1NLaI+pP4MGscWTzU4ywR7DI96QVX00jXsRa0UVZLhgAVhAw0py9ay7ZnF
         UP+tNZdFypdRhlfThAqz3/pVVHiWhbZg3fCfm5pJ9narcX6nxlQQWzrz8n//N4BT+u4u
         A49cwBFFk7zN02E6ZHcNpNTgtG+MtuSrsQUdmO+hDf/SCXWF50S5U2eriPJC4Cs8vC1e
         Y89lhxQ+8Wt0yJDvQkKDiYjhY7GHMspGnIZQ9GtdrJVGSTe576DHaX/Fl5gK17LS/CTg
         CjoFopG6unM7fUz98B9lKLzgLoqle7VTFMwc8Fz6KP1dBtxqgVvXZgHMnu1G1J14ysB2
         dQvg==
X-Gm-Message-State: AKwxyteSZ0fYUo46CrMQTwdpgUlZTAjKsT/yz+7XOt8/oMTAMEfqI3rv
        lNeEW+nRIUKLR9so8LmvxJk=
X-Google-Smtp-Source: AH8x226zLGRFwpK8YTuWo8bRH/DPGn0C+wKVjBP3fdeFUqsB/MUo9jK8WkQijBy7MDco1r6C498L7A==
X-Received: by 10.237.63.77 with SMTP id q13mr49483534qtf.327.1517353039867;
        Tue, 30 Jan 2018 14:57:19 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 15sm12294655qtz.76.2018.01.30.14.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 14:57:18 -0800 (PST)
Subject: Re: Some rough edges of core.fsmonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
References: <87efmcw3fa.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <26b9d795-b2b3-905d-c67a-83bc4e976894@gmail.com>
Date:   Tue, 30 Jan 2018 17:57:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87efmcw3fa.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While some of these issues have been discussed in other threads, I 
thought I'd summarize my thoughts here.

On 1/26/2018 7:28 PM, Ævar Arnfjörð Bjarmason wrote:
> I just got around to testing this since it landed, for context some
> previous poking of mine in [1].
> 
> Issues / stuff I've noticed:
> 
> 1) We end up invalidating the untracked cache because stuff in .git/
> changed. For example:
> 
>      01:09:24.975524 fsmonitor.c:173         fsmonitor process '.git/hooks/fsmonitor-watchman' returned success
>      01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callback '.git'
>      01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callback '.git/config'
>      01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callback '.git/index'
>      01:09:25.122726 fsmonitor.c:91          write fsmonitor extension successful
> 
> Am I missing something or should we do something like:
> 
>      diff --git a/fsmonitor.c b/fsmonitor.c
>      index 0af7c4edba..5067b89bda 100644
>      --- a/fsmonitor.c
>      +++ b/fsmonitor.c
>      @@ -118,7 +118,12 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
> 
>       static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
>       {
>      -       int pos = index_name_pos(istate, name, strlen(name));
>      +       int pos;
>      +
>      +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
>      +               return;
>      +
>      +       pos = index_name_pos(istate, name, strlen(name));
> 
>              if (pos >= 0) {
>                      struct cache_entry *ce = istate->cache[pos];
> 
> With that patch applied status on a large repo[2] goes from a consistent
> ~180-200ms to ~140-150ms, since we're not invalidating some of the UC
> structure
> 

I favor making this optimization by updating 
untracked_cache_invalidate_path() so that it ignores paths under 
get_git_dir() and doesn't invalidate the untracked cache or flag the 
index as dirty.

> 2) We re-write out the index even though we know nothing changed
> 
> When you first run with core.fsmonitor it needs to
> mark_fsmonitor_clean() for every path, but is there a reason for why we
> wouldn't supply the equivalent of GIT_OPTIONAL_LOCKS=0 if all paths are
> marked and we know from the hook that nothing changed? Why write out the
> index again?
> 

Writing out the index when core.fsmonitor is first turned on is 
necessary to get the index extension added with the current state of the 
dirty flags.  Given it is a one time cost, I don't think we have 
anything worth trying to optimize here.

> 3) A lot of time spend reading the index (or something..)
> 
> While the hook itself takes ~20ms (and watchman itself 1/4 of that)
> status as a whole takes much longer. gprof reveals:
> 
>      Each sample counts as 0.01 seconds.
>        %   cumulative   self              self     total
>       time   seconds   seconds    calls  ms/call  ms/call  name
>       15.38      0.02     0.02   221690     0.00     0.00  memihash
>       15.38      0.04     0.02   221689     0.00     0.00  create_from_disk
>        7.69      0.05     0.01  2216897     0.00     0.00  git_bswap32
>        7.69      0.06     0.01   222661     0.00     0.00  ce_path_match
>        7.69      0.07     0.01   221769     0.00     0.00  hashmap_add
>        7.69      0.08     0.01    39941     0.00     0.00  prep_exclude
>        7.69      0.09     0.01    39940     0.00     0.00  strbuf_addch
>        7.69      0.10     0.01        1    10.00    10.00  read_one
>        7.69      0.11     0.01        1    10.00    10.00  refresh_index
>        7.69      0.12     0.01        1    10.00    10.00  tweak_fsmonitor
>        7.69      0.13     0.01                             preload_thread
> 
> The index is 24M in this case, I guess it's unpacking it, but I wonder
> if this couldn't be much faster if we saved away the result of the last
> "status" in something that's quick to access, and then if nothing
> changed we just report that, and no need to re-write the index (or just
> write the "it was clean at this time" part).

Yes, reading the index is slow.  We've made some improvements (not 
computing the SHA, not validating the sort order, etc) and have one more 
in progress that will reduce the malloc() cost.  I haven't found any 
other easy optimizations but it would be great if you could find more! 
To make significant improvements, I'm afraid it will take more 
substantial changes to the in memory and on disk formats and updates to 
the code to take advantage of those changes.

> 
> 4) core.fsmonitor=false behaves unexpectedly
> 
> The code that reads this variable just treats it as a string, so we do a
> bunch of work for nothing (and nothing warns) if this is set and 'false'
> is executed. Any reason we couldn't do our standard boolean parsing
> here? You couldn't call your hook 0/1/true/false, but that doesn't seem
> like a big loss.
> 
> 1. https://public-inbox.org/git/CACBZZX5a6Op7dH_g9WOFBnejh2zgNK4b34ygxA8daNDqvitFVA@mail.gmail.com/
> 2. https://github.com/avar/2015-04-03-1M-git
> 

I'm torn on this one.  The core.fsmontior setting isn't a boolean value, 
its a string that is the command to run when we need file system 
changes.  It would be pretty simple to add a call to 
git_parse_maybe_bool_text() to treat "false," "no," or "off" the same as 
an empty string but that makes it look even more like a boolean when it 
isn't.
