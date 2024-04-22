Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2098.outbound.protection.outlook.com [40.107.8.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B915099E
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795478; cv=fail; b=MINjG5wNh+R4zQRg6k5uKAVpI2f9kWUWxaLCKUkKolFU/+XJgEWlT/uIXS3EhSPzfDx4PBz9EdRO2eUrU+RVwof2lZ8UvjviyFi4QQfq3YG4cS/3s5pjOVPoGh9XCfopKUh3ULrMUkv0GRUERjqTYlqiBKfNhrLyi7TbR73BqdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795478; c=relaxed/simple;
	bh=VJz3xT8WcjScbxsvSPnD2zdU2xWc7K5NEIwdTqhCiow=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jJKtvnBmUXKvOdPT8w6Mp64Sgd5j1vPeOmJZWcZEGrijgTf3UOphTJv3hKC6oWJczn3/yjsMxuW1b61owWLud1svhISSEBH70+T/xtGt0RVORKOZic4/SST7ei1Cf9cELFyBKd6vyEw9wvRwZh2R2k9AhZgCjUp0GBa3qUrMa7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thula.is; spf=pass smtp.mailfrom=thula.is; dkim=pass (1024-bit key) header.d=thulaehf.onmicrosoft.com header.i=@thulaehf.onmicrosoft.com header.b=0RIJJ3V4; arc=fail smtp.client-ip=40.107.8.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thula.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thula.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thulaehf.onmicrosoft.com header.i=@thulaehf.onmicrosoft.com header.b="0RIJJ3V4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQqa4KDdO0PyUuOTViUUl42y+kd6rYWAXhEqfxrYPkISrS7/pvCe8F7h4uffvyD6RVk+mPAG2sazb9GR9slLhAWDWsuNNkXtV8tc3go+9dxRmnvCFy9OBKd17MB32m7IwJSMvY1STkPIYb3UdPHuYm0rvhH7Cfk0QxW+ihso65r04AnL3F2SWyyYBurWeXecCh+F1yPXTpKvguyDTntuQqZ7hKBfpEtgyVS9IxICMeSnzkhC4NYXMLj6X1eNFqyH2qgH5uYlgd83ISDGyARV973lyk7c1K5jqrExsR6+iSbyNNbpEi7WncjmlkEl3vx5W7laWohQdeyAyJ61UV8j7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJz3xT8WcjScbxsvSPnD2zdU2xWc7K5NEIwdTqhCiow=;
 b=FZyZciiL2dBUlY1pyozbnDuji4FguC81s/79klXr9GCCYMM11i48ctXou5gUbq0rkKGMQ0gaQ8Yqy6yyXKwWKe0bDjBnrhISjq1N3p5+3Vp9krxIPPiraauGIWDj+0Ie/fKmiqsTGIroOYTi836jyDlwCdLpVvl0Jq1S3QY5vgaiT9BIuwq9ZL9DXXFmAX6UgVKlJrYwKoSXYYjThwpgD3u2AXJUlqcfYj3rZz5GDmuTDOWqwfoPgJs/LkEs0bwo/1bsV4gKTEp8pLG4e3mHxCap5GThQZAK3vuDqD7FdK5fs8yF9Kg+0OOvocnhTtUweDnzJ0THi1FhV+i7HEe+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thula.is; dmarc=pass action=none header.from=thula.is;
 dkim=pass header.d=thula.is; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thulaehf.onmicrosoft.com; s=selector2-thulaehf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJz3xT8WcjScbxsvSPnD2zdU2xWc7K5NEIwdTqhCiow=;
 b=0RIJJ3V4zigAP6X6RIFAUkJkl3u9iuRjSmw8jBog/oYF6lr3PT+wuuD2tTHH1XnaTXTs7qwrdu+neuGhm44P8JZow8x80iJeHwI9a7KgSmIRNgPgHT7qbgSFneuubMZYvzaKzOHR2ruFxwblFG7nopPWlC+R4QIf5gvN5X2/T/8=
Received: from DB4PR09MB6621.eurprd09.prod.outlook.com (2603:10a6:10:3ce::20)
 by DB3PR09MB6153.eurprd09.prod.outlook.com (2603:10a6:10:43b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:17:53 +0000
Received: from DB4PR09MB6621.eurprd09.prod.outlook.com
 ([fe80::6651:9016:83ed:ab26]) by DB4PR09MB6621.eurprd09.prod.outlook.com
 ([fe80::6651:9016:83ed:ab26%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:17:53 +0000
From: =?iso-8859-1?Q?Svanur_J=F3hannesson?= <svanur@thula.is>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: SVN to Git migration fails possibly due to branch renames and deletes
Thread-Topic: SVN to Git migration fails possibly due to branch renames and
 deletes
Thread-Index: AdqUv9zTAmKTQ2W4T4aIqxalZEVnkg==
Date: Mon, 22 Apr 2024 14:17:53 +0000
Message-ID:
 <DB4PR09MB6621B176177DAC3C82C9E455A7122@DB4PR09MB6621.eurprd09.prod.outlook.com>
Accept-Language: is-IS, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thula.is;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB4PR09MB6621:EE_|DB3PR09MB6153:EE_
x-ms-office365-filtering-correlation-id: bf79e0cb-576b-4355-3b79-08dc62d6ffde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xUVmcTt+r0XodeY1oCsTlS3SE5sgw6DpeMttARSCv43vudeI3/8VsS+1Ug?=
 =?iso-8859-1?Q?3Howy549nRAwUtU0xl7p1FWlqdvxq8MQpcjY1kBjr9upC2LL8UEM/dkX/O?=
 =?iso-8859-1?Q?487bN8YFtLjPT1vEPhz+INF0RGc/vDUdTIzS7PWXm2ebonNwn1lDGBx+U0?=
 =?iso-8859-1?Q?y85nzAx+TLMMc9LkXC6B79cvwRMLVbbO5mj+c7mLn8BVEbPFIcR6cvqZmP?=
 =?iso-8859-1?Q?kPP/mo047qfEHFg4GJvC18eDix7mK9dEsLVusrWu83CGZsZJvpaP9A4AFk?=
 =?iso-8859-1?Q?OlF2nfRaS8K9783cIlwCaCXmE6hOMhWlTa9KOPWhMbAuLsBEsADTIOPIF+?=
 =?iso-8859-1?Q?1Rrizmhp7VlJ1q4E+XK2SOoS+wS/nCEThDt7ENyG0UJmUXEbjUX8C8P36J?=
 =?iso-8859-1?Q?utmbAig7EbG2fe6DtQ6A6lYZ3mTj9oQWxL5ebtTaVBqXevOCKnk3m+YqfE?=
 =?iso-8859-1?Q?mNv+5Bjp4QgtAb9NLm/L/twU57LW2jQZj/FQyk82sIdJw4dNvs6/tD5m2j?=
 =?iso-8859-1?Q?JqebCKHJS/CZoCBaatlIpwOohPMKvAoQeO/3/yUfiFkb7UeE7J35yuoSbB?=
 =?iso-8859-1?Q?U5sSEGB1XvANZSLCtI3wYNqmQHkQ2B1qdyJFp9hDgHBUwM8DW4cwg+R62y?=
 =?iso-8859-1?Q?+7zLr1Z60tGhi+NfmqC7JWje9+oDUT1tCgAXesk6w0V/c/jVdFJQtZFxgK?=
 =?iso-8859-1?Q?J5d069old+SsrUmOZEE81O6zqGBmSBRwU6bUKJUOYhF7g93Vno7E7wPFU4?=
 =?iso-8859-1?Q?6jp4T2NMYshrZxf+SSAxGXSRg1S34KrDf1+oHnaPLCUZdp/oTbFj+Sto9F?=
 =?iso-8859-1?Q?JzTuWBamSTheK7nFeMSiwtn6RIslsC8GQNaXzgHI1tDUXHiydjlXWWOz5e?=
 =?iso-8859-1?Q?F3o4DEqEVh1ezLaGwC9AgYD5E6ABPIh4jge3NsAVowpNU5+3/WMnMsyfHj?=
 =?iso-8859-1?Q?zsntrKZFebXUBwc1l916jcfg+jS86s6E49bSukIeDfbBzYjB8VaD5zslHo?=
 =?iso-8859-1?Q?cHtUx6Tefjfi7LvTq2zFIkLf7f+5p14YYjqNbS4KAfnTL+AJJ1X49s3Uiv?=
 =?iso-8859-1?Q?06o3QIUv6F4Q0pfkHBXgxokOiU664eVsSmudi97XYMZpv37lwnCYKxmR8p?=
 =?iso-8859-1?Q?cYPT4/LuEChe0bwjjOgTNIL8hVChkhJuZ7MiihN54SCfzl2E5+bqDPNlhA?=
 =?iso-8859-1?Q?n4s61b9ev1e7Xq6xd2puk3bIsQTVY9DbPNhfJzrB1MVfSVXpwnN4kQKcTn?=
 =?iso-8859-1?Q?Q0Ck66x/bKMffIXHDrhMcgXKgfQPnB+E4V59ODqUvvYPKW6fgW4mdn+HdB?=
 =?iso-8859-1?Q?8P9uuWqaq38uwToFgmtCR+VPiY/g0mGoogX+W4tZEOMDYHctANnAkCvaSc?=
 =?iso-8859-1?Q?AVwiAcrzBA5ppUJmztOZuoDWSEMDySIQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR09MB6621.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rejQKnrAw4RYFLBjjFBkXvN0fTHwYeItczp0rS5XkdmkxV4V1s3Q2QJk9B?=
 =?iso-8859-1?Q?dxHma42gbxNGvB9DioJQrK9dvBtR/3cfqe14qg4p3nXPulmPrjOT0u2Lhg?=
 =?iso-8859-1?Q?XoiW4A+9J6xF7fqo5aFnEAfMpqNSAamNJG9aagmmfu7vD2xB2nNDYikwnV?=
 =?iso-8859-1?Q?yw2GwQsyn9csVoLxYrBvnjWE8s9GCgoNGNqtC9B6Q94WGANxU5mlAZcx+X?=
 =?iso-8859-1?Q?oXqgSSWmFPSUCJU5ljc4jThCNZOv5pX7q2S3iXiazI+GgEgYcaLT6+VOSB?=
 =?iso-8859-1?Q?fPy816utRcaTkVJfdD5/mlb2zqFdZwi42ga80HKvaWB0mJ/a9Kdwvo6VlV?=
 =?iso-8859-1?Q?Uct703uoo7WdM5DPPU6lYuOmbVVb+F4bYFl6Dla+OgJk3EJkKl3N5OAOHg?=
 =?iso-8859-1?Q?7+M/JDIq52fX+9p3sZzNoEbcPjotxiosT59SZ1S0ERvpxgMqtfW7lr8rzB?=
 =?iso-8859-1?Q?W7jHt1NzaoTlrQ+ITCDTWPWzq3J6RuGRGPon9gpTkhKdSml53ppTeQ5PpV?=
 =?iso-8859-1?Q?3Vcg586k70HtnJ+vfh8vy1uUO4essckH0uomtgXWAGBWXVJRrPQnx9nSkb?=
 =?iso-8859-1?Q?iuljV/SCkglpPAft9LO0UHjTbwKzmS5mJ91MF+3Wyl6PRCXFrU+6+riNuD?=
 =?iso-8859-1?Q?PyWTxP9hgs9GpVSNaZbVn+4Je88GEAiUMOiU1mPJCgt6NoNK59StMZRntf?=
 =?iso-8859-1?Q?bTLDRtL8b6j6IKi766NUF463t+Qq6aEnD6R8NuiBvhIvqhmz/EfBHCWQ2T?=
 =?iso-8859-1?Q?pn3nw9iXnlI4IRD3LR//bS0r6/5s95C406EBOfJvOIGrFwfoXmWyXZqvnM?=
 =?iso-8859-1?Q?XKcL9rx1I16O9X4pAG4RipGL1Jmp3lcJLmX3rLwbD1b7bOm7XjowT9ca4d?=
 =?iso-8859-1?Q?HGCJ58NJXrxLgZeX8cMjtdQu+WeUyJN2G5DHCwBrLNJVFABuy2PH5nYJ/t?=
 =?iso-8859-1?Q?2mfQC7GEsMowqhCy+OPUQLVWA0dOu67b0nd5omOMvrQi6yWR9dKX/2/ssS?=
 =?iso-8859-1?Q?bdXri6h2I0+9hCLI/QgR3o3k1hPJyfBJpqYlEMEFAyHWwDMI+CJIY5x92V?=
 =?iso-8859-1?Q?ZURk4tt/BhWsbInTvGtBMhuOTESKfdkP7G/P83xh4hXUKGwt5kAPr4yTGC?=
 =?iso-8859-1?Q?7Y4G2Gmosh03/Piov6gHPFmojAsCQMnZPEPjXhnW3Bz8kU41JrAjAmTmm9?=
 =?iso-8859-1?Q?GjA32dibbpo9kxtAcdu3Jkw4RNDEGMYbUzhb8k/6zM1k9fDmyFfor4NLtZ?=
 =?iso-8859-1?Q?rCyeEnHZNIip1Go6aj+aXlGxNjjfOBbBc0Ljt4XNIIIGENxUfQMymmUEPz?=
 =?iso-8859-1?Q?rvFU8QfeN7d7LBNWvd5M97jRJwRUG95MpB+I2Mhap4Ak4PURcVZEFNRkN8?=
 =?iso-8859-1?Q?/skGnN2huKUTIWYa161bBe/gc6fOq7IqlbT/e289pvb6eMWQ+AKZ58ayvD?=
 =?iso-8859-1?Q?HKnPk0d6XJId3KCOkrFH0VQi+oKpvNVCSAaJ8ok3wgy/6UBnt9R67KUtRl?=
 =?iso-8859-1?Q?GBjxrXz6O1EEjoihfG7b+lSe/FJ8gDZ00wb7BjE8Ql9gMokb9JIC0wyW/V?=
 =?iso-8859-1?Q?g0omvhQvY5kuJNTphHuakgw1E6hqAGFckR68LtOoaBbpLl1APGe8vAtooh?=
 =?iso-8859-1?Q?XGpKPrKILrXqs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: thula.is
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB4PR09MB6621.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf79e0cb-576b-4355-3b79-08dc62d6ffde
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 14:17:53.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 45a2d7c5-3f06-4f3c-a12b-4bc2630c392c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FP6fXL5BWGb4hZxzWPlOm/jvndYKNklrmYpAwixS9wU0KlWkEMi9PQoXHmtvTCw6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR09MB6153

Hi. I'm trying to move our code from SVN to git. This is a 27000 revision r=
epo and at 25600 ish it stopped working pointing to ra file in the Git fold=
er, line 467. I believe it is due to branch renames and deleted but I have =
reverted all deletes to make sure the revisions are available in the histor=
y and I can see them there now which I could not before. But it still fails=
. Could you help me with this issue. Kindest regards, Svanur
