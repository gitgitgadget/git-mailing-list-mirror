Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F661F576
	for <e@80x24.org>; Sat, 27 Jan 2018 11:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeA0Lnr (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 06:43:47 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:38880 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeA0Lnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 06:43:45 -0500
Received: by mail-wr0-f182.google.com with SMTP id a1so2638923wri.5
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 03:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8q1WToLou9ps/2nKoVXF0cug3lK8pqdDmN8b4bR91cw=;
        b=hR7khvSyyiWdZ5YkXv+nmaE//tokVRP1VQdquOBBMj0WyzfDS/+ndQvGmmxADi6A6e
         HfcGX6yYlvPI8PxYzJB8ZipmNXCXwoRV9DNHni8ajGLkYr18N3DDnG4VDm/nt7JsavXV
         /l9kRYh4ZzmJfKuTHYADx9Pm7etLpQfdnB6TjYLohryZX0S3ILGeMJaLV/q8s0cFMtnA
         kKmhIa2NmOLRHahFhSyB9isnAik3CshzK52jVUnfJPztuTfjj8L+K1iBtzBIKqmcQNiT
         JECq/Oy96ZWfbr6Yk04bDeTYrtJc5SF8WCKWqS1TUiRMppOil70cXTr23Th2LchmFwKq
         xKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8q1WToLou9ps/2nKoVXF0cug3lK8pqdDmN8b4bR91cw=;
        b=VZHCyHyyY9ybCfgugE7cav2QeIHfLeNn7JBDhsf4Q7ouOax8ZncJ1tU/MMISW4tJSL
         gZfwAhdbXDsB1HgSBQB6G3ccq2wy71n5FQB+itSbQAhdlEEPX/+i8PymHQ5nicbOXj0q
         8oJlwIbLdKSuLjAcWBXiwuAc+sv+JVZqaRam2bFW4PpqImqWbVPl8vgbBFYXFmc99dH9
         gTgKZJq4CTkG545Adfwp5P/llUGHWM472+0Eotuq5fFhhnAiAWQ1jibRCfx7FKunYuZj
         9vX6RJmLeLpTKjzX0TnzK0jyljtF26FOuQSgtq0QUJzsVxGhLisZH/hlt3RjoWQZT2yZ
         GjsA==
X-Gm-Message-State: AKwxytdk3JmDobPFQHNlxXk2H8Hb5ynnshKOcqndbAgV+cYIMwyJ/Ewf
        z1bHRIJPQ50Gq+/3S7bMoVSHwsPJ
X-Google-Smtp-Source: AH8x227/ThnIY3pSPgv568nisV3nbaDiMOsz4i9rCubmQpLNr2BbQWFrTU8lwhuoiNX/xKBgGIpETA==
X-Received: by 10.223.185.92 with SMTP id b28mr13876167wrg.196.1517053423220;
        Sat, 27 Jan 2018 03:43:43 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id d125sm6127594wmc.47.2018.01.27.03.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 03:43:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
Subject: Re: Some rough edges of core.fsmonitor
References: <87efmcw3fa.fsf@evledraar.gmail.com> <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
Date:   Sat, 27 Jan 2018 12:43:41 +0100
Message-ID: <87bmhfwmqa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 27 2018, Duy Nguyen jotted:

> On Sat, Jan 27, 2018 at 7:28 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> 3) A lot of time spend reading the index (or something..)
>
> I'm resending a patch from my old index-helper series. It should
> measure all big time consuming blocks in git. Maybe we should get it
> merged...
>
>> While the hook itself takes ~20ms (and watchman itself 1/4 of that)
>> status as a whole takes much longer. gprof reveals:
>>
>>     Each sample counts as 0.01 seconds.
>>       %   cumulative   self              self     total
>>      time   seconds   seconds    calls  ms/call  ms/call  name
>>      15.38      0.02     0.02   221690     0.00     0.00  memihash
>
> This sounds like name-hash to me.
>
>>      15.38      0.04     0.02   221689     0.00     0.00  create_from_disk
>>       7.69      0.05     0.01  2216897     0.00     0.00  git_bswap32
>>       7.69      0.06     0.01   222661     0.00     0.00  ce_path_match
>>       7.69      0.07     0.01   221769     0.00     0.00  hashmap_add
>>       7.69      0.08     0.01    39941     0.00     0.00  prep_exclude
>>       7.69      0.09     0.01    39940     0.00     0.00  strbuf_addch
>>       7.69      0.10     0.01        1    10.00    10.00  read_one
>>       7.69      0.11     0.01        1    10.00    10.00  refresh_index
>>       7.69      0.12     0.01        1    10.00    10.00  tweak_fsmonitor
>>       7.69      0.13     0.01                             preload_thread
>>
>> The index is 24M in this case, I guess it's unpacking it, but I wonder
>> if this couldn't be much faster if we saved away the result of the last
>> "status" in something that's quick to access, and then if nothing
>
> No we could do better, we could cache parsed index content so
> everybody benefits. I demonstrated it with my "index v254" patch a
> while back:
>
> https://public-inbox.org/git/1399980019-8706-1-git-send-email-pclouds@gmail.com/
>
> With the patch I'm sending soon, we can see how much time reading an
> index take out of that ~140-150ms (and we probably can cut down index
> read time to like 10-20% when cached).
>
>> changed we just report that, and no need to re-write the index (or just
>> write the "it was clean at this time" part).
>
> Hmm.. does an index write increase that much time?

Your patch is very useful. Here's (with gcc -03) some runtimes. This
also includes my .git exclusion patch.

These are all best out of 5, and with the top (until <0.5% time) of
strace -c output (run as another invocation, timing not done with
strace)::

a) no fsmonitor

    $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
    12:32:44.947651 read-cache.c:1890       performance: 0.053153609 s: read cache .git/index
    12:32:44.967943 preload-index.c:112     performance: 0.020161093 s: preload index
    12:32:44.974217 read-cache.c:1446       performance: 0.006230611 s: refresh index
    12:32:44.979083 diff-lib.c:250          performance: 0.004649994 s: diff-files
    12:32:44.982511 diff-lib.c:527          performance: 0.002918416 s: diff-index
    12:32:45.037880 dir.c:2290              performance: 0.055331063 s: read directory
    On branch master
    Your branch is up to date with 'origin/master'.

    nothing to commit, working tree clean
    12:32:45.040666 trace.c:417             performance: 0.146724289 s: git command: '/home/aearnfjord/g/git/git-status'

    real    0m0.153s
    user    0m0.110s
    sys     0m0.354s
    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     59.93    0.031924           1     39978         9 stat
     35.86    0.019104        6368         3           futex
      0.84    0.000446          12        36           mprotect
      0.73    0.000389          13        29           munmap
      0.66    0.000349           6        62           mmap
      0.53    0.000285          14        20           clone

b) with fsmonitor

    $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
    12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s: read cache .git/index
    12:34:23.838622 preload-index.c:112     performance: 0.001221197 s: preload index
    12:34:23.858723 fsmonitor.c:170         performance: 0.020059647 s: fsmonitor process '.git/hooks/fsmonitor-watchman'
    12:34:23.871532 read-cache.c:1446       performance: 0.032870818 s: refresh index
    12:34:23.876427 diff-lib.c:250          performance: 0.004731427 s: diff-files
    12:34:23.880669 diff-lib.c:527          performance: 0.003944422 s: diff-index
    12:34:23.899225 dir.c:2290              performance: 0.018509066 s: read directory
    On branch master
    Your branch is up to date with 'origin/master'.

    nothing to commit, working tree clean
    12:34:23.901914 trace.c:417             performance: 0.118250995 s: git command: '/home/aearnfjord/g/git/git-status'

    real    0m0.125s
    user    0m0.086s
    sys     0m0.043s
    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     36.61    0.001281          61        21           clone
     33.84    0.001184          41        29           munmap
      5.09    0.000178           5        36           mprotect
      4.34    0.000152           0       619           brk
      4.17    0.000146           2        62           mmap
      3.34    0.000117           2        55        20 open
      3.00    0.000105           2        60        27 lstat
      1.77    0.000062           2        37         9 stat
      1.60    0.000056           1        51           read
      1.57    0.000055           5        12           write
      1.17    0.000041          41         1           wait4
      0.83    0.000029           1        41           close
      0.83    0.000029           1        22           getcwd
      0.80    0.000028           1        34           fstat

c) with fsmonitor + don't write index

    $ time GIT_TRACE_PERFORMANCE=1 GIT_OPTIONAL_LOCKS=0 ~/g/git/git-status
    12:36:03.176866 read-cache.c:1890       performance: 0.048292088 s: read cache .git/index
    12:36:03.181006 preload-index.c:112     performance: 0.001343593 s: preload index
    12:36:03.200970 fsmonitor.c:170         performance: 0.019936338 s: fsmonitor process '.git/hooks/fsmonitor-watchman'
    12:36:03.210556 read-cache.c:1446       performance: 0.029525531 s: refresh index
    12:36:03.213366 diff-lib.c:250          performance: 0.002718730 s: diff-files
    12:36:03.216273 diff-lib.c:527          performance: 0.002666604 s: diff-index
    12:36:03.233579 dir.c:2290              performance: 0.017261702 s: read directory
    On branch master
    Your branch is up to date with 'origin/master'.

    nothing to commit, working tree clean
    12:36:03.233733 trace.c:417             performance: 0.105632105 s: git command: '/home/aearnfjord/g/git/git-status'

    real    0m0.111s
    user    0m0.073s
    sys     0m0.044s
    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     24.42    0.001081          37        29           munmap
     20.74    0.000918          44        21           clone
      7.63    0.000338           5        62           mmap
      7.43    0.000329           6        54        20 open
      6.05    0.000268           7        36           mprotect
      5.99    0.000265           0       619           brk
      4.99    0.000221           4        60        27 lstat
      4.13    0.000183           4        51           read
      3.68    0.000163           9        19        10 access
      3.25    0.000144           4        34           fstat
      2.78    0.000123           3        40           close
      2.48    0.000110           3        37         9 stat
      2.24    0.000099           5        21           getcwd
      1.15    0.000051           4        12           write
      0.99    0.000044          22         2           poll

For comparison just the output from the hook:

    $ time ('.git/hooks/fsmonitor-watchman' '1' '1517052856494406191')
    .git
    real    0m0.017s
    user    0m0.011s
    sys     0m0.003s

And this is what goes on behind the scenes after we get rid of the
.git/hooks/fsmonitor-watchman overhead:
    
    $ time (echo '["query", "/home/aearnfjord/git_tree/2015-04-03-1M-git", {
                            "since": 1517052856,
                            "fields": ["name"],
                            "expression": ["not", ["allof", ["since", 1517052856, "cclock"], ["not", "exists"]]]
                    }]' | watchman -j)
    {
        "version": "4.9.0",
        "is_fresh_instance": false,
        "clock": "c:1517006351:31165:4:1113968",
        "files": [
            ".git"
        ]
    }
    
    real    0m0.003s
    user    0m0.000s
    sys     0m0.004s
