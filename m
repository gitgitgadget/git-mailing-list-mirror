Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795757202;
	b=HBjsSxyhH3u+3MCzTGAj+gc77gtwIHMxYMyGdA/rngLD8gJrS8CN8wIehdeDZNd0gDhg
	 YhwEXwc7SAnRM1T0/nVSujUxvPDZLKWH1HtAzoteOvRQ6gFI5vtamsDGGWY+De5F2+SYX
	 Mz36f1pN050nCre90DFMBxHFy9cqjQ1zlBHcxO2hV49e4wJ8Q3o98hJypgArwVk3n+MoW
	 3lRtB5seGu2FRX9zQT9KOQEvzzwkauIWifOz9NEybOVNmIANpeFXhnj17xA87MUX8pZoB
	 /msdVfWHyrpXzXelylZt/G6xfAyzB/A/I+k+g90XJNUuL+ChgQB5uwDGeGr/aJuDfKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zGo/FNYAfyYQSxmNIiZfyI8Mw9KAdWjIjdmXCS0J5ts=;
	b=vef3x1LGvdP864d9ffE7ag9PjyH1nhHgeBoF210ETztyrzshrQlQW4ZTwzqszN8WQWmy
	 IfutVNNuzmBrADNUIu7nSg2E8lD5aJtwYqcp0B9ABRF48lvc/HgDplxuIDP/1+mUVYXku
	 JnQjN1cxgh9oRd/OzzsjiZKOREC7EXztbrmBlZsNA1k44/AVYCAT64IP2ACmz2Qp1MSOQ
	 JwT33B6YemA92xqQlPvZ3aJEDCFv0pRaWBd4KFH+fs/czU7l5UvK5jQ7K09NuPZGNZyQZ
	 q8n7M24N9+WRughODX8vDw9Ib5i9LjzCX+qWLboAuIYVH3qdE+LX7IuxQxYNz5ZXgnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O8IaZSvj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9E606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE9E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O8IaZSvj
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso7662930e87.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:26:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795757200; cv=none;
        d=google.com; s=arc-20260327;
        b=aMuCgNfmY2nkK+ws+zE5Nr2HRG8EKzoualICslWktcZw3RX20BdAIosRF9damtMZUC
         FTzzF/8PhcnkC+D3P6yW8Hm0m+9/UQx0NavMsDWE8SBJy7RJcqB5V9187aMNwjxLLc/H
         Y1J4ji3z4mTeRt3vxXCeHGDHoPfKeBRnWRWR9YF7VoNmhtMA3YchaoejgPSkEKBugIGx
         guguAxrxTeCAM8UO32GjMoZ/Vrk2qF6doknGLjpq7eH97zcMg4f+tSows3asiJFsr1dn
         wzKfNvlOXeVB5QY00j9FRBhgZWbvm4IgLyRDYBGF009wKDkhEH7sd8CUEulqtjbCwHPm
         HwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zGo/FNYAfyYQSxmNIiZfyI8Mw9KAdWjIjdmXCS0J5ts=;
        fh=BqENTY4zqFPsVZkQtz1v5mqP1ruRLlzBD3JACpsT36s=;
        b=LNl+mu/BBrsHvrWL/v379ecETE2w1BFp3vbgAh+30bmhJBUXyxzxbn6Fe3I9P1oOKN
         sg69AVrxsjuwbpCZh+nC5nPGIKfh05bOghEgZVjSopdqFKC+/aY83yW3DoghHHt4euDl
         L4ZSwgzvfEpSaAuxlHeYrma1SciWnZzULzjkdEbrz2QD29PzDXrPeRfPYwMhCRo+CUz2
         FADT5HmiO665NytRUvWNmPf/wo/PrGCr56XD9gJGi4j0o9+gakvK/RBsWX6sUTxu52BK
         TTnahMsE16J51yZMGuZfFNKnBhjhaXywp1fnZ+T1s7tMvPbGp5RwhhPYMhyhYY1c7XR4
         sItA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795757200; x=1796362000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGo/FNYAfyYQSxmNIiZfyI8Mw9KAdWjIjdmXCS0J5ts=;
        b=O8IaZSvjhI+yPJrJ+w4Ok9ThHnKLSBCBjZ3Y0ZqExOWQlfje0fk8tnTkFy4i/5aA4D
         e+MuJmH5/vexYSMNniFEAzV8cQitJAIteXuNnisfEh/h76keMcAvyU1PjhhyFfvUOk3S
         W17PvvAFHKCz214h2LF/s/squtj0/LbuGGkDyqa3vpOBNFxWbrn+E8aN4sUr7fo7I9KO
         kj/kycItFefOSpKynyIrAlRt9K4P9mLp+7Il/96qiH5+y5DDF3s0A2jqsGhAD1nNa+p9
         95YYAavnhXBORMbubII5R2EoL0gkPD6icVJFLgOFQNqSj52vXLfzpOjK6lm8Sv17UnhM
         RE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795757200; x=1796362000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGo/FNYAfyYQSxmNIiZfyI8Mw9KAdWjIjdmXCS0J5ts=;
        b=KxF4kcjDGDYxSicFOjf0qjL7OW+ZUC29t0+J8cnHL2ki3oeLYhY6h9mFCTiPQgeBJy
         ExZ1Bu3LUnz138+f8bgQvOqgjWRbFu+odDyXDm4ns+WAlBrznwAC2v6bGUYN1+3eD4rm
         pj0DVLnAS0+5S40hLkXbjpxykoxJ0xkO9+U+p1f2fPkoRgsSdBsee3/JRUH6u49/R8yK
         NaHtJIb2l6EyMNKxSjEha99P1GDY79CozN4YiPMF4GQFnuK3wH4wkkzXRFycsef1wZfH
         wcSsEusED0GoFPLMLDLkDQ1fjeU0DMliizxEWTXB7qC6ugc9b4PV6L0FBNDjJ3R2V1XM
         o7yA==
X-Forwarded-Encrypted: i=1; AL+hErFfFVGMmFKYn9DIQpYBQ6AleC/eRZNE4xDc8x2yiKPNIvlP3ldwtaQVEXXfyO2wPPZXM20=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ruHNESTna5AdDCB+eHM5dchbztGoY8z0O3NQS+WLHBXSNzZWS
	l10DMMvm2OkbLocHAd7rG+DnWWfKcqngRDDutFC/RfE12ZKKthtoBRUtROOIGbFFIgV+F5lX0FY
	SKfRicTy3R8zAtouKIdU6S1OcXm9Tp7c=
X-Gm-Gg: AZFdTZdojzv1C5xKpKto+aukpxELg66WYrT99bm4hKXbFgG/BHtFVb2N3xq0DhYzNHJ
	sfbhrq7kllIWiLDTsCt/D9DmfxCG/Rt1x9Fh7SSWiCSmw0Lagt4Iw8VUwUA3YlmGLFiolCuJkEj
	eh+ZqO+4MmT94tgvlpGfALH8SS0a1saLPHx44JwKABDTMRJZN6ivU2rKkXo+0xkPa6idOv3Nwlu
	xkOwowGqdx0jSfC7HnAta7VcFuqxbGL30asr3GfH36nf/pbbepZXys4bU8+xUPZV7bz8BSPiBQ4
	1pHPBs1EifSfEqZuvMAw+UmBJLaqa3E/cDyis7lpFDHO7ivTGWfp+R9ICNaEC9iUtgtm5F4TMEO
	KfQoUMEjkKTzH2MwLyNU0rmuCF7VhzZzAm4OBS1w=
X-Received: by 2002:a05:6512:3d0b:b0:5c1:ace3:1313 with SMTP id
 2adb3069b0e04-5c1bc867462mr6572117e87.29.1795757200125; Thu, 26 Nov 2026
 21:26:40 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2336.git.1795686173178.gitgitgadget@gmail.com>
 <pull.2336.v2.git.1795747717319.gitgitgadget@gmail.com> <CABQNq+mBfq5cPL7W31EcWPNJqb+3tfYRpyec4sRb4iD9oPYCbg@mail.gmail.com>
 <xmqqmrquetqq.fsf@gitster.g>
In-Reply-To: <xmqqmrquetqq.fsf@gitster.g>
From: Nahid hasan Sagor <nahidhasan141400@gmail.com>
Date: Fri, 27 Nov 2026 11:26:28 +0600
X-Gm-Features: Aa3M54rHg51W2yAZjL8u6a7fWzosiHzNHBv_cChKcrdjgIvop5U4pj6LddHKetw
Message-ID: <CABQNq+muQFMr8LJuY8dUosV2AzdXD6a=6759smjgE+yQ8ym4WQ@mail.gmail.com>
Subject: Re: [PATCH v2] push: shell-quote names in suggested push commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Nahid Hasan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

I am very sorry about that, I didn't realize the workflow here and
followed my usual GitHub approach by mistake. Thanks for explaining.
I will make sure to finish the discussion first before sending a new
iteration going forward.

On Fri, Nov 27, 2026 at 11:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Nahid hasan Sagor <nahidhasan141400@gmail.com> writes:
>
> > Hi Junio,
> >
> > Thanks for the thorough review. I have just sent v2 addressing all of
> > your points:
> >
> > - Dropped the trailing clause from the commit.
> > - Quoted the entire "HEAD:<short_upstream>" refspec in die_push_simple(=
).
> > - Removed the "die() does not return" notes from the comments.
> > - Quoted remote->name in setup_default_push_refspecs() for
> > message_detached_head_die[].
> > - Simplified the test_when_finished cleanup in t5523-push-upstream.sh
> > and removed the redundant single-branch test.
> >
> > Thanks,
> > MD Nahid Hasan Sagor
>
> It is not considered good manners to send a new iteration before
> first finishing the discussion on the reviews you received on your
> previous iteration.  You respond to reviews, saying "I will fix this
> point", "I think this one is fine as-is because...", and so forth,
> wait for responses to your response, and eventually come to an
> agreement with those in the discussion, so both sides know what the
> next iteration should look like before you start working on it.
>
> Only after finishing all of that do you prepare and send a new
> iteration.
