Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819591F454
	for <e@80x24.org>; Wed,  6 Nov 2019 17:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfKFRYm (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 12:24:42 -0500
Received: from mail-eopbgr720095.outbound.protection.outlook.com ([40.107.72.95]:18082
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728466AbfKFRYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 12:24:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULj2mPASVNXjg+CfPa3OqJhEtuGsX6bq1DVPufWv+hvSYy+lXgSbtWObCWuYEGAsYl6bPdK11GCWaEhhfAzRClBRDRsyNHvv57F/uWGYdo0q/JWpwvOiIRaY+dK50oRY5aqs2rd5lm4rhS5gwZiIAVgOgSpuFfqN/ihfDKjZHrfQFFrNCuv4EH1fmagpTK4tZ/p7eyFL0qx54554mfa1yoj/e58mLUs5xEOsASUl9fjTNJFSfyxKaJngtoM1DfC0flIoUslVZX1zNE3uKsf8Nk/SkaeK3GpUdUplI6OigMrpVOV4W0JOgX+a+s2lf+lg6CFqB6QzJATfIgJ4O+5P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lygShypgpI6GTQYCzC2TT3Xy9gnERJMAQGgxU62/l5o=;
 b=MSCCE7vcgSTWan84Rdgj5TNb5WMJz2RrepvNnm5jJeQOau1ysI9bwuR3VsD4QvCmeZo5fJdr9GKSl99tNRsdUJc325WgH2Wof1BSCY2lVatwJ9Oe4Xlenf9E1lSbxrrGpcqgZncqh53MA/e7xjM6SpxptRYDEUoo1+HziRTwf2lp7RkKW5cOZWwzELMG6LVNlllHjoKt0RNCdWspY31VvRcvO+v/4Cel7KeNYztqpzCZmb5RaVx4vrwiyW8kVnmq1lHdkezX8ymg7lwkp1Np2Fmz2CzkeZzxwHBO1Tov0ctCJzl3GR4YrpRLWteuujQ4WxvI0o583letiXJgYRJ57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lygShypgpI6GTQYCzC2TT3Xy9gnERJMAQGgxU62/l5o=;
 b=glG+v5hgMkhYTqSXXwj6VfiepYxfQbAmZs/a5i1qKTbvNYgWkek9YclPFk2Fc8U3PPNCWdcYJc4R9h5paILPdFrLU1rS+H33WsVjD0rQ5wb1JD/yAQqwTOIzbwE5UcTTeu391XK28pqdrzhE+dLtekNZyMe+JnFDAGrjMJ2vnDM=
Received: from BN6PR21MB0786.namprd21.prod.outlook.com (10.175.132.14) by
 BN6PR21MB0148.namprd21.prod.outlook.com (10.173.199.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.11; Wed, 6 Nov 2019 17:24:39 +0000
Received: from BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e]) by BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e%9]) with mapi id 15.20.2430.011; Wed, 6 Nov 2019
 17:24:39 +0000
From:   Kevin Willford <Kevin.Willford@microsoft.com>
To:     Utsav Shah <utsav@dropbox.com>
CC:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH v2 1/1] unpack-trees: skip stat on fsmonitor-valid files
Thread-Topic: [PATCH v2 1/1] unpack-trees: skip stat on fsmonitor-valid files
Thread-Index: AQHVk+2bruW1MfyQ40WaJtUPjf9M4ad8uw2wgADUkYCAALtA0A==
Date:   Wed, 6 Nov 2019 17:24:39 +0000
Message-ID: <BN6PR21MB0786BC0CD7ABD6B3EEACE74B91790@BN6PR21MB0786.namprd21.prod.outlook.com>
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
 <f76ba554ed25fb9877a223ef6481834f1831c8ca.1572967644.git.gitgitgadget@gmail.com>
 <BN6PR21MB07869D880E1D0111F1A80E42917E0@BN6PR21MB0786.namprd21.prod.outlook.com>
 <CAPYzU3PLVhGWcautao1oenbKbgcOB_99PoyVEcK1hnUk5XErKg@mail.gmail.com>
In-Reply-To: <CAPYzU3PLVhGWcautao1oenbKbgcOB_99PoyVEcK1hnUk5XErKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin.Willford@microsoft.com; 
x-originating-ip: [174.126.253.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1f44972-24e0-46aa-c6fc-08d762de342c
x-ms-traffictypediagnostic: BN6PR21MB0148:
x-microsoft-antispam-prvs: <BN6PR21MB01481C6B5669061994EA2A8A91790@BN6PR21MB0148.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(396003)(39860400002)(199004)(189003)(2906002)(9686003)(11346002)(102836004)(55016002)(476003)(10090500001)(446003)(186003)(4326008)(6246003)(6916009)(305945005)(26005)(74316002)(22452003)(99286004)(54906003)(316002)(7736002)(229853002)(25786009)(6116002)(3846002)(33656002)(14454004)(71190400001)(71200400001)(478600001)(8990500004)(6436002)(14444005)(256004)(10290500003)(7696005)(81156014)(81166006)(6506007)(486006)(76176011)(52536014)(86362001)(64756008)(76116006)(5660300002)(66476007)(66446008)(8676002)(66556008)(66066001)(66946007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0148;H:BN6PR21MB0786.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1dvnZm6jqJqvGnFmaVTT9D8NLiOYUBfdOxg6rOw0eA5JuokYOJzTLAUoB/YT6cDyOdqfTHCWh62NW4NtvB4BLz4+UuwqAvknSt1C34W6LojMrloQXHUgynbWT2109IGgBwD96xigLM59akO789d8SU03bD2OieAjte/1A6cY0UabijKmQvZlA/cdvepQbkpuoHPLGXohJmewNZo0/+XIP/b2xEMKUbL1IF4pceT+wRqPszMTp1AXjYOIfyZ/PTf9NfGe+VRWzBwBGYOkJw4+vBvtbX84OwtFfWZQ4wKHZN5dH9302phHImzUsUdO4UhBW4ifKJDP/mCAxiR9+p/jMdQ8KuCuOZsyWmMSa+FpDgAW8z9k6Q1BLomCW63OyEg2L/N+Pr22LnSMxEv+STNpXuPIqjqW7jB25orsZjNMQauNpVXEKSKcXnXo43dFQIc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f44972-24e0-46aa-c6fc-08d762de342c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 17:24:39.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2koXq1/h+AIslfzBTUgWEOWo22UpYm+1kwDMrDJxDze4acGA7ufdMQoQmgfC1sWmxaxmVxr6pJQqMxKn7/BSNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBVdHNhdiBTaGFoIDx1dHNhdkBkcm9wYm94LmNvbT4NCj4gU2VudDogVHVlc2RheSwg
Tm92ZW1iZXIgNSwgMjAxOSA5OjM2IFBNDQo+IA0KPiBUaGUgb25lIHBhcnQgdGhhdCBJIGRvbid0
IGZ1bGx5IHVuZGVyc3RhbmQgaWYgc2FmZSBpcyBjb3B5aW5nIG92ZXIgdGhlDQo+IG8tPnNyY19p
bmRleC0+ZnNtb25pdG9yX2xhc3RfdXBkYXRlIHRvIHRoZSByZXN1bHQgaW5kZXggaW4NCj4gdW5w
YWNrLXRyZWVzLiBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIGltcGxpY2F0aW9ucyBvZiB0aGF0LCBh
bmQgaWYgdGhhdCdzIHRoZQ0KPiBvbmx5IGZpZWxkIHdvcnRoIGNvcHlpbmcgb3Zlciwgb3IgaWYg
d2Ugc2hvdWxkIGJlIGNvcHlpbmcgb3ZlciBvdGhlciBmaWVsZHMNCj4gbGlrZSB0aGUgYml0bWFw
IGFzIHdlbGwuDQoNClRoZSBkYXRhIGZyb20gdGhlIGJpdG1hcCBoYXMgYWxyZWFkeSBiZWVuIGFw
cGxpZWQgdG8gdGhlIGluZGV4IGVudHJpZXMgYXQNCnRoaXMgcG9pbnQgc28gaXQgaXMgbm8gbG9u
Z2VyIG5lZWRlZCBhZnRlciB0aGF0Lg0KDQpmc21vbml0b3JfbGFzdF91cGRhdGUgaXMgcmVhbGx5
IGp1c3QgYmVpbmcgdXNlZCBhcyB0aGUgZmxhZyB0byBmaWxsIHRoZSBiaXRtYXANCmFuZCB3cml0
ZSBvdXQgdGhlIGZzbW9uaXRvciBleHRlbnNpb24uIFRoZSBmaWxsX2ZzbW9uaXRvcl9iaXRtYXAg
d2lsbCB1c2UNCnRoZSBjdXJyZW50IENFX0ZTTU9OSVRPUl9WQUxJRCBmbGFncyBmb3IgdGhlIGlu
ZGV4IGVudHJpZXMgdG8gY3JlYXRlIHRoZQ0KYml0bWFwLg0KDQppZiAoaXN0YXRlLT5mc21vbml0
b3JfbGFzdF91cGRhdGUpDQoJZmlsbF9mc21vbml0b3JfYml0bWFwKGlzdGF0ZSk7DQoNCnZvaWQg
ZmlsbF9mc21vbml0b3JfYml0bWFwKHN0cnVjdCBpbmRleF9zdGF0ZSAqaXN0YXRlKQ0Kew0KCXVu
c2lnbmVkIGludCBpLCBza2lwcGVkID0gMDsNCglpc3RhdGUtPmZzbW9uaXRvcl9kaXJ0eSA9IGV3
YWhfbmV3KCk7DQoJZm9yIChpID0gMDsgaSA8IGlzdGF0ZS0+Y2FjaGVfbnI7IGkrKykgew0KCQlp
ZiAoaXN0YXRlLT5jYWNoZVtpXS0+Y2VfZmxhZ3MgJiBDRV9SRU1PVkUpDQoJCQlza2lwcGVkKys7
DQoJCWVsc2UgaWYgKCEoaXN0YXRlLT5jYWNoZVtpXS0+Y2VfZmxhZ3MgJiBDRV9GU01PTklUT1Jf
VkFMSUQpKQ0KCQkJZXdhaF9zZXQoaXN0YXRlLT5mc21vbml0b3JfZGlydHksIGkgLSBza2lwcGVk
KTsNCgl9DQp9DQoNCmlmICghc3RyaXBfZXh0ZW5zaW9ucyAmJiBpc3RhdGUtPmZzbW9uaXRvcl9s
YXN0X3VwZGF0ZSkgew0KCXN0cnVjdCBzdHJidWYgc2IgPSBTVFJCVUZfSU5JVDsNCg0KCXdyaXRl
X2ZzbW9uaXRvcl9leHRlbnNpb24oJnNiLCBpc3RhdGUpOw0KCWVyciA9IHdyaXRlX2luZGV4X2V4
dF9oZWFkZXIoJmMsICZlb2llX2MsIG5ld2ZkLCBDQUNIRV9FWFRfRlNNT05JVE9SLCBzYi5sZW4p
IDwgMA0KCQl8fCBjZV93cml0ZSgmYywgbmV3ZmQsIHNiLmJ1Ziwgc2IubGVuKSA8IDA7DQoJc3Ry
YnVmX3JlbGVhc2UoJnNiKTsNCglpZiAoZXJyKQ0KCQlyZXR1cm4gLTE7DQp9DQo=
