Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6FC1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeDJPA3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:00:29 -0400
Received: from mail-he1eur01on0082.outbound.protection.outlook.com ([104.47.0.82]:63020
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754043AbeDJPA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.onmicrosoft.com;
 s=selector1-macq-eu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cckRh0WjX8b9ot6FJ9ZwU9fYMpHZoUT5SbRzI1GbGIY=;
 b=GhbSdo+e1jQLEr5uFB22ObYtSAR1zE8IqYE/cD0LPf91V59jK6BqxWYVkopkZzlMsj+hw0EmRlCH0TmBYyiCLlp/ntGwzYU/o4p2bQc2/XjTOvi+wZsjdpLTMz2u+WEYsWshtBAIoGM+9hIvDuE2VosvkNbfzlPu1L3RpXOWp5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Maes@macq.eu; 
Received: from chmalap.suse (109.88.34.230) by
 VI1PR05MB1168.eurprd05.prod.outlook.com (2a01:111:e400:582f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.653.12; Tue, 10
 Apr 2018 15:00:23 +0000
To:     philipp@gortan.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        philipoakley@iee.org
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
Subject: Re: git-gui ignores core.hooksPath
From:   Chris Maes <chris.maes@macq.eu>
Message-ID: <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu>
Date:   Tue, 10 Apr 2018 17:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [109.88.34.230]
X-ClientProxiedBy: DB6PR0501CA0018.eurprd05.prod.outlook.com
 (2603:10a6:4:8f::28) To VI1PR05MB1168.eurprd05.prod.outlook.com
 (2a01:111:e400:582f::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47ede161-b146-46e7-d54c-08d59ef3c98d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB1168;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1168;3:uaDyBrIVbnzdx4MC2Ms7l6W4G/chN07pvwVO9L9H+IZleOvuePnCbXZZCQX1BuKIrXP/LXN99wKgzwylVhOmbW0gBDqxQ9f+sLMZId6YvX4xHyeNEH5rho/NgHRRcnCITTWIUCNYgiJVKQddq0Y1ZioCsZZW6yJCj1uZk+69FYwW7A36MNYdvRowQs3HJfGhulrA/OzfrHaT9NX+WEylR/QuFVSwQgbcpmOc5Qlk/k/pWhSoo57gHonJMmVNje/B;25:33v9V5E7UYtqWxcblrozjW5pOJxGzF8JTPMFuQ0WzWj8GAWUhZPELCL8aDFwBOQDh+WErlE3GfORB6XRKA5IdIedPFspfOaQ+cGoBVOvBzn7hPiYJ6RVQXn5BUTcQSresZ8K6uBy9nd0iwSiCO7BJorHrwie6dsJEBoRTbaRoTUf4u1znbZbT1P7c7wMboxXx0GOIWkff1K3vABO9PJqymiGDTBIeD3uAyB7js+Tft5B11Eyr0RvW/LXrTJExu3IrmWRlu/P1W7RZA93PnlU5064kzso4NKZin3w1h71ysAN38Yxl/XJqpmQoOki5F38nP/EZpVyjvjvb4Tn3uDpoA==;31:6LoN0dpjVfefRvf22uPl0ERExFpWd7y5yzsKQuPIWS0B8zwFBlqWGNVJxt1yK1FfXlBQhpgSM5Td7dsXT+ypRRjr6TFRtoXfUm4G9sii4BR90Y+y/P6tgWlEdZz9S+wFXcG2/rS6nDjBO6nlBen+9AS39IsnMRJ/HaUGVAblJ8RZET1+zsq1ofd/HWcfU2VUDEkd4u7Pm1hMe2W0VmVzLZX43b9bHu9HsndEHXmCEsk=
X-MS-TrafficTypeDiagnostic: VI1PR05MB1168:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1168;20:2CrZJ0bdeuOz2sDK45ibT4GqZssTFUoDBPJagP8Qr9U0kBE2ImLVjpkylQd02Xt4auBB8SCRKwWbOFwAtuhGBVLfWI/VbwuSD0Yks8TeP2irkE12ab0Pc8Ua8PjMhm1TnmIovYejwe+pmTErAXyoma9S7k7bVQHfAt3te3TRDOgCnoTe1bJcun2pdYTJPz0SLQuREF12i5YV29GX6x/V6InDgpm2uwWLChhjIdKYu4pZDPfEDARHYLjMsnhpvTt2idiloQwKfjzeuVdDjmPrEylYhwaLOa9DpOKAcX3qeycwLBbQ3qpgwty/Xu5sUQjfP0QRMpvcugifO0mMmz/2rQ==;4:x1KDkycPViVnh2Po+rPWN1hwvGKi077PhFg/dA0Sj8XGqX8RKZ9L9C9YEf/268MUV5lpCJHBX6EAJ5TFivIl0hPxvq1wjm8RA1RNfCuOHSMvckjh0EOLkj/rczMCQyic9LZ5XMky5vDgby5u/w9FpcPlwWajacEVy/rO/tHlYlt/dcUrm9BTU1nh51H/fE7xVqWah3Ky4qxy0+FK6HPA3o66aVrMPod5TjJALUcqJNF5oNL33dYoyOeArxVlNLRbPu+RfhGz4ZcNPuvWn/V7n5DRXNFI9IUXf10nClc64XlIiJ+vNBG3SUJbznTpuk1u3M3dS7RHD0pKApftJw061YEeuiiZVjoTK0cSTGePo4o=
X-Microsoft-Antispam-PRVS: <VI1PR05MB116871DA98967ACBB16204538DBE0@VI1PR05MB1168.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(15185016700835);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR05MB1168;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1168;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39840400004)(39380400002)(346002)(376002)(396003)(189003)(199004)(16526019)(186003)(3846002)(15974865002)(86362001)(31696002)(21086003)(6116002)(69596002)(97736004)(64126003)(106356001)(31686004)(53936002)(6306002)(68736007)(6246003)(316002)(65806001)(50466002)(47776003)(58126008)(74482002)(6512007)(8666007)(65956001)(66066001)(39060400002)(105586002)(26005)(6486002)(36756003)(229853002)(52116002)(305945005)(446003)(2616005)(956004)(23676004)(76176011)(52146003)(7736002)(966005)(2486003)(478600001)(59450400001)(2361001)(386003)(11346002)(2351001)(476003)(6506007)(486006)(8936002)(72206003)(25786009)(8676002)(81156014)(67846002)(2906002)(2870700001)(6916009)(81166006)(65826007)(5660300001)(4326008)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB1168;H:chmalap.suse;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: macq.eu does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1TUIxMTY4OzIzOitSNmhzalltS0EwRlVUb3diVWlvM0NlVEx5?=
 =?utf-8?B?Wi9hQUxMZEU0VjYrbXJ5VzZBd1hEVnBjS3hueWZnaE9FZXMxbUdoZktCeU9Y?=
 =?utf-8?B?S3NuN0IvRTZ2azMxdW8ra3BPNFRONG1pYnNJeWZsdlNRWGxZQy96dmVEZWhO?=
 =?utf-8?B?TEVQS3dQRlBjV3IxUmZuSTZrQ0NHZ2dpLzhIbW5HblZLeDNxRkl4R2RZbVdr?=
 =?utf-8?B?TDVCUWdYQ1NLeU42anN0V1NaOW5iZlNtZHQvY0FTQW0zeWxWOFdRY0QzVkVR?=
 =?utf-8?B?dGNtZ0NET0ZRMkU1d0sxWTAyb0VZRVYwOTgyWU1Id0dMdGxJN1ZKSTdhT3Fr?=
 =?utf-8?B?cjc1QVhZYmZtbDJOMHduNWFOWUM1VFVqY3ZNa3gyT0haWDMzZCs1NlVrUDFQ?=
 =?utf-8?B?aHNkc1NjWU1XSldVMDdMcHJNa1B5ajNXb09OSVNvNStVRG1SY1ZzMXAvZ1Nh?=
 =?utf-8?B?NXZ6aURkUCtua1RtS1hnRmZlTFZlWXpZWjl1UUpIdFBvcEJMczdmYnQySWFa?=
 =?utf-8?B?aWhDS09GZEtwZWxJeUs2cExFZWVRbWpZWUpkazRLdjZVQWZOQk95TVJRb1Bs?=
 =?utf-8?B?dHk3SEQvUmJkYWUxSGxVU1hyWVFjU01lZ3JnU3hERkJQbVpZRUszaWZzWklj?=
 =?utf-8?B?SzdTRDZUL0NjV2F1aS8ydG1Zd2FzTzU3NlNQRkhKdy9Xc1FwSUZLRFB5VStS?=
 =?utf-8?B?Y3lxbzA2ME5vUmdjWU82WEIxb1hZbkh6VjFGVlgyZFV2SHpKSnVwbmpUdHVq?=
 =?utf-8?B?ZWc3VHlWR0tNTS9ISEFQNElBSlZGQ014N2hMa05uNFk1M3dzbGJUQzI1NGJ4?=
 =?utf-8?B?NHRUOExTRDVtVHA3UzZuQTdvdEkyZlpEdWphV25WU1FBWlYwZGhzeWZMK3Va?=
 =?utf-8?B?MnRacldZeE5vT29UWmpRdXUrMG5Rd2hTUGpBcXlSVGROUmxTUHJNcitQNDdH?=
 =?utf-8?B?TDV6T3FUUmNnTEROSFRsZ085Z0ZQZk53eTF3V1RvTnRYNElzbkFDRVY5NlNy?=
 =?utf-8?B?OWdXTEtIQ2YwenNiWC9iRG5sZ2hXcUhvV3RkWGk1YVdEc05oVFlPbzYza2Zs?=
 =?utf-8?B?VmtCNk4zK2x5Y2wzaFZwM0pHeTB0SzlOU3lzMDJsM21CT1VrZDhleEVyWi93?=
 =?utf-8?B?VzhUNngwaUc4dWtQR3VZT2k3RGJyNTFRZWYyYi9hbWw0TU9WdWxnWStvSnZJ?=
 =?utf-8?B?UzhsdUk3amZ1cDAwVktqcFlRNzN1WHl3eWg0ZzlNZmZVQ0IyMlNGdTNQbXNk?=
 =?utf-8?B?ckZRUTF6Wnh4YlR5Rm9uZHpqclZuY3ZkREhMVkxkbndVbVJvVTlyako1MkRv?=
 =?utf-8?B?Q0N0UTJDQ2xoV0FtclNLZ1I2Rys5dlRjZVR0djJZdHBqcVNJQWJxUWYybkxK?=
 =?utf-8?B?UnoweTN4WGNLRUlIbm1hdmZuVjk3eVhWb3hKUEJvRnplZFBCc3RrMlhNTWJH?=
 =?utf-8?B?aFVTQVdBbkRuR2hqQk5xVkRzR3dTTDJtUkxGRHN4eW83QTVralUxUWs1MDJI?=
 =?utf-8?B?a1VaVFZvWmZzUCtSR21ISm1UYjF0bE1ydzl4Z2dBOEFPR3NJUENQVStrb1By?=
 =?utf-8?B?a2x3Rk1EQzg4YWFGOHR5VmxkNjFZTGF2K0JYV2tQdEZMUXQvdHNENDFadHI2?=
 =?utf-8?B?SzlqSTlSNm12N1hQd1hwRS8zOVhLZ0QxUW55cGh3ZUJLb0drZFU2U25jcGZO?=
 =?utf-8?B?N0Z2VmRmQVYzbVdQaGpxRnpOUFNMWDN6eDRLWEx5cXBvV29JaFNMaHRFRFJx?=
 =?utf-8?B?VE16UVRCeG9CRzVTMGMzMnFXN3p5WkdSUURUT1FLSFoybGpsTVJqenhZWk5P?=
 =?utf-8?B?bUJDTE94cHMrckhFYStoU0ZGTStFSTdoRnRtY2RhS0t3UzhLcjBWaDQ4OFZt?=
 =?utf-8?B?VkdIQ3lDSHB2NnFEb21KMmQrdXIyRjg5ZGNVSDNwbEhta2g1bGFDOWZobE93?=
 =?utf-8?B?TDNZQklaSXdwcG9MOUgvaU41a2lWdXA2NEk5ZklzRWZub25DWWt5NEdrSVdt?=
 =?utf-8?B?TkRBLzh5T3E3Rk5IenVPdzJaU2dpTVlWRHI1TENXeFNJUkxPYjJ3VnFwSE9K?=
 =?utf-8?B?RFhwY3JBa3ZkY1ZSWjhscDVMdWRhK1BFWjBoL2NzU1Qrcmc1cHUwemlTanRs?=
 =?utf-8?B?N3FxaDZKb20vdFJUV2JtRzNuVmE4UXM4WnRRUVRRMTdEWStTdUN3NElLemxy?=
 =?utf-8?B?bUFianJTbFhYazdpeEVjb29COFVPSkRUSlpYaFFKTjZtZXozYytxTEt5bVlk?=
 =?utf-8?Q?iwxC57ylE65f1f7vBh?=
X-Microsoft-Antispam-Message-Info: 8CkyGdws5rhwN3PXK49Ht82yM3rDOxAyWMGs9iOiCEDTwOi8e12IOr3TawVt8KhCyGOSm3RZ8RCiUvlIa4wiPx2iycXqjNqkjnE8/x1orRXkuvL8cXK4YS3d/r1iefVEZYD1eCbngJ6wThvEMgqEI+a+lK4uHiwEOt8RKbvkSiSsun2s4DuFmfAX5PVHGh4v
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1168;6:w+m5bX8E0glk/z23rzC182ZtOlzZNw6XrMNWWDUT1+CcmcZ7vq0sNEFt9Cwqk4SUGrn1c2dkzppi5zY1xv8T9mvl6WrGDWyZtv53bjpfE3H74dgIyElusPvkbkXorkSDsadSUmnHbmMfKzXgPdoCMh/Cojfco6KRtsh1pDhWkZks5jBtI8dikRQINL85E3cbfmDPic7CUn8BvQ02o4uZ6seeYn3BMslT3SvyzdsAdp4Ry6m1Ol8Thg7t7yfD2kSlEMdPlIMQFSgmGaGWLayyqQsB5ZNrxeMykIEqkAoNFhlYmtzysNtB7LEQBifdIdzafZSkm8PnbuQlmAA7XID2VmoagmWHYb9uyN1jix0FzW+FMa/wfgSZ+RcA18KD9H878xunW/0jAuhp7bwdiw7LS6PPDd7GvvcY9EDMjeBq+1vCVMbOdjKpauo648JRShtIbKLxPqehqtQQYuVWm3pOsg==;5:QqAvfL9RxFj50NPibXw5JeDiVP7FT2/QBBiVgX45gaGLVEJo0TsSCM1wt5/U9zuU7OB2wlrfCUtzoU0S1y0BPIpQHvrcG+Bb6trOypitxDbhQo75N06N1IBdG94rzzQp0onEvbcxlRHH0FUuHXabqTxMwHHXWXoJF3eCdeDRfQ4=;24:RjQdflFRO7w5h3Qm8oQBV/wbBEOSI1dRhriRa+/riLs11bafjIeKEW9SArhMy8s+y6fSoCLhYjG6sCC4YFvf4yZLf4ddYEBnlPLnh40pmHc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1168;7:odpzilczwwPzsuaa9SHPv3PB3ENFukD2mot65s8HiViMhlkJ8CUct0SME7v1Djwr5GoSAYfrNC8Lhqns599INcBxbmKIdmRT3jvaaOsctOZUaSs8U1VJBYmxy6w7alHWWXFO0OgBsZwjP0CCqL8nvQcsZ8ObYvPUSoXCiROzWrqJurdPlfr/dkcYiVmsOj+JhMIgLBHDKBGHDz/WqF8wFJiunErE/ukl8M0VwwUWr043///om+gLbfG3N6aG2Eo6
X-OriginatorOrg: macq.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:00:23.3394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ede161-b146-46e7-d54c-08d59ef3c98d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB1168
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

using git 2.16 the same problem is still present. I see that the pull 
request https://github.com/patthoyts/git-gui/pull/12 (along with 15 
other pull requests) are lying around since about one year without any 
sign of life from patthoyts.

Is there any hope from here that anyone will pick up this / these 
changes? Will anyone else be assigned the main responsible for this 
git-gui repository?

Just hoping to revive the discussion here, since the 
https://github.com/patthoyts/git-gui/ repository seems quite dead.

sincerely,

Chris Maes.

-- 
Macq nv
Luchtschipstraat, 2 - 1140 Brussel - België
T +32 (0) 2 610 15 57
chris.maes@macq.eu - www.macq.eu

