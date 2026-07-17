Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9B42A16A
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299273; cv=pass; b=AHM5vuP89HOJvou/o1EbxoznY6iJF4+ZeNWzfQQl94nkde1POAiA9HaEYP9DOWtjvJZlrtO43ZonsoQPXd6LsC5n2uJn8qaHcZTHS/Tg09Jq0ray5L6U8Sm1vjLmyck5IVrdosyQhZah+kEQ4QojG6lsfxSBKFozNOgmCpZcS4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299273; c=relaxed/simple;
	bh=AMvxbJ0vgIkd5V2rG0fnUCdZmled2sFwEjFL/9SNmNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZMFa3nlRG5llOAPGa6HuvXl7OjZJs782hh5NoY8OFstWZdrI7oTmmO40g7sDOy075ypexAa1qjax9cHbDLyKB7NwF+vmAGyG2Jq4V4y4HFis+Xbu92luXIIMUfnQKbyvC0qToo5NbOBcvTITdZvJ/M3OIvmjFnC9N88b0UwUIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fygxOfuR; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fygxOfuR"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b159850b16so4176405e87.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 07:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784299268; cv=none;
        d=google.com; s=arc-20260327;
        b=mHEOAX1e9bt+oWNZpUO8OdCYwyEoqI5DOiMcF8xcl0tLczIJZVpK9pBnk+T1mqhNRz
         vtdxzRdIgIqOeRHYmktUWZ+5iyMF9WWJyEDweCc9l2Pk6yNSE37AxIb5oNP+TPyRI6Px
         vshuXKKSZGNE3lHa/h/IIDe/eMDP/mdqU8Hs3jiH3fTms9+TMEeGm35oX6cmTDbc11Jl
         J8WHr4kgdOk6G9SfrKD37fOY0PU23+3b1NwswD3xXXKXQRYiKQTA0/Y2cEDS6jZkkrrr
         l788BSWankPtOI4UYOfT3YDTEmULvvNWTBNh720tjRxE9LsBmtqV5oPm0zR1B8g+rEqS
         MC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AMvxbJ0vgIkd5V2rG0fnUCdZmled2sFwEjFL/9SNmNw=;
        fh=xGN3jb5xj+uMQ8TCNIXv8ah1HXk04mTu+GiZC+hpVog=;
        b=kR1PBXeLlvWn6SXGV+UJSTJ4XG+qADlC/MIBhuLDYz64hUyMrl3EKM7IY7kC+0mEsF
         t0eBvvPjcctR1ZbiJZIsUtVKpFHrS57CDaNrriUIS/ut0+Nw7xF2DGmRjixb0YE8rgfU
         DaaeiNjBAldNzjl+8g7AsQuG1FwvaR70zguje4u3dgNaZf1/+r0TTjeZguLM9IRYIipJ
         AZGVCFXGn7C5Kakvpp9eTSrTjZ4K5ddFGsTPaulzYqJwuBQ7UUw8BABz3OhLzdPJCQl7
         mQ1B5xTJ1mL2Y16m3xl/XPDiVSJkBouXlC7PNZmjce19YfCf5xnY4jryYq2e2ygH+xX+
         fq1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784299268; x=1784904068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AMvxbJ0vgIkd5V2rG0fnUCdZmled2sFwEjFL/9SNmNw=;
        b=fygxOfuROyPIqLBGlrmMVk3wOv5aOF6aUw1hvDDTaYBR+zTuNB+8abc7dWjL5jEfEP
         U7Jpt7KhYDmq7vr6fQUXoH58QE696le0aNXFxuyUFY6vsF/mw5jXBYlMge6vo8wFDPU7
         eRuapfPq2rG2uI6R1Q2w1X8kMPblGpBM54SO4qIyx0JZ4tan4JZTHXHvG0FG42vuvoIy
         y0NSNtpamYWevhykagkQLtUikBRSC8oRWzdVm/8lq02NWO5D3vhl1uZHxw0Ap1i09K7s
         6Utx+7L0rBVi2zjEXNh+fG8+exL9MvBRhzJXL+CP0hPGo7d1kr7ymuepkj3OOKWN4zst
         3qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299268; x=1784904068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMvxbJ0vgIkd5V2rG0fnUCdZmled2sFwEjFL/9SNmNw=;
        b=j9wBndKGw4ohpv5mZjQ9iVrjfJOZBikvlH2lelJQkuACrUQdFY9vyohTtbXeMxW36Q
         5Ibyihh/GOEH3ahU0gUZaYPWTKz2Nr7D5zsSTaX20LpXlELu96jZoEvDJSbNwnaFUoLz
         zxXfpgCklaoNXdL9kHXCTfrIuSg2YJofDROM5MK6Oi8N+Bp3J6+V6EVGGgY6l0e2LcKG
         Fksr72LRDi+XqLyrg4hfpyGR0dtYOQvVRNWgI5Qg2U5JkqTOz4dM3ZFSHQISecVITYJ7
         uD6Ycau6Gz93TCwl/PsP+jRmHSoIDzuSSpAY4YHgzXmixHoNibQcjY8wrCbybJO1c4V6
         Oc7w==
X-Forwarded-Encrypted: i=1; AHgh+RphT8+hPF/UnDrtfLtTp/X9m5jiiUBZMeZAJ0O0NmXcfnkBwf/g5ZImaaM06A1qatMyAPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUAqlloqPpAK4VnlZhclS73/PPLXiqIfXe3EVz5Lj8XMwIU94
	92HyA5F8esVhUk1ernTcJ3TN+EwToffVQh35Bu9rlT3v5S1KMNxfxHWo2I3ks7ktN0cUYZuluh4
	/+HS/WmnWbOWaBnhGyb8PR7lYrDpp3NjhnFEKvmQ=
X-Gm-Gg: AfdE7ck20BQj+NNWsObyWhxX5wkh67Zv12gRUypPBy97RUjko2SIGigPLs2/xEux3PI
	VQHyp4nRaDzYN3tjTqkGFOBjX7wMWiLwjkmbNj6wFxVNebQZ3rD0Qj82k4zUjIyv82abrG8O5Wj
	Ypah3YsLnJOmLhz/nT2pRasj3KUZ+/45ziEPcOoqGn5UbILTxiiF9Pvp6UUv7FDQ92YO05hr5bd
	gUSwiHSENOZm7eWIAU5xmkq/G6Ndc3FmlCxD75Y1OiZkFsDZVkbnb/iwh1EaV6lBKr6Jo+dlU1v
	btl7qsCR2pyt/ej9zjI=
X-Received: by 2002:ac2:50a9:0:b0:5ae:bcf7:a741 with SMTP id
 2adb3069b0e04-5b28f878afcmr494455e87.18.1784299268110; Fri, 17 Jul 2026
 07:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716185045.229320-1-sahityajb@gmail.com> <alnLPSnOt_Sf7cA5@pks.im>
 <20260717075449.GA1832790@coredump.intra.peff.net>
In-Reply-To: <20260717075449.GA1832790@coredump.intra.peff.net>
From: Sahitya Chandra <sahityajb@gmail.com>
Date: Fri, 17 Jul 2026 20:10:55 +0530
X-Gm-Features: AUfX_mzDjmZ3QFDuW-tBM8dhk2-O9S01SpjTSDnhjZcqzW2xnrvHAVdI86Bng4k
Message-ID: <CAP=WS+uWJJ3MY9K3JX-PQo_pKimNtyCO_fTdFsA=AXqbzO-bLg@mail.gmail.com>
Subject: Re: [PATCH] wt-status: avoid quadratic insertion for untracked paths
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com, 
	stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:24=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> Yeah, I had the same question, and tried for a moment to produce an
> example before realizing that it probably is theoretical. If we are
> feeding the entries in pre-sorted order then the insert is always O(1).
>
> I think it's still worth doing this, though, as it makes the result much
> more obvious to analyze. I think it could even be O(n) if the sort
> implementation is optimized under the hood for pre-sorted inputs.

Thanks, that makes sense. I updated v2 to avoid claiming this is a
current O(n^2) problem and instead frame it as making the append, sort,
and deduplicate steps explicit.

I also switched to string_list_sort_u() as Patrick suggested.
