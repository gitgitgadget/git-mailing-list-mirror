Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kjqtft8s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ym0zGRhH"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1F189
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700091817; x=1731627817;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6Tya0L70+/3+MCsxRSIFevhI585uSMkky4AQVmeZp1s=;
  b=Kjqtft8sY5GM/ihkDdrosAome45Jt3KLrAbXUm8KT2Fq3M4T5DlQWOH6
   EhGFTntm+MgYQ1c+r5arpgm4ijuhzmmbE1ZSOZyrjCyVrSY0muwV9KuD4
   Lw5rvu7eJKtkqScdlQ8v7Hmg011iG2/tlJYvk0LwnFq77Ewc5otmVfkI0
   ZsgeK6hjH4+6XIj+0SkV4kQj3imFyxzXl+J6f3vFpolBf9F6UfTVECgKy
   UeY+cunKUASfR18HM270RtyNMmczWvf1UNx/rj9GDz4yEsYhe20TFwEn+
   JSoAzHlRRM/NDS09U/OFSfHpN0QQkjtqCqD1jFq6e85XRUGT2++R76poy
   Q==;
X-CSE-ConnectionGUID: FPJMAILwSySAxJkP7eHTwQ==
X-CSE-MsgGUID: qJ14frUWSyCDVHuN/N28JA==
X-IronPort-AV: E=Sophos;i="6.03,306,1694707200"; 
   d="scan'208";a="2483314"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2023 07:43:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi7jlzUsMgPqQ2zbZHG+1K7b7BswnB7csnrdbke4GQpJRMNt+26V4SjiuCtXsY+z04eQ5w3FrcfBkpPG41XQCdpIs35g87dY6XhV4PVHcrGy/mRPmXrehOWnRZZbRN2mC+5To12CvME3u9hpafqIjfsrNePJc6w61OUPfcxIS2HAU3+IEjGpiDcmU9umLJOTPiEeNDZllaWWHR9KueVnDwFum/sO7/phrPUKAvP1OjzQh5gTFw1CtJLEzCqxkWT4VXJIzpXPoJeg3NNhGRUdJeBjrmh0DCLhM3jK7biNopSBlQBC7PygqVW5FSv2oJwlgHHePalRQ65LUryuGhx9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKNbU5AAisznCdItvBlcnEBZkc7E+Z5qzYg1CQUpTX0=;
 b=GgnFvIHbrXKlZqP9SPA7eHrodnogBNFM/RvKk2NIyFmBfw+XZON8L7O4fv0zdD7ETgWdgLB1E+rHYwPkJ93vB9bmVw9EpIetqvMibwRjfojwxpv0IKxNKnUhOxXIN7e8xajIi48MvL4wOz26uIspolfYQd7LLCBrXea9ALos36LigquEOUm8FxJHi4Jn9Fpi+uEu4o5HPQhBauY2a53PqbcXJ+PNHErYd576rHOTuBdPB2YVyL/rB1AAe0mbJRpFEmZZ2Fcn26IbkOfwvlANZd6/AhMWFKdmGmDNfAP1AEFcFdHSROW08ASxzABCJ1KXAqc7nGv/AfxUf9RE+rvTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKNbU5AAisznCdItvBlcnEBZkc7E+Z5qzYg1CQUpTX0=;
 b=ym0zGRhHnKHJv5DubRIR2KjUEww5tRmSchC5yMNo/ymJaO0BhjuK+l4OJDC6ORmiB83HtGlcbw+EEDm+zomahS2olXLTjH9YE0o0NFUYjNM2nj1ls3mLtyO+/6XFuytsQkMGfoRmiQ3BNc5et/EqK/G0gMNtv3H5DBiRmZm2xw0=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by BL3PR04MB7977.namprd04.prod.outlook.com (2603:10b6:208:340::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Wed, 15 Nov
 2023 23:43:33 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::68b2:146d:d161:352a]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::68b2:146d:d161:352a%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 23:43:32 +0000
From: Mun Johl <Mun.Johl@wdc.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: What is the best way to fix divergent branches during push
Thread-Topic: What is the best way to fix divergent branches during push
Thread-Index: AdoYG9Gy8g17nqmQQS+YdI6oN0YihA==
Date: Wed, 15 Nov 2023 23:43:32 +0000
Message-ID:
 <SJ0PR04MB8289AF64E6C9EDED7B6D7A9B9CB1A@SJ0PR04MB8289.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|BL3PR04MB7977:EE_
x-ms-office365-filtering-correlation-id: a97be723-664c-4cdd-9bf5-08dbe634ad37
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 P6a4rb+p9MA+HMU1e3SG9YTepOZ0qasRz4J/Oh9bMPUHBetA94FXE6fWb3a7PwJF259AG/2fF65E/7vOKxguSIBC9YLyHfkPq9ddGAchesZcD9Z7kzcAP/intEIdMReY9WkwY7yvevvs91GnIrkfreuWPmqjbSckPurnl71aIMOs9b9uru8lHLqkVMnbgthi/E2oBqUPvi0G3mvrNa18amCjkkqrzlPv50ytsqMzDSVYVpYJybSKC3f66EJg608dG1fskIdzgu/MVBj6aGmY8nvbbus+7Q0azgfXd3uKRzkj55BEeIRpYvYZKKySb5o2N6qkitCQTKTDxwinlIm5wSHbGWKRoUXwJ2fsXWaMeV1W5CdRQ+0XurEHlQhqq+nrt4OpvxgEb96MWZ3VBgAHP55UqQCNhzmGhqMXxjqtsW5sDzIaGCoFac15KvInHQ79gR0AlMq+qPjIU2ylLn8po7kS7to5C6TrMWVUXExeVSTyPye73kgj8MFw9yvP0V86bInYmoyKbKfg5wgiDsqE66cAB5ZJjcxrbXG/PFHdnjEPPCeM4EGKv5PRsUnwezoQz6qdrWKMUGEYVh8qo+m0JPLYGaOFK0W77f8r48Ldql3f+h/Hq/H5dgDzxLu65Sr1H4+yvEBeNt2PsREbgrN4HQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(64756008)(6916009)(316002)(9686003)(66946007)(76116006)(66556008)(66476007)(66446008)(26005)(38070700009)(478600001)(6506007)(7696005)(71200400001)(55016003)(5660300002)(86362001)(82960400001)(38100700002)(122000001)(2906002)(33656002)(83380400001)(8936002)(8676002)(41300700001)(52536014)(43043002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vZHhZ5X14IKWmM+YRv5ewSrqlbolsjVzbGZ25YtcDyyXqDXOt/H3NHD6RMXE?=
 =?us-ascii?Q?kJRmOX8Su3Vc7s2rH1ku+f6Qc2MjJZqpRoeiizkOBXC0R9kV/CNOSiHWbi5J?=
 =?us-ascii?Q?oGizITg/3KrbgxBqXSaVZJpHEzFBAJTgd8bjMW2ypWdg2ABWA2I+x/HJpG8f?=
 =?us-ascii?Q?STgjf1jiCIeo0GNPmZl7TfLbno2YtFGxERJsbJTAx26ObxF3QJI8i6KeAFhV?=
 =?us-ascii?Q?sVnim3tAI0UjqmSPNk7H7ANi74SmJZaDEFhPvfH3uYsnCjggmF5eH5lMk792?=
 =?us-ascii?Q?4Kfmg+9GDnNrnACsz4TLT8R0qT+yV1Cu+iFk/b1bIfqYNsaklmuxPp3Bzzo+?=
 =?us-ascii?Q?rgtYCFegB3nAmIgAKPld6NW2tldQ0WuLlRcutEyjSpyit4SjkakcEBwh0Mo+?=
 =?us-ascii?Q?RbgvJcp5dRFCgmLbT7cHEdCF5/MsJx0rKzPNyz1TSSjaHjuF8mDrn7lf1HwR?=
 =?us-ascii?Q?Q/aA238Xo5XcxSzXaWQX+xofa8KWhLEHokGivDdJhOH+l9cADGuG5KNuVVkL?=
 =?us-ascii?Q?LU5UYXMdxvgO7Fm/yKggezGHyj43ml6MzM+X9mat6AyH10tw62PQku6g0GuI?=
 =?us-ascii?Q?mp9NUuutQ8IpEL3WIPpAyfKrfs7+/+4a15rTLCJTZe3S71FGg50+7hdaOOFI?=
 =?us-ascii?Q?zoMrTRNvWbBzysB5q0TciGBqpUL+SLli3jSOws9x2KDBgw/nIWA0SVh9bdEi?=
 =?us-ascii?Q?tCQVQ2t3e7ko56iNwt9vk+gMDs5dzEwWczpu1z5jMl415LICnNH8QuNqiw9Y?=
 =?us-ascii?Q?hFaFdqYcQ5OwSz585Bk75DVg++AQ3i6nDgygQVX0jcqW5WtBMY3MgmlxtHqV?=
 =?us-ascii?Q?wk3mN7+VHgmePt+uLgcMtGWPBwSVqTba/zlsgRjoWbOjl81LENtJPo9HBMHC?=
 =?us-ascii?Q?t2m/pvYo+E9ymQo/MqRJVobf15mlpxWMNcN1bJyxLc6G4o28YG1arvhkzmFV?=
 =?us-ascii?Q?XQRi0RDeiQQfeNXXDFXcARe+APycyEyuPvl1LNecPbIufHJvIhcx9NQCN3RY?=
 =?us-ascii?Q?Q2DwlWfKnpVGI2RiAdNby341AdTwghkxzLB5gcoMWmeN3a6VvHj+zqqY3dCU?=
 =?us-ascii?Q?oXyAFHiVaed/pUKPbWDQhca+OK2TFATXIVUEK3eGD1YavXICwoK8EWbDgRf/?=
 =?us-ascii?Q?dSzXt+yk7c6M+/RuQkw61T22rZj4GPUCDnqnyWpSWSqyWLT9LTYYChg0F7Fc?=
 =?us-ascii?Q?gPZLIdMRzmm78eaA0alJ2SUs2r8UrGy6/0R19IVmzi9GTXxcZ7HJHncJ/5VN?=
 =?us-ascii?Q?ugI61H67szW+Y/rhPdaIq5d1hj6/+5rfzBO90UPspVRQncdmmFXF2tsIxg9G?=
 =?us-ascii?Q?yBnhFLEIdfA+MfIAjo/e2O1VyQgcn5tOFnosadkHbEF0BQzWxZikVk690ThA?=
 =?us-ascii?Q?yRFLSpOpT2ZIVWwOHy1sqTnYuNO20+RoSce8RBN63BHEV+nDNAmZZyPd70md?=
 =?us-ascii?Q?hXTEH05ubMagRxCtghUTUkDkJbJFYlHsO710ORiTwFQADbMazYEBUoQ/N2hB?=
 =?us-ascii?Q?3MJ+g3h0gcWv5AsS94vDVw/yPN36s1ISa7agNgE7Idw4QiH/DZYB63LHzTHD?=
 =?us-ascii?Q?IosJI6rPioY7bbtcx6M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+hpabIq9xvTGglwV3eF/7mufXuD6q7i9Ty1WM9oM7q2k9vGlQIW33gTZYQBPYRSvjivMyC0ij3LNqxgx/ocAD5CTdCr1+xrQMMXGNiloVEbcnlF0Dc+jonedGcue/NiLO+o2k7nyPJO50Ajl6Mpy6IYH8G3pdX7v6uv7jO1SGu3FSgBg8SNy1EmIzeyjO05LHG/bmzN4IfGtmB447iNH/EWLjozAeIUopOt3no3ih8cCdn8sQPVdCWqtTeYWj95XQiOhgBu1Aab0qEV8PkoaNspUN/7uA0C1YzyinHXm3NtVgeXDEmZNH11PlgX/v5LJRY4unqKnjP51Kp0RmMORMXay1pCLGi+2QPBHFinojwJhSCIUjLSEo153M6VUTBuueV9rtuwpFxwh3HI0unxZKFevJk1Gp1SZzt36fACxpEM3RLuHS8uBKpZXcCQDK764HQvrVipW51YZNHnhlGutmTNXWtx85JzQ7/C0AeRshxjreQFdAtRPSQ5UCW8vbl728sOa4sh4BhVZig87EviZFJ9AzY5UGxEVgaLZ4QgEktw35V/fh7SbJbCmT1QtATzzyrYRfGm7xe2QSvtK4mwW3uLJCJssZaqj7cRxVHjU5q9tTmRXoD64qxO7QfgmkUyw58L8Kvq/7mRqjAqxoD/zrC1Dttp+KUHi0jvxo3JluIWCMEGnZ2m6hcbq1RHH2xVnYnZ7cQ2eWshGPMG1OSQpM0ixIVj5kuVxRM/S8ChnVjsmTjl7iIFXPizVMvVWh7c6FQ0XQ/EAxeksFi4qNFYCrmxd3jyVi4r94yCh/7HodQg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97be723-664c-4cdd-9bf5-08dbe634ad37
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 23:43:32.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1XrBFUJIwlTQgs9osRZI/iWtI1tldJigHQ+I3vVs+7lATj8r8PboL2vSsx9LsgYhlOddNc41f3rq+tNo4YmXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7977

Hi all,

Our team recently moved from SVN to git and occasionally we get our workspa=
ce in a snarl.  I could use some advice on the best way to resolve our issu=
e.

In general, this is what happens:

1. git pull
2. bunch of edits which could last hours to days
3. git add
4. git commit
4a. sometimes there is a delay here before the next step because the user f=
orgets a push is needed; but that is not always the case and the end result=
s are the same
5. git push

At this point we have divergent branches.  Not surprising.  However, some u=
sers say no matter if the try a pull with ff-only, merge, or rebase that th=
ey get errors from git (sorry, I don't have the exact error text--but I hea=
r 'git pull' continues to complain about divergent branches).

What is the recommended method to correct the divergent branches issue so t=
hat the 'git push' can proceed successfully?

Are the steps outlined above incorrect?  Should we insert the following ste=
ps:

2.a  git stash
2.b  git fetch
2.c  git pull
2.d  git stash pop

I think the added steps may minimize the probability of divergent branches,=
 but it is certainly not ensuring divergent branches will not occur.

Any advice in this regard would be greatly appreciated.

Best regards,

--=20
Mun

