Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741227;
	b=n4Rri2elvNNZD23ZpF6N417A/zJIXG4QdqOVX51ytcg9DnGogSOiY46J3EJPUbOOOVVW
	 65GSNXvoSxeKZy0NfZngxNFz8MejDvgox0RRdSXHPXaCNe86GlOgR2LCNj6cgN2o9v8Hx
	 yuRWBoVprWpVKf2RnngkQ/FZZhOVAdQkMxaRK3p+gLyN+Aj783ojcRW8bUc/NsZg5J8dn
	 OsnmXKNEpfxFqJyxCNOTCkOEpg2JZM0pcTuUcvGwDx7ftJhbnca3e79+20mVcrTOVBPhG
	 B5B3Rq+SKG8OxFHqpDJLGyCrcIXD2EZiufTgkhHhjhCO/0e+w2MrqYfKaOIEs/MO9xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=un4j5NXTn5NtUvxZMywoTWnGMfQ7GDYSAhDdBQ16zBg=;
	b=RSUkY4rcSmC3zWwxyvtHx/SS2D+qk97pi0OsfahyqHOBUxwbOwy+NOtgxlH/Do7IUpji
	 P9Tr16mU4flMz85ETid0JH//46EQ4l3p/hnEBU+ZvN4fGIofsOLCQ1rbiXtzozQcPm4xy
	 79MQlW+Hw3i8lgPwfFJcPQhuLBPCwlTtsawJuBvzlXa0kocvW8d+lQwpvhhvlKPjdGNQH
	 h0ZuZNHGuWFnER40XKZFiVtY5fUeVohtqlmQoZ3yuGMdHeJBsJEtX3A7zGSscwlZkLVl6
	 nOfTnGhIWqi9DaAzDdiw+T78Y3dQGIriR/e7lHsKRHPbdlJbr4JAOYM9E9RaiWd47wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWVRfMx0;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BF606A333
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C7BF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWVRfMx0
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso128825e9.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741226; x=1794346026; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=un4j5NXTn5NtUvxZMywoTWnGMfQ7GDYSAhDdBQ16zBg=;
        b=MWVRfMx0AIPUzsrHNXsjw1rrGZ7uPG0CESMvQGHYrJsgx9Jhr0qxO0lzUFZP7+5rkS
         +xfgvwuWA0uOJL85NIZw1A4POsYPB+Ocbfqy+st5nvDbcGA+4ny0TA9T9DAiRDme9uG/
         Hp0cWdSJIujwUbCMXf1KhtUcETfYrJPAnfjAF6DBhjsY9o6uW5flqVw7PjZZuCE98Q96
         yPHt8ZeF9RAQxJM6R/PbB2BRAcRaAXIZxQa+wwTI16ny2WFASeHFuNkffVyo3sypmY0Y
         XjU6t5AFvSo9RGtt6gTEzQr+90dn2glxyfYITUhON+JK1m8IvxikpIr+bLIJTPWdClyv
         mj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741226; x=1794346026;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=un4j5NXTn5NtUvxZMywoTWnGMfQ7GDYSAhDdBQ16zBg=;
        b=r1NfrvdZWtrbzO3f9cptEwYkvihtiRtIbMSj4PyqYDq0bTfFN18ixwDhpaUqeK14Gy
         ILe9YZZHewR6CUmdt1MHRCKDWT9A3hDbOKs8RaNQLb7tBmbGQMsq2GMZ1E8he4cJUEMU
         G/6rPl5p3AY74V5exDbZiUpVi4v3DTKwh1OvkqVlG0vO6foHviW6NXKnHqnG2TNQdUjA
         UhtUAOpaFtobABQN6UpWFIkUM24ARH5znVuYjOokQ8mpTVDYGhVYgj1Xey82I1ZZkwFG
         7hAc21zzbLx/APoH2MEwx+HWwD2iFtxqE58iLU+C7PS4ay2SMQXYwX11Tw8rBuhUYFHh
         kxmA==
X-Forwarded-Encrypted: i=1; AKwUvByTDyJxlOSQNvLlGqYdY/nyI79lCcj8UjAzfD0DVjXoKX1rEXqua0CYZ8TUZFRh9S16cTY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OzdYiOvv1hSvctcpwpS2gm1y1nh2YpB9mkObgT0+2+tnITsp9
	h2HsoWM6OiCYyRXvjKHnqp/i04T0gORw01pBP/wB1P7CtFpI2amHtsS/
X-Gm-Gg: AYBFou1hWoD+KIPf36zwrcN9RwpDkiVd1PYPcfbxQYOURrSmQ+t2rLOYk8mEb3rATzY
	T6KkGhX0Hf3wIDojkGd+bgL5+2NMIl0Y0SHBdqdmbLpurAh9J/kF2Vr4a97EQfsqQrWgBf68ASm
	9ryZ/K7HWoDEtsM/xT3UHQmuZ9mEnx/5wfyzFkrjQx+pBAtOIjjCQgep4W6+togNUNJ1lYye8w9
	7AjCIlvbByXI0b6FOkKTRqDDIS3vIuW7t5dtewRDUzxiy2PxBD9TpkZRfUCFfLTbrOyiWGlQPXQ
	X75tQ6hKRWj7IJ2rnXK6B7wnULSIAbD84hIG8wqzG31RAFuHPfTDJoJv12BKFScSMGCTMlqDep/
	svLqFtcjr7WeSwg9Sg7MsfHGMMxIYkIuNFe78tMt5bgO4UMLpys/8AYbCho+CslNR3wozvzezxn
	UFMfgG1et4EtwAZosjop9S0FqE60LjJh8unSgEHvJ/2+zoGuN8FALrypvIKg9B+dwSr+iEjlrZj
	xG+lkwwMJC4IWQXJo2M5G33Lk9vwidyZ9GxRmQZoHKOitaZIe19IDX/ALGAjUL6iH834YT4L2Yi
	Cqt2aquBLL044SrKv3K51EeuXv6HssCbv9Zihs2uxUXpfu/idhIh24tZDqZWCbMxWkV6K6x6wud
	R1F+ySl7S8P8xT+/JxO/LxPeWW6yT3Is9AjdEVhM3Ef2vGgqOcL7ylU2vY99G4bHGLv9LJ7lxxe
	0RIOnpKoIiXCyThyXe30OE/NZBINs0bENlfK4jgR3kBtH4igiW2YZt
X-Received: by 2002:a05:600c:628d:b0:4a1:e01e:1927 with SMTP id 5b1f17b1804b1-4ac17d16a1bmr327243675e9.5.1793741225649;
        Tue, 03 Nov 2026 13:27:05 -0800 (PST)
Received: from localhost ([2001:818:c665:a700:a4bc:846:cdd6:3f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece998absm142876f8f.22.2026.11.03.13.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 13:27:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 21:27:04 +0000
Message-Id: <DMLW72EXMN1K.3IXVPHWNYQ3EH@gmail.com>
Cc: "Pablo Sabater" <pabloosabaterr@gmail.com>, "Karthik Nayak"
 <karthik.188@gmail.com>, "Chandra Pratap" <chandrapratap3519@gmail.com>
Subject: Re: log --graph draws an orphaned branch with parents
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "herr.kaste" <herr.kaste@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com> <CAFzd1+5s6V+YC3onNjYQmxRPVnsMROpsVi=qy1mg2=LOAnU+gg@mail.gmail.com>
In-Reply-To: <CAFzd1+5s6V+YC3onNjYQmxRPVnsMROpsVi=qy1mg2=LOAnU+gg@mail.gmail.com>

On Tue Nov 3, 2026 at 7:25 PM WET, herr.kaste wrote:
> Finally had time for a repro (tested with git 2.56.0.windows.3):
>
> sh
> git init -q -b main repro && cd repro
> export GIT_COMMITTER_DATE=3D"@1700000000 +0000"
> GIT_AUTHOR_DATE=3D"@1700000000 +0000"
> git commit -q --allow-empty -m B
> git switch -q -c topic
> git commit -q --allow-empty -m T
> git switch -q --orphan orphan
> git commit -q --allow-empty -m R
> git merge -q --allow-unrelated-histories --no-ff -m M main
> git log --graph --oneline --all

Hi!

Thanks for the repro and the bug report.

>
> Actual output:

The bug is because the indentation state GRAPH_PRE_ROOT is being
triggered, due to "R" being a root. What this state does is add a new
row to connect the indentation:

>
> *   40a81a9 M
> |\
>  \ |
^^^
This one

>   * | 1d9120a R

Then it pushes everything to the right.

>  /
> | * 5a29a85 T
> |/
> * f1cd12c B
>
> With --no-graph-indent:
>
> *   40a81a9 M
> |\
> * | 1d9120a R
>  /
> | * 5a29a85 T
> |/
> * f1cd12c B

The fix should be that the rendering of the graph is the same with the
indentation or without it, as there is nothing ambiguous in this case
that needs it.

I think I may be able to see how to fix it tomorrow, but I'm quite busy
until next week.

Regards,
Pablo
