Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB01FDD
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532812; cv=fail; b=m9qVyOBO8Cqbsn3/gLCojRs7n47smNeTD6uzbDx40TOYruWizyf7BH4qBv+bUPBRNTworrp/Lx/GITcM6xitpk/IPk47m8920ALCQxD1C4Ee1fV3a7gc6/abJ7F3Kwja4G41F/0x3M19mJE5xInS+BVX/p0Rmetl+m+XugZCehw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532812; c=relaxed/simple;
	bh=rrMTH1i9EdgZWTbn6ONQiOKhv1pViGZvT8BUZ1sbEaw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gKSQK1R5IdnGyixdfFa4B+pAmWStsefA3RMGhhH9Zy6Oc63Ibuf+ade3jKWr44Yv9zzGhxYZ/a/TIhbPCXkDHAbtZHRNiiLQXEa8V7diec8e74AXk1GUjErN6+49WvbDDHio3ZDMYOBMI9ibAYbqjReZarjvDsXa1mPddvdhUvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gentuity.com; spf=pass smtp.mailfrom=gentuity.com; dkim=pass (1024-bit key) header.d=gentuity.onmicrosoft.com header.i=@gentuity.onmicrosoft.com header.b=CVYYWbAG; arc=fail smtp.client-ip=40.107.236.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gentuity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentuity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentuity.onmicrosoft.com header.i=@gentuity.onmicrosoft.com header.b="CVYYWbAG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ86/cf27UPvpm84i8+g3hznSfrvM+s8ntB0jvpdknEnxa3CX6LOcFBsNqf7Orookj9xlMcPxrJbYpxSgofcjGQdUlAvUIf9GyVTHNV/ONcbQ2ufOITv1vMK4L5ImD+a2sIFCsq2PJUzXjtUiSoNWxe9YLlSWvo/fMNiW9A7G6vGApU1txPNaaRpxa/brBdCK0ma4E6CbKg9yGBbyI8KuIrMH9JP/tMh/rLh9PURPn10g7xuYW+8x2tOy0VlwOvIqmDVQ5XfELARgW5K4e/gKr6XPdkv4AksA4LoO25ivjwqg7xFVLadK6Yy6opJB4B7bFtxRrqxgFJJigtmiBnmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZOfdu/1X/ZiGBPmLq/09OZi9u7t5+oWw04aZqX5pUU=;
 b=yg4wpUup85+DdcWG4YBCi+0eydj+khmXgPyPfUn3yFAdJ1pxZPd1sdBXiQmpHc5BgCQoyNDewmc0JSeMrrBMJTthOWciIsneC4LDAODdmMl3/fYmtMaRYXx0yo6OdnwZQJ1GeTRtJ4z8/BX4Rshk2huN07Ey0pPw4WvVR/ml6LgCqpZWmRgfQ4oOvjGerfNV7WDCgIKqpLZ+kDu4XufhgNHUK7ZDzP/ZhDagfsWaQOybSqphA588VyoZfhiKTRwV3ttvw6cbI6ixGD0EY+92EZPM9R9n5OrUSdHRSvH6VCd1o8ZGw3pVnSo0Y8O7n3VYxh15D+7uzXZ5ZWTbc0muAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gentuity.com; dmarc=pass action=none header.from=gentuity.com;
 dkim=pass header.d=gentuity.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gentuity.onmicrosoft.com; s=selector2-gentuity-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZOfdu/1X/ZiGBPmLq/09OZi9u7t5+oWw04aZqX5pUU=;
 b=CVYYWbAGIYWO2jtdLWkmvOPy45fk3JyUOZPNMHRgcbEeWkRUJ3Cdw4oz9e2iC58AoQSo0bAvftmRGZiXySg3a97c+PegwqRPQk6cokE4SZkrAEZUxdmy44c5NzR07B9dskFhHCM6mv81uqS92rmvd3wp5vLJ1PJCkr2baXeXpno=
Received: from SA1PR16MB6134.namprd16.prod.outlook.com (2603:10b6:806:3ae::16)
 by CH3PR16MB5428.namprd16.prod.outlook.com (2603:10b6:610:166::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 22:13:25 +0000
Received: from SA1PR16MB6134.namprd16.prod.outlook.com
 ([fe80::1a75:7f97:19db:23f4]) by SA1PR16MB6134.namprd16.prod.outlook.com
 ([fe80::1a75:7f97:19db:23f4%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 22:13:25 +0000
From: Tom S <toms@gentuity.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Obscured (overwritten) second prompt for credentials during clone
 operation
Thread-Topic: Obscured (overwritten) second prompt for credentials during
 clone operation
Thread-Index: AQHbtUjMKOJr9+f/ukyNfy9Gx5Axmw==
Date: Thu, 24 Apr 2025 22:13:24 +0000
Message-ID:
 <SA1PR16MB613444332129B96B51EF1D27B9852@SA1PR16MB6134.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gentuity.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR16MB6134:EE_|CH3PR16MB5428:EE_
x-ms-office365-filtering-correlation-id: e81cf973-9040-45aa-f052-08dd837d3bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zMzlNmMqjWjeHZcLfo6QTnLxPHmmoA3GKZY3vHyZb6z02Z6/8+08IZqvcl?=
 =?iso-8859-1?Q?Ibg948dycwMuIeelWqlNlk2E8G+PMcOca5ecUdYWPenE8+0EUdBrgsDh+1?=
 =?iso-8859-1?Q?nyNOa88+63CJOt6ARSwzQRE5xkKGgsGe4Qw+exdLquLvLMDDqwrvc7K5AE?=
 =?iso-8859-1?Q?gL5fg6Fc+54idJHSlAFRvMIj4jJyby7vLMDec6M1LqaVyhesxRDbW/smbB?=
 =?iso-8859-1?Q?bc5kAl8xkkS1PD6sXqe8QG5HSj9w4ntuwwQxgQfeR7UXiiPJwd8ejgcXrs?=
 =?iso-8859-1?Q?XaWnHd8d7W++l28L1gVvDdq+Z6kUOS411asVp1M3ajOvBKaPs0ZAAwGnjW?=
 =?iso-8859-1?Q?Ln0enlbR/TTe/kPnHZv8lz/ZCpOa0cY0SV8+50fT0kgZKP8ZcdQK+cKXp2?=
 =?iso-8859-1?Q?YNYPbfjPht9X/pD81eUmDW+anDUUsfE+qFK2NCoazdVcdRlO934A8r71NH?=
 =?iso-8859-1?Q?sEVC4HjIU/cOeJpwu+evcb3C8NFtTIaK4nzHk/Z9RWbj18Pr+KBRyA1dsG?=
 =?iso-8859-1?Q?aQ3+CZYzd+tah8AckjUEqn+qhV1DamGQa7zflgnxNeAMUnHDsy0I1Y8j8Y?=
 =?iso-8859-1?Q?jqFZV4oMOCDSkzoSXRS1puC7MJ9b+e275PSYy498LV41dnZjT1xUbmRmwp?=
 =?iso-8859-1?Q?mTvYghZIH7MkCCbZoatDXnh++dxPfadAayM0EjxyiuzCw1bz16azJPKaa8?=
 =?iso-8859-1?Q?5ntTRGoecGh3KFaFKahTrexz3COSJUk4srqpe5sh6hCB+doj2P7UC06XRa?=
 =?iso-8859-1?Q?mSVUepeJ63TrTUMlVoSVmR9DSKDBSV3jQV1OeC34qH1WuhA4hR+3lMsdRn?=
 =?iso-8859-1?Q?czxEvIqrQI9/589KbVitJfvkn71jIQE21+wuHRC+s8j7eFbxp0Q7PPtOfQ?=
 =?iso-8859-1?Q?HJYg0ExMR8EsWHZQEGAqzHzGkcEtnUpohpeyCEIan4sg6QyFe7oFJI7OCt?=
 =?iso-8859-1?Q?fmCKsqjViJ4q2EPgIxDuma7YaAg+Zio2iszDgCPWBsa99E64ipUyNeKCkR?=
 =?iso-8859-1?Q?6xJAOpOm3OMBXs6hTRiDO0V02jJ76CdQyyzViKZvkqYUaD/N1zwf/iDrmT?=
 =?iso-8859-1?Q?l3Sxw/2ejEJVH7mOZ39IKcrL3gxxT49SslchBmT6MG5TNNJweEltcC9SzT?=
 =?iso-8859-1?Q?Mj40O0CkZPooi7Yqt9MikL4kqPwJLULfK4LMoZ8ywbI78/VQpfQC3FJLLQ?=
 =?iso-8859-1?Q?Xmhus3YOJoCrevP5BgE5Sp8xJEDMKEg4jcH14m6j3FPOjXfSiXw/DgfLWW?=
 =?iso-8859-1?Q?DPqN5ZNwOfM7AZMM3MWzztFWWbXCrqKbzTNw8uk1M84/PpqEfx4vMORo0d?=
 =?iso-8859-1?Q?uWW8ZyOZOzE2dSR8opDkT2P3U26GNZXa18yWGEHEr3/o3koqAmmu6LvDxR?=
 =?iso-8859-1?Q?3EKW26aUrntVrAAH+AtfcbYb+Z67S/vZ5YmZ1frZot7BJBKV9HJczbD1sM?=
 =?iso-8859-1?Q?UwymipbtrmetzGuxpFboC/e3bYcSIA70dGYa2xUxdGfk6qYRjzgBEYdM44?=
 =?iso-8859-1?Q?CtjGiz//xFUZMTIbIDpP4PjtVumjGLU6n0NYjNgmHf4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR16MB6134.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mKI+BDdxewHOztsR5hyMry3gw8JB5pz6XpM95e/pZD8b2VI+2AWR/Hpmg6?=
 =?iso-8859-1?Q?SeSaIE9eqMZeiGSO6ZyX/lNDOsPC/Sdofd5nAueeZFWlKYfFQ2BDYDg2IS?=
 =?iso-8859-1?Q?yl7cpPrXHetzCWB5pLrVtGujKaDYQlY1QamTvB9CBh+CQUWd3a4rMxyhhT?=
 =?iso-8859-1?Q?WIPsNgdw6LdlTgGTEYpZEQESo2ZJsg9tuhfXivTuUxP7mk+F52gdzbMkze?=
 =?iso-8859-1?Q?YqEblrVY0WorkeP0XYTuYYdoKo6a7T9V7Nzx76QWazNZCqEac2mJMK8aNe?=
 =?iso-8859-1?Q?cBXld7eqmwEV6sr7k8eYh88qzSVtHwLd8p0kVRX3CJMue3V2dO5jXeixZB?=
 =?iso-8859-1?Q?NQA079u7Icd5i7Mu1JnDtl+qv1bxVMWSC3KCE6APe8Aj85rvcuC/xxnycF?=
 =?iso-8859-1?Q?98hDdEH4yIw8SruxzW2u6lvm8Tlxq4LLHcvHa+MGrdvs4D4IjcvzruW99Y?=
 =?iso-8859-1?Q?A8psN3QA2g2pSFPrGl5DWt26xST4v8Gl8B01XDFVVYi/9VDtoATguqsMpe?=
 =?iso-8859-1?Q?FYoqEJ0HrEfro6gULH02+okRrGdH3cjuEOTtHXymJAHo+LUuoGXgRdAkNy?=
 =?iso-8859-1?Q?wYK9In7D9dmt+JAOaEAHwDjGi4c3PT0P2PYmlrJvFOzDAL4zZ7vtOOfRHq?=
 =?iso-8859-1?Q?vjtgydFcHlCxYKFSWkKis1pSxmw2AvV7JpK1oxmufyg34kPpiIX9ee+67z?=
 =?iso-8859-1?Q?FTmwtEduOqPr1+wAmPiNANHr6iAmoMV72X6NkaCAl3zxhr1LzyQHNKG/ob?=
 =?iso-8859-1?Q?Dhkt4RU4Y5iwdfhmJZZyVJpgwQZJakl/HXFoa2J38aOLZ21dXs44PP1adb?=
 =?iso-8859-1?Q?lTQJPZDMEiMGzmzCG/PLs0h9kvotDNzN9sue/8Q9lK44GrB8EMFWVSMDoR?=
 =?iso-8859-1?Q?99SyjseHgYiWyXJnss+S4MZ7bXvGRA51dytapTeuWS51w3ZpxNqRricgLG?=
 =?iso-8859-1?Q?T8pGOrV4P5nt8Ko4Qv6qv2rrK1ETk2iq/zn/45Ri3ucy63pNFSbFpoYwhf?=
 =?iso-8859-1?Q?//MjS/5F2s2nxTn7x68JRFBLMmHXbbm6f1PxeFAA96t32wYjIanPqhiQl8?=
 =?iso-8859-1?Q?7dxrIik7GjPRWhaUlw8eCES31oz6pu6cIp6NohPI0QXMMKGgtawiObqMfJ?=
 =?iso-8859-1?Q?OMRTcjP0ZTWLIQhdpX19/aPXKpsFCfJe/3Ln+hee9JD2QQx5JAoSDGRl6y?=
 =?iso-8859-1?Q?4fPOPiAzUYDaebrxlW3BtxmYyDd0pw5RwVG6YRdU1tmhLeW/lk+CtBggbj?=
 =?iso-8859-1?Q?kaqFFAMbbPk8Wn5/myaYSLzActBW+nPeE1XhvId7z4fpB+ZxWIqO6//c2h?=
 =?iso-8859-1?Q?q4IXXoOBZGyvkfvonH9AEocriwrD3rja9ZJRqytxok9JdbfEDyIvMlo8ix?=
 =?iso-8859-1?Q?jyN3qDO5GzI/D36GZ2YCYxjPeIXkhvBLNboLVHLiddudXcExgVywuwhSz5?=
 =?iso-8859-1?Q?CNAfgrsFULvkIn7T57Jsl96dJCu+WdaZ1UjQFlkR1FUbPOVPAOwuEVPAX7?=
 =?iso-8859-1?Q?TTyHdLfNT3snBQBLEeQdNik76sHVFUGnr3O6IMhorPS98Ru06MWHXWvnfl?=
 =?iso-8859-1?Q?d6z3ABjUrwoHnX63ajo2Otdu7IYKnk4g2/C/zpD630sOciGGjMeDywphmW?=
 =?iso-8859-1?Q?Q0Yn8cH2UJjxs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gentuity.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR16MB6134.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81cf973-9040-45aa-f052-08dd837d3bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 22:13:24.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c96e594-c845-4da7-a050-24c7941b1aa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfHOLrnsYFxbJv1ubuwK33IfhRSHgeYg/Wf1OhCTDpbt5AagBXiIW8HvgzyVdXbDGEa89Jc1Xg0SDuhjK0TgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB5428

While cloning a repo through HTTPS from a locally-hosted GitLab server, I w=
as prompted a second time for credentials, but the prompt was mostly obscur=
ed by other Git output. The only visible sign that a prompt was present was=
 ".ocal':" on the line that starts with "Updating files". This repo uses Gi=
t LFS, and I suspect but do not know for a fact that the second prompt is r=
elated to pulling LFS content. By typing the username I was able to elicit =
the second prompt for a password, and it does work, but the first time thro=
ugh I missed this detail and the clone operation did not succeed.=0A=
=0A=
Assuming a second prompt is necessary, I would expect this second prompt fo=
r Username to appear on its own line without being overwritten by other Git=
 output nor advancing the cursor to subsequent lines.=0A=
=0A=
$ git clone -c http.sslCAInfo=3D/.../<redacted>.pem https://<redacted>.loca=
l/sw/<redacted>.git=0A=
Cloning into '<redacted>'...=0A=
Username for 'https://<redacted>.local': <redacted>=0A=
Password for 'https://<redacted>@<redacted>.local':=0A=
remote: Enumerating objects: 179533, done.=0A=
remote: Counting objects: 100% (179533/179533), done.=0A=
remote: Compressing objects: 100% (34949/34949), done.=0A=
remote: Total 179533 (delta 144313), reused 179448 (delta 144269), pack-reu=
sed 0 (from 0)=0A=
Receiving objects: 100% (179533/179533), 870.75 MiB | 13.79 MiB/s, done.=0A=
Resolving deltas: 100% (144313/144313), done.=0A=
Updating files: 100% (2881/2881), done.ocal': Updating files:  95% (2737/28=
81)=0A=
<redacted username>=0A=
Password for 'https://<redacted>@<redacted>.local':=0A=
=0A=
I observed this with Git 2.49.0 with Fedora 42 on x64 using the default Gno=
me Terminal plus tmux.=0A=
=0A=
Regards,=0A=
Tom=0A=
=0A=
=0A=
