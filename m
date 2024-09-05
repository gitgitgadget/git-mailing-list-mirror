Received: from mx-relay80-hz1.antispameurope.com (mx-relay80-hz1.antispameurope.com [94.100.133.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A489194AE2
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.133.250
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523806; cv=fail; b=paB86PK4KbzWhRuB9RcO5dEMniejNmlD0Mvg4A2//n4QHJsOnaxjZsmXGuZd3RcRPeRY2a5PP258iMwjuiFbaFXZ3+529yQc29kBipqaFkLF2hWiqFAlWzw+Y6DcVppT7SBJYenyIn97sTRru5s0nzZmn98ZdFPtnzl8SrLKaUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523806; c=relaxed/simple;
	bh=SbsoclR2DqjA4ln6xI7tE9hJY5k6VyT3hHHtERbx+v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQpHed8bhUwqQs1dA+XeOiMkRIFot55p1kMjtG8uRLlSboFTHMQ/rVY7/cPA6B1BfM9qm4WofjJrUiFMJ+vOIKjwfKPHLIwUPJ7kIpTCIPnp4bdjCUJ0k1WlfYRTlrYOGxG300z0hHbuXXOuIWxnX20o++vSPlrVmzjUVPYw9cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=MuTSjc5W; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=ngvV+sHH; arc=fail smtp.client-ip=94.100.133.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="MuTSjc5W";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="ngvV+sHH"
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com ([104.47.17.105]) by mx-relay80-hz1.antispameurope.com;
 Thu, 05 Sep 2024 10:09:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOoVOPq5d9kqTah04uxh8DSnSXYGajuy2DlHJM1W+RVn0FqQRZ/aHoOLViGy3mKQc1NfAKa8jSBYxzV0aphoIkP9XBlCZmkIpT9Ml/aPGVvbiyiGpLuWJDavALk2ttmf9sV2f/ksxBqrHnc9am1qxenQQI6j9S9FHJqsG6YnJlCULp0bKs1Ql/VheVy79rKZ1Hwx5YtkkjZ4/e8wtoQPpuEnXOIdcWlRoueMVBE9/TIkGH7DbLe02toSCXGPc6U13ztkRO8ugewmvjxgTgvql0/hJnJlENjCZShG5AhoImdiku9jItLfbP+VFML9LhzQuLZt1ztbvzQCt8eaTq35sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1o008FjT/SVIsy5ky2vBcPWepw3DJ0aoyaTP5S1Q2Y=;
 b=WYeNMvWIfS7ZkQ6itqj+rDdhQqnK9fQ2ylxbFp5AW7RaFVPI5tQxSfxLt15YEdot8o/HK+FVdG6HrKAsg9IsjGD/5Lx4QBAXmWu1KTJVQ/V3+ngqRGP5vteUDzhzU5nzA3hghr+yuzAfpeoMjj5Yy42KgjC60lgobUifY9bZn5jKLXd7MJ7Fwv+c/q9Pu2sXizEXrqJPLEYhpo5PhWhWb/rYYZW9Lp3bMxlnskC/aTpXFsTTVLlT6ucs5TpiQS4iudKdtq11Qkn6bKSx9Q+cxF0H5hOSev4tKsj3sArsr2kkRqjAX0XH0qR7LwEsFYS/4gVHL9okZfKwGz6HeO60Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1o008FjT/SVIsy5ky2vBcPWepw3DJ0aoyaTP5S1Q2Y=;
 b=MuTSjc5WvL+ksap1gU/hnYcXWOp91g23vGlMD1sPfox/cYJbyZjuiYOlqLfZKs8t4DC7K1dYj9hcZrQ7qa5PuvTYjMeuePYlknDMhU1uyAqz2lTtPL+VPkXn4ZeeIz2hb3m67Vz4b+DY6TOEatij2TYBSZvgt2+FsBWQQyqnARE=
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com (2603:10a6:20b:557::8)
 by PAWPR08MB9855.eurprd08.prod.outlook.com (2603:10a6:102:2ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Thu, 5 Sep
 2024 08:09:00 +0000
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a]) by AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a%7]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 08:09:00 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: Junio C Hamano <gitster@pobox.com>, ToBoMi via GitGitGadget
	<gitgitgadget@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: [PATCH v2] git gui: add directly calling merge tool from
 gitconfig
Thread-Topic: [PATCH v2] git gui: add directly calling merge tool from
 gitconfig
Thread-Index: AQHa+STSGG0G4hMvjU6zVij+Dv2p67I855hogAqkKjA=
Date: Thu, 5 Sep 2024 08:09:00 +0000
Message-ID: 
 <AS2PR08MB8288F9C7DFE0FC563D81A30DE19D2@AS2PR08MB8288.eurprd08.prod.outlook.com>
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
	<pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
 <xmqq7cc01sow.fsf@gitster.g>
In-Reply-To: <xmqq7cc01sow.fsf@gitster.g>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ActionId=4c46dbab-82ec-44be-9f23-8e1524bca886;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ContentBits=0;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Enabled=true;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Method=Standard;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Name=General;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SetDate=2024-09-04T11:38:55Z;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB8288:EE_|PAWPR08MB9855:EE_
x-ms-office365-filtering-correlation-id: c56a1c08-8851-48c9-36e5-08dccd81ffc4
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?6IHf2CrRPCnL0kLcQC1+6ZneMbQDg+rdst9ne5ZrjbBJRw5HfBpaMjOa4O?=
 =?iso-8859-1?Q?8Dz42NSuymlRpKddMDGM2ACiyjUm+gcT3gzTjKDgfhfVhntTHgJSvT/bmz?=
 =?iso-8859-1?Q?yX6tiS29bO7JXP13Kx5WLrVCqYwt2kmLsGYQycJowTDFV0sGgA7ntPAjAZ?=
 =?iso-8859-1?Q?VxGiG1usnlLgRUrpsgExaoDIXwEGaa3dEaVDk72JkAxaSXXuXWVykORQjr?=
 =?iso-8859-1?Q?QlozlovMW6tsfMnIRn6vjdR2fPS2ARffoPYY7UlqYVsueG4dJPIAzbLPxk?=
 =?iso-8859-1?Q?5Tv9bU4roZLhgvQCR5tYi/lBcNMXYOVTuUr7eESfZr+17JdUZzvaVqTE+9?=
 =?iso-8859-1?Q?hmJCAnPu5IiNfYMWT8JL/puYgyKnOFs0+qcrmH64n80dU/b905/8Re2HFk?=
 =?iso-8859-1?Q?39c7N8LLLMBJBTHcV05YyR2v8zs5ys+G6GupIX1ORpwdfTDwVJu9eJRzwb?=
 =?iso-8859-1?Q?8VtUr25bSZPO6OScYyXUrGaiYn/Lij5upyLf70/2kuU4FHdXC08StLlPA7?=
 =?iso-8859-1?Q?cAfpuQGvKs7WYRbDZRGqDXMQ/BK4CvN+Ze3cA1+7Ugw7qqXAtH30orzjmk?=
 =?iso-8859-1?Q?MlAq3Olb7lee6qSa8Q1N9HoyFrx9xC+0oSSij0cDrhiLqilN1CehpDigW2?=
 =?iso-8859-1?Q?hOvQU13ufCNCo8dODmQpK0uvEqnbEyDnI+btvjzRFiF91/oYAXEYyqa4hn?=
 =?iso-8859-1?Q?H3FYJxr4ClXNDngFmt7GLBq0lcw+3WBe48pC8tN0X/A5dFhWTmSvM8jbpz?=
 =?iso-8859-1?Q?rPkR8cujcaI0E/ZSbVJEWtGt6G48hQO7DyXMdOO4MnrteWuYTrrTHUnkE6?=
 =?iso-8859-1?Q?RCfe3vfG6S+Dh96Ho3lL2hK37/aKJdKzWHQ3rLbAdGeYBv0TVL/xnhd0Z7?=
 =?iso-8859-1?Q?axKQMrCPz6jcSJMsNRYwefRO3gXSoNlHaRuqsTSUnzUSczCusAgFTkXgFi?=
 =?iso-8859-1?Q?gZtCC2qTuufkKidmZK7mYk4kaqYrSMcjbmGfjY1ODJvaBYur3SuGk7C44l?=
 =?iso-8859-1?Q?9uEjpVL9jI1JmP8XUBvJ2crMrCWuq2+9R8N43uJ9Ixbso6vnuNTy8xcQt2?=
 =?iso-8859-1?Q?SDFhQrwYaLJR+bJgzdxbFw0K3t71y18AUW4T/BMdOEyMU4GGxcbqBCAC0y?=
 =?iso-8859-1?Q?u5TLqWtS63U9dwpVEYj5JaJjhKHkJhgEuPHFT7JOFSJuPLE4oFxIWnKNM7?=
 =?iso-8859-1?Q?7nwe0QWRSOLYjeGiFxV/bWbYVfLr0tyiMoAAmZweFtz0kOl6SSy2QFbiB/?=
 =?iso-8859-1?Q?MGE3wjAO7DYAMPW8pFEBz465U6O1Cdij5+iY2ZHAOy1wFVtCuFJeRjM7d5?=
 =?iso-8859-1?Q?YhU/vqWQat3ULX8iPit61S+6qFChKqW+uSOQRFwB7NG3v24f/zfx3bYZov?=
 =?iso-8859-1?Q?xHE24p67t+YtyI7CLsspxAELFK8ztaHgzsX1HNSMX7EEzwwkTxBPpk0VtB?=
 =?iso-8859-1?Q?WydUFOQ7I7NNRHXcaYbKL4VleicHdG0SsDB1tQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8288.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?aBfsJPY2UPSZPJp+BbXoeFr3PxHw8aedYBYPlwKlGCzCyMmevLHqvKlgxO?=
 =?iso-8859-1?Q?ofI/Mh/Y5Fpi6Oy7rML8ycfrzwfiSuTIBWlSw5Ek2/DOnDELph+qfsBJXa?=
 =?iso-8859-1?Q?EPJ+CQsRm+jOU4ZlsavTOE69I7nPxNm8D2xwa54JENLAjX8UzBHJVoicXT?=
 =?iso-8859-1?Q?uQLXpCd6diFBMT958FEp9xUpKMBqW9/QLyMcjEE7RKu1I22A/DfV6XVnWq?=
 =?iso-8859-1?Q?zGVIthm+bV7BhzSOAGk9qOFZ0puoCwtuQaS98C3KMTRtmbPV03xF5Tubjn?=
 =?iso-8859-1?Q?T3qALDw9lu2MHsWXH0msvWwktwUJE4PWXZseEp86DjcofJttSNf7nx6az0?=
 =?iso-8859-1?Q?z88/Jpi2r8sSW9s73xnlfuKdozTJqunzEWVsSPeD/lvNUoq5f2/nBwkArc?=
 =?iso-8859-1?Q?dSl63cLEsIyIQI2aoga8+WezZR9T/KCm4/vIjZ3DvgxcnQNHvZezJIuY1B?=
 =?iso-8859-1?Q?XifrHBuFDoM7hac/plGYqn9YY3OPPmfsUuxnxb+pOqzk4f9gEBvzm+ENXj?=
 =?iso-8859-1?Q?b5/fTVrfUrgurrmPBXqfSAfqD4bGXOJ7gC85Pf+3+HF0DM3AOukp0QUfgd?=
 =?iso-8859-1?Q?jF68vs4YM9Cx7B0iIQNeQXzbcMfguH0OBMI3KEOitHqHHpVeQYbCjivCTc?=
 =?iso-8859-1?Q?vjfLzGHxmyr9iJy2KWIQBXd/yADY7qEV+GUgilPF6yBEVuifYoLGXmSqq7?=
 =?iso-8859-1?Q?CjzkfgC8AuK8aB0nFqBmRBQ2GDoRYC0lVPClQu06dPihmIlQE4AN1G6z9c?=
 =?iso-8859-1?Q?uEXEwyTxXxXhA99MRwSjMIlMnz4No7d3p/wS+7ix3tdMpQ47lFkxfu3SJ8?=
 =?iso-8859-1?Q?K+qrUIOUknQezL7F/rs/E8z8CaZcbS2NZCNlxIl96msMu3xWtlLAp/+e31?=
 =?iso-8859-1?Q?EvRwc7qYvYqMIiVWG+CGRKjdQVBxnypId07guzecXgWsKQFx526xUCmp2w?=
 =?iso-8859-1?Q?1jdqnZGLXrA2CgP0wxT6ttUuqOzVwTy0RHgMV6tIPXK8v6i9sTfutvVhQL?=
 =?iso-8859-1?Q?NimXiixSe7ZwZehVhbb9JjluCnjIInnTfuVpSm80uTYr55qX4iRkNiqOnN?=
 =?iso-8859-1?Q?ZCfVVqg52spRFO07fH99wjAGlgybMK2EWph3KXQ859hz2hJH88MIbNj23j?=
 =?iso-8859-1?Q?vdHgJ+KEgt5GjakT95QKOQUeOUzgV5WbQtA2Yt9QDVjSAT2TbWUld6PyTp?=
 =?iso-8859-1?Q?d3E9YAfkNL10B/A+ayh9EcifJfx1AhD0fjPEdztlcl25CJjdaAjANEPCGl?=
 =?iso-8859-1?Q?mC5QgfLH4mEq5TCpopoFA6OD8zrulHmrd1AGCJPce1Ws5jHT9oaNb7TPdZ?=
 =?iso-8859-1?Q?wotALqJOAvsux3k7LzJsesReBqYOEA6Klp1tC5dT+8Mk3/9PnKvwYYq0oZ?=
 =?iso-8859-1?Q?nG9WjkeelEu4HqzzrBsQvwIxEYTJnqX2C+m4c0ho1hfQ9dCOv6ra/JTopZ?=
 =?iso-8859-1?Q?fyV0IouR/Mg0HK3ttVB6lgBhE3Jj4wUVNNOdHqD1bUdgIGdKR3K9mUEKbg?=
 =?iso-8859-1?Q?u/eYShHECXuJ0z/gcu+NcdqJtzU6btKk/aSyWJXNmBdhnnNw6qJodpR7H3?=
 =?iso-8859-1?Q?x8x7DxvvQ1AVtrOHzLZY9AHWz6/Ti+3z+YtMkjP+aj40PBCYnGzFc5vD/1?=
 =?iso-8859-1?Q?NiYB9wPkzpz3fCjUL50CU3pGJ3O9R2357n?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: miele.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8288.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56a1c08-8851-48c9-36e5-08dccd81ffc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 08:09:00.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rS5hODZgh7zEqtPvOCzWXwPPYqITJlQZIlPAxzkV7l4b89xZo0hR7OhU61TcriTphFe2yvzjH5LL+m4dNMqmRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9855
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay80-hz1.antispameurope.com with 4WzsSw0sBSz2bN70
X-cloud-security-connect: mail-db8eur05lp2105.outbound.protection.outlook.com[104.47.17.105], TLS=1, IP=104.47.17.105
X-cloud-security-Digest:62c88dd24783fcb368cc7fd399a600f3
X-cloud-security:scantime:1.380
DKIM-Signature: a=rsa-sha256;
 bh=f1o008FjT/SVIsy5ky2vBcPWepw3DJ0aoyaTP5S1Q2Y=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1725523750; v=1;
 b=ngvV+sHHwx4d/t91MLcmbVqdkzHRN3TkB01HGNBWVx8thPvjS4/mFKsS63IoZqBhqgVo5KTN
 PimY8Kn39+x0KXGH5Xs/HtxURkFcHJpKZyxmsIFfKp411CwOjwQuCTXMDGryHaGdCBXl1Rsm4sL
 4Q0C/7JFEdyqdeEIQxg0WKH3qz9lZN/XUcEQ7ImZT8z8nMEurcJj7e9Pt/u99/FmF/C1G2VSZMm
 ct2U0D2GL3VgB1mPN+enNO3lpbTT9lFO69btXUZUDuJw/ekN7Ub8/tZgB0uFWv5SDfuBro58k1t
 m6Nbrx6YG1LeWa7LeJGL5CQ0D9zg3BpZVEuCx+5MniNiQ==

Thanks for he review.

> -----Urspr=FCngliche Nachricht-----
> Von: Junio C Hamano <gitster@pobox.com>
> Gesendet: Mittwoch, 28. August 2024 19:08
> An: ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Boesch, Tobias <tobias.boesch@miele.com>
> Betreff: Re: [PATCH v2] git gui: add directly calling merge tool from git=
config
>
> "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: deboeto <tobias.boesch@miele.com>
>
> Use the same ident (human readable name plus e-mail address) you have on
> your Signed-off-by: line below for this "From: " in-body header.
>
> > git gui can open a merge tool when conflicts are detected (Right click
> > in the diff of the file with conflicts).
> > The merge tools that are allowed to
> > use are hard coded into git gui.
> >
> > If one wants to add a new merge tool it has to be added to git gui
> > through a source code change.
> > This is not convenient in comparison to how it works in git (without
> > gui).
> >
> > git itself has configuration options for a merge tools path and
> > command in the git config.
> > New merge tools can be set up there without a source code change.
>
> Even if you configure an unknown tool, it would not get any benefit from
> what git-{diff,merge}tool--lib.sh gives the known diff/merge backends, wo=
uld
> it?  Instead of a more thorough support for known tools done in setup_too=
l(),
> an unknown tool would be handled by
> setup_user_tool() in git-mergetool-lib.sh which gives somewhat degraded
> support.
>

That might be. I don't know about this handling.
Would it be a problem to not have this handling for unsupported tools? Sinc=
e the concept of supported tools is not removed by this patch, tools can st=
ill be added as supported, to get this thorough handling.
I personally prefer to have an unsupported tool, that I can configure and u=
se right now and add official support for it later, instead of having some =
well-supported tools which exclude the tool I want to use right now and no =
option to add it quickly.
That is why I didn't add support for the tool I want to use right now. I wa=
nted it to be more universal, so that every tool I can configure will work =
immediately.

> So "can be set up without" may be true, but giving an impression that a t=
ool
> that is set up like so would work just like a known tool is misleading.
>

I don't want this patch to give that impression. How can this be avoided fr=
om your point of view?

The degraded functionality for unsupported tools could be mentioned in the =
message for an unsupported tool introduced enhanced in this patch. It could=
 tell the user that the current tool is not supported, but that it can be s=
etup with degraded support in the config.
An updated message will be part of the next patch.

> By the way, we do ask contributors to avoid overly long lines, 50-col lim=
t is a
> bit overly short and makes the resulting text harder to read than necessa=
ry.
>
> > Those options are used only by pure git in contrast to git gui. git
> > calls the configured merge tools directly from the config while git
> > Gui doesn't.
> >
> > With this change git gui can call merge tools configured in the
> > gitconfig directly without a change in git gui source code.
> > It needs a configured merge.tool and a configured mergetool.cmd config
> > entry.
>
> OK.
>
> > gitconfig example:
> > [merge]
> >     tool =3D vscode
> > [mergetool "vscode"]
> >     path =3D the/path/to/Code.exe
> >     cmd =3D \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\"
> \"$BASE\" \"$MERGED\"
> >
> > Without the mergetool.cmd configuration and an unsupported merge.tool
> > entry, git gui behaves mainly as before this change and informs the
> > user about an unsupported merge tool, but now also shows a hint to add
> > a config entry for the tool in gitconfig.
> >
> > If a wrong mergetool.cmd is configured by accident it is beeing
> > handled by git gui already. In this
>
> "is beeing" -> "is being", but "it gets handled by Git GUI already"
> should be sufficient.
>
> > case git gui informs the user that the merge tool couldn't be opened.
> > This behavior is preserved by this change and should not change.
> >
> > Beyond compare 3 and Visual Studio code were tested as manually
> > configured merge tools.
>
> Quote proper nouns for readability?  E.g.
>
>     "Beyond Compare 3" and "Visual Studio Code" were ...
>
> Thanks.

I'll correct the minor suggestions in the next patch version.


---------------------------------------------------------------------------=
----------------------
imperial-Werke oHG, Sitz B=FCnde, Registergericht Bad Oeynhausen - HRA 4825
