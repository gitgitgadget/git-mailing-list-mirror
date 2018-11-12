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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA7A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeKMIZk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:25:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35839 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeKMIZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:25:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so9656965wmt.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 14:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=b5yTqK/E3x11ZO92G++6cCIl2qSeknOYB8wBzLlSWd0=;
        b=EjdwFiTS6MdLCGatpq8zf6vhdrylBKgTWh5qEKCiT/yW70gq+0ZrWp7RXC0iCaN6vP
         oYgY+UM4nY3pj0sOzWip7+f/LudNoImUbuMWo5hZuoLgofzMSUUWwYW6qC1L8eWHY6HS
         3M4EIZzupGxF6lWxXEjo8eo8WN4KcO7YzSho6WqcsP3Q8QtWLJPIGLLEaRuLzcjM/06T
         zTCEPVBPuh4k+3WKP0JwIuALXfxRwfEwfc+P3bX1j1uWwMimRT7JLiK50b93OSremkkz
         qb6HxBctfI8wvd3O0s98VBLxhVqxGtLCMAsKLly4FVq+d/SDUxoa16kbFk+tzhF7fst4
         xTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=b5yTqK/E3x11ZO92G++6cCIl2qSeknOYB8wBzLlSWd0=;
        b=huHcs+duUjgoXLmX79DcqPnqc1SltbyZ/QZlpjhxksB08hRI0nOc2VYc6YU7f6HQIK
         6je/VJ1V3SW47wgHZYWejDXxyv9J65sumkaUZ0QhoIY8Q+bkj0X56dFbSf6J32bfrMLY
         0wy+AV39fLHUlScyerhQSuLkShlcdqiOpovSswn11xIG/KbOGCW/Y8ebi1ahw5b9IbWM
         VGo1OctJZv4w6AazsGLALmNKjhPHe7UbnF4clWord5l50kO2H4EMPamDyNMFb+EMzQ3n
         kZP63PrYzgAA8w2up+vGicdG5wuaQsEoXYAqk/JWxCkwwEGZjJsFVz9ahPl7DqQh0cmZ
         NvKw==
X-Gm-Message-State: AGRZ1gL/EjyITtSub0pl5Yvr74gn8HWR59T2idjsWFz9NOmEV9A7v9pb
        U99NldwOrxLuJyW2EEXJfV0=
X-Google-Smtp-Source: AJdET5cxVqMTGz7gOJm4XItquPRRkjIrk8fAToi4jKQnz6rC67D04nz7JhoSjYhnCr8uS7rA6/eIvA==
X-Received: by 2002:a1c:1189:: with SMTP id 131-v6mr1161945wmr.87.1542061827209;
        Mon, 12 Nov 2018 14:30:27 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id y21-v6sm8035108wma.36.2018.11.12.14.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 14:30:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence check
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112145442.GH7400@sigill.intra.peff.net> <87ftw62sld.fsf@evledraar.gmail.com> <20181112162150.GB7612@sigill.intra.peff.net> <87d0ra2b3z.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87d0ra2b3z.fsf@evledraar.gmail.com>
Date:   Mon, 12 Nov 2018 23:30:24 +0100
Message-ID: <87bm6u2akf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Nov 12 2018, Jeff King wrote:
>
>> On Mon, Nov 12, 2018 at 05:01:02PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>
>>> > There's some obvious hand-waving in the paragraphs above. I would love
>>> > it if somebody with an NFS system could do some before/after timings
>>> > with various numbers of loose objects, to get a sense of where the
>>> > breakeven point is.
>>> >
>>> > My gut is that we do not need the complexity of a cache-size limit, nor
>>> > of a config option to disable this. But it would be nice to have a real
>>> > number where "reasonable" ends and "pathological" begins. :)
>>>
>>> I'm happy to test this on some of the NFS we have locally, and started
>>> out with a plan to write some for-loop using the low-level API (so it
>>> would look up all 256), fake populate .git/objects/?? with N number of
>>> objects etc, but ran out of time.
>>>
>>> Do you have something ready that you think would be representative and I
>>> could just run? If not I'll try to pick this up again...
>>
>> No, but they don't even really need to be actual objects. So I suspect
>> something like:
>>
>>   git init
>>   for i in $(seq 256); do
>>     i=$(printf %02x $i)
>>     mkdir -p .git/objects/$i
>>     for j in $(seq --format=%038g 1000); do
>>       echo foo >.git/objects/$i/$j
>>     done
>>   done
>>   git index-pack -v --stdin </path/to/git.git/objects/pack/XYZ.pack
>>
>> might work (for various values of 1000). The shell loop would probably
>> be faster as perl, too. :)
>>
>> Make sure you clear the object directory between runs, though (otherwise
>> the subsequent index-pack's really do find collisions and spend time
>> accessing the objects).
>>
>> If you want real objects, you could probably just dump a bunch of
>> sequential blobs to fast-import, and then pipe the result to
>> unpack-objects.
>>
>> -Peff
>
> I did a very ad-hoc test against a NetApp filer using the test script
> quoted at the end of this E-Mail. The test compared origin/master, this
> branch of yours, and my core.checkCollisions=false branch.
>
> When run with DBD-mysql.git (just some random ~1k commit repo I had):
>
>     $ GIT_PERF_REPEAT_COUNT=3 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run origin/master peff/jk/loose-cache avar/check-collisions-config p0008-index-pack.sh
>
> I get:
>
>     Test                                             origin/master     peff/jk/loose-cache      avar/check-collisions-config
>     ------------------------------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      4.31(0.55+0.18)   0.41(0.40+0.02) -90.5%   0.23(0.36+0.01) -94.7%
>     0008.3: index-pack with 256*10 loose objects     4.37(0.45+0.21)   0.45(0.40+0.02) -89.7%   0.25(0.38+0.01) -94.3%
>     0008.4: index-pack with 256*100 loose objects    4.47(0.53+0.23)   0.67(0.63+0.02) -85.0%   0.24(0.38+0.01) -94.6%
>     0008.5: index-pack with 256*250 loose objects    5.01(0.67+0.30)   1.04(0.98+0.06) -79.2%   0.24(0.37+0.01) -95.2%
>     0008.6: index-pack with 256*500 loose objects    5.11(0.57+0.21)   1.81(1.70+0.09) -64.6%   0.25(0.38+0.01) -95.1%
>     0008.7: index-pack with 256*750 loose objects    5.12(0.60+0.22)   2.54(2.38+0.14) -50.4%   0.24(0.38+0.01) -95.3%
>     0008.8: index-pack with 256*1000 loose objects   4.52(0.52+0.21)   3.36(3.17+0.17) -25.7%   0.23(0.36+0.01) -94.9%
>
> I then hacked it to test against git.git, but skipped origin/master for
> that one because it takes *ages*. So just mine v.s. yours:
>
>     $ GIT_PERF_REPEAT_COUNT=3 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run peff/jk/loose-cache avar/check-collisions-config p0008-index-pack.sh
>     [...]
>     Test                                             peff/jk/loose-cache   avar/check-collisions-config
>     ---------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      12.57(28.72+0.61)     12.68(29.36+0.62) +0.9%
>     0008.3: index-pack with 256*10 loose objects     12.77(28.75+0.61)     12.50(28.88+0.56) -2.1%
>     0008.4: index-pack with 256*100 loose objects    13.20(29.49+0.66)     12.38(28.58+0.60) -6.2%
>     0008.5: index-pack with 256*250 loose objects    14.10(30.59+0.64)     12.54(28.22+0.57) -11.1%
>     0008.6: index-pack with 256*500 loose objects    14.48(31.06+0.74)     12.43(28.59+0.60) -14.2%
>     0008.7: index-pack with 256*750 loose objects    15.31(31.91+0.74)     12.67(29.23+0.64) -17.2%
>     0008.8: index-pack with 256*1000 loose objects   16.34(32.84+0.76)     13.11(30.19+0.68) -19.8%
>
> So not much of a practical difference perhaps. But then again this isn't
> a very realistic test case of anything. Rarely are you going to push a
> history of something the size of git.git into a repo with this many
> loose objects.
>
> Using sha1collisiondetection.git is I think the most realistic scenario,
> i.e. you'll often end up fetching/pushing something roughly the size of
> its entire history on a big repo, and with it:
>
>     Test                                             peff/jk/loose-cache   avar/check-collisions-config
>     ---------------------------------------------------------------------------------------------------
>     0008.2: index-pack with 256*1 loose objects      0.16(0.04+0.01)       0.05(0.03+0.00) -68.8%
>     0008.3: index-pack with 256*10 loose objects     0.19(0.04+0.02)       0.05(0.02+0.00) -73.7%
>     0008.4: index-pack with 256*100 loose objects    0.32(0.17+0.02)       0.04(0.02+0.00) -87.5%
>     0008.5: index-pack with 256*250 loose objects    0.57(0.41+0.03)       0.04(0.02+0.00) -93.0%
>     0008.6: index-pack with 256*500 loose objects    1.02(0.83+0.06)       0.04(0.03+0.00) -96.1%
>     0008.7: index-pack with 256*750 loose objects    1.47(1.24+0.10)       0.04(0.02+0.00) -97.3%
>     0008.8: index-pack with 256*1000 loose objects   1.94(1.70+0.10)       0.04(0.02+0.00) -97.9%
>
> As noted in previous threads I have an in-house monorepo where (due to
> expiry policies) loose objects hover around the 256*250 mark.
>
> The script, which is hacky as hell and takes shortcuts not to re-create
> the huge fake loose object collection every time (takes ages). Perhaps
> you're interested in incorporating some version of this into a v2. To be
> useful it should take some target path as an env variable.

I forgot perhaps the most useful metric. Testing against origin/master
too on the sha1collisiondetection.git repo, which as noted above I think
is a good stand-in for making a medium sized push to a big repo. This
shows when the loose cache becomes counterproductive:

    Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
    -------------------------------------------------------------------------------------------------------------------------
    0008.2: index-pack with 256*1 loose objects      0.42(0.04+0.03)   0.17(0.04+0.00) -59.5%    0.04(0.03+0.00) -90.5%
    0008.3: index-pack with 256*10 loose objects     0.49(0.04+0.03)   0.19(0.04+0.01) -61.2%    0.04(0.02+0.00) -91.8%
    0008.4: index-pack with 256*100 loose objects    0.49(0.04+0.04)   0.33(0.18+0.01) -32.7%    0.05(0.02+0.00) -89.8%
    0008.5: index-pack with 256*250 loose objects    0.54(0.03+0.04)   0.59(0.43+0.02) +9.3%     0.04(0.02+0.01) -92.6%
    0008.6: index-pack with 256*500 loose objects    0.49(0.04+0.03)   1.04(0.83+0.07) +112.2%   0.04(0.02+0.00) -91.8%
    0008.7: index-pack with 256*750 loose objects    0.56(0.04+0.05)   1.50(1.28+0.08) +167.9%   0.04(0.02+0.00) -92.9%
    0008.8: index-pack with 256*1000 loose objects   0.54(0.05+0.03)   1.95(1.68+0.13) +261.1%   0.04(0.02+0.00) -92.6%

I still think it's best to take this patch series since it's unlikely
we're making anything worse in practice, the >50k objects case is a
really high number, which I don't think is worth worrying about.

But I am somewhat paranoid about the potential performance
regression. I.e. this is me testing against a really expensive and
relatively well performing NetApp NFS device where the ping stats are:

    rtt min/avg/max/mdev = 0.155/0.396/1.387/0.349 ms

So I suspect this might get a lot worse for setups which don't enjoy the
same performance or network locality.


> $ cat t/perf/p0008-index-pack.sh
> #!/bin/sh
>
> test_description="Tests performance of index-pack with loose objects"
>
> . ./perf-lib.sh
>
> test_perf_fresh_repo
>
> test_expect_success 'setup tests' '
> 	for count in 1 10 100 250 500 750 1000
> 	do
> 		if test -d /mnt/ontap_githackers/repo-$count.git
> 		then
> 			rm -rf /mnt/ontap_githackers/repo-$count.git/objects/pack
> 		else
> 			git init --bare /mnt/ontap_githackers/repo-$count.git &&
> 			(
> 				cd /mnt/ontap_githackers/repo-$count.git &&
> 				for i in $(seq 0 255)
> 				do
> 					i=$(printf %02x $i) &&
> 					mkdir objects/$i &&
> 					for j in $(seq --format=%038g $count)
> 					do
> 						>objects/$i/$j
> 					done
> 				done
> 			)
> 		fi
> 	done
> '
>
> for count in 1 10 100 250 500 750 1000
> do
> 	echo 3 | sudo tee /proc/sys/vm/drop_caches
> 	test_perf "index-pack with 256*$count loose objects" "
> 		(
> 			cd /mnt/ontap_githackers/repo-$count.git &&
> 			rm -fv objects/pack/*;
> 			git -c core.checkCollisions=false index-pack -v --stdin </home/aearnfjord/g/DBD-mysql/.git/objects/pack/pack-*.pack
> 		)
> 	"
> done
>
> test_done
