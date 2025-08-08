Received: from outbound.pv.icloud.com (p-west1-cluster2-host6-snip4-7.eps.apple.com [57.103.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3621C179
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645452; cv=none; b=sCWpwOtdlJAeW7vDjHq2OIKEMtku3tUKnulXXvgZ8qhR9f3eL1+gwuopNI8IoSWX2GRuyPr7WzuYBuZpNc2IeN2CTVarR5MfYS8bcJ8R3IKkUcwbP1VYLSTVH78NpLw6REcN+vkwKaPy6+RHcHBvKG5AKqI0L2QZCEuunOFVDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645452; c=relaxed/simple;
	bh=VRVPY4lGBjpvirPv9EHjWD9KaV8mADhdeTFvVRKPZZM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KmBUOlwnODjApXcPDGw3CSX+IBumrAYniX6BMR1wM9ttNM9oMN3NVCk15p3wjhTOTwAdpZpXtfbsMPZv5nziiNo149TvFcAdgOwfxn4ILq+8Wh2p7hYg8BFIosuZZ27cTRd65toumr3dQ1SzBbxHeW+Q9bVG4VmifERa8jweCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XXasZ0t0; arc=none smtp.client-ip=57.103.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XXasZ0t0"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPS id 127E218001D8;
	Fri,  8 Aug 2025 09:30:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=VRVPY4lGBjpvirPv9EHjWD9KaV8mADhdeTFvVRKPZZM=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=XXasZ0t0CCjIeFYGBczr7XEzZtSkNP504KFO9+/Wl7kMcAOBDOmkvxwX2uPN0fR7mvrDPuaOOEDLCHdHnSVNG7OhtUpFo4DJDdqobXyRx/QrgiAnGk3VJkzRjkYokpPClPUeSiCIl0xOnxn4F/WeM0GwQDxzxuypjnpBGPnCGriBGpJbln/v8n2p5lVNuV1qxnKzvVz6Hn2EL9Xa9UCGscg8WP6mZerB1Rir/7OrNQ8hnJBiAyM54b6RnKCKtELY5PJZt8viiaKDVvFqvwJnsh6RBmLyQ6i/fjeSJHrJ5zLF0xzf+1E0m0B7Lc4+Y2L/eTTKzBdtiulxh9dM9aM/6A==
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPSA id 5C2C218001D7;
	Fri,  8 Aug 2025 09:30:46 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Discussion: Future-Proofing Git for Massive AI Parallelism
From: tanish desai <tanishdesai37@icloud.com>
In-Reply-To: <DB7PR02MB42658E4F3245CF0BA5B69AE4B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Date: Fri, 8 Aug 2025 15:00:31 +0530
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Tanish Desai #TD <tanishdesai37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C13A8F0-DF6F-44D6-A325-C152012AE140@icloud.com>
References: <VI1PR02MB4271E311313F60FB07359BB0B352A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <32989B0A-2DB0-4787-8A08-BDED46258C7D@icloud.com>
 <DB7PR02MB4265771098F7314E47D9F2C0B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42658E4F3245CF0BA5B69AE4B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
To: Skybuck Flying <skybuck2000@hotmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Proofpoint-GUID: -4e3GSviUAtE3dvKoavwJeA1pI-QSWV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3OCBTYWx0ZWRfXwkkLDwiRv7Bb
 7pJPniplbiAZMMwCaEELkyekV0gn5sF7rzHIirIOEE8aac0K3fU08q77vH964JDfvm11JgeHjBk
 sNIPefDsirf0izIb8/G1gQPxQpRGQtdCWQzGTSNtKIb2RKqcHXenHuiIfTnPtj3x7B5NgLjtE4H
 EZHz4YuvEwbzm4/ehf6CwHh2xmIYzJGawCJGanxwDKRJEcyLPrFnYKnNh4fjFMTeX/TJAzQnmhH
 H8w8cQTleJrqrD2Hwy6vksPlZuMMVg8l0KBOA0MToTgUiQ1Yd6Yx+pcqS9LoQ2Hv0liPG59UA=
X-Proofpoint-ORIG-GUID: -4e3GSviUAtE3dvKoavwJeA1pI-QSWV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080078


Ohh great to here that!
> On 2 Aug 2025, at 3:08=E2=80=AFAM, Skybuck Flying =
<skybuck2000@hotmail.com> wrote:
>=20
> For now I am busy with applieing Gemini to a RamDiskSupportUtility to =
modernize it's code from Delphi 7 to Delphi 12.3:
>=20
> Brand new project/fork I started today:
>=20
> https://github.com/SkybuckFlying/RamDiskSupportUtility
>=20
> This tool would allow a Ramdisk to be created on startup of the =
system, formatted the ramddisk (sounds a bit dangerous ;)) files copied =
towards it and on shutdown files copied back to the harddisk. However =
the existing tool seemed somewhat old and a bit shady/not that well =
developed/not enough error detection.
>=20
> Since I am now on a super duper trooper system and don't want to risk =
damage to my system I've taken upon me to check the code, modernize it, =
have gemini and potentially other AIs look at it and finally use it. =
There is a risk that my involvement might actually backfire and somehow =
damage my system, but praying that won't happen. The project actually =
seems to rely on almost ancient code/tntunicode in a time when unicode =
support in Delphi still wasn't fully implemented.=20
Did gemini cli converted the codebase?
> So today I even installed Delphi 7 enterprise to "time travel" back in =
time to see what kind of tntunicode gui component this project use to =
get an idea of how to re-create this old gui in a somewhat more modern =
delphi 12.3 gui, still vcl based for now though.
>=20
> It will be very handy to have this tool. I love the idea of having a =
ramdisk for firefox so the browser becomes lightning fast. This saves me =
from having to modify firefox code base and ripping out all of it's disk =
writing code, though it's very tempting to try and do that too at some =
point in the future or even better port the entire code base to Delphi =
just for kicks, so having AIs to be able to do that would be very cool =
and amazing, hence another motivation for this massive AI parallelism =
project.
>=20
> I hope once the tool is done and in a good state/shape it might be =
useful for others as well, who like to have lightning fast "storage =
operations" without actually wrecking their SSD disks due to wear and =
tear...
>=20
> This is also more first "real" delphi project were I will test out the =
capabilities of AI/Gemini and to see if it can lead to "real world" =
improvements to source code/projects/software/executables that would be =
cool and a good sign for the future !

Bye for now
Tanish Desai=
