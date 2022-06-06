Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0456C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 15:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiFFPLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbiFFPLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 11:11:15 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5B7136EA2
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breadfinancial.com;
        s=selectorSC; t=1654528272; i=@breadfinancial.com;
        bh=wm8wOPutfcM53zdriLcIrajZ1OigqU3iAU88D/oLBYQ=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=eUWBR3E2rI5ySRwvdOz/9SIaNugpvXbq9J8sbLrJw0Q/t5NqU5N1tIwz/qjUYP2o5
         MIWvpDGl0WPUOQJ71/1LhOm//CFg0ArtATs2YqksVMnyf+Ex5zms5XecvxkL5ofocL
         mOfP46bjMFyVipiRwNuFypp/pXj+02PMpzFESBKNxsdE9nFhexO+70zyV5rMvas4C9
         W7Lpb2bFu59Uc+942n77mKk3Be/AiBH4wbuCh6kJ4r7/QsGQ2KAwmnw3FZCbR8n4lo
         1RB3O/h8nKBCxVK3zELH/TIis2T3NjdABzPGKg1HLM1URq749UBWDcqlsHGfOEWQ1S
         pQiL57oCiZc8Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRWlGSWpSXmKPExsWSoe+kpSsgOS/
  JYNk9TouuK91MFg29V5gtrh3rZXVg9pjV0MvmcfGSssfnTXIBzFGsmXlJ+RUJrBkrNq9nLvgh
  VPGn9yt7A+MNoS5GLg5GgaXMEl0zGpggnEWsEnNmLmKBcE4ySpxdO48NxGER2MciMf/OE3YQR
  0hgGpPEunc72SCca4wSHT+mAjmcHGwCxhKzF7Sxg9giAr4Sq/ecArOZBfQlPv05wARiCwtIS0
  z5f5IJokZG4nHHfhYI20pi1615rCA2i4CKxNYT7WAzeQUiJda9PgBWIySQL/F85QmwmZwCmhJ
  t8+YzgtiMAmIS30+tYYLYJS5x68l8MFtCQEBiyZ7zzBC2qMTLx/9YIWxpic9th9ggemskPv1f
  BlUvK3FpfjcjhO0r8XvGC6AaDiBbX+LvZQ2IcI7E042PocbISazqfcgCYctLTFv0nh3ClpF4c
  GM7OHwkBC6wSXzYfAhq5jtmiWubYyFsA4l5346wTWDUm4Xk7FlA65iBXlu/Sx8irCgxpfsh+y
  xwSAhKnJz5hGUBI8sqRqukosz0jJLcxMwcXUMDA11DQxNdSzNdEwO9xCrdRL3SYt3y1OISXSO
  9xPJivdTiYr3iytzknBS9vNSSTYzANJRSlKCxg7Gn/6feIUZJDiYlUd4CvnlJQnxJ+SmVGYnF
  GfFFpTmpxYcYZTg4lCR4V4HkBItS01Mr0jJzgCkRJi3BwaMkwntYACjNW1yQmFucmQ6ROsVoz
  3Fl2969zBwPTpwEkvfX3ACS19Yv2McsxJKXn5cqJc67UByoTQCkLaM0D24oLIVfYpSVEuZlZG
  BgEOIpSC3KzSxBlX/FKM7BqCTMuwxkCk9mXgnc7ldAZzEBneXzYA7IWSWJCCmpBqZkh4/rfZa
  pddzpPRpSwZXzxJ/b83R7fZLx013VTwoyJDL6Lu136H957VTSilfre3J0XEPt1bi5dgqfYdm5
  e+fdws7vqQ5XxZ5Kfim3UEoROjbxZMmUXdb8rWyvfpZ2zlsbZLvlKfe9/lPNptd4T9ywMXjoq
  J60lkNwtbA8W32gWWzwF6lWj3bZfQdu2/97wvjupvEshsZb/66ZT10gOKPhf/5lm0u2CWdq5z
  qsv2PGc7dV4I9Gg087m3F4d0+4s8vaeJb9QTEXT2fNzk84Pu/Dfb0s5Uf8AVt04ngdXiyuE3t
  +9wUjp/zJzU2qxz4u2/xm1aRDWY+dmM7dCfJU28zLt/pild3895s35wf7BiixFGckGmoxFxUn
  AgCIk6eoXAQAAA==
X-Env-Sender: Edwin.Dyer@breadfinancial.com
X-Msg-Ref: server-2.tower-642.messagelabs.com!1654528271!115!1
X-Originating-IP: [104.47.66.42]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.7; banners=breadfinancial.com,-,-
X-VirusChecked: Checked
Received: (qmail 19616 invoked from network); 6 Jun 2022 15:11:12 -0000
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) (104.47.66.42)
  by server-2.tower-642.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Jun 2022 15:11:12 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffy9WTSxgwoaS5UtDjN0S+vmwR5ejOtlNuakfPj1LydTh5v+wTWBcjDJd0livVvNVKWsxQ80suGinukErw0JBhDPD4TUKkuTrOnsQUab35J270ZGwle/fP1hcLI3Il9BJ6sjjoPJ3iLwyzizSKNqyyK1qTXH6Tlg0aWuMgF/BSFwtFxsDO7ZUWPO0qKLZaApJNCc/+6OhgxVCG05Klv7KQZ6E+gYlzhEloiru4GYyGgTM12P+pvgTZ8EwXzkkIjAl+Thn6BdK74cZjHS+vgGr/gJV98gyRTZuysVvB1+d6glm78Sv3tbrIv0FuFx52TGvTdavzDp9QGCMu+Q8uUVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ziZbXmGcZXnhlofjO2iMEoqZS+LHv4cgIOWRy1eHVM=;
 b=O5PU4oyu1ltu25s//q87BPPUH0o3ZUtR3792e3jx5xlUrROkZMWpPY6ADAjHEKscDyY9/nt4brtLLLG/rK6NXbYTA5si3x+sFDxQqEyVwlKD2l/koBJZIP74k9Wj/MKJYwUx9V0xBA7b7vbFgl/01ede3qMdkEMtg6jVTUfGi11SoVNI9yk0/KQpk/irhQnki+yAJ9Xb/PbcnX+TIunF19Ao8NVfzu10ctZmFyogs7yLvR2fBgshWapfBVe0bpGb+QAIINufPQxfSUQMf40l1q2/t84KYmK6pYDe6zf84+15l/+8YnmYpReg+8XMTLhoTqAzlmQ/pgGJcgQwMsFoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=breadfinancial.com; dmarc=pass action=none
 header.from=breadfinancial.com; dkim=pass header.d=breadfinancial.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breadfinancial.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ziZbXmGcZXnhlofjO2iMEoqZS+LHv4cgIOWRy1eHVM=;
 b=FpCD0cwTT5ChZ8qr8kcDuu8/DZmfoEjvmikqj7ntRrrl5ql0ckzcxvbtiMXq+EeW3FChmE1yAafNuz8IhnH2rHTXIFQS3CtvQXfa5dZibhvPNSt2Q7pN7+XF8ibEcoTVB4Zm1rM27yMqqKSAGaW45r10YYmn/gUPQrznrNLGh28oE4Dv/5JXweOf51UF33CGe8yY3h9/ytzgzeEgkj7hpByf4sce+z8+HPn2si3Q5xJ5UUdzEoAF0MFnihp5VCPKrjlBr2iPSFhR0DJMgDDXTNeWxqHOXsaj60r6Hu96duqACahSVMpL0Ou1rubo+RU1jLeYtTd3xsRfs30lLM55Vw==
Received: from DM6PR01MB5978.prod.exchangelabs.com (2603:10b6:5:1df::26) by
 BN6PR0101MB3108.prod.exchangelabs.com (2603:10b6:405:2d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 15:11:09 +0000
Received: from DM6PR01MB5978.prod.exchangelabs.com
 ([fe80::2df6:d87f:5187:7fe3]) by DM6PR01MB5978.prod.exchangelabs.com
 ([fe80::2df6:d87f:5187:7fe3%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 15:11:09 +0000
From:   "Dyer, Edwin" <Edwin.Dyer@breadfinancial.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Mark Esler <mark.esler@canonical.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: CVE-2022-24975
Thread-Topic: CVE-2022-24975
Thread-Index: AQHYdfpy6LQNuRXpNUyi8qUUnWy9w607DQVcgAd1meA=
Date:   Mon, 6 Jun 2022 15:11:09 +0000
Message-ID: <DM6PR01MB597862CFD285C837EA61E690F9A29@DM6PR01MB5978.prod.exchangelabs.com>
References: <CAJ=HsVKX-NXePKU1G0UKRcFT5He8AjS_TQEirb3hN3chGFz9TA@mail.gmail.com>
 <xmqq4k14qe9g.fsf@gitster.g>
In-Reply-To: <xmqq4k14qe9g.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79034788-04a6-4ba5-0130-08da47cec971
x-ms-traffictypediagnostic: BN6PR0101MB3108:EE_
x-microsoft-antispam-prvs: <BN6PR0101MB31081EDE80C967DD413C0D4CF9A29@BN6PR0101MB3108.prod.exchangelabs.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +w/2OG6q36Ny74lNwoqJY/vfcJ9GYeulxpVUe2A8QDkpNOp/KkfiBzdbR5PsAhb8QXfsiSqcvrH28UGcmUPc6dSihKD7Pe7FRXKCQtq+Y4esR+S51bGu36IF41Ajo/RR4B4yIZ8SOJbsEZTBItPj0IMEBmHB9bs7LVVjMFXGATKBvzBsHB6ni6jNJX3xSphMdSBNvpb6OGniEslYCC2L//FYaHqgiZ0g+9Iv4obuFsnQRWJKMtA2GySO/NNdm2AG0phyD3sjV2wK66KDSXFXJeaQo4IXPkoF/E7PrNEkxnxpfiYwkHAVyjNm8OZdMqHln0C71nPhUHOVhJOJg/TnTE8d4mjNkK9EHB2j/sCbiG0WgOrw2k2ABfnLGnAFvZjuMEB9nl8IFXUpnpXeP4T3S6BlYEbOpXKc70wC0zdFIC1nVRlnrf2LuXtoQ+oonF9hQtFMixX+9FlmPN4fL+Um3fR8geDf4epk8NpyvJHiz0Gtut6qnXpgVExUgTH7Lu7EL7XFy/yowmKRcaXi9fZkXiyS32j0bzDr2eggmdgsb3c1+ud2kSSMmXreC6P/fdMoO8Mn4iP/U0ArK9Qp9Qaels0DTDGHcr0072Bjs4tAVqRkk+oKahBlNr+CINqhdejc5hLTUlqk61v1+v+uVOujJlarUaQ6mzBNeM3Vtd1RX66CDnKO82jo/CfDTbnA25kGPw3KKTxsYPAgHRrIjf+1iy3WaFSFOu+CJTQXob+zTuB7gC0AqMNOaw9zp5BLHCNgg++zWKOfYQmlYHpPaTMJrdy84YWd70uu7VQWhHVZias=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5978.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(6506007)(83380400001)(76116006)(53546011)(66946007)(66556008)(66446008)(9686003)(38100700002)(122000001)(186003)(508600001)(966005)(26005)(52536014)(38070700005)(55016003)(5660300002)(4326008)(8676002)(110136005)(316002)(2906002)(66476007)(71200400001)(86362001)(33656002)(64756008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGtYdFZNRGIwQkhhSzdDT1IwZG81MXpzRlNMWThyeTljdlBTZW8yTEVWOUQz?=
 =?utf-8?B?Vk41MTR1bXMrc3BDZ2FTTUZGUVJHOU1GVXlGTytGZGp0UDZxOUNCdmpFWUgr?=
 =?utf-8?B?cFRudi92TjMwWG5XUktBKzJRdnNsNk43bG5nTC93QVdhdFQvcUFkc3hFREs4?=
 =?utf-8?B?cU1zYWFxM1RZSUsrRlpJbzlUTjk0SUhtb1c2UWJ6VnVpRGd1YVZ1bkF0MGor?=
 =?utf-8?B?cXVISkg5SFNmakl3ZExLT1V3eDVoSk1Tcm5CM1p0RDR2aU1nYnlMZWxLNHVP?=
 =?utf-8?B?eGg5alRPZmVPbUN4bkZCU2lIeDRHZlB4K3BUQW9iL2pCRXVBclFOK25ja3lI?=
 =?utf-8?B?VkM3bmJjKzBOdzIyUi9JdWRSYkcvTGVYcHFQdnhuQTJhS3M1U1laVitKam9I?=
 =?utf-8?B?TlZXUWFPWDNXbjc4Yms4cFdlM0NDSzNSM2ZPZzFGNlFHQ2VvVWJlVkw5Mm41?=
 =?utf-8?B?QUVNR2tleTUxYVo2YXNIaTN5N3ljcXdPR2NpUHFqeVpnbFdkTis5L1M4aE9X?=
 =?utf-8?B?UjQzRTRuT1FtdWNsdHQ1aGtpS2hSM0VsUmRtQlhWckgwT3lFbUliMFZUT0pG?=
 =?utf-8?B?QWhaN2lDVGhiMFpob0RPanFsRWwzV0UzSGxXK0JqbGYyd1g4V0lkWUVDeGp4?=
 =?utf-8?B?a3QwcHp6UUlZdFk2MXlhWEhSV0NwTlJaUUFTTGtXelFnVVJDRkZpcGwwWS9w?=
 =?utf-8?B?djRUT3RMM05kUitjeXdkeEg4RGsxTU5raUVzTXVLUmJHZ2gxeUpyWEhXakMx?=
 =?utf-8?B?VWRsRHpEdm44b3R4NXU5dEgwWGRRRXd4WnRyNDMvYzloMzZieHo2VmhwcWVE?=
 =?utf-8?B?b3dGRVRpNG4yNkN2aVBESE5PeG8yT1BDdEw2aU9wbUQ1MjJEaytEdGZzNXVZ?=
 =?utf-8?B?dDRBdld3L3dnNytNdXh1T3ZuUUJLdlBBVmJCNjZzS1Z6ckNWaGpEWkluV1RZ?=
 =?utf-8?B?TVdOdnVLWmdnd0hRZEVlQjhuUzN6dzlhUXhKaWprSDRnWUUyclRSMlpYNytW?=
 =?utf-8?B?bDJZSUNIS090dnM5cCtaRGEvdXg4Mkk1T0xpRU5NMk9SSURJR1YyYWVzYzhR?=
 =?utf-8?B?OWpWN0dDR0tKb2haQ1NCNDljWTdIKzRIM1IyUXZML3hIVSttaWlmL2JtTWRo?=
 =?utf-8?B?UzkvQXp0ZnROanZkZy9EM0lOSjU5WGFzOEdlRzJBVTJDZ2xNeU1VMW9kMzZH?=
 =?utf-8?B?cjVOUVN5SUl4WVJqbEIrWlBKTTE5RjRKN2hpRkc4SmJJZE5lK3IwTERMWDFt?=
 =?utf-8?B?ellvZWtVMG5NaUdkL2FVcm9meGxCZWp2MWdVUEtLRmI3cG1abmV6TVhPeEJk?=
 =?utf-8?B?TTVjeW8yODUweW81Z20vRFlhNytKNFA1cnVleHFHMitiY2QzUmdialBkN3FW?=
 =?utf-8?B?VExEaFpyZXRDUXpVZGUrTVJlTEEwOUZZVkRqS2VtSTJnSE9KaitNeHh3dFgr?=
 =?utf-8?B?UmQwMHVnUWc3UFpraFVvV3VRQWUzb1Nnckd1R05Gd0ltMkY1dFlsdVd0MHIx?=
 =?utf-8?B?TGpYajl4cEhtV0NQVHR5a3Q5MEV2UWtyRXVvbWszSGFyQy9hR0hNeFFtSnpO?=
 =?utf-8?B?UW9rNStvZURWNnZFSGEybWxoVGZyTWtqN1o1R1pJQ0w0L21oaVRZd3RUWG5t?=
 =?utf-8?B?emVXUHcxZnpSSVphMVlrSnc0bG4xcHp3SElYQkp5SkROL0VDRVR0MlYrQnhu?=
 =?utf-8?B?VHl6cmtwNjQ3NUtXeEhKYlEvQXRFQzZRaCtYVTYvb2JMbm9qb09pUlZNQjNE?=
 =?utf-8?B?SGNzZGxpeEpZdjRNd2hOVjZETTN3OVM3TzlxWWs4WEhwSHYxVmVpaTBNeDUz?=
 =?utf-8?B?dnVQRmRDUVpzMjZqWlo3MTVTWExmTDBtWXVnc2QrSi92bitkLzJ5SHY2UkQr?=
 =?utf-8?B?VlBtYzRoNDdqaWw5Z0xPMVp0Y3JpdXllTVdCN1JYd2RFK3dzbk9ZdjdYVmp2?=
 =?utf-8?B?blJPWkFpczI5ZExSME5WazROSllXdS90bHBsZzM3ZTdlL290L28yZkxDZ2Uz?=
 =?utf-8?B?MVlhZUVOdFBqV1FXNzRHOWJYdWFJbmJ1cVd1Y0FDTUVucXBGQmEwbGR0MVVY?=
 =?utf-8?B?d2pUSCtmV3J5R0RIeEJKVTJhVENCVk1vZ2dqZDNUYmpKaVZFRzNZRjQ2OE1M?=
 =?utf-8?B?QTVyN2ZIWDJQZEVlOUpzZUpWMnRPS0FBc3dUcmMzSWdnV1NxMm92SHNjdXhG?=
 =?utf-8?B?bG1CeXBKNkhvMWcwZForT2ttZ0tiTzBVZVNzb01XZVR0Y3hCMnNaY3pUd1dk?=
 =?utf-8?B?UW9sbVRKZmJ1YWZrK1VaTjVqNUVENkJUV1p5MGtuSkw5Ny9oWjFkdHdTdFFK?=
 =?utf-8?B?V0RtNXQxNEJ4VHBGbk5UTDFZd1V4c1NPa2gwd09yUGpCRkgwMnZrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: breadfinancial.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5978.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79034788-04a6-4ba5-0130-08da47cec971
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 15:11:09.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a24eae8-33b9-449a-83f5-361634c821ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aexT6Ibg7Id/YggeCRSO/EKjPSGbGkoDd99kAxSI3wjX6t9vhIG4cNiN9PUK6tFGSHoeNJw81y1DBP7/OP3vAgwOq3wp0NdmD2iVVLwOlAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR0101MB3108
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R3JlZXRpbmdzOgoKSWYgaXQgaGVscHMsIFF1YWx5cyBpc24ndCBmbGFnZ2luZyB0aGlzIENWRSBh
cyB3ZSB1c2UgR2l0IGluIHNldmVyYWwgdmVyc2lvbnMuIEkgY2hlY2tlZCBvdXIgbWFpbiBHaXQg
Ym94IGFuZCBuYXJ5IGEgZmxhZyBmb3IgaXQuCgpFZCBEeWVyCkRldk9wcyBFbmdpbmVlcgoKTWFs
dW0gQ29uc2lsaXVtIFF1b2QgTXV0YXJpIE5vbiBQb3Rlc3QKCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tCkZyb206IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4gClNlbnQ6IFdl
ZG5lc2RheSwgSnVuZSAxLCAyMDIyIDU6MTMgUE0KVG86IE1hcmsgRXNsZXIgPG1hcmsuZXNsZXJA
Y2Fub25pY2FsLmNvbT4KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcKU3ViamVjdDogUmU6IENWRS0y
MDIyLTI0OTc1CgpbRVhURVJOQUwgRU1BSUxdIOKAkyBUaGluayBTZWN1cml0eSEKCk1hcmsgRXNs
ZXIgPG1hcmsuZXNsZXJAY2Fub25pY2FsLmNvbT4gd3JpdGVzOgoKPiBIZWxsbywKPgo+IENvdWxk
IHRoZSBnaXQgZGV2ZWxvcGVycyBzdGF0ZSB0aGVpciBwb3NpdGlvbiBvbiBDVkUtMjAyMi0yNDk3
NT8gSXMgaXQgCj4gZGlzcHV0ZWQgb3Igd2lsbCBpdCBiZSBhZGRyZXNzZWQgYnkgdXBzdHJlYW0/
Cj4KPiBBcyBJIHJlYWQgdGhlIGRvY3VtZW50YXRpb24sIC0tbWlycm9yIGlzIHdvcmtpbmcgYXMg
c3RhdGVkIGFuZCBNSVRSRSAKPiBzaG91bGQgcmVtb3ZlIHRoZSBDVkUuCj4KPiBUaGFuayB5b3Us
Cj4gTWFyayBFc2xlcgoKSXQgdG9vayBtZSBhIHdoaWxlIHRvIEdvb2dsZSBmb3IgImdpdGJsZWVk
IiBhcyBJIGdvdCB0b25zIG9mIEdJIGJsZWVkIGJ1dCBubyBHaXRibGVlZCwgc28gYSBxdWljayBj
b25jbHVzaW9uIGlzIHRoZXJlIGlzIG5vIHN1Y2ggY3JlZGlibGUgdGhpbmcgY2FsbGVkIGdpdGJs
ZWVkIDstKQoKSm9rZXMgYXNpZGUgKHllcywgSSBrbm93IGFib3V0IFsqXSkuCgpBcyB5b3Ugc2Fp
ZCwgIkEgcmVwb3NpdG9yeSBjYW4gaGF2ZSBtb3JlIHRoYW4gd2hhdCBicmFuY2ggaGVhZHMgYW5k
IHRhZ3MgY2FuIHJlYWNoLCBhbmQgdGhlIC0tbWlycm9yIG9wdGlvbiBpcyBhIHdheSB0byBjb3B5
IGFsbCB0aGUgdGhpbmdzIHRoYXQgYXJlIHJlYWNoYWJsZSBmcm9tIG90aGVyIHJlZnMuICBJdCBp
cyAxMDAlIHdvcmtpbmcgYXMgaW50ZW5kZWQuIgoKRHVyaW5nIHRoZSBkaXNjdXNzaW9uIGFib3V0
IFsqXSBvbiBnaXQtc2VjdXJpdHlAIG1haWxpbmcgbHNpdCwgZXZlcnlib2R5IHNhaWQgdGhhdCBp
dCBpcyBkdWJpb3VzIHRoYXQgQ1ZFIGlzIHdhcnJhbnRlZC4gIEkgYW0gbm90IHN1cmUgdGhlcmUg
aXMgYW55dGhpbmcgbW9yZSBmb3IgdXMgdG8gZG8uCgoKW1JlZmVyZW5jZV0KCiogaHR0cHM6Ly93
d3dzLm5pZ2h0d2F0Y2hjeWJlcnNlY3VyaXR5LmNvbS8yMDIyLzAyLzExL2dpdGJsZWVkLwoKICB0
aGUgYXV0aG9yIG9mIHdoaWNoIGFza2VkIGdpdC1zZWN1cml0eUAgbGlzdCBhbmQgYWZ0ZXIgZ2V0
dGluZwogIHRoaW5ncyBleHBsYWluZWQsIGFjY2VwdGVkIHRoYXQgdGhpcyBpcyBhICJ3b3JraW5n
IGFzIGludGVuZGVkIgogIGZ1bmN0aW9uYWxpdHkgYW5kIHByb21pc2VkIHRvIGFkanVzdCB0aGUg
YmxvZyBwb3N0IGVudHJ5IG5vdCB0bwogIGltcGx5IHRoYXQgdGhlIGVudGlyZSByZXBvc2l0b3J5
IGNhbiBiZSBjb3BpZWQuICBJIGRvIG5vdCBrbm93IGhvdwogIG11Y2ggY29ycmVjdGlvbiB3YXMg
YWN0dWFsbHkgbWFkZSBzaW5jZSB0aGVuLCB0aG91Z2guCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClRoZSBpbmZv
cm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1l
bnRzIG1heSBiZSBwcml2aWxlZ2VkIGFuZCBjb25maWRlbnRpYWwuIElmIHRoZSByZWFkZXIgb2Yg
dGhpcyBtZXNzYWdlIGlzIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9yIGFuIGFnZW50IHJl
c3BvbnNpYmxlIGZvciBkZWxpdmVyaW5nIGl0IHRvIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlv
dSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IHJldmlldywgZGlzc2VtaW5hdGlvbiwgZGlz
dHJpYnV0aW9uIG9yIGNvcHlpbmcgb2YgdGhpcyBjb21tdW5pY2F0aW9uIGlzIHN0cmljdGx5IHBy
b2hpYml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgY29tbXVuaWNhdGlvbiBpbiBlcnJv
ciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5aW5nIHRvIHRo
aXMgZS1tYWlsIGFuZCBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBmcm9t
IHlvdXIgY29tcHV0ZXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18K

