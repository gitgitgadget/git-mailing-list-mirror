Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F364F1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeA3XQS (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:16:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36490 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeA3XQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:16:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id f3so4422910wmc.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0+RYfQ7PfKn/GCpT9boic0NI/6UWFdtjdLCQAoe4L5I=;
        b=rIrVMI4YoTBzIded25TM6hBYxGtBR9+aNU537EWHbohK9vQHtMPnqGXasOSkto88Sp
         wAaQNUw8Jkft3VoAAoFUKBwsZNGm0KbBOIpfDIg+8xGWZ2IA83FNb6oz8Mrdz7WR+0TU
         csSO6Bl6CEZV7FAH2FnNTs2ls0Qc3OdbMdylM4f9b3oVS4WCV/02D/W98Z0mhKSzoxos
         FUbrZYlq7ttQ3/XoYSc3k6WwSgKeOLaCQQXaNT3rUStjvchyB2EpvrDV32mbByYyQy7x
         KywShgVqkSeUuEcKcxzH5XAVos7MdcuhZmp97WdS7T3rSSBBioXLdsMn/1v8ZpCTdFbN
         VPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0+RYfQ7PfKn/GCpT9boic0NI/6UWFdtjdLCQAoe4L5I=;
        b=KpjldphjDZvo4Mkupx3/0BFCQanC6KJPV5X/6t1jlCwes58XC63+WGx0YNFEXusxB6
         pXxuoZZz/wDiXgF2Cb6ma7YvL859nfa9Whp8eRzHkLTde09v92xiXiq7ioav4HRAFcai
         j6z75ChJY4PxQda9KzK1D1pMWIGUSvM8UPx4bFt2l/zXiW0o9UDS6y1wO+EUwrOeRSMm
         QYErlsIBC2nCwPc6XJqr0yn51wyMNQqeufTDLkCYG0gdnmaD4X23qGgciaL+6Jnx341D
         ftSbEJRNncWbAqa1nhlCzbyR6zSB8Lo1yUIze1zBFw9xrEVebjjt/7570bDSekLjorA6
         HXJg==
X-Gm-Message-State: AKwxytfGQVQMjavWLr8FXtrAQXEDfUAkE7H4rBjpJ6tKNgrvvxYaAKSM
        eAFampJTqNXePBYnI54IqY/KmEQf
X-Google-Smtp-Source: AH8x2279Gpm0bT+WBSrv6hhaoqhMzNjf6dsrptq6+hp3GnRSrUW3lLjpQ4dh+I9h5l8if5HSlL6uoA==
X-Received: by 10.80.178.99 with SMTP id o90mr6873501edd.255.1517354176140;
        Tue, 30 Jan 2018 15:16:16 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id d4sm8078664eda.78.2018.01.30.15.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 15:16:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
Subject: Re: Some rough edges of core.fsmonitor
References: <87efmcw3fa.fsf@evledraar.gmail.com> <26b9d795-b2b3-905d-c67a-83bc4e976894@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <26b9d795-b2b3-905d-c67a-83bc4e976894@gmail.com>
Date:   Wed, 31 Jan 2018 00:16:14 +0100
Message-ID: <87vafjlyyp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 30 2018, Ben Peart jotted:

> While some of these issues have been discussed in other threads, I
> thought I'd summarize my thoughts here.

Thanks for this & your other reply. I'm going to get to testing some of
Duy's patches soon, and if you have some other relevant WIP I'd be happy
to try them, but meanwhile replying to a few of these:

> On 1/26/2018 7:28 PM, Ævar Arnfjörð Bjarmason wrote:
>> I just got around to testing this since it landed, for context some
>> previous poking of mine in [1].
>>
>> Issues / stuff I've noticed:
>>
>> 1) We end up invalidating the untracked cache because stuff in .git/
>> changed. For example:
>>
>>      01:09:24.975524 fsmonitor.c:173         fsmonitor process '.git/hooks/fsmonitor-watchman' returned success
>>      01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callback '.git'
>>      01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callback '.git/config'
>>      01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callback '.git/index'
>>      01:09:25.122726 fsmonitor.c:91          write fsmonitor extension successful
>>
>> Am I missing something or should we do something like:
>>
>>      diff --git a/fsmonitor.c b/fsmonitor.c
>>      index 0af7c4edba..5067b89bda 100644
>>      --- a/fsmonitor.c
>>      +++ b/fsmonitor.c
>>      @@ -118,7 +118,12 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
>>
>>       static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
>>       {
>>      -       int pos = index_name_pos(istate, name, strlen(name));
>>      +       int pos;
>>      +
>>      +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
>>      +               return;
>>      +
>>      +       pos = index_name_pos(istate, name, strlen(name));
>>
>>              if (pos >= 0) {
>>                      struct cache_entry *ce = istate->cache[pos];
>>
>> With that patch applied status on a large repo[2] goes from a consistent
>> ~180-200ms to ~140-150ms, since we're not invalidating some of the UC
>> structure
>>
>
> I favor making this optimization by updating
> untracked_cache_invalidate_path() so that it ignores paths under
> get_git_dir() and doesn't invalidate the untracked cache or flag the
> index as dirty.

*nod*

>> 2) We re-write out the index even though we know nothing changed
>>
>> When you first run with core.fsmonitor it needs to
>> mark_fsmonitor_clean() for every path, but is there a reason for why we
>> wouldn't supply the equivalent of GIT_OPTIONAL_LOCKS=0 if all paths are
>> marked and we know from the hook that nothing changed? Why write out the
>> index again?
>>
>
> Writing out the index when core.fsmonitor is first turned on is
> necessary to get the index extension added with the current state of
> the dirty flags.  Given it is a one time cost, I don't think we have
> anything worth trying to optimize here.

Indeed, that makes sense. What I was showing here is even after the
initial setup we continue to write it out when we know nothing changed.

We do that anyway without fsmonitor, but this seemed like a worthwhile
thing to optimize.

>> 3) A lot of time spend reading the index (or something..)
>>
>> While the hook itself takes ~20ms (and watchman itself 1/4 of that)
>> status as a whole takes much longer. gprof reveals:
>>
>>      Each sample counts as 0.01 seconds.
>>        %   cumulative   self              self     total
>>       time   seconds   seconds    calls  ms/call  ms/call  name
>>       15.38      0.02     0.02   221690     0.00     0.00  memihash
>>       15.38      0.04     0.02   221689     0.00     0.00  create_from_disk
>>        7.69      0.05     0.01  2216897     0.00     0.00  git_bswap32
>>        7.69      0.06     0.01   222661     0.00     0.00  ce_path_match
>>        7.69      0.07     0.01   221769     0.00     0.00  hashmap_add
>>        7.69      0.08     0.01    39941     0.00     0.00  prep_exclude
>>        7.69      0.09     0.01    39940     0.00     0.00  strbuf_addch
>>        7.69      0.10     0.01        1    10.00    10.00  read_one
>>        7.69      0.11     0.01        1    10.00    10.00  refresh_index
>>        7.69      0.12     0.01        1    10.00    10.00  tweak_fsmonitor
>>        7.69      0.13     0.01                             preload_thread
>>
>> The index is 24M in this case, I guess it's unpacking it, but I wonder
>> if this couldn't be much faster if we saved away the result of the last
>> "status" in something that's quick to access, and then if nothing
>> changed we just report that, and no need to re-write the index (or just
>> write the "it was clean at this time" part).
>
> Yes, reading the index is slow.  We've made some improvements (not
> computing the SHA, not validating the sort order, etc) and have one
> more in progress that will reduce the malloc() cost.  I haven't found
> any other easy optimizations but it would be great if you could find
> more! To make significant improvements, I'm afraid it will take more
> substantial changes to the in memory and on disk formats and updates
> to the code to take advantage of those changes.

What I was wondering (not very clearly) is whether an easier
optimization for now would be to speed up the case where nothing
changed, that would involve just reading some flag in the index (or
elsewhere) saying nothing changed last time, then the timestamp the
fsmonitor writes, and trusting the hook when it says nothing changed
since that timestamp.

>>
>> 4) core.fsmonitor=false behaves unexpectedly
>>
>> The code that reads this variable just treats it as a string, so we do a
>> bunch of work for nothing (and nothing warns) if this is set and 'false'
>> is executed. Any reason we couldn't do our standard boolean parsing
>> here? You couldn't call your hook 0/1/true/false, but that doesn't seem
>> like a big loss.
>>
>> 1. https://public-inbox.org/git/CACBZZX5a6Op7dH_g9WOFBnejh2zgNK4b34ygxA8daNDqvitFVA@mail.gmail.com/
>> 2. https://github.com/avar/2015-04-03-1M-git
>>
>
> I'm torn on this one.  The core.fsmontior setting isn't a boolean
> value, its a string that is the command to run when we need file
> system changes.  It would be pretty simple to add a call to
> git_parse_maybe_bool_text() to treat "false," "no," or "off" the same
> as an empty string but that makes it look even more like a boolean
> when it isn't.

Yes, that makes sense. I wonder though if we should warn if the hook is
set and returning non-zero, right now that failure case is silent, maybe
the hook would like to return an exit code for "don't ask me", but it
seems better to make that 125 (like git bisect skip) instead of !0,
since that makes the hook failing completely indistinguishable to the
user from the hook doing its job.
