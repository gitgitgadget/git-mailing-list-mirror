Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D5DB202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 17:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdGFRcP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 13:32:15 -0400
Received: from mail-bl2nam02on0063.outbound.protection.outlook.com ([104.47.38.63]:9961
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751654AbdGFRcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 13:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adminliveunc.onmicrosoft.com; s=selector1-unc-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2DtIAYC58ZLhNWfVznuO+EXhW4J21uxoPYOD6axTaKQ=;
 b=bWxbw5rDtn7sT4a+FvG7H8YWfePRHPEune9oZXaK+g+swcgOPCHWE7NhNVx7L9KGXFtFPb/HrTKDlooPOsKBOMB86c1mFzBxWAK1okIcPnEkggC1HgcxF68afT4FLU+HxbBYJtytEki9VHxG1fLlNx2oVMezgLe1WFkg8edCasw=
Authentication-Results: email.unc.edu; dkim=none (message not signed)
 header.d=none;email.unc.edu; dmarc=none action=none
 header.from=email.unc.edu;
Received: from tarna.oit.unc.edu (152.19.250.103) by
 MWHPR03MB2446.namprd03.prod.outlook.com (10.169.200.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1240.13; Thu, 6 Jul 2017 17:32:05 +0000
Subject: Re: bug report: dates on diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <b28bc109-b06f-0acf-960b-0b6761b0ee38@email.unc.edu>
 <xmqqo9sxfscp.fsf@gitster.mtv.corp.google.com>
From:   Todd Lewis <utoddl@email.unc.edu>
Message-ID: <53f97d43-6984-6a46-bde2-a8cf64e7bb9e@email.unc.edu>
Date:   Thu, 6 Jul 2017 13:32:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9sxfscp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [152.19.250.103]
X-ClientProxiedBy: CY4PR14CA0031.namprd14.prod.outlook.com (10.172.162.145) To
 MWHPR03MB2446.namprd03.prod.outlook.com (10.169.200.140)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c4d481-d677-47db-6b09-08d4c494ec0e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(300000503095)(300135400095)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR03MB2446;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2446;3:PgNBdRognyz/5rePNcA5La1WERAFdXyTgVYyalUQJen95Xu0x1jUEyWQDxwAvXmyslpLv4VEVDQ7+In0J5nhR19IffIaqAwUqJULxmQV/Ul8nbfefjeAx4l97nYV0BM7ha8tFMmq8c8+wIPGsUnlBuoW+ZU/xb7jkhMFqbA/hy26bqgI4Rqi4KjwrhL4Htv/oJNy6sMcFbYGquY22frSlUttKhi/fSxNXikkSFgUrHzKvRCg2MMIP5pCwnabOxHnL9kJGm16EvcTRd6sqxPk3l8R+56Y6SygnVYIuRR5XgdHADIpRA2DVI9V/enqhC9zfUUZoUEz8tCkYVPqiQs77s6FEXOwcCmgyaSQrWS3OFjjmVJqJT4Oo+BbLTGowqK5IYaQaN8Zg/v6idpYmq/+LA+UTOvpml+5D4iXmJnd3ckqHQoXiEiHwrSY73Nm4dvKleuvox85XqJGA71fyuX2pM1x9hlqhSoW1otGwwFqIv/2PDh7sYo0kOYH2IKjvTldfbVlOxbUjKi+N/P1fVgiBzYItWHDRuKWD5AjNJVR3jhk+M58Q3PYpKlPkXa4nW5HYc7KX0sYZ94Za+RwPKQn7cJQFa5gK0EcZxpU/mhqIZmnciWVvkHz4hOyp1u2uqTBAXz5v7bDgYSwwo+lG2AsED9YhZ/A9h0eu/ydjucIp7KgmJ3QlwDgDjuzoyR78fN/BpnjMzrMvTgpdjIlshwd7Fy+3nf0BKXNxZvy3v9yzGfWmMubUFU36089AtZViNfq
X-MS-TrafficTypeDiagnostic: MWHPR03MB2446:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2446;25:EiEDvJ/hZpe86wQAhawb4q0V7mYplQHVXYvvTTKKn3gsGr1VvskMnFRNFTf3q4oEbWt9AJM0nmvjuer7kmHWyvANsqjPYvNkBWcGuTvJ3Jg6guRtzyPjsYTTKIaTGQtNO6BXoYWCjblpxALyza9b4eTsveLUclEnpCjL8BOqEGKjGGf2BGN0MJyHZnB8soIgeF7nOi/rBrFtyrMs3yNyEMl4X1XUDq1pr6S6EVO/hJJqdM502BOfuJ18LANqc4Ey4C8LIW46iKqD/FcwVPLHJ6CvdbF5fO2IcEX5xkQUSDoQRZGMNQ+s0WHVNDuugqkLmIuQIeRcJ/jz8N938eFMZGs0NmIsp43IjGPVlt8cbapfOKkIZoLGomnWkAf9Z/18zgqQ05ejN+4zy8SEigKff+ESTUCJo0XLXboZU8GGz5pRMbw1CoR5nqXsEphDqwlJifispVsjzUYzp35UyVOL/R+VnMy2vt0CfQlV8t6benx7H/rq7LQj7lWgRnXgVHXNk/VwZVe5zHKtq8JWE8yIgKq9Nz4rB2OFzFBGbHIKNXioHD1RETZj5cpPhrWAcMzVjrweBTbC+NZGZIUiEk8j9zkqBJems5jCllKjPpgOv2/wXGYUT/7UMSypaOfG+MKwqbtdw/imzPY8TVsf40avHmkrIKtJv2vZMkxTF3C3OhU1IFLNczIT1Ig4nLygKZYLXeDloGV6gAVkbC+w9aTob4ltGbTMw9Wlg6zd3oT5sfAaOZ4N06igM+ikukL8z+oVWJ42FQhCHA0xnZA8oFBOBaislkXh68youn4Ju3IZgoHVyEjted71MgBLnjoLLHO5DjT4+K0caBcXGQ7Ntyb9iQNSpHDeI6SA6sO60ucrQopH2tVIw1L/bdXqj1RkpcdGP5cYw9VYKdWHm++2YTFWdAuEEMlQ0ner4DaIUfcAY40=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2446;31:e5Q174J5BR1RVpref7xeA0kCOOhjpWI57hmZ2aHJKR6YgSdI84DOP3e4oGjqjlAJET0MyuOVQAIV+mqvFIYLuRJW8CE5eljoNlVs26dmEPR4yeQjfZ3j2cs2mxm8bTx7zDAFXZp1z1FYNDU9TtOLmgYnTgkjXjn17JKYl7mDxRTmAqRBj1tDXLnM8TVskFMMH5UCLT79K0vXQw8fYDWuJ4ZMyRRjFAMmgJIr8IOpov95SjKYE0dH/7kqMRAKjwewcb4zhzFuEOmW+zPj+Z48pfNnBRkhd+ALoTBwrdGY/m6iSHNHpisMm/08VphzbeHxLGPe7M1y1PnXLjLh7lLvUykXDHwtdngMkm/t78Op3dxMqZjAl85wSw2TjO2FuOw7CKeFRTEEiHFWQwXpqqrvwHS1RpKRpfBZjLybQnfFbH0PRiAZht319MRPIv1KXja12G6ypZszv/QMaIpk2sNU+erNib/5piO8JYAQdEwgzPVRrEjcNcPU08YFTUabB1YJicEnAG6hvZOUDA+kZ1x4ZA6v9HEZUYoA+AER9KgCkCF+zhZD60KnhYsBsbKYGY3QWZ4nV3GXwgADm6JsqEQKYonMMJ6uUu7vgJJt5014ScPt+qklHMnc0kiOnAlOBxGQqqMY7ubq38EE7QX0fYC7o0XfiEKnrvyvAMwetTua3C1usVa67SYO3WvUf5WMEOYlY29ANMRs5BTmQ/MjYUm0yg==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2446;20:PyBsBhjRgi0AO7wjIGLZjV5bASQLo4xb7IAtzQqWfkpzkN8/BF7M4yeHiwBMPmDulJRW2ToaUpmHYg+qTp7jmoSnYfMhxlALNF8RNS5mveDk1eh5mAIvlqNWjqiJMQgDzPDU835TldxHM0LzztO2ooDli6EJswAWfQJtn7RTMy09TxnULHj960VtYPddp6oJevhuNhEOJ/ML4wEgPSPpW7ZlbbEUsSopfsmjn6O8+dIxasyNTGd99w8NeVY9jYYPXtrL/0NY6euvB6RZFk/fR2EP55rViCmCLBF4ewavUPpWhGkGrk5S1uL+tbqdllL0FEhHwImY9sIESeyQFuSkH+0NIKbnZPz7Aljxf9ztoBLxu+zCUH5jmbETUrXGYc3PE8z6v5h5TfIxFJTvKooK/4Sppp1Wh7jozJ2RhtNm6BO97iHvSZyc3rBEEJTmWW5zYIVJfJexI9KwAGmft+TuQh+YKIoiBvA+8YsvgKDrLjJ5LyqV0yv5DuCZIaljXIh5
X-Microsoft-Antispam-PRVS: <MWHPR03MB2446433DDBDAE5334C90B724F8D50@MWHPR03MB2446.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(236129657087228);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(2017060910050)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201702281529075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR03MB2446;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR03MB2446;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIyNDQ2OzQ6RWd5bGkwL3Npa00xaGJndmVxdVVtOE9OOG5V?=
 =?utf-8?B?cGprMFNXeG0vOFc4aytnZ3krQlB5Ym9WVXlOU0RRNkJjZlZicno3c3dIUWow?=
 =?utf-8?B?VnlnaDJoTVI0K2pVZ2l5UmNxZzliZDZXSy95SXJrWk5lUyt0Q3lSQ0hGazhn?=
 =?utf-8?B?MHIyOGttcXU4RHFMdlJydWhXRDhYZ0FvdHcvU290Z21OVWZLdEs4eXNEOGN4?=
 =?utf-8?B?RnB4VkEwWlVXUnV1S09GZml5SkpKWVEzL3Q2dDZMTC9iNWt4OFc3T2dlWWhS?=
 =?utf-8?B?WGFFUHV6OVhYTkJ4RERGVFhld210eVYvT2lRTzZGTmRVS1FJRFd0ZzRlaGNZ?=
 =?utf-8?B?UUdNTDh6eUJMcTZkV0UyV2plbTkzazZSdGkrS2FVSTRicnRqb2p0TVpMbXFQ?=
 =?utf-8?B?ei9jRmRxSnRJZkxXK0k1UWgybS95Q1dVUGxIcW9wclEraTNqaTF6WWxmd1JQ?=
 =?utf-8?B?eUZlT09hdDdzK1VJMExIN05wSExQT0xpTjhublJhcThWS3dJMEN5WlJydXd5?=
 =?utf-8?B?SG8rVDlWZWhwL0R6aFdvOTJSd1dQNzdadHVmeitaTUswcVQ3ZXl1NEo3UE9h?=
 =?utf-8?B?M0NCZSsyWGRqMENUU2t1S2svSFJmMWdjOGRMN3orYmRIRW5hc1RwT1BUWW5t?=
 =?utf-8?B?SmJuTnNjUlNxTVdzZWxSOXA5cFBVN3N6VmN3em5YaWJVaTkrcUQxcW90N09p?=
 =?utf-8?B?N09FVC9UTElvOURXVjdJQmNDTUhFc3JZTVVtMHBEUVhuY1d6TjZKNW1wT0xW?=
 =?utf-8?B?SDNHU0ZzNVk3TzlmRTdKTFdVQlhaYUdmNnBNZHFDaHhhVzQ0ditESjBvM1dx?=
 =?utf-8?B?MFpkTFo4T2lQOW5FYjl1SERtQUJUUVhvRGp4WVZOVmgvUCtCdnNuYWF4SHgz?=
 =?utf-8?B?WmRFNWhBaWZQeTNCMmlOVHFOb2Jra2pjYlFmUlR6N0wwRksyaXRkSHoydUU0?=
 =?utf-8?B?RGV2NXZkM2tUUkdBRW5acTdLNFVPTFZwZTVyYTNUN3o5VFU4OHlMcHBmY3Z6?=
 =?utf-8?B?NlNXNFMvVXF5enhiR0FROVRwUG9POE96QmZNRmhyeGc5NGE1Qkp6WWVJVTdD?=
 =?utf-8?B?MTVQQlJQRFd4R05WS0RqL25GR0hVRHVyaHNvRjZ5VDJ0UDFWNVlGejIyRUhY?=
 =?utf-8?B?azJqQjBKWEYwMzc2dWNTaGdyYjdBSlNrcVF5MENkZ0dua3JzaS9PcjI4VnlF?=
 =?utf-8?B?aXZFVU5WcjVaZnZ5eDQxU3hKME1wdFNFcnczZHp6MThSS3ZHNkN3NmhqMncy?=
 =?utf-8?B?bzUvSG5KVXhNRXV0a3cwSFJ1ejJ2UDdXRmdhci9vVFVSM1B2T3JvWUsrMThT?=
 =?utf-8?B?YkdseGtBbzlTYmlabDkwekowblNCc1BKRXJsMnVpRmE5Z2luYUpFRklzRTF1?=
 =?utf-8?B?bW1tcU5MOHRleDJBMkFIS2I4OTYxMVpnV1NjNWlYM2J6TGVCS01YWnZTbDVW?=
 =?utf-8?B?L01aR09aWHluQjJucEN4SzIvdnRFNHgvdVQ5VHl2YVVJMzVBbitYVGM0T1NS?=
 =?utf-8?B?TExKUStIeGd5cnhMTDQwTCtyRFBZdURiKzQ1QitGY1ljUnpMdjR4YjFOOFFJ?=
 =?utf-8?B?MFRDbEVyQkx0ZTZEMExNTGFtNVV2emNUVkdpN0dnc2Ywb1Z1SlZVdThMUHly?=
 =?utf-8?B?VnNtNitLRm9JR3o5bWtmcUI1anJ5YjZha0RobDZzVU1LalB6TzZIbGhmdnVW?=
 =?utf-8?Q?F032AfSJeHu9X4OBQ=3D?=
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39860400002)(39400400002)(39450400003)(39410400002)(39850400002)(377424004)(52164004)(43784003)(377454003)(24454002)(478600001)(47776003)(5660300001)(229853002)(88552002)(53546010)(75432002)(4001350100001)(6116002)(81166006)(230700001)(8676002)(2906002)(3846002)(64126003)(2950100002)(6666003)(6486002)(31696002)(50986999)(54356999)(42186005)(50466002)(31686004)(6512007)(189998001)(33646002)(25786009)(6916009)(8656002)(6506006)(53936002)(4326008)(110136004)(83506001)(7736002)(6246003)(38730400002)(66066001)(76176999)(23676002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2446;H:tarna.oit.unc.edu;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIyNDQ2OzIzOlVFb2lIY2JBZGdJL3JSanRMUVZuUmNwQmhZ?=
 =?utf-8?B?bVR0czhFVUNIV0pPYUs5RTR3TkVvZWJKRjFnUlUxSHhWTnY5a1huWHlJRkVD?=
 =?utf-8?B?TU5iekJlTGN4ajRpdTV2K0ZPM2tMUEh0MUMraEF5RVUwalNINU9ZaHNSU3pY?=
 =?utf-8?B?WHA2WGJkN2lsdk5MWGxoOVZPSXFhR2VpSXVjK2k5d0c4R1RSWWg5MlNFK2RG?=
 =?utf-8?B?Vkw3bjk1RFpLaC9rck5GUld4bDdtQmxZbVR5aWJHSzR3Q2hENHFtTWI1eW9i?=
 =?utf-8?B?S0pqcTJCSnl6LzRNWXN5ZUE1M1lzR0NTQUtkQklucnkxYWZFYjNHSU15UTM5?=
 =?utf-8?B?dGc1dHNiamJURUN4dU9jNTdBalljR0YwaFNpU08xRGZKTklacmp1ZXR0ZHRU?=
 =?utf-8?B?QTVhV09TWGdDWnFxb3ZqMUpNbm5kTE01dmFjeHJjS1FyNjdLeURqQmFiRHY0?=
 =?utf-8?B?cnpQbkcxUGtwRTA5TTU2TzBLOXkyZU9rNWhIYTVybVppSmE0RXR6U0wwUmFo?=
 =?utf-8?B?T3hteWZwMkNTMW1TVmdPQ291d01OSk9zemNWTWVmalVMNGEwT1lhdUE4cEVZ?=
 =?utf-8?B?c1ZXVmR2cVIvbDBWa3hCOEFBNWlZY04yVkNJbUtJVkU5eWViY1hOOU4rMHpm?=
 =?utf-8?B?bkxTTE45a3ZqYmtiVTNEdmU4TDBMSFFINU9CbnI1OU91dmoyTGhSYWJXdlRB?=
 =?utf-8?B?UjdrZzNxd2M3VldYOVFFeXl3aWRPNmZuUGdpTS9rdFdiVENpaTMrYWlHZEhv?=
 =?utf-8?B?MkdDRDBNaTFrTlh1RHVrR2xCcTZwRTlIdm41TlM2N3Y5TC91NGQzYXhwckp6?=
 =?utf-8?B?QlpxeXI1UW9za1V3YlAva2pGbWRFRFpkTEs1N3VaWGl2ZndEc21LUkdvQlpW?=
 =?utf-8?B?VkNLRlowaEdJU1JFaHM2eHB6NlQ5MS8xRmZTTm95NUZxWXRkR2oxOU9Vdms0?=
 =?utf-8?B?R2U1NkM5SmZqZE1STEMzN3J2dllFdTZMWEZqTGs1b3p5RCtucmRxVVJVd2hp?=
 =?utf-8?B?K1Frc1Z0ZXJ5K0pDL2lmK1k3bms0Mlppd252aDJyM01JNi80dndOdW0vY2ZM?=
 =?utf-8?B?VWFQcjhRNThZZDJIWVN2TkdPOW5sbWNkdVRnbGl6NXV5d3lqV2djQW9pSFdE?=
 =?utf-8?B?bUFrUG9lQlBkbzZzbGZzWldmTmRpTUJUTHFCUngxdThKWDc3TFp3VWdzWW13?=
 =?utf-8?B?QUV5Um9HUGE2cnFXYTZQOEd1UXdMZ3JuVkx4MkR4QlVCTW1pL2FFY1BZYk1B?=
 =?utf-8?B?ZHp2YVppaUd4T0ZjK0s5L0RuMEdHc1kxSDA2WVZHTmxGQzM2Q0ZBWXZFajc5?=
 =?utf-8?B?Tzl1aGp6cGNhdjhvTVdGaFJHTUNSZW5yZVJKNGZxWjg4bXlZcHVqZ3d1Tmpx?=
 =?utf-8?B?NWFWQWw3RENmcUVDVkxaK3ZGNisxdXAzT1BnM2llYW41RVJpZ2xXTjhMb2Zy?=
 =?utf-8?B?TkphOGZSNVlHbVMzMWF1ZWErWHQrTDlLaXJ3ZVlvUEVDcTVGWU4xNzFhaFVl?=
 =?utf-8?B?My91V01GVjQ5QmNxS2hWdE1NVW13MnZ4S2Y2WkVNQnpLQkppZUVZVnBnMUg4?=
 =?utf-8?B?MDVhZGhCREFpNTVJZ3ZQQlJOQ3N6bTBFY0d5RzQyWWFyMlJZUkZPRlhya1Iz?=
 =?utf-8?B?TFpUTi9JcXVTRE1xTlNpOE8vVHlmMlBIYnc5cmt3YUI5bFJNK3Jueit5M1JV?=
 =?utf-8?B?NUNUUkZCd1ZXbU9UeXl1Y3cwM1dLSk9HOThNVXVUUTdpeUd0L0Nra05qL3Br?=
 =?utf-8?B?SGV3Y3BGUnZuUlFXb1JLVlZRVURmVC9qUmVVWXpJS29Sa1lYUU5PaUpVRDRU?=
 =?utf-8?B?VWVKQWlUcWNlZithVUFkUzh3S24rUXY4S2tJNWloUEdieHc9PQ==?=
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIyNDQ2OzY6QXhad3pqMDF3WUpTN1lzTGN6QVFsdjFmVFFE?=
 =?utf-8?B?djFhdUU5ZE41RUFuK0JTNkM0VWdlVFRFeWN6VEpyZ2REZG9jNnNzWC9TUEtS?=
 =?utf-8?B?MTgvYnRUamU2dkwzazVzTnFrQS8xb2RaRzQxZzQycklYWGVnT0pMTVFPUDN0?=
 =?utf-8?B?L0hqanFSMy9UUWlYZ1Z1dGRvcGcxRkZMc3pqUEJ4NjFDQzhHYjc2VDJtWWdZ?=
 =?utf-8?B?Wk1wN3pVcXk5aE9uVVFtZDIwMk9pcnJoL1M3eFVTV1hyWVVMTTNIdWM4cmFG?=
 =?utf-8?B?aWp0Q3lvcUlxQ2IyR3R0MGlpVHliOHVwZTRVQnhkTHlnWGxCaXhheDBZOVZm?=
 =?utf-8?B?QndrUUhDZ3JnQTFBdm5XN3RSNU45UC8ra2FlTklkYU15Z3F5UnEwL0NnMFFh?=
 =?utf-8?B?YnBuK3p3WGEwc1pTWWJldlJleXdlaFE3ZThvdzQ5OFl2WXI4dkNqbnhSZCtk?=
 =?utf-8?B?VzRaK2ZUTDg3MUNldWZWa3hPSlNVakR0OVowNjRkQ3RyT0xVT08yRFVBZC9y?=
 =?utf-8?B?VnJZNEhDcDBacWx6dnh5Ym5uSEpQMUF5MThmU1JPRHErbmJvYnM4d0dOU0Rw?=
 =?utf-8?B?S0trM1BzM2RvcCs5OHNYU2syb3RGaG5DWTJZQ3FLVDBxVVVMVm1sdkxQTXJB?=
 =?utf-8?B?WXF4V01vM1NpVTk2TkY4b2Z0S2ZxT0MvU2pnQ1JzUlhjV2cyTGZ2VGVtNjVi?=
 =?utf-8?B?dlVzZExycXZXS09jTTdwbWQ4NGVwVkxBSFhQNG80akhIT0cxZHNvT0taVC84?=
 =?utf-8?B?RjAzMlZrVHRMOUhWQ2t1b3NjWDA1NG1KUGVuTmFIOW5QbGk5UEpQamZyN3VT?=
 =?utf-8?B?R3dIQk0zNXhqUitnSWFTbHhaL0Nac0E2RlcwdDFNUUQ2ZjVDR1l6a3ZEeUV1?=
 =?utf-8?B?R0M4Y2RBS0NOcElsNXNNak5Nci8wOXV2U0VSTEdhaXN6bTM0TnBCaDFoT1pv?=
 =?utf-8?B?N0VvV3cycTJOdUp2OGE4dDNtV1ZTL1ZQWS9jbW9hRXgwK1ppbG8xMXQ0QjZm?=
 =?utf-8?B?NFBiRWtYZlVSd25nQnpsNk5nQTZMRWlOUlNYR3hwT1hIUGtNQXJYbFJIVGIz?=
 =?utf-8?B?Y0o2MzRiN0dVK1grMDdDbHVSRlN6MkpKTWpHd2xEU2grTUxWbmhkNUtxZXJq?=
 =?utf-8?B?VCs3MnlRZkNPMG42WE8vdG5Ib0VNRTdxSFhYYlJON05Oc2hMVVRPNkRFR3RJ?=
 =?utf-8?B?TmVNcGdxaUNsOGNtdG1Ic2N1NGFVby9QbDBhZ3NXam52YUFxNzVLQW5aQ1c0?=
 =?utf-8?B?bU1GK212aWN6aERJVGZYNThCQ1ppdkd3TDJzWXFwbUhJVTUxMFlLQ1k2NURC?=
 =?utf-8?Q?W7I+I33m5z1DO9earC22Ss6aYDy/H7Q=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2446;5:89GbR85DMPvdm0Vqgo3YisE1nyyijm4Zi6uKrDIEzLuZo3BlKlTrmhTX/hnFltC+a0bojTezAFmRGLi8twV7RD1QY5BX7BXRJkoz+T1JuuDvRuEipRmSserOMQpEtOj38/R41QyI8jJi2G/pDSC5BMweMm6cFL1kYoFDc6akMY2Rh65NlmVg21tLmsEW3fPFLlWTtXctlS9wDBMHeG76lrG28ihtrkbQmMhl17y5LMJF7sMjtT0KNyAOlKssEpssnVNirjgK6g9UKPWeAkARoLaQQy9u8eoEyBoBMCj0NVnIjqt4FwiHF566sr1qlf1BEz6MoARqI8MWmesSr/pTA0pWHePSOg2QIFRZGuGQZhuDCXZ4F5B/uJP1gPPDtukTCF6lPwwZCjzU50BUAOIPJqMU2rJQwJo+NBooz1/Tu3CTf2TkqwGgnc3c2H+CAXRh6W2D2mMarvPRs9TRoofTtzDNv5eZaH7Kri0uh8bXe8kJj1nBD4Czpm5dVmccyg3v;24:g/IYsvNJL+uUnjUgG1bnAxM9rneA+53Nc4mBMr+IwH2CZx42VklZIwBcTjhOuNkPdpiQtRqSaRveN57pdWnluY3SyymLAAW/8z5WgfzhF/M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2446;7:82HfD90SeRJObtt4v95l/upX+IcdtDTUcx/opvlkPA5sukX4ttLSoxJJMJuQA/RyV204EYBhGgXeq+t+PRV5WJUch3RvCmBMlfGxYO2bjIBnvqb41QMFAiPpdRrlHBDgw1LMBroBd9beIltHza922Id97i7g7IqcuPkGph/jyH/StRNLX8SGxhiEq6/Ih+a5qlaW4jNMEOKDAMcu8QJXpSYFRzcXrzifl2lW3JJl8VQNw+r5TgAP9DyrNux5G+VuuS1uVSo68/G0cPXfZtkuT5ejdvQryovE/aEozrAZANiKn2ibIcddeIpb/a+pchomSkx3ZOkiaT7nAwaF3A+NQPGZf3pSCg4auOeejA0x8eqGr5IlyiV+HKyZ6LlyRxi4wLMSa0FicPClCezFoCM0RsJWKCaFLVZVBPlnyakKfUpJJD/fIcXrYxHYR8v53AadzFcMgMH+4uT+f09TLE26xwy/cUYG/nv7WArbcEhvRi2ccg+WLEgdylRV24qLAMcVWGI2bI4o/B366J8wDncMcvUT9kpy/tvRxfUdCsGD6pWNuLR7YFfLqzZZsNekQLym5Qd62h+zmH6hmuQ8QnhzRe+AHbYNUWt94xPud9f+mQnLKanzPhv0Crqw2iHxhe34Ik6O+vCrLcXTMISZDYBx8d/xzsdEhwtJL002kQQpRQDu1fr35+jlsGKnCpEz8ATxr1PGOwa2YMGPDHUah/FULgyt2jFuTUvepbStl6aN5Of1YjKqHSm67867utp/m+5OlYVdRJDmNeI25UIiRQ1fw+c8J5xqESVbbmESdnXqX1U=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2446;20:wrl07xrurmxE0OvufA9iM2luMls1WShe09Ln+kGu4Nkv9+rwdsstwpMczQ4mL37q0nWMoaES6lIK3J2PtIMwuq/UWBJYANgbDXOP+L6hawF50yYql/cGkqc0QM3dUdjx/XGP8gKT/E3FRC88XxtA2g+zvctMhHXEVHR3aTOnG2M=
X-OriginatorOrg: email.unc.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2017 17:32:05.6435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2446
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/06/2017 12:22 PM, Junio C Hamano wrote:
> If you didn't create this repository back in 2012, then the syntax
> "master@{01-01-2012}" that asks "Back at the beginning of 2012, what
> object did the master branch point at?" does not have a sensible
> answer.  That can be seen in the warning you got from Git.
> 
> Hope this clarifies.

Thanks; it does explain what I saw, and even makes some sense.

However, it does leave me scratching my head about how to accomplish what I set
out to do, or just how to reference commits by their dates as displayed by git
log w/o either changing the system time/date when committing historic data
(which seems like a total no-no), or making multiple passes over "get log" to
determine how to ref. Perhaps there's a way to patch the log to match dates
recorded in relevant objects?

Trying not to sound snide, but, what's the point of "--date=" on commits if you
can't use it later? Granted, things always seem harder until you understand how
the work. Thanks again.
