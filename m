Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E16720D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdFAVOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:14:15 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36367 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFAVOO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:14:14 -0400
Received: by mail-io0-f193.google.com with SMTP id f102so6554131ioi.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OX0p+tpvAkPaVWGFKQw+v6Xq3rSaT3iIr0LolAwTaQE=;
        b=bpX+XTcbuAl2G41MBusbuGp9piGQaJQ++blgxb+oXtHUan4lFdDX6xeQgpOtpst6JZ
         p9xDT7p5JhuunQpL0AbCPazCMDqE9BUFGbxfLn13kGrUNH9mBDER3ffHEi/T4erwp90C
         /cgPZruFmlysiOTBtsG1FVRGHyhsJiL/b8kfMvq65ey/1bTDkrO0r2o5Z38cfjOTCNSi
         rsqchTpPehlFQbo0RCMddpnEyZPOVMJoDhwIy6INiSxR2ZG/qFGHBw8hHkd0gUEZ48ga
         7uTHeVXNMA+dw0uNCH4tg3XKaggM+hxm7uejw1yMN53mNe6awhLxGyabFM0qLFGKK8Ea
         IulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OX0p+tpvAkPaVWGFKQw+v6Xq3rSaT3iIr0LolAwTaQE=;
        b=E8t5GqQ43LTpYCOcmSjmJPoGC8KLt1gi3dvarO2diC2YRKfDkGMH0o/kcK+YS4Gbie
         LpGrBleNb9tSx10N0AGC8Fj8wBjaGxrlI1O6cPrzT6Uh06l+bPsqXN4pwtxbu8tvjER6
         M8b4rR3vc9pE1y956z+OlJPQWWwfweMDBTMXBu8ItVUCkmdpmDsQnC/Bg42niDFX3icY
         g12RWyZ4vw6R9veurMeh7H+FNGUZmw7r3zdzfP5A/T0AB1h++qZiWYGrLhzexVyqsHf/
         KDK+Z7m110tzkf/a7LIgnAiVS4jdleu1oz+RQPe1piKJdAdwmdFNS17xq+DsJKALr03i
         4Wsw==
X-Gm-Message-State: AODbwcAGFYjFfvglZx241dN1R1Nzeu2QLSdD5FSEEwhLoTr3qEtXDJ7O
        WB8LvDhPmtKl9XAxY8+SNsXMJKu5XQ==
X-Received: by 10.107.178.215 with SMTP id b206mr1069717iof.50.1496351653120;
 Thu, 01 Jun 2017 14:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 14:13:52 -0700 (PDT)
In-Reply-To: <CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=rp-7vXd8nURyWQ@mail.gmail.com>
References: <20170601155105.28356-1-benpeart@microsoft.com> <CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=rp-7vXd8nURyWQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 23:13:52 +0200
Message-ID: <CACBZZX4eZ3G8LQ8O+_BkbkJ-ZXTOkUi9cW=QKYjfHKtmA3pgrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 10:51 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jun 1, 2017 at 5:50 PM, Ben Peart <peartben@gmail.com> wrote:
>> Changes from V3 include:
>>  - update test script based on feedback
>>  - update template hook proc with better post-processing code and make
>>    it executable
>
> I have watchman running finally, so aside from issues applying this I
> can finally test this. I set up a watch of linux.git:
>
> $ watchman watch $PWD
> $ watchman watch-list|jq '.roots[]'
> "/home/avar/g/linux"
>
> And first, for simplicity, I'll be turning core.fsmonitore on later:
>
> $ for c in fsmonitor untrackedCache splitIndex; do git config core.$c
> false; done
>
> On a hot fs cache running "git status" takes me 80ms, but if I flush cach=
es:
>
> # free && sync && echo 3 > /proc/sys/vm/drop_caches && free
>
> Running "git status" takes me 4s. Now, right after flushing those caches:
>
> $ date +%s
> 1496349235
> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349235,
> "fields":["name"]}]' | watchman -j) | jq '.files[]'
>
> real    0m0.664s
> user    0m0.000s
> sys     0m0.004s
> $ touch foo bar
> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349235,
> "fields":["name"]}]' | watchman -j) | jq '.files[]'
> "bar"
> "foo"
>
> real    0m0.044s
> user    0m0.000s
> sys     0m0.000s
>
> Without the monitor running "git status' takes me ~2.5s, i.e. from cold c=
ache:
>
> $ time GIT_TRACE=3D1 ~/g/git/git-status
> 20:34:49.154731 git.c:369               trace: built-in: git 'status'
> On branch master
> Your branch is up-to-date with 'origin/master'.
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         bar
>         foo
>
> nothing added to commit but untracked files present (use "git add" to tra=
ck)
>
> real    0m2.546s
> user    0m0.060s
> sys     0m0.228s
>
> Now, I would expect the case where the working tree isn't in the fs
> cache to be lightning fast, since the watchman command is really fast
> (flushed the cache again, turned on the fsmonitor):
>
> $ date +%s
> 1496349523
> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349523,
> "fields":["name"]}]' | watchman -j) | jq '.files[]'
>
> real    0m0.529s
> user    0m0.000s
> sys     0m0.004s
> $ touch foo bar
> $ time (echo '["query", "/home/avar/g/linux", {"since": 1496349523,
> "fields":["name"]}]' | watchman -j) | jq '.files[]'
> "bar"
> "foo"
>
> real    0m0.312s
> user    0m0.000s
> sys     0m0.000s
>
> But if I run "git status" (and I instrumented the hook to dump the
> changed files) it takes a long time (those 10s are just the disk being
> slow, but it should be ~0s, right?):
>
> $ time GIT_TRACE=3D1 ~/g/git/git-status
> 20:39:11.250128 git.c:369               trace: built-in: git 'status'
> 20:39:14.586720 run-command.c:626       trace: run_command:
> '.git/hooks/query-fsmonitor' '1' '1496349494197821000'
> Watchman says these changed: bar foo hi there .git .git/index.lock .git/i=
ndex
> On branch master
> Your branch is up-to-date with 'origin/master'.
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         bar
>         foo
>
> nothing added to commit but untracked files present (use "git add" to tra=
ck)
>
> real    0m10.791s
> user    0m0.108s
> sys     0m0.228s
>
> If I re-run that it takes ~160-200ms with the hook, 80-120ms without
> it, so in this case once the data is in the fscache watchman is
> actually slower.
>
> But manually running watchman shows that it's really fast, usually
> returning within 3ms, I flush the fscache in the middle of this,
> that's the 600ms time, that could be some global kernel lock or
> something due to the odd manual proc operation, I haven't actually
> tested this on a system under memory pressure:
>
> $ for i in {1..10}; do (time (printf '["query", "/home/avar/g/linux",
> {"since": %s, "fields":["name"]}]' $(($(date +%s)-3)) | watchman -j |
> jq '.files[]')) 2>&1 | grep -e '"' -e ^real && touch $i && sleep 1;
> done
> real    0m0.004s
> "1"
> real    0m0.003s
> "2"
> "1"
> real    0m0.605s
> "3"
> real    0m0.003s
> "4"
> "3"
> real    0m0.003s
> "5"
> "4"
> real    0m0.003s
> "6"
> "5"
> real    0m0.003s
> "7"
> "6"
> real    0m0.003s
> "8"
> "7"
> real    0m0.003s
> "9"
> "8"
> real    0m0.003s
>
> So something really odd is going on here. This should be speeding up
> "git status" a lot, even with a hot fs cache doing stat on all of
> linux.git takes a lot longer than 3ms, but for some reason it's
> slower.

Dug a bit further, with cold cache and no fsmonitor, gprof output from
-O0 compiled git:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 37.50      0.03     0.03   123886     0.00     0.00  memihash
 12.50      0.04     0.01   284727     0.00     0.00  match_basename
 12.50      0.05     0.01    73989     0.00     0.00  match_pathname
 12.50      0.06     0.01    59924     0.00     0.00  hashmap_add
 12.50      0.07     0.01    59847     0.00     0.00  same_name
 12.50      0.08     0.01    59844     0.00     0.00  hash_index_entry
  0.00      0.08     0.00   598446     0.00     0.00  git_bswap32
  0.00      0.08     0.00   259150     0.00     0.00  fspathncmp
  0.00      0.08     0.00   178731     0.00     0.00  match_pathspec
  0.00      0.08     0.00   178655     0.00     0.00  do_match_pathspec
And then cold cache with fsmonitor:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 66.67      0.04     0.04    96696     0.00     0.00  blk_SHA1_Block
 16.67      0.05     0.01    59844     0.00     0.00  cache_entry_from_ondi=
sk
 16.67      0.06     0.01    58869     0.00     0.00  longest_path_match
  0.00      0.06     0.00  1547157     0.00     0.00  git_bswap32
  0.00      0.06     0.00  1196893     0.00     0.00  git_bswap32
  0.00      0.06     0.00   284727     0.00     0.00  match_basename
  0.00      0.06     0.00   259150     0.00     0.00  fspathncmp
  0.00      0.06     0.00   178561     0.00     0.00  do_match_pathspec
  0.00      0.06     0.00   178543     0.00     0.00  match_pathspec
  0.00      0.06     0.00   145141     0.00     0.00  memory_limit_check
