Received: from mail-out-4.itc.rwth-aachen.de (mail-out-4.itc.rwth-aachen.de [134.130.5.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674939E16A
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.130.5.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940670; cv=none; b=n+Mxw3xBOPDQ/aEqFZhHoaHqLyePtpGV8i/MBsFKUkd+XLYqt1UCKeazaB1gkIGRKiVRFTFkWgWMyRZO3h/vJJsUV8Uoo2TaY629Gg6rrXzQ7NGvDJQejJpkTFbllESGCpZ31+AqCpABpisdGHuUgCS+G4uKPD60d2vzz9bxqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940670; c=relaxed/simple;
	bh=VH/5Z1gKnEioK78tWF6LqxfCMaT4EyV0HNiPg4Yvj1Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ugGKsQ4Q5yA/M+VqAZCtdUWsLPyM5+G8BPPSMCXIOIhW95BwkaELXIEwT3rK+LKQdrpvXyszWGVMt6bsuoMzUG4V7OX/RmlNUjqpfhAoTNmiPJKQi7DxS7S5fky4XwIX2JaRYYVzsopgbVnykR9z/hB/VGD9eOdTgmYOoZJXyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rwth-aachen.de; spf=pass smtp.mailfrom=rwth-aachen.de; dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b=nDDotBct; arc=none smtp.client-ip=134.130.5.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rwth-aachen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rwth-aachen.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b="nDDotBct"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
  s=20240516-RWTH; t=1771940669; x=1803476669;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VH/5Z1gKnEioK78tWF6LqxfCMaT4EyV0HNiPg4Yvj1Q=;
  b=nDDotBctQ4OCoWEhGoBsQbTXwfH+JJCplYpvpPIf/b3f0Wm52u5pH4q8
   x2R2ipRwhQZt9aHgxy25gXrlw9OzQy1XtD5TT0VrsrXKrZPkrQHuj0/x7
   NWakOcHuGNluHSGK2B7y2YQlpWEokGcYnhC8wLvKt6G9BYQEKwBpxRatq
   fhdi0sD5S7a+ou04On5AmaHWAlon8YD1Dnhvu48h3gWmdOnJ0JcJidOcS
   b1go+TkV0G3ZKIj9jjo+IDf/jzZu3lPfXQADaQFBy86B6WxBVypiaRHSE
   QTVTxBCZC9FmvDTmOjsjY+G8I5yexID7uhH7YiJ4HLBp9HvOa5vZHwJ7P
   w==;
X-CSE-ConnectionGUID: hlo5JDDqQ16BL4fb7oI7Ug==
X-CSE-MsgGUID: YMZrx9I+RRWPuF8GFZ5kKg==
X-IPAS-Result: =?us-ascii?q?A2BOJADlqZ1p/58agoZagQmBUoVNAQG0SoF+DwEBAQEBA?=
 =?us-ascii?q?QEBAQgBFD0EAQGEfQEBCAKNHyg7Aw0BAgQBAQEBAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEGAQEBAQEBBgWBIYYJRwyGWwaBCQIBTjElAgQbhW6pPoE0gQGEfNsygU6IU?=
 =?us-ascii?q?wGGLIRCggxDhA6LVCIEgiJ6FB2TGCyBHngsAQ9GExcLBwWBZgMqLy0yPDIdg?=
 =?us-ascii?q?SM+FzNYGwcFhlwPiHeBZoEegV8DCwdmPTcUGwYBgTWRewaBO4E4AqRqoXoDB?=
 =?us-ascii?q?AOCNYFnBaFbLheDcQESk1yTC5kGIoI2pj4CBAIEBQIYghIBgWpxgzdRFwIPj?=
 =?us-ascii?q?l/EVIE0AgcLAQEDCZJKAYEcAQE?=
IronPort-Data: A9a23:1Vk8S6Aap/21sBVW/3riw5YqxClBgxIJ4kV8jS/XYbTApGsr1mRTm
 jcXCDqCPvbYZGCjLYxwb462oEhTsMeHzIQ3OVdlrnsFo1CmCCbmLYnDch2gb3v6wunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dga++2k
 Y20+ZS31GONgWYubDpOsf7b8XuDgdyr0N8mlg1mDRx0lAKG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7ncHqFV15bvWkdNM1CHG0GwkmVUFPFSSuzXKX6aR/xGWeG5fgLmkH4EweZeUlFuhL7W5m9
 fgfdRIhQgm63ryc5O61QLZrp5seI5y+VG8fkikIITDxF+k6QZ3TBrqQoNUexigshoVHEbDSa
 qL1axI2N0iGOkYXfA1JTstjzY9EhVGmG9FcgE6UuaMx4mGV1xF+0bH3LN39YMOWRYBcl02Yq
 2SA82mR7hQybobFmGDUri/EaunnrAbJQpJDNf6CzMFSnXPD6UIhVR41Wg7uyRW+ogvkMz5FE
 GQb+zYGs6c/7gqoQ8P7Uhn+p2SL1iPwQPJKDPE65RHI1fCR6UCDGXQECzdNLtAr3CMreQEXO
 payt4uBLVRSXHe9EBpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:+t615K7eFx8Z1jMRSgPXwO/XdLJyesId70hD6qkmc20zTiX4rb
 HXoB1173HJYVoqOU3I+urwQZVoI0mslqKdurNhWItKNTOO0ADDEGgF1+vfKlbbdxEWmNQx6U
 5ISdkbNDSJNykZse/KpC2/FdskzJ2g66CnheDX0ndrQ0VRYbph9hoRMHf8LqWhLDMoOaYE
X-Talos-CUID: 9a23:fUETTmDeHVLNw3j6Eylj8xM2Nuw8SySD5lOMLUXnDkc2dbLAHA==
X-Talos-MUID: 9a23:dcSwYQqQrnFvy99ubO4ezwBHBt14soXtMnoyqYgo6+aqB3FzGDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,308,1763420400"; 
   d="scan'208";a="22292945"
Received: from rwthex-w2-b.rwth-ad.de ([134.130.26.159])
  by mail-in-4.itc.rwth-aachen.de with ESMTP; 24 Feb 2026 14:44:27 +0100
Received: from RWTHEX-S2-B.rwth-ad.de (134.130.26.155) by
 rwthex-w2-b.rwth-ad.de (134.130.26.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Feb 2026 14:44:26 +0100
Received: from RWTHEX-S2-B.rwth-ad.de ([fe80::da1b:3f9e:2ef:13be]) by
 RWTHEX-S2-B.rwth-ad.de ([fe80::da1b:3f9e:2ef:13be%8]) with mapi id
 15.02.2562.037; Tue, 24 Feb 2026 14:44:26 +0100
From: "Sugiarto, Titania" <titania.sugiarto@rwth-aachen.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature that allows the user to merge only specific files/folders
 from another branch
Thread-Topic: Feature that allows the user to merge only specific
 files/folders from another branch
Thread-Index: AQHcpZMvLszBf3EeWEaY9rlSzRf8trWR2/kK
Date: Tue, 24 Feb 2026 13:44:26 +0000
Message-ID: <14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de>
References: <532e9d58b905404fa625aa59104ce8f5@rwth-aachen.de>
In-Reply-To: <532e9d58b905404fa625aa59104ce8f5@rwth-aachen.de>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,=A0

I have a suggestion for Git, which includes a feature that allows the user =
to merge (I want to highlight merge here, not replace) specific files/folde=
rs from another branch.
I feel like a lot of users have spoken about this online but up until now, =
there hasn't been an update regarding such feature.

Might be worthwhile to consider?





       =
