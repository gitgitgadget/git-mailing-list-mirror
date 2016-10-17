Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2029A1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 21:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033311AbcJQVSl (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 17:18:41 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:28275
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032716AbcJQVSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 17:18:39 -0400
X-Greylist: delayed 889 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Oct 2016 17:18:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zebra.onmicrosoft.com;
 s=selector1-zebra-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VwglGgpxQBVDe24fHyhEo0f43OCNtefbMoDFWlP14Z8=;
 b=iOf2o7MM3rn4xnJFrFJ6gBDifGFRCrgMcIuL6t37Oz9fPtTAW7hwr4HjZj7lyuPu11mo/4TY1mX4+FDltkCJoBKeC7pJPyyrjCTDAI3sMD19CEzYhpobt1g+86KLPB7hm6TZ4Ea2wYHl0MjqI9wNJn1bq0wNBhopfKjfbXBc1zo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=CNP637@zebra.com; 
Received: from [10.186.5.55] (140.101.111.1) by
 BL2PR03MB515.namprd03.prod.outlook.com (10.141.94.23) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.669.12; Mon, 17 Oct 2016 21:03:46 +0000
To:     git@vger.kernel.org
From:   K Richard Pixley <cnp637@zebra.com>
Subject: Problems with "git svn clone"
Message-ID: <500ef24a-55f9-1b38-52bb-17347ebaabcd@zebra.com>
Date:   Mon, 17 Oct 2016 14:03:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [140.101.111.1]
X-ClientProxiedBy: BN6PR06CA0023.namprd06.prod.outlook.com (10.175.123.161) To
 BL2PR03MB515.namprd03.prod.outlook.com (10.141.94.23)
X-MS-Office365-Filtering-Correlation-Id: d6d5cd24-b858-44ac-abc7-08d3f6d115fa
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB515;2:6wtJWANaRrNve6MKp7NeSczyiVOolUFN+2HdmmEeleyu9nbyJ5ETYzrh/G61eRDPUNuLwTloyimYuH21vdTe5W6+yivKosdqj6ihNjQFTtMwB9Ie0SiugwTu14svy8HbeZSmx+itngD/x/BYBJMBnmW/zOOW11yT2CAazJCReATfdALvtxIsdAq1uIRxzHdHLyrtpRdR4Fl9otNirjFcxA==;3:PHCxSSbqvCWttYbZrpIO+bO611EMZWQ/2e+4pKndtiIGRKYnd9cldtxIRj076qmRcs23RSYQErj45PChbA1ziPIJYLTxWUe8osaTNDBH8T5GPUvYmhlD1jIJglysi1F1B3enrf/a7xwEGfuLb/uHnw==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB515;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB515;25:11S+vlap//LhHs2jsWAPEqPl7QNL+UJwIr4CaNO1ZdDuignTbWC3rHSFzdisH4rn+af8KbB3gGgSpNI8EVq48ObG3ronTvB8kgyxBDbdxYpH6B//sKCuDRvbx7Gb0QGAR5x9te/pVB0kWD7AXXTuvcuAPJF0pz9EHfLWg3h6/WktiMoxfiElKz6XESM5T9pSBzNuv7ecY5D1E7f9nUIDyjNkFmoL8MWBJZSIYh/aC9+HJfeMus8kmUESmPmro9+dlseZrBm7Sj7bfO9kuKsXqHkTB4U1C2iyHY87s0FGh0rvnCPBFyXW847iQX0IgQjnhXsIQdovaaEMufZARivntVXdAmrYMHq7gwrZ0cdCzwq2OjXjsxhJurIqFmSpf/wqc1aWNcipTAeUa5fLtI0FA0JaZKxBwNfva27aRVUnsf3pPMHj4jhfg7TqS2SQyO+PJY4ZV3PnczjC90poo2j6+xGEfHBjfen4TJlXeoUvMAGzUlZEPfJe72+JDxf0AXMC3R6STqS1rYU9CACn2UYUwSCWSv/UCrY3ZHYDoLWH6e4S+x7Ghi0/tX09j4SEwQ2u+wD8Nab7YGRYUw/CJA7FOyrr26/WOd/aS8ctjxaji2s82KVsPNmvc70I7lMkyyW0+35bNilg8rpg0vu13TfNf252Mi/aOa2m0QsYDHOQKCMDOQyTXMmRDllhm1P1cZaZgS7tat3yMlZTis3VE8QPAyfcMyLOlOlDwQ/0kKZQ+sYdprknLUajwEXV2z8T6NahipNYoT+qELpw1Y2Lwmpc6w==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB515;31:OSqjJ2vd+HUarmlraP8P2Ujiyu26SAJ7i47qOHsvIhZ5HJWl1CrgD9jPJYIDvMVRd2N99VBHNOh5Sqk84Xl/ZZXwCeDrAviJu5CRvvb4DHj8H9VVI20mjituBjR4RCEe0cWdqZHIG8JyE6e8rlLycrE640AipnFyxJVx42payZLcGRwuqdFuOwypKN9OsomOmWlkzgI/m67GCetR7vgoQP9EiuYNzWZbPXBrXS0WcJNyr58Vvz0fEN7ZtBMYdstJvW1oWX1XFWSAwp6gGvrIsA==;20:Wfhcj7FQo/CObwdCBaHeYSorNDbSEg19LW18K2YhFCIDEpbE8MywWR5otaSVvCepSBht1g8aH+Mazdj9+F5PPbesYDGq7C2HfmA5Nc4hUEh6NMo35Q28TFuBxAmcJf4P03dUW6Fnee/5+FTlrrXcFwEse+/TxsZ/umSoCO2db49gdMDdOQjHYMP7+56ai2avyRIvqG1j0gEp84G/Q8mvRKR6gQIR7GwNhEZv8lbicGe5qa9bjv0jYYBaZK35Lrfxtua/rgeOfWNhf6fwmIpZaWX4Ag/5a7Nwiom4nyxlOyna3mgqbzses5uIi3dvoojbmPM+N6Jeqi4f81VNuZZTukGpuUy19DtJ+TO0V6y6UVRwiq/lyfziYrV3+Rx4Hzmx8iYHAnZ4Khz01+e2/ac5q62c74j4vdVh/ecIyRwMZn9CLMKGhTnbxbk8F/s5MA9mH4t4X3XwG8ZrtC7BiJNJ7nsTo8XQaSLcqfIMtJD4AkS0VPwL/EeL9ImR0iYUhqRA
X-Microsoft-Antispam-PRVS: <BL2PR03MB5159DC3BA6461D6D7A95C5E94D00@BL2PR03MB515.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026);SRVR:BL2PR03MB515;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB515;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB515;4:4tbDao47OmGyzdKUyKnq3PKo/j64T5oB6FkXUZwO6PAtUIhHBrvBIY7yX9G10lKVcvgLI4BjN7/Wlu2iOUZ8z/0V0ceVG60yru0/j1PeiGxE7JMk3DilIbnyfguw6hpQw20F8PeSlhVZt6EwsoF1xDq9xMcIfz4kYltMwSW4zy6WQAI7M52ADoIhRquMDZ1KkA2+r1SIQgf7FUo91MqxT8E6W7EBBKXfeuUr02FASawvhM7ksKqzECRM8hKJhI7D+lrvN5LcYlYwIXXtfxqm2q6X+QY6FtauFc6AVOWpgWcsyPmUgjavQ7FYnLHwEnUAi4U/lKofGNQig0ZmrRDunelcFwi86d7BMtYlAl2c+0Zc8dBCtsxT8Hp5XMEbNAk77oOs9pedTcQIu3l68r2mubqlQmfVkxPTgjEbrhwqrQo=
X-Forefront-PRVS: 0098BA6C6C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(6049001)(7916002)(199003)(40124003)(189002)(107886002)(36756003)(7846002)(65956001)(65826007)(8676002)(66066001)(586003)(189998001)(81156014)(92566002)(50986999)(101416001)(54356999)(33646002)(50466002)(65806001)(106356001)(2351001)(229853001)(4001350100001)(47776003)(23676002)(3846002)(105586002)(31686004)(68736007)(305945005)(81166006)(6916009)(86362001)(19580395003)(2361001)(5660300001)(6116002)(97736004)(77096005)(8746002)(6666003)(64126003)(42186005)(83506001)(2906002)(450100001)(110136003)(7736002)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB515;H:[10.186.5.55];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: zebra.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1MTU7MjM6Zk85eXFPNzhwamtNQ1dpRXNSNFQrOTEvRXRD?=
 =?utf-8?B?RjJHQ29PSDN5QUhEbUhvU3dFR2tQbGNjRE9OVlg2dnVJd1NlTkE1TGNodUFZ?=
 =?utf-8?B?YTVxV3NZWTRxcXBraEFqU1FGd0w4d2JKVlZMNXhBNkJrQWJ3YkZtM2dxck81?=
 =?utf-8?B?VjVEd1JZTUV6eEgyU1NyekVoTGdXNGJtdll4eUl4Zk1KdUdBMC8xY2RBYjh2?=
 =?utf-8?B?b2pwNGZFV2hYR3F5KzJYSmN6d21YaWlNTzVLdkJOcy9wa2VkcHJXcHJQRGpU?=
 =?utf-8?B?L2JkT2x4NUwyWUFNeC9HT2M0UlV6SXgvTXZTcC9Mam50THJuUXN1SDdjN21n?=
 =?utf-8?B?VndoNEE4YjlhdmJ3MmhhNzhTVFJBbFFuZmpYQ3dNVVozcmhrSnFkcFpla2J4?=
 =?utf-8?B?SzFTK3o2eHNER3oxb25JazlobTVseCtJa0txWlRwVThCZzF0QVQxVTNkWk9u?=
 =?utf-8?B?MTRYY055d2wxSDV6d3Y5MHNTVlNJdEd0aTNmUlhReVJaaUN1K0t1WGxrL0lF?=
 =?utf-8?B?a2VERFpqSlYwVGErZzZmd0JkVURTcERhVW9tMHhOUFRkaEI1MjU4cGxUQ2R1?=
 =?utf-8?B?VlJsb3MvN2lDc1NKVndLdUZXbld3ZldMK0VLUzhFUE50Mld6M2pMSFZyQW1F?=
 =?utf-8?B?VXpuOWoxcEhjbCtmNVFtNkMzM3VWdko3M3I4VWtRdG1qT245TEcrMEdqVUJs?=
 =?utf-8?B?K0MveXdrb0V5WmxyV3pSaW9UWDNKLzlFK1FVdXRUek00QlI3TVZjQWVJTit0?=
 =?utf-8?B?K3pBbXl1R3JEdHB3Z3UzUm5RNlFzS0phanQxdVkyTUsrMmRzQzE2Vkl3TjVO?=
 =?utf-8?B?cmNVdFpUN0ZYZUhPMEZkamNZeFdudC9vTnFvby9DSzRUSDhoZFg1dXRCaGxQ?=
 =?utf-8?B?Y1dHdlNlcGJTWC8yRVVQcmJxTG84dVpxa01rQWozeUVwYm5OR21IbG9WZ09h?=
 =?utf-8?B?cWNra0lNOEpRZkUvRGpPNlVaMmdMZUlub3ByckZ2YVNuQWdqUEc5emdmTEIz?=
 =?utf-8?B?cHA2V1lzb3hXSjkxd3MxTkV0WTRlSHBhNDJBUmJ2bkIwcFRxLzBNRFdKNkJ0?=
 =?utf-8?B?Vm5vU1hlQk1QcmtmNUwvSnBsRWpIYWVHeWppejlkV3A0M3B1TlZQK1ViVS94?=
 =?utf-8?B?MTgwZnhFenBnZ1V6VmpGU0VDaVJKeVdzd0JBVkFyaXRaUHBiaHR2cWhUS1Rm?=
 =?utf-8?B?NjFQMFJYb1cxMzByMG1qUUVGcVlDOVk4Z1VOMDY0akwzTG13LzdIRFVjRGRy?=
 =?utf-8?B?ZEp1VVpNRHhWemQ2Sjh5K0RleGs4ejNxQ3k4WTRZYlFOejZndWJBS0pkMDVY?=
 =?utf-8?B?ZmU3OHc0QWc3NDJJbmdvMG1taUpJQTRvbVk1SlNweWlpM1hZMUFOVHFONUhH?=
 =?utf-8?B?MzNZODE5MGN5VnpseDdzN0tGN1FpMDVYVHhlSVM4VWxDTkNDTDJ2L2JWaFl2?=
 =?utf-8?B?T09ydHhuRGI1QTBhYUxRbFJQUkR3VmlRZnZQYmY1VHM3dXh6R2RkT1NyN0Vw?=
 =?utf-8?B?T1RQWkR4dk93M3pWR20wS1NVZXdLV0VxNFZRQ1MwVDQ0RVp5UC9zZDY5OHBt?=
 =?utf-8?B?ZnN0TzZKWVJOdWVYdnNpeldMYnFGQ1IvUDErL1o5a2Z2a2ovbm5PQlZIWW42?=
 =?utf-8?B?RUtyK0tyMXZNTHB1RVdQbWZzNUpydkl5S3p3S3ViWkl1bksrUU5ZSGlicVhO?=
 =?utf-8?Q?SdoqgpLOntLVNYpsGZSrZgrgqFdO1Okz5HcpCY?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB515;6:xCwUPpbzM1JAmf9Ik34lbrofz1VLHX1Wh8SinejvEpsmAwJDnQjX4rWOLTw8+u1A60mp3PWSWb6g1w8WmbmJhLi34nVaTVTcmhuuWSxsgddkarGA7OUwMsku6IcqRkhuMrjvxBPwherkOCbzIXV7fkWjWZcddrs+8Ll+CDvL4JwxUj/xp1RcsNGw247vu8TRMVculVQXdRI3/gtPW4ocIMcPyyR2CBd1rU9VoKFK8rwa0JPHvt930bmyhpu3Rq7mBIsalUNMZ8YDR5rrMVpgZZTpVRWDr6Y3fLTlEQ1RlPyAXVmWw31E7mnevgjmPeLzJhmraAMm/lYpCUyZI2o9jxMPYM8Bw8TMqGrHiYebGMI=;5:B3tth7dS8jTk8b5SS9rP6yIl/7cf4U2oZ85/GlSRm7F++at8kt7HSuIMRp0XYuzfboU11JL7kzgpy+xAl5fbPWPyyCIKK6pJVDq6d+mUrWq+hsAt/UtP9mXpiHRT+4G1MatAQZrUIL+cfixIbF7/6g==;24:gO8rnG1JowXochD/mhTMbgjc04wjJ/Oq8WW9oQEqnKAYyAYG+bXJmL390rl/3mjBbkRFyI1NBMAQFVC7O9MN5XCFP/Oa1WwC+U9Q/4KMLwQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB515;7:ARV4aLuBGf7EbrcRxSJe0JEe6CHmQVLFbxFL+gM4nOHdghDT2S1qYIPECT+vTPso30t1Ll2bWp38zF6Af+TUxZaCy2ya5/Mxd/PdMM+CTHDF7+XrhcwE75fX1Vb65yaeWZXCPFDhGifBJiRJt4CGfo765EhzqbnDIN99/9ZXMfJf1C49K9jn+RRfUQvcz5xrTPOD+p6Uuo3R/WwsnzSwsmEYgUqwYHZGrIc0nyJz2e+HuFZGnDSpzcN9AHeMC7JI6RKfNwzZm4TG9CPlfd7taQ9Ur9BTfp5gR4RlnaBrw2ORUa+380bGHXlCPR+7ohhm2us9TOL8wMwX+7UggK3L1P3bp/ATOMWJF+gLjO0cKaw=
X-OriginatorOrg: zebra.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2016 21:03:46.2665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB515
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to create a git-svn repository with:

git svn clone --username=3Dpixleyr --stdlayout --branches branches --branch=
es branches2 svn://mumble.com/mumble/mumble

but the command dies about 11seconds in with:

         A       src/kernel/ppc/2.4.26-pre5-moto-pq3-2004_06_04-0/drivers/u=
sb/serial/belkin_sa.h

         A       src/kernel/ppc/2.4.26-pre5-moto-pq3-2004_06_04-0/drivers/u=
sb/serial/keyspan_usa28_fw.h

error: git-svn died of signal 11

This seems awfully early and blatant for a core dump.  What can I do to
get this running?

Initially discovered on git-2.7.4, (ubuntu-16.04), but also reproduced
on freshly built top of tree git-2.10.1.445.g3cdd5d1.

--rich



________________________________
- CONFIDENTIAL-

This email and any files transmitted with it are confidential, and may also=
 be legally privileged. If you are not the intended recipient, you may not =
review, use, copy, or distribute this message. If you receive this email in=
 error, please notify the sender immediately by reply email and then delete=
 this email.
