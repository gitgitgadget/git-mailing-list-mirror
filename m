Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B958D1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 22:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGZWD5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 18:03:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43062 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfGZWD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 18:03:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so25122960pfg.10
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w8eajx8wEXFaY3Z6W8y58dwc6bEjINOxrs9+c2HYfRs=;
        b=NcEfG0xg++C9lo+IxBAtGhSXzeB/qR38JKnoIaaaKCtm2r1X+xpda+LRsyutsGmsnF
         02asDX+JJkBXi17I3933UFZOkpD+xw+nzgge8m4wsH4iZ7K7P22lM+NFYbfpZ43P2xJe
         FrnTq3ducGiBoCkFSt8SvPLgnpOe49Ux4Neg6kH5NU0polq+T1D6xipHWnJbRu1wkiY0
         miHuNDkvNvghRuUV9UFxDsE9xaDZo3/PnL3L1BFImBVJ3RhSRmoDZ/IHFG4Pyr7QzLBs
         tWP4jHB4tmkYuu1jPavuM319vjFH/YfiHdwEJRXZHU7/h9uKO83FNsqnjTyAPVkn5DjR
         tcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w8eajx8wEXFaY3Z6W8y58dwc6bEjINOxrs9+c2HYfRs=;
        b=imsrb7/nyMjtmkdnDObS05618qanv6+Ydr4Wvu0ylBqQ882HF+Y0FpWi45j5G9fUYI
         o6gWKnxOCFng/xc+rgpTXysul6qO7She6G6nFNyUfcjne4f7rqvfoZa4s6FeH1o4Rn/D
         Ux8pi7zCpk0PV/XGzUYs7rkZC2yef88uR823YTnzjkPe/0PXQxHI1yV0DusNTJvf+ekh
         BJe46R2vIfcd2WgUfspdkRDiiDS01nxeR5wj+KmP0ER5kVcFHg5nECKD97lke3ls22D5
         QBOqDo7eMZ/1a/g2mrIye6QO6GU972scZ2e0H1L0P+P6H4BFpAFlP1U/7MhgwcJlPMeJ
         P0kQ==
X-Gm-Message-State: APjAAAUjJqpbAiLJK1K2rntKl3RcHWDvTHWwy/xoZPWfmKtdcfhrZ7dg
        mDisg+hridmqa1O0SrgPCEZniA==
X-Google-Smtp-Source: APXvYqz0Yz4NWa4rTXPxKdpv5LNduh3zyIcEIUcpdBJ2fAEcWsustBuw8FtXC8CKT6fspgsPEBIiQA==
X-Received: by 2002:a63:784c:: with SMTP id t73mr96043293pgc.268.1564178634778;
        Fri, 26 Jul 2019 15:03:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id q1sm75132596pfn.178.2019.07.26.15.03.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 15:03:53 -0700 (PDT)
Date:   Fri, 26 Jul 2019 15:03:48 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190726220348.GF43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.26 14:12, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 26 Jul 2019, SZEDER Gábor wrote:
> 
> > On Wed, Jul 24, 2019 at 04:06:50PM -0700, Josh Steadmon wrote:
> >
> > > 3:  acf3aebcaa ! 3:  a07458b2e4 ci: run trace2 schema validation in the CI suite
> > >     @@ ci/run-build-and-tests.sh: then
> > >       	make test
> > >      +	t/trace_schema_validator/trace_schema_validator \
> > >      +		--trace2_event_file=${GIT_TRACE2_EVENT} \
> > >     -+		--schema_file=t/trace_schema_validator/strict_schema.json
> > >     ++		--schema_file=t/trace_schema_validator/strict_schema.json \
> >
> > However, the options used in the CI script remained unchanged, and,
> > consequently, the build breaks with the message "flag provided but not
> > defined: -trace2_event_file" (nit: which doesn't begin with the prefix
> > "error:"):
> >
> >   https://travis-ci.org/git/git/jobs/563776273#L2238
> 
> Not only on Travis, but obviously also on Azure Pipelines.
> 
> I was wary about this patch series ever since I got aware that it
> refuses to use an already-available JSON schema validator (such as
> `ajv`, a seemingly well-established all-purpose validator that even
> claims to be the fastest validator) and instead tries to push down our
> throat the first Go-implemented thing in git.git.

As I mentioned in my cover letter, all the standalone validators that I
had previously tested took multiple hours to validate the full "make
test" output.  Additionally, they tended to have unhelpful output in the
case of non-validating messages, that did not describe how or where the
validation failed.

I had previously attempted to evaluate ajv-cli, but I could not get npm
to install it correctly on my machine. I took another look today, and I
am pleasantly surprised to see that it can validate the full 1.7M line
trace output in just over a minute. Moreover, it has helpful output when
validation fails. So I would be happy to re-implement this using
ajv-cli.

This will also require using `jq` to massage the trace output from
JSON-Lines into a single JSON list object; I presume that adding jq as a
dependency to the CI suite would not be a burden? If so I suppose `sed`
would also suffice.

> That somehow does not sit well with me.
> 
> And I still think we can do a lot better than implement a JSON schema
> validator in Go (which has nothing to do with Git), leverage other,
> well-maintained projects instead, and gain even more power by not having
> to maintain it in git.git, and by avoiding to add yet another Language
> You Gotta Know To Do Git. (We already have too many of those, and quite
> honestly, I'd rather add Javascript that we _already_ kinda require
> contributors to know because of GitWeb, rather than any other
> language, especially languages that seem to be controlled by one
> company, that's why I still stay away from .NET and even Java, to be
> quite honest, even if I was really super knowledgeable about Java
> because of my previous job).
> 
> Besides, I have to admit that I am quite disheartened to see these lines
> in the log:
> 
> -- snip --
> 2019/07/26 11:39:28 Validated items: 0
> 2019/07/26 11:39:32 Validated items: 10000
> 2019/07/26 11:39:36 Validated items: 20000
> 2019/07/26 11:39:40 Validated items: 30000
> 2019/07/26 11:39:44 Validated items: 40000
> 2019/07/26 11:39:49 Validated items: 50000
> 2019/07/26 11:39:53 Validated items: 60000
> 2019/07/26 11:39:57 Validated items: 70000
> 2019/07/26 11:40:02 Validated items: 80000
> 2019/07/26 11:40:06 Validated items: 90000
> 2019/07/26 11:40:11 Validated items: 100000
> 2019/07/26 11:40:15 Validated items: 110000
> 2019/07/26 11:40:19 Validated items: 120000
> 2019/07/26 11:40:23 Validated items: 130000
> 2019/07/26 11:40:28 Validated items: 140000
> 2019/07/26 11:40:32 Validated items: 150000
> 2019/07/26 11:40:36 Validated items: 160000
> 2019/07/26 11:40:41 Validated items: 170000
> 2019/07/26 11:40:45 Validated items: 180000
> 2019/07/26 11:40:50 Validated items: 190000
> 2019/07/26 11:40:54 Validated items: 200000
> 2019/07/26 11:40:59 Validated items: 210000
> 2019/07/26 11:41:04 Validated items: 220000
> 2019/07/26 11:41:08 Validated items: 230000
> 2019/07/26 11:41:13 Validated items: 240000
> 2019/07/26 11:41:17 Validated items: 250000
> 2019/07/26 11:41:22 Validated items: 260000
> 2019/07/26 11:41:27 Validated items: 270000
> 2019/07/26 11:41:31 Validated items: 280000
> 2019/07/26 11:41:36 Validated items: 290000
> 2019/07/26 11:41:40 Validated items: 300000
> 2019/07/26 11:41:45 Validated items: 310000
> 2019/07/26 11:41:49 Validated items: 320000
> 2019/07/26 11:41:54 Validated items: 330000
> 2019/07/26 11:41:58 Validated items: 340000
> 2019/07/26 11:42:03 Validated items: 350000
> 2019/07/26 11:42:08 Validated items: 360000
> 2019/07/26 11:42:12 Validated items: 370000
> 2019/07/26 11:42:17 Validated items: 380000
> 2019/07/26 11:42:21 Validated items: 390000
> 2019/07/26 11:42:25 Validated items: 400000
> 2019/07/26 11:42:30 Validated items: 410000
> 2019/07/26 11:42:35 Validated items: 420000
> 2019/07/26 11:42:39 Validated items: 430000
> 2019/07/26 11:42:44 Validated items: 440000
> 2019/07/26 11:42:48 Validated items: 450000
> 2019/07/26 11:42:53 Validated items: 460000
> 2019/07/26 11:42:57 Validated items: 470000
> 2019/07/26 11:43:02 Validated items: 480000
> 2019/07/26 11:43:06 Validated items: 490000
> 2019/07/26 11:43:11 Validated items: 500000
> 2019/07/26 11:43:16 Validated items: 510000
> 2019/07/26 11:43:20 Validated items: 520000
> 2019/07/26 11:43:25 Validated items: 530000
> 2019/07/26 11:43:29 Validated items: 540000
> 2019/07/26 11:43:34 Validated items: 550000
> 2019/07/26 11:43:38 Validated items: 560000
> 2019/07/26 11:43:43 Validated items: 570000
> 2019/07/26 11:43:47 Validated items: 580000
> 2019/07/26 11:43:51 Validated items: 590000
> 2019/07/26 11:43:56 Validated items: 600000
> 2019/07/26 11:44:00 Validated items: 610000
> 2019/07/26 11:44:04 Validated items: 620000
> 2019/07/26 11:44:09 Validated items: 630000
> 2019/07/26 11:44:13 Validated items: 640000
> 2019/07/26 11:44:18 Validated items: 650000
> 2019/07/26 11:44:22 Validated items: 660000
> 2019/07/26 11:44:27 Validated items: 670000
> 2019/07/26 11:44:31 Validated items: 680000
> 2019/07/26 11:44:35 Validated items: 690000
> 2019/07/26 11:44:40 Validated items: 700000
> 2019/07/26 11:44:44 Validated items: 710000
> 2019/07/26 11:44:48 Validated items: 720000
> 2019/07/26 11:44:52 Validated items: 730000
> 2019/07/26 11:44:57 Validated items: 740000
> 2019/07/26 11:45:01 Validated items: 750000
> 2019/07/26 11:45:05 Validated items: 760000
> 2019/07/26 11:45:10 Validated items: 770000
> 2019/07/26 11:45:14 Validated items: 780000
> 2019/07/26 11:45:19 Validated items: 790000
> 2019/07/26 11:45:23 Validated items: 800000
> 2019/07/26 11:45:27 Validated items: 810000
> 2019/07/26 11:45:31 Validated items: 820000
> 2019/07/26 11:45:36 Validated items: 830000
> 2019/07/26 11:45:40 Validated items: 840000
> 2019/07/26 11:45:44 Validated items: 850000
> 2019/07/26 11:45:49 Validated items: 860000
> 2019/07/26 11:45:53 Validated items: 870000
> 2019/07/26 11:45:57 Validated items: 880000
> 2019/07/26 11:46:01 Validated items: 890000
> 2019/07/26 11:46:06 Validated items: 900000
> 2019/07/26 11:46:10 Validated items: 910000
> 2019/07/26 11:46:14 Validated items: 920000
> 2019/07/26 11:46:19 Validated items: 930000
> 2019/07/26 11:46:23 Validated items: 940000
> 2019/07/26 11:46:27 Validated items: 950000
> 2019/07/26 11:46:31 Validated items: 960000
> 2019/07/26 11:46:36 Validated items: 970000
> 2019/07/26 11:46:40 Validated items: 980000
> 2019/07/26 11:46:44 Validated items: 990000
> 2019/07/26 11:46:49 Validated items: 1000000
> 2019/07/26 11:46:53 Validated items: 1010000
> 2019/07/26 11:46:57 Validated items: 1020000
> 2019/07/26 11:47:01 Validated items: 1030000
> 2019/07/26 11:47:05 Validated items: 1040000
> 2019/07/26 11:47:10 Validated items: 1050000
> 2019/07/26 11:47:14 Validated items: 1060000
> 2019/07/26 11:47:18 Validated items: 1070000
> 2019/07/26 11:47:22 Validated items: 1080000
> 2019/07/26 11:47:27 Validated items: 1090000
> 2019/07/26 11:47:31 Validated items: 1100000
> 2019/07/26 11:47:35 Validated items: 1110000
> 2019/07/26 11:47:40 Validated items: 1120000
> 2019/07/26 11:47:44 Validated items: 1130000
> 2019/07/26 11:47:49 Validated items: 1140000
> 2019/07/26 11:47:54 Validated items: 1150000
> 2019/07/26 11:47:58 Validated items: 1160000
> 2019/07/26 11:48:02 Validated items: 1170000
> 2019/07/26 11:48:07 Validated items: 1180000
> 2019/07/26 11:48:11 Validated items: 1190000
> 2019/07/26 11:48:15 Validated items: 1200000
> 2019/07/26 11:48:19 Validated items: 1210000
> 2019/07/26 11:48:24 Validated items: 1220000
> 2019/07/26 11:48:28 Validated items: 1230000
> 2019/07/26 11:48:33 Validated items: 1240000
> 2019/07/26 11:48:37 Validated items: 1250000
> 2019/07/26 11:48:42 Validated items: 1260000
> 2019/07/26 11:48:47 Validated items: 1270000
> 2019/07/26 11:48:52 Validated items: 1280000
> 2019/07/26 11:48:56 Validated items: 1290000
> 2019/07/26 11:49:01 Validated items: 1300000
> 2019/07/26 11:49:05 Validated items: 1310000
> 2019/07/26 11:49:09 Validated items: 1320000
> 2019/07/26 11:49:14 Validated items: 1330000
> 2019/07/26 11:49:18 Validated items: 1340000
> 2019/07/26 11:49:23 Validated items: 1350000
> 2019/07/26 11:49:28 Validated items: 1360000
> 2019/07/26 11:49:32 Validated items: 1370000
> 2019/07/26 11:49:37 Validated items: 1380000
> 2019/07/26 11:49:41 Validated items: 1390000
> 2019/07/26 11:49:46 Validated items: 1400000
> 2019/07/26 11:49:50 Validated items: 1410000
> 2019/07/26 11:49:55 Validated items: 1420000
> 2019/07/26 11:50:00 Validated items: 1430000
> 2019/07/26 11:50:04 Validated items: 1440000
> 2019/07/26 11:50:08 Validated items: 1450000
> 2019/07/26 11:50:12 Validated items: 1460000
> 2019/07/26 11:50:17 Validated items: 1470000
> 2019/07/26 11:50:21 Validated items: 1480000
> 2019/07/26 11:50:26 Validated items: 1490000
> 2019/07/26 11:50:30 Validated items: 1500000
> 2019/07/26 11:50:35 Validated items: 1510000
> 2019/07/26 11:50:39 Validated items: 1520000
> 2019/07/26 11:50:44 Validated items: 1530000
> 2019/07/26 11:50:49 Validated items: 1540000
> 2019/07/26 11:50:53 Validated items: 1550000
> 2019/07/26 11:50:57 Validated items: 1560000
> 2019/07/26 11:51:02 Validated items: 1570000
> 2019/07/26 11:51:06 Validated items: 1580000
> 2019/07/26 11:51:11 Validated items: 1590000
> 2019/07/26 11:51:15 Validated items: 1600000
> 2019/07/26 11:51:20 Validated items: 1610000
> 2019/07/26 11:51:24 Validated items: 1620000
> 2019/07/26 11:51:29 Validated items: 1630000
> 2019/07/26 11:51:33 Validated items: 1640000
> 2019/07/26 11:51:38 Validated items: 1650000
> 2019/07/26 11:51:42 Validated items: 1660000
> 2019/07/26 11:51:47 Validated items: 1670000
> 2019/07/26 11:51:51 Validated items: 1680000
> 2019/07/26 11:51:55 Validated items: 1690000
> 2019/07/26 11:52:00 Validated items: 1700000
> 2019/07/26 11:52:04 Validated items: 1710000
> 2019/07/26 11:52:09 Validated items: 1720000
> 2019/07/26 11:52:13 Validated items: 1730000
> 2019/07/26 11:52:17 Validated items: 1740000
> 2019/07/26 11:52:22 Validated items: 1750000
> 2019/07/26 11:52:26 Validated items: 1760000
> 2019/07/26 11:52:30 Validated items: 1770000
> 2019/07/26 11:52:34 Validated items: 1780000
> 2019/07/26 11:52:39 Validated items: 1790000
> 2019/07/26 11:52:43 Validated items: 1800000
> 2019/07/26 11:52:47 Validated items: 1810000
> 2019/07/26 11:52:51 Validated items: 1820000
> 2019/07/26 11:52:55 Validated items: 1830000
> 2019/07/26 11:52:59 Validated items: 1840000
> 2019/07/26 11:53:04 Validated items: 1850000
> 2019/07/26 11:53:08 Validated items: 1860000
> 2019/07/26 11:53:12 Validated items: 1870000
> 2019/07/26 11:53:16 Validated items: 1880000
> 2019/07/26 11:53:20 Validated items: 1890000
> 2019/07/26 11:53:24 Validated items: 1900000
> 2019/07/26 11:53:28 Validated items: 1910000
> 2019/07/26 11:53:32 Validated items: 1920000
> 2019/07/26 11:53:36 Validated items: 1930000
> 2019/07/26 11:53:41 Validated items: 1940000
> 2019/07/26 11:53:45 Validated items: 1950000
> 2019/07/26 11:53:49 Validated items: 1960000
> 2019/07/26 11:53:53 Validated items: 1970000
> 2019/07/26 11:53:58 Validated items: 1980000
> 2019/07/26 11:54:02 Validated items: 1990000
> 2019/07/26 11:54:06 Validated items: 2000000
> 2019/07/26 11:54:10 Validated items: 2010000
> 2019/07/26 11:54:14 Validated items: 2020000
> 2019/07/26 11:54:18 Validated items: 2030000
> 2019/07/26 11:54:23 Validated items: 2040000
> 2019/07/26 11:54:27 Validated items: 2050000
> 2019/07/26 11:54:31 Validated items: 2060000
> 2019/07/26 11:54:35 Validated items: 2070000
> 2019/07/26 11:54:39 Validated items: 2080000
> 2019/07/26 11:54:43 Validated items: 2090000
> 2019/07/26 11:54:48 Validated items: 2100000
> 2019/07/26 11:54:52 Validated items: 2110000
> 2019/07/26 11:54:56 Validated items: 2120000
> 2019/07/26 11:55:00 Validated items: 2130000
> 2019/07/26 11:55:04 Validated items: 2140000
> 2019/07/26 11:55:08 Validated items: 2150000
> 2019/07/26 11:55:12 Validated items: 2160000
> 2019/07/26 11:55:16 Validated items: 2170000
> 2019/07/26 11:55:21 Validated items: 2180000
> 2019/07/26 11:55:25 Validated items: 2190000
> 2019/07/26 11:55:29 Validated items: 2200000
> 2019/07/26 11:55:33 Validated items: 2210000
> 2019/07/26 11:55:37 Validated items: 2220000
> 2019/07/26 11:55:42 Validated items: 2230000
> 2019/07/26 11:55:46 Validated items: 2240000
> 2019/07/26 11:55:50 Validated items: 2250000
> 2019/07/26 11:55:55 Validated items: 2260000
> 2019/07/26 11:55:59 Validated items: 2270000
> 2019/07/26 11:56:03 Validated items: 2280000
> 2019/07/26 11:56:08 Validated items: 2290000
> 2019/07/26 11:56:12 Validated items: 2300000
> 2019/07/26 11:56:14 Validated events: 2303564
> -- snap --
> 
> Let me read this out loud to you. We validate about 2.3 million items,
> and we spend a whopping sixteen minutes and fourty-six seconds on
> validating them.
> 
> That's crazy.
> 
> It's not only the time, that's bad enough. It is the combined amount of
> electricity and CO2 that is spent -- quite pointlessly -- on this task.
> 
> I know that at least for Azure Pipelines, that's CO2-neutral, but that
> is only a trick and a lot of money. I'd rather avoid that in the first
> place.
> 
> What the heck are we thinking, to add such a lot of wasted time to every
> CI run? Why do we have to validate *that* many items? And why do we have
> to use a validator that is obviously pretty slow at doing this?
> 
> In the short run, let's fix the build. But even before the next
> iteraion, let's try to find a way to avoid having to maintain a JSON
> validator in Git's source code, _and_ let's avoid wasting so much time
> and electricty.
> 
> Junio, I need this patch to fix the build, would you terribly mind
> applying it on top of `js/trace2-json-schema`?
> 
> -- snipsnap --
> From 2deb3ac117768133551716c9788266671aafb445 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 26 Jul 2019 13:18:26 +0200
> Subject: [PATCH] fixup??? ci: run trace2 schema validation in the CI suite
> 
> That seems like an oversight when iterating the patch series.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 8103125849..696b6248ed 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -24,8 +24,8 @@ linux-gcc)
>  	export GIT_TEST_ADD_I_USE_BUILTIN=1
>  	make test
>  	t/trace_schema_validator/trace_schema_validator \
> -		--trace2_event_file=${GIT_TRACE2_EVENT} \
> -		--schema_file=t/trace_schema_validator/strict_schema.json \
> +		--trace2-event-file=${GIT_TRACE2_EVENT} \
> +		--schema-file=t/trace_schema_validator/strict_schema.json \
>  		--progress=10000
>  	;;
>  linux-gcc-4.8)
> --
> 2.22.0.windows.1.6.g271c090e89

