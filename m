Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D139280D
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542806; cv=pass; b=h2kS+tYWMF0svAj46wduYSkupLmdivDZJaGrrRmQIsu92Syp2gFCOWWInZ6iU6IG89tDAEcyOckXXp7joi30A0WE0vlyJsGxvx8zdxfiUgUC08UKHKyrCM3BxHkD2Yb6Hepc6oMGY7GW+UTDPsoH41ORhAQDo+KAuESvMxFTk8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542806; c=relaxed/simple;
	bh=VIUx71oM7HPRruYcUBgOHS9MTks+2LVgw0JoQvtSlrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrFu/lne8gTRbVGElTgFzQJYQEaK3aj4as4lnE3Ptkc+sNXsTcW09K17QPW3x9Jx9f25kSRG2R4IEZQepmTBrJMFF35Sf/WA/6VQ1gL9qpMuwjNaL7B19QQmuF3HbhdMYg5/29CDZmnPLW4YQbWWW+LSONWxGtbftZGe8H//LcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/RuablA; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/RuablA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a2c90e383so2322741b3a.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 03:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784542805; cv=none;
        d=google.com; s=arc-20260327;
        b=MAstc95MjC/D4jziT2tatAvNkNe83ES1uqeGOPOeF+M2BToEshcwZN0HhyG5xQoF1W
         fTW5BoBH04l7RUoabeqQBBSVYXiEQ2SnLIERMnxNNTSgGXXJ2uYjw8V/2NrLOXb8QoqM
         M0vR+WjlN9ZJVK+lYCgYBnv++w9VMdx4H+lHrgDzrWywHp15LIRR/djJtDW+92CmleYB
         lWMbAoDOPuFpbV6ZlGbR28MHfAYvktU+B0Y2BDBslnYT+9vbv7z3m1QfwQ/1QTliqRB3
         1oA738cor+q4Xv8aE7vTUK6jjYBfo76vfFzmXbI4brolXCXhhfsDPltzOgT+R/o5RwMc
         MoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VIUx71oM7HPRruYcUBgOHS9MTks+2LVgw0JoQvtSlrM=;
        fh=h83en6Dr5+E4BFEbSBk9ciqFMJ3sYwHOEz/wUHqjghE=;
        b=hHo1vzitB0KCGjtKbTnwCwmmc2od1Mu7ohO1hWlYbYrK4L6nFvhuvEDzsAfG0sj6x9
         3N5dT3H3i1PaVdzIkDWfOybZHiajxN7m/Iwx9pdn0aUMXfQ/85hOnm0M7VkbPfHcOBEx
         HxjjWzamVHk6EZ0hbXP4GT53qHo6H7T5Rz0vMrtM2Yc9Ug0U+g4f8BjcKzszHcjqdgsD
         yeQwpSVAqupZ4h6hhec70fpNZI8PqbmZ+xouW258hEsoTIqxsWdqrQwaG2DygEuiNvBK
         i0fwkVR/HvSdCyNYtsbT2ScjuRYeL71YLf8e0fo8lwGBx/yitqo3Qrd7evEzvGYUvDyB
         n8nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784542805; x=1785147605; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VIUx71oM7HPRruYcUBgOHS9MTks+2LVgw0JoQvtSlrM=;
        b=C/RuablACAHWOIMT64X5DJ+nswHdaZdGiSM8rXdyNNtt1o+4Q8CoKUToikvjNfNBep
         EMBQw0CWiNZ2wL7LReUzYazRPFVphCZNup/+WaAcaEf7KBzFiktZTfYc3aOmNK6KVaN1
         smfo6WS6r1tfU7EgZ1AlNPfk1VQXlTlmjPbPoB8GfAcxqwXlmNxdNTlBlDBUoSm0QsIY
         7M4iiUQ7qqQTBGJ8s6df/991FG/5dTzhTlisRuZBObTqK+Eto3oXh9bi8LYRRS55vq8Y
         ToUHaTSuPJxhJ7rGLAtScgKMOXHFEPJ3mbdTdX9Kj0BR1juSLjnAzZN4wJNtwuYWQuIx
         kaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542805; x=1785147605;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VIUx71oM7HPRruYcUBgOHS9MTks+2LVgw0JoQvtSlrM=;
        b=TIQz0q5NMBpg5yQFAYDGq01sn/u5HY1u7S4ZEgHnG6jBrfRyyUb/P1eDYLwtxtsGtq
         vU+STF2THpfZLAwMmlY2XzFG0Oz51wSzOMp+8V5tankRbjso0eGzUl5yzxj4f7nnIPKG
         bkh9eO8LNmv+dodKMxB4uXCA1cUyqW8nkojYiWy46/x6iqy3v7/idb9KAgKpKc0l79Ob
         UH5O9hqgPo0qFGoj3ykwRc1rHh1JrxVmis9W2kfbNnPto2hzuEZPrsqIE5ZK1bwscZdA
         Rkot+LgaUg4gUTPS6l0aYxlcA4Lv2Yl9QcT5NjR3j+WbfsTqTFu+MAXEk2xLIgyYwNFE
         BPpA==
X-Gm-Message-State: AOJu0Yy+vZLgO5swwizcU6tfTuHPfzE8k7YfqDvYm2chNqHgnvCpLLDR
	WDsXkpUIC+yWS1SbA37VgE/x7SYj3V4/g8R1gQZjfIaTwACunM7Rrnav8XL0sQEAXlltQlp+Rqz
	gxabYIezOgn+OA+XJ1A6HPFozOQuvIUk=
X-Gm-Gg: AfdE7cm+qiQgujxCVBBKUrMcL7fNlAKwhtMq0RdyjlKT8eoZT629piuCYcND2KhJ3x/
	BFoVywWFljp6Lxr5XozaTEHXa5c9hXg6SoGW1wef/a1JSsMJQAGsDi6jxMRoxuST/nXFIzllHiN
	VPaNygDH19hhCInzUWiMQ9RmMO5cwqe6s82Z5L/nMiv639xFFgkWb5WIIjDXptkaEWPaI/euWlW
	zBiL+Q3clH70c4RdDDGVbdi/P6ZdJk/yNoKhr1tqaqgDsbTuvlQLCgM8UEcm3dfJ9QqiVGEpiVT
	sEWu4/JlbHg8V1FvQxPk62CaTHOKBlVyimZ29uIOlEZO6rmGCIlwYJqws2wGow9LytHzI9kKT12
	KHkDQZQ==
X-Received: by 2002:a05:6a00:6c9f:b0:837:f111:b70 with SMTP id
 d2e1a72fcca58-84beb054ce3mr17593511b3a.4.1784542804401; Mon, 20 Jul 2026
 03:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260716132848.95982-2-r.siddharth.shrimali@gmail.com> <CAP8UFD2ZNmWh4fjh+vFvKCihfebg2yif9=xLjqpKZFgF-O0RSg@mail.gmail.com>
In-Reply-To: <CAP8UFD2ZNmWh4fjh+vFvKCihfebg2yif9=xLjqpKZFgF-O0RSg@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Mon, 20 Jul 2026 15:49:28 +0530
X-Gm-Features: AUfX_mzXUuzZ7lZ-B_5RxPxUBl4S7bZBHZvyYlrLnXceD5runhdolEVZ6fsZLLY
Message-ID: <CAGWgyh8rCg0eP6Og31RPRn6oXZ5K09VHtH2UsvMSQs9-CJ=pgg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] builtin/repack.c: add --drop-filtered and
 --dry-run options
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	me@ttaylorr.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de, 
	karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey Christian,

On Sat, 18 Jul 2026 at 18:01, Christian Couder
<christian.couder@gmail.com> wrote:
> An alternative would be `--drop-filtered[=dry-run]`, which might be
> extended with other `--drop-filtered` specific options later.
>
> I think separating `--dry-run` from `--drop-filtered` like this patch
> does makes sense though if we think that `--dry-run` could be useful
> later without `--drop-filtered`. The fact that a number of other
> commands already have a `--dry-run` option might be a good sign.

Agreed. I chose a separate --dry-run mainly for consistency with the many other
Git commands that already use it that way, and because it leaves room
for --dry-run
to apply to other repack behavior later rather than being tied to
--drop-filtered.

That said, I do like the --drop-filtered[=dry-run] form for keeping future
--drop-filtered-specific options together, and it might end up being the tidier
choice.

Since this is an RFC, I'd genuinely welcome others' thoughts on which one
holds up better in the long run, before settling on any one command-line.

>
> Anyway it would be nice if the commit message explained a bit the
> choice to have a separate `--dry-run` option.

Either way, for v2 I'll add a note to the commit message explaining
the final choice.

Thanks!
