Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383870;
	b=dDU+foSXbrdddYcEntHcoJJvDDFYdomjw/fRsavzt1+q2Dn0/2arIFOystgQfpL5GLXS
	 E4DeyLuyF0mRDfTVyIBwKm98QPN1yaolDQJJMBPJqlZHgNZrt+4IoovKY/rFKZvAIXWGF
	 ljpfkxdizf4fFZnRJgSUfB9bOf/rLD4MZEZZX+YmD9wAeSRDqiLU+A7oMO+1EHDI/gJ9o
	 gO+PzWxCr8nLBvO64iwQ0dXvZuwpSE7einAlbKQUATXEdc6b9W3krIhpPqhIbG4qmf8iL
	 ycsQs+vf2oiUpdlEXAOkLc4jv5ma9USXgU7AlFM09TGQ4/vvOzNc/7DfErtHBRlSyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Subject:
	 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=EGZbTurEtIIE7xhLnzq+GuTQpb9TX3kyAYcTjpFNrM0=;
	b=TRO4ug2cNabhdf4chv08cAOGcu3d2rPF8rRoy5w+U0o1Nf7CWl6WBjTTv8Nk06hwN35F
	 +E0tlX+k5BlDjkeg7pCUbPIrX5ISDCuFWt9voGDaVFl15LZ4oBGy0x2fP25v/NmX/BJIp
	 vS2OopIK4oVsTouOmONIwokdmLRyjT+Flgu2xsXqthy7OtNY2/c8gPCZ4jvbdGM6D2xg5
	 IDmVjxF98cSZJrTbhvHv7sefGLKX08crr0C5qQjhTenK/uBzhOvyFdpSpPFgl+JZqNjBE
	 m4nOphMKv45SRTINSKEwvpFEnSt6PHCEjmUEhe7ypjc8PJJJc6e1ifHoX4OhJXwdjWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXYHQ809;
	arc=none smtp.remote-ip=74.125.228.135
Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A5606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE8A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXYHQ809
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c50564a92bbso76565866b.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 23:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794383868; x=1794988668; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGZbTurEtIIE7xhLnzq+GuTQpb9TX3kyAYcTjpFNrM0=;
        b=kXYHQ809c+PyWabr/xw0mnRv25dkJCCMjnv9MldJYIqGSJfjnxyLNyiguo7CFGrjN5
         nhVo0XYG/HEkL3esgkJlaYcdfTYkv+kaSGwLsHFcvG+yafN8EytFz1WCsRyfW282XwPp
         xw+seXTUeR94W24/l+OTvEAu2B5y88j6P+K/cwtM0xAvhBfJAHgJPhzjDthsaKeiYfZt
         pDr9zqmuiGHBTKYKI687WfoqaZ3Rr/iSsdFimTDGikJpnFx856d3tq37oyf1lIdEyrLX
         vzvhybkyARawC/VjBrTzDWVUo125U8Bh81sdlHuDyhSH1bDDiaZNSo5saYfK/vp99Q4W
         2FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383868; x=1794988668;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGZbTurEtIIE7xhLnzq+GuTQpb9TX3kyAYcTjpFNrM0=;
        b=ZjB+RbFaQnl4HbvJbtKybFyeBPwhyTu7zDUtNwoQdaCWQ9r3teuBmwUflptpLbQbhV
         nakQU0Y/RsV3mXBYtHfoQPi4Nv61b60SQdwXbnbxReDQveArmWEsZGatPzOmoYfnxB3I
         t38+5gBycdPMD51DZfo9Bba8yMTqaHnv8/zVG9+EyrkEoArIUpfkqtGLtoJLsB++37nK
         9QBQuzbdTL0o2uv2wSV9nbRMX6idcxKLyC6udDauJdEJ0wEqV4+jxZyI2EXJ20M1gUxm
         O0kVZOoUBOBt8bZ2cjLFi7mhYZ3woo8FJ9ieMDiEaT19xu3LOr/ZU2IF3HvL6poTYQRL
         tZ1g==
X-Gm-Message-State: APuU4Z/AO/vB/GSG0U4RiuXmvjQ+57gFlqTz87mBeVEWds3NewSKZfXn
	Kyax72ipqIHKz803L0WLV7C+521e6N9zLFMstwSRJZlqdfLOetDPlmSJnj/PKcrkjbzs2slM
X-Gm-Gg: AYBFou0NQEj6UGYId0JiQ1XDuPa6AVsR5y/4rdHyCe6I6VVQF96v/hfpIzqnPR3W3uU
	AC56MxZJCezZcl00nJe/jPwI2BuRlUv8/dwidrRc06Hm/q0Vk5sM/4EvlCd+Jy7fmIuuQm4GcsF
	LhpNjle33qQ58XfAe68aCOmVakwmM8tv1WWJwuwTpPREY8Ckuuh33O8t2yPbRXk1xeVipUdWACQ
	QX9QazAHT872Fv92BMjb2ZhN+W6stnIzAPafEUunUoupLbuQ9hUqHabP1UjNKymUHvJ3F7PoCmw
	APmPfr0SH6QO9y9oclLIHbBo5t/6DOnGaozigQavTFmUxfTEuWsPzZVMjc0UIG8YsqxDwh3o4Ew
	fATrYHPcYTnheVhNE4YuU1tr96IFyZGYzyireEBj3n32/qU/36x3R+bDm8YacOhVAjc31JiQyOa
	SoYW5iLs2aihCpvH/wMrmaVNBgKvfYyMwwrYClspMe43HGMvAKIfuSl+rx7SktUgBeQfZFzlmXo
	T9WN9rjgce7CRS3oCI3ffI1XviJhA+0pqJTjGpK29wAOVkBAmg8790TXGsvQt4tlwzydKod/ZpZ
X-Received: by 2002:a17:907:da17:b0:c3f:153a:8649 with SMTP id a640c23a62f3a-c506694dfebmr108300066b.7.1794378015935;
        Tue, 10 Nov 2026 22:20:15 -0800 (PST)
Received: from [192.168.87.59] ([197.211.58.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6dc3sm205630166b.6.2026.11.10.22.20.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:20:15 -0800 (PST)
Date: Tue, 10 Nov 2026 22:20:15 -0800 (PST)
From: Your Name <cindraviugc@gmail.com>
To: git@vger.kernel.org
Subject: just signed up for GitHub's UGC creator roster + 2 hook ideas
Message-ID: <179437801002.11040.10361709530470487284@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hey GitHub team,

I just saw your Direct Brand Portals call for UGC creators in the DTC Brand C=
ollabs space and officially submitted my application.

To make things seamless for your creative team, I also mapped out 2 custom 3-=
second hook concepts tailored directly to your brand. Here is my 60-sec UGC r=
eel: https://canva.link/iep52tp73js7yaa

Mind if I send over both concepts right here in this thread?
