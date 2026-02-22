Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56910335BA
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771772003; cv=pass; b=kOBaQ/odtpjYj45Raxvy6wy2xad8FPGSFIjl4KDIuqnuMLASxOxoJ7fDQfSlSsz/k5/ePTj9lEBzhQgDD5pHYyt850odqdBiy8ItBOGcgO4x6cs2O3lgNYnqxbyXUgjXZROYYLUMWWSVPwNhoNeNsVaJ2DpNUAWbA9BdyOfWmNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771772003; c=relaxed/simple;
	bh=VMkZhvfslvfP5puYdns1dXhdD1lHJ50WjGkCa6+yNqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4pwSgiL8z4HDTCzzmlJZRTmXnjXTBz09rIOKGNI0fyup9fHjFAw0qvtnEafSP5aS8ct8XsAgpx3oeUdICuSMpxlu1WoPXijZIG2LtwsaAuaZcp1ag3q2wG8/czbxyknx4a9xk/5Af5wwFq71VvrYrbGvOhkhhNfOMbG1T6uCeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etpdxw0z; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etpdxw0z"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so31652745ad.2
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 06:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771772002; cv=none;
        d=google.com; s=arc-20240605;
        b=LaDp1ZQAXxcHTe1V/rpkTKrtWKYvJ/Nov8HaS86jwGDvj107riy6ZuTnDu4mJd4CAf
         /1qA/AuMzCM1gy+0ddQhFgFzqtLk83VkwF4Qx9Bve1bxaiLWRXjEJV8vDDWXIpY5s27y
         omcfrIN1z1XO4lyPWmGKbIqfooLuR0ZRqxxvsIfPve8YEx71oG7++Vqx6koxgIFwqA9d
         Iuy0s6xvLOPItViyif7QQSJ0FDhzU5pmQwyQsNsO4YIynr12/kfGew4dqKzBBZ9+gBY1
         PFleujqMd80xs75Em8iGPpOaAaNdEVJpTcBkivB0tDVDQtaOhys7Sg3/fBk/W+eUTYsJ
         PuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMkZhvfslvfP5puYdns1dXhdD1lHJ50WjGkCa6+yNqM=;
        fh=S21/Y0+PBneLWqLMucCA2hsEvMQmo8FbCxOAIgmVYeY=;
        b=PHy1fo+8aM2uaNlDS0AlY0YPTiGgpchXxndIYcaJpZSlIuPxKODvM7Azrmw5/ZmLsv
         5/F2KCh/H9WcqB3ICKQ+Z5F4EzOIXUUVZCW65Bm6sBs5QavWvmCrawAgCmp//NqHEZX/
         ZWx3z0OxJiOa1viGZ22/18SxBU4nlC3nScd3SVQrkmhP8r/zdBw9AAR9hVDRYAEwboST
         0wzV2b8PA/xAdx30YybBVm1wwvp3NhCp41LrIvsrj9OUFYGATwH8r3qCyybbf5H1nyYg
         vJAS7rJgVRv4JidIWxUwnG0RLGImjdJvt4AT/ROJK8/nZhvFltkhp00RcgGNwXHYlK4w
         nmbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771772002; x=1772376802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMkZhvfslvfP5puYdns1dXhdD1lHJ50WjGkCa6+yNqM=;
        b=etpdxw0zeD3zl5QDUk3puja7EZABpXN9hJRyt2YXH4LVs1il2QfYP10inYxM8c/lcY
         OPF2bv+D2H63cA9mET44hWM3MMwR83wnPt/S+5H2jCtc1tmOv52TmbXZ9jH3N8Fw+n2J
         2XQquc0PYz+fLtN3CFxFxHon7zUSqiQiCBfR2oaylLz3q98nuOsbnuHZQSra4FfN20pS
         GeNusyeKjl1JAcm1RLrHEK4fc35ztM1my9Q/tKi5pFAAokwu5GA9Z+9weQUzUd/60xen
         KmUYpqO+j9VCcfx0aVXP0YMQrkpGvDkVMRERnOgH06Yz8FxBdj7thUV+YZ6+wauMaL7M
         t+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771772002; x=1772376802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMkZhvfslvfP5puYdns1dXhdD1lHJ50WjGkCa6+yNqM=;
        b=aNJ2ZXBpl2040p+KtakSAE7PuDASnDdMc9Entmev4oqptVEtj5Ai/VQ0hNbeAlUSm2
         1X+kohIYYbJyf0V25IVHbFCy4czPMA6T/6Ipyd7GmK157NDJxsbMbNmbHGCGelJaBytk
         dSpfsZz58jA+eCZmYlJXvUBMBaMY7FGT29EId+6wF84nUMYDObbrB/3Y7AwzUTUGY6pj
         IGlNZWxQLZ5lx4zTKHARsFLa/C6xa+yk0GK95BuiCCu7sDXeohWEsTXpUG/U6ZWj2QYq
         0e3hkQonJCs+i8/UV4HHzYFNbb2u8CJb42sg3FPNVKQiyWfOoBifD2x1R661m/L5x+e5
         O75w==
X-Forwarded-Encrypted: i=1; AJvYcCXQMGdOCE4eF9vFpUPonjVgXrWgEq/Y/zJ9eC/q/lhTtCLDxf9918f2ViDS3mq1NJqzqRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLQdmD8vF2wccNMzO1fL1Wsn1v2r9rQhar1ade43IgB8PeGyD
	8oChydQa04MIxbOsIHxcMKwlErtuWfqKZMTrASh11aMn3VIK9+cgdLS3xwtnmSmkxuA/3XSnSlx
	j0w+W5abOE2vghItN/7Hq+cQnAirJNSaFaRi8
X-Gm-Gg: AZuq6aJRrEHBh/C+sMdPKtKgEgsTlctxEyGs65XCEwx9U/fb0RIRF3r/VX8jbG/ZMec
	o5rFscvPNdjv7CuD9ITlpbz5OfQ0KQegiiKR4PB06+Wk6DugUxJFK6lEcb8pwv4nO1tB7VXmKEW
	IQ3V9hEeQopMPDJfrXCOHWK0hNDD4NU6e0Vz7fJO1dxqKAb49zQ+LkW0DnQxCpK6j2sfzZDX6Hb
	f3Di7Rz5uS5OWHocvxVbgKdtzD2q+E58B5sqPIefyIA4g8N1tqUjSbgI4u3YeK8EsK6tEgpNhX7
	fAUkV0pgySQG3wXR8XsOoGjgxFeXFteNwNBlDQ+rlXbcgD6dTVzY4dDUhkAhIxAoSbG7Nj5usq/
	i0u7FN2t9Fmck16ewMjsZG97B7w==
X-Received: by 2002:a17:902:ccc4:b0:2a7:3db0:6e1d with SMTP id
 d9443c01a7336-2ad743fb670mr54915485ad.9.1771772001690; Sun, 22 Feb 2026
 06:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5EDD26EE-51B6-4BE2-A7C7-E1E0991537E4@gmail.com>
 <20260221140049.579922-1-shreyanshpaliwalcmsmn@gmail.com> <xmqqldgmrom9.fsf@gitster.g>
In-Reply-To: <xmqqldgmrom9.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 22 Feb 2026 09:53:10 -0500
X-Gm-Features: AaiRm50uSOlAgG3JgF9PW2FJBnA1VsBZ_82G-NrZ7MrqDnXjsgGVPTob_Tobt-g
Message-ID: <CALnO6CALy48cmpqSp7TMjkg0ZuuMwhw_hsvLU09yxp5MSEi=Wg@mail.gmail.com>
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
To: Junio C Hamano <gitster@pobox.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 12:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
> >> Yeah, that was a bit confusing for me until I got used to it. Maybe
> >> saying =E2=80=9C[default: UTF-8]=E2=80=9D would be a small and definit=
e improvement?
>
> The current message can be mistaken, if the reader does not READ, if
> it is asking a yes/no question, but with the "default" label, you
> cannot imagine answering "yes", which is clearly not one of the
> things in the same class as "UTF-8" that is given as the default,
> which also serves as an example.
>
> This is indeed a clever hack (not hack on computer code but hack on
> the mind of human who is reading the message).

Yep. I've seen it somewhere before; I thought it was from Portage's
emerge in "ask" mode, but checking that doesn't seem to be the case.

--=20
D. Ben Knoble
