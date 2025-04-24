Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021110.outbound.protection.outlook.com [40.93.199.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865762580E7
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528269; cv=fail; b=XFBYt15RRhLYqe/LOsqieUaz1Qtam5xFhIFX02w3OGM8ZfEHVEMU75Z1BUAtCAhrF4zWgibMtiEbe/gUGCAn0m7YbYZlCXHveDWoTGdxguf4U4Slh35IBmU7xoROZAl56SxDUuCAI1k6t8XADkEPtC420hA4oCEftiQEWHAfUKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528269; c=relaxed/simple;
	bh=Y7wNJuptELKsCtffZO5RvVOvKEXxbL8UGOraw20ZoN8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KmI3McKRYDkx/zwwevpttf5N4ZmliXZNMUfkOpg4AjutwHXac2iYLRcDXJHAnDddUBze9QKJhQXb2WHNn/B3LHOLG9W1GxTL75gSkCPx7OSkbAVUr66OBpNoAziTGw34/SkNX8jnasvIzh6eHSZfxaayN8uDBZ6K8746t1epTiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Saf97Vm0; arc=fail smtp.client-ip=40.93.199.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Saf97Vm0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVd9wQ/ZmPVIFaMtbH2HwzQJYz2j5zNdf0b5G129JJokMW4grE8OmoUQCXHOiJmdUK6Dp54EcKesKY0yQj0WGm0vjFADP6ixzJZZE0ME7lDk+kfF67GMdVrcSE+mtB0WXoDLt2sDQNC4y6hYWgoQG9hs1+HQs29pzkxF1jIq0YT5ewFC5bUWsFYflcT+PA8AxPJNIHAce6QUy7Nj/J/Oh81GICGbM+PpXC3NITaep0wRryLOsL0b5UvYvZA5YCQwdIkij1SXpUiPBa9UOJ5TT2lQrRldg7LyPVh0pWmo6uGQNu096k/dvY2EVFe2yhIOi2KtUu8DQVFFRozlASGt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PphRFMlmRQlLcPlzc4VuQfuvMnPA5hziT3O+YkG2CAs=;
 b=RYMH5aOYEK7bwuClDAw4okG9tCdvO6vwBcQ4hJBtgsp8zIKc3TxdoZCT1J/kahYzifxHLhWtaVACraasQbviI8q9ba429y3YLhMpTENZ/gK3uJSEx3yrVRIlOkiIiXDEsVyuG7WKpY0r0WlnP8WTzXKPHLUa0tlB7wrCJW40B2U+Q2iYjx5xiPRxfnbgRiv8Njzl2ll4+JgLswvlh0cb2ZGN1ErRrMIu+GnmjTALi5ewHCa76hUFFHU4NasHhat3uHtAmjEgUeNzYZumArE/tg7LB4GZVLntswQrmrMLuDwTT6Wr+HPRZExzO/VcENA9EVQPKFcs88L2oruPZTj3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PphRFMlmRQlLcPlzc4VuQfuvMnPA5hziT3O+YkG2CAs=;
 b=Saf97Vm0PDs3vdBY9w6JT/U4I+YtkhgSra7rHDxikad+0lLkl6dPNGHIWVUNXJWI1rvjtUzhaeWZEnBHN9R019/C/RX/QXVlNTSOHXMxeNG8DckBuxISBVQ0/IV0KBsWL98aZxlR5EvvaZN8WGeX5fB3Bkaw4TSFvHkb+t9PWoU=
Received: from SJ1PR21MB3504.namprd21.prod.outlook.com (2603:10b6:a03:454::7)
 by DM4PR21MB4619.namprd21.prod.outlook.com (2603:10b6:8:244::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 20:57:43 +0000
Received: from SJ1PR21MB3504.namprd21.prod.outlook.com
 ([fe80::58b1:aa59:d15e:4171]) by SJ1PR21MB3504.namprd21.prod.outlook.com
 ([fe80::58b1:aa59:d15e:4171%7]) with mapi id 15.20.8699.005; Thu, 24 Apr 2025
 20:57:43 +0000
From: Sam Harwell <Sam.Harwell@microsoft.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Potential bug in for-each-ref handling of fetch/push refspec
Thread-Topic: Potential bug in for-each-ref handling of fetch/push refspec
Thread-Index: AQHbtVsiuviLI7U+HUeCWJxjjDhSWQ==
Date: Thu, 24 Apr 2025 20:57:43 +0000
Message-ID:
 <SJ1PR21MB3504FBA7658CA100C90387F6F9852@SJ1PR21MB3504.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-24T20:57:40.182Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3504:EE_|DM4PR21MB4619:EE_
x-ms-office365-filtering-correlation-id: e722be18-1bb7-43b9-90ee-08dd8372a871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?84OT6e/1rYQu+KU8kAUlH8HBehMmh0EZpyqz/zWDgLXwwNqQT0dSLZBigT?=
 =?iso-8859-1?Q?VzfzVAZDcRoBPReznrlDvAo5jWdIplZNfFOHFd2TEPGL9c5+qBChEZBg+D?=
 =?iso-8859-1?Q?AUVF4MtuyGJhJGVsrQWUIVrqrmUneb29gAnahrt1/H1Nku8ghQM/5c+vv0?=
 =?iso-8859-1?Q?PRqX4gGjUO6FhM4rJo10mddOlt606JHzvTqLmlAcJxd5nn5h0U7ryuYic+?=
 =?iso-8859-1?Q?vjYDDt3EGybVOy3ovzVNA1ll+3ypLM/8mCiH6UPWc25gukMRzME+Q8G8HE?=
 =?iso-8859-1?Q?lNhFA7sz7AQClOvvV3bKuSXVMIpIsDTRIoqfnHcnZaeZRDYRCb3Ow4ttaQ?=
 =?iso-8859-1?Q?zb9voh8q9QjvyS2hF/8xpWKMHlBUCEnwnqwu6w3DZFXT5JxCcmNr/beXM+?=
 =?iso-8859-1?Q?WXocsAUUZdN2fw5ONIkp80dradRME9+YVEIdqqSEzW8Q/GHLRyiVyCYr9Y?=
 =?iso-8859-1?Q?UGenz7ZjjlXTokw8oV/UI/4niZFwAqad2eAGJ/A+P36Zec+1sk7fihGX3d?=
 =?iso-8859-1?Q?fBz6cXtRiqJX1SBuap87mcTrz3J9QJ0zJdSnOLQZ2Ffmw7Ge63kmhfiZhl?=
 =?iso-8859-1?Q?PvrEZqgnQspTds98Y+ZEaftRFhahALqu9BOlqokQzcCqeIn/vA21Cx1rNL?=
 =?iso-8859-1?Q?5Z/lLU4YErtdQHskXmBcJJzRBdxDoFwbVpM+yBWqXpLREOi6mN4F9+fZt4?=
 =?iso-8859-1?Q?CbxKzs9Iufb/rci5lupEnZQe+ASCHQoS4zlXrcRKA3MG6+iGpN5ZO71F0I?=
 =?iso-8859-1?Q?v1bmysqIVKIL6mkaQ2gVdbShrM3ktg2jZnQ9AslKyFRu0j4gLOQX5Szb37?=
 =?iso-8859-1?Q?LJZkqJHdKYfo0D9NY8mISzduWAQGpuROmSxijZShFNdgMsRueMob+l+Gv2?=
 =?iso-8859-1?Q?Zoc/+38XMzBmzSAWDWWLboKqtg1GgUMU803h2XsRZD2E/2HQGvbgIgPyol?=
 =?iso-8859-1?Q?wvF1tgAvoAUC4v2ieHCdP53xFNK+33Y1/MWmU0jvUD8kqC4JoIZcoO9/Jc?=
 =?iso-8859-1?Q?w8KiihbWu2wG2T9vYjEgcjy8ein85gbA6kJSDuBSqbFY2ZinSOylxr1kAs?=
 =?iso-8859-1?Q?JbcmRzHOs0QeroS/soNMCq1KbVYlCxfJ+XvMYCh2z4jplc5jxKEILsivzk?=
 =?iso-8859-1?Q?Uq5uWc0YnFEXoI5Hl8v5gYAC/wUM+7kHU6tH8810lQPXYP074/s1hUJLyN?=
 =?iso-8859-1?Q?5+aM+U07gW7t3Q78H4QpI0oTDSbGUG0gSzqz/Tt+wMmJivFAERmzq06H1p?=
 =?iso-8859-1?Q?SC1DCx/D7T3OFwnj95oUgGgZaengRP6FmiZJgpilFrLcOe4oKTNT7lOgA2?=
 =?iso-8859-1?Q?/XZ3tSvWYxLfvOFi7a0N2f73Whtjz7eUsRLKW4okt+LcpMgwFsv9diCtq/?=
 =?iso-8859-1?Q?v7tiBOXqMIwzRdDlT18urlcioZzVHW1yfnNRwUa+QjiPOMOWmL6B4w/t9s?=
 =?iso-8859-1?Q?9+g48O12m6I6M+hRWkwFU6Qga3yil9Mu4KGiVUJKwrhVSPQswhaUS3D9Yn?=
 =?iso-8859-1?Q?QxpLksVMKDCKOddyVqj0AXz6+e0DOeGJF/S6AqgsynvQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3504.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gsWzCIr8IED3ROww/EUVooHkWd4O5hUUWZ+hOVUzNriXj0ZxF37KpEUzBL?=
 =?iso-8859-1?Q?6u1L7EauZWLCVW1LNEKRt+WUNV5vZkJu7a7UGd+BhjJN8m/Mys6SZQSX4J?=
 =?iso-8859-1?Q?iStjn7VSo4xFFujvnyv9JOmfoWP2ekWLGfwq5zOzK/LIsmHVsFytuXARHF?=
 =?iso-8859-1?Q?wMiSGFUyELZ4tAePZQpp+w1NcZjYYZNE3paYJbLf3sqXJUYEiaq0SYXlDY?=
 =?iso-8859-1?Q?l6IReqHXasSU5E6063shmKiWZT+zN9euliu29sFjja410zlin+xpPpxEtG?=
 =?iso-8859-1?Q?C0WgKI9w266HWUtAGrP/UD2orlG00wcWYDt34nENrhaul63GoKVDvFsBdU?=
 =?iso-8859-1?Q?8UZxNjPrnUfqrVywWcSSwy8wE2b/aPtoa35onlVRU6RZNuntrYjEQHyWYr?=
 =?iso-8859-1?Q?SN9h8efKvtukUZ/QBis9mksLdYb+CR4NHnYPNyTTo+wsj1+Mt/Xz01qfPR?=
 =?iso-8859-1?Q?OZddFHzl645gUxLGgSAfigancZdI5cdZ0uDqY4ruLVOqAYilb2wToiylKT?=
 =?iso-8859-1?Q?oN/hTZ3enAn3/LnszX4sEqh2jsPvqcbG5WjB9MfmFuGxiDTDujDcy7ZymN?=
 =?iso-8859-1?Q?VZRWMafSo1Eb0Ioq1jdM3o1ejgNXiDpMo7qpWicI6uwwbDrkVx7egFqBL9?=
 =?iso-8859-1?Q?kU13DdD4RJzbE/6N555+9ItVzLoYjWCj8ehfbx7kArv+SiD5wZC1oKyW43?=
 =?iso-8859-1?Q?2f62oc2jrLR+q/CvIx9k7Zm+1/UaNJhoC72DsBkMD2Lzqq/LDEVnSoKpNE?=
 =?iso-8859-1?Q?IcBfPnPFrH3OCRra348TfZXNWGfSS1KHr0d4Y4RlsS7tCbStxCRGG4saEL?=
 =?iso-8859-1?Q?u33pEA0QXgMVfts6PwRU8tEtJAEHtDPOYLwGtABRxqGGX1M0+iIMBU+I5K?=
 =?iso-8859-1?Q?hmn01MyuzVkuKPcSSO3kHhgpaXJf4sBrM86xepnEzfuSJPrcM0dypN5y/J?=
 =?iso-8859-1?Q?ycbuLSYwzxOoGl3WyJdtliED48n7lCgqmnXVwyJtsVjXtuZdZSFWy6soqL?=
 =?iso-8859-1?Q?eTw35ONbGR+WpnuSYIDRtvS+1k0qzmWGDSscJDOPsq+5y6gGa/qu2kGHlD?=
 =?iso-8859-1?Q?f/4SobxPxrcoo+4NyhoQJxAdXWCxLUJRFE9lxc8oAW2oZSpA5MTEEr8x0j?=
 =?iso-8859-1?Q?mytNonyskUVwwn7tuBOvaN9gQseaDXpD8L7IkOIzEkCxJyA6x6ytdKXyl7?=
 =?iso-8859-1?Q?uPxK/Tcr8c0Qlz6GugyPmZC0JTzFEfRoJVpv3rnhvSZ9qS0MKmjOv6vr6q?=
 =?iso-8859-1?Q?NamRPstO3xQOe8EKobt2hWAK/kHZ6FrBwHfL1aK7P9Y76wGIR1k59LtRP0?=
 =?iso-8859-1?Q?YFPk+StIcG4x5uSDOJFXkvbhYj/NrYQ07mulzEiCgS1MaAcd8E3scUtum4?=
 =?iso-8859-1?Q?LJBIwiUvsSmUfAMXFCb8sw3J6TA9y5WkQqvTr2xuWYwysVDcJmAcjeS3M4?=
 =?iso-8859-1?Q?SiETTj2vyf/jzMFuCVFL0xCUAU54/wczihHvIzHxD4SjUwGEu5ADjtZAYp?=
 =?iso-8859-1?Q?I4ZeAmI3v4syg2Z/cFYxb2V+HfG0RX7JZ/zsKgEey6376fbq6fwGBLCcXz?=
 =?iso-8859-1?Q?V5eWBreRwhQzXRRqJzHdJPx3l/6/dhlW1kEZdtuo3km9vJQObyfRWaqAB0?=
 =?iso-8859-1?Q?EBVz1A5CvchdynIhfBGMpk0Q19mm5tIQR3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3504.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e722be18-1bb7-43b9-90ee-08dd8372a871
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 20:57:43.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/Gng4BL4jovtQjNu2VlJ7REddq+uqcFOjE95ITDpn08YWuafeCMszQZgWGjfDmBpwolv15Ror6cedw9SfF0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB4619

Thank you for filling out a Git bug report!=0A=
Please answer the following questions to help us understand your issue.=0A=
=0A=
What did you do before the bug happened? (Steps to reproduce your issue)=0A=
=0A=
I attempted to use fetch and push refspec to make an Azure DevOps repositor=
y (no forks) behave more like a GitHub contributor model (with forks). For =
example, the 'main' and 'rel/*' branches are considered upstream, and 'dev/=
user/branch' is the format used by each user for working branches. Here's a=
n example configuration showing three remotes: 1) origin maps every local b=
ranch 'name' to remote branch 'dev/sharwell/name'; 2) devdiv does not renam=
e branches but restricts the view to just main and rel/*; 3) partner maps l=
ocal branch 'name' to 'dev/partner/name', representing the work done by use=
rname partner.=0A=
=0A=
[remote "origin"]=0A=
	url =3D https://path/to/repo=0A=
	fetch =3D +refs/heads/dev/sharwell/*:refs/remotes/origin/*=0A=
	push =3D refs/heads/*:refs/heads/dev/sharwell/*=0A=
[remote "devdiv"]=0A=
	url =3D https://path/to/repo=0A=
	fetch =3D +refs/heads/main:refs/remotes/devdiv/main=0A=
	fetch =3D +refs/heads/rel/*:refs/remotes/devdiv/rel/*=0A=
[remote "partner"]=0A=
	url =3D https://path/to/repo=0A=
	fetch =3D +refs/heads/dev/partner/*:refs/remotes/partner/*=0A=
	push =3D refs/heads/*:refs/heads/dev/partner/*=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
=0A=
I expected get-for-each-ref to consider refspecs for newly-created local br=
anches than are not pushed. For example, consider the following command:=0A=
=0A=
git for-each-ref --format=3D"%(push:track,nobracket)::%(upstream:track,nobr=
acket)::%(push)::%(upstream)::%(refname:short)" refs/heads/newLocalBranch=
=0A=
=0A=
I expected this to print out:=0A=
=0A=
::::::::newLocalBranch=0A=
=0A=
What happened instead? (Actual behavior)=0A=
=0A=
The command printed out:=0A=
=0A=
gone::::refs/remotes/origin/newLocalBranch::::newLocalBranch=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
=0A=
The command printed 'gone' instead of the empty string for '%(push:track,no=
bracket)'.=0A=
The command printed 'refs/remotes/origin/newLocalBranch' instead of the emp=
ty string for '%(push)'.=0A=
=0A=
Anything else you want to add:=0A=
=0A=
Please review the rest of the bug report below.=0A=
You can delete any lines you don't wish to share.=0A=
=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.49.0.windows.1=0A=
cpu: x86_64=0A=
built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc=0A=
sizeof-long: 4=0A=
sizeof-size_t: 8=0A=
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh=0A=
feature: fsmonitor--daemon=0A=
libcurl: 8.12.1=0A=
OpenSSL: OpenSSL 3.2.4 11 Feb 2025=0A=
zlib: 1.3.1=0A=
uname: Windows 10.0 26100 =0A=
compiler info: gnuc: 14.2=0A=
libc info: no libc information available=0A=
$SHELL (typically, interactive shell): <unset>=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
