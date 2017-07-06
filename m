Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F3D202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 12:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdGFMyV (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 08:54:21 -0400
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:56109
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752540AbdGFMyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 08:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adminliveunc.onmicrosoft.com; s=selector1-unc-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jA5SAAZ69aiIkJwKSF0vRVsw8CaSb2xR8q31KvL4kec=;
 b=RXcQW5i1VOqREgv6FwQMmPOIO4M5Wf4OMA5Kk02nZOsQbZiNSrwRMXwUns1Cva2Ga/hInSODKkVQU2pM/nP58u9Jp02GXrifzRLx503IWxcEaGNu2SKX9ncCRcFh0hIC077BKmcV/wrbnRj1todqX2UkXZPAJMMVJMbBPtjHIAI=
Authentication-Results: email.unc.edu; dkim=none (message not signed)
 header.d=none;email.unc.edu; dmarc=none action=none
 header.from=email.unc.edu;
Received: from tarna.oit.unc.edu (152.19.250.103) by
 DM5PR03MB2442.namprd03.prod.outlook.com (10.168.233.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1220.11; Thu, 6 Jul 2017 12:54:17 +0000
To:     git@vger.kernel.org
From:   Todd Lewis <utoddl@email.unc.edu>
Subject: bug report: dates on diff
Message-ID: <b28bc109-b06f-0acf-960b-0b6761b0ee38@email.unc.edu>
Date:   Thu, 6 Jul 2017 08:54:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [152.19.250.103]
X-ClientProxiedBy: DM5PR06CA0050.namprd06.prod.outlook.com (10.168.110.140) To
 DM5PR03MB2442.namprd03.prod.outlook.com (10.168.233.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9416ef4b-5b99-48bb-6475-08d4c46e1cb0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(300000503095)(300135400095)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR03MB2442;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2442;3:mVz3DUW08TJ0SX+HxWevRG9dr3qliiD9iDhkouAeh7gi5BiKLkiep63ft9aKqDaIClmxeMrCifVx/3u8Ie34+x+9VpaamF9QCBk2UjZjQRqNqpcfRlDa3O4hwVOUoS2hJueXgok29RvMULDsRLSYpwtPv6pj8bqwiASVD5EsI5SF3vpA4BoaPPqucgcSnVoZLmE2V0m7S1R9GoEy7kmMsOrI7MQXwQ8GuSPZOVFLrSkBMwabL/NzZzYdHHb0jU4osUVUoeMFdO6lbcZwIc60Gkss7BLRMLp6dYsj6su+kETznSkluUwvtWKOnfD7MlcEoVFMyXtfIJgviYRWzmZmtm4vGvvXEP7WThlp/L50gbWHKFioQtK+LSOI8KOpThQ/nMs1mcIV5byWUICKgQN92J3JzjOo5So3oAUxfX6E4bNnVZBhMjTTe7HuuN5VB+NLV7cy4ELjXZ3NWKe6XRtKiaL7WxZ2gZ5aiWGp8vF4B70UW3kXXuEg32v01ALLbH+mtxHq+uC0mHQSWsDY/BhWtOdWfhs2cYFpDNMM4TKaoOGP3A3ZMvgsxfRdKAm+9wJRwley4h0rigqK25I+3OK4q39VfWQ3YLSBmOZ0l666CRE5NPDV5p4WCS9Pwko6CRdOoK5i6KDi2/TsqhQP7g4eugKydBLSN5FPuQpYSBmcUeJ7aF2kdtPUGQcM/Hs9EQHpO6aYZMNhHu1aktJsSSsG7PZRNYwuz9+Rr999PAo5Pxf6fLx0T3iqEKn7QVkoKbe7
X-MS-TrafficTypeDiagnostic: DM5PR03MB2442:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2442;25:zLU3lzucSdMgc/y0pvBVguRxOegUSuxX/eXXHuiex/UsMPXSBr5bkdeVDf4qn5q160uybSn0Ducpz7mNU3PvhOmsWADggFBarOyCONJ785IsJJrOdRlYrX8ed1S6OBXAARVqAFTwZoLlQ05F4oh4WsKvg2+ZOE0LWE+Ua5gnwa32C5kqZ9Q16RsovYJyR8dlU+GVYXFjrHXSSCSbmnNN0FS7IHNEucygscDeXfRpsT6rm+TZx5VHEWbgj2P7W2zi8pXwl6+3XPfQrEAS6RIcrzGt3o/bfuAAU8yecbI7T8ysA7SqFi/2TARQTC71oH5Lss+4D+/jFqJz/WNfXTIZv4N9fTu1VTRKhyRIiwIsW1japBczzwBlnQaV/ZRAfu/oDlYb+YiWbV2HFeIQwCtonhSCtiK+0OhlJpxp7uTLFbXDmhZRyCGAbAOVG8an8dYGx+XgwnV754OA1ggYdwQZ7Vrp3mRWukkDy4SgwGUJoIwJ7Hru/eVNSeW0Ia8e/4k9SS3rAQxNoZZLiQs4I5/vT1737354KhqZXzf5P8LYcTJgCj4z9YWyS/E+vThguHzGbrRNSspPkCI3OPdaMHx3mMDQRv6UDQ/ysGpkfi2cyYafDPKPBt9NTHIXSsus/tfA2NXwtv/7xNaOBh6LWe2BClM7e8MF5X0zO29qQU4pjh1787KE23mzea5wK5wpl1f5kHSWP7ZfZnlUtEO5olpeeKnY0LEI4SQ2cU1es5PcDWdOpwT/YoJYKQqBrYG4113w+n7OlrCU14Gi57PkwAmusKOVOvca86dfnrqu+LGnaH/dr2q2b8Ik/nSS2/B152iEu1Veza9mFSUKiyDSAo19zut+OhEQqtGLwXeq8gobUHkDUUHTF+hqh55HtIkcymJ9ZiBT1PVc9KYf5/OFFk1U31GWnpDAfgHKSEmiUrmRNRM=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2442;31:B0Lbzyn30UM/378unrfOJM6RQV0kEb9cZcvPhladO6TMntXOpHP2U9Hwpk+mOoEvlqW00gXEaTT3BY/yesnlPTvTqmZFBd+IvGThgZ49/odXLOPAw4at6oFZ44z++ku2YOhyDSzTojV4vWyqD1mCqTporSfrM/9/7xddPo++u2NSiddjZO/Jk8ryxVVqKT9Rsfz4l/co9M7DPstcEb9V5STNvulGxe4C3WEeF4AohK4l5btN+Ya6PorJdVlGdLA9ZtzblLKv0eWr1mM5Br6fwb4DKGBWZ8UYOiGGFGnhbNYqvHk0zBn9eCQi60RjM3hi6XHkxBb3GDYSkZ1u2mQGJ0o3iaVCwKK+NmcnlPtyQLNyVEnVzU2u/S6b1myYakB2VwHKoexUjryTK85/CnowxkteVqvPm7xHA3w5u10HNZf8Z8PYSvba49jfQrD0zsZCsD6eHRR9soIbMD7DS9fVS/t5Qe8uJBv6fBwkEqHj2nqLmJIDA011pgxk5ayAPqzO9Fzr1/nhS29h9sHQ0IDMYalUy7FXhwL3H6mzCsMkTk8cJYr8jQIi1CZsFmYu+On0sv/3IrJydX2TmEb1nbA3YyDkNEDgMmt8Q+l+rvmuiyPtNMqph7PzItRxQ/xp1NNzKR0efSG0ZD0XF6GXCojN9DD+wxgi3R7AXRslG6RA38bF3rUwTslVwvhQ19W+1Iu0
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2442;20:qbylt4t4hYy6KfI3dp6fVWcQHc3aqdWC7OjOPf8cn6fYOm6Vrkg18Tfo+ZvQgFkw94JD3+FalzMHp2WBWdKFoZHXWETuwsMl4sJUOAsb5hrH/PAKsCWt+WKcDeJpT8Khg/tmhgFqDQcrIbuxvHpqyPwyeO5Ht/xeRYzXVfT5mSMfN+JemMOS9NR3lS4sYSFr+NDPHSJPdVZDWm+yzqOn+R8Nfq+8DlmYTSTzLhiz3G4PAQaba65L60D0xPxGGWjXOH7ZebuVtHejyOoQWy+frbytaf2mrG9KcRpyGtaEvHSPxUDULBcDccHE1ATl3nTbxyHEA+qp5SPfvryee2RYv19tTP7M6FBcKxjBs6VOemHrsnXn+WiaT/9ihka+oKYDeMsyEtKHAi6v7i0l5dFg84g5Lpa8xP5nLTv2mJqc4wej3YJkCKC7ZnKmTH2Pcc8irmJQsoh5Qc590NsSZnPbpsbHlPB0qVSdkFn8hT0ovec7PY0BVsE6ABcCz3UPkqSi
X-Microsoft-Antispam-PRVS: <DM5PR03MB2442D8ABA71DFBEB18DDD62FF8D50@DM5PR03MB2442.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(236129657087228)(148574349560750);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6041248)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201702281529075)(201703061421075)(201703061406153)(20161123562025)(20161123560025)(20161123564025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR03MB2442;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR03MB2442;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIyNDQyOzQ6OHZpUm5IOWw1UittbUZnaXdNSkNqUTNBUVJV?=
 =?utf-8?B?SGtKVG5RRytRYzVnS2dFRFBVOFFKcWI4WWZlS0pwUUdwY0dyUFNWMnpNM09q?=
 =?utf-8?B?M21Sd2dsdEYzT2FnRjEvdWM4NUZPaHVVWldXOWtOUEI3RzNQeEE1eW9TTmxt?=
 =?utf-8?B?Wm9JVzQyMHd2ZXhSdFlLNHFOb09nR2tzWmdleGR6T3k1b2ZraHVQblRvVzdu?=
 =?utf-8?B?MkYwSUZKbkw2Z0RGSzNobHRFa1VlOVYzc2paRXNNSGZTVzM1M2pTY2lsZnlC?=
 =?utf-8?B?LzM4V05lTzducDlqU1pZaDE2MjdXNkp0UDE4MUZ0a2xVR2dPZFBjU1ZoOHRp?=
 =?utf-8?B?ZXlDeXV3SmprRGJsUFVmc2R1Z3dxOUd1T2JncFMrK0cyZ2s5QmJ2TmV1b1JK?=
 =?utf-8?B?b2g4WXo0L2FDWkZhRW0relJ5clk0bU1NSERETVg3bkdQYXVXNEh1MENjMjVF?=
 =?utf-8?B?SmxWa2ZIcjFpSmNPNEcxbXVlUk1YUFNZTjY0R1h6dzhEUW9tSDkyQjlaR3lh?=
 =?utf-8?B?Smw5ZUROUjN0WEtTZitpdXRkTTY3VnhDQlpMOGQyMVhxVE5yQlpKYVdjZXlU?=
 =?utf-8?B?Z3FhY0x5ckQ2cmdoSlc1YWhvMDFub2dwQllkQ1ZnR2FXYVkraXZ5dUtZRkoz?=
 =?utf-8?B?YTZWU0xNMHZkUDRXUGtTYm9IWHJ2TkhUcTZTL2wvV3d0c1pZQXZxV1l1VDlU?=
 =?utf-8?B?VzlkV1BHbFU3QzhwM0w3MVZjdzBIazFodUo3V3ByRTB1YUgxZFJMem90Z1E0?=
 =?utf-8?B?Z2JEeGwreDZXbDljamR2Um5ETW9UaEpzVk1GTkgyRkpJYm5tMUFvblNRaXor?=
 =?utf-8?B?d0RQbmFJdHBnQlNscGl2bHdtVlpiODVQdmdRV0M1UFlia1dHNnU1ZWJzdlN3?=
 =?utf-8?B?VmExU3VWOVZpNjZpUHNibXN4dDExL3FwYWZRcEhxdGJpWnJGMU52cUpyL0Y3?=
 =?utf-8?B?aXQyTy9Ubm5vdmRGRmJXbXE2UXdtQ0gzblV4OXhYU2FDQjl0UnBtRU9Vd2lF?=
 =?utf-8?B?QW8wYkM4VHFOMDh3L3dpNmlzYnVqdHFseTVCZ3NIQS9iNThZRGgwMjQwd1BE?=
 =?utf-8?B?R081Mkh2RnlRUkdMQXZQcEJHMGxmNjRuYlc1bXBscmd0ZFhQdGpERjZUVFQ3?=
 =?utf-8?B?K013QjhVb0R5dStNdm9RUVUvdEd2UzZPTkg5NncyTzdyYTBWVG4wTmNKTnNs?=
 =?utf-8?B?K1ZrVG13dlBuWk1RazhpNENhRER0cTh2MTlReVV6VmkzaVY0NStPTkxyMzdz?=
 =?utf-8?B?TmlyNjN0WllYZkhaaFAvMzVmUzdpeW40d1FOZGtDOFlFVVZoTTZPUy9Qc05F?=
 =?utf-8?B?ZzlHV21vT2NCa20rNW5Ya3JOaElLZkZJd202NUNWYzY3MGEwUFRjYkllWDNV?=
 =?utf-8?B?NXlJNWthRGhybmswaTB4MnNTbmNiRTFGSkRIQVB1TzgzWW9XZnZManpoL3hv?=
 =?utf-8?B?MHpuVHBWeFhSNWVWalFrVi9Kb1pLOUZYZkw4RXVzakFmM0VZNEZXK25aYjFq?=
 =?utf-8?B?N2xSTGdMdnI0ejVrbjFJbCsycWJucTUxdTJmMzg2d1R1bzZkU1FSWkQrNXor?=
 =?utf-8?B?ODVhTHg4RzZQRk1vbVB1TzJTKytucE1tUStRYmpySERoM1hmMEpzQkY0RXBV?=
 =?utf-8?B?Y3UxM1M3MHNrZ21HVnkvZWdTbWtjdjBVWVVrc2xhM1kzNlRZTWJPQVNLSDRF?=
 =?utf-8?Q?aUqfF185FKip44/KU=3D?=
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39850400002)(39400400002)(39860400002)(39840400002)(39450400003)(377424004)(52164004)(65956001)(65806001)(110136004)(47776003)(7736002)(230700001)(4001350100001)(25786009)(478600001)(83506001)(2361001)(966005)(8676002)(6116002)(305945005)(53936002)(50986999)(31686004)(54356999)(23676002)(42186005)(3846002)(88552002)(81166006)(33646002)(66066001)(6486002)(6666003)(6512007)(6306002)(38730400002)(2351001)(5660300001)(65826007)(189998001)(31696002)(6506006)(75432002)(575784001)(50466002)(6916009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2442;H:tarna.oit.unc.edu;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIyNDQyOzIzOnk2aEhNdTdBWnE0a1FpZHZMK1JSWE1IRmxK?=
 =?utf-8?B?L25JUENYVkYyR2cxTEdkOWlyL005UmViUnRTSE41bUZML3FvR0dhbUNxSEs1?=
 =?utf-8?B?ci9xRGNsM0VtaU1Fa2lGNERoZ29oL0Q3SnhFcGI2MWMyUEt1R0RzSFp0NW9x?=
 =?utf-8?B?SkQycUplSHZHWS84c0VjUGpoWU02aFlJWGlvdDdCdkJzMXBaN1NLUHBjZldI?=
 =?utf-8?B?dEpVbmFGRkdsRHVpL3RxRGtJc3didlZ0d005S3VjQzZIN21CZktEV05PeW1E?=
 =?utf-8?B?cndRbDBCdHZRcElNSEV6aHlhcWZ5TkgxV3JSdEE1YmFwSDBuUUdoN3EvaEhZ?=
 =?utf-8?B?b1R1cXArWU8yamM2MytXWlhKajZZRllLUnlnaHBYdWRKR05FcEZCcmxkWUIv?=
 =?utf-8?B?czBNbU10b2o0eStKaU01L29sRmxrYi9SYzdTYmlLRDczSEVlK1Q4T1FFcnNJ?=
 =?utf-8?B?T2Y4RFpQcnZNaGMyZm1kR3RSWE5qc0RqeTN0d3pNREFSWHNWNm15WnFrMFFp?=
 =?utf-8?B?YVp3U2lvbVJUZ0ZublVHa1o0VHJhMEdma3E1Sk8yTnREcU1oQXZBb04vVDkv?=
 =?utf-8?B?eWkyT2NISGxkZ2piKy9aRU4rU204ekxiTVE1b1JZbTlPVGhHWWZ6M0Izd24y?=
 =?utf-8?B?SGZ5QVpKenhhZTJzN0ErNktjY0JHZXZMbU1VVEY4UDczSjFPOWR0Vlhtai9Y?=
 =?utf-8?B?SXcxZ2ZPVkc2N2dHdjB5bWhzWmM3VHk4TENzZ09jVG9iL2s5Wi9oaEdValpx?=
 =?utf-8?B?YUxaMC93UWdvZnZIR2xQTEM3N01IQytCZk4yUW53U1A0bU94ZUZIUmRoQU9F?=
 =?utf-8?B?ZDg5a0hrRUV0OGR4UzV3K3ZoMDdjejNHWGZHaDRkaHJSMVNYL1ltSC82S3B1?=
 =?utf-8?B?UDA3dHJmVzV1d0UyY3J4ekhHTXhwd1FUZ2xwY0JyRWFKVzBmeW5BV2NKdkg2?=
 =?utf-8?B?UVV4RzdNR2YwTFFVU0c4N2tXWkdJdCtkc1h5ZXVkeUovK0VsLzc1UWQ2NnVa?=
 =?utf-8?B?ck9QZ0VhOWZxS2xlSDZxZHp2dGY2U0xPZFhsYXorL09HazV5QThBRVgzMFJz?=
 =?utf-8?B?WE1zZEJrWWhjVWNDVkZyS3R4R2xSZU5VS3NrekZTN0ZhT0lPek5CZi85Mi9h?=
 =?utf-8?B?TWR1dm9OK01xQkl6dU5MS05UTVRRMGlHNDU2cjNsL2ZFeFpoYmtUMlVYTlpI?=
 =?utf-8?B?RG9iZlRsbjN6dlgyQUZidkZVQWpRcXc5Sk8xMDVleUpZVTNZZnEwRjE5Sk4v?=
 =?utf-8?B?LzZtSkVoQ01jbG9zSFFBVkN6dUJsanEvenQzOTNiUmR4ZFp6WDhjSVdFa0xD?=
 =?utf-8?B?ajYzSEU3dzRoclIwbDVibTgvMGxjSVNWamxtMnV5SkE5Sm9zQlZJdCtzRmtn?=
 =?utf-8?B?ZEdRQ1VSRXFGQ0lhZjd6Z3FwQ1JHaGFnVU0wSm1mdjR6RXZwcXhxL05YSTQ0?=
 =?utf-8?B?cWtpbGNhbTRLZlJzTTRJRDRhYWREYXluWEM5WkNHamNwMGlBbkZiUXRsTFM1?=
 =?utf-8?B?K2lOYlU3RVZITEptRE9SRUdHMk8vMERpWG5YTHZHM2s0K1ZjOVVkQXpFZVpH?=
 =?utf-8?B?ZnJheG4rTzhhbzNYT2RBU1FXL0VOSG5RS21Wc3pUU2ZuRHV3SjMzMFNlYjNn?=
 =?utf-8?B?YnVQN0N1YjVnNzlyOUlaV1hQanFNOFF2RDBoZHRiMjVVZk4zZ1g5S1lFK0px?=
 =?utf-8?B?ZnNNV1FHekhTZXVqaStsUUlISWYwcmxzU3EyS1FrSVRpTG9SQW5HcXlnZXVT?=
 =?utf-8?B?OGRnekxjS0paTE44STdWZz09?=
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIyNDQyOzY6NjVYRDBkZERFN2dJQm5TSGhrakVqUnUzaTYv?=
 =?utf-8?B?NmNwR0kvRnpFTW85L0pmU3diQnhLSU4yU00weTJvSFdvRVJZdWw0U3hPZ0Iw?=
 =?utf-8?B?YWtOWm8xeEFJd0o4T1Q4aUludEJFRXBlSkVWZkxLcXd4TzQwRmN6ek0zc3lw?=
 =?utf-8?B?Z21qT0lqekdsQ0pqdWxKNmNxVDhYS0VBYUlONG56WE9CbUNtVk9nY240aXZQ?=
 =?utf-8?B?eHMrY1FJaUtwS044SUdOQjNNM2NHVUlmSmh5QTNkRUprUEZVVlZtS213Wlli?=
 =?utf-8?B?ZEdGaGtoUDJPNWUzcjI1VTdQQTBiWDVkdFNscW5kVUtScW1vby8wUEh5Uk1U?=
 =?utf-8?B?YWpRb0o4a2dhYldaYWxFOWdhRVQrSEtxT0hwL2w4NDc4eTFpaHRxQmtjcHZo?=
 =?utf-8?B?b2xhNVZPNStIUE5QYktwNDY5c3pkbnBFVlRWSVBRR0h2V1RzTmtTSkpQZU5F?=
 =?utf-8?B?ajlYWnA4cWhST2dUOXpRMG54UFZlUktnQ3hzL052VFlXallYcnNuQ21yS2F5?=
 =?utf-8?B?MkMyMFI2c1hMdXJkY1FKQW4zampzQyt2M3ArdVh1TnhlQVAzSVB4V1NVbUVk?=
 =?utf-8?B?emNlUU16S1Fxa24xZSs0YzV6ZlpUMVNrUmdjaHdVVkRNUlFSZ2h5WVZmV0pz?=
 =?utf-8?B?ajZ4cWYyalo4dDlJNWVIMHlmYW1QanlyK0M5Q0dBMVo3MTRhV1pmN2RscUtH?=
 =?utf-8?B?YUJVSlhMRm9SY1BReFpZMmgwSzZXMGJwbHZmNlVJUndSWTI2cEZ2SExKMUx5?=
 =?utf-8?B?WVhURmRUVjJKMnVzRSsrR1RWdndtNFlEcE5FbzdiN0x3NWFEUFBmTW1pbkJU?=
 =?utf-8?B?VmdjZDA0cEhrV01FMU5DcUxNRjRTNUxFZ0laNG5vRUUvUXRTeTA2QW9pZG4x?=
 =?utf-8?B?R2dIYjRWVXhiaHpUOFc3SWN6dU1iYnMrV0VtYkJsaENHcVp5TW9OQzBqV2t1?=
 =?utf-8?B?TjlIbHJvK2NNWmJ5N0NEaHNmYVA5ODhhNW5qVXZIZlJPb1psK2dNM1JieEN5?=
 =?utf-8?B?NWxXSFd6WEpPRkxzTENlQWNkL2o1WWt6RkpVeE1qYVViN3dSS0xjR25DRUwv?=
 =?utf-8?B?RjY4UTYxZUFNald1dDZQTGtEeFBlcXVoN2VJWkhYQWRnNkt1cEsrNzBBcU9C?=
 =?utf-8?B?UFRZS1hERVY0OW1MNVRWSmorbFN2blJmaHp4Z1JqUG90RjhCdDUzU3BZQjNt?=
 =?utf-8?B?Slo0bldURmZVS3p2eUJiVm1RWURSWHJGRkFBQzErTTYralhvTk54YWNvOEQ4?=
 =?utf-8?B?Ukt4dzF4YnFXZlh4N0Nac3FrUERpSVhBdVRCQkczcndaZGhEM01aRHdMc0lq?=
 =?utf-8?Q?kyrPvJ20mFNSBsGbqSmLXtTGKMYNHS8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2442;5:0Vg0+SYAMxJ8Qbkf6YZGVe1tQcSaIgVRzjSi19DpLdpWaU4Ur17SVoJsCPyCttQ+5qaextQpQmRAUgNWAl4+hWiweU8iJfC+bvEyuCifOLXJfKmtRPqxt2n6dGUwS+uqz2VztXupna/GFz4FZrV9dS1AL7RyCfJhUzBVFukKd096YqeytW3CSec6wTU1kmiSwrrcuRJscKuHBzykwyEzeHsynK2dZqudmR4ez+phA8RS4WgrJqdKitHryyD7oyUUUmkHrQPE2pw9jBa8B0E7bAYti6GvEDNEchNfgfDHRdqRldb2YVJsY7fqbMY5xsRKDk4e/F6EDOVd+kYlIcjlFw0LVYp2ejebSWdOZ7+oSMSM1bMxD1QrEeiv6tlRLZ10l2CjOsv34hc9ZsMNMFZT21Ybdokwe2auVXYBycKBaDX++DBEs9BmpTqEtL4iWtwEVLQwwLMAdKQrdust2JLGmm40LpVK+v/mn9+GROEpUEY+3XtQa6JTSGWRfmwvIiec;24:PLueJF1wRaYuYszs2Pqrf9VBxKTE7rO3hWsoSvw7QvYMst7JhDPOtDTCNRlupfnjtFrojBxwyfBUMixR3Z65Cjlsttyd4SzYy2mnZP1GE3w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2442;7:RwpycQQAS7DNRJllw5EZn9H36MJk3uA+RzqlODGE7xqGTvUZTakw+CJMLRMDURG1jlM7qyd1k7bw5ca1erQ4HYAkTeenuTBxwcs/rVV0oHFYqIlnDmmssfqf3MQ22xGp4R9Z/9Ys/edeksNk6QM28bnCEQ4sbMWhqPL1IEwwnnZbCRMezZUg/mNOXHJ/ena4Kni0P6E93ul0HRKgBaMyVWbSEyJ+O/oon4l8aIaQjzi2xSvQSiUN48lxtgfeESV4wr43zQEHQtmnIsHVpfPjyxo8TJMRKwbqD4IkkImUmvA1ZPTg3gYC4/HDUPmKG8W+/hAL5DCcyKzqEkChy0/BB7H7fHYDYnTYmhyVx1cMPHAmAFqrdXky92elRM3EM9UG4mPDF+XX9a9twNdJDcVvp7FXWdjeP65Nf7762h5HjFmxGvmW6LR1q5ssm4Vl42l3ZIsi79aAKiz8YvvHroLExqetmQ0Oe3YhyuX9TLVQ7dvymtfdybB+4NEq1MJB9zOVp90bOKTzrWE9v0SGuPk8OfbXVpqXPGss/RgqpLSpIK5g5UfedyPx4AAqjeZdPy8QEj5vZTJdU9oPb4a9/H6UHMvcstFt+ryo0650Np/HN9nfzstSaI7DUzyIOI7pEKUS4loVwjb+q506FBPwZPnjS8qLAd2Okx6HrQzkMpadkD/8RPMRCiP4CUL9rIS+DfWAePcVcOxuv47puj1I02s1U7IJ2l6SEnZVQTmoT6zP8bIdEv1PPtKzL9e73oN5OVMGqNYGLkaP3kXRWFmK/eo6FrR2lw7vfW3ks+4tXqVIXCQ=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2442;20:GO8Ld44E9tnkR9qZnMPi6upe2WaC8S+04ZHyPPJbRbPJNZR5Eght18P6c1FUUumT18O3E6QO+htroKndYK+K8C3VMWfHiFKjUrPKbN0Iz2Ol+gZ9DzYX1SEHrb/X3xjG2D48/S6vR8bJ/PqNwYyzCHWg3TZp2y11cqb8rKuEKBI=
X-OriginatorOrg: email.unc.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2017 12:54:17.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2442
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've run into what I think is a bug wrt date handling in "git diff". I have some
historical data with which I'm attempting to populate a new git repo with
back-dated commits. That appears to work. But referencing those commits by date
with "git diff" does not. (I have no idea if the problem is limited to "git
diff"; that's just where I've been banging my head.)

I'm using git version 2.9.4.

Below is a recreation of the problem from scratch using made up data. Note that
the "git log" output shows the commits with the correct dates, but referencing
"master@{any-date-before-git-init}" throws a "Warning: Log for 'master' only
goes back to ..." and it erroneously selects the first commit (for 2010 in the
example below, instead of the requested 2012 commit).

Here's the terminal session demonstrating the problem:

[utoddl@tarna tmp]$ mkdir gitbug

[utoddl@tarna tmp]$ cd gitbug

[utoddl@tarna gitbug]$ git init
Initialized empty Git repository in /tmp/gitbug/.git/

[utoddl@tarna gitbug]$ for year in 2010 2011 2012 2013 2014 ; do
> echo "Charter for year $year." > charter_01-01-$year.txt
> touch -d"$year-01-01" charter_01-01-$year.txt
> done

[utoddl@tarna gitbug]$ ls -al
total 20
drwxrwxr-x.  3 utoddl utoddl 160 Jul  6 08:14 .
drwxrwxrwt. 19 root   root   420 Jul  6 08:12 ..
-rw-rw-r--.  1 utoddl utoddl  23 Jan  1  2010 charter_01-01-2010.txt
-rw-rw-r--.  1 utoddl utoddl  23 Jan  1  2011 charter_01-01-2011.txt
-rw-rw-r--.  1 utoddl utoddl  23 Jan  1  2012 charter_01-01-2012.txt
-rw-rw-r--.  1 utoddl utoddl  23 Jan  1  2013 charter_01-01-2013.txt
-rw-rw-r--.  1 utoddl utoddl  23 Jan  1  2014 charter_01-01-2014.txt
drwxrwxr-x.  7 utoddl utoddl 200 Jul  6 08:12 .git

[utoddl@tarna gitbug]$ for year in 2010 2011 2012 2013 2014 ; do
> cp -p charter_01-01-$year.txt charter.txt
> git add charter.txt
> git commit --date="01-01-$year" -m "Committing charter for $year." charter.txt
> done
[master (root-commit) f5dc22c] Committing charter for 2010.
 Date: Fri Jan 1 07:19:45 2010 -0500
 1 file changed, 1 insertion(+)
 create mode 100644 charter.txt
cp: overwrite 'charter.txt'? y
[master dec8944] Committing charter for 2011.
 Date: Sat Jan 1 07:19:47 2011 -0500
 1 file changed, 1 insertion(+), 1 deletion(-)
cp: overwrite 'charter.txt'? y
[master cab72e0] Committing charter for 2012.
 Date: Sun Jan 1 07:19:48 2012 -0500
 1 file changed, 1 insertion(+), 1 deletion(-)
cp: overwrite 'charter.txt'? y
[master a0cbf74] Committing charter for 2013.
 Date: Tue Jan 1 07:19:49 2013 -0500
 1 file changed, 1 insertion(+), 1 deletion(-)
cp: overwrite 'charter.txt'? y
[master a75164c] Committing charter for 2014.
 Date: Wed Jan 1 07:19:53 2014 -0500
 1 file changed, 1 insertion(+), 1 deletion(-)

[utoddl@tarna gitbug]$ git log
commit a75164cdf56b5f7b10e7575ee4aa4f653656e456
Author: Todd Lewis <utoddl@email.unc.edu>
Date:   Wed Jan 1 07:19:53 2014 -0500

    Committing charter for 2014.

commit a0cbf74320f5b2309f697a48a8026328a998d787
Author: Todd Lewis <utoddl@email.unc.edu>
Date:   Tue Jan 1 07:19:49 2013 -0500

    Committing charter for 2013.

commit cab72e0902cb4130de49c5d898ef4cc2daf1e2d1
Author: Todd Lewis <utoddl@email.unc.edu>
Date:   Sun Jan 1 07:19:48 2012 -0500

    Committing charter for 2012.

commit dec8944f3c411f5f667cdfefee0609d38298489f
Author: Todd Lewis <utoddl@email.unc.edu>
Date:   Sat Jan 1 07:19:47 2011 -0500

    Committing charter for 2011.

commit f5dc22c636dd66a51e74dc01935a4879bd4946d6
Author: Todd Lewis <utoddl@email.unc.edu>
Date:   Fri Jan 1 07:19:45 2010 -0500

    Committing charter for 2010.

[utoddl@tarna gitbug]$ git diff master@{01-01-2012} charter.txt
warning: Log for 'master' only goes back to Thu, 6 Jul 2017 08:19:45 -0400.
diff --git a/charter.txt b/charter.txt
index a18dbc9..29fedf9 100644
--- a/charter.txt
+++ b/charter.txt
@@ -1 +1 @@
-Charter for year 2010.
+Charter for year 2014.
[utoddl@tarna gitbug]$

-- 
   +--------------------------------------------------------------+
  / Todd_Lewis@unc.edu  919-445-0091  http://www.unc.edu/~utoddl /
 /      A man's home is his castle, in a manor of speaking.     /
+--------------------------------------------------------------+
