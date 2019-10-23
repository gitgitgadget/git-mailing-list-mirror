Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504A31F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 07:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbfJWHWQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 03:22:16 -0400
Received: from mail-eopbgr40095.outbound.protection.outlook.com ([40.107.4.95]:43054
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731524AbfJWHWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 03:22:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzRD+dOxm3dsmNiXRSHu372fHyuZNNbzlyBe7S7qgxaclp/+Vj4p3yKVLMrb5Yob+cGJ7tbVL+m1hAl9+iwASmUrxT5+XcAvEfVzBRJz9T5QJhjF9Ytg7AjiIJTugtpE7Wf1ozDnaI63zPwR00HVEXmFDRfSkkucY9+ZzL9tnwCh8n9vdI0OStPZOwxIqVGljkeS9Hkj21DqqZQrjSpFjOyPXLGOzvLPDU/V8Nfs98qvoXO0H7Iylhvv9tlyZ5m/jbraF05olELF3redKRoLMxVxI027FA2oiM1Yc/QDsg9rlVzOoO0KvVxO6VE3lPXIuqlg6uEhWj6zgbdvJagsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6X1/oLepWAI5dJKo/km94nQ0qCcBIhf34F9xYxZWxQ=;
 b=OlB4+w4NNk7GdRGN9MM+xIDwRO4L+p7Zk4RBwxFU1IJxIQ6JWyqHoBZqwvSnCRzgB5sldJbxy++3FF0N2bw2/f5Co0YaXE34B+zwsKqBJ2qMNjwlKV8w0iciPVyGfCmeStE0R+bSoTdGz/kH8QkLHXFk3+zAUV+mWP0eONkPiIseV7DL7ejd4fsZ7OxX8oVauu75Ctm+f0oxqgl5+eLI9Q6jggHtLiJwvpHOvaam8KzAqlWWgR8k3ZpHn0Njx/RvjW6T3gd9u8RqSA1h5UAnT78bxkVi5W41McFj9vWqq0ly0nPVHyjXGS51W0JY9OI+3WHfd/NAWQF2POrMBox7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plesk.com; dmarc=pass action=none header.from=plesk.com;
 dkim=pass header.d=plesk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plesk.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6X1/oLepWAI5dJKo/km94nQ0qCcBIhf34F9xYxZWxQ=;
 b=CYaW6JscYS8rHhJrr0BgjrZlt/F7xz3/3tMpFykJO36Os8qzoTYBMTJLtukYZNOL/0Ff0InGrDvg7aflH2LHECsTejc/CERgsNw7E6T5fTlSy2aU2KWRIO4YF6Zmcq+iyZYIPRubJplBumO5GMbDgm4V5vfxD1El/U6o2AjQOIk=
Received: from AM5PR0902MB1953.eurprd09.prod.outlook.com (10.167.171.158) by
 AM5PR0902MB1956.eurprd09.prod.outlook.com (10.167.169.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 23 Oct 2019 07:22:12 +0000
Received: from AM5PR0902MB1953.eurprd09.prod.outlook.com
 ([fe80::19d1:d2a3:fade:66a5]) by AM5PR0902MB1953.eurprd09.prod.outlook.com
 ([fe80::19d1:d2a3:fade:66a5%7]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 07:22:12 +0000
From:   Aleksey Mikhaylov <almikhailov@plesk.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Issue: "Could not access submodule" error when pulling recursively
 with Git 2.22.0 
Thread-Topic: Issue: "Could not access submodule" error when pulling
 recursively with Git 2.22.0 
Thread-Index: AdWJcVhQE9Rw6FTOSmSDwHQXlfdo7w==
Date:   Wed, 23 Oct 2019 07:22:12 +0000
Message-ID: <AM5PR0902MB1953988602B657C3D0BB9B17A36B0@AM5PR0902MB1953.eurprd09.prod.outlook.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=almikhailov@plesk.com; 
x-originating-ip: [91.204.24.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bea2983e-0c55-4b81-75ba-08d75789b932
x-ms-traffictypediagnostic: AM5PR0902MB1956:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <AM5PR0902MB195644C31F5A5BFA1521D5AFA36B0@AM5PR0902MB1956.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(366004)(136003)(396003)(376002)(199004)(189003)(2906002)(7696005)(316002)(66066001)(66476007)(2501003)(99286004)(76116006)(9686003)(66556008)(66446008)(66946007)(64756008)(86362001)(186003)(6306002)(2351001)(4743002)(52536014)(25786009)(5660300002)(256004)(476003)(5640700003)(81156014)(1730700003)(55016002)(81166006)(8676002)(6506007)(478600001)(14444005)(6916009)(966005)(26005)(14454004)(8936002)(71190400001)(6436002)(6116002)(33656002)(71200400001)(486006)(74316002)(7736002)(305945005)(102836004)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0902MB1956;H:AM5PR0902MB1953.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: plesk.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lzy5XTxOHN+QLCiNO/uUsS2dxi2f2hrVl3IbiJHpducwRueos4cPPMjhackZJOZgcgSjN9+vItE+hP86avIe+dOANSdK0Z0+7EH9Ff0PpmUGpMTh2ZUwZhlG3+vIGlzLnBOSN3wXtO5880ziKYq1375/kPShmp3t5xvI93d+j/4/9Gvol/D/WV+jXoiCCXzLq+MXiRxf3N92zFaMt76LthBN8n8bstx/SNvWVZa31PB8L3tega5JKakKxHCvl3qcZ8acB+D7tzL+UUAfDu+6aTf+z9mac4NDYruUdWjXR4acGKV5aNMHbcPvyXpDQ7ZTEYuVOmtPDozWaX/7Su3lJATx0FsXyt8KmkQe2wqmsMLqUAt23MtnqLXInisjUymP/4+FfHszORLKB5dbSOx7W+KBW8Gyo6CwmySlyyzCzQWtejYHkSi9C4oGBoUgAYVBECHi/m7fadk3fq0gWrKxCOpkXiDLuZeZEDRI+4jxQIk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plesk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea2983e-0c55-4b81-75ba-08d75789b932
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 07:22:12.4113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6dc7ca87-6797-4cec-b9b8-de8a083e7dc8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vGk5myx0nfYlAMbeo4zxwakYwXxke24q5r5V2yGCVaWuCqFnh/VJp11MmIlIUyeNQAr1X/+GyLQ6jHPzT235A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0902MB1956
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PROBLEM DESCRIPTION

"Could not access submodule" error when pulling recursively with Git 2.22.0=
.
This issue causes if there is submodule in submodule.

At first, we reported this problem for Git for Windows:
https://github.com/git-for-windows/git/issues/2361
But we received the answer that it was reproduced on Linux too.

Also, the same problem is described here:=20
https://gitlab.com/gitlab-org/gitlab/issues/27287

STEPS TO REPRODUCE

Please use my simple test repository to reproduce the problem:
https://github.com/agmikhailov/example2361.git

It is just an empty repository with one submodule (https://github.com/agmik=
hailov/example2361M1.git)=20
and one submodule of submodule (https://github.com/agmikhailov/example2361M=
2.git):

git clone https://github.com/agmikhailov/example2361.git
cd example2361/
git submodule init
git submodule update
git pull --recurse-submodules=3Dtrue

ACTUAL RESULT

"git --recurse-submodules=3Dtrue" command fails with message "Could not acc=
ess submodule":

$ git --recurse-submodules=3Dtrue
Fetching submodule example2361M1
Could not access submodule 'example2361M2'

EXPECTED RESULT

All submodules are successfully updated by "git --recurse-submodules=3Dtrue=
" command.

ADDITIONAL INFORMATION

Git version 2.20.1 does not have this problem.=20
So we had to downgrade Git to work with submodules.

Best regards,
--
Aleksey

