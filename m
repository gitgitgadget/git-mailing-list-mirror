Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B95F1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 01:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935930AbeFNBgJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 21:36:09 -0400
Received: from mail-pu1apc01on0052.outbound.protection.outlook.com ([104.47.126.52]:40800
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935889AbeFNBgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 21:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortunewhite.onmicrosoft.com; s=selector1-fortunewhite-org;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZokNaomKgOlMqN5/je1wk3vUskbCiy878TdsOrjgKjY=;
 b=HobmApCTPGCMVXLToxLqUbMY2320xOKHZ/nhj7WsDNkjsmyDxgc13eZpoXK7JNrtEulxyxTdIQOheBKkPNKBEEwvZF+gs8VPHZ56BU3/abGZzntfD12H+RVUvIF9AVMOYBjN38rS5sucocSjEcBBrgSVx1dmcmquc6cgDkDObU0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mengsungwu@fortunewhite.org; 
Received: from localhost.localdomain (114.42.142.74) by
 SG2PR02MB1407.apcprd02.prod.outlook.com (2a01:111:e400:79ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.17; Thu, 14 Jun
 2018 01:36:04 +0000
From:   Meng-Sung Wu <mengsungwu@fortunewhite.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, mengsungwu@fortunewhite.org
Subject: [PATCH v2] doc: update the order of the syntax `git merge --continue`
Date:   Thu, 14 Jun 2018 09:33:34 +0800
Message-Id: <20180614013334.17145-1-mengsungwu@fortunewhite.org>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <xmqq36xq7dix.fsf@gitster-ct.c.googlers.com>
References: <xmqq36xq7dix.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.42.142.74]
X-ClientProxiedBy: HK0PR03CA0072.apcprd03.prod.outlook.com
 (2603:1096:203:52::36) To SG2PR02MB1407.apcprd02.prod.outlook.com
 (2a01:111:e400:79ce::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 411b8f08-7eb9-43fb-2caa-08d5d19731ab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB1407;
X-Microsoft-Exchange-Diagnostics: 1;SG2PR02MB1407;3:vqKNuYm3OcIQkgUxPrY26znTPhSqrZPoYuj2IGcDN5E6dQgySouvTtCpzwBdbr+JJl0imcCwxsZZnlKYqI8LONRX+cFITWU9M89RdbaVWIdXcfk51mWe5xWPTY16RLhv5P5aE24YvfXxPuKv14rR1legSA8s+DXrfWJFB+05QsjvOlR3bi88epPn/aZFuPZ2gjatSbGEgh598lctZFyky/jDAy/zDXatvfIl2AjQC7ozB/BOeo4PWcvzV28tJZGS;25:EYYcuPUKuAQh7esaxuIIcJqYwBjj42N0qN0plWdYyfGLj63fJCDB37V2qL+zn1CdjEETWjDbe3KOA2hhBksWT20aIuaMHpwyDJ8Zq20HmrHI24ffJNAwpETmk9vXg+zx2Nu/Xi97j273wy+UppEXgCtEB4UG64zC3Hv8gDrop+afVtEnoCl1whz1ROKzG2FMXnIIRsd9tJXN9f894d0ps0E4M7E/SCC6vkAWztHDLWwQfi/3qK+39jB+xLG3XpriQ0bfmCLhlI3Uikeq5vNUCUHRStSpvBaeZge/03rR0YGG0xAmqe22PZX7exWJ0NFAa8Noa8BTDrhHVYpXEXf/CA==;31:MT1lP8dm8lpNOqY6j9IoPLVP8IGNrlE8ZxAVItPUEe6amhvo2BlZCuBOyvpAMoVN4EBZPtl4XkrY3v8NoWOY/4fKdlSgKdtANxxuQ18xHNMW+xKTJ7qgYyIH4dPXE8Z4J2tmJGn/IwRQ2LXhBmb/U7eyognwX8Zr8agf0HaCHcgkBD8I0YuFhIdUIhVVeHjn7yBDBTHKxa7tLCqYwR4m+vTl3v0K8KG6SyFSMbyBEjI=
X-MS-TrafficTypeDiagnostic: SG2PR02MB1407:
X-Microsoft-Antispam-PRVS: <SG2PR02MB1407CC170CFA9AEBA30FFAFFB47D0@SG2PR02MB1407.apcprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:SG2PR02MB1407;BCL:0;PCL:0;RULEID:;SRVR:SG2PR02MB1407;
X-Microsoft-Exchange-Diagnostics: 1;SG2PR02MB1407;4:n679cT3nvBnmaSHWFH1xDpNSac5PgDvSIJOEKoSjcRTtafFlL0wHU+uqGOQpTySr/7ickVPwQb1ZnajkTxqvfo6faNztBxizsxfhZK8uChWoLqfgHF6epEbont1gi894mUokTrfDhn89ZlCrZ7TBNcw8N4UOZUE7QeGlJacOg11Wr2AYWDpUtIzX7F3BkzL47Bv5Xzsryt88Zv49bIK5CUtDbLrw5ocysntxS0bg9y5SsRtNfrF9nP2e6SxoGwsGVzOTmx+j92XfF6gvNAeuIg==
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(39830400003)(346002)(39380400002)(396003)(199004)(189003)(15650500001)(16526019)(2906002)(186003)(59450400001)(16586007)(386003)(6486002)(6506007)(6916009)(52116002)(5660300001)(6666003)(51416003)(76176011)(86362001)(50226002)(316002)(97736004)(478600001)(105586002)(106356001)(8676002)(956004)(81156014)(47776003)(81166006)(305945005)(2616005)(66066001)(486006)(36756003)(1076002)(8656006)(68736007)(53936002)(476003)(107886003)(446003)(6512007)(25786009)(4326008)(8936002)(2361001)(11346002)(2351001)(48376002)(26005)(7736002)(3846002)(50466002)(6116002)(11716003)(46800400004)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB1407;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
Received-SPF: None (protection.outlook.com: fortunewhite.org does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SG2PR02MB1407;23:QUGfyCxLgKzP29coVMuRhdCGrEx0CtKoNmHUBtIZ3?=
 =?us-ascii?Q?cayeLT6m6LId+fYVkxhs8QZHaRpXr1sTmMSqM9YaiuNAl/YdeGER5y3R1mwt?=
 =?us-ascii?Q?PQeXx6XjvApOoJzVMdTB3pcdHQovsNbEEqoUB4wQ1JsZGXeDLt6Md1TyEekM?=
 =?us-ascii?Q?hhsrED9igV+57NRDWlXD5+/MHydxI6DY3vGB85R4TVe1XDmbVBBnrxZ+LOXG?=
 =?us-ascii?Q?5b/UgLOoWCiPREIBMgrO2rIzTTUT8aZxThzL5poYGzuvSd1IkqVHTL7sWZZF?=
 =?us-ascii?Q?Cf8eZq0y0Ue3DqQT+2AJ1C0no+O8U3eRdPk9NRauxp9sbItyH2BXaKz8SjCv?=
 =?us-ascii?Q?g1AmznLTnMqqr/MVgIcaIZPyIH9M0Z0VOMz4Qpyt9o/aXnEy7TX+vNw5lIcs?=
 =?us-ascii?Q?HmcBlLU4opV3uppIxC/qNZVn6dGNgQO8pH9taaCmbBh1a4Mo5v+1M0MtuL6J?=
 =?us-ascii?Q?KLx6rZmkrbVsap2P0cBQIjk5a/s+osOUSUB5UmVGzjYXN3pEoILJisMZ4ZBF?=
 =?us-ascii?Q?9Q/Bftt0k4op/RxUbX8ousPag6DHg+UacrImSFrvdJs/BX/Gdyx+MiFNDvKl?=
 =?us-ascii?Q?XLnLBVZDwGVIV02zfxUO02ecUDLy1Y/CDnQ+SoG8kPKg6UA+QLwfqHkl5a+6?=
 =?us-ascii?Q?Iefnnmxa8Q0neBnvm3MfDewWI+fBH8+JWILYS6VnFJ+E/080Z6nV/+Cp/tg5?=
 =?us-ascii?Q?xAtHukoU4f4xwOkNWtFTz5zC0HVKbeKPbkJ8zTqAh6llBMDzufHEKvrD+pL+?=
 =?us-ascii?Q?T81QeUT0pGsMRAX7zP4hQztAQHD3ZO/Wogr0cC3kUXWwbwmTl0LBk1OvJKW+?=
 =?us-ascii?Q?PCK4wydp2Q2dULF+md/MHtV79tMyPmwlej9hKemIl6fnMvI2ZA1b8Xa2Y7aq?=
 =?us-ascii?Q?W3hZrMvN2cql0kXQ7dWsYsvIKNJ4fAkaSsgQyRffryQO9v1i06bw2eYbhURu?=
 =?us-ascii?Q?1saczZtuW2tBWWIjR67bVlgdryQbEzmvIWJ+tClQUGMQxu+R1hyjrsOUMoh6?=
 =?us-ascii?Q?zGK4HeZyGfXMdVXxp7zJPYjVJTL0b3h9JQsadnveOcbhidYY5F8e5T94NRPD?=
 =?us-ascii?Q?35dkm+kJizP9eX3LD14DlknRnO2KMf0m7j9ALf8GfaU6SS4I2uTxveq0TT14?=
 =?us-ascii?Q?70K01wvv1/AY2sMmUTBHPxTvpSI20EBuWNzNz9lv2DVO4rfyqvzfrGatGDtR?=
 =?us-ascii?Q?2h2nsJXH+ZXFXQKAB1E2bZA8fTqDxv3XcovQeqGaS2qUFmWLcnDcNPoYw1As?=
 =?us-ascii?Q?kz0UzYHYbwyMAZWYPAwAwN3lN3KY/Ic1WBkJnriK1TmxQV0noYaSqy/Eak03?=
 =?us-ascii?Q?M/mwAqsHVgJjrNKEHa1ZUMNeDttrx3A3tLr066tSPnPER9NcqF5GvNaUo5kw?=
 =?us-ascii?Q?9auwZQDeFMiLFxcTQinG251fQMw4QHBras4PGHDGwV4Ukzh47vZUFU0thgxB?=
 =?us-ascii?Q?5w4yAKHRA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9g0o+L/4RCjLF1CnXEbPNa2jXEP+1MKPIETa8SIdZ12CVrdQnxmQxwZO23jkWlMNE+6cag+6aa8KGq84Z5yGzxV7ga3/iOGeI0XZFo+SKm3p5WzMyvE6Wt1hNGaI4v9lsqpM1Z5UWQMkes1dBMeudvtRZZc6+zYTxJOSLHN1snrBgTpA2nW7qTdXG0Z2NOlE
X-Microsoft-Exchange-Diagnostics: 1;SG2PR02MB1407;6:oYCeZ+XXmBslgHUMaSLT77W6t0FJWQY2bh9mJ6zg3hGcKB9LBRkd+3ie5BIu/3wALUjoLkAcPDAHQ38sSNfXZGiW1S2t1z0UUsSM/SfusQ95ss0ignTnZzka/nHNe1ehYQcwtEiKwNXLeo0pYAiznmP+g3TRP+/J54uAlRfza5MbvdIpYzlTRM45EOXvV/zYxS6ha//e+W6m1Ko2iceAhnaF+3vYUFADAaWthUsf5P9CADN1/Zek049o7WkCxKb5zye9TG7UtId2vx8Y2/F/cOqUfaQ79kUsN8omAotzWunQpePs1Y3EiEo55NaDAkcZFr3gEuVz5hxWC9KzAdzSj1oV7DoY2SZdPKJHsFoYV5cOTyVczAaWtSOD2SbnDcpGRO9wDqg47bJ0KuessBh+W+D6wPZwelWpcLSlVnfIagMZwOXZfNLCVC9okdo0wRz6wX4moQ7ykgT0vSmukJzg1w==;5:qC46JR7Qlhbj+6NcA9H5nou20QChdIHd0tniTTgnexT+TwLSYoczCtY+r3awFjyGD5FR1p5SO9w3rOw3lcwxJ0T385MubMyzwUbYG4OBcfLSwZ1clrXz8BxM6q9AMh0GukGA5UON4W0vIcuFhzREzW/9FB4CUmMwa023/SrFqNA=;24:LIyFwZU99Pu2zB0Po8AG7gkXs95Nrk185AscAi8+kn5aagyZTwGCLKGHkSoT2V2dPV+acznFXJtpOcZhThUTYqUEkyNRfTctFXSl2TqROc0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SG2PR02MB1407;7:b8OzEVNTLPSfOad8he9dJKjISyouGkc4NhD2DSR/hn+AOvmMUxEk8WmljCNH0QPRdRiEjxTpmIDB7fJ7lX9vCaM6I8DPipxj4PJFV4P2UDslW+hnZq+3A/SshcQ9ihQvjjh865HOmnO43iKLbFlwLO67/Q6djONpkD69Jv7PsoeXJ4eaeVc2JY9mWtU0+gRogB3CUmnh8U7B0jYtMbBNM37D/N2BlfmSj08uzI01WXjVCO2eKkVXs0uBcnVkr47B
X-OriginatorOrg: fortunewhite.org
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 01:36:04.2548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411b8f08-7eb9-43fb-2caa-08d5d19731ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f8f60d5-9654-45b1-a1d8-998175cd542e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB1407
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The syntax "git merge <message> HEAD <commit>" has been removed. The
order of the syntax should also be updated.

Signed-off-by: Meng-Sung Wu <mengsungwu@fortunewhite.org>
---
 Documentation/git-merge.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index d5dfd8430..6a5c00e2c 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -57,7 +57,7 @@ reconstruct the original (pre-merge) changes. Therefore:
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
-The fourth syntax ("`git merge --continue`") can only be run after the
+The third syntax ("`git merge --continue`") can only be run after the
 merge has resulted in conflicts.
 
 OPTIONS
-- 
2.15.1 (Apple Git-101)

