Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222511F404
	for <e@80x24.org>; Wed,  7 Mar 2018 12:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeCGMTb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 7 Mar 2018 07:19:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:62716 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeCGMTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 07:19:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2018 04:19:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,435,1515484800"; 
   d="scan'208";a="23221168"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2018 04:19:28 -0800
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 7 Mar 2018 04:18:50 -0800
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 7 Mar 2018 04:18:49 -0800
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.252]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Wed, 7 Mar 2018 14:16:49 +0200
From:   "Vromen, Tomer" <tomer.vromen@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug report: git-stash doesn't return correct status code
Thread-Topic: Bug report: git-stash doesn't return correct status code
Thread-Index: AdO2DZ6mZ3OCKXPgQ+aMAsqWU0GB6Q==
Date:   Wed, 7 Mar 2018 12:16:48 +0000
Message-ID: <8ED425DE0F8BEC45AADD477A8872875788FB691C@hasmsx109.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWRmMDkyYjMtYzkwYS00MDRkLThhYjItMDVjNGQ0Y2Q5OTU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJWQ2dNZnlZWkk1UkVPSHV4NkhCN1FyVlNJKytPcXMrRzdHUVY4ZUZ5cnd3RVBaaVMyZlwvQm9uNUlqRU1yb2FmNCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.185.75.169]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I often use this one-liner:

> git stash && git checkout -b new-feature-branch && git stash pop

This is useful when I realize that I want to open a new branch for my changes (that I haven't committed yet).
However, I might have forgotten to save my changes in the editor, so git-stash will give this error:

No local changes to save

Despite the error, the command returns status code 0, and so the branch is created and the stash is popped, which was not my intention.
I think that git-stash should return a non-zero status code if it didn't push a new stash.

git version: 2.8.4


Thank you,
Tomer Vromen

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

