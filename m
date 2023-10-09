Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CF7CD610E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377862AbjJIRWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377861AbjJIRWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:22:01 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEA1FD
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNa4gKcgajTn22FaGKZy9eztNXdmk3ORWmTDM36+2f4DBx6Pk5s7etQLo983PRyaMeZOjHVn6FFT7Gfz+BwlicjZ/58dNCcL0NLIk2LTakGI3h8CklmlhfiTa+lUoQYzEci/A4IQnUP51hSLhG2wdhi1kluRUTWzGWz46zuyc4cZMZOi+f567senz3UirZw60hs4fTWOXyaKEJ8BDudmoJrl12r5orwSaWC5Z8UHvI8fkbPzxxDbtgTRPThgqB2Pmiom/D9Z4W2IaxLS6++/+Hq6ParhksR3Hq5gMs+MSue5MXaFsFzFVwcxmBqdO4Ucs8JMKIrJS7ODM3MipqbJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+JeyoCyrlaDe16OgAw6xQV57pyG4f47a9NZgjVvdE8=;
 b=KvBQI3NZ/SfYXAD4Psy/dHscsyxgZmjm4MSLYKwr/4kKygJbjYh41k25kPP71Wj1SOfRdhYPnJSC9stYRS615vG4Awtw6EBOq+lDl/dBYW9HdipLeU/GS1yxMr6GpXZJnAW0j8/X8nzkrWPTsidy0SbDmQq4nLuM8XEwkOnelqBqhkYhYHkzLkoriVVxr1HP3BCMwv32ljO9XLhxKOybAaZT7DfnFUoXQpwnwFN0CC5kaeyC98LWO6zOz+tucpCOUfgiFqWqf+vtAJaptioR+WWNT15ukSFdTUCfdxvgmBiGqFaA1R3a878UfB1VtOoRV3SGY5Gpe7JWPfgFcWZ5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+JeyoCyrlaDe16OgAw6xQV57pyG4f47a9NZgjVvdE8=;
 b=eM8s2Zt/nxSuMlFroriA2TjTJL/o89RIWD0MVY2LTvGB+x91QaO1u9rweHUyCcXJSxSlVZnqr9RJVe+0RIG8scaPgdNauJMM/JDdTimVTvSBrnbxZOxGspPI2n4ONciX8m118BMvTkQz3Z+HuXzNsPLMuDxEVM8i9eDoxVGXjz8=
Received: from SJ1PR21MB3699.namprd21.prod.outlook.com (2603:10b6:a03:451::19)
 by CH2PR21MB1527.namprd21.prod.outlook.com (2603:10b6:610:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.3; Mon, 9 Oct
 2023 17:21:49 +0000
Received: from SJ1PR21MB3699.namprd21.prod.outlook.com
 ([fe80::97cd:a6b9:22e1:4313]) by SJ1PR21MB3699.namprd21.prod.outlook.com
 ([fe80::97cd:a6b9:22e1:4313%3]) with mapi id 15.20.6907.001; Mon, 9 Oct 2023
 17:21:49 +0000
From:   "Rolland Swing (Insight Global LLC)" <v-roswing@microsoft.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Anthony Chuang <anchuang@microsoft.com>
Subject: RE: [EXTERNAL] Re: Microsoft Smart App Control - Git - git-bash.exe
 File Unsigned
Thread-Topic: [EXTERNAL] Re: Microsoft Smart App Control - Git - git-bash.exe
 File Unsigned
Thread-Index: Adn3y8YtJwTQp2GGTUOXCwWr6FHBagAAC6RAAAAUg+AAO5r7gACF6dOw
Date:   Mon, 9 Oct 2023 17:21:49 +0000
Message-ID: <SJ1PR21MB3699885158AABEE6392388ECE3CEA@SJ1PR21MB3699.namprd21.prod.outlook.com>
References: <SJ1PR21MB36990080CCBC0BB415261D82E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
 <SJ1PR21MB3699CA030DE035CA42582AF5E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
 <SJ1PR21MB369933C2C879EAD0D5EAFBD1E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
 <ZSCvaWuPJ1peZ3KF@tapette.crustytoothpaste.net>
In-Reply-To: <ZSCvaWuPJ1peZ3KF@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3699:EE_|CH2PR21MB1527:EE_
x-ms-office365-filtering-correlation-id: 70583b5b-6eae-4032-363f-08dbc8ec38f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ua1oLJdIy9gr9ziWflZ21HjkipGzZwAeQ95UIElJ29eFdTLc7Ht8XNWXhGO1KDc5b8igiUwR9d0hU8uEiGY8P75sD6OdsHkxKotSmAnWpNoQih0e328ewWhQ3e8LCa5IRVwrZGcr7YTS/sqrLpUwegWs+d6BX97B25jsThEaxr9dS1LPZDYk+S33Uo5xdDGTAyn9ypMo9NMhuePD9ZMhRucXcXB6tY7otfH7LuBLviEz+Vj/jBjrxfrcP+r96m9h/bjbXXFU9YXscyHthJvK4G7LqF8eElkpgSf8VeNXojup5YezvLiLtYo3U6cpNzAGkf8izmd6GjEQQSX6evsOGr9tYJsVwCey+ZV+Dbc4zAzXVXHWPgt68s805wJpPU2r/t2ofNAobS88IPnXObotfm/kTcjB1ig/JiSb0IHZNx51wOFM2CW/Wp3aUzxngdfYCGppnmoflFxLmD7AHvtBHuDTJAPJeiBGNdUV85iLLWWIJLy1D+ajfDEXayBr0wvUgWEPgFbVi1eofZM0hfUqgnznDRBRsHDDxurNVeBy7Wkj/CDeHOKcSshqHX/7fgr9UGrWXs38TZjJMXpM8JKAnL86sFL2EJgnvttmFDiIrCtWx96ESIAJLXlh6IiEBBZ8dgsVQ/OoJcOpb5R2rWpy7fU4EZbKvA6f6IFgAh6lObdE0DUvXPw+bSxk/cJlivJorlAh6PKiZdIustMJNYhDYGFFX+ZCyy7/Mj94kp5r7w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3699.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(47530400004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(33656002)(53546011)(107886003)(26005)(8990500004)(9686003)(86362001)(6506007)(7696005)(71200400001)(10290500003)(478600001)(122000001)(82960400001)(52230400001)(83380400001)(82950400001)(38070700005)(38100700002)(55016003)(966005)(64756008)(66446008)(66476007)(54906003)(316002)(6916009)(66946007)(66556008)(76116006)(4326008)(5660300002)(8676002)(8936002)(41300700001)(52536014)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWl6bWY3UUd5Y2IwNnJ2WFI1TGVBZklLdWQrWFZkek5GRVgzZWFSWVZ0UzBw?=
 =?utf-8?B?OGhsSlhJUTliajkzSnVxcUZwN0d6Ky9odGszZHNIME9BVnZ2R2hIOE1xdVF3?=
 =?utf-8?B?NXoreHJzY211ZjduWm92Vk9GZHN1T2JJaGJ3Y3ZuY2FzeDJwcXlsMXBmeUVI?=
 =?utf-8?B?UUQ1MTQ1WnN3Tzg2VnNHN0NuMCtMOWhQVjhmVTMrbWl3YlBVYXZCRElja29h?=
 =?utf-8?B?YThJQ1J3U3lqbjFGRWJiMG9VYStqV0pmZEhBTzFnQ1o5b2NjNXc4ZzhPc3J0?=
 =?utf-8?B?SkdNSUp4Rzd3UHVxcVFOaU5GWlNIVmxDcHRVaEhCSzNyZVArUlJsZlVOU1lr?=
 =?utf-8?B?d1pKUE00Mi9LK1BOL2pXUWRNWjY0KytWSE5INWlzbENDQzlNQ25pSy93em5X?=
 =?utf-8?B?b0o0czlPTy9KUTF2U213N1VNUW0rU053SmVUL0hNeTlhZkdQT2NBOUtBY1JO?=
 =?utf-8?B?WjhhOXZielh0VGdXSCtSc0FnR1dnVUMwdnl6MWhkUXppWCt4dDdZaTZ0b2JP?=
 =?utf-8?B?MlBDcHpUSHFvYjZFOXBublpZOUplK1c5bDE2cFczcjRRNXhDcUZ2OFo3VHRS?=
 =?utf-8?B?YjNNVUFCajBYcERLakh1ZCtOdTVGNlRFYmVSR1FCaXZaa1k4SUpwZjJwd1cz?=
 =?utf-8?B?bzBMUjh5ZkFvamV5WmhlRlRpUjhOYlJMcUpjYzBFN0MwRDNBWkwrZ2hZcitk?=
 =?utf-8?B?ZlREWnlMeHd3elh3dW5mMitHNFlYR3hjYnVpTFFRaGZHZmFSTEQzdWJGdlJN?=
 =?utf-8?B?Sy9YL2RqUjlrT3FuUk9yNHlCQWtMZEQvL09hZThZbjJIc2ZjWlpOTjhXdEZ1?=
 =?utf-8?B?Uy80aC9HYWZXaWFDUXgwaEtEQStxMlVDR3AxQ0xIbmV5YzdnWmpXVkk2Ryt2?=
 =?utf-8?B?bFFWMWJFQzJKc1A1dHo0bW0vNHRjT01IdjJ1MTc4K3lRNjJaS1BZM2hmeFRG?=
 =?utf-8?B?NllheURTRmk2aWlDbUwyTlVPOVJWcXRIVEFNNU02alhkQnVEMjY0d0xJRXZZ?=
 =?utf-8?B?a2FGRVRvbC9tN0ZBY0ZVVXE0TWVpc0RYS0RGYm1tMGM0ZG0xc2wyV3FzYnZp?=
 =?utf-8?B?MHNNQmRuR05xK0hzOUFXcnlOSUpia1drOUhhTHRCZCtPZkovcG5IMnNjaGl3?=
 =?utf-8?B?OW1lTC9VWUhERkZwU3FsbVc3SXc2eWtaMlQyUnBQOG9RVUNsV0hMdlJLQU1u?=
 =?utf-8?B?bkM4RG5MM2xuR0Y5MXdiZ0o3R2ZZenV3TitJSEh6eExDS0ErYWJuUmR5MEVx?=
 =?utf-8?B?SDJUQXM5WWFYcXlxaGRPaTZ6MWF0ZWIxaGY4elYxZm9ueFF5RUYxWUw2bEVZ?=
 =?utf-8?B?aStSeDJOQmxlK1Znc29CRjdJaGpUdlc0ZGdxSXJuZFl1cDVDaURNdkUzeFRE?=
 =?utf-8?B?ZVF2NVlpYnJzK2VCVlJvUkJPZzRVTTh2YWpES2hhaEQ3ZWdobjRybGNtUE5W?=
 =?utf-8?B?VkhXTS9WUHYyc0VlZFRkS2FVSmNjZDBRditERFlxUm0vUVVST1MxVEJUc3dr?=
 =?utf-8?B?Tkw1Z2NlV1dNYzk2RlBteGtzOWd2VXNVSXdzOTZ0b0txMVo1eE9tUXVOR0Vt?=
 =?utf-8?B?ME1oNE1jdmx1QldnbkFyTGJtQ1d3MWs1YytDR2s0OFhiUjRYZ0Y3Q0ZJYmlG?=
 =?utf-8?B?SXpxcFczRTdVUldHT09Xdzh0cCt1bjVZUENzNGJpMmNPNWJ4SG16VzFnQldM?=
 =?utf-8?B?ODYvRlQrYktFV0kzMnlKeUVsbVMvc1pxOE1BR25scFgvMjI5YjhMbHBIQmZm?=
 =?utf-8?B?djZrY1lnVTJ6eHIxRlJQdndwRTNnaGQwcHdLYW1GaUVNb2dWMjN6WnhnL2pH?=
 =?utf-8?B?N3gxZEhnZ0drb0xiVGlYUzlnQ0lrREZyZDJIMDhGYy9qbkhNMStQT1ZPMXlU?=
 =?utf-8?B?a1VmMDFKSkNOODNzK3l0NDZYSE42eHlxaWNHN0YxRE1tdGMxRllqTGNVbmZ4?=
 =?utf-8?B?ekFPNjZIV1hkZHVLTWhMWW83a1hEOVBhN1JmQ014K3lBN3lEZHBlVjlMalF1?=
 =?utf-8?B?N0JqdDV5aFM3dkpyTGdKQnNNQW9WOCtBNmp4NGtvelQxMVlvNmhrd21GbWVS?=
 =?utf-8?Q?HWIkgx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3699.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70583b5b-6eae-4032-363f-08dbc8ec38f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 17:21:49.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAdrTVSmqA3oLj74cKf4yX6MegO6jfT1AxaGD0yitDgU6UnR1DRGL1wJuanH34g4odEsImff8m4MPOJ8DnyLuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1527
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIEJyaWFuIC0gSSdsbCByZWFjaCBvdXQgdG8gdGhlbSB2aWEgdGhlaXIgaXNzdWUgdHJh
Y2tlci4NCg0KVGhhbmtzLA0KDQpSb2xsYW5kDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBicmlhbiBtLiBjYXJsc29uIDxzYW5kYWxzQGNydXN0eXRvb3RocGFzdGUubmV0PiAN
ClNlbnQ6IEZyaWRheSwgT2N0b2JlciA2LCAyMDIzIDY6MDggUE0NClRvOiBSb2xsYW5kIFN3aW5n
IChJbnNpZ2h0IEdsb2JhbCBMTEMpIDx2LXJvc3dpbmdAbWljcm9zb2Z0LmNvbT4NCkNjOiBnaXRA
dmdlci5rZXJuZWwub3JnOyBBbnRob255IENodWFuZyA8YW5jaHVhbmdAbWljcm9zb2Z0LmNvbT4N
ClN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IE1pY3Jvc29mdCBTbWFydCBBcHAgQ29udHJvbCAtIEdp
dCAtIGdpdC1iYXNoLmV4ZSBGaWxlIFVuc2lnbmVkDQoNCk9uIDIwMjMtMTAtMDUgYXQgMjA6NDE6
MzksIFJvbGxhbmQgU3dpbmcgKEluc2lnaHQgR2xvYmFsIExMQykgd3JvdGU6DQo+IEhpIEdpdCBU
ZWFtLA0KDQpIZXksDQoNCj4gV2UncmUgcGFydCBvZiB0aGUgTWljcm9zb2Z0IHRlYW0gdGhhdCBv
d25zIFNtYXJ0IEFwcCBDb250cm9sIChodHRwczovL2xlYXJuLm1pY3Jvc29mdC5jb20vZW4tdXMv
d2luZG93cy9hcHBzL2RldmVsb3Avc21hcnQtYXBwLWNvbnRyb2wvb3ZlcnZpZXcpLCB3aGljaCBy
ZXF1aXJlcyBhcHBsaWNhdGlvbnMgdG8gc2lnbiBhbGwgb2YgdGhlaXIgZXhlY3V0YWJsZSBmaWxl
cyAoZXhlLCBkbGwsIG1zaSwgdG1wLCBhbmQgYSBmZXcgb3RoZXIgZmlsZSBmb3JtYXRzKS4NCj4g
wqANCj4gV2UgZm91bmQgZHVyaW5nIGludGVybmFsIHRlc3RpbmcgYW5kL29yIGZyb20gdXNlciBm
ZWVkYmFjayB0aGF0IHlvdXIgYXBwLCBnaXQtYmFzaC5leGUsIGlzIG5vdCBjb3JyZWN0bHkgc2ln
bmVkLiANCj4gDQo+IEJsb2NrIEV2ZW50OsKgwqAgRmlsZU5hbWU6IFxEZXZpY2VcSGFyZGRpc2tW
b2x1bWU3XFByb2dyYW0gDQo+IEZpbGVzXEdpdFxnaXQtYmFzaC5leGUNCj4gwqAgQ2FsbGluZyBQ
cm9jZXNzOiBcRGV2aWNlXEhhcmRkaXNrVm9sdW1lN1xXaW5kb3dzXGV4cGxvcmVyLmV4ZQ0KPiDC
oCBTaGEyNTYgSGFzaDogDQo+IDQyRjJFNjg1Njg2RkI2MzU2QTE5NTcwOUFGOTEyQzdCOUQ0MjQ0
NjZCRDdDNkQ2OTI1OEFBREE1RTgwQUMzQzINCg0KVGhlIEdpdCBwcm9qZWN0IGRvZXNuJ3QgZGlz
dHJpYnV0ZSBhbnkgYmluYXJpZXMgYXQgYWxsLiAgV2UgZGlzdHJpYnV0ZSBvbmx5IHNvdXJjZSBj
b2RlLiAgTWFueSBkaXN0cmlidXRvcnMgY29tcGlsZSB0aGVzZSB0byBwcm9kdWNlIGJpbmFyaWVz
Lg0KDQpUaGUgcHJvamVjdCB5b3UgYXJlIHByb2JhYmx5IHRoaW5raW5nIG9mIGlzIEdpdCBmb3Ig
V2luZG93cywgd2hpY2gsIHdoaWxlIHJlbGF0ZWQsIGlzIGEgc2VwYXJhdGUgcHJvamVjdC4gIFRo
ZXkgZG8gaW5kZWVkIGRpc3RyaWJ1dGUgYmluYXJpZXMsIGFuZCB0aGlzIGxvb2tzIGxpa2UgYSBi
aW5hcnkgdGhhdCdzIHRoZWlycy4gIElmIHlvdSdkIGxpa2UgdG8gY29udGFjdCB0aGVtLCB5b3Ug
Y2FuIHVzZSB0aGVpciBpc3N1ZSB0cmFja2VyDQooaHR0cHM6Ly9naXRodWIuY29tL2dpdC1mb3It
d2luZG93cy9naXQvaXNzdWVzKSB0byBpbnF1aXJlLg0KDQpIb3dldmVyLCBJIHdpbGwgbm90ZSB0
aGF0IGEgY3Vyc29yeSBzZWFyY2ggdGhlcmUgZm91bmQgaHR0cHM6Ly9naXRodWIuY29tL2dpdC1m
b3Itd2luZG93cy9naXQvaXNzdWVzLzc5OCwgd2hlcmUgdGhlIG1haW50YWluZXIgcG9pbnRzIG91
dCB0aGF0IHRoZXJlIGFyZSBvdmVyIDQwMCBleGUgZmlsZXMgYW5kIDI1MCBkbGwgZmlsZXMsIHdo
aWNoIHdvdWxkIG1ha2Ugc2lnbmluZyB0aGVtIGFsbCBleGNlc3NpdmVseSBidXJkZW5zb21lLiAg
SSBleHBlY3QgdGhlIHVwY29taW5nIHJlcXVpcmVtZW50cyBmb3IgSFNNLWJhY2tlZCBrZXlzIGZv
ciBXaW5kb3dzIGNvZGUgc2lnbmluZyBtYXkgbWFrZSB0aGF0IGV2ZW4gc2xvd2VyIGFuZCBtb3Jl
IGJ1cmRlbnNvbWUuICBUaGF0IGJlaW5nIHNhaWQsIHBlcmhhcHMgd2l0aCBhdXRvbWF0aW9uLCB0
aGUgbWFpbnRhaW5lciBtYXkgZmVlbCBkaWZmZXJlbnRseSB0aGFuIHRoZXkgZGlkIGluIDIwMTYs
IHNvIGl0IG1pZ2h0IGJlIHdvcnRoIGFza2luZyBhZ2Fpbi4NCi0tDQpicmlhbiBtLiBjYXJsc29u
IChoZS9oaW0gb3IgdGhleS90aGVtKQ0KVG9yb250bywgT250YXJpbywgQ0ENCg==
