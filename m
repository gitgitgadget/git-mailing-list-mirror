Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76F1E5B63
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758310619; cv=none; b=E4Je4SThxO6ZzG8Zyx9un7aotzKIxBirUKppgIeNZNJs5L4uKtu2BQD5M+sexySUHT8HSh5TbDnH1HJW2e6bzF2blM4PZwNaUjIkLnJ60AxuYoJf1MiWUG0jBiVGAd3bLfiwXD+ZoMU0ea06GuXjKjOZpRkw2d08OGnJ2Gi6sG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758310619; c=relaxed/simple;
	bh=a9KhTutRaq+bTKxzhaZgCWNPJSHSwlk3baQ8qeDobZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrZ7g6S9/nKfPVLhGhlADQ47CbrXZ3m73Uk1l4+yXY+LYxC59+tuw8eNYTpqyVH8wp4lkMCYKXDZFi0Z71b8NF0VnSabdQ2p8BZrpvfizw1VEKKeahYrcZ7CbdFOiJbdtAv4tXTCD9JFpiCU6fI3XKaU5VDljpnEjq6z5lW0caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRFc+chE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRFc+chE"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33730e1cda7so21164781fa.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 12:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758310616; x=1758915416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/26JAO5XquJvPi9azKX8HAOG6lCs5p99yqhn2dRidw=;
        b=CRFc+chE+YDeoPh3KwHa00l5WUP7owsV4hNDvtxN3rdmu7NnQWfz2xeh1npcPQvwLt
         XUBjh9gFbO56X4W3f40+9RzN3sVs4i/WOZLlVqmFW8ekNXbgvKm2hdDeXjCd+gA1t7bx
         QBHmWvEwimrwXyp2Xm1fBF5HJqvMnlI2oQTQpnEw8swRQm6DwTM+djp7p1yLP2A4sqxK
         xpUECm9BgNsngtmAWM1TyO1u4/PkjVRlMraEI8yol3J+6+/0MjI/wJPtMF2DRNHksdp4
         +Nm49HsugTLsvoPtP+szRFp9WLTLHpacX0ENGxY7bUFfX55bxNlK9UGiP2MXXgPgxnzu
         JGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758310616; x=1758915416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/26JAO5XquJvPi9azKX8HAOG6lCs5p99yqhn2dRidw=;
        b=oCDc3BTppI4nk0USN5MlEz1WRSFRRk7mxMv5iGNT3k/Fj65+ZkLI+MXcL+4su1kbQM
         qH2HEF6bEAmSxrP1E029fd2CsOje5M3VW+4XBP7uI7MfBZPckpPGWtvmsqOFch41Qcdp
         f2G43kXVuG13QjV3C0pGh5h9C4t0FrlA2rsy8RVGMD2a+5IF3ysK/vNOMPL6VSAek5hQ
         NMtiKriCY2z2ApDeWVGzeMSyG6WEP+KTAJDUUkbODN91E9KpVklDSF9UmRLitxrpS2KB
         fAigcb99ezbJwBf6f7GU8SSbo7fcp6NfYufNTC5RzuQL4WxJhganjpAUq1mJWigw0u/Z
         vtBw==
X-Forwarded-Encrypted: i=1; AJvYcCUvHjpL9kqRI0pQBCe8OghfwmNjvYzDFicW/4hINl+gKimO8WfgEv/+jbOJwjyUH+kBPFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqzjpzuPEkI3HAYVf5oNX10vTwGJi+9RSi6BaUIg3Z7Urx1BMj
	vIvVhnJ4gQQvn4vPWIFVYneK0x7OeF1Zu9ATF8+iKLoiHEpVeOQC7d98pEg4kbsTsJ2a0PtGZqv
	nxj+UHsWhAt45YSQU0aDycaknKIpTL8VgrpKc
X-Gm-Gg: ASbGncvR0PBZr4ZTVYeqPb9NYh8liTwuN2V2E4E9yVUHGMbEICn6os72Dxyi6M1wEgf
	OVEKcp1uSQpMztKPTx0EjlBLpUCpXSfmUN4+HA1DfJP0GPxg3UTkw5YAzjIzoVOyaYTI7jWfaqh
	bDDDCMbKRWg95k8IR1jfopXQn5IacHU0TTBWQSIyrOSMynxJ+9PE9r2smO1RH6ydqUR3hYGPRV6
	9gDLPXv
X-Google-Smtp-Source: AGHT+IGx060Q2L4C/UFUzw7khrWXfotFQEkh5wrcE+Dp0XekYCXiq8IJCwAq33EEzqUsIb+lr5v/A5pyxEE7ud8Wa/M=
X-Received: by 2002:a05:651c:4412:20b0:351:786c:e50b with SMTP id
 38308e7fff4ca-36418be5c4fmr17102661fa.25.1758310615691; Fri, 19 Sep 2025
 12:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <5f77f1bd5d986dc1f8d123919af24dd219e323e8.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cQqKCbGpfp=ppmjKEOe+sDRu6BocDfenzqvQJHSMiKDHQ@mail.gmail.com> <xmqqa52tgne2.fsf@gitster.g>
In-Reply-To: <xmqqa52tgne2.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 13:36:43 -0600
X-Gm-Features: AS18NWC724RRfh8ylWlBj-8ErJdP8sZZzgYYQhv1MtxHeCPNZcXAY7Hko_sdaTE
Message-ID: <CAH=ZcbDn0tEPu-xuY4uOMk1uajT_Wma=9G5mQ3PBsC-mQm1EqQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] cleanup: rename variables that collide with Rust
 primitive type names
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:32=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Isn't the true cause of the trouble the (I might say "misguided")
> desire to use "u16" as a type in C code?  As long as we all agree
> that the data that can be passed across the ffi barrier should be of
> the types of known size, and let C side use uint(8|16|32|64)_t and
> Rust side use u(8|16|32|64) consistently, we do not need to have
> this "cleanup", do we?

It appears that I am the only one in favor of using Rust type names in
C. Going forward I'll use [ui]int(8|16|32|64)_t types going forward.
I'll drop this commit.
