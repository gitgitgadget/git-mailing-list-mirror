Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A9D1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbdBAW0J convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 1 Feb 2017 17:26:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:4916 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752858AbdBAW0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:26:08 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP; 01 Feb 2017 14:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,322,1477983600"; 
   d="scan'208";a="60128053"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2017 14:26:07 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.108]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.69]) with mapi id 14.03.0248.002;
 Wed, 1 Feb 2017 14:26:06 -0800
From:   "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git commit results in many lstat()s
Thread-Topic: git commit results in many lstat()s
Thread-Index: AdJ8zldaoJRrSN8YSgqDGiFiJtHa4gACc4EfAABbhxA=
Date:   Wed, 1 Feb 2017 22:26:05 +0000
Message-ID: <DA0A42D68346B1469147552440A645039A9C57D6@ORSMSX115.amr.corp.intel.com>
References: <DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com>
 <xmqq8tppo92x.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq8tppo92x.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2JjODgxYTQtZWUwNy00Yjk2LThkYmMtNjAyNzk2MWE2M2EyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6IjdnRzBrQ1wvZW9WcWo5R0ZZam1WXC9IS2pGeEp4NDhlWGxRQTY1SmFlQXA4WT0ifQ==
x-ctpclassification: CTP_IC
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano" <jch2355@gmail.com> writes:
> There probably are other things that can be optimized.

Yes, I think that when the user passes --only flag to git-commit, then git does not
need to call refresh_cache() in prepare_index() in builtin/commit.c.

I may experiment with that. Do you see any downside or negative side-effects?

Matt
