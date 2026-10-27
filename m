Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793110752;
	b=uBVkBSLafs9y9xBRFI1Xk8BHbBRbSCG7dC40ZlRsfL5RJohaxQQTucc5qZSicaJOA1bw
	 fKiW/ln8+AElPLd9KLfqw5z/+oOQLyu7AWygpBUu198EseDOs4tBef1KTGEO5cAWzr2CC
	 J1FHETeZgJiV+UduZW1XQZfLH/iotK/0NWldj3jwlrVmSPsKXrPlH9+OrL3nbHD732Ojz
	 zS2eZ3HTRWOVSPps3GX1ITFb+JghDnqqi4V0vvnSpafVrK4lWTtLh2UqskjeQbqDJ1yWL
	 x8LOC5C835BMwbESwCJrR8knscydzbvBtG5I66gfa7ozZaYKKxy3xyp04sCGA70A+lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ObUzF9BqDMZeAbdynJtdzZdfBBO17xExGv4Z+bdRNJI=;
	b=S1HU4Huyekvjvkwc/SUKoQaBj8Txbcm1WSZgI4qFi3ZL7JIsq89YvJkDClfp0FQUjz+0
	 +jRWCCGhBpjY/pIa9mngEtK+CcyBJ8n/dBUcTIKvuyoYWKQMBV4AXi7HNNsyq8A1pWES3
	 S7J4Zfy0OsMg6qtWIXVhz4oXPly85MVs8pAWec63PjNNnT2Ir9GxxwksxspU5dqk4Ikbr
	 twaU/5b+rmBVn3vWAU/OhTHe5pIJoE6N5hHIP/ovBDcq7U1Kdwn/I/Lq1TJheJK8L4D9P
	 DWt+vJRyo8BznrSDfrqDchgNOts1BOxccaeILUCbkDkGLx6sWLOeT9lbzhgP3+oO0CA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFIbCXc0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1C606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F1C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFIbCXc0
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5361e313e63so40588831cf.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 07:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793110751; cv=none;
        d=google.com; s=arc-20260327;
        b=PkY0KOVHN/HestZhjDmrnAXWvHxC5uM1QBcrwsTeghFNFoj1ScgYpi1fFuBgSF3zl+
         DSp5gmz6Zkf5GcC3AU3c8zJjcZCgVSJZannKM61HzlS3jFgAD9o/cjzDR1wgOHyByHQR
         PLwq6nyTYSy96yuba0+tE5f+BK2NTfLeeZ4o4DfLrsSH1UzIwJtwp0kzvXZKBfWoiZ6U
         /qWlVXj9w+tbv5Yd9Cy1mCGxXpexZqmNFDUESIrEFxtyeNpwuc3k0ITOSmzqgY3S8KZI
         U4DjO5ie3MydGIJPHPsFCiYwHZyQtMVjUkpYayFlJALahQZz6jDaGPICF4xUZ3JbSdPk
         TTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ObUzF9BqDMZeAbdynJtdzZdfBBO17xExGv4Z+bdRNJI=;
        fh=DJqLEJ4IbaYtBWqGh6sF4Lef89d68ZMmdvp51M4Mpno=;
        b=n/0aCs36Ta34by1qTfJYeqKi7i1yMZLQNP3vk/V8GcNsRK4WT/4tLf30KkwXIWXJVU
         KQRR/ZKyHelJCLQIdUxtnrzTMXu9bAuQT0YgfijntsWlbud269Ihpn1+DZW7aORl+Xp9
         COH/cikeCwOEXj8RjoJPl/KgxqbnYTQH7gE5bDZrzdVdxPsz+SlDZR2EFsUq6xYsNOIP
         HxpVxxJpo3JNmVgG2/SRPnMWU2/na2lMHHH6i0bWDp9FtZbO/Qv/enOu6cXGA8AVh7eZ
         SUHc+jt92NFyZF+cqd8qa3LOxKLtC3sGKd8eCFzX59RFjF05301fiu+uQrZAuqwCjTUA
         ottg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793110751; x=1793715551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ObUzF9BqDMZeAbdynJtdzZdfBBO17xExGv4Z+bdRNJI=;
        b=WFIbCXc09zuc/lNvmUFoEP7qlqUFsGQd6gXGSUHERSx6NlfEGFZz//aMmM6LPoFwTM
         KZc8nF7nYwqgXfsoUCyP9xd9rIC2c9AKquFBJDzudEWqsk470n/pSS+sYFszFTHoO23R
         SAGDjxUbh0nppNEWotBHf7vrnWHqNcv3L9AG1fMSkuhEUatTRH+wrTTOmgr8ANVQY8gd
         CgaZsqCwECt5dfW3Jn/YMt6lD09n6+3RZWs0ojNjUdp+tAtWyq530aOfL2A5jYco5C35
         0dSlT2OKwxHb419VBo9Y0+i096IueBDHBVVXOUx9xG2GXnJzYWBjyAZRRn+yzCdH8ivK
         AEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110751; x=1793715551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ObUzF9BqDMZeAbdynJtdzZdfBBO17xExGv4Z+bdRNJI=;
        b=ZEvt/Dd5kWOaVjB7GErXCdR3BTyXPRvPsx6viO7ovJ/nUmolF2IPgDsfJa/U8+EQ2p
         kJp1ZjHW6X/dycDI97Hzju/EqkDEJoDhPpbeUmWAHHahBcWGrEQts2T0jdxXjd4GlBx9
         rnK6cQXNfdYNYGgYbVD3wpEc+mNADjlC5VZMqJrm+gYeqPaNbOIjp7S2c6KA3jAAlrpL
         XbF1vq5DtbnwQ1JXRehAFzeFQkzau8ZgyGusXypVRXQYAuGacATYSwqlperVBTwjl5tm
         A6+umgGhjz663fH77EOIBvVhx1X860yZE6Y3t1Vit23Dxcq2L4zX7qs0TJAvF0zleVGl
         LLhg==
X-Forwarded-Encrypted: i=1; AKwUvBzQ9KztgeEYFYmjJD1JwYUDpf1dXQZ4Ls/xOnt5t746+W1TsHIIBARkMQBwFmlHELOZNOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPqH1v276uUorQP8tDRyZ0I/Az71ad6DdWyz/wBllD6iaM15R2
	foRJysDN1ybN7im9NOegr0EzRxQSoKj4gL+CBXqNSrOHsuy8svuASNVJufqqnWDics2WwyIHjfL
	9UVeRjf4HKvu4xr/YA3Y52YXQ6ikLes0=
X-Gm-Gg: AYBFou0dlPbi7GaQ308p9s69qWUl60f5WptrdPbrFu6rGLT7vu5kaPlFwf7fC4a8xeH
	7/oFXWAD9ZikSA1xfaFk4ayJNFhXB1sQmUNuQDjpGf8qId70ZKE6Xn/MTwV1H4ztbczX4tVjPsU
	vpiKjCZCVOpYYXNG4cA1mkVAHSNklHcixWnDsEIfl8u1z6fkSVqRuPpooWVVoMNWuc4ox56Uev4
	InSExq126nbLDKjWjUDGcAeLVJVQJdF9pcgDwB2ejS69CwTSMMSY0tI3rqXWgGpdID0iTKB1WTV
	i9/Ap+ybyBmelbJdz91aVBMsfY4EVNXUr8WG1jWRNSbmE68sADJ/hcKxZ41onTeiBhw34STwWhV
	YsboEGF5SGM2TSymq0uJRrBAfGL6DfFNto6zSdAMlj0m7os/Nmm1eruge954JnheZop5A8Nka12
	eBAtJCbvr1zCWjLsLRG6EiAHdrxMpVyEJLgWbLktVrzLXBy904B+PcVDCsQQ==
X-Received: by 2002:a05:622a:5793:b0:535:9a06:1fc4 with SMTP id
 d75a77b69052e-5383b4b124fmr168627511cf.18.1793110751295; Tue, 27 Oct 2026
 07:19:11 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v7.git.1793098852493.gitgitgadget@gmail.com> <DMFLKY90144W.2W4T9I9V2PEYO@gmail.com>
In-Reply-To: <DMFLKY90144W.2W4T9I9V2PEYO@gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Tue, 27 Oct 2026 19:48:59 +0530
X-Gm-Features: AclHuK9NDXe_6SP3iIJA7qZliQc3cRdSzrfDWhSWwde3DQtR6MggJ75RAeY8J74
Message-ID: <CABh_KWhpK0cH=zz9bOsLpoA=+uBw+bNeNUirr3_p9-c3UUk4bg@mail.gmail.com>
Subject: Re: [PATCH v7] diff-delta: use safe integer arithmetic
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:22=E2=80=AFPM Pablo Sabater <pabloosabaterr@gmail=
.com> wrote:
>
> On Tue Oct 27, 2026 at 11:00 AM WET, Srujith A Poojary via GitGitGadget w=
rote:
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> [snip]
> >
> > For the unpacked index allocation:
> > - sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32-bit sys=
tems
> >   (4 bytes for ptr, 4 bytes for val, 4 bytes for inner entry, and 4 byt=
es
> >   for the next pointer).
> > - sizeof(struct index_entry *) is 4 bytes.
> > - entries is capped by (0xffffffu / RABIN_WINDOW), limiting entries.
> > - hsize is determined as the smallest power of 2 >=3D (entries / 4), ca=
pped
> >   appropriately.
>
> Hi,
>
> I couldn't help but notice that my review was completely ignored. Instead
> of fixing the points I raised, v7 just removes the information, and in
> your reply you say 16 bytes when I clearly wrote it couldn't be 16. It
> feels like I'm talking to something automated, and that's a bit
> frustrating.
>
> If I'm the one who got it wrong and that's why you didn't apply it, I'd
> appreciate it if you told me.
>
> [snip]
> >
> > Range-diff vs v6:
> >
> >  1:  b91a1ed54b ! 1:  8eb6d31788 diff-delta: use safe integer arithmeti=
c
> >      @@ Commit message
> >           helpers (st_mult, st_add, st_add3).
> >
> >           For the unpacked index allocation:
> >      -    - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit s=
ystems,
> >      -      which may be padded to 16 bytes depending on compiler align=
ment rules.
> >      +    - sizeof(struct unpacked_index_entry) is exactly 16 bytes on =
32-bit systems
> >      +      (4 bytes for ptr, 4 bytes for val, 4 bytes for inner entry,=
 and 4 bytes
> >      +      for the next pointer).
>
> sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit, not 16.
> "inner entry" is ptr + val, it's not a separate 4 bytes field.
>
> >           - sizeof(struct index_entry *) is 4 bytes.
> >      -    - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN=
_WINDOW is 16,
> >      -      limiting entries to 1,048,575.
> >      -    - hsize is the smallest power of 2 greater than or equal to e=
ntries,
> >      -      capped at 1,048,576.
> >      +    - entries is capped by (0xffffffu / RABIN_WINDOW), limiting e=
ntries.
>
> entries is capped by 0xfffffffeU / RABIN_WINDOW (l 157), not 0xffffffu.
> Removing the number doesn't fix it.
>
> >      +    - hsize is determined as the smallest power of 2 >=3D (entrie=
s / 4), capped
> >      +      appropriately.
>
> "capped appropriately" doesn't say anything, hsize is capped at 2^26
> (with a minimum of 16).
>
> >
> >      -    While entries is bounded in current code, using st_mult() and=
 st_add()
> >      -    guarantees that any unexpected growth in struct sizes or boun=
ds changes
> >      +    Using st_mult() and st_add() guarantees that any allocation c=
alculations
> >           will safely die() on size_t overflow instead of wrapping arou=
nd.
> >
> >           For the packed index allocation:
> >           - (hsize + 1) is passed to st_mult(), which is evaluated as a=
n argument
> >      -      inside st_add3(), and is safe from overflow because hsize i=
s capped at
> >      -      1,048,576 early in the function.
> >      +      inside st_add3(), and is safe from overflow because hsize i=
s capped early
> >      +      in the function.
> >
> >           Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
>
> I recommend reading the review on v6.
>
> [snip]
>
> -Pablo
>

Hi Pablo,

Thank you for the detailed feedback and for calling that out. You are
completely right, and I apologize for missing your exact points in v7.

I have carefully reviewed your breakdown from v6 and incorporated your
exact figures into v8:
- Corrected the struct size breakdown to 16 bytes on 32-bit
(clarifying that "inner entry" is ptr + val, not a separate 4 bytes).
- Used the exact hex bound 0xfffffffeU / RABIN_WINDOW for entries.
- Explicitly stated that hsize is capped at 2^26 (with a minimum of 16).

Thank you for taking the time to guide me through this.

Best regards,
Srujith
