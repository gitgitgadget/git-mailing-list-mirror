Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033E11F731
	for <e@80x24.org>; Fri,  9 Aug 2019 19:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHITgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 15:36:22 -0400
Received: from mail-eopbgr780102.outbound.protection.outlook.com ([40.107.78.102]:52745
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbfHITgV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 15:36:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqsKfZtNL+HQRZoHJmoSu88vj6NVZpzxdNdxQxCYTJEFetNvJdKAPGldbj4ajfJUev02zk5DbJLqS4uzcTGFVWQwfIgARsAskgTqYKUKWUaR7xAuiIUXnWWUVcWzOM0SLiFkHwOK/ILwboyb/s7MAjG2+05hZqU7y7jdr6tpo4XSiMn7BofS5w14HElW18NJVyjd2z9ELCQWzkncleWrUMJ6MLcbEXp6uskUA6rqIru0Z45uXrEyhd+n8N5MuKBsBhS+kCLvMaQzFgJfH9uB9qEqX//HhmKRawwayjgvrMxZGZutN0enE5vTtxuPk4jhh5q6XYakfVyrZQ+TsdnzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jt8TnfSYpjJbCABcARikie0KLs/FO57J9FA0Gj6TnU=;
 b=CpYB5xdKsmPZz8hiuZklVhE2zPjuiVe+jg8pFLo1qJqBVcNOt89hfh3i7bQ6MEuMIsD8Z/EOgGHSkCTWAD3NdUa4LF93vLHLkLhQfmFIS2YXgsOdxJtO+kzFmzsy3Ak0a/5Y6TPQ8w1Ln/2z8Z/Ckis4tw0e4pX/X1g2Mk7gifE8juMvEo8eZiH5W42luO50Rg4bqNyhFD9wJcveYllE0qxQmL2vT+bJILrcNv2R3KNfdL6fIdcOq1nua1vtcqmfGqXwyN+gMmEthhTFGy0uLwdQaV0qT/ziAf17MzImMCLkcct/zCrXtsxRUimDHXOptDcpAptXfwRZdNQenHZTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jt8TnfSYpjJbCABcARikie0KLs/FO57J9FA0Gj6TnU=;
 b=GQgbtfrBSN1VRArvQK7ieVjAMd5URjUt0ET17HTUC1ZG23QIZr9LozUOdBl3+j9qO1IjGY2W8tWsO4kCfqTkRt/5YCwp4a0yJrie0xgnTbyWz9Z4S8CFH584ypcQXnogjYHhTEQ22FAULpIslHGZypPpEZJnFE2smXzTgDOtft8=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (20.179.72.203) by
 BN8PR21MB1298.namprd21.prod.outlook.com (20.179.74.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.3; Fri, 9 Aug 2019 19:36:19 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4%9]) with mapi id 15.20.2157.001; Fri, 9 Aug 2019
 19:36:19 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "git log" does not display refs info when executed via C# Process
 class on Windows
Thread-Topic: "git log" does not display refs info when executed via C#
 Process class on Windows
Thread-Index: AdVO6XCnSWdcLXyxQQWtA59IuPRg6A==
Date:   Fri, 9 Aug 2019 19:36:19 +0000
Message-ID: <BN8PR21MB11569DAA8A677BF00113F683B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d5ebc92-1f82-431b-3049-08d71d00da32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR21MB1298;
x-ms-traffictypediagnostic: BN8PR21MB1298:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR21MB1298A3ACEAD9093E9EA3D36DB7D60@BN8PR21MB1298.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(478600001)(476003)(74316002)(1730700003)(55016002)(26005)(66066001)(66476007)(64756008)(66446008)(9686003)(4744005)(22452003)(5660300002)(76116006)(33656002)(66946007)(486006)(86362001)(316002)(8676002)(81156014)(305945005)(66556008)(8936002)(5640700003)(8990500004)(81166006)(53936002)(25786009)(2501003)(3846002)(52536014)(14454004)(99286004)(6436002)(6306002)(7696005)(6916009)(256004)(2906002)(71190400001)(6506007)(966005)(102836004)(10290500003)(186003)(7736002)(2351001)(71200400001)(10090500001)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1298;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7/sF26kWWz+ksy40PeM6gvx9pZdm/XwxIpgJedMNSi/vcnetwwjUlmt4W+OVtRvMzxkIWItrW3myq5P1x/PEThY/egU2XSkacJatHmyxbzG8oryvQRLWo/icgMjP1Fnv/vbGqPfJg6DoAjb4WJwPop/J0bymNl8oZxrsz5QsCiDFe4jFDFgk3vjhiaJpojYyZlpPUQqTSSffog1SVz3gEk1Rayfw0tvCmn5BBD6c+t5hVtU4WZAEMcFLeMiWuP4IL0B90wgVa4DDEukYEMo3udGQkuZJWn76LzRyzxNyMDQRAcUFG8g2UgMyhCDa/tMVA1w8iE1ZGt63JjeBLbJJzkGb8ZAfhvkNeetnRcT74iyblWrO9cAeC97ZP8u9EaS4qGMkSFlQRE8Sii4koeFFv31etNUa4IgWtbJ9E91xEkM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5ebc92-1f82-431b-3049-08d71d00da32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 19:36:19.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xO7JaAlLWD8ysPwM/PODjdMA8WCV3mImZQBMl+H7WuHbUHQW4IDRglUEdz9qDhIDZtqOlHYfYdsQ4IZw+XR8vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1298
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have an open Git for Windows issue here:
https://github.com/git-for-windows/git/issues/2285

"git log" works as expected from the command prompt.  But when I execute it=
 via C# Process class and read from Standard Output, the refs are missing.

Is anyone familiar with this issue?  Any idea why the output to CMD and STD=
OUT would be different?

Thanks,
Cliff

