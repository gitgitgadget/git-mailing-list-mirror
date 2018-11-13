Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE54F1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 10:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbeKMT7z (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 14:59:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40302 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeKMT7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 14:59:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so9298141edx.7
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SVl4+JuBVYyPNK4u+7DwQ3cHgZ6dwS+viAA1+h8KkGg=;
        b=Z/1Mwjh1DCahT9Z29xXusH7qjes6DUiu5k88eQVBc8y1xBaTAe8aIFYqE92bM6j7kF
         GqDtA7s3JvSAUgw71i5aRRMlLiKkObDWj7A3KiFcIzawQCht/H42ZxaRm9jQnVdsRXql
         8jr0GoHj6h8kRrfQLQtMU5l446kjKN7XmHKttDNVPJBjKKS8TsW408BmpUwHOXNIM8pA
         TZnZ7BZmG+bDPWG/w13OyX4sUU6gu6+XoerKJCPlRMF1ghZHy/on8lEaKcnl/t3y2gza
         FP0FOqeEonactBJycA7PGg0QmCdNYz5TfBctBc9QoOYTQzyjWu/TZfITS3gErgFRTveY
         ab+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SVl4+JuBVYyPNK4u+7DwQ3cHgZ6dwS+viAA1+h8KkGg=;
        b=S0bt0mgZ86rUAfPc0bapCAlmVSVjm40hk4SN9XXz7KsRNPnvEUEbkCG4hDYxbCbTg8
         V8nVbV8H14kMl9lYRgU5DHXmGLB16mEG40nI8Fhpuh4D7Y9sGuyFSz/vNuQoJASLvHk/
         oxZ9QH88HdmJeuLx61wQyRKNprNG2LFrcUvjTDdEIh49AcsXMezoEQ9a3zSQis3Fnk8k
         vD6bwqgfmqw6l4FLeBNYN8jxykvudfpKawp545ou6hBe1LHb/3nFaVXeVjipflaci/Wy
         YSJ9MI5+UYf4/E3Gxg6TBz0QjwFkU6GqyLkcZL0uoEHojQvu5hbEboUhA4aHGoe75dEh
         eCSg==
X-Gm-Message-State: AGRZ1gLvVZst/F+kN2HPcVh4zs+43JHxEaDtOMe+/7K+hZXZ7aBSTJ5z
        pEUxmjV6w8EaEuqXhxO8SQ0=
X-Google-Smtp-Source: AJdET5evoj3fC6D2ARVT25m0jBxpLgSqhgiiLOsFgEsffdfSN1EQrZdK4kDYuylAU9OBec85ak7k4g==
X-Received: by 2002:a50:93e6:: with SMTP id o93-v6mr15295508eda.20.1542103351482;
        Tue, 13 Nov 2018 02:02:31 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id o2-v6sm5007942edb.84.2018.11.13.02.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 02:02:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence check
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112145442.GH7400@sigill.intra.peff.net> <87ftw62sld.fsf@evledraar.gmail.com> <20181112162150.GB7612@sigill.intra.peff.net> <87d0ra2b3z.fsf@evledraar.gmail.com> <87bm6u2akf.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87bm6u2akf.fsf@evledraar.gmail.com>
Date:   Tue, 13 Nov 2018 11:02:29 +0100
Message-ID: <878t1x2t3e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Nov 12 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Mon, Nov 12 2018, Jeff King wrote:
>>
>>> On Mon, Nov 12, 2018 at 05:01:02PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>>
>>>> > There's some obvious hand-waving in the paragraphs above. I would love
>>>> > it if somebody with an NFS system could do some before/after timings
>>>> > with various numbers of loose objects, to get a sense of where the
>>>> > breakeven point is.
>>>> >
>>>> > My gut is that we do not need the complexity of a cache-size limit, nor
>>>> > of a config option to disable this. But it would be nice to have a real
>>>> > number where "reasonable" ends and "pathological" begins. :)
>>>>
>>>> I'm happy to test this on some of the NFS we have locally, and started
>>>> out with a plan to write some for-loop using the low-level API (so it
>>>> would look up all 256), fake populate .git/objects/?? with N number of
>>>> objects etc, but ran out of time.
>>>>
>>>> Do you have something ready that you think would be representative and I
>>>> could just run? If not I'll try to pick this up again...
>>>
>>> No, but they don't even really need to be actual objects. So I suspect
>>> something like:
>>>
>>>   git init
>>>   for i in $(seq 256); do
>>>     i=$(printf %02x $i)
>>>     mkdir -p .git/objects/$i
>>>     for j in $(seq --format=%038g 1000); do
>>>       echo foo >.git/objects/$i/$j
>>>     done
>>>   done
>>>   git index-pack -v --stdin </path/to/git.git/objects/pack/XYZ.pack
>>>
>>> might work (for various values of 1000). The shell loop would probably
>>> be faster as perl, too. :)
>>>
>>> Make sure you clear the object directory between runs, though (otherwise
>>> the subsequent index-pack's really do find collisions and spend time
>>> accessing the objects).
>>>
>>> If you want real objects, you could probably just dump a bunch of
>>> sequential blobs to fast-import, and then pipe the result to
>>> unpack-objects.
>>>
>>> -Peff
>>
>> I did a very ad-hoc test against a NetApp filer using the test script
>> quoted at the end of this E-Mail. The test compared origin/master, this
>> branch of yours, and my core.checkCollisions=false branch.
>>
>> When run with DBD-mysql.git (just some random ~1k commit repo I had):
>>
>>     $ GIT_PERF_REPEAT_COUNT=3 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run origin/master peff/jk/loose-cache avar/check-collisions-config p0008-index-pack.sh
>>
>> I get:
>>
>>     Test                                             origin/master     peff/jk/loose-cache      avar/check-collisions-config
>>     ------------------------------------------------------------------------------------------------------------------------
>>     0008.2: index-pack with 256*1 loose objects      4.31(0.55+0.18)   0.41(0.40+0.02) -90.5%   0.23(0.36+0.01) -94.7%
>>     0008.3: index-pack with 256*10 loose objects     4.37(0.45+0.21)   0.45(0.40+0.02) -89.7%   0.25(0.38+0.01) -94.3%
>>     0008.4: index-pack with 256*100 loose objects    4.47(0.53+0.23)   0.67(0.63+0.02) -85.0%   0.24(0.38+0.01) -94.6%
>>     0008.5: index-pack with 256*250 loose objects    5.01(0.67+0.30)   1.04(0.98+0.06) -79.2%   0.24(0.37+0.01) -95.2%
>>     0008.6: index-pack with 256*500 loose objects    5.11(0.57+0.21)   1.81(1.70+0.09) -64.6%   0.25(0.38+0.01) -95.1%
>>     0008.7: index-pack with 256*750 loose objects    5.12(0.60+0.22)   2.54(2.38+0.14) -50.4%   0.24(0.38+0.01) -95.3%
>>     0008.8: index-pack with 256*1000 loose objects   4.52(0.52+0.21)   3.36(3.17+0.17) -25.7%   0.23(0.36+0.01) -94.9%
>>
>> I then hacked it to test against git.git, but skipped origin/master for
>> that one because it takes *ages*. So just mine v.s. yours:
>>
>>     $ GIT_PERF_REPEAT_COUNT=3 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run peff/jk/loose-cache avar/check-collisions-config p0008-index-pack.sh
>>     [...]
>>     Test                                             peff/jk/loose-cache   avar/check-collisions-config
>>     ---------------------------------------------------------------------------------------------------
>>     0008.2: index-pack with 256*1 loose objects      12.57(28.72+0.61)     12.68(29.36+0.62) +0.9%
>>     0008.3: index-pack with 256*10 loose objects     12.77(28.75+0.61)     12.50(28.88+0.56) -2.1%
>>     0008.4: index-pack with 256*100 loose objects    13.20(29.49+0.66)     12.38(28.58+0.60) -6.2%
>>     0008.5: index-pack with 256*250 loose objects    14.10(30.59+0.64)     12.54(28.22+0.57) -11.1%
>>     0008.6: index-pack with 256*500 loose objects    14.48(31.06+0.74)     12.43(28.59+0.60) -14.2%
>>     0008.7: index-pack with 256*750 loose objects    15.31(31.91+0.74)     12.67(29.23+0.64) -17.2%
>>     0008.8: index-pack with 256*1000 loose objects   16.34(32.84+0.76)     13.11(30.19+0.68) -19.8%
>>
>> So not much of a practical difference perhaps. But then again this isn't
>> a very realistic test case of anything. Rarely are you going to push a
>> history of something the size of git.git into a repo with this many
>> loose objects.
>>
>> Using sha1collisiondetection.git is I think the most realistic scenario,
>> i.e. you'll often end up fetching/pushing something roughly the size of
>> its entire history on a big repo, and with it:
>>
>>     Test                                             peff/jk/loose-cache   avar/check-collisions-config
>>     ---------------------------------------------------------------------------------------------------
>>     0008.2: index-pack with 256*1 loose objects      0.16(0.04+0.01)       0.05(0.03+0.00) -68.8%
>>     0008.3: index-pack with 256*10 loose objects     0.19(0.04+0.02)       0.05(0.02+0.00) -73.7%
>>     0008.4: index-pack with 256*100 loose objects    0.32(0.17+0.02)       0.04(0.02+0.00) -87.5%
>>     0008.5: index-pack with 256*250 loose objects    0.57(0.41+0.03)       0.04(0.02+0.00) -93.0%
>>     0008.6: index-pack with 256*500 loose objects    1.02(0.83+0.06)       0.04(0.03+0.00) -96.1%
>>     0008.7: index-pack with 256*750 loose objects    1.47(1.24+0.10)       0.04(0.02+0.00) -97.3%
>>     0008.8: index-pack with 256*1000 loose objects   1.94(1.70+0.10)       0.04(0.02+0.00) -97.9%
>>
>> As noted in previous threads I have an in-house monorepo where (due to
>> expiry policies) loose objects hover around the 256*250 mark.
>>
>> The script, which is hacky as hell and takes shortcuts not to re-create
>> the huge fake loose object collection every time (takes ages). Perhaps
>> you're interested in incorporating some version of this into a v2. To be
>> useful it should take some target path as an env variable.
>
> I forgot perhaps the most useful metric. Testing against origin/master
> too on the sha1collisiondetection.git repo, which as noted above I think
> is a good stand-in for making a medium sized push to a big repo. This
> shows when the loose cache becomes counterproductive:
>
>     Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
>     -------------------------------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      0.42(0.04+0.03)   0.17(0.04+0.00) -59.5%    0.04(0.03+0.00) -90.5%
>     0008.3: index-pack with 256*10 loose objects     0.49(0.04+0.03)   0.19(0.04+0.01) -61.2%    0.04(0.02+0.00) -91.8%
>     0008.4: index-pack with 256*100 loose objects    0.49(0.04+0.04)   0.33(0.18+0.01) -32.7%    0.05(0.02+0.00) -89.8%
>     0008.5: index-pack with 256*250 loose objects    0.54(0.03+0.04)   0.59(0.43+0.02) +9.3%     0.04(0.02+0.01) -92.6%
>     0008.6: index-pack with 256*500 loose objects    0.49(0.04+0.03)   1.04(0.83+0.07) +112.2%   0.04(0.02+0.00) -91.8%
>     0008.7: index-pack with 256*750 loose objects    0.56(0.04+0.05)   1.50(1.28+0.08) +167.9%   0.04(0.02+0.00) -92.9%
>     0008.8: index-pack with 256*1000 loose objects   0.54(0.05+0.03)   1.95(1.68+0.13) +261.1%   0.04(0.02+0.00) -92.6%
>
> I still think it's best to take this patch series since it's unlikely
> we're making anything worse in practice, the >50k objects case is a
> really high number, which I don't think is worth worrying about.
>
> But I am somewhat paranoid about the potential performance
> regression. I.e. this is me testing against a really expensive and
> relatively well performing NetApp NFS device where the ping stats are:
>
>     rtt min/avg/max/mdev = 0.155/0.396/1.387/0.349 ms
>
> So I suspect this might get a lot worse for setups which don't enjoy the
> same performance or network locality.

I tried this with the same filer mounted from another DC with ~10x the
RTT:

    rtt min/avg/max/mdev = 11.553/11.618/11.739/0.121 ms

But otherwise the same setup (same machine type/specs mounting it). It
had the opposite results of what I was expecting:

    Test                                             origin/master     peff/jk/loose-cache      avar/check-collisions-config
    ------------------------------------------------------------------------------------------------------------------------
    0008.2: index-pack with 256*1 loose objects      7.78(0.04+0.03)   2.75(0.03+0.01) -64.7%   0.40(0.02+0.00) -94.9%
    0008.3: index-pack with 256*10 loose objects     7.75(0.04+0.04)   2.77(0.05+0.01) -64.3%   0.40(0.02+0.00) -94.8%
    0008.4: index-pack with 256*100 loose objects    7.75(0.05+0.02)   2.91(0.18+0.01) -62.5%   0.40(0.02+0.00) -94.8%
    0008.5: index-pack with 256*250 loose objects    7.73(0.04+0.04)   3.19(0.43+0.02) -58.7%   0.40(0.02+0.00) -94.8%
    0008.6: index-pack with 256*500 loose objects    7.73(0.04+0.04)   3.64(0.83+0.05) -52.9%   0.40(0.02+0.00) -94.8%
    0008.7: index-pack with 256*750 loose objects    7.73(0.04+0.02)   4.14(1.29+0.07) -46.4%   0.40(0.02+0.00) -94.8%
    0008.8: index-pack with 256*1000 loose objects   7.73(0.04+0.03)   4.55(1.72+0.09) -41.1%   0.40(0.02+0.01) -94.8%

I.e. there the cliff of where the cache becomes counterproductive comes
much later, not earlier. The sha1collisiondetection.git repo has 418
objects.

So is it cheaper to fill a huge cache than look up those 418? I don't
know, haven't dug. But so far what this suggests is that we're helping
slow FSs to the detriment of faster ones.

So here's the same test not against NFS, but the local ext4 fs (CO7;
Linux 3.10) for sha1collisiondetection.git:

    Test                                             origin/master     peff/jk/loose-cache        avar/check-collisions-config
    --------------------------------------------------------------------------------------------------------------------------
    0008.2: index-pack with 256*1 loose objects      0.02(0.02+0.00)   0.02(0.02+0.01) +0.0%      0.02(0.02+0.00) +0.0%
    0008.3: index-pack with 256*10 loose objects     0.02(0.02+0.00)   0.03(0.03+0.00) +50.0%     0.02(0.02+0.00) +0.0%
    0008.4: index-pack with 256*100 loose objects    0.02(0.02+0.00)   0.17(0.16+0.01) +750.0%    0.02(0.02+0.00) +0.0%
    0008.5: index-pack with 256*250 loose objects    0.02(0.02+0.00)   0.43(0.40+0.03) +2050.0%   0.02(0.02+0.00) +0.0%
    0008.6: index-pack with 256*500 loose objects    0.02(0.02+0.00)   0.88(0.80+0.09) +4300.0%   0.02(0.02+0.00) +0.0%
    0008.7: index-pack with 256*750 loose objects    0.02(0.02+0.00)   1.35(1.27+0.09) +6650.0%   0.02(0.02+0.00) +0.0%
    0008.8: index-pack with 256*1000 loose objects   0.02(0.02+0.00)   1.83(1.70+0.14) +9050.0%   0.02(0.02+0.00) +0.0%

And for mu.git, a ~20k object repo:

    Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
    -------------------------------------------------------------------------------------------------------------------------
    0008.2: index-pack with 256*1 loose objects      0.59(0.91+0.06)   0.58(0.93+0.03) -1.7%     0.57(0.89+0.04) -3.4%
    0008.3: index-pack with 256*10 loose objects     0.59(0.91+0.07)   0.59(0.92+0.03) +0.0%     0.57(0.89+0.03) -3.4%
    0008.4: index-pack with 256*100 loose objects    0.59(0.91+0.05)   0.81(1.13+0.04) +37.3%    0.58(0.91+0.04) -1.7%
    0008.5: index-pack with 256*250 loose objects    0.59(0.91+0.05)   1.23(1.51+0.08) +108.5%   0.58(0.91+0.04) -1.7%
    0008.6: index-pack with 256*500 loose objects    0.59(0.90+0.06)   1.96(2.20+0.12) +232.2%   0.58(0.91+0.04) -1.7%
    0008.7: index-pack with 256*750 loose objects    0.59(0.92+0.05)   2.72(2.92+0.17) +361.0%   0.58(0.90+0.04) -1.7%
    0008.8: index-pack with 256*1000 loose objects   0.59(0.90+0.06)   3.50(3.67+0.21) +493.2%   0.57(0.90+0.04) -3.4%

All of which is to say that I think it definitely makes sense to re-roll
this with a perf test, and a switch to toggle it + docs explaining the
caveats & pointing to the perf test. It's a clear win in some scenarios,
but a big loss in others.

>> $ cat t/perf/p0008-index-pack.sh
>> #!/bin/sh
>>
>> test_description="Tests performance of index-pack with loose objects"
>>
>> . ./perf-lib.sh
>>
>> test_perf_fresh_repo
>>
>> test_expect_success 'setup tests' '
>> 	for count in 1 10 100 250 500 750 1000
>> 	do
>> 		if test -d /mnt/ontap_githackers/repo-$count.git
>> 		then
>> 			rm -rf /mnt/ontap_githackers/repo-$count.git/objects/pack
>> 		else
>> 			git init --bare /mnt/ontap_githackers/repo-$count.git &&
>> 			(
>> 				cd /mnt/ontap_githackers/repo-$count.git &&
>> 				for i in $(seq 0 255)
>> 				do
>> 					i=$(printf %02x $i) &&
>> 					mkdir objects/$i &&
>> 					for j in $(seq --format=%038g $count)
>> 					do
>> 						>objects/$i/$j
>> 					done
>> 				done
>> 			)
>> 		fi
>> 	done
>> '
>>
>> for count in 1 10 100 250 500 750 1000
>> do
>> 	echo 3 | sudo tee /proc/sys/vm/drop_caches
>> 	test_perf "index-pack with 256*$count loose objects" "
>> 		(
>> 			cd /mnt/ontap_githackers/repo-$count.git &&
>> 			rm -fv objects/pack/*;
>> 			git -c core.checkCollisions=false index-pack -v --stdin </home/aearnfjord/g/DBD-mysql/.git/objects/pack/pack-*.pack
>> 		)
>> 	"
>> done
>>
>> test_done
