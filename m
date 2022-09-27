Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E9C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 04:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiI0EDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 00:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI0EDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 00:03:17 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE62A486C
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1664251395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+TGZMW1a4UjssX8FKUpTwqwHyEUsRJGdGFexPemxjs=;
        b=MpoG1GLdRsH+4pk88tVuesOnGZ9XSD/JFhleT0lZr/p4PrW0ArI8rmcMgbkUTnDohCGTWP
        t++oPZzV2hsS/KtFUfYnemrJN7pL6shYWEQbBg+J8OR+qgGzfNmcWkBrX1qi6VHVLnSa8v
        lbpr4/cyg/lK+PvKNTJX4GnbV87wjdo=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-centralusazlp17013039.outbound.protection.outlook.com [40.93.13.39])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-h0VFkp-OPIKmIkRlnctBBw-1; Tue, 27 Sep 2022 00:03:13 -0400
X-MC-Unique: h0VFkp-OPIKmIkRlnctBBw-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by DM6PR05MB4811.namprd05.prod.outlook.com (2603:10b6:5:1a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 27 Sep
 2022 04:03:11 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5676.014; Tue, 27 Sep 2022
 04:03:10 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v12 6/6] fsmonitor: add documentation for allowRemote and
 socketDir options
Thread-Topic: [PATCH v12 6/6] fsmonitor: add documentation for allowRemote and
 socketDir options
Thread-Index: AQHY0E5dp2bC65sUEUWf+HFHzTdIE63x08aAgAC534CAAB1xsA==
Date:   Tue, 27 Sep 2022 04:03:10 +0000
Message-ID: <BL0PR05MB55710CE7C3AB27C3F4CF738DD9559@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <b375b0ac798a673301a09903dcdfb22bedda7393.1664048782.git.gitgitgadget@gmail.com>
 <220926.864jwu181g.gmgdl@evledraar.gmail.com>
 <CAPig+cSsKu9N+vSx5gTuxksi6sDczszXntQnMinHgRZVfY9JGA@mail.gmail.com>
In-Reply-To: <CAPig+cSsKu9N+vSx5gTuxksi6sDczszXntQnMinHgRZVfY9JGA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|DM6PR05MB4811:EE_
x-ms-office365-filtering-correlation-id: f26d3fa2-ee95-4b11-2979-08daa03d311e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: XR20cTzd0OQDyAONv5JS1+rF9Bmaze7sQIxX6l3bAL7Yhwc8Us4IUXaCgw38Nm6URAFmaGf/Zm6z8ZwLtP/4Ohn2NLpOOKu082AMHj55GLnlXbombShB/LMSmWJLxLlpTY5muE7p/aDNjceDK9Tv6Ccu80MzDNuCDlC0IBBxxjeVYTdHykP1DOK/kKH1tdpIL+zQ+glEmMCe8eTGHuZgPo41CBAt2+DCVzne3HI6piQkGegJRis8dvMmcN6FP1CkoGWpdnWR5MBKbmiTWFHm5v5LCC+djLzKPqAkMyQvWhlUlRG6UGQVZckCS2yXY4Mod17qUPMmcREdnOx8KVmQ7pna3TqdyggExN5kh+XhSRFgda+L5gpVb1t6uK6iWRfEVhzJEt/nOzwdMDfJs7Tm5EggSDtxnlrZgniGl7eHSghLDI8xRELxpw1aVYQK/7oBa8F53g62A+31vH9H3idYVxKQFUkM9YQ2lc4ofHDMT9beidv9EJpwKew1LpBsmaYMFTSJuFvrd8gQlKL4ykDyLNpl6+7yMthLMi4+J+uyoGgZAdo891pxD7UC6BaVnjtGxYBLKBDFP6Lzvdue1WF+JprC5vFN1P/6/f1ewzkO+StPINzbD+tGPQcjzcKQX6NvkUqVDIQqqNKu90fz92UrDUQvhq6RVmJ8Zzs3Mm4bzQCl12PGqpEJhhgjSnheBcyS4isgXAXKDSri2kSnN2aPZqASee5sgmF38GDami6Wk4wkICFK/FuBAd7fm5r7Bp0gzjBR55Wzdg4B+yQOrCTFY5S174F8U84vFr39P/UI8MJn5zdOAtClHTIBsNGscPwiKu0lPn10/7rcOOv/jSuiVgEo84hy9EHBSbeJNHr6IU8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(41300700001)(52536014)(53546011)(966005)(83380400001)(38070700005)(110136005)(33656002)(71200400001)(7696005)(6506007)(2906002)(38100700002)(122000001)(8936002)(316002)(478600001)(86362001)(54906003)(5660300002)(186003)(66574015)(55016003)(26005)(66556008)(8676002)(66446008)(66946007)(64756008)(9686003)(4326008)(66476007)(76116006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVBKRzVZOU1McGMvMUJOak96NTIvRWJ2VnljM3U5bE9oOVo2TDUwRGdsOHFO?=
 =?utf-8?B?REJ3bGxNZ3F3Q1RoWWprOGVZYjVjWU9KaDZOaXo5N0hSeDBnSzJTV0RNeW9p?=
 =?utf-8?B?czROTzJvZEx0cnlJdDJLb2o5Y3pMdzMrS29LQUFmb1gzRjlQdnpGblJiTlYx?=
 =?utf-8?B?LzZhbTJJOFpWaVd1dkt3R1l0WHBSamJxL2o0VjdkTlNGaXArLzBUb2dkSFdx?=
 =?utf-8?B?L01xdm9nMDRrTnl2UysxUzJwY21pYkNBOEtaMlBoOGF1amxVUFpQOGlXSmdH?=
 =?utf-8?B?cGRRNkpoa0t5enBKbThGRnFuYTBPRGZhOUJvdnJUOVJLVUdUNjB0MWJabEQw?=
 =?utf-8?B?MFJsTEZLRzlpNXBWczBBWkwwYXVCd245RnRMMHdiMlVyazUybTB0NVhpelJG?=
 =?utf-8?B?K2pZOHA0MlBtUnVrLyt1QUxpdmZFL29sb0IwVjlpWHduNHhyVEFibkl1VHpv?=
 =?utf-8?B?ckpXamp5Y1U5U2lDeUNIZHF4VVc0a01wMlpxNkt4KzZOc2NKd0NRTWtzcVNX?=
 =?utf-8?B?Z2ZRLzlTS1c1WVlyZzByYnljSDEySmZsbmY4b09qNjNpR1dtU2VhZTVkYVV6?=
 =?utf-8?B?dEY2Um5EdThYRU1yL1hpSGxNdFFNYnprNm5FZUFXZkxZQlBEK2tmOFdBUXI0?=
 =?utf-8?B?YlYyU1pVaDNLcXNKWWxEOWhXc2d1Q0h5elMyUjIyMXprK2w4WVRhOHluay9r?=
 =?utf-8?B?L01wa2FQQklJdTg4ck9JdjlzejdSRHhkSjErWGsyVnZtdVc3Z3QyVFZGTlc3?=
 =?utf-8?B?bVhucGtIeG41a3FiWE1aTk42U2JYMFRsNVJvMkR6NDBzSnVYVHJPZDMzUjBs?=
 =?utf-8?B?YUo0Ykt3SW90R2U1ZUJWRWVHNnF0YlpYZ0N1L1BZTWtZU2FQaW5SZEhZYUFD?=
 =?utf-8?B?WlNqeG10S0xDY1djdkZJMytKSHNmNXVZdjUwVWhvZEhVdC9ISUpNQmRsZlF1?=
 =?utf-8?B?NXV2MWNBT0k2eGRTbTFQTVhsNGdVM0s2ckJZR0pPMWRPZFdRelZFNVZIcEk1?=
 =?utf-8?B?Z3ptcWdSZEJrWXNtV0VDbWJHUWI2TlJ6cStoS1B2ZERxYzdLbE4wZ2lna3hQ?=
 =?utf-8?B?SE03NjVEVkFJNWZSRDVLOUY4MGlDZXJmenNGVE9qY0lYM0NlUUVjVjZJemsv?=
 =?utf-8?B?MGpQSERtdERwSlFmMkJBbXUzNlZhOUZWenp4VThqVldvMUhoTUJoVEFZV0RF?=
 =?utf-8?B?alIwSWZTcW1IVzhLclJuV005T0tKb2N5MWNxdlhTWUkySEt1ejlXRUVJWVlX?=
 =?utf-8?B?am5mOFNBUzcvSVY3eU5mZjBNVGNUQzl3N0xFcEZrMjhzNEZFZVAreC9VbVlI?=
 =?utf-8?B?b0psUjhOOGxRb2NQbDRVaStiYThqQ2RuRFh6dmZwSURHclVSSjRhMlpQekRp?=
 =?utf-8?B?T0VRQUd4cFBwMVZucTRabC9CMWU1Q1lmLzBCc1ZrRlBZbWo0d2NhSzVrSFhk?=
 =?utf-8?B?VjdETmVuUGxKQm9WbnFpZkh0QW9FdFMxU3owZ2N6OFlGWHlIL3cxUUtKczN4?=
 =?utf-8?B?UThhbFZ3bERnOWdOY0NSWHgxbGE5alljTVZLeVdENUgwZ2JoZlZvZHJxSllx?=
 =?utf-8?B?T0p0Yjg2SDRMYk92elVqV2YrNERKMGFrWHJWSzU0Y29OSlZUOENrRFVmWkZv?=
 =?utf-8?B?Ti9xQUkvc2JQU2U0czRpcnd3cVZ0cnZicHAzT1RGT0lyRjUwRk8rRFNnbHZI?=
 =?utf-8?B?YlFBNHlGUW1VOTl5U0JmRmRZeXozeC9IVlBNY3R2VGUzbGg5V09FbFB3MGo2?=
 =?utf-8?B?cGR2NkpMck0wekg4dHZkTGpTQ0xZRVZtNjRFckhLYnpITVpINkVVenVFbDBI?=
 =?utf-8?B?ZU5iK2UrWnNscU1Hc3haeGdjRW9pcDNHMjVTTXk4OFcwMjFmak5pRlc3eXJt?=
 =?utf-8?B?UTFjTGU3VzgwMlVnVncwTEs5bWE0cStkTWZSWVNOcE1lNXlUaG1ZWjk5aE1p?=
 =?utf-8?B?N3B2dGdFWkFnVWdSNVJXZXBsamM2eXkvSExvNEJ4cTBHYVgvRnZPYlg0dkM5?=
 =?utf-8?B?OVBIT3U4ME1JZXgyN1JCSmpuVHZ6QnJ3QkM1N2Z2SEFibTRoendhTENtN3Ja?=
 =?utf-8?B?dGlKT2p0d1BIK0RzV1JoMTBDMk0vMWZBa3IzVVhKdWdCRkY0aFMzR2p5aGV2?=
 =?utf-8?Q?rqkLV+1r/sR/IRgfY+Rlom5wl?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26d3fa2-ee95-4b11-2979-08daa03d311e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 04:03:10.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThOq6xBZ6r/q7hPvUeLkdTZPHvzll7wQHiLDuw55Qon2jNK4HOf9zr7OqsEMkpdO7QDCDLLebYdfweL0DJkbKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4811
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBTdW5zaGluZSA8
c3Vuc2hpbmVAc3Vuc2hpbmVjby5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI2LCAy
MDIyIDEwOjE2IFBNDQo+IFRvOiDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiA8YXZhcmFiQGdt
YWlsLmNvbT4NCj4gQ2M6IEVyaWMgRGVDb3N0YSB2aWEgR2l0R2l0R2FkZ2V0IDxnaXRnaXRnYWRn
ZXRAZ21haWwuY29tPjsgR2l0IExpc3QNCj4gPGdpdEB2Z2VyLmtlcm5lbC5vcmc+OyBKZWZmIEhv
c3RldGxlciA8Z2l0QGplZmZob3N0ZXRsZXIuY29tPjsgVG9yc3Rlbg0KPiBCw7ZnZXJzaGF1c2Vu
IDx0Ym9lZ2lAd2ViLmRlPjsgUmFtc2F5IEpvbmVzDQo+IDxyYW1zYXlAcmFtc2F5am9uZXMucGx1
cy5jb20+OyBKb2hhbm5lcyBTY2hpbmRlbGluDQo+IDxKb2hhbm5lcy5TY2hpbmRlbGluQGdteC5k
ZT47IEVyaWMgRGVDb3N0YSA8ZWRlY29zdGFAbWF0aHdvcmtzLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MTIgNi82XSBmc21vbml0b3I6IGFkZCBkb2N1bWVudGF0aW9uIGZvciBhbGxvd1Jl
bW90ZQ0KPiBhbmQgc29ja2V0RGlyIG9wdGlvbnMNCj4gDQo+IE9uIE1vbiwgU2VwIDI2LCAyMDIy
IGF0IDExOjE1IEFNIMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uDQo+IDxhdmFyYWJAZ21haWwu
Y29tPiB3cm90ZToNCj4gPiBPbiBTYXQsIFNlcCAyNCAyMDIyLCBFcmljIERlQ29zdGEgdmlhIEdp
dEdpdEdhZGdldCB3cm90ZToNCj4gPiA+IEFkZCBkb2N1bWVudGF0aW9uIGZvciAnZnNtb25pdG9y
LmFsbG93UmVtb3RlJyBhbmQNCj4gJ2ZzbW9uaXRvci5zb2NrZXREaXInLg0KPiA+ID4gQ2FsbC1v
dXQgZXhwZXJpbWVudGFsIG5hdHVyZSBvZiAnZnNtb25pdG9yLmFsbG93UmVtb3RlJyBhbmQgbGlt
aXRlZA0KPiA+ID4gZmlsZSBzeXN0ZW0gc3VwcG9ydCBmb3IgJ2ZzbW9uaXRvci5zb2NrZXREaXIn
Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVyaWMgRGVDb3N0YSA8ZWRlY29zdGFAbWF0
aHdvcmtzLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gLWdpdC1mc21vbml0b3ItLWRhZW1vbiAtIEEg
QnVpbHQtaW4gRmlsZSBTeXN0ZW0gTW9uaXRvcg0KPiA+ID4gK2dpdC1mc21vbml0b3ItLWRhZW1v
biAtIEEgQnVpbHQtaW4gRmlsZXN5c3RlbSBNb25pdG9yDQo+ID4NCj4gPiBXZSBoYXZlIH40MDAg
dXNlcyBvZiAiZmlsZXN5c3RlbSIgaW4tdHJlZSwgYnV0IH4xMDAgZm9yICJmaWxlIHN5c3RlbSIu
DQo+ID4gSSBkb24ndCBtaW5kIHRoZSBjaGFuZ2UgcGVyLXNlLCBidXQgdGhpcyBsb29rcyBsaWtl
IGFuIG9kZCAid2hpbGUgYXQgaXQiDQo+ID4gY2hhbmdlLg0KPiA+DQo+ID4gPiBBIGRhZW1vbiB0
byB3YXRjaCB0aGUgd29ya2luZyBkaXJlY3RvcnkgZm9yIGZpbGUgYW5kIGRpcmVjdG9yeQ0KPiA+
ID4gLWNoYW5nZXMgdXNpbmcgcGxhdGZvcm0tc3BlY2lmaWMgZmlsZSBzeXN0ZW0gbm90aWZpY2F0
aW9uIGZhY2lsaXRpZXMuDQo+ID4gPiArY2hhbmdlcyB1c2luZyBwbGF0Zm9ybS1zcGVjaWZpYyBm
aWxlc3lzdGVtIG5vdGlmaWNhdGlvbiBmYWNpbGl0aWVzLg0KPiA+DQo+ID4gTW9yZSB3aGlsZS1h
dC1pdC4uLg0KPiANCj4gVGhlc2UgY2hhbmdlcyBtYXkgaGF2ZSBiZWVuIGluIHJlc3BvbnNlIHRv
IG15IHJldmlld1sxXSwgdGhvdWdoIEkgZGlkIHNheQ0KPiB0aGF0IHN1Y2ggYSBjaGFuZ2Ugd2Fz
IG91dHNpZGUgdGhlIHNjb3BlIG9mIHRoaXMgc2VyaWVzLiBQZXJoYXBzIEkgbmVlZCB0bw0KPiBj
aG9vc2UgbXkgd29yZGluZyBtb3JlIGNhcmVmdWxseT8NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvZ2l0L0NBUGlnK2NRNVNNdyswQ3d0dzQ3TFFNNTktDQo+IG1RakphT1BlX0xU
eWJBQzJqPTNGOU95d0FAbWFpbC5nbWFpbC5jb20vIDxodHRwczovL3Byb3RlY3QtDQo+IHVzLm1p
bWVjYXN0LmNvbS9zL1NUd09DRzZBN0RJWWdBcVljN1dkdGg/ZG9tYWluPWxvcmUua2VybmVsLm9y
Zz4NCj4NCllvdXIgd29yZGluZyB3YXMgZmluZS4gTmV4dCB0aW1lIEknbGwga25vdyBiZXR0ZXIg
YW5kIGxlYXZlIGl0IGZvciBhbm90aGVyIHBhdGNoIHNldC4NCg0KLUVyaWMNCg0K

