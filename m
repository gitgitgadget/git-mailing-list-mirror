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
	by dcvr.yhbt.net (Postfix) with ESMTP id CD76A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbeKMINw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:13:52 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:34186 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMINw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:13:52 -0500
Received: by mail-wm1-f41.google.com with SMTP id f1-v6so9808517wmg.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 14:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rISCccNohwmm0MTgAahSksBi6yMWyy+mJuHTvNteWRA=;
        b=ba4IZTdXMVT7bZRiCkb7TrM+C/D8bjUZKk7WbxqI0dY21Yi6T3pNfKYOt/ilM4q5uG
         M6qQa/9WBbK6cfq+TWfdmMdegvrUQsRnis/4HG1QMKKJVNT5H7IdxGUWEWlXwezVL377
         1uaQZKoyC6P/knqxOLUY1lbHXIyxfdwZgL2gH+hYEbIioF8owa3Y4+4Y49A7WSFs1Dxp
         ThhYjdDuHhYzatDWqbOtsAWCocZSRF/H0bZThDq+XyaDNBnJ0IBlkUe1T+LUeeY8eTY1
         qwAHrjMW++HMKBTvyXr5UDOB9WOXlNz03q0lR9xMb4kSnXlhrOfvyO5sDq/ID9iTL72p
         vMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rISCccNohwmm0MTgAahSksBi6yMWyy+mJuHTvNteWRA=;
        b=jGED2t4XiiymeCwNtQCkev56+O0lLpUcMKO80o0oGh0TRUig8vohjmi85eojaRdqM6
         LKA0CXXzvo/x45N+USoell+AR1SDX/S5h5F9mqcyXC44XwcXHOqGzyrhr5dY7OhtH/hB
         ipodwR1X2X9JyB5QQSSHyWpc91EjO/1QCuUTwfvoNygDhtG2exL2ytBtlzanBovY8cmJ
         S0DdW3Wv4lhu4Gn2Cy4+0gX7TcunkdfaWRc5VgOkKqK+Ql5OW93U1+N8SGTID8TMi0Xk
         GkjeUsNh/5hl2g5C1PgfQ5daqJq3ynon18Hzdn/JsfGbk3GhycL0X//H7vNs0k//vc+V
         QTag==
X-Gm-Message-State: AGRZ1gJ2RYgqsqWkmYW1ISsREH5wbTruhy8dah+UrAxUpBmonp32/rna
        fJMyln3dI/6iIqPgXwr9/RQ=
X-Google-Smtp-Source: AJdET5f8WzHNsCHGjv+UGvRKvshIXCWkqGN00a8Kil4jvK2HZ6NCHD1mUlhixHNeh5+4zB4RabHbWg==
X-Received: by 2002:a7b:c052:: with SMTP id u18-v6mr1112476wmc.81.1542061122964;
        Mon, 12 Nov 2018 14:18:42 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v10-v6sm28110737wrq.4.2018.11.12.14.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 14:18:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence check
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112145442.GH7400@sigill.intra.peff.net> <87ftw62sld.fsf@evledraar.gmail.com> <20181112162150.GB7612@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181112162150.GB7612@sigill.intra.peff.net>
Date:   Mon, 12 Nov 2018 23:18:40 +0100
Message-ID: <87d0ra2b3z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Jeff King wrote:

> On Mon, Nov 12, 2018 at 05:01:02PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> > There's some obvious hand-waving in the paragraphs above. I would love
>> > it if somebody with an NFS system could do some before/after timings
>> > with various numbers of loose objects, to get a sense of where the
>> > breakeven point is.
>> >
>> > My gut is that we do not need the complexity of a cache-size limit, nor
>> > of a config option to disable this. But it would be nice to have a real
>> > number where "reasonable" ends and "pathological" begins. :)
>>
>> I'm happy to test this on some of the NFS we have locally, and started
>> out with a plan to write some for-loop using the low-level API (so it
>> would look up all 256), fake populate .git/objects/?? with N number of
>> objects etc, but ran out of time.
>>
>> Do you have something ready that you think would be representative and I
>> could just run? If not I'll try to pick this up again...
>
> No, but they don't even really need to be actual objects. So I suspect
> something like:
>
>   git init
>   for i in $(seq 256); do
>     i=$(printf %02x $i)
>     mkdir -p .git/objects/$i
>     for j in $(seq --format=%038g 1000); do
>       echo foo >.git/objects/$i/$j
>     done
>   done
>   git index-pack -v --stdin </path/to/git.git/objects/pack/XYZ.pack
>
> might work (for various values of 1000). The shell loop would probably
> be faster as perl, too. :)
>
> Make sure you clear the object directory between runs, though (otherwise
> the subsequent index-pack's really do find collisions and spend time
> accessing the objects).
>
> If you want real objects, you could probably just dump a bunch of
> sequential blobs to fast-import, and then pipe the result to
> unpack-objects.
>
> -Peff

I did a very ad-hoc test against a NetApp filer using the test script
quoted at the end of this E-Mail. The test compared origin/master, this
branch of yours, and my core.checkCollisions=false branch.

When run with DBD-mysql.git (just some random ~1k commit repo I had):

    $ GIT_PERF_REPEAT_COUNT=3 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run origin/master peff/jk/loose-cache avar/check-collisions-config p0008-index-pack.sh

I get:

    Test                                             origin/master     peff/jk/loose-cache      avar/check-collisions-config
    ------------------------------------------------------------------------------------------------------------------------
    0008.2: index-pack with 256*1 loose objects      4.31(0.55+0.18)   0.41(0.40+0.02) -90.5%   0.23(0.36+0.01) -94.7%
    0008.3: index-pack with 256*10 loose objects     4.37(0.45+0.21)   0.45(0.40+0.02) -89.7%   0.25(0.38+0.01) -94.3%
    0008.4: index-pack with 256*100 loose objects    4.47(0.53+0.23)   0.67(0.63+0.02) -85.0%   0.24(0.38+0.01) -94.6%
    0008.5: index-pack with 256*250 loose objects    5.01(0.67+0.30)   1.04(0.98+0.06) -79.2%   0.24(0.37+0.01) -95.2%
    0008.6: index-pack with 256*500 loose objects    5.11(0.57+0.21)   1.81(1.70+0.09) -64.6%   0.25(0.38+0.01) -95.1%
    0008.7: index-pack with 256*750 loose objects    5.12(0.60+0.22)   2.54(2.38+0.14) -50.4%   0.24(0.38+0.01) -95.3%
    0008.8: index-pack with 256*1000 loose objects   4.52(0.52+0.21)   3.36(3.17+0.17) -25.7%   0.23(0.36+0.01) -94.9%

I then hacked it to test against git.git, but skipped origin/master for
that one because it takes *ages*. So just mine v.s. yours:

    $ GIT_PERF_REPEAT_COUNT=3 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run peff/jk/loose-cache avar/check-collisions-config p0008-index-pack.sh
    [...]
    Test                                             peff/jk/loose-cache   avar/check-collisions-config
    ---------------------------------------------------------------------------------------------------
    0008.2: index-pack with 256*1 loose objects      12.57(28.72+0.61)     12.68(29.36+0.62) +0.9%
    0008.3: index-pack with 256*10 loose objects     12.77(28.75+0.61)     12.50(28.88+0.56) -2.1%
    0008.4: index-pack with 256*100 loose objects    13.20(29.49+0.66)     12.38(28.58+0.60) -6.2%
    0008.5: index-pack with 256*250 loose objects    14.10(30.59+0.64)     12.54(28.22+0.57) -11.1%
    0008.6: index-pack with 256*500 loose objects    14.48(31.06+0.74)     12.43(28.59+0.60) -14.2%
    0008.7: index-pack with 256*750 loose objects    15.31(31.91+0.74)     12.67(29.23+0.64) -17.2%
    0008.8: index-pack with 256*1000 loose objects   16.34(32.84+0.76)     13.11(30.19+0.68) -19.8%

So not much of a practical difference perhaps. But then again this isn't
a very realistic test case of anything. Rarely are you going to push a
history of something the size of git.git into a repo with this many
loose objects.

Using sha1collisiondetection.git is I think the most realistic scenario,
i.e. you'll often end up fetching/pushing something roughly the size of
its entire history on a big repo, and with it:

    Test                                             peff/jk/loose-cache   avar/check-collisions-config
    ---------------------------------------------------------------------------------------------------
    0008.2: index-pack with 256*1 loose objects      0.16(0.04+0.01)       0.05(0.03+0.00) -68.8%
    0008.3: index-pack with 256*10 loose objects     0.19(0.04+0.02)       0.05(0.02+0.00) -73.7%
    0008.4: index-pack with 256*100 loose objects    0.32(0.17+0.02)       0.04(0.02+0.00) -87.5%
    0008.5: index-pack with 256*250 loose objects    0.57(0.41+0.03)       0.04(0.02+0.00) -93.0%
    0008.6: index-pack with 256*500 loose objects    1.02(0.83+0.06)       0.04(0.03+0.00) -96.1%
    0008.7: index-pack with 256*750 loose objects    1.47(1.24+0.10)       0.04(0.02+0.00) -97.3%
    0008.8: index-pack with 256*1000 loose objects   1.94(1.70+0.10)       0.04(0.02+0.00) -97.9%

As noted in previous threads I have an in-house monorepo where (due to
expiry policies) loose objects hover around the 256*250 mark.

The script, which is hacky as hell and takes shortcuts not to re-create
the huge fake loose object collection every time (takes ages). Perhaps
you're interested in incorporating some version of this into a v2. To be
useful it should take some target path as an env variable.

$ cat t/perf/p0008-index-pack.sh
#!/bin/sh

test_description="Tests performance of index-pack with loose objects"

. ./perf-lib.sh

test_perf_fresh_repo

test_expect_success 'setup tests' '
	for count in 1 10 100 250 500 750 1000
	do
		if test -d /mnt/ontap_githackers/repo-$count.git
		then
			rm -rf /mnt/ontap_githackers/repo-$count.git/objects/pack
		else
			git init --bare /mnt/ontap_githackers/repo-$count.git &&
			(
				cd /mnt/ontap_githackers/repo-$count.git &&
				for i in $(seq 0 255)
				do
					i=$(printf %02x $i) &&
					mkdir objects/$i &&
					for j in $(seq --format=%038g $count)
					do
						>objects/$i/$j
					done
				done
			)
		fi
	done
'

for count in 1 10 100 250 500 750 1000
do
	echo 3 | sudo tee /proc/sys/vm/drop_caches
	test_perf "index-pack with 256*$count loose objects" "
		(
			cd /mnt/ontap_githackers/repo-$count.git &&
			rm -fv objects/pack/*;
			git -c core.checkCollisions=false index-pack -v --stdin </home/aearnfjord/g/DBD-mysql/.git/objects/pack/pack-*.pack
		)
	"
done

test_done
