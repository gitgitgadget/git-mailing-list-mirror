Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93531435EE7
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117443; cv=pass; b=or0MHi2RVOssy5zcC01FLDyCySdcJEAaYaV51xv/vqxtKSQ1SPA34co4i/MTmCSf1Z8L//W31Nie2Swzty+OHO2Jwavou1Xm3LS/DmR9A1uKjcHmXmLiT0W4j26nTw7MvSFrtNjXBvVwcyJtwEHLiovRw5xDuuhLadGZZQ3WNgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117443; c=relaxed/simple;
	bh=7NxT3hUoGGv3Qb+xFoAwsG8lyEUkBvFCPlk7aVZBOa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP9hBIPGDo11B8OoWF7id/eYecbyEkqFzLjkLGqvBRw5jJECv2B8D+kr7MCXBwkoZyPKSYL+VMBKHuUqqHCCr9z3FdktY8UaxTiHze6jEQ9yVdtTCjiCNe5NIEqCZUoP+R4eVLJyBRKkSdu5EdtfecEPXzmRHHNWEwgA+VLvPPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kR8wVJwW; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR8wVJwW"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4a4c6081f9fso1077847b6e.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786117441; cv=none;
        d=google.com; s=arc-20260327;
        b=py8e4uWwe1Ffi37GKhW8Mc08sWl25E9seki5Vk0CdvVaCImd2tt2QEvyja07GAV3W1
         hPU2LnnZQuhFGQNNN4mV87UrMtsYA4hOxffR5b2chNfYTDSPAGU+VXLit0miDiXO7TOi
         cUTLuji/yrcVWIKmC7k46RmyaTdjJYJJ0Y7Tidx1hJLWsG9kmUryaVaBLBh0N522waM8
         uoi/z5dhZd6z8RWLM1gwp6XAgilqVpKEg5X6goxbRAwlTD+r+DODI26c/PfxeGHI4VdC
         j91+BSC6/sEF2r3Pppb9kzlmTJ4MketjFOU3dkYwGWsLFILyHJH8HcfJkGpeKELbP58s
         VWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e3D7Wt4FOPZbAJqDWSfMEVJnjFN7unIt5aOfBcx9pbo=;
        fh=/lL00N6kXIWIOj/3B8UdQZrVaAIPvK0J/tbnM8hNW2M=;
        b=agXM0HUhKxZ1jIL59BoW8Ts0oABYqssrd2vS3fu9AlLjX2PGZafyDQ3swBN6Qt3hfX
         ClLMe6rqqMlp96Zu3J1awHngDUnyUHiFY44bJHZJD62x64EN1IkMBQDVTegwBOMUze+S
         I0MKBglWw4YqPMZdtx9zinQPLSJpPcetOti48Fw4FUA/mJHcz1u4Sf2sHp1D4oYwCjOR
         BgPDZ5sm+w/oNmRjg7gshWrd1NytOeQBu/XT3zxVDHvjxVR08yLf6svmkEpC10Z+Av42
         ofX3/l2Hhsnu/q4D6WxWatzXrNgh9Y0R2wj2qi4ju+XNbn7r9wksuQzxPmb7fDawIJT2
         Crgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117441; x=1786722241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e3D7Wt4FOPZbAJqDWSfMEVJnjFN7unIt5aOfBcx9pbo=;
        b=kR8wVJwWyMDFg6xECc1Tf16bg6MQehqooxqcxRhvNRF9/UWuLW6q24Wxui/D7iy8qy
         VqhsILnibo+D0E5VYU7tds1NvkHrrRIwCVjWAmOF3maLBhtfhaQ27FgzQhkcH2OrKDaL
         Z97f0cj6fiMakX+dSzkENmWrTrrqA3mqrLuQEV4eb+c7S3Uo/i/PzewOgATsMTsQRRbj
         ysZT1th6BiOGJdibjjh/gzt0+8ZcN67KpGsEOdUZErge0z/LYt0/4RgDIwny0IHKmFFm
         9L8shDe23ibWmqppgTbfqud0IsENkxgNLzllOtlN9oIWLW60TOA408nC/C/9DLweiqcj
         83iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117441; x=1786722241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e3D7Wt4FOPZbAJqDWSfMEVJnjFN7unIt5aOfBcx9pbo=;
        b=JhFkIt/5rFOT8s3sKYCfIc4Lv40Il+xMUHbXIv4JXpZ3ef53RVlQDdXpQKUIUim5kb
         9KJTB4wUlHwwR72w2KMXfsyoeDOQzZsOYfgl2Lid+jNGbs2u2pI6DtUq3yDeCCTIDuft
         wD+WkNxG4WNXV4GOixHCEiLnkow4SIiYZYL5uAi1YtI+ZGevgZKYkfhnKRXS/WJryUek
         90E8NyVHLZeYLHHPhS8WrmGzqvxFtQslfrr+UH5EBZRORlPBBDn53YzF0eeUx7DVGn90
         bHTovP+my8q6B8+JX3F443pAI+mcqUvGArhQyQfTjE7GiZ/KnXNUYh3n8KiXzSAGRaVv
         dHTg==
X-Forwarded-Encrypted: i=1; AHgh+Rplllr6H/GPyE7fTKafEsH5schKgd5uLPJyv03zlkDQzFRFiadO7lTjc5a5PDvBXtCYSXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzKcRON2K3xkRgtaf2Jfr3vClOHDe1y8GyNWMrvBppedkqmul
	QxYRADkzv1aq013YsvnHVyfZ87ze/CQ4FKQKjyvvVm8kiW35umThAcAx6e0jeg4/nkw8wzzH4T+
	l9+ivJbQacMSgA3ofa4cQKNOjoIzFqLY=
X-Gm-Gg: AR+sD12E1M5xYAkxksCVxRlbn5QX+8WHGtSr3EecSwQTZXthWPvAySU+AKcqtLL8h5q
	UcEVZJZ1fTlMEu5QxtbNV8HeZtY0Z04eVAwPfC/VjFc0gzTXUGvV6So7sOVArUKYJwX7vEyu0xX
	/Cfwofcz+ZWVpS/c8246cbG4FRar8Tk4Gb81r082g/qAAm0tajaFGyknZ0/EjqZWuqHLxnayM/6
	x2WgwaeUniaDkzA36xzCl0OvtKE2JRsi04CRlc0E90eYHK+QMbIAB23MSQX/4+seAyZNTKrSJbp
	V8oBEY2zGych9OX9sVUIl6Kgo93JftdqnLe4oKQEjqHcadM7ILLgSbR+j8vQBSKUmY126YjWXG7
	W2z68zMmYxvRiJHVaMhzZfaK01kD8bx49AYCBhG8WdFDSYyfEnMEiDXM2BXa6mf4=
X-Received: by 2002:a05:6808:4dcb:b0:4b1:a33a:3886 with SMTP id
 5614622812f47-4b1a33a4132mr1903167b6e.20.1786117441264; Fri, 07 Aug 2026
 08:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <a1c8e89ef9f1d0fb5cb10ec9687633df8792ec7b.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BFqghtx4p_Nqx+AWpU7SVn3mXOZGDQ0yoN-ZYQgXmZC=g@mail.gmail.com> <CAL71e4MULMmbMyrE2iKgNXD36vpjnxCYXTcNw75ibu_nwxqAPQ@mail.gmail.com>
In-Reply-To: <CAL71e4MULMmbMyrE2iKgNXD36vpjnxCYXTcNw75ibu_nwxqAPQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 08:43:49 -0700
X-Gm-Features: AUfX_mzGo-3-UgkbaiW5zGx07s0_YW-AZY9nTJu78z-q3E9y49c8ZBMBW3KuNYY
Message-ID: <CABPp-BE+QBBYj=oaRDcQj8bFrDX6Z_JVK39ciAk4TwMPb0zHOQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] commit-reach: introduce struct paint_state with
 per-side counters
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 4:48=E2=80=AFAM Kristofer Karlsson <krka@spotify.com=
> wrote:
>
> On Fri, 7 Aug 2026 at 05:02, Elijah Newren <newren@gmail.com> wrote:
> >
> > became -> become
>
> Good catch, will fix.
>
> > So: pop, clear, check the counters, and _then_ decrement the counters.
> > This means the zero-counter-check still include the just-popped
> > commit.  If the decrement were before the check, we'd actually just
> > barely miss the merge-base most the time, so this order is important.
>
> Yes, I should perhaps add a code comment for this to ensure it
> does not get corrupted in the future. Something like this:
>
>     /* must check exit conditions before decrementing counters
>        for the dequeued commit -- the counters may otherwise be
>        be temporarily zero until the commit has been processed
>        and its parent nodes have been enqueued.
>      */
>
> Or is it overkill?

My comment was meant more as a "review out loud; show how I'm thinking
about the patch as I read it" kind of comment rather than as a note of
something worth changing in the patch.  The order _is_ important here,
so the idea of adding a comment to reinforce it seems quite reasonable
to consider (I thought about changing my comment to ask for one when
reviewing), but I'm on the fence about whether it's important enough
or overkill.  I'm okay with the patch either way.

Although, if you do add one, as per the CodingGuidelines:

/*
 * Multi-line comments include their delimiters
 * on separate lines from the text.
 */

:-)
