Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2120.outbound.protection.outlook.com [40.107.105.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33127640A
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405967; cv=fail; b=OJcDXLg0J6pHr1wl6ARNRZ/9gZZe+ptmYyzrhT4dGfqtpCCC6x/GaSYmeKLFoP3JZhPDB/aI6z3e+uyOUAkEKsg6zRTW+cmCa0EtM+5wl5hJC1xBg/gjckzXdq1CQYpTwnR5Z3BLXTHlliJTM2SV5n2snxKD/97ZWK9zi4Sa4QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405967; c=relaxed/simple;
	bh=h37ZwgBxdFTPVUdkD0VeewHMTFu4WHJQkSvrHjRMDSw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xjk4yCV9KFaaZZxhDo4N4AwT3FLb++KqCS0H3kTSbAqOrFvRGFAm8F2L6gPXv2jpbUBHV0O5O5iUNnPaKKfLNQ76OBUtfzsQfN2cYg0tsMRXB+DTNYMsskdKYm49OS4MoCk9gsbfX8wFSaAz4rL/WtfKQLkrLSyXpDlLFVnEwQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io; spf=pass smtp.mailfrom=qt.io; dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b=AaW9EEOY; arc=fail smtp.client-ip=40.107.105.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qt.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b="AaW9EEOY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C272htQabNTtAvDeN3d/4IrrW2XJ1SBn/KBX9ZxhdaCCfA0OPVVgNeeH9+BdVl8KUSXv64qHWPQGZ1ogxDTO4Xywf3XJGOeQD2sUpbr1cbi5bbh2+4PVFWENQORKNSyZHngkhxgimLt3Ej3OzSe2wm2gz0wJacuXKwH1gyCu8S3zKOUDcP1DadtRtZUuNlY0kr1zORYnZfufV2X2NBJerEz3N63O5rjzvbtHXR6a/lOWWY26Im+My8+d0w1+WkX1kuKehfgyHJC5yTwvP0fhKRgmoB/6EVqq/r68HN9q9SvHiYQPRcFbGHi69/GpoQCrb3Gl9YtwowEA4RL3Y2KBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe4oP25iPwf2Ang7T4uqk5O0FC4ywgWtzCQu1V9rQ0I=;
 b=ZTnpEBD9q/of9xzeHsuuxdH8+rEyJFjDdFs2Xzu+iosaVQxhE7e+GXPX3g9o7qBKY6Nd8UtZPxYbRDChUaJoRofbACtucJO5/YRP42Ph13q7yzFkRG1iZFi7Y6s9EnxwCIpgC1vCtLkiblhDUY90dD7tvl1VAduwKfNS4/3+TAAepH28D23YujsPzqHydrw5YACaD1MepIt6Fh70VHhy/3yxq2wjKDcCnTv9vrZ2rpdzJc6yAUjXv+QFQpGh0ZieQF2Dr9eG/CZsN5ib6XtnCL1OB512jrEmGoiRElSnM/KLK5eCvm6Lw78PVp25l0wmCZyKIM10M5nV5WsxWdZQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qt.io; dmarc=pass action=none header.from=qt.io; dkim=pass
 header.d=qt.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qt.io; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe4oP25iPwf2Ang7T4uqk5O0FC4ywgWtzCQu1V9rQ0I=;
 b=AaW9EEOY4525u7lgoNtIEP7XicrpTkExqGuKQOoMEfGuMwISbQvy8NL3UWftCaPJMckcqfRkoITvm5f9THwiVvFo+VGadeO/0Z1uozrroQgV2FK0XQsYyrUNPdfUoUNxXroJ6AATOXCoDUx/szfyI/n6ij/RcCYRxPmvdX+ap8E=
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com (2603:10a6:102:302::20)
 by PA4PR02MB7985.eurprd02.prod.outlook.com (2603:10a6:102:2a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 15:26:01 +0000
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::abe4:ff1b:74bd:48a1]) by PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::abe4:ff1b:74bd:48a1%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 15:26:00 +0000
From: Marcus Tillmanns <Marcus.Tillmanns@qt.io>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: Commit fails when no global email address is set even though
 --author is used
Thread-Topic: Bug: Commit fails when no global email address is set even
 though --author is used
Thread-Index: AQHaWqMfNcbnPvHYRkal1vOoKHDhhA==
Date: Thu, 8 Feb 2024 15:26:00 +0000
Message-ID: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qt.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR02MB9617:EE_|PA4PR02MB7985:EE_
x-ms-office365-filtering-correlation-id: 65d228dd-9973-4931-af30-08dc28ba419a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fx3CJoXCXo9dsEzOFijB5qwxqGOBLx+rDzyZ4vcpaVTctkBfVz+o7+xebe7x5DETFy/Al3/c0Ff66lwez5Kb3IJHpUjFuup7jkLApIIVnxac3xLhqPjzqWKd0dOfG37Cjt/k5Q7bNWCyYUycYf7ox/oXCwsartLUOC3LJw/NkXEYOFlM7y4WXGByVAyxu3/Brz8lpwpB490y3tNyVrii+g9KVus5ZNpM0KeCvoAC2Q72JkEPEKb8xC6pLdMMd2xwB3/52G8939RwtzShCXQGSNvnd0wtRKzDxTNQ6oTsYSBVOQaPhz7hrYRUss2/hapMd4fZFXwC+mKtor19McTUX7vyDV/tlLWLfjQucoUycp8nbINjyMx0iSrQjCCwhzfHQnv6slOXpdbHgbZrwUBm8U+cU1hjOyQPeQYn9vXt66PjeQGpHv1ZXCoWAM0bcEU0yaAepytDMTiVXXHpt3RMk1g8xGSXZ1+wAJB+jyemnp/7DRwwM/0Nr8NHIhCeJnpXf+reG5BL4h84jLLUPatpUlLWDr3KZMp/fZNjSzKAadms5rNbMruBe3ZAThQka/QzhzDAf4d9B7QxkPtrVu886K/1i962pHleZYC+grjUx8kJmpx1nxSdPcPJNxovicbb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9617.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(366004)(346002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(5660300002)(41300700001)(8936002)(8676002)(83380400001)(86362001)(38070700009)(36756003)(66946007)(33656002)(2616005)(66476007)(76116006)(26005)(71200400001)(6506007)(66446008)(38100700002)(122000001)(6486002)(316002)(66556008)(64756008)(6916009)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D87OkoLBwCCKKA6hilcvuTUeUliKz6PGarw07AtMCGikGqPeWwEAzsyXyndA?=
 =?us-ascii?Q?DZxz07U8SHXGFnRYbx48h/HqzpA6Zjr4Sx4n+eLCcPqIZRmkIDt7FZMEko+U?=
 =?us-ascii?Q?cGeQHYGQ2fUFCT7n7D6XA7y/PW0wY5rWFsoYoKIDVPlxjiBkpP1C2EVDh5JN?=
 =?us-ascii?Q?ZhI0U5J02mZat1v0zVNU7nnDSM/rDIfjKAnSupYKlsMazs/pE4olxb7tHe8x?=
 =?us-ascii?Q?oRxFu8kM728Z4aNXv6brTQi6Vy0YIDA7hW8NKVwC/53YKzpsy7yGHOrycdJb?=
 =?us-ascii?Q?kOSOHFaILAN30S50Lo6vNNl24pJsKozy2dFoCXDb5fOC5OX/tJDlkf+X4Y5q?=
 =?us-ascii?Q?ZhV66yieTT49YkKV85eqwGdg0/BCj2Z6QKkx/WwNV2/P63LM4KrhKs0kTiHG?=
 =?us-ascii?Q?eBv4OZ+XY34MB/wS7T+he/Q9nYGJKNQNT/mXPiswCTvrZrguYAzFmhsAhudR?=
 =?us-ascii?Q?P3u6WwdAPr/aGIyWAX97Xw78FpLziKWGK5VGeP13s+uCFUOy4OVqxebeqU63?=
 =?us-ascii?Q?SIR4nu2nqzT0DU6j8A8qa8BS4eXBjfZJp6ROmClZk1yDUr5FthNa5H87J5nw?=
 =?us-ascii?Q?2kiKpVgdOnjtlXJ6e732tI87GaQkGYdm9wIQDk9MnAbBdymfDGBBrGblKXfO?=
 =?us-ascii?Q?1+2njsXMfy83VWRtYGJQBO8Yq4YdvGCR8/MZXRyA8IhlUulitwJH67M+vuWQ?=
 =?us-ascii?Q?pxE0vw201FCOxhvSn2uDXUpYrCw0j64lnkOHqMNoKdRmCpZHiWKRMXmYqjRw?=
 =?us-ascii?Q?fdYTSKt1lJTO7zZKLf56Htkk0RtMmVhAn7HhfLNlBAlpGXmf83ZrHGBVQVJK?=
 =?us-ascii?Q?/4HgnOJcYdXJFpoQjCshVdRQAkxYA0lWvqoSdYxcaG4dZm7RD/EWgZjTok5I?=
 =?us-ascii?Q?uy5yHESR1ShsdDU0STey9b44AahVkmnEMs453f4c0ifCxj+CdlsFqYZNg1mh?=
 =?us-ascii?Q?FM4JNylvAvhXPr+Yc9Uy5HPLai5+g+uYFw16eUCe9b424An1Pzfo2MP38/Ye?=
 =?us-ascii?Q?LGV4nh/CjyK1GYoSdb8Psfh/zVPisyCVuweJhvM49fOmBaJXWQ0lku3DSJ8X?=
 =?us-ascii?Q?xinhfVgcPYX71aPIcSpWdtzJQoESO5jmYMfWpa54kiPeoMeQX2bTyypzkgqI?=
 =?us-ascii?Q?f8CMxmiPO5bP5KV8MheKOHguvguQmrVGaeIXnQSeU7SBtlATG44m0dQzKuNt?=
 =?us-ascii?Q?vBknY/RhiMtptN4VbgcjeItXidC8pdjNPE8jE5ZgqIKFi3JZuQn2Jsy6f8Ws?=
 =?us-ascii?Q?JuDPJbMsa+7T3FPos8lwYuy1e91MgtL0R8IvG0EURW+yag4I9MeD/kRXa0K3?=
 =?us-ascii?Q?0x7vj2US49nqzGc67mqSC3P/H7ECKUwkUFf3Eas3uF9GnRvvLdmL9bTqCQVf?=
 =?us-ascii?Q?TPr7BcqiRNFnS1agUqczRuiTbj4Iz9CF6Ck68BtOKhbOUV0wsn5Vppea76Cp?=
 =?us-ascii?Q?TrhDKFKWqecF8qxWMwL0AjlocKsdc+LLp/p6HVLp2vdRStL0Fw3ZP5us49Sm?=
 =?us-ascii?Q?M1zF/vd/RUsZC9AkNa2BlTsxxaJ8b05T+mcUrxsQnou9Mtx7xCdwUjtisvA6?=
 =?us-ascii?Q?TQ/J/Iwkio9CmE+mjLhd+7R1yhjy3mvDjrRmkirpw7Gq4/qc8QWsrsMeXjkJ?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36631DF1C92CB548858B6F9AC36DBA57@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9617.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d228dd-9973-4931-af30-08dc28ba419a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 15:26:00.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gZBPtspzZkc8LNi2CYrWDyrZNEiIIkSMHGjvGZoCoTyKaVLrEGTH1sWyjO6eLvmSOYoRvxqBy2rUFVLBWjSug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7985

What did you do before the bug happened? (Steps to reproduce your issue)

* Set your machines hostname to a name that does not contain "." (e.g. "iha=
venodotinmyhostname")
* Make sure you have no name or email configured in your global git config
* Create a new repository and "git add" a file
* Run: git commit -m "Test" --author "My Name <my@email.com>"

What did you expect to happen? (Expected behavior)

A commit should be created with author name "My Name", and author email "my=
@email.com"

What happened instead? (Actual behavior)

An error is thrown, complaining about not being able to determine the email=
 address

What's different between what you expected and what actually happened?

The email should have been taken from the "--author" argument, but instead =
the commit failed.

Anything else you want to add:

This does not happen if your hostname contains a ".", e.g. "myhostname.loca=
l"

[System Info]
git version:
git version 2.40.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-15-generic #15-Ubuntu SMP PREEMPT_DYNAMIC Tue Jan  9 17:=
03:36 UTC 2024 x86_64
compiler info: gnuc: 12.3
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /bin/bash=
