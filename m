Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6614372D
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280516; cv=fail; b=ijtkZc7tH3fgsEWbXWJ41G35Mvr60RlYGP9QEwX7zcKgEfWiilMItWx4MuVMQvEHMyptZ/qUhKY0Uvclgn93nSScpV77aeNQJKQnaKHuxUafw/m7CTOuGJ6pC41xcrXN5TAct5ft1pFPSWVm8HdaHtRs0vSHW21Fmjj6g20vZJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280516; c=relaxed/simple;
	bh=2aIV0N0cZU/a5Q0gR0ACyfbByNsDubx/ctnkCzMlXSo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MU7eMabbYfj7JjAaZZM8J+jxMItwSFJiBuDlPCTcQ3s7drCKXKcWNlSO3H7nrI0aq9x9SwsgOK9GpR+EMLPC8Vgtszr5jnqyYV5Aa07BTAwCkbiJT5/ZK3dwMFDzytq+9SacdtkTnoroygtNf7LG3a80hHc31yxnKS8uDYcqBwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=myRiqBcI; arc=fail smtp.client-ip=40.107.93.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="myRiqBcI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIqAvBWqev5u8H6XM2j+YV8FrxQPcyk4pbuCSFzpXP3T/aQDeF1Kb+6BU69Bdz8+klAesdtVhOJYoLjO+N/INCo++hg/C9Mk5xMDI8PhBx8UOwxWRTzYYBQoEreapsVdf8X2xys6dQzP01ZrZK+mdbVr3wASWqv4KV+TgnpLDFsfKWyDLrdtKknmZYCnk5p58g20jgHJh92E+jKvvx3LHiUfp6WXZ3QZXF15Of/39uEXHUyP0tVyBeE0SQocOfyOIN6VN702iHhjPJCazeG0fi3w3IVj1THggU3HwmhYr1YBbID6ikaV8vvMYkBZvjv3M3kphHrTdbIjdVy3L+ToLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eDx9o01ChBORscTQDEftVNbQsQ83XACMWWWaZe5wzE=;
 b=A02LCL/ntY1PBtEW92dm1HtvZdb3oGp+yM7OISSQ0wYgTrXJ3p2lGTGSjbiwnO+5BYY3qO6rXM2m5pVigLnOGduM0iNFfrwsUsKdRZ2fvraeG2eitfjsjV+AO1fNPJj8QEzPuAlGgUwOopO7DuHquSYrVBDhz1z5o2RJWt7hQ5vyQTfa55x0DWJAGB9qV+Plj1tWIm/AgvYn5VnXiWPgif/YHGYrPAjcb7szw2lafDtuC2eOoY4Ze5JqlxUX+iQxVDBHZO+j3NnJ6ceD4JLQa5wFfVnOluoQp1ouo2TK1U4hrW8/4gYJd7jzo8M/Uy2tA9Jk0RxJUZf2ELug1hu8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eDx9o01ChBORscTQDEftVNbQsQ83XACMWWWaZe5wzE=;
 b=myRiqBcIjBoU0PI6XvKOJnW/HOhjfZV27dMuRVWfthW/gZigM1EhHeVFBxMFAdB2k7aGCA9ZJ4IPpcQh9tESo+i7xP7sG3FdeOCx5CYdT4RzXob62SmkSEariNmIXnscd4HjenMBOLwvqiogDNkirv1v858r0GA5xxImx0pnKlFSTQON6a8xrvvM1q2dXTwXaDeFgWVTR2xZRkO1W4EkRJ/c5KaL85YzsIrhTaEyoYHjmT/789cBTs31a6yILsz7V2o3HAjQ2vvvMA8m/4CO6VwmeFXd/6aVJMXUJNZqmxHBGOkk060HHV2GEn/CUNEGvAJQdmHt/U9tWHs/mk6mwQ==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by SJ0PR14MB4252.namprd14.prod.outlook.com (2603:10b6:a03:2eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 21:55:12 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 21:55:12 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Christopher Lindee <christopher.lindee@webpros.com>
Subject: [PATCH 1/2] Teach send-pack & push to --send-up-to-date refs
Thread-Topic: [PATCH 1/2] Teach send-pack & push to --send-up-to-date refs
Thread-Index: AQHadMdLLrOfHThu5EeIsu1MpASt+Q==
Date: Tue, 12 Mar 2024 21:55:12 +0000
Message-ID:
 <SA1PR14MB469144B8903909F65493323A8D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|SJ0PR14MB4252:EE_
x-ms-office365-filtering-correlation-id: 2222dc8f-d47e-4941-a8da-08dc42df17f5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4tvQLvgudh1f6IJAkRIoJNeoe51muWZUVuD2/Q4Y1QfeRfYAErB5udcJ4+agj8Mq60D/BC7UVmFX6Cjb98WJQ5RmVwGPdKA3eDRZDlGRND6xiPES/qDnzfD63WMwExbh2/yvy9dqZJh2og3jac1Pc2LQqdk1oCHNMYYpzaoJ9tsNK/tUoHbbg91ZrqDl+equYjRRfbdPX8k+wR+f31igw7V6fiKtGR2CFl7xBA9oHdWSoVH2dxu3IFUsZ+cUhHnoFNNKN1sB90BIrAWwSpp+0DuQO6FnZzU929zp7WltKBsJ9/uncW0zJdjq+ZSF2Zlx2qQ82+Sxv4fVYS8/M50hHiU2HUfQwJ1GmSHQ3pcGW7CIkLYepSUeg1nUnTxyX4YxZlGVAVBAOyARSMn+SsJDFKmaezguITnx1W6FdDfGjgupCpoB6mZdWdbUqNkVYNRoiuxwcxvxbbsTFjnfJ2nQbjFyZV86p/I4a9ZIW0Puun1kDLtbUUuD8nHO1hqPgF9U7Xg1X4Ab8tl5AIXbnLQcPiia+eazqVvQffp3g8L6lJgeUpvBvHk6BgY9gisoRbEpP40E+pe1GaI/ar6EvBPl9f2ZRvP+TrTB622S2+DbLkcZQW7pZYM0zcXOyKiwF82BsDKPCs1X2aYzdM25ahfNVad4Z9SULfSgttOmWjl5uDGrKw7FHjgMcDQIYG5m3gs53VbzUSPnHNOVDJsOPeud3A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?or0mTCPYtdpWVIm1IlEmiX6rXwPo5KyVX371f8GhhWmwcfd8Ss2ZIkXiqh?=
 =?iso-8859-1?Q?l78CPdm9YAxjWlUZ4aeBH3jLEWFpl2dApwv/1czKTmgsKa02CKfFq6aPP1?=
 =?iso-8859-1?Q?a/YOziFOiLw4ku+cPv1WeFU3FgPh7Ju9v02WA02ffgxkjLNnr+RieQSGr5?=
 =?iso-8859-1?Q?fGfHFOPXlOLHOl1uR9R4H3u5+05U5sHJceQJa21uzIhX2PDFiwrgdZsw9A?=
 =?iso-8859-1?Q?EY9pKI8uYNaXbYlF5TyZYyr/gGbht0IvXxDo6A0giT8KjvKjyXemxt178R?=
 =?iso-8859-1?Q?EbvqTYptcUdQkYUeLYlyPnCn249MOrYI+cm18c+tJ8BBTX7BahHyFIqv4q?=
 =?iso-8859-1?Q?cZZvJpdVSEPGJWufPFCVLcG2+S8GKFoEttU50WHe/DM2Clg+rxNzoV2Rzb?=
 =?iso-8859-1?Q?ruKTXH5IUXbGBjWK7mAuUowFGSB+JCedNGN6DCATwgx1fir3dVGBgxsupg?=
 =?iso-8859-1?Q?GOZW7Bbk9RZr/2e3erbsBloY2SArs8udLbPymAEHpLnPLyZGyfGdZEVKdE?=
 =?iso-8859-1?Q?dgnXvB164HiW3dB+LiOvWFUWBcRNBPrkHDsveGg7zFPT+Y+ocG0megKImc?=
 =?iso-8859-1?Q?CDhs+SFPZmK4V42EmDnlpfJRLwLgyfefhU0uie5ekDxuPVDfPdUyw7SM9s?=
 =?iso-8859-1?Q?+rBRKxMxS7wNM+8uOzVWxWy3XlotWD1ErTMVDfogeRoSdZtoLbEy2uRuvg?=
 =?iso-8859-1?Q?8PVigY3cRWeaMFIkxp1QP/c9OfT0Tx12b20bfMg22FqMsjFcUNOh63bHFo?=
 =?iso-8859-1?Q?kfTwrAHGmLrF0BMBXpYurNSlw5BI+4Efld4Qej42POO2+oixdqsymklpRr?=
 =?iso-8859-1?Q?M3LUZfMZVzzV5b3oZhei5LzszBJIIXRu5Z1FafHfJ25v0U41VG3b8Zz+/q?=
 =?iso-8859-1?Q?mOdL0gEJVp0EwBQlxGhDF0E12k6D8CS64OF32lJFHfQEyFWUg8XPw+3qsT?=
 =?iso-8859-1?Q?oUxPQyYvSBO9iAO/Ny+Oyp9HfLM0jfsH6+Rigzf4jBmkce9704Lx76IJlC?=
 =?iso-8859-1?Q?LZSCoIvoYvBJdcd/wdmzfV/QrMBF7tL7kPsrsnVGSB6ZTnopv9gTVUSI7n?=
 =?iso-8859-1?Q?MH+/bOm89oGeupjeNW96K+fqsmtkcljYLn0FvUB63QuTstBAjtJTLuSDPG?=
 =?iso-8859-1?Q?NZQZiRuOMJMC7ttiPZYM77ZbrR2ks8EL3mRfS8eBR3mkCw5vBpX/Fggulh?=
 =?iso-8859-1?Q?xN+ZSMZoX2ZV+LzSU3ZtEDTImZkH1HY8QFR7a4OmWc0uX+Q36UbOEKgOf0?=
 =?iso-8859-1?Q?jAM/vBFl1d4amWVU86T8zg8xSsW+s7HLtlaRmjC+oepnZqJPmH3QBVtkWQ?=
 =?iso-8859-1?Q?cogV8LGSovSxawcqFB5+g+ISR8R9ApApkZyGapX6OXKM6OVfNx2NMu44Ri?=
 =?iso-8859-1?Q?iPtpmvZnzwIzKGi6/T3i72T22eiuva7eZdYiyo2UUg/cjiOmPIByhoXR2f?=
 =?iso-8859-1?Q?dCW8UOPGE/lJou/yxRgKpEgXhRljknJaHcztl0EGW73ERpDtrhDgWCNpi4?=
 =?iso-8859-1?Q?S0MBvtWgmj/laQEE89QmVgXKGP6CNX6CFpiYYncCP2MUEVaYAhx81kfcJs?=
 =?iso-8859-1?Q?VTObE4rL88w8WYZiJVl09dRi3jzoYzv6D1IWH/tRHvXSJyOHFRzXf5RMF/?=
 =?iso-8859-1?Q?7nCjpW9fMZBF6gof4lc7t5o6tpBiikaXm4PJjlerE5iHLDvjPkMBd4cw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2222dc8f-d47e-4941-a8da-08dc42df17f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 21:55:12.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDA8/NU0m0NrQJQLOV7VEBWKb9Ho9Vn3EnCbMBK3E/byZjDxn1x8cDkUoYiTUZg2J0f9OMAQoQTc74knpK+onseyxW+uEMuzIkbfCOntRq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4252

Provide an option that forces the local Git transport to transmit a local=
=0A=
ref even when the receiving ref would not change (i.e. the local & remote=
=0A=
refs point to the same object).  This is not done normally, as no changes=
=0A=
would take place on the server in a vanilla Git setup.  However, some Git=
=0A=
servers support push options and those push options decide which branches=
=0A=
to operate on based on the refs that are transmitted alongside the option.=
=0A=
=0A=
This option ensures the refs listed on the command line are always sent.=0A=
=0A=
Signed-off-by: Christopher Lindee <christopher.lindee@webpros.com>=0A=
---=0A=
 Documentation/git-push.txt      | 8 +++++++-=0A=
 Documentation/git-send-pack.txt | 7 +++++++=0A=
 builtin/push.c                  | 1 +=0A=
 builtin/send-pack.c             | 4 ++++=0A=
 send-pack.c                     | 2 +-=0A=
 send-pack.h                     | 3 ++-=0A=
 transport-helper.c              | 7 ++++++-=0A=
 transport.c                     | 1 +=0A=
 transport.h                     | 1 +=0A=
 9 files changed, 30 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt=0A=
index 9b7cfbc5c1..44d1e04931 100644=0A=
--- a/Documentation/git-push.txt=0A=
+++ b/Documentation/git-push.txt=0A=
@@ -11,7 +11,7 @@ SYNOPSIS=0A=
 [verse]=0A=
 'git push' [--all | --branches | --mirror | --tags] [--follow-tags] [--ato=
mic] [-n | --dry-run] [--receive-pack=3D<git-receive-pack>]=0A=
 	   [--repo=3D<repository>] [-f | --force] [-d | --delete] [--prune] [-q |=
 --quiet] [-v | --verbose]=0A=
-	   [-u | --set-upstream] [-o <string> | --push-option=3D<string>]=0A=
+	   [-u | --set-upstream] [-o <string> | --push-option=3D<string>] [--send=
-up-to-date]=0A=
 	   [--[no-]signed|--signed=3D(true|false|if-asked)]=0A=
 	   [--force-with-lease[=3D<refname>[:<expect>]] [--force-if-includes]]=0A=
 	   [--no-verify] [<repository> [<refspec>...]]=0A=
@@ -225,6 +225,12 @@ already exists on the remote side.=0A=
 	line, the values of configuration variable `push.pushOption`=0A=
 	are used instead.=0A=
 =0A=
+--send-up-to-date::=0A=
+	Usually, the command will not send a local ref when the remote ref=0A=
+	already matches, as no change would occur if it did.  This flag=0A=
+	disables that check.  This allows push options to be sent alongside=0A=
+	up-to-date references on the remote.=0A=
+=0A=
 --receive-pack=3D<git-receive-pack>::=0A=
 --exec=3D<git-receive-pack>::=0A=
 	Path to the 'git-receive-pack' program on the remote=0A=
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.=
txt=0A=
index b9e73f2e77..2517d226d0 100644=0A=
--- a/Documentation/git-send-pack.txt=0A=
+++ b/Documentation/git-send-pack.txt=0A=
@@ -13,6 +13,7 @@ SYNOPSIS=0A=
 		[--receive-pack=3D<git-receive-pack>]=0A=
 		[--verbose] [--thin] [--atomic]=0A=
 		[--[no-]signed | --signed=3D(true|false|if-asked)]=0A=
+		[--send-up-to-date]=0A=
 		[<host>:]<directory> (--all | <ref>...)=0A=
 =0A=
 DESCRIPTION=0A=
@@ -88,6 +89,12 @@ be in a separate packet, and the list must end with a fl=
ush packet.=0A=
 	options, error out.  See linkgit:git-push[1] and=0A=
 	linkgit:githooks[5] for details.=0A=
 =0A=
+--send-up-to-date::=0A=
+	Usually, the command will not send a local ref when the remote ref=0A=
+	already matches, as no change would occur if it did.  This flag=0A=
+	disables that check.  This allows push options to be sent alongside=0A=
+	up-to-date references on the remote.=0A=
+=0A=
 <host>::=0A=
 	A remote host to house the repository.  When this=0A=
 	part is specified, 'git-receive-pack' is invoked via=0A=
diff --git a/builtin/push.c b/builtin/push.c=0A=
index 2fbb31c3ad..555e8b53fe 100644=0A=
--- a/builtin/push.c=0A=
+++ b/builtin/push.c=0A=
@@ -617,6 +617,7 @@ int cmd_push(int argc, const char **argv, const char *p=
refix)=0A=
 		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PU=
SH_NO_HOOK),=0A=
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),=
=0A=
 			TRANSPORT_PUSH_FOLLOW_TAGS),=0A=
+		OPT_BIT(0, "send-up-to-date", &flags, N_("send refs when there is no cha=
nge"), TRANSPORT_PUSH_SEND_UPTODATE),=0A=
 		OPT_CALLBACK_F(0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sig=
n the push"),=0A=
 				PARSE_OPT_OPTARG, option_parse_push_signed),=0A=
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote si=
de"), TRANSPORT_PUSH_ATOMIC),=0A=
diff --git a/builtin/send-pack.c b/builtin/send-pack.c=0A=
index 3df9eaad09..da6630fa12 100644=0A=
--- a/builtin/send-pack.c=0A=
+++ b/builtin/send-pack.c=0A=
@@ -19,6 +19,7 @@ static const char * const send_pack_usage[] =3D {=0A=
 	   "              [--receive-pack=3D<git-receive-pack>]\n"=0A=
 	   "              [--verbose] [--thin] [--atomic]\n"=0A=
 	   "              [--[no-]signed | --signed=3D(true|false|if-asked)]\n"=
=0A=
+	   "              [--send-up-to-date]\n"=0A=
 	   "              [<host>:]<directory> (--all | <ref>...)"),=0A=
 	NULL,=0A=
 };=0A=
@@ -165,6 +166,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)=0A=
 	const char *receivepack =3D "git-receive-pack";=0A=
 	unsigned dry_run =3D 0;=0A=
 	unsigned send_mirror =3D 0;=0A=
+	unsigned send_uptodate =3D 0;=0A=
 	unsigned force_update =3D 0;=0A=
 	unsigned quiet =3D 0;=0A=
 	int push_cert =3D 0;=0A=
@@ -200,6 +202,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)=0A=
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC proto=
col")),=0A=
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),=0A=
 		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remot=
e helper")),=0A=
+		OPT_BOOL(0, "send-up-to-date", &send_uptodate, N_("send refs when there =
is no change")),=0A=
 		OPT_CALLBACK_F(0, "force-with-lease", &cas, N_("<refname>:<expect>"),=0A=
 		  N_("require old value of ref to be at this value"),=0A=
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option),=0A=
@@ -221,6 +224,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)=0A=
 	args.verbose =3D verbose;=0A=
 	args.dry_run =3D dry_run;=0A=
 	args.send_mirror =3D send_mirror;=0A=
+	args.send_uptodate =3D send_uptodate;=0A=
 	args.force_update =3D force_update;=0A=
 	args.quiet =3D quiet;=0A=
 	args.push_cert =3D push_cert;=0A=
diff --git a/send-pack.c b/send-pack.c=0A=
index 37f59d4f66..30b0f2f276 100644=0A=
--- a/send-pack.c=0A=
+++ b/send-pack.c=0A=
@@ -313,7 +313,7 @@ static int check_to_send_update(const struct ref *ref, =
const struct send_pack_ar=0A=
 	case REF_STATUS_REJECT_NODELETE:=0A=
 		return CHECK_REF_STATUS_REJECTED;=0A=
 	case REF_STATUS_UPTODATE:=0A=
-		return CHECK_REF_UPTODATE;=0A=
+		return args->send_uptodate ? 0 : CHECK_REF_UPTODATE;=0A=
 =0A=
 	default:=0A=
 	case REF_STATUS_EXPECTING_REPORT:=0A=
diff --git a/send-pack.h b/send-pack.h=0A=
index 7edb80596c..241b4278bc 100644=0A=
--- a/send-pack.h=0A=
+++ b/send-pack.h=0A=
@@ -27,7 +27,8 @@ struct send_pack_args {=0A=
 		push_cert:2,=0A=
 		stateless_rpc:1,=0A=
 		atomic:1,=0A=
-		disable_bitmaps:1;=0A=
+		disable_bitmaps:1,=0A=
+		send_uptodate:1;=0A=
 	const struct string_list *push_options;=0A=
 };=0A=
 =0A=
diff --git a/transport-helper.c b/transport-helper.c=0A=
index dd6002b393..115f46f6b8 100644=0A=
--- a/transport-helper.c=0A=
+++ b/transport-helper.c=0A=
@@ -983,6 +983,7 @@ static int push_refs_with_push(struct transport *transp=
ort,=0A=
 	int force_all =3D flags & TRANSPORT_PUSH_FORCE;=0A=
 	int mirror =3D flags & TRANSPORT_PUSH_MIRROR;=0A=
 	int atomic =3D flags & TRANSPORT_PUSH_ATOMIC;=0A=
+	int do_nop =3D flags & TRANSPORT_PUSH_SEND_UPTODATE;=0A=
 	struct helper_data *data =3D transport->data;=0A=
 	struct strbuf buf =3D STRBUF_INIT;=0A=
 	struct ref *ref;=0A=
@@ -1010,7 +1011,11 @@ static int push_refs_with_push(struct transport *tra=
nsport,=0A=
 			} else=0A=
 				continue;=0A=
 		case REF_STATUS_UPTODATE:=0A=
-			continue;=0A=
+			if (do_nop) {=0A=
+				; /* do nothing */=0A=
+			}=0A=
+			else=0A=
+				continue;=0A=
 		default:=0A=
 			; /* do nothing */=0A=
 		}=0A=
diff --git a/transport.c b/transport.c=0A=
index df518ead70..84deadd2b6 100644=0A=
--- a/transport.c=0A=
+++ b/transport.c=0A=
@@ -867,6 +867,7 @@ static int git_transport_push(struct transport *transpo=
rt, struct ref *remote_re=0A=
 =0A=
 	memset(&args, 0, sizeof(args));=0A=
 	args.send_mirror =3D !!(flags & TRANSPORT_PUSH_MIRROR);=0A=
+	args.send_uptodate =3D !!(flags & TRANSPORT_PUSH_SEND_UPTODATE);=0A=
 	args.force_update =3D !!(flags & TRANSPORT_PUSH_FORCE);=0A=
 	args.use_thin_pack =3D data->options.thin;=0A=
 	args.verbose =3D (transport->verbose > 0);=0A=
diff --git a/transport.h b/transport.h=0A=
index 6393cd9823..61a20e84f0 100644=0A=
--- a/transport.h=0A=
+++ b/transport.h=0A=
@@ -158,6 +158,7 @@ struct transport {=0A=
 #define TRANSPORT_RECURSE_SUBMODULES_ONLY	(1<<15)=0A=
 #define TRANSPORT_PUSH_FORCE_IF_INCLUDES	(1<<16)=0A=
 #define TRANSPORT_PUSH_AUTO_UPSTREAM		(1<<17)=0A=
+#define TRANSPORT_PUSH_SEND_UPTODATE		(1<<18)=0A=
 =0A=
 int transport_summary_width(const struct ref *refs);=0A=
 =0A=
-- =0A=
2.38.1=0A=
