Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77041F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbeIFXkC (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:40:02 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:6211
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729083AbeIFXkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zmml9bJ+9IHlzf4qrEBtLYMyhfK8k+xtVVpVOZiRIs=;
 b=aamcuci1wmAHnJBwCZsHm2xqi+4bzAGLR3QisPVMSf9RlQXJOj/1u2QHZBRvsKnc2BOl45uZxWUCcd2LYFH2AvW7m8mqDQe65jJm8wfmUERYGkp/0VQqz+hUcL7EwT2ffXwhS2EicOamLdAvRn55zXCE+yn9Rq5wVD+WwqJifgI=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0924.namprd21.prod.outlook.com (52.132.152.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Thu, 6 Sep 2018 19:03:07 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858%4]) with mapi id 15.20.1143.008; Thu, 6 Sep 2018
 19:03:07 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: RE: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
Thread-Topic: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
Thread-Index: AQHT9CP1HB4g94JO80KizjOKnc2PoKRA2smAgKL4EwCAAEojgIAAH+UA
Date:   Thu, 6 Sep 2018 19:03:06 +0000
Message-ID: <MW2PR2101MB0970C7744A6FA72940DCB252F4010@MW2PR2101MB0970.namprd21.prod.outlook.com>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <87lgc77wc7.fsf@evledraar.gmail.com>
 <CAGZ79kae4k=uLx-oX5emxas4KrqObzQhzgir0coOSBzzpO8APw@mail.gmail.com>
 <87tvn2remn.fsf@evledraar.gmail.com>
 <CAGZ79kYKzrRXy+GUCpMN3jpo4MvcpGvBFvEkTjrsy85XJb0K2A@mail.gmail.com>
In-Reply-To: <CAGZ79kYKzrRXy+GUCpMN3jpo4MvcpGvBFvEkTjrsy85XJb0K2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-06T19:03:03.2760433Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:hrEuq+4E8LSw3L9MN/x/+HyLuAAN87Fx1/YT0O+xu5Mm/ENFL0TM3blsCNGI/tHQP2h8U5hEfadTOgrFk2ogig2EfB39/3LoFU7YmKHJtbHZ/mGlYbFrvzx7hOByzynYjQBqX2Ss1dye0H2uMLaOyBOxd2PU3Rzsm2mIFPasKO3g1r89k7jZ4uuYjdNPLvKBayyyXkrg6YYQmhXmSYDWg9pol/p5Lnd9jUhFF/MY5fqe64dC3sGqYZyZtLLjUJOMAYvujWPOD1461cjZnGCx2qytKIgiuSXHq86Lbxbr4gnMVZO1IF6f7IZqXZfBOrcW+MWR/m0xX1AhKfXMhVclApuiQqkRO0ekLalTjlJbEUc9cNwtU2KjuH4lLen8yWg9N1i9aQpaQ1apYtRodDZFUpDM+mVErnCn3xB9MVAOLatLo8dAUhn1IwzYDCKgklU9gVZssrVp8rxq8OwArr86Cw==;5:jUYiwEmj0ikBPFk+rBc+ln8OUYxHGKr1puoKc/shQqsemvtQs9NyQyBy/qTvrtMAAHSlVFeZEoRngW1UcIspyubkpRy/0BNGAPIYqU11cXJZ/eiTivqCgZ7Lm4Edp3fMKwmf/MjrslNbHsjuR7jeKWbGNO055kVDTq7kFZrRCpA=;7:+NtXbIqgiEy/Fm9fLv0OW8JvTJdWH2w0O7nnSDnI8v2f1yxmkR7RQ5cF2LiO4XDay9lUysbXWhGMtwJuPYxn46bQut0Xm3o+auGwyuxHRlGzCiph0yIEExUlpZ067AigB1OCyK+dA5zcGPBzlbuejcqkXSPZSmvL3xO7S2C9bKy4k5gYpqFrxcZdjpihXgyyHmWu6UtYHyADeJ4HJ+H90DaLpSr1OhqzU04n4eEypF9EGDh9wSGZCKaUogMervnL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1bf3412d-6469-4a5c-f526-08d6142b616c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
x-microsoft-antispam-prvs: <MW2PR2101MB0924DCBA8A1E6B1DE739E7A9F4010@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(85827821059158)(211936372134217)(153496737603132)(219752817060721)(100324003535756);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(54094003)(13464003)(199004)(189003)(106356001)(5660300001)(68736007)(305945005)(7736002)(55016002)(2906002)(10290500003)(229853002)(6436002)(6306002)(9686003)(25786009)(66066001)(39060400002)(4326008)(81166006)(8936002)(81156014)(8676002)(74316002)(2900100001)(33656002)(105586002)(97736004)(256004)(6246003)(11346002)(26005)(99286004)(86362001)(102836004)(14454004)(53546011)(186003)(966005)(10090500001)(8990500004)(446003)(72206003)(5250100002)(476003)(486006)(6346003)(478600001)(54906003)(53936002)(86612001)(6506007)(110136005)(7696005)(22452003)(76176011)(316002)(3846002)(6116002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: cWnJDGp0SliozvEs4/2qRjLAaZdFExRhllDHUPEKqcxoYlbyGVGbcQU4ELlSYOSqtSPAgi5Cacly6P4/2Q9H6bfuLTgA98SeVf4VanzVueznGxjuUphAZ9WfbbThAVl8BqbD3SZrEDY+9ohW/z/mnRnVuERO1p4BdVUorx776LCjaM9/+FpjZAyldtZOD/nJkehGF7rtl8aApb0u0yNbjiaEm1TRi6AM6K3DQSMrOzfuNj2+s/0UWSInfeSld+ro/j4tcV8IyxUpD0v1Pmq/QaYNycpe8Ajvm3Eadm0J62dDDl3Uq0+5f8C5LB2jQykxk3l0Q+Nd3Muryq65mylo2xWSqrOYXuVnkTYaZuzIOoI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf3412d-6469-4a5c-f526-08d6142b616c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 19:03:06.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gQmVsbGVyIDxzYmVs
bGVyQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgNiwgMjAxOCAxMjo1
NyBQTQ0KPiBUbzogw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gPGF2YXJhYkBnbWFpbC5jb20+
DQo+IENjOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+OyBnaXQgPGdpdEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBCZW4NCj4gUGVhcnQgPEJlbi5QZWFydEBtaWNyb3NvZnQuY29tPg0KPiBT
dWJqZWN0OiBSZTogc2Ivc3VibW9kdWxlLW1vdmUtbmVzdGVkIGJyZWFrcyB0NzQxMSB1bmRlcg0K
PiBHSVRfRlNNT05JVE9SX1RFU1QNCj4gDQo+ID4gPiBXaWxsIGRlYnVnIGZ1cnRoZXIuDQo+ID4N
Cj4gPiBJIHNwb3R0ZWQgdGhpcyBhZ2FpbiBhZnRlciB0ZXN0aW5nIHRoZSBzcGxpdCBpbmRleCAo
c2VlDQo+ID4NCj4gaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZwdWJsaWMtDQo+IGluYm94Lm9yZyUyRmdpdCUyRjg3dmE3aXJl
dXUuZnNmJTQwZXZsZWRyYWFyLmdtYWlsLmNvbSUyRiZhbXA7ZGF0YT0wDQo+IDIlN0MwMSU3Q0Jl
bi5QZWFydCU0MG1pY3Jvc29mdC5jb20lN0MyN2M5MDFmMTk4YTI0ZTVhMDQ1YTA4ZDYxNDENCj4g
OWNlNDIlN0M3MmY5ODhiZjg2ZjE0MWFmOTFhYjJkN2NkMDExZGI0NyU3QzElN0MwJTdDNjM2NzE4
NDk4NDAxDQo+IDc4ODY5NyZhbXA7c2RhdGE9SmZhdkh0S2FmaUpSQVZudk1YVTNudzFSSTI3RzRP
RnhzM1ltdDdTVGJ2TSUzDQo+IEQmYW1wO3Jlc2VydmVkPTApIGFuZA0KPiA+IHdhcyB0ZXN0aW5n
IHRoZSBmc21vbml0b3IgdGVzdCBtb2RlIGFzIHdlbGwuDQo+ID4NCj4gPiBTbyBnZW50bGUgKnBv
a2UqOiBEaWQgeW91IGdldCBhbnl3aGVyZSB3aXRoIGRlYnVnZ2luZyB0aGlzPyBJdCdzIHN0aWxs
DQo+ID4gZmFpbGluZyBvbiAibWFzdGVyIiBub3cuDQo+IA0KPiBJIHN0YXJ0ZWQgbG9va2luZyBp
bnRvIHRoaXMgYWdhaW4sIGhlbHAgd291bGQgYmUgYXBwcmVjaWF0ZWQsIGFzIEkgZG8gbm90DQo+
IHF1aXRlIHVuZGVyc3RhbmQgdGhlIGZzbW9uaXRvciBwYXJ0Lg0KPiANCj4gVGhlIGVycm9yIGlz
IGluIHRoZSBzZXR1cCwgd2hlcmUgd2UgaGF2ZSAiZ2l0IG12IGEgYiINCj4gDQo+IEdJVF9UUkFD
RV9GU01PTklUT1I9MSBHSVRfVFJBQ0U9MQ0KPiBHSVRfRlNNT05JVE9SX1RFU1Q9JFBXRC90NzUx
OS9mc21vbml0b3ItYWxsDQo+IC4vdDc0MTEtc3VibW9kdWxlLWNvbmZpZy5zaCAtZCAtaSAtdiAt
eA0KPiArKyBnaXQgbXYgYSBiDQo+IHRyYWNlOiBidWlsdC1pbjogZ2l0IG12IGEgYg0KPiByZWFk
IGZzbW9uaXRvciBleHRlbnNpb24gc3VjY2Vzc2Z1bA0KPiBhZGQgZnNtb25pdG9yDQo+IHJlZnJl
c2ggZnNtb25pdG9yDQo+IHRyYWNlOiBydW5fY29tbWFuZDogY2QgJy91L2dpdC90L3RyYXNoDQo+
IGRpcmVjdG9yeS50NzQxMS1zdWJtb2R1bGUtY29uZmlnL3N1cGVyJzsgL3UvZ2l0L3QvdDc1MTkv
ZnNtb25pdG9yLWFsbA0KPiAxIDE1MzYyNTI4MTk4MjQ3OTM3MjgNCj4gZnNtb25pdG9yIHByb2Nl
c3MgJy91L2dpdC90L3Q3NTE5L2ZzbW9uaXRvci1hbGwnIHJldHVybmVkIHN1Y2Nlc3MNCj4gbWFy
a19mc21vbml0b3JfY2xlYW4gJy5naXRtb2R1bGVzJw0KPiB3cml0ZSBmc21vbml0b3IgZXh0ZW5z
aW9uIHN1Y2Nlc3NmdWwNCj4gDQo+IG9yIHdpdGggbW9yZSB0cmFjZV9wcmludGZzIGxpdHRlcmVk
IHRocm91Z2ggdGhlIGNvZGUNCj4gKGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aHViDQo+IC5jb20lMkZzdGVmYW5iZWxs
ZXIlMkZnaXQlMkZ0cmVlJTJGc3VibW9kdWxlX2ZzbW9pdG9yX2RlYnVnJmFtcDtkDQo+IGF0YT0w
MiU3QzAxJTdDQmVuLlBlYXJ0JTQwbWljcm9zb2Z0LmNvbSU3QzI3YzkwMWYxOThhMjRlNWEwNDVh
MDgNCj4gZDYxNDE5Y2U0MiU3QzcyZjk4OGJmODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3
QzAlN0M2MzY3MTg0DQo+IDk4NDAxNzg4Njk3JmFtcDtzZGF0YT1wb0FVRmxWRGtvTlA1NnQxaG1k
eEhIeUNockgwNWN1dDFpU1Z0NzB5Sg0KPiBlbyUzRCZhbXA7cmVzZXJ2ZWQ9MCkNCj4gDQo+IHRy
YWNlOiBidWlsdC1pbjogZ2l0IG12IGEgYg0KPiByZWFkIGZzbW9uaXRvciBleHRlbnNpb24gc3Vj
Y2Vzc2Z1bA0KPiBhZGQgZnNtb25pdG9yDQo+IHJlZnJlc2ggZnNtb25pdG9yDQo+IHRyYWNlOiBy
dW5fY29tbWFuZDogY2QgJy91L2dpdC90L3RyYXNoDQo+IGRpcmVjdG9yeS50NzQxMS1zdWJtb2R1
bGUtY29uZmlnL3N1cGVyJzsgL3UvZ2l0L3QvdDc1MTkvZnNtb25pdG9yLWFsbA0KPiAxIDE1MzYy
NTI0OTc5NTEzMjkzNDENCj4gZnNtb25pdG9yIHByb2Nlc3MgJy91L2dpdC90L3Q3NTE5L2ZzbW9u
aXRvci1hbGwnIHJldHVybmVkIHN1Y2Nlc3MNCj4gbmVlZCB0byBzdGFnZSAuZ2l0bW9kdWxlcw0K
PiBjYWxsaW5nIGFkZF9maWxlX3RvX2luZGV4DQo+IA0KPiANCj4gSSBzdXNwZWN0IHRoYXQgdGhl
IEZTTU9OSVRPUiBBUEkgaXMgaGFuZGxlZCB3cm9uZ2x5IGJ5IHRoZSBwYXJ0IG9mIGdpdC1tdg0K
PiB0aGF0IHdyaXRlcyBvdXQgdGhlIC5naXRtb2R1bGVzIGZpbGUgKGlmIG5lZWRlZCkgYW5kIHRo
ZSAuZ2l0L2luZGV4IChhcyBuZWVkZWQpLg0KPiANCj4gQmVuLCBkbyB5b3UgaGF2ZSBhbiBpZGVh
Pw0KPiANCg0KSSdsbCB0YWtlIGEgbG9vayBhcyBzb29uIGFzIEkgY2FuIChhbmQgYXQgdGhlIG90
aGVyIGZzbW9uaXRvciB0ZXN0IGlzc3VlIMOGdmFyIHNlbnQgZW1haWwgYWJvdXQpIGJ1dCBpdCBt
YXkgYmUgYSBmZXcgZGF5cyBiZWZvcmUgSSBnZXQgYSBjaGFuY2UuDQoNCkkgaGF2ZW4ndCBoYWQg
YSBjaGFuY2UgdG8gbG9vayBpbnRvIHRoaXMgeWV0IGJ1dCBoZXJlIGFyZSBhIGNvdXBsZSBvZiBT
V0FHJ3MgSSdkIHN0YXJ0IHdpdGg6DQoNCkkgd29uZGVyIGlmIHRoZXJlIGlzIGEgbWlzc2luZyBj
YWxsIHRvIG1hcmtfZnNtb25pdG9yX2ludmFsaWQoKSBpbiB0aGUgImdpdCBtdiIgY29kZXBhdGgg
c29tZXdoZXJlLg0KDQpyZWZyZXNoX2ZzbW9uaXRvcigpIG9ubHkgcnVucyBvbmNlIHBlciBnaXQg
Y29tbWFuZCAtIGlzIGl0IHBvc3NpYmxlIHRoYXQgImdpdCBtdiIgaXMgdHJpZ2dlcmluZyBpdCBl
YXJseSwgbWFraW5nIGEgY2hhbmdlLCBhbmQgdGhlbiB1cGRhdGluZyB0aGUgaW5kZXggd2l0aCBz
dGFsZSBmc21vbml0b3IgZGF0YT8NCg0KU29ycnksIEknbGwgbG9vayBhcyBzb29uIGFzIEkgY2Fu
Lg0KDQpCZW4NCg0KPiBUaGFua3MsDQo+IFN0ZWZhbg0K
