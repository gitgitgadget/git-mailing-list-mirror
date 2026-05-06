Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301573043BE
	for <git@vger.kernel.org>; Wed,  6 May 2026 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109674; cv=none; b=SZbb/VJqJzAlf4purlL7cxnM3ehq5ISXUxMBvaAzbldpl9L8iROqD8r0QOTpDpfZAfDx05BN2WTCpgIcok34thncJZII4d0hEg24GxUtiwLtEGaSCTDSZMM02H98Kn9EGYVtxw6xFzM0iUUsxI7mG0iY0lIlhaoz0j67vnCdTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109674; c=relaxed/simple;
	bh=N2s6+lsNkMiQo9r4yoXYNueLTFaQ11T5Rkl+2AjEewA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DdU2UuH7RPhJm4z50CZ2sxg0Do3EKJ71X7SfPqVsJH2qC3A361up/hEaLE3WMXL9RK5QoGhOfWMMBwJEYpEvcPbM7EjDYone3jN3nOYa6F17eSNBfDTrTcpmZ7PE6OR3HPH+c7NoCR5QOduig6KAT4JT9nKKCGKNXOlTnKWNQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs14ZAUk; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs14ZAUk"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a7109f568so1894047b3.1
        for <git@vger.kernel.org>; Wed, 06 May 2026 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778109672; x=1778714472; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2s6+lsNkMiQo9r4yoXYNueLTFaQ11T5Rkl+2AjEewA=;
        b=Fs14ZAUkLdbCxe54i0267gIbNRtyOfe2qMnSZHjvBumaK0DKB7DcOMmTvhPREkFigh
         L8Vynzk2CZ2K66Rq/PtbGZuxBkvVUZk3JXJW5Pt2MgJYbG5URROrSnrOM686gp8m9wG0
         wL6Z/DIPSDUiYaXGZbbP44Swm0uPYxLjNtir+0zb5Y0IktxPJMLIvSV9ANdp1ZDXlCD1
         wF8FFND530YoQ1L8YojhT04yGtsWuwgxPdeYHGqHPCMEyiNycn9BHhuZl0HY8oAU79nH
         YhycyafdqacklY/3QccIx3lJFNduvg3wHa+fH0Lk14MaMr2by812qurBGWoZmGwJYlwz
         NSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778109672; x=1778714472;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N2s6+lsNkMiQo9r4yoXYNueLTFaQ11T5Rkl+2AjEewA=;
        b=lyaNRBh94GESccpsskGg0MCX7CiSlPGWB3N2iL+mYyrTTvxXyGBHknZL1Jc6gYocT9
         es6+LUf21qMkOFBKn4XGNLLFjuJQFjvLg9i9DnHgQ9iZuhM4WKoZjQBCdjpPkatFyhdy
         ZMmeamnrZ7o6PdYBBfaqwJzlbyUi8wVahMa6cSC3q1pFQuP3jmvBRwecuP0xamTW6qh7
         Cbiyo7kEh0ELisoxE68rmntqFElqbtueph5cxb/+N2LfiyRaatGCGS0Hlf5mOtRPpXe2
         QMVEt7d6EQfSFSxfyXf0w+s7dBE+dBvlVesOnFKk7LYmZglk9YK4TYO59KZ3SxgCKL1L
         vv7A==
X-Forwarded-Encrypted: i=1; AFNElJ9l/TilY1pp5Duti4TC7i4Aw8z1wUX9I77CvKnMXkB3lw6HEVKTZ9wI/OLniVcGFFjWhbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybS6zwUpNLXAdnCi5ZP+f72lPfq1AQOgSC+1Yu6/0Ot36C9CUV
	/KcfoHb5Oa7IlKAaO/A2PclWdaHUuaLOPXEMClr9eO4QmnS4GAfTd7m9KO07/A==
X-Gm-Gg: AeBDievLzuCkPB61w+tJsvwx5XkA+zJbNu5TKjwUl/NHuGQz97XA7/KE49sWqoy1klb
	yRX/UMx3/5t1ZZzCmPTsv9tCLcG8KhwuaR61h2SQ+0SW6+o2Z8e8TPXy4klSI2hkiyYFnif+GcQ
	eLSfetqmGKF3HkQDOWCekaqhdbbZ0py0gV5o2xjntFCMtWMoReaKaOBK5hq7UGIXR7WdLzOiXWM
	pz0D4QySCmriXPMaH5uzxVVnGiBtHH2BGLFILkA3bMPWYie89kzhawdfd4FD74rCIwfu5PtfwCX
	i4gn9Rl++wZuT9cDS/k1jWoBMnjot3pymdcBKZoi6V1GD4/jrNfn43vCd++8SvgMa7DUfQT6ssq
	pH3WxfCEyGzJSpBaNvXi4M1GyPKjXXzZkBe5OGQXQllxvnb1AGkmncyz4C5+8hsgkWpaXzmiD2Y
	o61fehTf5n/Aa9NmxJAQ8zXUrhMO0nJVdge+Xt0isuFFQdcM++Ac2j40Xpxbd+vcMJ+6rydArsu
	MoB/4ef6WOlYEhegxQtJ8kveKUJParXJEhWRcfDq3cyW0DdDP74yMjO
X-Received: by 2002:a05:690c:6e86:b0:7bd:577d:7828 with SMTP id 00721157ae682-7bdf5e87a8amr64722507b3.31.1778109671659;
        Wed, 06 May 2026 16:21:11 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:e86d:a706:9ec3:b090])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652742csm84071327b3.9.2026.05.06.16.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:21:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git 2.54 fails to build for rhel 6 (2.53 builds fine)
Date: Wed, 6 May 2026 19:21:00 -0400
Message-Id: <87E428E0-97B3-499F-A352-20A1E617D168@gmail.com>
References: <14616621778106505@de6a8060-5532-44d2-bc08-24865b6e9c4d>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
In-Reply-To: <14616621778106505@de6a8060-5532-44d2-bc08-24865b6e9c4d>
To: usmanov@ieml.ru
X-Mailer: iPhone Mail (23D8133)


> Le 6 mai 2026 =C3=A0 18:35, =D0=90=D0=B7=D0=B0=D1=82 =D0=A3=D1=81=D0=BC=D0=
=B0=D0=BD=D0=BE=D0=B2 <usmanov@ieml.ru> a =C3=A9crit :
>=20
> =EF=BB=BFany chance someone could show what commit causing the issue, sinc=
e 2.53 builds ok. Ive looked through the changelog for 2.54 didn't see anyth=
ihg specific that migh cause this.

Since you are presumably able to produce the build failure, you could use gi=
t bisect to find the cause of your issue.=20=
