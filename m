Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F22202BB
	for <e@80x24.org>; Sat, 16 Mar 2019 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCPBho (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 21:37:44 -0400
Received: from au-smtp-delivery-112.mimecast.com ([180.189.28.112]:29258 "EHLO
        au-smtp-delivery-112.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbfCPBho (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Mar 2019 21:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=griffithuni.edu.au; s=mimecast20181013; t=1552700261; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding:in-reply-to: references; bh=0h7esoAi44Tu01ZVE8o24NJ8/S3RDpX+e/FIjG5omho=; b=WVevcsgbuGE7AUqeqozzN48yUDch5jPUqQ6LWZRbjjNu6vkJ9X9SzoUN0yUR6q8YKZ2qE3afALUlCR6T1d5NdikLeJEjgKjAbIFZY32SOyQUOGc8dk++ilNhoCNHlA4yrhdFQVLJkGrwzfG4TZhGFwh+XneMWaSmbysJGehlLNs=
Received: from AUS01-ME1-obe.outbound.protection.outlook.com
 (mail-me1aus01lp2058.outbound.protection.outlook.com [104.47.116.58])
 (Using TLS) by relay.mimecast.com with ESMTP id
 au-mta-19-Atmrfa4TNACZWtUO_74eGw-1; Sat, 16 Mar 2019 12:37:40 +1100
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com (10.169.178.15) by
 SYXPR01MB0830.ausprd01.prod.outlook.com (10.169.177.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Sat, 16 Mar 2019 01:37:39 +0000
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67]) by SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67%5]) with mapi id 15.20.1686.021; Sat, 16 Mar 2019
 01:37:39 +0000
From:   Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: protect .git folder/files from grep/sed commands
Thread-Topic: protect .git folder/files from grep/sed commands
Thread-Index: AQHU25jWfU9yUeneB0aW4S1ZOjW1Mg==
Date:   Sat, 16 Mar 2019 01:37:39 +0000
Message-ID: <SYXPR01MB09574FEB4E6D6476B4F1D155DD450@SYXPR01MB0957.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [1.132.104.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69865c60-7260-4120-7a0d-08d6a9aff9bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SYXPR01MB0830;
x-ms-traffictypediagnostic: SYXPR01MB0830:
x-microsoft-antispam-prvs: <SYXPR01MB083043A4D8BA71CEFF622EA7DD450@SYXPR01MB0830.ausprd01.prod.outlook.com>
x-forefront-prvs: 09781D4C35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39850400004)(199004)(189003)(97736004)(8676002)(1730700003)(6916009)(7736002)(66066001)(6506007)(86362001)(305945005)(81166006)(74316002)(476003)(14454004)(81156014)(102836004)(14444005)(52536014)(33656002)(2906002)(256004)(44832011)(88552002)(486006)(2351001)(5640700003)(105586002)(106356001)(71200400001)(55016002)(53936002)(6436002)(7696005)(74482002)(25786009)(99286004)(2501003)(478600001)(316002)(786003)(6116002)(71190400001)(4744005)(26005)(186003)(9686003)(68736007)(8936002)(5660300002)(3846002)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:SYXPR01MB0830;H:SYXPR01MB0957.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x45YurbTe5bB1YN+Z7LRkBtK7v+VQ9fkQl8bFzxXAZ+wr2mCpqvwLbpWBQT7+xN5Tkuz7BPg4WKp7yCZjUBCAQM4dKrql0U/GT/nC1XkfgNRTW1Ak4wS+alNT5oD6H0moxk2qHKJdGvAqOeQfYPE89pwWWBBlPqo09j2pOn8PzYav3Tm4lTYYI24dGMCA58FSsyufQVzZgl+jOOTCsBugxXVEzeQN6Jw1jKlhWFLxBODUl3JZdZ9DeCjqZD1iCRkGBDgXzyIwPjaEaHfHyydfaJPCgaSRT1WAuFftBmjN5zJfhozqapIQOg+m7MxDlvrfogpnuZD7IZbhD7mUdWBd9TOOCK+snDxEYG0ZhRouU0L0QOvqn4PXkkSgOExeRhT3a+sdHcsV1EYaEN9xqekKr/f+iRGL+mwRPsuJSMyipk=
MIME-Version: 1.0
X-OriginatorOrg: griffithuni.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 69865c60-7260-4120-7a0d-08d6a9aff9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2019 01:37:39.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a7cc8ab-a4dc-4f9b-bf60-66714049ad62
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB0830
X-MC-Unique: Atmrfa4TNACZWtUO_74eGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing global changes in a project/tree using a command like:=0A=
=0Agrep -r "search" | xargs -I {} sed -i '' s/search/replace/g=0A=0Athere e=
xists the possibility that this command will alter data in .git=0Afolder.  =
Using GNU grep, it is possible to use --exclude '/.*"' to avoid=0Athe .git =
folder, but this flag is not available on BSD grep (i.e. MacOS).=0A=0AMaybe=
 git and the .git folder within a repository should be configured=0Ato use =
a separate user account, and then the .git folder would have its=0Apermissi=
ons set to 600?=0A=0A

