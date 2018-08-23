Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A786E1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeHWTXR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:23:17 -0400
Received: from mail-eopbgr690090.outbound.protection.outlook.com ([40.107.69.90]:40930
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeHWTXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUbzHziEG2jfx+b15tCl8AKaik6yp9/qLiOh1O0k2X8=;
 b=CLarqRmZXyLNeYFsXrM+ETXjB2m6QHWeG3kA17aplHAf4cL3n/sVoZwmt8JOz4kIWlk/dK5qC/u1b+3pZZNLA4FkdY6h/IdYdoWH1oYKipI7xKXPSz9eLnevxZmt9Wu4LIVRGEmokuIdjtRmKpZ+HQNPV19WR5Y5jpR4C6dG7KE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1043.namprd21.prod.outlook.com (52.132.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.2; Thu, 23 Aug 2018 15:51:19 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.007; Thu, 23 Aug 2018
 15:51:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "j6t@kdbg.org" <j6t@kdbg.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] config: fix commit-graph related config docs
Thread-Topic: [PATCH v2] config: fix commit-graph related config docs
Thread-Index: AQHUOvkie1rtG1+a8EWZVNU0+nDFGA==
Date:   Thu, 23 Aug 2018 15:51:19 +0000
Message-ID: <20180823155107.16658-1-dstolee@microsoft.com>
References: <20180822131547.56899-1-dstolee@microsoft.com>
In-Reply-To: <20180822131547.56899-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR0601CA0052.namprd06.prod.outlook.com
 (2603:10b6:910:89::29) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [167.220.148.125]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;6:NWUnVL6OlUWRTPU4pakhV5ELvox71O27x+3Z4KPCN17lWGcTMNdbA63uAwNnU5NWNx3hdzNlJHDat5HtjEW6Kn2/5lwTUCHiork3yc8PQoICaMeFtPLH8n4j0DyM47aUtlEywZyMiGznwWSCKLpuBBdwDee3P06t6UoC0H2dMY/tG/jEzp4kZv9GtrUj4lvVO9t/2HG3yaseL8J9Z5Sgr7X8/bBi4//PJdrn7JPRnAjLD48CPZfoRAsY0BfMIBghHpnINGC2wFqzFaMWd5f8A50zjBbtwDYDMhKCXnyzkAxPlDL1dsOXsKKd5vjwRODbQxtxFd9BWedBd8dmcefBEXUFVVdtfnxvV8QFfihtz7CFZBmcdkQ0GYBrCt036YEaWCJDJnVpc8/GIq2PlmqHZ4f75N44b8qItfOjJv3m6WJRmk8+9BrOxeZNasJNtI+EYguOjBC8n4TFzWrvmexY4g==;5:BFO9+D0SrGPWAJSxr78V2624Tk+jCLJM9d9UFoZoi3/CWqVAO0FRAjcB4+DdXx2lUNFpTCilMwFOjj3G0xzUfj3XLKzoR2qB9booEjUyrZWumLxgCMNzTRRogwcvbjnebPPwnGZbuOprysTHe93mEu7QHBpAbQ4lFG3svGNYank=;7:DXgCa7gKTS66bZfvRSXomLcipJksL6uDIr3S0Am1NdreFOrc2xztEiaGwmwaxbDALHibWVnfbZhxoe4hO+JPZjeltl9HSf5vBQr4ZdXeG+gLDoyN9zjgw/Ab1paX8OtKCGofG1vw0M8lVN+N05YDnCBDYvMEO6PohkiJPRvhAVpUm14PaMXIEkyk2T2QnRYwAPr60lVH9qdFNu6zz7zNnG2iWMIqwptlfYsmUjGxcC6MaGjQg0H0YXADEeOlgopr
x-ms-office365-filtering-correlation-id: c346000c-b672-4a96-1597-08d609104480
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB10438173B24173EEA6B73CACA1370@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699037)(76991021);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(476003)(6346003)(186003)(52116002)(99286004)(5640700003)(5250100002)(14454004)(68736007)(2351001)(26005)(305945005)(2616005)(2906002)(6486002)(446003)(11346002)(2501003)(7736002)(386003)(6506007)(8936002)(6116002)(2900100001)(478600001)(3846002)(1076002)(6436002)(6512007)(256004)(97736004)(53936002)(25786009)(22452003)(6916009)(10290500003)(8676002)(81156014)(54906003)(107886003)(105586002)(486006)(66066001)(10090500001)(102836004)(36756003)(5660300001)(4326008)(81166006)(39060400002)(316002)(106356001)(86362001)(76176011)(1730700003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 9b8nlLKiGXIglPdYqAgF9tyIOST43puX3JC11BGVQBpDQ4y4jqAbEYoTiDaO7pfiRgdxIIyAuVV7hYvFRabf4RI/frtlVyB+c+c1qQUlMxeUQnVIw4LCAH2k7ysVnA9wG0XkGNwsp5OAe0lxGep1QDA3iVH24XHurm+iviewsUt8VRtxyk2wg+3AmhiDGP8EriofMDmSjFz6LlDHUNNcpHlvSjkP5Ife6LdTw+4R4mB2h3kRw4ng1qWiTgn0M2lhl36xZCtgjsWqLqgETLyFa08H8KVX3dEYkOSc3PPIoIMIlIOg7hPWdVwm/8nb3SPhq6cmsd7tFgd/FotySEgijQ7J7UDYrtr2PkJDCh7BdoM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EF6E30CF97DA44C82F58944FF71CA84@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c346000c-b672-4a96-1597-08d609104480
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 15:51:19.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGNvcmUuY29tbWl0R3JhcGggY29uZmlnIHNldHRpbmcgd2FzIGFjY2lkZW50YWxseSByZW1v
dmVkIGZyb20NCnRoZSBjb25maWcgZG9jdW1lbnRhdGlvbi4gSW4gdGhhdCBzYW1lIHBhdGNoLCB0
aGUgY29uZmlnIHNldHRpbmcNCnRoYXQgd3JpdGVzIGEgY29tbWl0LWdyYXBoIGR1cmluZyBnYXJi
YWdlIGNvbGxlY3Rpb24gd2FzIGluY29ycmVjdGx5DQp3cml0dGVuIHRvIHRoZSBkb2MgYXMgImdj
LmNvbW1pdEdyYXBoIiBpbnN0ZWFkIG9mICJnYy53cml0ZUNvbW1pdEdyYXBoIi4NCg0KUmVwb3J0
ZWQtYnk6IFN6ZWRlciBHw6Fib3IgPHN6ZWRlci5kZXZAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1i
eTogRGVycmljayBTdG9sZWUgPGRzdG9sZWVAbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIERvY3VtZW50
YXRpb24vY29uZmlnLnR4dCB8IDE3ICsrKysrKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2NvbmZpZy50eHQgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQNCmluZGV4IDFjNDIz
NjQ5ODguLjZlZTE4OTA5ODQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQN
CisrKyBiL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dA0KQEAgLTkxNywxMiArOTE3LDEwIEBAIGNv
cmUubm90ZXNSZWY6Og0KIFRoaXMgc2V0dGluZyBkZWZhdWx0cyB0byAicmVmcy9ub3Rlcy9jb21t
aXRzIiwgYW5kIGl0IGNhbiBiZSBvdmVycmlkZGVuIGJ5DQogdGhlIGBHSVRfTk9URVNfUkVGYCBl
bnZpcm9ubWVudCB2YXJpYWJsZS4gIFNlZSBsaW5rZ2l0OmdpdC1ub3Rlc1sxXS4NCiANCi1nYy5j
b21taXRHcmFwaDo6DQotCUlmIHRydWUsIHRoZW4gZ2Mgd2lsbCByZXdyaXRlIHRoZSBjb21taXQt
Z3JhcGggZmlsZSB3aGVuDQotCWxpbmtnaXQ6Z2l0LWdjWzFdIGlzIHJ1bi4gV2hlbiB1c2luZyBs
aW5rZ2l0OmdpdC1nY1sxXQ0KLQknLS1hdXRvJyB0aGUgY29tbWl0LWdyYXBoIHdpbGwgYmUgdXBk
YXRlZCBpZiBob3VzZWtlZXBpbmcgaXMNCi0JcmVxdWlyZWQuIERlZmF1bHQgaXMgZmFsc2UuIFNl
ZSBsaW5rZ2l0OmdpdC1jb21taXQtZ3JhcGhbMV0NCi0JZm9yIGRldGFpbHMuDQorY29yZS5jb21t
aXRHcmFwaDo6DQorCUlmIHRydWUsIHRoZW4gZ2l0IHdpbGwgcmVhZCB0aGUgY29tbWl0LWdyYXBo
IGZpbGUgKGlmIGl0IGV4aXN0cykNCisJdG8gcGFyc2UgdGhlIGdyYXBoIHN0cnVjdHVyZSBvZiBj
b21taXRzLiBEZWZhdWx0cyB0byBmYWxzZS4gU2VlDQorCWxpbmtnaXQ6Z2l0LWNvbW1pdC1ncmFw
aFsxXSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCiANCiBjb3JlLnVzZVJlcGxhY2VSZWZzOjoNCiAJ
SWYgc2V0IHRvIGBmYWxzZWAsIGJlaGF2ZSBhcyBpZiB0aGUgYC0tbm8tcmVwbGFjZS1vYmplY3Rz
YA0KQEAgLTE3NjMsNiArMTc2MSwxMyBAQCB0aGlzIGNvbmZpZ3VyYXRpb24gdmFyaWFibGUgaXMg
aWdub3JlZCwgYWxsIHBhY2tzIGV4Y2VwdCB0aGUgYmFzZSBwYWNrDQogd2lsbCBiZSByZXBhY2tl
ZC4gQWZ0ZXIgdGhpcyB0aGUgbnVtYmVyIG9mIHBhY2tzIHNob3VsZCBnbyBiZWxvdw0KIGdjLmF1
dG9QYWNrTGltaXQgYW5kIGdjLmJpZ1BhY2tUaHJlc2hvbGQgc2hvdWxkIGJlIHJlc3BlY3RlZCBh
Z2Fpbi4NCiANCitnYy53cml0ZUNvbW1pdEdyYXBoOjoNCisJSWYgdHJ1ZSwgdGhlbiBnYyB3aWxs
IHJld3JpdGUgdGhlIGNvbW1pdC1ncmFwaCBmaWxlIHdoZW4NCisJbGlua2dpdDpnaXQtZ2NbMV0g
aXMgcnVuLiBXaGVuIHVzaW5nIGxpbmtnaXQ6Z2l0LWdjWzFdDQorCSctLWF1dG8nIHRoZSBjb21t
aXQtZ3JhcGggd2lsbCBiZSB1cGRhdGVkIGlmIGhvdXNla2VlcGluZyBpcw0KKwlyZXF1aXJlZC4g
RGVmYXVsdCBpcyBmYWxzZS4gU2VlIGxpbmtnaXQ6Z2l0LWNvbW1pdC1ncmFwaFsxXQ0KKwlmb3Ig
ZGV0YWlscy4NCisNCiBnYy5sb2dFeHBpcnk6Og0KIAlJZiB0aGUgZmlsZSBnYy5sb2cgZXhpc3Rz
LCB0aGVuIGBnaXQgZ2MgLS1hdXRvYCB3b24ndCBydW4NCiAJdW5sZXNzIHRoYXQgZmlsZSBpcyBt
b3JlIHRoYW4gJ2djLmxvZ0V4cGlyeScgb2xkLiAgRGVmYXVsdCBpcw0KLS0gDQoyLjE5LjAucmMw
DQoNCg==
