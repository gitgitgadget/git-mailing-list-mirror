Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20C3E40F9
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425270; cv=pass; b=Z1gk11TAJANr6NS0pDFM6BlcRn9VS91k6xyu8mKcKpxSCVTh8f4/Ntt3WybPR0Rk7C/tMGJpNtcjha/YNz9Tyi76cdQ5LpLsGnW3yrsRH23sI9dlrSr/h+x86MgdNwiNrKe82pE3Eksswcppom7B1dID9OHgpYlwRG/S7jLJzM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425270; c=relaxed/simple;
	bh=R0sEs/q7TA8LxMcIBy+88u/iyd0j9b6c5pn0E612DFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XARNG8mTeKXq1UblrE0rbtWRscYIZC//tQPF9XkC3fcgLeLmHY75t4KEoZPiIv4iv++1YCbEo4urvrei/7xmZjvRstxC/ehYszIpdaQBhvHI+d4ZXeDYPHCFzFAavFh0OLVYQlwKVi0PhTrHm8DGMdNYy2jJeb0pUQOzPLc93g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMFKT6ni; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMFKT6ni"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so906055a91.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790425269; cv=none;
        d=google.com; s=arc-20260327;
        b=r599kyz70jPtTPXgylbn+Iaob77almX0U1DDzKOtsprQ5VZWQwcRrICA0eIg8OUQmk
         IVs9Y9eVZj53pQMQ8JyzeqAZYagq4TyNFHcrv75NOmdslPS8aTOCEOH0U3gIj7fPEjDE
         h6deftoksPW46CiXmY25+qMU/9PneBrn1Qg/E8OnEr6Vx1dF7RUfjkdVrogNvgCf3l+O
         sojyht8cy7MexqxIjmoowJTVngSXK5zRhQI62XfHZb83XJq19MYK1IsQELnSHwNnO5t4
         I0us6My4PMnvU/5yVIZ5f8wP7iZlAOBTvayM/Moz8XFsjWJrUArVAW8dpIAGZnu4z4lU
         9IOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R0sEs/q7TA8LxMcIBy+88u/iyd0j9b6c5pn0E612DFI=;
        fh=HocxaikbsIg0V+R4115ckTrQyh4ct+YYMH/x/0xjsIk=;
        b=l4IDuIhcY32FYpQEY9+8Wc8XmfEij4uOw3DI5711ZqeiJEnLNZ4fnE+etkf16P2asz
         4VLEg3wUyLqzQd+qjXviVnDSkXtDSjg0XJ2c7ExGMWhXopJ8vXM5q5AATlh2Kk+jF9Oi
         uvp8MBTBS5puPYYDzzdOnVAnS/u1jIU+i7wX0I2UZXmTfxUHaIQH1ERMpFzEaPxEZOji
         dctUge7QOU+FvNDIyUJLuPA2brGdMP6UKw0d1IsBDmqtZ9mi3qDF6hTmSy+wn6wOTmjN
         kyAVp98ZraaCyhKXvLLz6C3/trguV327tmjuCjpF0oWq/8t2UzL9/JYSu0Kyd/k6bzGU
         zNLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790425269; x=1791030069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R0sEs/q7TA8LxMcIBy+88u/iyd0j9b6c5pn0E612DFI=;
        b=pMFKT6niVRAaNc0rlkPQz96T5piN5ScqUckor8TFHdERdHfzrXpr9OGtJ8Fix+c8XC
         ucMD1xi4xE+Rv6t10/djlGSdnDIom0Hw2eLtEZdrMAIs2rVFVfCHhvUtktwbXEqK6TwK
         jVysMUyjRmpkJ2f+Jfkk82y7l7kVlH7kY41OOdh3eKVQJpcslY7K8K1xbN2N3/HysRPL
         IkpLdd0k3tA+m5uRFvjkhd+Iz009FUP5ZDUcMNrA72iEyzHHzuRHPmTyUBL6zzYqfTro
         NReqgY6UQrOHKDhJuvO2D8D3wxmj/rX/MSXVX5slwJQD+aoMEUc79ey/+y3AEqkuKTgO
         BRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790425269; x=1791030069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0sEs/q7TA8LxMcIBy+88u/iyd0j9b6c5pn0E612DFI=;
        b=qjlpY/d3NHP92i4Qp4jxTSbwYd4S8mGigWOvBbvZHDz7nbSYbBCdzGv/byf1qze5Bl
         SFVlM1yjJkbFVG+gRhFtyoHR0zZeKvolGCMsfwRWwQgdEeGm5tJvrvCK5/WQ2NfyTn2S
         ksKrfeCTGDByxTg8UNrg57f2ZrknH9apfJiqz4u/5QPoZYIhHlL82Egjybn0bBNsdpUR
         8lM35ijESlI4nsWnukAGrT6fcqaZJZrEeJehIKdxez0xfPBgqRCH5GyueZ8+ild/HVf/
         jqmZpPN3+Rkneaegibe/5oTjYXO0yDjKtk+ib5+iwt4pfCzYH1YshzNzczPCQZRh/VBj
         lRBg==
X-Gm-Message-State: AFq9FYLPoF2N5lma10NjkDq2I0lL0ojIvB5rhJzejipHj2J558NGfVgd
	Z3uJ06msDMD/1xmJ1VBA2T263ygFGQHly/yJc+hbk0lYvoGKI3dGb8XB/rmwnS+gyWLZ0Y/tBBy
	aDRJzvCStJfbw3htE+NROHLCsPYkoBH1at3aR
X-Gm-Gg: AYBFou2djrr5DyuwKa4aPUS7+D/DFpFU6Y80kzX6jat6BqQyevlSecibrNI79PMHPF6
	7B1VWIVAHZiz5IHEcDzKmbualzvYLV9SWAOpFO/UT7fXRKpu+VPNmFhprnikXwerQ8tAI6iVZCD
	74St99sFVuTbJxc1ssVhcKL+f0FnYVIy+o+2XotDelPUiw6FKXCurBe6FX99IXPgJxVGt2c3/Ew
	2c+ChvLvBQjv3odGbKAUEALeHx1a+yvAGse9g/KjJA5s187sn6ASMO8XU3UIsQS0icKvrdDDW3U
	M6Ma27WR4DD7jM/F8H4T3qliSFZSVaz7BlbZqXu5og1kTw5OHyDA7xxtRYvIpKPk0GuAeAUZHPM
	VzfmugW7Yqis7SG9at9Fb0da5a15VnRZdrK5xgXzXPfbNazg/mZA5Z5EcYDZYk7Jk5FBz/S5U2R
	qRkf/WABU=
X-Received: by 2002:a17:90a:bc9:b0:3a0:a515:c477 with SMTP id
 98e67ed59e1d1-3a0a515c8a1mr3762626a91.16.1790425268866; Sat, 26 Sep 2026
 05:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
In-Reply-To: <cover.1790425008.git.ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Sep 2026 08:20:58 -0400
X-Gm-Features: AclHuK9zgds-oTf8fL5G-F7HzHfmtqEu3tbLXzj36n0xuc-d1pziZEyeJ_Ob6V8
Message-ID: <CALnO6CBpV6TiQGKSxEcurwzZEE3rvqO0EryO=5orD8F3Ren8Kg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 8:17=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> Hi all,
>
> This small patch series fixes a bug reported by Eli Barzilay in the
> interaction between autostashing, staged index entries, and
> stash.index=3Dtrue.
>
> The first patch is an incidental cleanup, and the second re-arranges one
> line to make the change easier. The third and fourth add missing test
> coverage (which catch breakages from prior incorrect rounds of this
> series), while the last holds the interesting bits.
>
> Changes in v3:

Woops. Contrary to my usual practice of late, I sent this in reply to
v2 rather than v1. Oh well.
