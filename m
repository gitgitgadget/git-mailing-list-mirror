Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949B2356D8
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620216; cv=fail; b=NCrg9Q0fWkNbumVqZkB3651upSK7RIYabsdIl//ESGeSiVeRST8dscdoQsZ+27mx1NN1cnRmAviJ0uiypXwsHfhdya9YdmRLVIz+PEPQsIj5RY1mMa5LjmmfJQhYb0mNMoQPWDwjN/tWyixU1riJ9MlKZC/qNJMhRGOvIfDTtx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620216; c=relaxed/simple;
	bh=k6oePqLMyA61uEmLe1SpPKDbzJUHzMQtB+uMFpjtq+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zk3QnBovEG5HHfzDkP7SJRkzUN0rb0ApadE9Aps8qbqKaGTyjJaentLJsT8SVU423BKLZgSLpdV+1pQdhCD3oBpNKqsnYoT9c+d+LTghgcTcP3h/RMKICCHUkvS9KeHm/rHJESAYe9jZdlrqJQQzJ7IXSwy5ddD3AHGF/svlQPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=upQ5NWpa; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="upQ5NWpa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSrCrBRMyJthJmJURdm57FKzxoYpoWBwxmvN6YSkjVT2XUjxTR3hc+TzuwmEsFwIN4OLrs0pOWqjjt09fOAC27O9bE+mI4pqlZPyCDe5XidIjEQ6UQLEwfVscVihdsXPH7hCo0QpA6ZBP4TMbzcikYpDLdF8oPmy/D+BpwGOe6+Sj574IJCuD3GSEKoIZcag/cD9fgjT3uBgbRhjxs1Lso5okQhqdnKMjiSrcy2VktB7e7WAzG75mBvbAV1PHzs4VfSCH/ouvceK22GZPXPoL3FksnM9cBwZ3lQZlT5DUfnGV1Mf+7WtU5TAxE6HX8zCgGCOhwdLJ/gWyQFWPmlliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eixNMuMsUwD3Wz1AWE/H/JJsO/YmExJvd4l3Wjsb6MQ=;
 b=Q8YumkYV6AL/RNG0Tl7I7/gsHCoaCk67DkNw4gSqEOcvLybLF0kZWuN0KUHslDV71hBSXNpkBmKuNpeU5MPKOEkiDFqHSRCJruNdj0rN73SuRmjlB9LFbwo9jeCyEUZCZcfbCKHDGOSr3YYhdDmYZ2RvgTSLhU8Rvhn73USuQVGz+5q+MFxrmTnfZfuqHAL63X311fQGBM6yLUb09pyjtCVfGzsVjSujlAYZAcy+h7TozyGXbPFfaHL7y07ER4PowNQ+qVCMgnesjBPxqkvLM82mFQa8RC9NvOkokJUONZW6GVuKy9rsGnR78OGzfWVf69rcCnEWs9Rdls0G8hG2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eixNMuMsUwD3Wz1AWE/H/JJsO/YmExJvd4l3Wjsb6MQ=;
 b=upQ5NWpa5GXvMSL1sMV4oXSOTjpt3wwzBU9iFFaGS0/yYXDMT7/j2EnfgInDJY6s+hVqLVyv6FHqau2Zzkrsi1B0KzkqR67uvuTn0xWdcZm96JT600ppdqeNw99l4Kz2v7DSx5BgAJI7UR9MUx/q1YrrKLPypL7FGr1sts6//Muf7zUXUPPXQYTE7Zfjz/Pm1UWGSC28rIXSXUnftas7xfgvLjVUccDktxpsAY8AqGFd2FQcPj4uxHGftxkXZqa/IpJN3qfeJp6lRV9HvT7O/3uFXzujdrJCi4X/urHIMaZrM6erLnOQw9uqteelbFrL42+ppIiGkJj/TSgjqdWobQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 15:50:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 15:50:05 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>, Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 3/4] docs: remove credential helper links for emails from
 gitcredentials
Thread-Topic: [PATCH v7 3/4] docs: remove credential helper links for emails
 from gitcredentials
Thread-Index: AQHb0XqD0MJsNpNNl0OG72zw5mycvQ==
Date: Fri, 30 May 2025 15:50:05 +0000
Message-ID: <20250530154934.10077-4-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250530154934.10077-1-gargaditya08@live.com>
In-Reply-To: <20250530154934.10077-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6024:EE_
x-ms-office365-filtering-correlation-id: 6ccf761c-695f-47b7-12f0-08dd9f91a5f0
x-ms-exchange-slblob-mailprops:
 AlkLxVwsndlmbqnVVkeM2BobHaL9MaaalYSq1lQ4fPhkdJbBiP10uL5/cZ2H+1bDayqVijVywEbC8+UxaFWM96rXC7Em5yyypBMyyGj6SSBN6erFlEf0E8/rvIyTyvDaHDldBfPFsQATS8OigVRAN0+uSnMwTDUzX21lnSPm+f3PNZCXLtuzTG3Sx6lUBGgesmXwNVSO4+pkAI5Q9VVnQOoAlUsJTAwlpAAKg6rV5O/FOuOexN+MzcU6JkGcRrS+mMYaeVHI97+OkicegeP7QUGJLvPNtg5B8j42tnDLGGDUqcmV8Z739IOZ/4VN5sbcRDpbqVpGyXE2Gr0GtIGnod/hYYBv45Onax56kvTyboQN+xOXqVzY1ItLGlxjxPoKrXVv9KDmMDPm5aQde1FL7zpVvQGU5seLqsfEmUk6y8V0QAsdYxJn/inXG7xhzlZZccyDqDAJgY+Fd/AE1Voejy2UQnKvhvVinSvD91WWTE8Owl3dVF81WAfYtDyJgwAiAMzLGA0dCnsq0BnFrovVInzNH8ga+m/UhMV720ZOOXXDEtL3+xqUXdoT+ImCnOcyNYCyByBOW8jbppGIMuFX6K4mIf4m8xlL83y9tOti3WBmEfvjNQna+k+wEcoa8Dj8NMQgWlnikGAUeU6Ufi79yRw6U00BoCJcdIPdRsi7ETh1bhNl7SoeicQ7AD7akFnqO6p3rwIxxGvtPJBCM4Wd3d5afcMOJzFU2N7OdDJNr28QDJSJYp5lUqmRjOHFQCAHMgBobDW2At5wrvXhHtsCQWZywsufxYtz
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|19110799006|8060799009|8062599006|15080799009|1602099012|3412199025|4302099013|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5P3YDSnMHctpUF2GeE1wXOPYaWFqIaTYnunIrMKL3V+LFWflqlSOdpkVsG?=
 =?iso-8859-1?Q?QDLmNTtmtXNnBhHSrpIlhE7J03y/LHqH9BTtLa41YFd0nzb8DvS7gKjwOR?=
 =?iso-8859-1?Q?wz4IHQX7Au65gcbJQSFhsMXP4Qeg9MrnHRBumFgCNnHmVwfr5jCWyYuGv5?=
 =?iso-8859-1?Q?7bxGesMzxnPg9YVLfSW7u6JpsrRVpRp2MJ9w0j1aTgibvnmyAiSyADrbFk?=
 =?iso-8859-1?Q?7MR4Wo96NSTrDKTukLJF7xkKtBLHsahzw9ROP8Et6tyLsEcRTEC4hGuCH8?=
 =?iso-8859-1?Q?HwlAWyo3CYj0AkjL9UsE1wPYshWMJSwBi3Vj/lm9xpSvmHoQZmDGRCMctQ?=
 =?iso-8859-1?Q?ciHCehkqqiefQBFtYDAfYiz9D6wMQwR7AK29XQQsSspWbXRWcujtePCS/6?=
 =?iso-8859-1?Q?7W5FgHJ67Fk/xqYeseaGMcUGEAP1cmrxRLuv6hU0ojYqshvg/BaMeVs4Xx?=
 =?iso-8859-1?Q?PRBejGa01ghunnICARkfn+HCOTvY9r+nAE7NbYeL+LsI9/Ntk7ipG0eIjq?=
 =?iso-8859-1?Q?XfFtDBQZJ1BfrbGNKo2tBKRa+o3l7yheFPX27fvhMd0GTvUtJSFMyHElv/?=
 =?iso-8859-1?Q?tI3gTC7FZRo+lvhWoERb2RRoSfGhRIEFgUDQxg03QPsuCqVaNd+WfzysVQ?=
 =?iso-8859-1?Q?yb2ycRyxkSlS4qMGrpLgxPkqnlzjHRjVIhVv83q9CGMyPq60+gul2CVXNY?=
 =?iso-8859-1?Q?v44HI7POqUHK5WxeTHNWotTVopeHEsV+uj7zbxijYljvHGvLSYRtLDLea+?=
 =?iso-8859-1?Q?GmlRvCt5NZpsaStEv5gDLSf7oAqqm7YdJ5NzOmWIDf8FSEUXukj2gYOVMc?=
 =?iso-8859-1?Q?RtmKlT4nsF1gtlWOZcX1Cuqklv05IOrAB73VsJcjHRvFKAWDyZSw8k4uqP?=
 =?iso-8859-1?Q?OamArCkIsrEf2jfSM8gv1AcULyqZt1A7hI9BWYEDKDNZ3XFncwztye0Qq4?=
 =?iso-8859-1?Q?Irhb6keaj2eXQcr2/gVak4KEekQMNadKBMPcW388KXQOMvsNNTEPdRbpcY?=
 =?iso-8859-1?Q?ukrawg0j+dfcNaYL99/IvtbI/l8VO/164UNJQPkWw1Ze1g6S2lVlGCyxR6?=
 =?iso-8859-1?Q?ApEYZ++4/XDj9IkQqa5AouvFxOUj5m3jVJk5bXwHYPgeOLUEc9CzYqcRyb?=
 =?iso-8859-1?Q?6zK37iFbeWv8pyRPTXOUDplZ44MZLLeEJwWgT/39Esclpwh9GYUPMc7dLY?=
 =?iso-8859-1?Q?pWjnGCdJPtHQ26zMHa2MIIVgspQBk3hZKEvYJl31nFP35/uSJmMfmAKvZz?=
 =?iso-8859-1?Q?IT2GEkZS32MSh/twPbCg2KmvagsSwrJt+X9mWfqVmwn0nYLW9eglCPMxJD?=
 =?iso-8859-1?Q?q/6YrO8I8I5oaNmrx0IslH6KHg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EXUhBm2ZrrtnilzPi+ktt4l6VlcEIdSv4EEjSKjbL9rm7RZPQY0vX/2ycN?=
 =?iso-8859-1?Q?tlM3A275fPA3JQNObs3Wg/bcN0qsCDKOyDiuP6kZ3NppFg19Zqei8KAIbB?=
 =?iso-8859-1?Q?mDnoKF3aLHRnVjl3Ghg/M/z9zGRkZfdLbV8OR2iN4pgLvq0fDYz2ScL2lt?=
 =?iso-8859-1?Q?OLjoxyC6S5BgpCqkSFFqcxHs56BPZCdFfW6H7rFLYbP6LI9T0YyLAy0MqQ?=
 =?iso-8859-1?Q?PrqMsGF3hwqd573UGkUNw+MqQkxgHwTC2U+/mtU9mXS6shpACy6mSMcoyp?=
 =?iso-8859-1?Q?/DRmGQYZUWMvA90hpeSVsaekTAJzd2zkVsq+2PFQVnaVNfnQJutmcDptsW?=
 =?iso-8859-1?Q?01U7zCZ0FcWXYNERQ4vGc/futdsU49ctYgSixa8BTqdOYlWi+Ri7Q0NvNO?=
 =?iso-8859-1?Q?+MdMsC4hB53WXxI++Oh4MsxWaYWW/G1b/gqnX622V1G6J+MmsoHmvdGyzF?=
 =?iso-8859-1?Q?K0gOjH/WEZo+ntuMgCWFLhtarWGACGg8wy923IesHfLN9lNjqAAuJMnrEz?=
 =?iso-8859-1?Q?ft4Fdq6jkqcz+CkFjgGML0EpkNy7/Dbz/k9FxqYsbm3+7WDnQfMOk2DM9+?=
 =?iso-8859-1?Q?KI7FzQzU+qmA3jGIhCJbPkts+FPRkZTurthQ0vqpU4xawP2XpPpsjJa63J?=
 =?iso-8859-1?Q?2Ry1T0UoZHzhS7ErLObdmnADoxnQPIu6n6pfUo9lBqTCa4esjMRGRsZUhs?=
 =?iso-8859-1?Q?SnnOALYRr9OcZAidssC+/1MnfLadKxHgshsu+j5vyQuVI2p0ey20xkGPrF?=
 =?iso-8859-1?Q?jT5uTM+nHD1RBnAu7TnJd4GSsn1FVvQl7jI/lfokg64y7OuIrrezte23o5?=
 =?iso-8859-1?Q?yF3e/n7zli45DsnP9Bc2FXeGaUyIpfwH7ZooXVlOiBoAJ6tNEbSopgtB7z?=
 =?iso-8859-1?Q?URyhoNjmOqyhK53bqlP78fdX8aAZteBsw6YZSHbJORhBEUdZILPE2oB2x3?=
 =?iso-8859-1?Q?WrzleWNqC/rwNcAM5tKulQy7U1cxnAB94Uy7fpLHoxdd2GIqvZSzgUNId9?=
 =?iso-8859-1?Q?f3P/VO3DQVV2hkt0q8hrKNday9GuCuXzrv+smf/Dg377d53BBs6z7GK8PU?=
 =?iso-8859-1?Q?6+efRYZ9jWpJ7QkUN8Yd9ry1Y53vpCPIV0aT1IvcymMk2VBhFsOm0unL3+?=
 =?iso-8859-1?Q?hab9ndO6djpqeCvFZJjj6LOdnakIkC3zaSMRHEDfYW+OW9Q8xe6ZkSnkpV?=
 =?iso-8859-1?Q?bdJrb2zUeGa/A3BZwlJYdzsTWMLeEu+SA7/j0VZbv2ipAKdkHFKfjC2zO9?=
 =?iso-8859-1?Q?oIOxBQmMNXAsxAb1bpFOesTgB/+dCWgnx4fDvdoTM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccf761c-695f-47b7-12f0-08dd9f91a5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 15:50:05.9499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6024

In a recent attempt to add links of email helpers to git-scm.com [1], I
came to a conclusion that the links in the gitcredentials page are meant
for people needing credential helpers for cloning, fetching and pushing
repositories to remote hosts, and not sending emails. gitcredentials
docs don't even talk about send emails, thus confirming this view.

So, lets remove these links from the gitcredentials page. The links are
still available in the git-send-email documentation, which is the right
place for them.

[1]: https://github.com/git/git-scm.com/pull/2005

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentia=
ls.adoc
index b49923db02..3337bb475d 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,10 +133,6 @@ Popular helpers with OAuth support include:
=20
     - https://github.com/hickford/git-credential-oauth[git-credential-oaut=
h] (cross platform, included in many Linux distributions)
=20
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-g=
mail] (cross platform, dedicated helper to authenticate Gmail accounts for =
linkgit:git-send-email[1])
-
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-o=
utlook] (cross platform, dedicated helper to authenticate Microsoft Outlook=
 accounts for linkgit:git-send-email[1])
-
 CREDENTIAL CONTEXTS
 -------------------
=20
--=20
2.49.0.639.ge2dd5d9d81

