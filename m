Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501628;
	b=tOBGxT5sh8CRB1MLgA2zT8n6Q7SqDO4+F1Q4DWfU2P+90xjiRPeDJZaiMMRZWQ56Swv+
	 9ivsN8NSaiUwJNYxSwhIm5nMcTH6hYIFSaxQmcpqnMtVBxSZQakygEiO3I3zkdfoRHM2b
	 bKL3/wz19ZSBihBPxKBE22YaDjgdtXlLvgiIVhGhrkiMxo9irooYCbDJJ3Os+QM5WGOvZ
	 Ue7JuYKFfDBPwalFuTC03U/dmhX8Ix5uPhNDRpVdf5DyEjp4ET/hHN5MrEeIPLzXJABJs
	 w+/FQEQIhMIl4cQZ7r81PYeEYvWkXbW3NFru+I5OhYrj2CPJkXJ2VxT3oQvzxhLhXhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8xadr04benaJoqKj5Lo8vNOfw3G6Pxm6Zq6eqc1dq3Q=;
	b=vO6+04qTqEKTmt+HUg3vpb1w6z8PQm12FEcGF2nizdocTstg+SaPW3kGHNiwcnVLINhs
	 snTq4q/dxELJ/S1Z8WTVi5l1hkIIhIB2+fMeWXcuk2nWe05PcX5oyOfi9auiJ/45QLfq6
	 UG9L29SRrV+3X9lRaP459WhgGwn55r1FS1FUsdBKQHYAfCAUd+KwaULevPwP1vJ6WRxTB
	 0D21FgcKUkzjA+3L2ygpfoDax0TrdN6mhbQOzXNhq4rqqRtpbcMiyb/Ex0uV+eGqpuW2G
	 I//mslb7juuvhVNlxF+H/rqDLmyDMdA60ldHsqAehIrZuxB/ey2xuFPtr8uskeFEf9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="CswIQ4v/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA675606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA675606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CswIQ4v/
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2db80fcdf8bso18665255ad.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792501627; cv=none;
        d=google.com; s=arc-20260327;
        b=XqIwwpoDZtkr/fLGGBBjf7pWMewlLnvFvhGd9pmge35bjB5dZAk+3t5Vo+AcXRaqev
         qTrEzb2hGGma29oUr5VXxA+ZQFn0jqu7BfBlnAdbqj3Jsc+qo5PnXXMGyvtgN1DE/SL6
         KoIPly841qf8RAK5BbS77r0PuFGNvDJAIVTzNLmTIq8123ux1DE9oX6tv7J8Lxg0t2Bn
         2x2r5FG6RzrlFHlHKn2URxDk+ODbzr0piBIaO/rLE1WR9nC7e/APFQLSLRh6G9sLYDza
         Es8Hux6ijTA+QE3j/EUBZzcTad8lHaIg7m9tjcYFzEHJAzCBsD7+SFz4h4q6UZkSrJcQ
         5oJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8xadr04benaJoqKj5Lo8vNOfw3G6Pxm6Zq6eqc1dq3Q=;
        fh=C8x1jbBNU+DKOqoqrXxOAn87PXmNIVITM0I9/YsGSr4=;
        b=DtFSx4xFL2Gu76Z+vev3JTfbiBvzZ05CEn6gPAvmKd5UEVhfrc2LRl5OCQ0GqVlv7F
         Kf5auTAiM766e9WOlDxnyB2IBoYwYYAuy7TfWGku4Dn83x2t/I//mva43EAkcG/iFl3h
         QR28jeRXHuCRLQ1MKkrLlSpP2YWceptpL7/rKQRQGr3eyt697f/rHjmrgvTqMKHaALQ+
         3+Sze3zzbDxNpKy+4AwVva2nQ5xf4wYEPAvAOf8AjiRB1LA103yEejnWXOF2fHntMCFo
         zzMI59k07XjgfMXoq74tdFUCqg2iL/MRU2niMaFXj5wBG/SguNeyvkb7klNGxxT6s6Th
         9TeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501627; x=1793106427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xadr04benaJoqKj5Lo8vNOfw3G6Pxm6Zq6eqc1dq3Q=;
        b=CswIQ4v/Jrt2JBkIAaiO/te+LySq12pd5ZekZzhFxS+E0p75ypcjn3cLxudhKKjFUO
         IDEvGGnOCJm+oVL6gfITSKlOzTNGCkQLQ6t9jb5un8cbCHOpIZ0nSQLg/mpuErXah0f1
         FD1URN/dVgibYcHH06iVP786YAViMtMEklaIWohTa8sjSty70Jv94B37fLKiSSX7LWWp
         fXgi9jijZ6fRS7r+aNvQmYAa5QXFRCFaQrxF6+spbc4mJ9dfVNzZcaqGSQ2Hwoodhcrx
         K4JHchG1co71pUHu+BIRp/Azht3/lGTKCPPewXYAQ/nrTTPFwDj8g2FtjNNEI/cfXZ6x
         bpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501627; x=1793106427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xadr04benaJoqKj5Lo8vNOfw3G6Pxm6Zq6eqc1dq3Q=;
        b=1XN7G7xyFyX9Qg+i5kboab43DbJ4yptReAfdWGNaxeBaJ7PwiL0qlasqhg6WTMrVa/
         Pm4YkUE8qgWFrB6Ggd1ODVZhUbqOgz7mUO62GE6d/GoiP94rE/0WCoH1kTt60CN9TKp1
         vG/IGZ07fSVTxDqeBV6cXCoWh3tJfw38m9BFBr6IDM16r6uWJtqyO/6klAcMtAWoAYXm
         0Nv/UihGEq+Iy3GGGnMQ+DyZ4FQ4lOlzrxag6KD3tf5Fm9HTX6ZWeibfmRiXDSLpIr95
         xM3TAJ3bsppyB2YR7b2xgTbURcu2nDvp2DJKpDEfcdLRBwKKCe03K81qUYsgxGbzMyfu
         OCEQ==
X-Gm-Message-State: AFq9FYKWE4aEIDXdTpOXQZ0FJJhml5Jg6JnNlkO32Q+P/iSqBVPFAJVh
	vYmHZF/aEQhdEnYnPUzAjJFp7IVeBBr/At7n3PPViwkfDACBbOuUuDgun9NGw1R8CigBQpjVH7X
	tnlpE3KIomHLGmD09OitZGUUxMwjsYlYzOTvi
X-Gm-Gg: AYBFou3C54jZz9T/4CuX5bS6O7mYeHL7uQZ+Cls/e2JCj4jWtA3YBRHSK9mweO00vZ6
	SNmBF61rtxsqiKVuhMe4apRoPbzqWxbiuCDVNLDUtLapLqUdVRhUeyGyCxV30RHrUu3PfBobz6y
	x+fcDIewfGCMjMUUKQU87mpMrB1fQUrgZidT5UY9B6CT9C6Z3evoXK+3yWYmrMAPFDy3G4ywfwr
	JQXbq9Yqb1cII0RVc/jl2mxlQbfcJUP6PPUuCgn4Tq6NJGr6u1QY4BLHkxFKkLoxcVJ2waaBoR+
	+nwzzto3AB60L1IXQU+hM8sz8N40+tf1I7+XeRqY4vwHGnr5bcV1C2kvPBroR+cSM9jf6x6FMue
	OYCNr8xqSZWrV9sIXFjxjedPfSN+cJ2VPiMJGNlzEZGAsTKC/3QQ41H/eVCf828WAbwiYLwcrLg
	IpqYBhngBq3rvnUzFf46KDh8WMHlpXdA==
X-Received: by 2002:a17:902:f683:b0:2df:3b0c:a6a5 with SMTP id
 d9443c01a7336-2e9a68347c1mr91836945ad.9.1792501626848; Tue, 20 Oct 2026
 06:07:06 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
In-Reply-To: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 20 Oct 2026 09:06:54 -0400
X-Gm-Features: AclHuK_BDxsd3CjICkavEPpzcGoHmWoYFA8GpdrFoRLNqIMsMxrUkNz6jI_PBLA
Message-ID: <CALnO6CCFfd3VcZkFGmc6kYHqEwsafa7UbOg-6cN0jEfsipQm5Q@mail.gmail.com>
Subject: Re: switch/checkout stops halfway when it fails to write tracking config
To: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:41=E2=80=AFPM =E4=BA=95=E4=B8=8A=E5=8F=B8 <inoue.=
tsukasa.4@gmail.com> wrote:
>
> 5. Root cause
> update_refs_for_switch() -> create_branch() -> setup_tracking() fails to =
write
> the config, and the code calls exit(1) in setup_tracking() (branch.c). At=
 that
> point the worktree and the branch have been changed, but HEAD has not. Th=
is
> exit was introduced in 27852b2c53 (branch: report errors in tracking bran=
ch
> setup, 2016-02-22).

I can see where create_branch() is called prior to setting up HEAD,
but I'm mildly confused about the index/wt updates prior to either! It
seems to me that should be one of the last steps, hm. Unfortunately,
I'm having a hard time finding the responsible code outside of the
"merge" case (which probably has a similar issue).

--=20
D. Ben Knoble
