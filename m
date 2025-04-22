Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AF10A3E
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306407; cv=fail; b=k5ec0fgMqK3CcBQtNPN/pMu911euU6aTOXvEhXlD0aF0mNtcblN5bvDgQfiMTil9urSpVQWh15MpunlvAinQIqT5WvX0tCSiKUhu1kVgt5Zs6JZ46DnM8+V+w/236+J5PhYuxSMo99tsZmk+YdaujjjR+g4NkBoPPh4nqJRY5A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306407; c=relaxed/simple;
	bh=SRWEc7K/ORyMoBNhhS5c+MvOFyJWcTzgrhgBSUto8FA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G0VbdivDczh17EL98Z44Fm3+mGVvzRiLiMKXVvwHPsJtoYTzVrxHfM4NWO6cK2S+VRthq1nfiZAlum80o5sI9tyFrp2VfboRfgLQMSTe7/yMkhb3BQMkopIQQkMx/Fgm6lnmitH0WlRWpt5hw7LFkx0FoIOKusTjJXrEXlW6JVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com; spf=pass smtp.mailfrom=commvault.com; dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b=fy2Sd+59; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commvault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b="fy2Sd+59"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqrPIpmpk/NPY0ZudQ/wwWrvbtW6rLsMKJcFsDAX9a2LP5W41VwMHsAOTg5dklfDNUg4DJrmSOXaNBl6AckFrosGHmmZD3k+1BMTtG8wMT0BpueADMlKdWDZZXVnsNtyjsDCZPFbRZcIDaQMcsfycIyq5ApsuCGHbBVctynawh1hDtAMffijtKz1arVIQe31i3idwTSl5w1GYPAuPiFv0aGSpciOMhs/F4bfMyn7qZCoUrRa6WM/izl8Rqr4TJ+i3kqiuusfaXdO9uWoJfGMqvhG+caofinaY3iVmZne3WIlNerX+Vtarw9hp5OKnr5emsTuTjH5mjVtpr3w2yzs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ4JL4GDhADLGI5Ko7bKnUjlZUziVvFCdtpiJ8DExc4=;
 b=JqgbCEnT2KLn9xpo/8fKL9XZCm2GoFcb/KmrH7O/lNLPnBfqtfJ/vwn43qakxZYEigm5L4n88Ds9FCkYH5hENWnA9fKfzadoAHyGg/PxH0mbwmiRicBXvyXMN8qNAs9sOaH7sB3tQpOpmLVZKTkGUSDQE1kLcITGfgDmpYg0ggXP8Ld6FUqw+m/PLYHMq8fP7Mwb//+RQx5BUR5WZUlU2vRmiIhdgkC2ntOUpXbxWXx8FFg01nSw0+7KOwJI9f3FG0zGzN7jm1WBDbPyTiYocestcGl+DcDmlD/nTRItcnFiWkZh+Fw2IuQiqwk2bxD7+0z1fe9wZwk2E/OjYNXbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=commvault.com; dmarc=pass action=none
 header.from=commvault.com; dkim=pass header.d=commvault.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=commvault.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ4JL4GDhADLGI5Ko7bKnUjlZUziVvFCdtpiJ8DExc4=;
 b=fy2Sd+59Ouo1yVMD/7fLeIKJSVYdZpxyK9cpD4rQizxtirfioCLrLgA8IXUH+CXMBvRG06oo3fV7Yk+NYk6P5pXS2tDKNveV34L+BFuDcXgEiI7spWXkjrEYG/kmSq4LyT412ZtDOQ4Xt502qKXXCgjVFeS8pGc2XZ4n48iAIQFTy+rX2fY8C7thzptIA+DHF2jGNkCx7+v7LIjKLEBG7k39a7TFzQ7g2VuaC1uYR1X1aqauH3KnK0I03vEHU+w2rzqnaJLv+FrrgNibvKHumgLGGUZGlq3/qb3pBAeC5xqIGVEgm0g7+9uL1izzQevoJ7f8jtC5Bq0qHta2c//VJA==
Received: from SA1PR19MB7013.namprd19.prod.outlook.com (2603:10b6:806:2bd::22)
 by SJ0PR19MB6679.namprd19.prod.outlook.com (2603:10b6:a03:477::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Tue, 22 Apr
 2025 07:19:57 +0000
Received: from SA1PR19MB7013.namprd19.prod.outlook.com
 ([fe80::24a8:69bb:604d:3b4c]) by SA1PR19MB7013.namprd19.prod.outlook.com
 ([fe80::24a8:69bb:604d:3b4c%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 07:19:57 +0000
From: Akash S <akashs@commvault.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Verifying data integrity of two git repositories
Thread-Topic: Verifying data integrity of two git repositories
Thread-Index: AduzT2Pu9d8RTiakSQyoP18TGYwvjA==
Date: Tue, 22 Apr 2025 07:19:57 +0000
Message-ID:
 <SA1PR19MB7013FAD97E5E89B56AD7BF04C0BB2@SA1PR19MB7013.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=commvault.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB7013:EE_|SJ0PR19MB6679:EE_
x-ms-office365-filtering-correlation-id: 633f94ea-c56f-480d-4347-08dd816e1619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MjL3R31kas0T0EdLGmqG3XeapKI2PO3cRfeER1oMEgIrODT0N0b9RMPd7K2f?=
 =?us-ascii?Q?JD3xo1xLs+NY0nAmzJhOyuvAlFV/mEYIA6b3tvagDtj/t3pfxzV8i3qXteDK?=
 =?us-ascii?Q?JQ3a3LexNH3xdeYh1e05ImAkEUHvN2IZQ9sbB2b8Tw853vjKrvheksplKNxl?=
 =?us-ascii?Q?Zg6th71mdISxnG5AEvj+czs0m19DfCbFgnf0ANUuofV57Png0vOCQ2d2aYvq?=
 =?us-ascii?Q?xlILkeKxWjTyWtVT1ElQ8nQOm4kMmkJFrxO+v32yu/5nRvFE6PxGbvJ4akGX?=
 =?us-ascii?Q?c/byW0nu7/GqvR3/q9MYxcbBDgpdCPpANEJcFpcl20HSAP/otDj+0c5rZUqj?=
 =?us-ascii?Q?bH2SwDc9eh0kKG6luhaXxVc62ZtfC4fuSbyYNWmiOQ34Sihkdjd8KMSrLI02?=
 =?us-ascii?Q?DCOqUEYVh5P5MFKAY0+SaxqXXJ5R1gB5S0ikg7pbWfEhkwsDXLyjGkKf60mI?=
 =?us-ascii?Q?a89N/XhfOLeewpPUR5G7LjcAdezsqsSmsoOSWHvOWWOfNH2Oi2amL1rbZuUa?=
 =?us-ascii?Q?GGCocIT75hzq1LUSLNviDYsDJuf2BIFc3IY9PDNeotQsnwetKgJD1VdOT7eu?=
 =?us-ascii?Q?Oly5q3iHVD3iVEOaKvGKTJcv0IVNQSG53hf9vvBYUE+OeGi7VMglDKvRktSZ?=
 =?us-ascii?Q?JlbSqR3Mnulq6t+IupK9fG76cH393FOYnWLYKibRPJpRBRsMLlZRUSJlrxU9?=
 =?us-ascii?Q?r1BBXXbEpB/VyVjOmRnqTOKwIguBWXr13ukGsx2DB36kFMLfcesBbe9/C5UD?=
 =?us-ascii?Q?KzlRXGTiz9V2E+KrzoHEMOTw7vIxH9SVRiEs2nk87HG/BsXYKo1lo2xa4+81?=
 =?us-ascii?Q?IG9tnV2GEzXwIo8wEhKGirt27TE3z2nP9tX6nMtFWtYs3G5M5SkycQRhtwSg?=
 =?us-ascii?Q?iyNmGqs04APel+ZDK1N9TX+aDs5IU0J0d5aJt/25LlXxMpMhY9Z1F6rlk5v/?=
 =?us-ascii?Q?ZiydVw13y5cpH8ZB2YID9sigrPhdhUEvlNV7RP0sEb1AYdN2ml4FVTaoIL1r?=
 =?us-ascii?Q?GcB1dzodjb3uTnVEOMf+zdJO8shlFrGT8EWOMNTuQc17OUQQONHa6Z78YGeD?=
 =?us-ascii?Q?pyiBnVipN2fd1NqaNMcSUPRtKiFQbk626ENvssdDInkL9EGfPL7BFGRk2iK8?=
 =?us-ascii?Q?tsKSYrthvtIwqaYA7Y73JPAYyJvFlr3+yA+sDxfxrSIRlbN3yfx65os/D2r3?=
 =?us-ascii?Q?YtZU4q5//G7ftR+1JiuZj40kmXU46l8VPnzSe3WqwJdxP/HBDLtv6ECsTXhs?=
 =?us-ascii?Q?OloO5dSRiiJA9rUdSyWsIv848zh9OjCoOCTPu8+fN1pJSuMuahjsEf1Rp2wN?=
 =?us-ascii?Q?DMYmU0kVFmn5x/S+i/Agk+z106E6guenVAitMn03nrGGMBW9usizp8KRY3LR?=
 =?us-ascii?Q?LatjZAKTRTc+2cfltbKhvES5UEUZ4IE1+J9RvVXlup8Mfh/mmyM/Drxe285l?=
 =?us-ascii?Q?4QmRPTyeIwA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB7013.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hI5oldu3b5fkfGV2lxTy1ux/af/cIHcJaCCSx25FOuaO0XWOYEzbrYJi5ZnO?=
 =?us-ascii?Q?zSISWdyIjUm5eF6RXQxCdK3bA2HTeQmiNhJVmvAm01l8GdZuvyB8TKa7WI4k?=
 =?us-ascii?Q?Lt5jppWY+wTOiGKgiRWjqQOsw/+lbKE6LF5x6LkUw+M+qZMz+zS0rrRGTpdi?=
 =?us-ascii?Q?nHiIgI94/3XnqJybcXmy34thaKs9gpgHKjSi3kLMa5UofqvUyiyLd0fL1iLx?=
 =?us-ascii?Q?lJ6gRUPFswbNdoAG9nruw+Zgy27VpkpV7Ox+bbx9Nt1eRGEJd1CicW0Ekx7R?=
 =?us-ascii?Q?1CLHuQ4OvYL4uCyP9M+039USPbIkypk7qsxc8ULOZf+g+PAesDsDhPh1uDN/?=
 =?us-ascii?Q?zxgMeJX7VUFCXwbnykuuh/VDoeELswPLKzeED3E+2trjf2D/Ur/eXBRgLrVg?=
 =?us-ascii?Q?W98MDih2ScghhHX4zHtBHULTloOqJ2Z9c4HvT9LeBWnvF9zmk5jF5HdhhGKx?=
 =?us-ascii?Q?IwuKxfWk+qDTYUXE+S7iRwEiFf+jHjwLh+U3OnTIEOZLtmGlv5QarScL7S95?=
 =?us-ascii?Q?5nVNPwemX7rFuVaVMfjY9ETGaU3WybZnDxXBV2Zb56XYUoEzePUtr0LIVoWa?=
 =?us-ascii?Q?F3s4G9NOs/MsLAUoDHEyP7V5+aKwDPQJQhZO6x7ew0nXtzItOmEcGSVtL+Hn?=
 =?us-ascii?Q?MzZdQPD9hz/NKhCnsrPNfzpPzi/OhEJQn2IAWQMAdni/gQPZ7W6fL/uHSjIB?=
 =?us-ascii?Q?ddadLsVsD9AesUlOunNzauxz5o5ZgfBTE9qxFNYfrX/i9u1LsbaYlgQWbzx9?=
 =?us-ascii?Q?+tAS4GGjJjt6SgfFNu87EU+USlHsrmeAzov2kG3Qw/7GVH7aHOkxDURSUsPj?=
 =?us-ascii?Q?yqzJyk4tj8vYisoJ1RS/xbFgSBHouRLaeNwhK4yNQZxC5JvyvhVaQAg8ntiv?=
 =?us-ascii?Q?TytKaVWnq8vV9zWxhquT8p5RAHpEvqEIzOOrUVf3FgmsbRskCVmT3zMAcFNR?=
 =?us-ascii?Q?yb8LPQxVqMOZ0JnDdJ795rCpJSNASMhsPnV7Edi7lDVjpLC1qlarEKWomVGm?=
 =?us-ascii?Q?z3jCLTGjR872bEfdAB0lqpZSRa/XyGrRHNnetUxMi3TQQghlXmU8VcAXgUc/?=
 =?us-ascii?Q?e8HDtj3SaZXybV7hw2uHN4wmr/nxNW/Dh51NDmaPx621wS1uL2/Q3e4Xz5He?=
 =?us-ascii?Q?4LRKcCeXfweh7lakJ8iIRoJV/xKoqBoT6KK6YpyhC6iBm/gxK4l3NSTre0GK?=
 =?us-ascii?Q?e1W6v39XRkU5FVHp7PvO19VTmZZ+UdBGV/eIBVzFEEqJFSPmqGCUcCreLFKg?=
 =?us-ascii?Q?iSv7ifwwAWt51TeQQa885P68XamBkA80/zzhnqWBkvZlRm+JN9Qs7+nHwOBv?=
 =?us-ascii?Q?XgGYnHmkT+uzZ6dE1uyCUU4Fu2xV414aAiQKGByT5fuR1oxify23/+VFe3VU?=
 =?us-ascii?Q?VHIORkKnv/zBYb701mWPYFOpFO7gLGDkY+fTfeCaFu10kmm6h9qcg5IlAZaX?=
 =?us-ascii?Q?lPQ2ZG95JEHbM2h3y13btRZ5VtLwfAu+/jV6exaFjiCYiuD4S/FLhufGt7Bu?=
 =?us-ascii?Q?Jygbu05q6PFXYG0ffVReUDs3vfsSEp+AjX79E+lLvhGwXZl8dicnsnjAq2Zh?=
 =?us-ascii?Q?UtL0VHKvLfAHpYspSVyjjixFAZb5uUeGH53MUJ8X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: commvault.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB7013.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633f94ea-c56f-480d-4347-08dd816e1619
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 07:19:57.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 40ed1e38-a16e-4622-9d7c-45161b6969d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ax/wC1fDP8WpFW1+RK2A8MCt6E988+Nj9jAfDr9MEa8MBVvfFG+9lE0UFRIQ9xJSPMY1ITO5vHEgbO7Kq+Sreg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6679

I have a bare repository of size 5.7 GB in my local disk.

I need to push this to Azure DevOps. I usually do it with the command "git =
push --mirror" but unfortunately, Azure DevOps has a single push size limit=
 of 5GB.

So I have to push repos larger than 5GB in chunks.

I used this stackoverflow answer (https://stackoverflow.com/questions/79167=
276/splitt-git-push-to-azure-devops) asmy basis and created a script to pus=
h each branch in batches of commits.

I pushed my repository in batches to lets say remote repo "A".

I did a "git clone --bare" from remote repo A to my local disk. I verified =
the size of this bare and it seems to be of size 5 GB only.

	i) I counted the number of objects using this command "git rev-list --obje=
cts --all | wc -l" in both repos, both are same.

	ii) There is only 1 branch master in both repos and the last commit id of =
both master branches are matching (read an article that data integrity can =
be checked like this also since git also works like Blockchain)

	iii) git fsck --full in both repos,  both gave the same output:=20

		Checking object directories: 100% (256/256), done.
		Checking objects: 100% (10793794/10793794), done.
		Checking connectivity: 10793794, done.

		But original repo on disk had this extra line in the end (which the remot=
e bare on disk did not display)

		Verifying commits in commit graph: 100% (1351940/1351940), done.
=09
	iv) I create a bundle of the original repo on disk using command "git bund=
le create repo.bundle --all" and then in the remote cloned repo on disk I r=
an, "git bundle verify ../repo.bundle". Output:

		The bundle contains these 883 refs:
		<All Refs>
		The bundle records a complete history.
		The bundle uses this hash algorithm: sha1
		/home/repo.bundle is okay

	ii) I checked the repo size using this command "git count-objects -vH", th=
e size-pack differs (original repo says 5.62 GB and the remote cloned repo =
on disk says 4.93 GB)

Note: My repository does not have lfs/objects also. So I do not have any lf=
s objects to begin with. So that is out of the question.

Why is there a change in size? Also how do I validate if two repos are the =
same or not?

Script being used to push in batches of commits:

#!/bin/bash
set -e

# =3D=3D=3D CONFIGURATION =3D=3D=3D
RepositoryFolderPathForBareCloneBAK=3D"/root/linux"
BackupRepositoryHttpsURL=3D"<REMOTE_URL> "
remoteName=3D"origin"
maxPushSizeInMB=3D$((4 * 1024)) # 4GB
splitPushCommitsCount=3D35000
splitPush=3Dfalse

ALocation=3D$(pwd)

if [ ! -d "$RepositoryFolderPathForBareCloneBAK" ]; then
    echo "Error: Bare clone folder not found at $RepositoryFolderPathForBar=
eCloneBAK"
    exit 1
fi

cd "$RepositoryFolderPathForBareCloneBAK"
git config http.postBuffer 524288000

doSplitPush=3D$splitPush

# Check repo size and decide whether to split push
if [ "$doSplitPush" =3D false ]; then
    echo "Checking repository size..."
    repositorySize=3D0
    while read -r line; do
        echo "$line"
        if [[ "$line" =3D~ ^size-pack:\ ([0-9]+(\.[0-9]+)?)\ ([A-Za-z]+) ]]=
; then
            value=3D${BASH_REMATCH[1]}
            unit=3D${BASH_REMATCH[3]}
            case "$unit" in
                bytes) repositorySize=3D$(echo "$value / 1024 / 1024" | bc)=
 ;;
                KiB)   repositorySize=3D$(echo "$value / 1024" | bc) ;;
                MiB)   repositorySize=3D$(echo "$value" | bc) ;;
                GiB)   repositorySize=3D$(echo "$value * 1024" | bc) ;;
                *)     repositorySize=3D$(echo "$value" | bc) ;;
            esac
        fi
    done < <(git count-objects -vH)

    # Round down to integer
    repositorySize=3D${repositorySize%.*}

    echo "Repo size: $repositorySize MiB"

    if [ "$repositorySize" -ge "$maxPushSizeInMB" ]; then
        doSplitPush=3Dtrue
    fi
fi

# Unset mirror config to allow partial pushes if needed
if git config --get remote.origin.mirror >/dev/null; then
    git config --unset remote.origin.mirror
fi

# Setup remote
NewREMOTE=3D"push_remote"
if git remote | grep -q "$NewREMOTE"; then
    git remote remove "$NewREMOTE"
fi
git remote add "$NewREMOTE" "$BackupRepositoryHttpsURL"

if [ "$doSplitPush" =3D false ]; then
    echo "Performing full push to $BackupRepositoryHttpsURL"
    git push "$NewREMOTE" --mirror
else
    echo "Performing split push to $BackupRepositoryHttpsURL"

    git for-each-ref --format=3D"%(refname)" --sort=3D'authordate' | while =
read -r ref; do
        if [[ "$ref" =3D=3D refs/heads/* ]]; then
            BRANCH=3D"${ref#refs/heads/}"
            echo "Processing branch: $BRANCH"

            git symbolic-ref HEAD "$ref"

            if git show-ref --quiet --verify "refs/remotes/$NewREMOTE/$BRAN=
CH"; then
                range=3D"$NewREMOTE/$BRANCH..HEAD"
            else
                range=3D"HEAD"
            fi

            n=3D$(git log --first-parent --format=3D"format:x" $range | wc =
-l)
            echo "$n commits to push"

            splitPushCommitsCount=3D$(( (maxPushSizeInMB * n) / repositoryS=
ize ))
            [ "$splitPushCommitsCount" -gt 20000 ] && splitPushCommitsCount=
=3D20000

            echo "Calculated splitPushCommitsCount: $splitPushCommitsCount"

            if [ "$n" -gt 0 ]; then
                loopCount=3D$((n / splitPushCommitsCount))
                for ((i=3D1; i<=3DloopCount; i++)); do
                    h=3D$(git log --first-parent --reverse --format=3Dforma=
t:%H --skip $((n - (i * splitPushCommitsCount))) -n1)
                    echo "Batch commit: $h"
                    git push "$NewREMOTE" --force "$h:refs/heads/$BRANCH"
                    echo "sleeping for 5 minutes"
                    sleep 300
                done
                echo "Final push: HEAD:refs/heads/$BRANCH"
                git push "$NewREMOTE" --force "HEAD:refs/heads/$BRANCH"
            else
                echo "No commits to push for $BRANCH"
            fi
        fi
    done

    echo "Pushing tags"
    git push "$NewREMOTE" --force 'refs/tags/*'

    echo "Pushing replace refs (if any)"
    git push "$NewREMOTE" --force 'refs/replace/*'
fi

# =3D=3D=3D LFS Push =3D=3D=3D
echo "Pushing Git LFS objects..."
Get_LFS_Objects() {
    lfs_objects_dir=3D"$1/lfs/objects"
    if [ -d "$lfs_objects_dir" ]; then
        lfs_objects=3D$(find "$lfs_objects_dir" -type f -printf "%f ")
        if [ -z "$lfs_objects" ]; then
            lfs_objects=3D"NO_OBJECTS"
        fi
    else
        lfs_objects=3D"NO_OBJECTS"
    fi
}
Get_LFS_Objects "$RepositoryFolderPathForBareCloneBAK"
if [[ "$lfs_objects" !=3D "NO_OBJECTS" ]]; then
    LFS_SPECIFIER=3D"--object-id $lfs_objects"
    echo "Running lfs"

    git lfs push "$NewREMOTE" $LFS_SPECIFIER
    retCode=3D$?
    echo "LFS push exited with code: $retCode"
else
    echo "No LFS objects to push."
fi

cd "$ALocation"
echo "All done! Git and LFS data pushed successfully."



