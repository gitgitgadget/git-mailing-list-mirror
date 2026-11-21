Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281957;
	b=TCjzRKoPX0+xyYvOa38GhMUGfMT+QzZIDRAsKB/h3U79f9yhG0/k4cZ42ipCfmhGgBJg
	 uzB6q/6ePIeObW5c/MZkHEdior3Grn4bki+JnN6y+LAXgwI0viXqigdi0CFUAOk6SXd8N
	 Y7yJAN+q9+oumiPbFbZ9j6iO91kv3xJ9IkdipqlGvMpjrcsDjwS/RQd5QqJg3U6X05Kdj
	 a1oNJMu3TtyJcnNjUz4oIzwoSzYCROD95KcyA0MPgJKiJ3Ryd8LWtNG04aTiiB8Gh3FNT
	 6YIkN8wVCyrjZ/fXH+gSBYAtJ7DSV6WWChnE1ED11mo6aCIC2rqt9Qkid+zAUTJtFdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=3fJcQxKBNMG1sB1BtYvRWseAS8A1rpdhjeCfwJobK7I=;
	b=uC40Mi50Dkfl6nB+QIbjXRbc2ExA15PyPdmqR4TOmy+QPXD7x+xHCdcdp2Yq+ifXuCSn
	 fp6Z17yEoYEUW94lEj/ThGdC7J4lyAlkch0FacUypgj8Pfut/QIolDcL6TZm8mRk41IWH
	 HoU4hIZIg4gvmLMwomb2yh+pKkj1SrL542ponaKUm5DO0pc0scK7W+ZFkhKy1QQUAwg0x
	 TfZT/fm2VI6FV7nK5XbutGTqxnaYcq6nIg2y6kCKAMFroaSEZNy2/HZptYGQI+8DDMUaw
	 5kk5+HoiQEOOd3fKgObcuEyVDDD4dU2gJ4J6VC4V9uYAJOssF+j66nHnfOBnDRMWHJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fyUbCsDb;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1639A606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 17:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1639A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fyUbCsDb
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso17988995e9.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281955; x=1795886755; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3fJcQxKBNMG1sB1BtYvRWseAS8A1rpdhjeCfwJobK7I=;
        b=fyUbCsDbzBKd0W4WAdFKBN0Vhgj/5s60cH+xvHhNFeYGEorEmcPIsNINFtkJ7O/6jE
         XwgmfYjMxx4woH0QUWOsJakb00s2aeYUDzBmIeT5/9LcvJGQJNpderv2HWILwipw+nfI
         H8xANRpxMTIMOccYGJq+ckcpllAC/7CxT8lZRey9m6vnRX8U+JTBO2+/K3H5uW2mhSHL
         lQJQHc9xAGQF2TK/0HcCZQHw+6DUWHp4T+U2GvAaIgicQePvCOwDsnqsKPNPKYaw+4sT
         5/DYzJAqdZ9srX2ezKN/5QNdEKVyS8JPedGXe5UuH6la2Hv5mkI1QseHLm34NYTePmq5
         GKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281955; x=1795886755;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fJcQxKBNMG1sB1BtYvRWseAS8A1rpdhjeCfwJobK7I=;
        b=QalFmN8BN/TDTqMgFpKyOKqdg1EPNMqK+FBNGlMKDB4pbdbWohAXJ/KBjtFzchchHQ
         fxe/qvaqEJ56tCb4aio1HRXbds4Ir1hS+/zx1eUk71ieMCDYRAnGY5xuCgr6qthzFYkC
         eXAO30shmOd0RV9672PGXbQREGNube2P6R2MvaY8dxUBA0+q67r9hZSx+CdQ79cieKvO
         p56qzqVSsULyqSvffuBA/2Ac8JpOyJwgStHZWNcLu3qoeDikrjZWfeEAZlWxC3Na4Ul4
         2nQkjDbkTYjPqUnht+fQ5WlJE6NnAE5W7xTVYcspuMPK1bkvHfoDw80txcugfK99Pf/7
         XkVQ==
X-Forwarded-Encrypted: i=1; AL+hErH1rk8oGIPK/TUgmU17eI815R6+JVmtdrUKqYH9KUAdhp+s4G4EqNqxb3UaGajOjFA3xtg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s1Lq48m/f337Ts3Tda0XevsSIDB+Hd+YJ6XcznK7oS4YAbH3T
	50HyX4ongmgZjc161gnDK92NONPwcBShdiyDMtx22nywNJJaJid+8Dk8
X-Gm-Gg: AZFdTZdZrJLk/WRIJmsHTXL/gtexy1fQ5s/iOsWw+xAagAahCSSY0XTiKInvt+bsE7e
	kRpqda7G+CJn5Yt9A94JNlLiev8J4bYq25gXYhikWNCSiieLu9oTdoPyytWTpn4IWRbUnrGrNMh
	dQ3Fnt0d8QnSktoTeeNqPhQmYS38qgrv781i8PFJqq6Q+hVwML/eCGqxG4FqawxxxfP+ltMsHxh
	dyvdntZPq/EEw7oyKyKdqYz633CN7Q2W9qPZ7c8jP1q7sZbhuf06ULBx07P5s1boeI9Ql+P4m+W
	oORb0+hC6e5MhuCT4dYLc+ubaZhywkbzBFM7JDYK7SdGG8HjOkoESInAn9By9oxikLB9yspHQok
	Q9lv40vMF6jVknJFceTzItluaCUjB5/pi16bdDBESmNn2h8LJT8Kk+DQVVpwIDWbNUdKS+DLI8O
	JX2EDvgq/glQ5PkG7ZvpfYYSNQp/Evc5A+JukaKMJyZKDDY1em4iLfkcQzISHW9BgXnGVPrUrUQ
	Qvg7NyVw6AxkLVoAh/KOtSs0lMeQ9mrnXU/XAWjCxlHBqdEvz6xTW9P4o5eh1nmQpOHzgh+0tUj
	sCWULL76rEWa4+7hNyg0w0Rms1PZLjfwzzZlOfogtdIXyE7tlS8drtmvTRDpVYi310+iCv+Kuha
	OZKY=
X-Received: by 2002:a05:600c:34c9:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4bb88810d28mr158002245e9.18.1795281955347;
        Sat, 21 Nov 2026 09:25:55 -0800 (PST)
Received: from smtpclient.apple ([87.68.137.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm226674705e9.8.2026.11.21.09.25.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2026 09:25:54 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.300.60\))
Subject: Re: [PATCH] github: fix typo in main workflow file
From: Ophir Bleicher <ophirble@gmail.com>
In-Reply-To: <CALnO6CAqmkigFKUYcpkmfg6zKGpqfRTAXsxdH20fEA54wuVH2w@mail.gmail.com>
Date: Sat, 21 Nov 2026 19:25:43 +0200
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC7ED551-10A1-44BF-83AD-9C98C87276E0@gmail.com>
References: <pull.2499.git.git.1795279151447.gitgitgadget@gmail.com>
 <CALnO6CAqmkigFKUYcpkmfg6zKGpqfRTAXsxdH20fEA54wuVH2w@mail.gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: Apple Mail (2.3901.300.60)

OK, thank you anyway.

> On 21 Nov 2026, at 19:24, D. Ben Knoble <ben.knoble@gmail.com> wrote:
>=20
> On Sat, Nov 21, 2026 at 11:39=E2=80=AFAM Ophir Bleicher via =
GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>=20
>> From: Ophir Bleicher <ophirble@gmail.com>
>>=20
>> Fix a typo in line 10 of .github/workflows/main.yml:
>>=20
>> Older runs are canceled when a new revision is pushed.
>>=20
>> The typo is 'canceled' instead of 'cancelled'.
>=20
> This is typically a regional variation (e.g., American vs. British
> English), so personally I wouldn't bother.

