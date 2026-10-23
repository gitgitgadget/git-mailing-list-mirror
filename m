Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792774584;
	b=STNOadUXXQGOR6AmmxV/PXAQfkZBHTW29zIFGYbr6J0ygP99so42Xxl77FGKlOgTiOmC
	 iRqz9bM06I1L4NosPkiD55SQ4nzSUHJOdGowuB7aaa3WrrtjMJmrN1zDqYsXbGut/Ufsc
	 Bc86ytmarwhL8NZuP0fydkPfO3mULzsOR6Lt1TYg7ZEouatS0gNCn3y/hrZAw4Js5uuMu
	 et3Zr+WTB1J8UKyJlHLXgre+WMjS5DaBT2h1fWXuWajpLatAVRnDE90fbKkwJnB4V+2a/
	 qSeo78TqsU5NBo8tMUciGV2sdGrW4JWALwqYvis68/7P6NcoahRGKjFzccnMlqJxOog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FNTgzAp7tRvOoxqvqIsregZfs+LQ5NVqpTZYJ8syyyY=;
	b=N10KMPG8/GqomxHjjGwH6hMyZNWEzZplEXC1xla1LC+BhsPNtOXV+yRXKNSA5kXXqSfv
	 1hyuJXSXN7Z1BPtiVrVBeBFEj5AUVOU81q2GKlSleHH4YLfqMjT/53iNy/3O9/4rLNTc+
	 LBMPhCq2dlkTFvZ93Jgx93FpAShA+yxr8TkBawcXwpfo+vix89/H//y4amTWqHwDICeQt
	 Cvui0eiopNTfBklWXM2waMyN8rfjB2oYAE2qTu4WzyRTwXojRbdPnjIK4oDCK2u67ls/Y
	 yN2Qi8mZsmuxZ9TWh+bXSDp5J6s4X/U1voHKykSjz8gUjjyH7khuzjUmx3vWZcj0EbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z65EzpSn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC52606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC52606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z65EzpSn
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e55db58cfso105276285a.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 09:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792774583; cv=none;
        d=google.com; s=arc-20260327;
        b=P8omFiTqmhKp5SZSnj8SyKNzAwi603EL2RqxTJJhRzg5GgVRsDY/+Bpwc3wXCN1Wuu
         PZSNJORycw0Snb41tVT/cYlTTOsHmJSSb2F7FwGsDE5Rc+67OlcqAC5EVzw1hnfHJNt6
         zH2Q5Q6kxU4C3s1A0AKYrbHtAaVKFxLraXSMui6UiqkUFSX34RnKVxKbWek4IfDhjCQV
         sn+gHfAvRSDdfu/XJ3vN5LTterRrZBHqhOZqhj+iZB4n0vIYIcDK3WvvcEnseenlkUgx
         8wHsK6itjSPqTU4p8CRIvt55hzQjTgAmEmaU+J3ZcVYzNkn+MD5X4oXGvfECCnrpdgix
         qhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNTgzAp7tRvOoxqvqIsregZfs+LQ5NVqpTZYJ8syyyY=;
        fh=6erHoooVZHKRIDbuqUHhwcpSkervJuJprZggLroIJjY=;
        b=V/uFjWaO/IAVioZxJ0QSc7jIjydH1iYi+YEJNUBroLxHBvZuDAJE1gGuEDRB3TfvlG
         IdjkPmD+tz0qFTN1+nA0YrB072MjWDo/weSiY2elAY+PRbN7HFva+HhOLM+66Og9le9D
         NvPng0pWE51az3BWpo5f1CV8XqkZiZm9Jg3Dpwv+mIj3P5jiwJETtOFXBWT8p9++oA1k
         shtYTlrO4HBJQ8+pi0RIXpFAEhrxZMz5UTZlNl/n24ccS/safrjBC8YjsnlDFzS4djUb
         9Nmu6Txw9xLxDirN2HMfRMSojjxyo2vFv/KqRJC0o2tKsDtJFP7PAbm1UBoqhpUVU/mU
         1+Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792774583; x=1793379383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNTgzAp7tRvOoxqvqIsregZfs+LQ5NVqpTZYJ8syyyY=;
        b=Z65EzpSn8fD+EM1FuVzqbqMh2bSd5HNakvtJ9Lt/9qmIKPUSNC9Jr9jtSbTiHLR4K4
         c1I6h7QuMJJcSmGEcF+L0QaHj2n7AXr5AzrxzS3yVMXBSM8ljtPFVs4XuWa9sr3z3kdR
         hxfkB1NWc2QyHeXUunL64CWbccIMyfcZlPmfa/B2fouJAtpJTgIY8gR7XBlsQ2o4ZI3a
         HOuhtRjcV5FiBAYmlp972RCeYbKjNa0o2e3B7+wSWl89em3tlMpjIhwzZL+fmLLm/YmT
         IOggvGdrjbHyOpC20V5VrCwLvyK7I0h5SRVkCBQU5BBXFT7vvM7tIz4OsR5sQnr3uOA2
         t0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774583; x=1793379383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNTgzAp7tRvOoxqvqIsregZfs+LQ5NVqpTZYJ8syyyY=;
        b=AP1RbHAeNl0Dhe5Bq9opyqsmitmb971dzd8UjAxUdJ4sFvblxXeIJ51PQ/7GOBJCdg
         StIQEP8C2p275aL+09XfIeK3O2VRdsLETG6VD57gpKK23MMTjfh+xa238qkQAjXteNf0
         29dWMtn/gQ6jnNrVozH1TQ464y01spAaWRRbuUsJzC0Sv0i6MQaZidb0YvmZnpmrW0RL
         ZGvyMUTFnHTpGb60uDYUZwjN2w6JMlGkTGqtbpNOyy0crErOfLVwfdHg4nFNKOOOa2W3
         LaWnxj16eZtFa5+mxM+ENybWs5quaYlj8JluY22Olwbeurg3wyf+8e/1RPK3QIDL0IPF
         zMBQ==
X-Forwarded-Encrypted: i=1; AKwUvByf9pA6imEn5STEqoRbsZ9MNqCpHC14aCMhyyGTtPWtuZowo2FnIGjvVVRu4kbxClHwoXc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7fKGNdIw4fDIUyau7zkuefsbm0KnqS963MalUo2avQ3yZwhlH
	e+SyIuRQGKhB/uyipWjTtyXaSzVIm/fwBWPNNuIIlQ4pTtprevYT8MIDrFSyr+UxjVUeEsqXype
	Ps5WzaqRuBFWJ5umCT0aI5EeMgkExrzw=
X-Gm-Gg: AYBFou1Ku6u1n+YzqZEths8rN1iFwm2g3/7Ix7I/p/dWLaoEPvvorG6uvygNfiy8GDt
	dI5SMqv0lJsGwkw2+Pq1QozcHGFAI7rB9xZxUAejXDJcRlp3I/69Q4TvSx/NtE1i7FKpCsYeaKu
	9V0k0BCg7fRfNx97Oe4dyuVaeRh5IG+Ze28DrMoUxd4e26AvXpVjS8ck23nudt7FBFX3BWrt9ST
	1I+75V86gDc1jYYg21758utlpNMiAvo7Yv38QFi+KL0nnv/+UMqVCBZK/rueRnuFb+k5CZXtpiu
	x6aS+l0PnRpoSOPRDooc8M5Q/zAGN3V3jxZ1fYlnUum8UySuH8weV64L7ek8+s09oN+KC3CNjvl
	zQFnS1Ozpzbipn7xbT7kxMdNl2eRzuOz8ZoZU4KTB2oHbuNPN48HSEcfTtXarnmf+TKk7jM1VFY
	IRcCduFHHvzcCaA4Lx5kWYgJyyETCTwgiRHhV3bF98WmRIwl7ABzkjHQDf
X-Received: by 2002:a05:620a:198f:b0:93e:c12c:9b6f with SMTP id
 af79cd13be357-93f6f85dbdfmr535739785a.74.1792774583491; Fri, 23 Oct 2026
 09:56:23 -0700 (PDT)
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
 <xmqqld7paty9.fsf@gitster.g> <CABh_KWiKmXP4KTgF=k2gGdSvcZXkRipD61AVn+AS7ZgvhcjHWw@mail.gmail.com>
 <xmqqtsmca0yy.fsf@gitster.g>
In-Reply-To: <xmqqtsmca0yy.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 23 Oct 2026 22:26:13 +0530
X-Gm-Features: AclHuK8kW-m5AqMsEylObYOzZShKsnjqluargxsV9oBK_7KKORwUUKVfGraRSrc
Message-ID: <CABh_KWgBzCXCSn4FUTSg+rXYj9vm6+AVZnDn3iR_4UJCsB8tjw@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Srujith Poojary <poojarysrujith@gmail.com> writes:
>
> > Thank you for clarifying this. You are right=E2=80=94st_add() and st_mu=
lt()
> > call die() on overflow rather than returning NULL.
> > I will update the commit message to accurately reflect this behavior
> > and submit v2.
>
> Please don't, before making sure if it can overflow.  With the
> number of entries capped like this:
>
>         if (bufsize >=3D 0xffffffffUL)
>                 entries =3D 0xfffffffeU / RABIN_WINDOW;
>
> and then computed
>
>         hsize =3D entries / 4;
>         for (i =3D 4; (1u << i) < hsize; i++);
>         hsize =3D 1 << i;
>         /* allocate lookup index */
>         memsize =3D sizeof(*hash) * hsize +
>                   sizeof(*entry) * entries;
>
> it may not be possible to overflow size_t even on 32-bit platforms.
> I didn't have time to do math yet myself, though.
>

Hi Phillip and Junio,

Thank you for the detailed feedback.

I checked the bounds: since entries is capped by (0xffffffu /
RABIN_WINDOW), hsize remains small, making a size_t overflow
impossible even on 32-bit systems.

I ran git clang-format HEAD^ to fix the code alignment as suggested
and updated the patch.

Best regards,
Srujith
