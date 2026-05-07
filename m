Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE42C859
	for <git@vger.kernel.org>; Thu,  7 May 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164759; cv=pass; b=jlFJ06aaym0o6vTn/CfaAVwQwPeBil1TaKVhk1sXBmkuLlMQzAM7hbMNrzNWuqrrX/1a8y2iXYgRCgavmvfVGySJiSug6rQw8zRJ01bJvvzVH3MDQM/GywZfEtQhTTX3au2r2VPS0PzGY1B66axzqrt9lG+Rehyt4zRKiPnoNQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164759; c=relaxed/simple;
	bh=+7SJyvNR+bwkzrtljl4I+fgA4l7XyTMgFojqgae6wYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNYriTwHYikIQA+JgMIc60sXWXsBOQcknkeIRiOGbC30sBTVnfPGVBe9wuYyEy2j+iN6qqGz9gT2z4a54Tz7q43U7FPmrkmZy2dYGZXJWcevjdSmlDpagtqbgR2Wk2HyMIiS6k9/6uM8SMFA8zJs692fvHFBZ55rIhwcGJnJJUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUpOku+z; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUpOku+z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba6485d219so6541585ad.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 07:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778164755; cv=none;
        d=google.com; s=arc-20240605;
        b=l0YhCcEHiK20tW7yb+w01seLYguP5NlvHaAW3jxBUXzlL8rHnb2T9f/btSuaMQQxH1
         GnWbVvLrUf0teZg5FFQowOT5A2m5neolBivajwfUmxc3z1U3A6KRByuuBNGOLeCM2QEQ
         dSJ+YeyIi/3B1aOnRH9gTjymfjepxgjcVOgYGxDHgmcZmKSYmD3UDCZQz81anzXRDU8q
         jPWANqJbZ1RKKzUDJvNRTNK4FPojk0hv1wL+lpUasWIwnAEe7Xxd5vWUxlQMTVdrEKv6
         dHrLS+jZC/DuOa2JjpOKTW1m9LxC236/DX9bGGYZMlgzGmFKMdYQjg4LVqYz8bOSkQG0
         tKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6tdHQjfmb5cZPBThIdVSieuwZESLaFAZSPTlf8+eTEc=;
        fh=5Pq1TaQL+Iap9bzMsZFgF02ItY5twbuvu2wZsG6aiIM=;
        b=P7tcB9vJwMg2nNrgjuZFxQ+7wzCIs0wwJVd07ux5ms+4djJjUDk033o+HRrxY0Qqkk
         pc91Pl+dFaaCDMBiTdTZHr5yEYYvfS6sEqR9GScOueXg0wT5pMSm8o5Jz0DE+sgxnAKG
         UJpC7yq14tZ1BGWjf174/UDeuGE8/W7kMfjcLPOs/rqlKKqskFiphM4HJbPQYLGiTXpi
         hXgMljS1RgWxR0ZpSjOYGSSlRQXfFlOhZ439wl9DAHDcTfu75BkAch3d6Eo4lXAq0k/7
         T/6yZ9QIk0PEM2DSGMl61CYdfc+anBtIpSTS9a/tNDyBUnD9kf4Iq2hf4k7pwcNAnjSg
         zPVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778164755; x=1778769555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tdHQjfmb5cZPBThIdVSieuwZESLaFAZSPTlf8+eTEc=;
        b=sUpOku+zuvCPi3T2ZsfUhIGVxVLMS6jLCtxELJPwg2/s4SlYoa5VHDPOPWds4LqVoC
         CAC4SbQSPLg2yJ7BdNXPnp19tQdCErgWu/UZxdZUzQa/4S/6Uwz4Gl4sywXGVcCvkmxo
         4TP/YmXSYQ0jmj5ypei2JkCeZ79b/8Pp22PAn13CMpqsKfoVp4HarhetbqNJV3OZsDNt
         LcAK7mEvnuI2xDfczDpdXPtaGEfO/aP4dgTkWAM7304tZvtIesiIMJClIa+dFw2uKb3o
         HnL35DPADb2ofVml4jtX5NtQSNJwhsAoJ4mhcbE3ZhNdbYaFe4o+1hfv47mDlsRGZAYM
         672w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164755; x=1778769555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tdHQjfmb5cZPBThIdVSieuwZESLaFAZSPTlf8+eTEc=;
        b=VRHwfjG/44YRmw/zH3lPlmgf8FxsJSz7Iv70xRtupC07C/NNJ7Io7R7TT3Wj46ynMA
         KqDVRFignjGCWN0AAdf4jr4GXkCOQBtuuijpzjBIvIElpUE0BJecmHQmOl6dkp6mFnfd
         yhRyoiMkzNA+Haf8AlV4XtnTkQU2xXbLn7ot57i0EWn6IrNa+UqbJ4ZQ/irGGs9Gj2bv
         uLU1bUa907P4xtw6OSkj5tfbhMIcseHmRvVLW2mQIWVVO7gwSrV+xJiqOPxLc1LzegH8
         CpBlIoqTkW0Fc38KoD3lkknaRykdNpsiMXScQ0WhPt4r9b3MzihtJl5hEyl8U+Lr92KE
         Ucng==
X-Forwarded-Encrypted: i=1; AFNElJ9kelpEY09Ni5VsgzGJOUI5rEdMDL+7NDce5oCXU23hhqmsLky3YKxhGIUGoS3R13Xv4m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dh7wLqCs4VIMkGlknb2BsDhOve64ZyIDRQma8LDYlZjsx78T
	q17NFRw2l1QqXooO3fKT85WwAX0ma9YHR6h2/OBIi4sTXoA7W4a84ljZcIVMlCXB+MWQXSjIeXk
	UTCCNB7TCCjW9TNxW0CJT2OD4iIXONH4=
X-Gm-Gg: AeBDietwx68mHulyuHOLGpohVS9FaFu6EU+9BGefFk3RLvq41NXg9phawhyprwc1Osr
	f0n6Uv5l6WWmYvCq+aDI+Xh4l5JHkiBz/UeE/yL8RNgYA8wG6v/SDJrbNhqgPZm0n5UEfDrONip
	nI0YCSVYcJ794HXOTk8fEIGHbwhYufejy/GVKBiyiVHPM+ee5Qq9oSN+MQfOgFwrW/hkhNDeqlg
	52o7gO7Ltgdla7Uq+xeo2/FlgUWswccN7M4qaOcODmk7w8H7P7Qhcx1eb9KoOM6nmIGric1McBe
	XRMKFFMCIAAH/FUtOJYeQUL9QyYnzNA9U2E6YOfGKrHEkIwSl4S/ZLpe9UucvtQZ3Z998mPAJoY
	9+3DHgj4qdnqdL24=
X-Received: by 2002:a17:902:ef11:b0:2ba:60a:3108 with SMTP id
 d9443c01a7336-2ba79bfcbe3mr81344485ad.34.1778164754832; Thu, 07 May 2026
 07:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506235459.529862-1-javierbassi@gmail.com> <e640ac2d-9e46-4f1e-9aef-deac80c65361@gmail.com>
In-Reply-To: <e640ac2d-9e46-4f1e-9aef-deac80c65361@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 7 May 2026 10:39:03 -0400
X-Gm-Features: AVHnY4JLa_ehJy1VJh64jCLz2crOl1B5nzPPsirzwK7aYf7nkypiL-wy901XZv4
Message-ID: <CALnO6CCsOMyLxAhGW10L4duaahUORwedfmtdpY3zDGpQcZoP2Q@mail.gmail.com>
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with --word-diff
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Javier Bassi <javierbassi@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>, 
	Rene Scharfe <l.s.r@web.de>, Elijah Newren <newren@gmail.com>, Ruben Justo <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 9:28=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Javier
>
> On 07/05/2026 00:54, Javier Bassi wrote:
> > When using `git add --patch`, reviewing changes in long lines can be
> > difficult with the default line-based diff. This is particularly
> > noticeable in formats such as JSONP, CSV, LaTeX, Markdown, or other
> > plain text where small inline edits can be hard to spot.
> >
> > Added `w - print the current hunk with word-diff` during hunk selection
> > to re-display the current hunk using `--word-diff`. This provides a
> > clearer inline view of changes without modifying the hunk or affecting
> > how patches are applied or staged.
>
> I think this is useful. While one can set interactive.diffFilter to
> highlight intraline differences with "diff-highlight" or "delta" they do
> not cope well if the text has been reflowed.

I concur, though I wonder what other diff options would be useful. I
can imagine a world where "add --patch" allows to reshow the patch
with any set of custom options. Spitballing=E2=80=A6

     :show <opts>

=E2=80=A6could work, since we have room to allow long-form commands still.
This could be extended to arbitrary git-* commands, and ":!cmd" could
be used for shelling out.

(Can you tell I use Vim?)

Anyway, what I like about this is we don't have to worry about running
out of (or thinking up new mnemonics for) single letters for different
combinations of diff options, so it's a bit more extensible.

> I think the approach of using the current hunk text, rather than running
> "git diff --diff-words" is sensible because it works correctly if the
> user has edited the hunk and it makes it easy to handle hunks that have
> been split. It would be good to propagate the filename when creating the
> filespec so that we use the correct word diff regex for the file. We
> should also propagate the context and inter-hunk context settings from
> struct interactive_options. It would also be a good idea to reuse the
> hunk header from the unified diff so that the line numbers and hunk
> fragment are correct.
>
> Thanks
>
> Phillip


--=20
D. Ben Knoble
