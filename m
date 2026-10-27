Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793120279;
	b=4vyohIic/9rF87ISYwvGFz7c/QRoAdb+kZAr5jAN16uw5D/qg7o9jF7KAH+Nq9w2kzwA
	 qaOD9GtQ4wDCULYe9oxzmpCskJF979VPqjBQ0Tee7SM8BQ4F+gNlpCt0BiOQONafHm6KJ
	 +bgcJBx4sFnCiM/ESLgIDczPrYAxRvbzKCCfjadFcTm0q+yIpir28jmW7NCjhPLo5mw2N
	 OojYEzT+4FAqICYuNppSqAt3IVo5KcjkpOueITCWmT4TygCOG8Nx8n5OGA7cfSi7SDKyd
	 2tKu2HJI4PEC0L/ZwMlYo/POAbyoQHlOSB0NhMt4Z7ler75WdeiGe3KD+oD6F0FAyCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DMx4tDCDQCYgua29psbaLPRP8/Ow0HyC16c/WJSjeRg=;
	b=nCESuLkYaVOzrt4cB51kictlXUrluxMeK/um4Jmi7uu49fD4MdUCfjjiKCb6yZEllGDA
	 K2pTiTd9t4XkhqGdMxldicI649nJUxanwXFyWsVxUn9JyYvPpsApYhrHe9iDLcJstCENw
	 R1oF0lM76bZHvxmeC6GgSvGqh1AaIMORJGK8aDGaEsElpYMSos1ZHZ4Jkxmw6ZW8tgDyv
	 wC6WUmXr0VzskOcSr712j3tTqpnLZiqQQmFOiA3Ld4L58b7XBt3lg1B5EQk1dH33HlQ6c
	 mi/C5gYvEjuFCckzHnVE3fmIkxKDuezUDO4nkA65QlSgkCnaVRUgc+8i2HNZ0ZjfSvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TXNkBayu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D132606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D132606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TXNkBayu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b8306b9f8so1471216d6.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793120278; cv=none;
        d=google.com; s=arc-20260327;
        b=kGccOajbD4z7y0iOHSP4/AdMwc5nMH9KpBkI5nTvvZcAZf/oh8l0bhge+CzgdCuw9f
         pnpw2rEJK7Qqmd/HVtzzukLA7wjmQp38QhMn+VRZC7h0QY3fzNdABfwu2p7qbmkOvlTz
         bCLYUje4to/B6vwvWLRwGp829Edeb1Zl1NiXt+cjhtYQjJpDbKyr9eaKagptSQONMLCF
         fSOFN5ysi8RiZGjzvmDAop6zh581GmKmMt8NU3yvcOH5iAHCwZvVu3C57Kbdc1cn2GqF
         MQ1HZjOZPU9H4ZxjMrePGKk9BlJ8DZerP1M4vw4ETetym42I0v+0aZrP8FtzgSiTn7Cx
         QYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMx4tDCDQCYgua29psbaLPRP8/Ow0HyC16c/WJSjeRg=;
        fh=TkelY52rMKyXzFFau7r7oSE8C2/XaAnLnj1fjSQOCII=;
        b=W0d3RSr4J/BqkJhQIACDrgZFrzfE6IJbrAic9tCed7m2TYrGeF+jQsRyppQzVRoi4U
         mlqZT6E819qHfI4iJNvEY13/1jz+QP4x4LiQnUBi7atkA67LLX2XS1uhHCIUPPQDdRNW
         GlWRh2YvmFW7mhiopaUOwjiurMMskX7lbBiV9p8Hqwfk5bKWS3uy50tbsyoGcynwjUUr
         A1Tr9ey4Rbs2u+t6rrY1o94Phf/D19uQR5l7fO7812bDphRwgJDuOQdcrDWu8T06THBu
         wPp2CcTMNBMiYnzYyaP1UMvtWA9lL9CDufJ8jKO9t2pYaNygE/bb5yE9gNiSMiyh8rEg
         ddmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120278; x=1793725078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMx4tDCDQCYgua29psbaLPRP8/Ow0HyC16c/WJSjeRg=;
        b=TXNkBayuDWzDxW0nxgDPK1hsNS1gve7l2P72+KO6NnCzSKj8jExsprjrK/fJfDslEW
         6kb3h8N3dQzJLuIeAtVD3RMWYWa2GAx1xN5pT4Mtc1nYAWhM2ei3tKpb8pkjKxh2GPQ2
         qycD4E8Ijf2KYJ29dvrscdjrt0HftyfRKWLOQEeeU33s1rbQDDJCndiWGhWHDzD+IHk1
         94SyIXFFd1oJJvVDOd3FkFv0wFC6drXMZV1eEnAOXMx1J0ZXa7baDl8cv2W/DShbA2Op
         Ga9qK3X2GNtV9BqKJschah0BrYfuxjC6O78Ml+gY/vYigWXld87bgGAu/Nt7k/o9cytE
         MqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120278; x=1793725078;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMx4tDCDQCYgua29psbaLPRP8/Ow0HyC16c/WJSjeRg=;
        b=u84Oov7UpqUM27u8rHLH0pVwa0B7sHWDErENYasyjGopRbAP3BMc9j8oyBqQHBssvg
         UmRmRJS/TrMIe8PyPPFTPxOF6KVLoEOba6tPE2SxT0Ns+pcDJBlM+XT12ZEB7UjBobVs
         OfsP3i+DzspXlkUk+zBk277+o8CNkvxQoX8QgFzrKT6HoMtaw5IkWocDRZ/QcKvuB/HL
         g+YNjs8Z7OSBDoOE0hT2LjF6jz5GilIgbhniL09bqVLhPZurbYgzGwYqH7KC3jZ2326F
         DyulNLTWr2IUubmMppPuK0aSzky+tcL3wh5j4Q+fZaFoxQA/qVhCGTpnyBcF3VpcBwCX
         OXgA==
X-Forwarded-Encrypted: i=1; AKwUvByv/4vUj29Y4q5nd+0fLvyxj6Iwb+Kog+rV7nhTIE0lc45aXEcSwbsnlYkV7sYy7vHKc0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg6iZNIIBnIqO4RWMNoNXlVxHd3/XjCffsQcdG3elXVb6VSH1w
	upxoCafMp3tvGAJ7g72Z8U6LoxF32FKJ5/C42OeD1uu8c8pa3dOkplTtSaga8NkmUsMwCQFVN/w
	culmSVjHHMzNkYzhbmqdKJWdtqElIWrigEs/zSbs=
X-Gm-Gg: AYBFou0kmpyf63ysSju7PaFO9oa+3AeIk6zJWF6FiDYDK0pu7/+5zgG2Hc2kRLjJswC
	TW2ZdezReMFZlp/6c6SmxSQRDX+fYCHwcWaP17acWq4Q4ZFSj/+q99IkkniewJzJm7jtLmxBDQ+
	ZDsCBgqSGDV2uCa3a6Ah6ZJAKjEdu20qAmZcIXi0r+xjK6SgvDICnyR+EVX8q09Byg3GK6WaZY/
	/hfM2DLzYLkpJvsD/vCRtx9CwrXN0n0pGuEPIobfXSTnaV4H+IY/mi0bXWaHMQPV79l51wljhgP
	xwz4H1hDHtv8lHKBNTjdIivfQfctisu9w8lqIf88L2a/aY5iHu0yC4EQ1EXZvCWQF8ReAPrPtRx
	pdGcolfDP6PCEOUIy3iaAuePy3iGl5OyOO2xn+zNDuMqtvlRVkRz7n+2hzsC9E6N/nBY5OM3jUZ
	gKUq/QgnoenkKYK0qycgz2gql+qyr4rOV1+HZxIaO24VnoT0kdFzSR8bJM
X-Received: by 2002:a05:6214:8086:b0:91c:613a:aef with SMTP id
 6a1803df08f44-91c613a0bb7mr96562876d6.25.1793120277934; Tue, 27 Oct 2026
 09:57:57 -0700 (PDT)
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
 <xmqqtsm7m7ms.fsf@gitster.g>
In-Reply-To: <xmqqtsm7m7ms.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Tue, 27 Oct 2026 22:27:46 +0530
X-Gm-Features: AclHuK-OiXbTcTk8cQjU2ms5kTG_RWzi6t1Iq6xFpyabGOJPxVStHitcGu1LJIA
Message-ID: <CABh_KWju4DP17T6aj4nEJJQJjP0fn+_V8ja0WaE6VcDCkj9URA@mail.gmail.com>
Subject: Re: [PATCH v7] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>, Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
> > On Tue Oct 27, 2026 at 11:00 AM WET, Srujith A Poojary via GitGitGadget=
 wrote:
> >> From: Srujith A Poojary <poojarysrujith@gmail.com>
> >>
> > [snip]
> >>
> >> For the unpacked index allocation:
> >> - sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32-bit sy=
stems
>
> "exactly 16 bytes"?  That sounds fishy.
>
> It is implementation defined, a naive expectation is it would be
> more common to make it occupy 12 bytes, and we should expect it to
> be larger like 16 bytes depending on platforms.
>
> The C standard (e.g., ISO/IEC 9899:1999) has this:
>
>     Within a structure object, the non-bit-field members and the
>     units in which bit-fields reside have addresses that increase in
>     the order in which they are declared.  A pointer to a structure
>     object, suitably converted, points to its initial member (or if
>     that member is a bit-field, then to the unit in which it
>     resides), and vice versa.  There may be unnamed padding within a
>     structure object, but not at its beginning.
>
> For a 32-bit platform, the minimum natural alignment for a 4-byte
> unsigned int, unsigned char *, and a pointer to a struct, are all 4
> bytes.  However, the standard specifies minimum requirements, not
> maximums.  A compiler is entirely free to choose a stricter
> alignment (such as 16 bytes) for performance optimization reasons,
> e.g., to align for better cache line utilization or vectorization.
>
> I think your math is correct in that the computation for allocation
> size would not overflow if we can assume the struct involved is
> always 12-byte on 32-bit systems.  That would make this patch
> unnecessary (and the patch is unnecessary on 64-bit systems with
> wider size_t to begin with).  But we cannot assume the best case.
>
> We could assume sizeof(struct unpacked_index_entry) =3D=3D 12 on
> platforms where we can depend on GCC/Clang's __attribute__((packed))
> and C11's <stdalign.h>, but we are not doing that (and I am not sure
> if we want to, as these can introduce different portability issues).
>
> Thanks for pointing out the fishy description.
>
>

Hi Junio and Pablo,

Thank you both for the detailed feedback and guidance.

Junio, your explanation regarding implementation-defined struct
alignment and why hardcoding exact padding sizes can be misleading
across different compilers and platforms was extremely helpful. Pablo,
thank you for pushing for precision on the exact bounds and math.

I have just submitted v9, which updates the commit message to
incorporate these insights:
- Shifted the focus to robust defensive programming, acknowledging
that struct layout and padding can vary across platforms while using
st_mult() and st_add() to protect against any future size variations
or wrap-arounds.
- Explicitly documented the exact bounds: entries capped by
0xfffffffeU / RABIN_WINDOW, and hsize capped at 2^26 (with a minimum
of 16).

Thank you both for taking the time to review this thoroughly and help
me get it right.

Best regards,
Srujith
