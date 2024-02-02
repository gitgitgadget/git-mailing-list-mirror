Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2107.outbound.protection.outlook.com [40.92.90.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9B18042
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869321; cv=fail; b=jQiaIYyFvQduV2Tg3cqwRVie/4YsM6bLGxSvlbCckoJvSWcmFdr2oxd2LFo7M83B/oHsAkZQPhGaOuH5pjKco4mau9b5G7xGKAAg763q28CjFeXtXOLqo1YwQw7yxPD4RocaBTzSBT0dy5BwcH+N24cyXddOmNwfVmvFw2qh/tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869321; c=relaxed/simple;
	bh=jUE5ts0dUxJq0j2YYccs+vWMgqaKaOy8u5K3wwE/7WA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ai2ACPEXoiuIgkp/pOqcs1FoHpVraNVkal61rQTIenjkyL+91PfBaULFSy5lHzS+RSQNNrllKqFHVjyfjLqI/2ZYcDppqAsebnbukEPcdvoZwoQxV3Q9vhkAouo039IY+msxVuQonIh/Ihm0NfRMFJPxBSO8QouqEYP840bO/l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CW/0n95z; arc=fail smtp.client-ip=40.92.90.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CW/0n95z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5gSLYwpQJew76ZKbTo61jsDvwSzdC+SqU94r0njzOKmBRNOWOtihBA6/ChuCehegfQIqlk/3trSlYGrf6ijNMz5uqMr22jPAI06wyAXMy+lBiumxBMNnQzczXxh8ZIKWKNKWTwOZyhX7yg/aqL0aKfYcCyJ4p2HxlQ3duuRediAWPabsgIKzTSXs+S0BbYJ+6723x/bAq8c81wvGF2GSEkrO62WnqSZ/+Jd4s5vkiNoUp+lAEbqibb9ghScXcCCGelFL0ZVflTl3kRCWqNnfWKqJb4nwP7J7JK/sltLRhtVul+3c1VHNtjmciqLAcP6tAVufYKgWc5aoKrTcAmKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUE5ts0dUxJq0j2YYccs+vWMgqaKaOy8u5K3wwE/7WA=;
 b=OHVXnJtlV+9ppeZP1lXuYSDHrGVd9WLzyKACaTrkmLZ0xxN/y0uRgPcOnjsHNCnsP/eLHldqU+lDrnxkdjXqhUUrA/AEtNL9oSA9ivI+H/X2CbzPPzRTQsz6qL6Dt3fElyL0BpMXgSTeAtkQvlXmM7jvKgSzknQ5a5euR5LuqAcucM7GUlGVPkjiY6cB8u5maL/Irb8jJiO5EhTpE/y4IjkzanT5KB2YCNfP44zRvwTuiQ7Q99qsvSwpDEzdmsgICRZXPrsazbpr9g5XzpQPwxsuJCBpX4my2D6r+HRGGgUdkjOfEnCCR3HqVrvLg/Drr4DlUxooVhoeSPq04Opg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUE5ts0dUxJq0j2YYccs+vWMgqaKaOy8u5K3wwE/7WA=;
 b=CW/0n95zFDXX7QDjKNW9z+ipX+Lf+LkaNWlZsGGVLs0sXSFCChVZ+LxBUWtJ9RP4g7/00AyRuOfXmNJSSk3PitG7LYZ0SA4NbLflGYOwNfEPl0hHxzwM/x/0no79dOkHsRGaxKjVs6ikf/JLaF/grM7n7uS4FYyHiBykgUX3BObQjlsGnFV0xopbi6t14jx4K8LyqvLyj9rWTiZjDZlFy/4PAMAHt+2GHYyURs+I1PHwIkHsBqs9gm4YCIdttKeeS9FTxPxVsnTjDEXek6mdQ3xR021jBKAGnN7m+lvRaCfwEh4sj6+sMSGm0ejrtRqptUnUE0AJnLZQvO+zyYoIvQ==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by AM9P195MB1095.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 10:21:55 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10%7]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 10:21:55 +0000
From: Hans Meiser <brille1@hotmail.com>
To: 'Dragan Simic' <dsimic@manjaro.org>, "rsbecker@nexbridge.com"
	<rsbecker@nexbridge.com>
CC: 'Konstantin Ryabitsev' <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index:
 AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAA6fwCAABmD9oAACw8AgAAGJuWAAA1uAIAAER2AgADvwtw=
Date: Fri, 2 Feb 2024 10:21:55 +0000
Message-ID:
 <DB9P195MB2130D9CFF998FBCB6100FB6CE2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
 <060d01da5549$6e93e250$4bbba6f0$@nexbridge.com>
In-Reply-To: <060d01da5549$6e93e250$4bbba6f0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [L5FrJIY9sl+sKccfSVCAKBVNaM9Dxhjx]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|AM9P195MB1095:EE_
x-ms-office365-filtering-correlation-id: 6165af25-bb32-473d-9334-08dc23d8c7f1
x-ms-exchange-slblob-mailprops:
 laRBL560oLTmV3YUZGBVpWtZmo3U4emCtqUDDGv6+Lrpcawn4b0EWmVmR8lojXOqAgxAaiNxkAhmHSsYTIsyYhl5IqTPKcU9ZMwa9qSXy7WzkDhyN1DdruAsucHGGlRLwCRVre6DHMdzyQ8HSmqND52olwZ+qkimrWknOBWF3pGjgDI6iYnkAbY9m93JIJblXzBjQomaKksKQa2qOH+kzKI65+1zO14+i0BbXDErkRUcs9Yt9SxfOuufK2IUd2Phem/VXBQUOS7dlVWl++B/l4VyjWHsoVql84SS7nEGVVoc4GujDF0efwOvusoVAqBRzkY7UWk+2tZ52ipn7+8LPD7f2bm9D7dN8p9ESoSaHOPdkKZtqQADvVItxciLCP2tmnh8kBT0+58EKczL6GeSbnkCxXONSXHe/F26C+UH5FBr030t8aut8eKV6YKK23n1uFChqjKj7qe+eCBJwtmdvFG3ft6q1XnI0EefBvgbDprQVtDymkm1XdQSuDHeZqjIH4D3h0o+wT7deeB3vNxwLHlaaENYp7n6V5B/dBIY0hGJLjqaobVq0VpdTRfEg4CcoK6kPd6y1L8xl6PckNTjajViZXoM3GLpWGFfSZSXI82ePY5xAR46ZAWxa9hjX5BiTVIL4Mfv4a1HMDnSvakWvHYfQTZrp8TM3B0nZHtgPIVmIu3TZYDvTIbkIlnSS6fdesvzimkvR+2EqaC68Oz2lOU8Gh0DzDRTBoSVB77emMJCGUVkPS5Ffwp1RJyyYWONxbJ5GRRCKtGpmPl89OFYS5fCvlr97eJS
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4MFSFOYCOVbpgGsJD0FxvZjxqqXPGoS8S2A7Co10HVNnz1KKKDyMOM3Clg+LCTvh4aw4amr+hG7x7w3sfgmoPugZdzV3Noq6sdDkicpDpg/ZHMQNffAaOy5YcHrLokwag+apToqyw6vqt2+rCT1f0Z7WNDjeyHUIG5gC7mLbB5FNYmZ/gg+y+qWGD/xnqe/gTgzrz06p6Skkooeu1kKChI7CHCm7BrdE5Mlmt6uAq9YSmGjc2O+jVLjN4dCFuICMx/g7SQArwXQS5yFyfu86fAchuOEdOJuxJnPktUbhDIkkM0jd0txST0p7euFEdxFVNFQBMSGxTX7cLccfCBx1QpAWteNN4yOvrqLIH4ywzAfgoM53K9EdyCI1yfnsrpEUVtkyB8IP19HQeDYE02CY0AyhoEcd8oOVTxXwbfL2+vuAClUBytyT5UUa5GZtlhhEgm7aJetJDMZBIQ9MfggvRJ7HEHZjbZ5F9rVolKpjNWnV++L2EX0k5AdViLtjyorqqEZkzgs1BLRLaLFanwA4RSeuxn8n1urW3gmxJwai85qDY5Yyx9v/0LjWBEqEoO08
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?un49w40N1yRP/TczpT8ej+vlSW3DrVZ5j44WGuJole6GYHv038ramzZPWZ?=
 =?iso-8859-1?Q?l9z10r0Degiu5tOqot0m4/8P5YPJSaDv/cfJzfNZjxULoCv8fM8uIeGZqE?=
 =?iso-8859-1?Q?lCYWuQfR4kgSwl4x//LYrfjn65zrBMpARw9WE6OdO55r2zbVTvrz7+4VRb?=
 =?iso-8859-1?Q?I2xtjo6uP/DCLxrolWsvTAbPUoQUovxSlOGaenoARSrwHI9sVdgXU6khFz?=
 =?iso-8859-1?Q?JtUsj8nUF5FobEwfLGmiCHfgxEsPwdjFbOp4SFd9ionqOZFZML/Z5ieY4M?=
 =?iso-8859-1?Q?mGtiM9c+2fi97/U2+rftaZxTyQ1RRG5z+86XZxL7C2xPxtVsoRVLfjiERB?=
 =?iso-8859-1?Q?dxYnMOxjplHVRw4dC49PYVcIgFmv2K/fk5bzf3wwzQpRNfglOR896NB9vD?=
 =?iso-8859-1?Q?oAFs3LLhmbK3z6DpdlnHpFOkx/uCWtvWpRh6rKwVgxAww4m1LMs9MIVoTm?=
 =?iso-8859-1?Q?YVzTSQ+CkOBNP9VvnMD2QZNZfeNsbkWopWbtjxBXdpNaSJnLnXe3mSWhTr?=
 =?iso-8859-1?Q?FGZNMpWVlwcnFxZT6C9FzxloM4h8MlGzLj8r4MLpJmClkHRu/eMKZM03q7?=
 =?iso-8859-1?Q?wd4q6DU46qLlsjXFQly85v+ajK2CiH0m3uqTnXiHLkJxxs01F6Yv+xaevF?=
 =?iso-8859-1?Q?pUHheWQ0mVUv8Zi7HTAu7OtU1fnbXfW07a0mPiTLWKfsYeIhXYym3GRw9y?=
 =?iso-8859-1?Q?O2gHq6gs3hSkSQa2RVJU8djjUlGEmj53WP4J25nrgMtmMgnI0FltIKLi7b?=
 =?iso-8859-1?Q?tAcFAZOLwWuJcGHN1k4wrXbRyAV7yap76hcWHLrqqIgRL6FY8clk3pc7Ft?=
 =?iso-8859-1?Q?/yzKQAkTBTTgGHBmfbnFXZPBWi3PLeTViqbYBdzMUwxCIHQQINQH0cx9Cr?=
 =?iso-8859-1?Q?Ll5KAZ1sP1bCF5f9dpLdMQzDVR5P9q//LbrRp4yM6A2SxdQyk2o5Tqg1bt?=
 =?iso-8859-1?Q?NrO5KDbp1lAkVhnVA6lXSu/pZtN5eHnj/IfWKEZ1teazIc7E0nqinRntSe?=
 =?iso-8859-1?Q?2a1LqMZVBpqQPNn4WjPKkOucCZRGBfa19Pr9fS/HWyPsYjhjTOEmqPDOBk?=
 =?iso-8859-1?Q?5DrqxMOqb0AlScLPntuSjsf7ffeM+FIngIKwST95JniPJ0NIoGUh5xeTba?=
 =?iso-8859-1?Q?3iqA3wlx36hbHPxg969etcrXzYcy16tUPJwSbGNKa2CQyx0b1Kepsd4qk6?=
 =?iso-8859-1?Q?4I+OcswBpyJYSeY5VUsJuWvxcZv8zB+EzjK/K0ScHK1TnWQBQLeSEB/m?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6165af25-bb32-473d-9334-08dc23d8c7f1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 10:21:55.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1095

> A huge advantage of using a git server is being able to mirror the reposi=
tory. If we=0A=
> went with a GitLab host, we could potentially mirror over to GitHub. The =
drawback is=0A=
> that the pull request history (and related discussions) id not (currently=
) preserved.=0A=
=0A=
I'm pretty sure that if you want to move over to any of the platforms, admi=
ns there will happily assist you in pre-filling issues and PRs there from y=
our mailing list.=0A=
=0A=
I just saw in the mailing list that a PR needs to be splitted over multiple=
 e-mails. Do you really want to cling to this old fashioned (I'd rather cal=
l it obsolete) process?=
