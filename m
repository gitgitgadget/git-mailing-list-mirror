Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2116.outbound.protection.outlook.com [40.107.94.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F02E659
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140199; cv=fail; b=Ebb6BYns0EXa+UNUWkd4N+h+3U2DJlHoSJ6JOcD3Ih0YCCa4V5hPsJfNBsIvGYZFvdBFbBqSCfFSHF64AKryh9ixYwWiYBcOXhgpF9G2/R61cIM8zP/0l4ubnjuA6cPgnTQSEeHX0r1MbtFXy5PUX9bSbj0XWhOihOu0ToQJ4YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140199; c=relaxed/simple;
	bh=f3uLswQthIs6Owej269RTkJUd4qJ6H5hGfrK/iuEUD4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l4u231GF7mC4yPIpcmO0mNcOiSTm2B1gcq7GybVqSCSJ3Xul0XmP7oF+Nfkp0z7kUrEDtrS+iXl+bumTfE8AizV8Mbnmc/YjhwOhctaQmkJbaqhBPum2ORzyYHK0+nj/LlxhVtMUnr7fkw00JFOpxw5+3LtRs6NNf7vF6y/w78o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=temple.edu; spf=fail smtp.mailfrom=temple.edu; dkim=pass (2048-bit key) header.d=temple.edu header.i=@temple.edu header.b=x+jW0xkt; arc=fail smtp.client-ip=40.107.94.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=temple.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=temple.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=temple.edu header.i=@temple.edu header.b="x+jW0xkt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N12BJrA5AXjm96movNvYK0zYyq0Bnne90sHwTBzqf1yyvugyxdcqVhle+W4zm01ugKdNmGzrUzojdg+ShQqs0JcOkqq4Zhjgd152CXYowljpDA97gpgfng3MHIW5b0tY74VME5yLtSmKnnqWBrD0J7oiszHFK6cfaAEcWF6Db2Dm0hPGTsSJJlu4LNPTtl8nF/yIE+dD4Ce/InOaTEnTskEIp8pa/vaKQSXNVHFx9QQaiVfUNC2s7zB5Y0C2H344ASWMbdsbTdSmEA/RtuBgkjFreFYG5aLo53y/3ZL7sRnNjmrh50ZDMurWEzNbZabkaFoB9q5Uv/Wn8+IErk4YDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bEut8dPxdN9nveTST+xtC5XzrRSmO/fLNlWuEinqM8=;
 b=tzut+X/5djD9H4jDh/g7Y4O9b+sSEGzHl0gx9gEdUWiSNXfoS/NtCGkMr7DfibSeArR6PYWFzhKI5KRgjT0Ib60E7GK4RrcaJSzgixfnpeGmWYMd/NKw4lcD68LFPyvLHWQjEaWz0H/Pi3ad8Ttd36PvficFX7k2qqnzD0Rvz1kTTX8IkZyrwP0sqY6oNo5VzaperYPYiGKt16iSAcXkgA0PTcA8zinrLkSVjHXhcRa4Puejt07qD9fqVcmYKjlyTTQVBJCCNFUI+qNz2GHK6dKHivFekWIvebjqWvGfVfoiCClq8fcR9zOaziMsCtjrAqICfMRBQV90QQCMdM1C4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=temple.edu; dmarc=pass action=none header.from=temple.edu;
 dkim=pass header.d=temple.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=temple.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bEut8dPxdN9nveTST+xtC5XzrRSmO/fLNlWuEinqM8=;
 b=x+jW0xkt85Y2Ru9rt15mwFAkl/n4fKuzXpn/Sz/lsGsD7CUIChk+YGHILTsysvjRoWHCbx90CcOoTFADAbKRabax03wpto0BEFM2bl47yTJF688JhowiXWYj/fJGQ0uxpwsc1OcawOIjR2l+6gnBjcUznocyLkvPch6GMOt4aYJR0vjccW1aBIirxzH/Fo5teLyxubOwLeVLYlnDceoso+EavnLdh6vD2XIHK9MLjjYhMI5AKXvBQyq4pCEG+ZHoYT4iNofcSeyIRxQBCqCfyhe139h+H4WjsrHfmDqky/riu3r/uQAk8zAUTwEemVlGEcRxpIjrN8Yr4anhIz68uw==
Received: from MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Thu, 5 Jun
 2025 16:16:35 +0000
Received: from MW3PR11MB4763.namprd11.prod.outlook.com
 ([fe80::f730:f6c2:565b:a3ce]) by MW3PR11MB4763.namprd11.prod.outlook.com
 ([fe80::f730:f6c2:565b:a3ce%6]) with mapi id 15.20.8746.030; Thu, 5 Jun 2025
 16:16:34 +0000
From: "Scott Birl (Temple Univ)" <sbirl@temple.edu>
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: "git config get" returns "error: key does not contain a section: get"
Thread-Topic: "git config get" returns "error: key does not contain a section:
 get"
Thread-Index: AdvWMlT7n+SU7vrKRke7Sg0lXr9IFg==
Sensitivity: company-confidential
Date: Thu, 5 Jun 2025 16:16:34 +0000
Message-ID:
 <MW3PR11MB47638E3211C195DC1C032DB9C36FA@MW3PR11MB4763.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=temple.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4763:EE_|MW3PR11MB4681:EE_
x-ms-office365-filtering-correlation-id: 8dfe0c12-2c66-45d1-09e8-08dda44c577d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z7DWueppgLav8hqYj0lZUKMgY4/kMQ4Nyhq1+FO2Z6f6xYs5Ku1H+vIN4lwn?=
 =?us-ascii?Q?8FYSJgLL0qElynQ2tUA80R1QAljgd2d8ec7C3Y7Adw1uwJ3y8ut5A/4jSoO8?=
 =?us-ascii?Q?fZNvg458GKZe4TlsHmCDxoEGL3cWpK7yJ42DyxsaIgra9P3EGA+5hetrWhwk?=
 =?us-ascii?Q?0/EC9XysVjb0UTC0wLzfu49hd6FAfThdKhKDkU0c12rLOfKiQwPJ+SfZlqHl?=
 =?us-ascii?Q?Wn5ASAAjH6TRcCVOaYnKg+9vEhwkvextghWSKUPuHjE4AHtXzDFY8lI/vR7s?=
 =?us-ascii?Q?x7DbRi5PNpBYz/AxIbYfzz0KIMKSJh0sLgnubs2uWmA6n8VkFb3BO7k+YZRz?=
 =?us-ascii?Q?++eF8fEWFuJWubsY+NnJNxrWew6CwJZ/NUAXR+FuOJihl1p0YVHDgOPdJqHT?=
 =?us-ascii?Q?pWYWysOr0ggRaOmK6Ua281aKBtJQczYlrn4jeRVK3WDaDiJ7ok3XxShY+YgC?=
 =?us-ascii?Q?x+SNzacksh9uW9LHIUb49g4TUpsrfVu9YUJNOMI7QvIIhrr2p8YZd1w/6Lfv?=
 =?us-ascii?Q?v4ylKkO4+JF6s0mt4oTlWpP6L02SKg2MnWjWpvqV2ZdwBLqg4jTPk9xsTpqU?=
 =?us-ascii?Q?W3NHTkp2cwTps2Fw1QlE5GulNB9YqWoxabbkMBo3xjVyxa52Z8H2JL1yBFZ2?=
 =?us-ascii?Q?dJ/3UxZS5MWEXfbV3G1G3NK8EtZnXdt62zpumUNf4ju2wk522L/kpnRYTnQO?=
 =?us-ascii?Q?ReBq7CrgI+2tvxtNoRqpaaZoB3ptgn18DDcFDw/rJor2R0fBL+wsF4KZRXN1?=
 =?us-ascii?Q?YqD0cMAmTbESlJ4PL57daVx1BHOw9sWRUZr+cM1XEg6zQ6PPt84xhjRvFxOL?=
 =?us-ascii?Q?wsZk5il18GRcUICr+Xc9Us1L4xVxcFH6y4rMCHAxxH0cT4S421OpcvZ6BmDU?=
 =?us-ascii?Q?XFWS/dmXr4CYZ3VqRzDR3VeKANGnag5bIMAYvqog+hslRx65/JKZ97J3Mw9M?=
 =?us-ascii?Q?kqvyV/XdeDDb6uCKulJaOHlVJif5E/YkZESrfmUZ+UX05/jsm7b3U0wh8JlB?=
 =?us-ascii?Q?0SKtVdxgBky1+e1qMC6Jy/sxkM14/l/7aBjyhw8ihdwIFVaTejP9t5RV7yvq?=
 =?us-ascii?Q?iFuPagciKWbWTg6e14uyIS+kUGt/Jc5O4yeOnpYLkqVlf5tE+8A6EHW5yY+w?=
 =?us-ascii?Q?57M45T6kH480aGePvxIwYi9BUIBtKzqEma2IgoeCbZ2QiP1ww4dNEyobcoXo?=
 =?us-ascii?Q?uo+5GzpquG8zwV0zx8RlZYO/YCCINHWXifjc4Ctn83cK3KUOL7XI+JDZ145G?=
 =?us-ascii?Q?z8Ic8xywcdJ/UeGR8eDWGivDHmKddfAns0yjl3cP972UH2GMaQ7WAqnlYJ++?=
 =?us-ascii?Q?/KSQtGLg17cX+iBS8Y9uvAZKjPJYFGO+8njI3pF4B1qqFvPTDAS6mTbBzJRt?=
 =?us-ascii?Q?BB6PcYfMk64cN/bieHR3cUH+8Mz2tqoTc9otBOu9TcJnUqcXyCa11q0jM12c?=
 =?us-ascii?Q?wCPEFvb7WGQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?suRVkRRV9MRlr5NW6JH5S7EVod6A/6tKZ4Ap4ESJb3/c9++okKQoM6vU4Aoh?=
 =?us-ascii?Q?H5SUoyAzpbugwxhtOygQjW9AoiF/d8biygHCSro7CGcOJWT+O4+Om7t0H2oT?=
 =?us-ascii?Q?DI3SHK63VNpJMFKI98liNy651uwnq35HG7YC7x9vvm/B+0Flol5np089BqqA?=
 =?us-ascii?Q?6JOC1qA9eezdXeIKCX5G/wMRYSIe40/+bWuhFeJPCVA7ICo8BD3jNrP69AEK?=
 =?us-ascii?Q?i6dN2EPyicXJvAM5mhWx1DtXhFsPhGE68pO9aRFIKrCppr9o/q/122aLHaix?=
 =?us-ascii?Q?475k1nS/knaH5I6P8JcJ1iMq/GcMZGVwlEk1K8QNBEFdI38nsFHa1iHwYTS+?=
 =?us-ascii?Q?FSOKSUbT1jWyQkHbWpEVdg5dqPsXsMhFDO4ma5wpUPPP8QDAmGsU0/gm2hZz?=
 =?us-ascii?Q?BGxOItVZopI0JcktDQy6HnUh9MZ2Vom9khZLljcW+hSIjGsuAu/dzwqYNdv/?=
 =?us-ascii?Q?BGd1upR+UjhQWLkcIh3d7dA2LyvTKnR058V5Bpv5YxxcGe76DlkoDVxvrlsb?=
 =?us-ascii?Q?LrXDqWd0/iC0NyRvtOGqIVebtRyt+MTtby/3UNLkrtPt5dwkSM6sXFpMy+G3?=
 =?us-ascii?Q?6wt3NgSe3Xe1lPIPoHOzqhAIUJ7yv4IP+nZbDrSyK1kOzG9ecDMb8GgSsevK?=
 =?us-ascii?Q?Pu945XoRkfhDs7X16cL+eTDAKlAm7roKyqfcT+hY08QNvM1SYJG2NFc/qJ7r?=
 =?us-ascii?Q?nYIr80hOXADFs2rt0fjA/vsolpx6xpgxcCZwm7w0E/8utBeFVBp/JPpwpySV?=
 =?us-ascii?Q?Q3VnKDWcfA6N1qtXNewoTi2imiHAu3OYUZQ15hh+14xzmwb3Zt4u6ybbnr6n?=
 =?us-ascii?Q?sD+R5Toip25bGkx1o7yX/+Wum61VBRAajNLv8YDZJp1zSPiQ8p+7lkFw14eR?=
 =?us-ascii?Q?CJNzLrc80b34iBRQrzT6ktzURKbOuY51BfuSgOagXWgLwBGsjpa95P948JDZ?=
 =?us-ascii?Q?UgseeTqi0zsBFWXy7YErcSExtHsJJIJoNdBdcLfTAw5qzb0x/qQszhee+zoB?=
 =?us-ascii?Q?7pHihh5Hc8zsHUnq7KxaHWFV+gVC/3WdktfMCIqxynxplhOmUSeYQiiNYe+x?=
 =?us-ascii?Q?f/eUHa+USjrVHnnuDOrlXxqzUYVJULym/l//w+soXlMUNd29B9HDEHyXJm9h?=
 =?us-ascii?Q?fRMeVppSuJjsRMwFju/z1x4g1BpOxHiNIgA9OcqU6JhbE3J7Teaux1S2WNII?=
 =?us-ascii?Q?LcE58TSFlGnIgT8A+mKBH9qvYrNuH25sVG4k3KHIMb4w5514Yxe1fE8B8anc?=
 =?us-ascii?Q?/MXWXsbFhlWj8Fz7hzOGxLP6LliBlIpGbK05LiM15NAV4EzxuzKtYbNlkv84?=
 =?us-ascii?Q?KyrYLUNbhWSqKLKCLywj1KBDietbKh/+ZQho/PKfUQHsx4QCzCGCfwrAvPuF?=
 =?us-ascii?Q?KEwC+CxYTDTEXBaAt8xB4xC9b9bDhE7sJF4xDf42Cq14DxRQxmXiJqzMNarr?=
 =?us-ascii?Q?XdWz77TF2BtmwKwUgotGE55qDy3NoZnozCXsgOJpLOrnP1WLyUl7fgm4F3LO?=
 =?us-ascii?Q?guE3aml3WmQ+mSA+mPFlVZasvkcuOZUIK+BttBpFXht+vk+2t9CjnWgEkKtz?=
 =?us-ascii?Q?nlAiHunbvCGb7V5dj6M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: temple.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfe0c12-2c66-45d1-09e8-08dda44c577d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 16:16:34.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 716e81ef-b522-4473-8e31-10bd02ccf6e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9rXUgUQkpBsjYZk/wDskYx8HYzA9LD/TIN39Jn3tmvxLb2ikkVDpJFQNZCllfVC/s0lt8owaULkAWfqFxRCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681

Hello all:

Debian 12/bookworm -- git is already the newest version (1:2.39.5-0+deb12u2=
).
Trying out examples from https://git-scm.com/docs/git-config.html#EXAMPLES

----
$ which git

git is hashed (/usr/bin/git)

-----
$ git config get --type=3Dcolor --default=3D"reset" ""

usage: git config [<options>]

Config file location
    --global              use global config file
    --system              use system config file
    --local               use repository config file
    --worktree            use per-worktree config file
    -f, --file <file>     use given config file
    --blob <blob-id>      read config from given blob object

Action...
-----

$ git config get --type=3Dcolor --default=3D"blue reverse" color.diff.white=
space

usage: git config [<options>]

Config file location
    --global              use global config file
    --system              use system config file
    --local               use repository config file
    --worktree            use per-worktree config file
    -f, --file <file>     use given config file
    --blob <blob-id>      read config from given blob object

Action...
----

$ git config get core.filemode

error: key does not contain a section: get
-----

$ git config --global get core.filemode

error: key does not contain a section: get
-----

$ git config --local get core.filemode

error: key does not contain a section: get
-----

pwd: $HOME
cat -n ~/.gitconfig:

     1  [core]
     2          fileMode =3D true
     3  ###
-----

Can someone explain what's going on?

Thanks.
 =20
 =20

