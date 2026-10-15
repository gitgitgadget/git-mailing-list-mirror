Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0B49EC68
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061224; cv=pass; b=KYdZKZHiaQ65LTmGB54RuKYK2yU4hmXmTzDyirzRU7T5u720QJitLbiQUwPV0dI0uotiWuzvKJhpzXG2JW7TxS+980PzEJwW5VINDsAfU7Om081tvwi4OxtHc7qfFn40yIfT9AqNW2iGlvdvYXr+Hg0LJwV+tOE3btoKvH6yYdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061224; c=relaxed/simple;
	bh=2nXlZfDPKCCmfeofHNiL9PenXXw45xdLKoLiQpVVbM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYNEax4qlBsP7dOuLgDWElnUKZSFQaENHbGQwUT6IJyXwDaAUOUAPJArPWY2pdbZoMg/rRDbQN3DIUWai5XBNHA7rR4yQLaNokeXvYWTiJc7UzDCLtxe7rsvPCO6+KdAlhkn9C4uNgpw023Zfmz02IEphXNiyMT8ANyMv5X/D7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkNc1e1n; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkNc1e1n"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-821b5c73292so3657452a34.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 03:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792061222; cv=none;
        d=google.com; s=arc-20260327;
        b=Ni6hy6QDcJ3BY8siMHzy0UfYuoObxD/7fSrFcms7hl74TS7ikFFL+Zhv6nbbFUOkBA
         K3jkVf1AxD3vjWRFphf4R8FlQJidg/ytgtS7qeAk3T2uMFf/pITKlGrKYEOouzVozVHf
         Bpz+4ML2nLAivlfC/HHKC7a/WikJXPOABKR5SW3b3lg+KRgbdkM28roUWAHknFdNGkAp
         qa3UTykCcWu4T9O4uuTi0lshFa2nGUND3Gqrng/3XosLgAYNJ8gAHNJxHYZTfydzAw2X
         alGPuTuyiitkC4TAXR47lT3afSIxKDFtOsL6/swin0sOdHplZh/PbBan377o5aRrWmeF
         P3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2nXlZfDPKCCmfeofHNiL9PenXXw45xdLKoLiQpVVbM0=;
        fh=aUFmfdB/kkXm1K6rwZ9Cis4mVDbhBryRqq8sxCB565w=;
        b=JSWUbz+vfUmAd0ijhHFGCI88Tm7Bxl6TQOtSkzGq7HauL+JyscABbRHZf+vBUrbnoP
         lBdY1T93uw3jAj0hJoIru6TXhtUx3sNJv8qdlYGS77LS4nzXPCLn6xeVg+KKD0B+/E0+
         7z2lt/LAOxJd6+dS0cd3M9LlLUiuFlA68QuHRJr9HGmPNqDoUcwGqiINGnA0dv6eVvfv
         l5OO/L35Il02nGpMpdxrANjLLaeXur1Fk5Dy0bgeRDN1Wa66kF3pgm6YQ7JTC3tq0HZI
         Uvw+Ip/X+bw+g49pz1t13osMGJdy6Ng1SvcTFen8diotI9x9BpibxK54jq/TmkXmsBMt
         Gcfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061222; x=1792666022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2nXlZfDPKCCmfeofHNiL9PenXXw45xdLKoLiQpVVbM0=;
        b=VkNc1e1nxVB+wPnHG6Y7vKR1linj4blax0w621ltM5J5sEWhwyJlDjQvknxqeYK1ES
         RahJd5F1Yo8sZnWCOAmoWbppa/R29XCW8fG0fxTWf3h+udKENxqwQvZUKKl/wTnmxMuc
         3Rsn+GSn+nQ849VgHECWjEWUJiOy40dZ8gFcprW21G4jWGp/FnOObRE2gvUxuBp6ONDt
         lpVxZX7//+KwQ0WJsjjK4wo4Y98QejeIYg+vlQns5cgc2lcupM4/I/WCMsyqLlTeQsZ7
         6w0rTDlZoEUf2CedKuwMHw80cX3cX7TL0Y+6nAyNAxMD32UNgZgpPAMQ/Vhfp1P0oBXZ
         O7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061222; x=1792666022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nXlZfDPKCCmfeofHNiL9PenXXw45xdLKoLiQpVVbM0=;
        b=orwey0g4hMNjvJdkt9t5QQqVm58/BGGYGegUPjSYZ9Ejmu0Ts5SAazH13W2nUFKfHQ
         zqcwTq7dtAjIZXjLtYu5YOsSlo/sfp6Oa+bxEm2uh8vVnLC8QQ4kg3s3idckJF0Pd9AQ
         q4p3j8Rex8JNftU3iwHwpLG7VsC2b2h34wBVDCizwL95GExf6OC+3HEyPAnwQAjIzt9Q
         DsqOlT/24dX212D2msMpx/9QexZQ1jX1xAebo64Psjdrh1foVbXVZMnDiRRNxXpUQTc7
         o6znAYB0gDXZnrKTe6Iy/A/YgNZ+fp/tDwrHCQ99mtLEZAlPlu/lSKz/PRCW1E3sBYP0
         fgKA==
X-Forwarded-Encrypted: i=1; AKwUvBx2Em30a5S4f0nGQ1RB+x5TLKya1Dmvma+D43uqNWvezNInpKigJORsruTbvBznFK1yNIQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfF4kg8d8032LQgCz+hRQf/VmCquHXli0i5oxtUcsHTieiipDj
	fcDEkdNF58zUqZVSYg27WTOH407NlLdEYdvZDrm829IFf5X+BJe8IkRJB6AxbihhX4A/yoaVAwb
	dLGdcJCoDuQNUVR8NZqqwNyOd2PaKcjg=
X-Gm-Gg: AYBFou2fw8s1yF6OrTteF83tmxibp069kN33G7UTi0P2Otfbxhu4i5By9lJkovrD1C4
	zJfAu/xl+dU9aM+w9eeXQqr0dD25QPVMQbiP1jaBwzGSwlmIp17x20wzpe2GfcTA7Crfu6SnuPH
	XXxnL6XRZDtGdB8mfAfABLb3L1g2hFZsoYl/UeHqUrr0umNpOmBybWjJOEIjdf4PQ8AJwBjmYuG
	EkTR/phegA1q7Hw4wdOqtM0+l79q6diijlwKKiN7dixOHkSztEpUXm0Tm6FJcNkdO/HRFwvUX+r
	+dAj4UiA9QMCuHzhRrjzQoRwUxI8S7OdFC9ccOX5vQqi5DkCus8FxErVDxY=
X-Received: by 2002:a05:6830:44ac:b0:824:df9:971 with SMTP id
 46e09a7af769-8309506c2a3mr19236435a34.10.1792061222552; Thu, 15 Oct 2026
 03:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
 <xmqq5wz4rthd.fsf@gitster.g> <CAHwyqnVX+FBbihdXA2jxDoweKv6wnqr_rtb110uqLrzNVRAZfw@mail.gmail.com>
In-Reply-To: <CAHwyqnVX+FBbihdXA2jxDoweKv6wnqr_rtb110uqLrzNVRAZfw@mail.gmail.com>
From: jyotish kumar <jyotishkumar725015@gmail.com>
Date: Thu, 15 Oct 2026 16:16:50 +0530
X-Gm-Features: AclHuK-gM8w3uQygDSgEKhpwjsn_lIBEJbVDTBYZx3HUOywibPQb_ACYVDNavkc
Message-ID: <CAGjZMyT=RPJSbJoq=RbdBXNiK1Tn4p8VnyeyzkZ46F=p43i6Pw@mail.gmail.com>
Subject: Re: [RFC] pull: custom fetch refspecs and fork-point lookup
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald, Junio,

Thanks for the feedback.

This is an issue I came across while investigating
`get_tracking_branch()` in `builtin/pull.c`. I haven't started working
on a patch yet, and I'm not aware of anyone currently addressing this
issue.

Junio, thanks for pointing out the potentially related discussion. If
you happen to recall any additional details that could help locate it,
that would be helpful.

I will look into the existing discussions and code further before
proceeding with a fix.

Thanks!

On Thu, Oct 15, 2026 at 12:47=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> Yes, seems like a hardcoding bug.
>
> Is this for an in-flight topic that Jyotish is working on, or
> something already in master?
>
>
> Harald
