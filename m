Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020134.outbound.protection.outlook.com [52.101.188.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8E30C14A
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413519; cv=fail; b=Df1/yfO2+3aCANM7qTxvbxGaaj31sRLWgd0i7u9nZ/UZ99+Zb2vUnHfOh2ByFhEU7FL0dERc1GOCPpoc/6JMeg80qmjS5GFGZDTD9yixS6q7X/2mtvgwd7Hq1KRKmysVR8AGTYJovshMIp1qWm+BrHd4ATUfOlPUMgENqZK0WZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413519; c=relaxed/simple;
	bh=W8pN9nPwnD8+yULjjNnUkQCdxOaWcLGDp4F865Ot7h4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=elHr2LA13MR5okYHIpr4w3MP34pG4bqgWRe247GnUg/89SVvfeWGAWOfdNj+UcRme+qBzbsV+njuOTQ0hiR575NgXtNSiQ+4IAHdTB3xEReHhCTEAnSMTk6PFmG4W40y6AxIhvzocguPtlBvQszpjRooLCLsGSwbnEQFukxKpes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qualitasag.ch; spf=pass smtp.mailfrom=qualitasag.ch; dkim=pass (2048-bit key) header.d=qualitasag.ch header.i=@qualitasag.ch header.b=TMuLMg4y; arc=fail smtp.client-ip=52.101.188.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qualitasag.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualitasag.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualitasag.ch header.i=@qualitasag.ch header.b="TMuLMg4y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUsEmft5MqonwZgjojdY3j77TzFS7KKm0XpNjhjhsv1beUNbAmHNDfc8sJYhl7UPladztY2Q7mx7jc4sAiKl5cYN5hZoB3b6Pc9qgSLLVBkufXI28srBpExuuM+U+AbAE8A3zWkwafe+QHd5k6da5ywnmxeaFLXlK1Mm9vhKLs4jMVE6UoucL93yF+PyO+mN1KMctUjPOSLQZvF1JK4eyDv/8JzElkpgomJLFB9iTjYu75t/NpMsik165IhQN1s+2SuzTUHVoMnui/Mpj0fVGvkgLR22EvIgB3InbAGIWL7zLCz72KRfshWsQIkF7QkvJtoJ5Yn1L+drqGziF2h2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8pN9nPwnD8+yULjjNnUkQCdxOaWcLGDp4F865Ot7h4=;
 b=uUAyVKHN7cyXrFJTOA8agpg4dUGcAKJuf0XQPhKvgO0NGA+YZffYIjJmE4ZcK9/3kvkX4XTjDaVnWytT1Nul1UxfIp8pffLWfqWCnwQgNyyVrkjUTY1u0uMU8O3UIOl7Fikjmsyl6CKYMaQTS/D2P31f79dD44AuIvoAev47eA48rAQGccuRvB5TKWySFhmxyOGEj0kc6loboKpwYrAUJO7GwVc7eXGy9LEV3o/LebuM3kW1hzx6xYysIBISfow7JAo3rTCxykHx0spk3aBjXb2gAKx/kGWFBOGfHGBrPvznskJvrKIYkqui3Xgr5AYdH4qmyMtEOKdcLa9TdQesTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qualitasag.ch; dmarc=pass action=none
 header.from=qualitasag.ch; dkim=pass header.d=qualitasag.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualitasag.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8pN9nPwnD8+yULjjNnUkQCdxOaWcLGDp4F865Ot7h4=;
 b=TMuLMg4yPuoPK815jRBcYRaDlt8rMCWqSK+cEBZ7U/HzDXs78Vvv62kPX15te1QNVXuKcVmwEdQLhRgBuErQKHFAAaz7boM8CNpyK8yXdfgPU8Ud8/e7PI622UMerrix0eIt3Aha/OOMg/Ck5TDsHyDW3NO9AcL4nJ2wHW4KPIAHThK+aHO7zwqmv7pDQJWrDrTlCSeODsiW23AGnuE+OD69H3blZ13RxYQjN6AW8V0sEI/chWKPGXCTt19rTIB0IC76ojvCMuyMnDeIbtCJ2SlkNuxt/wM6r25elrLQqTpUIa5iyDvZdnommh8qE0jghpBgCtl3d62YAtF652+WEA==
Received: from ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:ae::14)
 by GV0P278MB1420.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 08:38:34 +0000
Received: from ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a07:bcc9:d6bf:cd99]) by ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a07:bcc9:d6bf:cd99%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 08:38:34 +0000
From: Berner Martin <martin.berner@qualitasag.ch>
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: CVE-2026-55200 libssh2
Thread-Topic: CVE-2026-55200 libssh2
Thread-Index: Ad0N6/53o/EQsu93S4KT/Zd4eDBGtA==
Date: Tue, 7 Jul 2026 08:38:34 +0000
Message-ID:
 <ZR5P278MB19814B2CA717210492C13A73F0F02@ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qualitasag.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR5P278MB1981:EE_|GV0P278MB1420:EE_
x-ms-office365-filtering-correlation-id: d7e6945d-444a-4b21-1bbd-08dedc0321df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 fT75hrZqenYbn/NauNnq46hOo9GihzLIjvS0ESS/m+tRNcnGNpDOsNVB0YA63ypfpLZOXGed7Z2qp8Gi17FC4Xky1P+bV9d+bGQURjIhvJDXPR3IuyPMZpvVwYbnU/t87KLfCtXavGaC18ttjt+RMSU2HeAqK6/jSomyNIUqnOHG4VZg5ZDGKPYQNjlOZUfVMHwYqobT4qRG3GJEU3Z3TsWG9FR9dCQn2QO13/pW+5NPpxZN7rentsfn6DAwzgbm6Br7whMSy7Gt/OdLqsavvgzfRC5yYSiaU9rkZkIaH9B0FhvyUGjK5Twjfz3UkLtqjmHylCHfsssWwyVf639xcy5vFeTmKERTtiCx7joY3mGE+jOm51L9/s0qOQ7+A0bT8ldjvu4Zwusfz88c3WehavoaEfrlGSkfL4/54IT+RYFPPTiBGQBmCEpiOGN8f+/9b7fod2oOM9QwSPg1FwSK3nbnncKnn3WeubgcJyLdT+IDw/2GRp5ubvmRIOkta2FnkZ/ERmR6x0KuxeLzV03tuNOXZvGb5AahD9bSs+cPwU+XUYDSot8HgvcRa/BWwrQB2oqFrPlNIBtud8gNriMC41puqRyS3jkqOmOURW/WFLPQNTtQLD0LtRSRDWkETtUozFLz1b8iIwCfoaysnIaLiSfgCSxVsdgHK/SFkQzIfWhiOb9H2tVpWnvgchI+DoRlSC8ERnuFVj5+xQ/MjMnwGhjKw6kt/5vVjgLk4wVS9k4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9UrVKPiDfhbravf358iHC05eOZrKcPsSv1LJKxvkBpe7MLWXaGwWgn2q8hfs?=
 =?us-ascii?Q?My5lu1lD21ysvhbPOdNXFIXDtbE5+bojK2rfAn6FLk7kqIWcRsonrL/6HNeX?=
 =?us-ascii?Q?knm6bKAHbEQWSzvvPqqcdXJjEbfEcpKD8G7sKQGlJftALWWCeYFqiTfvjCkp?=
 =?us-ascii?Q?cpn7gXanc7768HVJtIjdCPj7aFvZdxTEX1mZNT2Hso2CcEfwUqW5eAGgsh1D?=
 =?us-ascii?Q?tAWeV0gWZc1jgsph3E5lYckpfv6IkYDCFSFZ1pHC1fCoVo+SNa1kBaQv946p?=
 =?us-ascii?Q?n2mLy49pmb9IuoVmUKwQgkXglMP3NPZIdh+CuKhiSE5RPxfG4Sp9/J6sLyqg?=
 =?us-ascii?Q?Ta0hCtr+98HFZO63RdHXCNklDCaNyPKsd8UnwpoV7PGH0ufIonENVqVnJuxY?=
 =?us-ascii?Q?S1QNGt12MAtt4u1D7IY+sxLff8X66mEQSeIvyqWaAppkMmYgoS3mqQsfFVN3?=
 =?us-ascii?Q?kfuBJVKnEjrdIX6r5nzE6OYiO0Ir2a1BS9HwEBc6zyihvILKFvG9rSLP4aol?=
 =?us-ascii?Q?Tftzwyi8d3svNT9vy2vCEe7KUE2khEtdmSDThTYsewt2EnJhVsqeBfy1DXse?=
 =?us-ascii?Q?BZtiDYOzj+cu75auIpx5O3S8N9NIA59EQ/7sfWzfKOXdp2orv/YQR6a8Wr34?=
 =?us-ascii?Q?OhKd/yJJbyHrgY2D86rl3gJEkdAegJ51Co2NhSbVRI7gg9BoLNBZV2x1Zy2K?=
 =?us-ascii?Q?TSheIwYrrWiCuYQgzW67i6xoeJVkwAmebkASQdXoLMl8QJKuzdOoCDE9oQmw?=
 =?us-ascii?Q?fuSKwn2D1drC19yR6dBkrajbmVAwxV5IBTJ2GIrb14qQQJheP6LFiDuq5VUZ?=
 =?us-ascii?Q?9lF8E22jDkIMw/NEexh7YRqqa9ItilV27MBYn8OeO7yqc7UiORgx2v/m5hKf?=
 =?us-ascii?Q?fbFOvo7DofM+zQ5WbKM/NwPGnPxJmmhlwaXznmgDHNNh5QkYaZu9XS3nYJl8?=
 =?us-ascii?Q?O7JNN4iVskTHsAjslPqJNjCdTPws9JI7GgNf0v+RWY8fkCG74dCoufN8XAbo?=
 =?us-ascii?Q?F7CFBXX8taT1mHR+8SL4cnd/u3lwwxINhvpKTIBxSMzTW9DE2eQHc+npq7Wa?=
 =?us-ascii?Q?V5Onv+OZYC/bphRkNfsNCptznTulzhgbpaxF3qJR8w9FFFQTBvruqKB7WYbZ?=
 =?us-ascii?Q?+DFnhl5HnSiB2RsTNyLNAtS+rM0E5xdxB/1r+iP9vprxLcc9XQhnoOgli/RH?=
 =?us-ascii?Q?jLaj9mJWfpUMoYDZpBW/ujpLJNWGMaQd1tBMPzZScLFrxKNU9lYeciP10ppF?=
 =?us-ascii?Q?xQ4FE8Pb1OgaL3CxgRFMDzgnSs4IDAWAGlR8hn8d0BCvAgUngePDCbsMdy00?=
 =?us-ascii?Q?oshIL5eTtuUuzQ6gJMjy/ZeiNGj7EAZ7hOsrQoqHCy4or5TO5MDOmjSwcBLL?=
 =?us-ascii?Q?M9pYDcZqsfikm7JF6FlDW2OPMoHiOcVl6i5Ng96iKeCb/+anoRRA0nIdEkX7?=
 =?us-ascii?Q?BTf6Tqk1C40sqAViaGR7VfvYR2+FixKD+/aRS0g+3K/mbl3QFr6inSkDNXzN?=
 =?us-ascii?Q?Ukdpq7r4CyFtqhAL+Q+KXEuOlRLw2cxBNhN27lAje25mKEUarKDCXuMHmt3m?=
 =?us-ascii?Q?hF2RxITrSVq1uvQwbvGwce9FsABc7sLBkMTFdgBaUF0zWoZQnqblq5QxBwtU?=
 =?us-ascii?Q?1NH4E1RCUePWu1IzqWvXM/rsrmFMWzHTiI7IxDGHNQ/Yv+MeEr3rcrxYzKwi?=
 =?us-ascii?Q?yKAZINuGWOBODbxYC3luDlD20vZ0wW7mfZhGiBdqwELiCPeT3G97kwnDgevO?=
 =?us-ascii?Q?YmxkJ6H2tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qualitasag.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e6945d-444a-4b21-1bbd-08dedc0321df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 08:38:34.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf92dc3f-ac30-478d-836e-9628882ad7b4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CY1sRJkaPgcIas4Lq3B4SYW3nP0U5yGzyUTUMaPhHVsZW6I9lJ2KWRKgLop4jnHFt7Q1rbutRPuu8+MZ996fAcfvyZmvx/StqHlLD3iqi9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1420

Hello,
The libssh2 library appears to be relevant in the Git for Windows build. Gi=
t depends on libcurl, and libcurl in turn depends on libssh2.
However, even in the latest build, the version still appears to be 1.11.1, =
which I understand may be affected by vulnerability CVE-2026-55200.
Is that correct? If so, when can a patched build be expected?

Kind regards,
Martin Berner
