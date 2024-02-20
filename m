Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2112.outbound.protection.outlook.com [40.107.135.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9872D79D
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412088; cv=fail; b=DCScj+seI2f9m3Aq9mNAGzgAS5y3BslFaf/+oSIxOqmcdSyEIqzaz1h0f9LPB02hzkVtVJfHgIiDnl1nf4tLZDR0iJAeESCMa2ziVT5wqXS84Ih+ySIpF0pr8uzc0/foVTtRquSJAxQ3eYoE1+11dV8GhOhNzY8RsUryP+zHf1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412088; c=relaxed/simple;
	bh=hjN+CvGcGZHSpdnZTDu5M9/h4fMvj8egL+0Z42OabDk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mW9EZQEaiRMmdOPW2c8nE9WcHxY3J+jaVEQMGvj7N/Dt8qhBkSPs26qkhS8dXub6NrprYwSwM4anfLEUg9m9UtW655fWDdFfLBDCvoqrOHWkBUxpSN3nLUdZNUdc1TzdD8LgfsKN/BITnEfuFQ6l1SEoj/smDZtmyLWtoQwsP4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastec.de; spf=pass smtp.mailfrom=fastec.de; dkim=pass (1024-bit key) header.d=fastecgmbh.onmicrosoft.com header.i=@fastecgmbh.onmicrosoft.com header.b=Ch7u/VW4; arc=fail smtp.client-ip=40.107.135.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastec.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastecgmbh.onmicrosoft.com header.i=@fastecgmbh.onmicrosoft.com header.b="Ch7u/VW4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2ze3DiBiY8U39WLbknv3hWw0zBJ2zYhCHB8vd67VdzO3TFTmd2DJodzhaLxnj7bsJCScbde/d1bsxvssovC8AiYrzghfMQ+W4EIGxVFRGdrmQjheJObaHCQ3uVhiiaI0raF/49JtSSgsQPb1NIal6LrT2Xu0UnCc7B+7DlxbKLAKXm6Ecbyh8dE2HTqNkrS6dVY+vghbU+J84N4HL956dQFZEuOVuCHQel1ZoSqJXKl53abbCJc8zmYj8hj++UOqr0vHV7nqEFbxi7MmKAdB/l3iN4Y6IqlTRjys8MhMHw6CkRIPIKPr87IypE4F5OUjtGbDnzdz6i9/qly7HfqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjN+CvGcGZHSpdnZTDu5M9/h4fMvj8egL+0Z42OabDk=;
 b=WS5GC9ZHhfztlcs06y75HFXW1xfPpFZIag5f4naIEaP8bITYnfqube8R2tZ97GEp0nsn826iYOH25hWWCYnLMUcyjQNIeQZioH/2lgDavQ4SiVTpkVejy/ylRLgVJQwXyCa+/dGROkO0Er9diFfLdcBqWQR4H4ic2vtHshpeGT7vfzEQ0ZlZ+MTGKctlIoMbrt8NzIStfsSjE/4toE7WxuG5SamefHwATJGVW9FrdJf63uzzDNUILkPN3l9qKrh1lF09Qt994p7WQpR0lNQ2+QMiK8bBdBpFXMp9K6pvFtiYoCEYAJ+erVtzobVukE4CYsZxOGVG1g/fmC6l0xJuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fastec.de; dmarc=pass action=none header.from=fastec.de;
 dkim=pass header.d=fastec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastecgmbh.onmicrosoft.com; s=selector1-fastecgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjN+CvGcGZHSpdnZTDu5M9/h4fMvj8egL+0Z42OabDk=;
 b=Ch7u/VW4NN2hiuF3iZHYwPo3qifuipB7CXanB/+bl2pDVtf+pjEJhcrxd3L8C63mMqpWrVPjT+Fgb8WmgzXXIiKf46o7lNt/zHGX1EDnoCF6zKh+RnPgnnuOtWzuiIKbtJ4eaWWrsDQQXEsQM/hpIQPeNSzFWRlmPhypZZZ/GcQ=
Received: from FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8e::8) by
 FR2P281MB1494.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.38; Tue, 20 Feb 2024 06:54:42 +0000
Received: from FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6cc0:4279:43dd:b928]) by FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6cc0:4279:43dd:b928%3]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 06:54:42 +0000
From: Dominik von Haller <vonhaller@fastec.de>
To: Junio C Hamano <gitster@pobox.com>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>, "git@vger.kernel.org"
	<git@vger.kernel.org>, "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>
Subject: Re: Why does the includeif woks how it does?
Thread-Topic: Re: Why does the includeif woks how it does?
Thread-Index: AdpjxirXp/OKv1/PSCSFyDBXCDgpSg==
Date: Tue, 20 Feb 2024 06:54:42 +0000
Message-ID:
 <FR2P281MB16867E5D8C722A787F6CFEDABA502@FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fastec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB1686:EE_|FR2P281MB1494:EE_
x-ms-office365-filtering-correlation-id: 1a144a80-44b0-4d54-801d-08dc31e0d0dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8wUcRAVRf1CrSETSNuaRsQ7QdHnM5bvlIW9j+LDDhRbk7LTx7icXHPWofkLYmCkpt4vcrippGxZ+UOCa+QHvxLkrpfvIYc8lS0qyjgJaO8Ckb8valA724TaYFK5kD418JQ1we8+ufz1my7JeYeY15t/roYqebJU1hhac+Z27skcLClsiHlE8D2SVaUGcGhHds3B07EJJKi3cWHEmrSCjvDXVRl9Z8A4XJ465xnvCJrZ52MUNiH8lONI5JpL4WQSd8sWbIqatz7qSWDHUdyIhzdIGL/08h/OxHE7x2trg2ZBCZx7gZSQoocPgJUZ96D0UEgxeVf5QdaQSKtZ2Ll6cEFbbOYEa/QeGuqv2V/1nVT8/prJbganBR5hYSVZSRHLLJCnkoiJgQ/sPyg7ZuTtHyuCyVREHs480RzDuIzbFzqvbbdi5mj4QrekTfh+dVsVh0UQoIsAf8okoPcvYGSGrRWCfBMkZVXQ/Kk/qYsDFZAMZ4Y/aPL9jcr0jrcJ2QjCxFNjm+tFe7mWJARihH/pqlGJcqVY3LpLvRMavRCtFJ1KRdQE0HLUv4PlM5kQwLN/QxxcRt+7Kurf+jOvzOQQiBC3X7fUF5GggFlvTW/Zo4HNfFjxOlvFYh0dTDWHbVoVh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xPrtrK8swgohtWYDwMMFdH5154A58/qeb/bYAWXUhfCtrq1Z/PlPlnofUX?=
 =?iso-8859-1?Q?pQAzza/L4XqrFbFOAIr24GdXzRaIVX2ypKBfE+4lD+RY/U9j2FAvQl/SBt?=
 =?iso-8859-1?Q?ZZAngXuFe+rR+ojxb9Hzq9dG8Czad0xABSHZVBGFfupXkCOvzEkaCgYgLu?=
 =?iso-8859-1?Q?njE1xcP6aWxU6ohgfgGYn1zjxczfkF5a935QSQgLUlqoxGEh+u1D4WRiN2?=
 =?iso-8859-1?Q?J6eOM7T3egdyGxCUAbPf1H80Vhz88m32SzP18RMXVCa93M64lYpopeE1+3?=
 =?iso-8859-1?Q?kR82MomZ+1/gm1N7kFUsstef224kl66E7osEuSvBaMxsaZgeFsQGvu1d9Y?=
 =?iso-8859-1?Q?BdZg4J9eTWdC+qhjuxP7Ogim7Q+42Myjp0+dDkcoYVCsQDHnJTTggbiWfW?=
 =?iso-8859-1?Q?uNlvjWOP0eSKepM5B97WgkYZGMxoyJbAF27/I4ncKzrbUuixHu9lD/T7I5?=
 =?iso-8859-1?Q?y/8aslTa6EwTCH4l5MYITD04mYFilevYyBfNmULvgrj2XgGli2tvXrmkzs?=
 =?iso-8859-1?Q?B90JT+WoAGIMEsGxL7LQwqlB+yJveg7xU7YpXKzZf1cBOCsozGxtjGJsMM?=
 =?iso-8859-1?Q?NcrD/669rJkANoC4akcs9QPKxTcEe3kI+rx0PdvJQ871LxMN3E0YzcG3d8?=
 =?iso-8859-1?Q?esoz8iQk3NbzeRE7hWls8Ajo1rKJ1WvugHsT9ZRoD7DbMVwyKyCMXYyDM+?=
 =?iso-8859-1?Q?U6Ln6qI0HwWtQYoNEYto6ivRwGcilUo5DoqtwZ40BgiMCwcnIygC8Ev55f?=
 =?iso-8859-1?Q?r21b+DlAJZFtb+dJSe0SARjrLGTEGmrMBU4iXvqn3uT/CSDpnNGX28Xy5o?=
 =?iso-8859-1?Q?0Url28ij4+OlWPjC7vsy82iFMGtC0epmb5Hn0t615NaPc+mlocZo6bKtYI?=
 =?iso-8859-1?Q?SHnHccaJKTGEKdWZf++GyQHwSjKNmK1pKvBMAiMXV/iAVd2GwqBJU0+uzO?=
 =?iso-8859-1?Q?awEmP3rWgLQBZJYT803L97flq2TPktKq4zBVC8a8/hDXK1KKwFj+SLct+i?=
 =?iso-8859-1?Q?KG6jNRWb1nMN9CGPyTdI2Rp1GbIu2TqayOj7pchVBwzbn32Wwl9ewL7QL6?=
 =?iso-8859-1?Q?m42falqJbupD50/ZGhj759+AhTjvyXsnq9/yvG86+OWLVVGWdtb4nb9Yz2?=
 =?iso-8859-1?Q?YFusIcUdAEn3TuOWFzSRiHVBdpNpHOGRfMDbjMasixeDdPDTorbQ4kA8yr?=
 =?iso-8859-1?Q?W1VtwJ//AD9IWD7e3exUrJQ7G6XEt/qtE4CSpofpEO+4EcJv+3wGdyKQhj?=
 =?iso-8859-1?Q?saD9wo53etuWCCX+4C8X/WW9Um9p531I0c1ZFRkZAYW8lusehNTA3uKwQU?=
 =?iso-8859-1?Q?esegkp57yF8yk6s42FQ9r0IeruLrQnNZHVn307V8BUTm3wYn8YyPjhds/d?=
 =?iso-8859-1?Q?XhYfAMDm6p5BEWIp+Lo+604yCiBIKnQsFloUSWvd7nQOJBAbVPoc1KvgEv?=
 =?iso-8859-1?Q?kbcmFUsqRNXU1UiE7R0Qy3Qqve9ZPBQSGQZGlAc+1Z/8i7VUKTR7g2BFPy?=
 =?iso-8859-1?Q?5soo95Z96YaBU+Sa6M4x6I/Z7M4j/idcyYFv2Dm/tfxXWCtHss21bCxNAM?=
 =?iso-8859-1?Q?iX80OAuRFsbY9XN/J8Ifsw1jpWlecpvIfQzzCm0GXnjjrbv6DFprc5dTSJ?=
 =?iso-8859-1?Q?rD82PK9qSxEJsHH+aLnlj66EN8Ac4odGI/nWpmFs/TvDpXNWw75Ofk3KsQ?=
 =?iso-8859-1?Q?pjyRlFmWN69xj753FgWOEZ26SGAVifpFYtUV2lAI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fastec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a144a80-44b0-4d54-801d-08dc31e0d0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 06:54:42.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f95ea7c-9a3d-4add-988c-01b7cee9a358
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO7Vo2ZrVGS0AA2ZhsOOmZawPxWBlkEj7vACrJjsVoVaqEjDMTnSAXb6gM36X6R6Yuk04YSPhgQlealKAECXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1494

Thanks, you all for your insights. <3


So to summarize, it was implemented through a gitdir because of possible co=
nfusions with the working directory. And there is no other implementation b=
ecause the use case is not there.

For the new implementation I would always use the working directory. If set=
 with git -C than use that. Should also not be a Problem because the workin=
g directory it is set internally anyway.


As far as the possible implementation of this goes, I would prefer an inclu=
deif with an extra option dir instead of gitdir. This would prevent confusi=
on between includewhere and includeif.

The mentioned Problems seem to be easily figured out.
Every includeif =3D=3D true will get included. Every more specific path wil=
l overwrite properties if set before. Gitdir is more specific than just dir=
.
Somewhat like that I would say is very intuitive.

Another possible approach which I would also say is logical is a top-down a=
pproach. Every Includeif would be executed from top to bottom. Every true i=
ncludeif will be included and as before would overwrite properties if neces=
sary.=20


Best regards
Dominik von Haller=A0
