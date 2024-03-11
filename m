Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2098.outbound.protection.outlook.com [40.107.8.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A0446A2
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167075; cv=fail; b=lMEiJP/C1grGRGjdTtCX5PXasCzKgVuVBxKoCAjOktnFEcsLdm+F7h1SCSC9C7inNN9iIMlnFhDPqKfworwtnSZRhWBFZKOXulLT1Wz2quQlinvVcsK351UKgW25aMbHxut+yXtz098kTgmhXrUwUlrAXgwXOTgIUx1uRmdgXaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167075; c=relaxed/simple;
	bh=D161+4XYSujrdYbAb5UxDcN8zLZ4qVTgvMpC0rGZJV8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kE3qxs2WCHSLxNzqk4WAMbUfktOD/dVzQoY+HBLClLwno2zc6ZwdqBLD6idLVhFp0rWRa4JzZ4hrYaWhQnOKIggFfMDwN8xvxWpzNe8GL4VvDUalJ0MgJYMCscp3jEr0c92JZv+cHleS6JcnarQ5Y7wQBXBhIyPwm6v+WzRcCN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metrologic.group; spf=pass smtp.mailfrom=metrologic.group; dkim=pass (2048-bit key) header.d=metrologic.group header.i=@metrologic.group header.b=Stf0olDL; arc=fail smtp.client-ip=40.107.8.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metrologic.group
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metrologic.group
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metrologic.group header.i=@metrologic.group header.b="Stf0olDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzK1AzBzf0j2Qmlg9DLEW+DxyWfyBp8h9UlhQEiUBxLWDUSFdjUE6fn1Q1ghABnPA+8J1Q9iTxX9rK44JU5WkRlef2+4mKo/FGZwhEOrCUBpfFaN4k0o3RD6RGluWTX19ma9pbOiTynirLU5CeEo9lIqaIFJke+fWNsuZ+7XyjZTQKbFi49cQlmsx+0mjlcVIcSgzHCc/SVci8Q8Jy5w4zCItCwZYHtgKUHRYeT7QPN31iVgl2aOQbqtWzlB+fRHeU/oXHyVcSZLPbXwX56G1d/E3tCEOh4A5yDsz/CD4saS1/YMeYQHuQLowkYGKmV/HQ6EfwpY3T8oOu9Sn4PixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D161+4XYSujrdYbAb5UxDcN8zLZ4qVTgvMpC0rGZJV8=;
 b=jenIOcJeDLJLRCL9D6f+Zuyqj1gmseU4idXE2MEa8v2/C4PjL/5W3eVpOtPywNVE0B3w/99aqmmsH/qJV4BTCtIdrkZICmEFuO42rC0aVLysREVlo9+UODX+XIlb+jW3UvJcI5wEyUKBRqfvkLrNXITG0zYqtQMK4EaMpZ+CZQezSs4XJgAliYR5GUNq3QsVxPP+hRjVALtUWdfVdx9NSoZ7NnNpAt8QuWflNJcJSuQUq+gtIlNGmcruxU1XgV5anF0ulfkujey59lFR02tSS43dak6JVd62NqsmQlJs47UXKPtfDKh8jEatB+kmrgPuAidRGBcaamyVz/uAksADSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metrologic.group; dmarc=pass action=none
 header.from=metrologic.group; dkim=pass header.d=metrologic.group; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metrologic.group;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D161+4XYSujrdYbAb5UxDcN8zLZ4qVTgvMpC0rGZJV8=;
 b=Stf0olDLF3OkFni/7SYG/f3vd1Lj38kYanLzEokOBWVB7zKwgtRFRCmlNKXFdXFuSqMubrVVr1TyJtMmzO1KALgTt6ojxhrikDAs/E+NlNlMN0IDOink+7/Qlv8g42auG/DDEe8patL5DGZRQK7mq6yQGqll6CO2NNeAdUJYMHBYdP3q9gWmjE9SEEVW9ah4NZTvjN6Pn3CRvX9fwa4PHrd8jAhc0TD321ekNjcgOD4xuakOBcil60P1DggJ0Pun0PskOl4EH1UnKnJ6P6yvAOVqHXp3w6lwaW3aTsENerdxNtnLerFsFPzvcaBg/s79HSuhj++FV7dLMo9VTtaV6Q==
Received: from AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ae::30)
 by VI1PR10MB3472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:24:24 +0000
Received: from AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6a3:609d:daef:8de7]) by AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6a3:609d:daef:8de7%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:24:24 +0000
From: Philemon GIRAUD <philemon.giraud@metrologic.group>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git bug report CDPATH completion
Thread-Topic: Git bug report CDPATH completion
Thread-Index: Adpzv9B/VWQfuITpRpK5uB8ezq6osg==
Date: Mon, 11 Mar 2024 14:24:24 +0000
Message-ID:
 <AM6PR10MB28087CFD43779194563F558492242@AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=metrologic.group;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR10MB2808:EE_|VI1PR10MB3472:EE_
x-ms-office365-filtering-correlation-id: 7eb55bf6-3aa1-4463-d7ec-08dc41d6f3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +yMt6bOu49IUGcNNhzVXmNOvuO+mmQ1/nf7X29N7y4kAmMxCvrhUJkeJ+4Ur5Th59MxJQrQ7M/gftIbt9PPHDwutjAbxxewKOAWxYQd13xta38MUHdozaY2BcCM1X1WCnc2NFO+x+cwrgqYi0vvaAmgQBRPGFzcoITQKvcNvJahQcMWLyknoiVqxaB33pYElbUvqnPWT+AlJOcYbV8KPJYHh2mErhFQEorY2SLn8T05zvPTvViqyrEk0RYGCMSTtv36HUp/+sACWTF26cdivDAj1N1PWmw7aRAuDvYK0x2N9GgwKskiTkvgP3EY7LwsH5eA2pfrhMu62kP0zUfNFcARHfktFqMcMq6PDTPUouuoULh2PSO+Lry7hmtYTR0aSm2wU8P7CJkpSpKhD+AHzN/y7lFMlMr0wSlRfFm8Q52G6mRqNPH/SNipMd2AzavPElfR7YLo0T8vr//cnVlRSkGdlC9vhm/SjZNtI5LN9VNtk5cQDd5DfaxerOs3HFP63lz1m7d6BsVHuCitWSQ4u5NU2CXEMPW9bZJ6e9K8r/H/fnSuCN1q4FvxgyVHtMhBpGQ7zOE2nuaxMkG1vaop2C76vOm/JynZEuL0NF3z/lA6NN1B/03c2Fm6/DDCoc0iufEEt093wDbAnQAdk7/XsP8sNu9PToZsnd6vjR0KS0iU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uFJI8gBYLIt8tJEyJErFVGx1mpvpZiQOS9tygiUKwOpqn4S/88L3ocB1hw?=
 =?iso-8859-1?Q?aa3tuHCUk4LQii65G1NcJk/+fj1vDcyyTNwCNoOBfFagzewtFl9CZqW+EZ?=
 =?iso-8859-1?Q?03PtElcHGSVUpc3ekfG+kcPed02fZN7f2paaObmbJQMfp/4poxWE0qJRlt?=
 =?iso-8859-1?Q?+Qw+8HgtJJ3icCRtLtB4nbkzJotNlPstrqRe/Vdxjd6jb9JJ1d+l+9qDk4?=
 =?iso-8859-1?Q?/C/9CxMokD7ZEZ6mjpoNJN0FbQLq/srnrMTLpuAkq2K0+cWigL8ytmriOK?=
 =?iso-8859-1?Q?oB1AwqNqxap/5qB9e1F7+eCeNoI4bk+Ga4b13tOH8jzLADmgB6/FFqEbFP?=
 =?iso-8859-1?Q?2oSCso1vJaykuC9yLxdr+5+RmXGC2UO/djIJKr43oGP2rf3wuOJnHGkFqJ?=
 =?iso-8859-1?Q?lEKAVs3/fk7L3WUYeXGtdjx3liOzxxeArfNgVKOu5Y2FnZ/yRzsfdkeGDE?=
 =?iso-8859-1?Q?ZfDkdAn6s7QqQmCkhQSzoJ3L4J+giCKLPNFmYEv2UbTLtH1KkRT2D9jZ/q?=
 =?iso-8859-1?Q?WMaWG3lnr02ik3ZAS3IgKsgQiexQv6vupvLR/6UwYkiLfPBjGr3g0qqYe/?=
 =?iso-8859-1?Q?4c7FxQhPe8m/g63nD8sD3PNVM8ys0sAqa8BdT7PG8Beme0ObmyBDKD72e5?=
 =?iso-8859-1?Q?zlugIl2+oVsBnFVBFAgj12wpUDTCG2HW5t9uxQ7qqQedmFNelDwcuBwcen?=
 =?iso-8859-1?Q?6Oi59DuJwb15w0Eu2LlGaTyHNywFjf1a0X3dMzzJvW30Tp9UZ5L9uCHMx3?=
 =?iso-8859-1?Q?K0Th8p0AtMy9h2Azax+nEF8uVXdRUXAeRM4/N/+xss6zUz0Ll/KbjfxNWR?=
 =?iso-8859-1?Q?2MzXDI/fE1S0DnSeZnm7j0ThkHpfwpwWF3wbutfhNaTxmL8Zpy+ddHN7Zj?=
 =?iso-8859-1?Q?QFdvUVSTNcMLKH8soCy+ePGekFj+MWxgD5Pct23JswR3Pn+gxdBdhmj6cj?=
 =?iso-8859-1?Q?iCFyqbh977Ef7RnuepDWJorsAjsKCQYKhHFk6qr50pw+z0FJJZuIZdqfY/?=
 =?iso-8859-1?Q?G2kcStaFehWqDR4owOBnXqGICQNW4qO7fhJKW2WeqUpL4MclDpY7IWPttz?=
 =?iso-8859-1?Q?GgCWIBWg56lqGKrmvOZzONg6N4EYCPtV8EBizrMyHfysIsMBWIBMfm85j5?=
 =?iso-8859-1?Q?yU0jv2G8S5+ejwtI8SIX8wDQM1nfMDrbODJJrtoGPof81lyxq1k4FsGWFk?=
 =?iso-8859-1?Q?YAoCjY6NSaOTyMm0dr9sD9iVInUQD8ae/3SscztYh5DmLHW/FmsOXAVDKL?=
 =?iso-8859-1?Q?bXOjchHB7rabEiTsDPVf4URDpygO4F4VhUYu9wtoqviaHwKQccekkPCEsK?=
 =?iso-8859-1?Q?QOIey/fPqWY0oo6IClghvTBzJCtjn/YbOrdp4CMxWbd1UiW6GJhAm5zkBD?=
 =?iso-8859-1?Q?ePBQAtqDwZMbvESYyKDHRHLv0gzfcu4oSEtTraPrignvzcr/LmARkR2Dae?=
 =?iso-8859-1?Q?M/0y29Oclki5o+dD0Uu6fxd1gYKzRxDlnbowLrHL0LXx8L4p9UFZvgC24x?=
 =?iso-8859-1?Q?pfkzZlhsK9sUrzAY0FozkB7Go2bZoTtEYDH+2opB/51T8emccSf+wici6s?=
 =?iso-8859-1?Q?QQPlUL09hheW0Uotk9J+hkrFob5YgMoMuOQkBakA7C5EyQb2oJ+TF7RAdg?=
 =?iso-8859-1?Q?vWNbY5ZbODcx9CsKo77ZgD0LpMHpaLrqB6/tHia8IE82VyGzamcxwYQQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: metrologic.group
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb55bf6-3aa1-4463-d7ec-08dc41d6f3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 14:24:24.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f33745c-acc6-43a9-8dc5-842ef4e7243f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp13AtP6EtqsCfxMnwb04QousBJPyTxfK9XWC+eIPRFtGYrz5tfKz1gz62vCd3mct0kkV+PHAOx2BrQUbx/vxRl1FDYLZtieedzsQmLNmGGVXvbH3q2/dC3xcn/H1Wub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3472

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
This bug is about the "git bash" that comes with git for windows
I added "export CDPATH=3D.:/c/some/path" to my .bashrc

What did you expect to happen? (Expected behavior)
Given that the folder "/c/some/path/myfolder" exists,
I expected to type (from any directory) "cd myf<TAB>" add that the autocomp=
lete would complete to "cd myfolder"

What happened instead? (Actual behavior)
The tab completion did not work, nothing happened when pressing tab.

What's different between what you expected and what actually happened?
Tab completion after cd do work with normal path, but not for addtional pat=
h accessible thanks to CDPATH

Anything else you want to add:
Note that the CDPATH variable do work: "cd myfolder" takes me to "/c/some/p=
ath/myfolder" all the time, whatever the starting directory is
Lastest bash-completion (https://github.com/scop/bash-completion) do suppor=
t completion with CDPATH (see https://github.com/scop/bash-completion/blob/=
master/completions/cd)

[System Info]
git version:
git version 2.44.0.windows.1
cpu: x86_64
built from commit: ad0bbfffa543db6979717be96df630d3e5741331
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045=20
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]
not run from a git repository - no hooks to showPhil=E9mon Giraud=A0 | CS e=
ngineer=20

