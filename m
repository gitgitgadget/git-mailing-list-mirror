Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B8F144025
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280521; cv=fail; b=TGPZjcbTaBliTyU5wQz62CBjPbkXOQOO76m2R4MmYSzwBJSZaTb019Jd382Iqz30a240BL4ksaFqHN1zjppPyV6v/hgbfquVb6zXLcQu/yHOFf0khuOmLvm4RGd9WV+lILiUYmLWXfQgRkA+ATuxOA7VfWQYlyaLO2kuCkRNFGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280521; c=relaxed/simple;
	bh=gojP5vA7Z4H0VFQYjS3sVKnqZOPIGEFMPUvVjO6S1c8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=shn01/w+lr8x2KwgGyeBTciSc7QEFm3MuobGz09icsVxPUPwW3PVE/pSE0Hc3x1qW465G20vy6ejJi85kyY7wRBhEkDipPVj8OT7GudTnc/wsPRhFSCBXbybLyAQIZio+XAD/F605MWhvh5RC9gCpF1tEcitrygseyXjYs/u/8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=T1fHXfg8; arc=fail smtp.client-ip=40.107.93.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="T1fHXfg8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm6PXsp6jFiePFeiv0sBTcMddxrHx8K8WYcr7Mo3kAK37OjQjpw9c39+/b1x7so9z4gseA/e2fRmAXrg3I46QRnJNF6GfQzYC+vWfl0mZ6pEtK505oG/dW5XaIVkoAzCRx5if9kEjTzsz+KEIZPUgyTr20Ky+BVoKEQLh3AJUQREz4ci1GNRglAQ+DsRicfkT842Rg8PDttX3kYXPh/3v+rukkOTUvfewV5xXHvJZk3rX1YzmO0psCw3yJ5ae+9EBNfpn1VtryeN3bAMAs7i8Jec3UJAAUhjGYzAw4ApfCfv9KrD7gu5qPKBuN/hIUBAdsDLdFOFelBMQWue+p0yPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGSg0Usl5azqSS/MQKcV40EYs0KkGWOL5Hm++3LJcW4=;
 b=awRK8jI2trjZE9WWLrA+2c3RPz9NQ9+Fj80l1trsvMxKoy26RORnr7ISMglHtbiYAjA5Bpa/v2APQ2+Wh9Sq1sHZtJuefy+TCji90/7nnbktNU+COytJww987eOLpN8DQMvznnyj6aAyT/rsuIv0OPriNY6yon1JIu9w3rMScr3v1+We4D7mD0xHMuP8rF8t6FV9iYrr47k7f5BcRSeb/L3YX/huojYKZHVVQmFHcdXVRtG9eHs3GX1iQwQCENDFDEXS/F/6RX4CqXafBw/dqJzyWN+0MfKUvMOLzwwYongdEc5rqVg05LIY57GPiIfllbr38fwXcWDpLF1aD0S5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGSg0Usl5azqSS/MQKcV40EYs0KkGWOL5Hm++3LJcW4=;
 b=T1fHXfg88xNnzLesTdxBxPDuBUe7ZGdsbjneCw96uoSt2WxR02CZ2mwH+dsiylK0F0kC9CRhXUY+bYVpeSByoWAg5DsTunuqyrCrfKknutFjXBVd0vzDOBoKNMBif4pY/ErD4OAz9PPoaCbknnSkMx47iQZVo0RHlS1POMHXrsvfIEUCM0qerk+DO0GgaaM2du5pUY5T2jp95aA1o2sLRSodRfqkzAfriWVuQlA2Dqqw/v1uzzOwCYKZjIIvwizLJH3H9WhLzY0OTE0NY7X5VhezoFJf2n166f9UIfsSPyrMtvEVRKGA+5D19lTWSq2xmRFYMWU1VQJKyVgSbq8Lfw==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by SJ0PR14MB4252.namprd14.prod.outlook.com (2603:10b6:a03:2eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 21:55:18 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 21:55:18 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Christopher Lindee <christopher.lindee@webpros.com>
Subject: [PATCH 2/2] Add transport message for up-to-date references
Thread-Topic: [PATCH 2/2] Add transport message for up-to-date references
Thread-Index: AQHadMfJU4Kb2lPtQEKMVlla3PY73A==
Date: Tue, 12 Mar 2024 21:55:18 +0000
Message-ID:
 <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|SJ0PR14MB4252:EE_
x-ms-office365-filtering-correlation-id: c535a81d-b07f-45f3-8d50-08dc42df1b59
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J4f94mCaarZ2mwgVVoFZg09aJSuR09L9qNFEuo54L8lm/dtPlV5FD5qxHQ1+jKVjnLgHLKnYXXKqGP00rOh63oB97timOG/5nR48SRO++yPzLQGT+XvbOvypi6Kq1Ed+YE3P2iHV8+rpeDYtxgJKi4c++4Z18x5HrhXrqqG5IT4XqERxYlce2CBvz0ezVfrCkUhJicKhoOw6WBs2UIWXdk403LZpy/qfX74g5C6l2ppFU4EAQxRLcsaT9grzbD/4TsMRSNq0g3A/Lr8V90LVi77kTtLadTmX0z2Nbb3o1f1uAuG4xJaji04M0qWLQiHqvIMvgHLeXsQ3ThfvP69hGKtmoXlOe+xlpVEiXzwwuBrJruCPsP8Zn6hV7znGTK1XVail5Xp+ph7GFrpTNW1vbieJip9u09mcKhXBK5nyPf/3ky9hFRDF0GbWDwrYsEfQwDZ4X5zR1Sze3+CNHK39WrlBCsgFYgPWJltk46T7fw8r0bApkqgSZwXG+fvm+Nkc+bcETK5kbAM+0XI+VF9hjsJI/+4Uz0lB43vatxSIe3vxl/WbsBfhhOUiLlU3F13ZFVsJzXDCUGRyZycsJGzgM9EXSK78Hj4ddGG+xhjOSei71v83sIh+qiW2J/kZ+LbTE+rYE2yxjIjEuBO00+EpVSvdsY0doZryknhMikQjtHna1cGcztRsRsKwC9AniFaZxm6MVHXdDssKIi5x+OPMfQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vRYZAOSp4AFx0wU5uKb8N4NqouAhJCslKAM7+HVYzQN3B/nfUUVE/ilRkl?=
 =?iso-8859-1?Q?YN2dFy/WIbx63N4kekHkaXDL4zQ+VvZMhQ3+3HwXlnHMZFqluJBvne5pSQ?=
 =?iso-8859-1?Q?+gYeLkZsFscuWygDAN9968TMIKSzuMXbn0RTac20len1XWhHesgJeqF2UH?=
 =?iso-8859-1?Q?99eGcRMb7gR45DUzYUhxvUk6TvBIVpvRm2tEqRyc0tce9AQ9VhYY33ypPo?=
 =?iso-8859-1?Q?KKP3hI1zba3Kl9NSADlAkp/yNBqBXfLCphSYZAsQ/QbskHbx3jfygWnOb0?=
 =?iso-8859-1?Q?nwv5qdUDk8e6Na/3CzrkV5NMSTHK4rxkp4qpvnw0WzVlByU52wuhFzSuu4?=
 =?iso-8859-1?Q?Gb1wQFgukVjoGmZpMApuP8aJzQqD5h3/s5R88s4d7sSBvS0wyWYvCP2Nkr?=
 =?iso-8859-1?Q?eYQt4Qd3Z3mHG7pQIoUbuOJ0TvCdR2GV7Pv3uJpbpPZ8reqvEBz88o9vOn?=
 =?iso-8859-1?Q?n6+KviVmYaChOozFIKQwtJrUpv+pPRTcIEqcNUiAt1w3QDS1Crfiq+Fb11?=
 =?iso-8859-1?Q?c+hTrj8N7nX4EF6yMJYgfpwRK/G8Cc9AlNJRhL3XI2OqpNDnBlKu3ykgg4?=
 =?iso-8859-1?Q?za8tgpu96ZCOU7hbV27I8EYIZ5ROCJStq5KMHHnOkxQZgYBrvHKLyPPRJg?=
 =?iso-8859-1?Q?mzsYeCGfvISnwcaTRyowyFCegJ9V/PNHnGEcj3masXKPJwEs2ffy0GvAOI?=
 =?iso-8859-1?Q?EBtb8ZEbN/JIfeQycSWdCiIyFrYjZZ+XcXZcThwB5rXUxrIbvBjZoSWL3L?=
 =?iso-8859-1?Q?6enW4+zXZnAmQRBGUxMvN8QrH/B11VQli8JzScvXHvWN3hKYpgv84csOSn?=
 =?iso-8859-1?Q?jFMk4gebbAQlQJmsfvUyM6Xu49Joc9M5ZWZRGn9DnyCO5fGzeJGOKX7ZID?=
 =?iso-8859-1?Q?hs6nJ8QwZcd7f8vZ2o7hXEIp+STIgoMAf/t5nPHzI09+zopYwRD62sEwB2?=
 =?iso-8859-1?Q?e8eFq0TnRvQo82E6m8v5vQs3D1CTa1jA5VudC2qLMohXyf48kQqQfOWe4U?=
 =?iso-8859-1?Q?xaZ8JobRUIhUvQ+lu/XOIbV3QUnkXhlBK3qZGXi3DE0vr11U5NKMoYHCD5?=
 =?iso-8859-1?Q?L6lQNt3CNFNjR5VdiIupDxg0BRXBe0/L5/XTL5pOkhCJjUdq1jS+Lhs3Cd?=
 =?iso-8859-1?Q?aH6R7pEN8JQdDnDp1W12K1RxP6V5SSm4ZA9Q30vYR6963EN3OwF3h59Rqd?=
 =?iso-8859-1?Q?rqS7zaW2nnnshNvHWVVQlK1q4QVKvEVOgDlRnqHj+OvrY7iZQoAFIW2xiW?=
 =?iso-8859-1?Q?eo1+3XI7/9NcC96wPj+n5qbm7ixgpfKTWIDOaFOzFb8LYKypMeulbjyBz8?=
 =?iso-8859-1?Q?QZJr3fKz8e0qI/IOw5+9k7GWTpALKuxJ6Bz6UoR0sUVe0UZeUE2shBQlX3?=
 =?iso-8859-1?Q?8dOOAihoO1LNacR69EpzIIMTbI/IniL2zGO0r2SXZt9wfczBjsQcwEmQfd?=
 =?iso-8859-1?Q?xaMFbpOARoMCMTyzOh4yMRCymuInRTdJq/RKVYzG2fWbimHmbAwkVASm/P?=
 =?iso-8859-1?Q?KCAnQMRJU5OVcvIqmkBlLAuD8sN8E1F1wkGbm6CZ+Fv2HokExyHdZc7HhX?=
 =?iso-8859-1?Q?Fuwu+jiqtSgxMcjznkABgbggw5hh4dvQITbgcavzA48edPjmvSIhNdiZ2M?=
 =?iso-8859-1?Q?e3kKqf/cSrQU38dYkY4cwwj5nuc+GTLxni8gn0i5a+Y3Kiial16xpnaw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: webpros.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR14MB4691.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c535a81d-b07f-45f3-8d50-08dc42df1b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 21:55:18.3528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4D488vWCMETZA+/lcjN2AdfukuiDPWB+6Tjfx2bDAR5lWemaCFdLUMcDh3a9rtREz7m822xtyyE5CVPnnVLGYtTNlZODkcsoOR+urcN+0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4252

If the `--send-up-to-date` option in the previous commit is used, the=0A=
"Everything up-to-date!" message will never appear, even if all of the=0A=
refs are up to date.  Moreover, the output `deadbeef..deadbeef` appears=0A=
suspicious, almost as if a collision occurred.  To clarify that the hash=0A=
is, in fact, identical & to allow grepping for the phrase "up-to-date",=0A=
add a message to the output when the ref is transmitted, but no change=0A=
occurred.=0A=
=0A=
Signed-off-by: Christopher Lindee <christopher.lindee@webpros.com>=0A=
---=0A=
 transport.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/transport.c b/transport.c=0A=
index 84deadd2b6..89802452ea 100644=0A=
--- a/transport.c=0A=
+++ b/transport.c=0A=
@@ -670,6 +670,8 @@ static void print_ok_ref_status(struct ref *ref,=0A=
 			strbuf_addstr(&quickref, "..");=0A=
 			type =3D ' ';=0A=
 			msg =3D NULL;=0A=
+			if (oideq(old_oid, new_oid))=0A=
+				msg =3D "up-to-date";=0A=
 		}=0A=
 		strbuf_add_unique_abbrev(&quickref, new_oid,=0A=
 					 DEFAULT_ABBREV);=0A=
-- =0A=
2.38.1=
