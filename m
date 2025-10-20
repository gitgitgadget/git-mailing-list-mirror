Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E532F748
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986938; cv=none; b=C6/M+dGh+cBvfOCDE4TIlzJDKkGwxFTZRiNJHgPwaK3+lz0D5Qs8rVI3WNEJKmMKi8sEfD+i9tLZj4Ke9kYzXDrnxKtvVjjQ6lqeqpQ6fGEBLev7AsL6l15/7V+iHCFxTEieCHadIBGVQuv1eQMYfjgx6eyhZxexgbuwQpjeB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986938; c=relaxed/simple;
	bh=AHs8fG4Wu6N7EJ9cejqAsW7By8t2EufaeXNiGV22bJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7+7Z8rpckxFg4ZfQnhC8mQQzA217Wl6XirJlIMf7pvc/LGTpBWi7RLiwFEROJVDJGOm1v8lXC1PGgXrlK68k9a/IN/CfMxh5L2LPkuB8XR/466nczJiFiwL9jofEwTBgmfdNGG/GeJky8AVfJ4ymeL7plnLpakGPfcU7XRjCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCiVW53b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCiVW53b"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d3540a43fso50438375ad.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760986936; x=1761591736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UB2bjIXx34K/8dZRF1KLs143vBmXI3/PbgH83EApoIQ=;
        b=hCiVW53b0kSNId+xiofBogesWFryY0c2p+Q8b6+YMGyFRnwvlT3LrW3Yd3LQEFhle5
         YcuTJFFU5otIVGnaqpk2gE6yE8f2EkQdQq6ODJ/lUI3m3n58at2s4gYSGwlWCjkJ/Tjf
         oD7CpnCkXXMri6H0fR31uPrNwdCrEJpaPCpd4gjXzncN6h7wwR81j7M3iHvix/2B4hLd
         DAlzf5ISyQ+ShwkYemLlDgbn8zjh7KHal0eKzc7Q1DC2Rlf5n6KxxkQTexDDLse5iglM
         ZiDxAiXpiJMZiunDgqZ3kUV/z7Y6g6x+5Apcz6aJrtyrS6Vpf6XZx+9at1x1+uHj2WUK
         yXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760986936; x=1761591736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UB2bjIXx34K/8dZRF1KLs143vBmXI3/PbgH83EApoIQ=;
        b=W5ohXocGqOipRtr+/KzLd40cO8xJl2bv8748fwbn/cqW9PkcFknAeDdbw0oWU/s09U
         Th8GojcweISSI6DGNZEkEa+02nvMhBOyEHfAC3APK69ZBOChui7YTxc3m01BZhy86tqA
         fLb7O2QA1kf7vdv+WdkzGR9kO7EmYZx0jDTtbSkF8Y69zo4DW5K1r+e4P4Kk+zulxulG
         lDvj6erLdJU7VDvvreBmk8GC56QJlJrToWkzb1oXjz2qZQXLFdeFo6ecuUjx8jMVh9Ht
         yPkO3/qCEUqk1X0xuOAqq5C7t+FIESNW0n1GYnetCCeD1z05EI7AOK6f5P4MIEojqX3/
         LBrQ==
X-Gm-Message-State: AOJu0YwKWqsN/L3E6v+N5nNV0/nVH855uw+G/nutqK09YgyOb+IsA//7
	3dIU8YIeJ31gCTpkWsj6rAU7BaVqSBXlvrSQb8cVdCaH/8Ow9hQFlN2q/uM2ndcQ8JWNEPSfmV+
	0RPwSprFmqURNmFHp3JvKI/8cC1akc0Y=
X-Gm-Gg: ASbGncsTy5wFCj8O6iYQWjB21soKeIoeJoK4SuScpahhhoIpxUGt78hjPVYiYGq8c30
	j7seQSDa2kOmauOGdy4quaL1NVc4BqbnZ9RHhvKdZugI8yogT85OUIgILiAnXSg3wjV4s4cFL7R
	Ezo9JkhBSZApoD39nBEmCDQCEfiZDsI3sEA6igPdJjZygF4wqX/wbORQe8/z218UIBOVq4opmVH
	6bbmN7ceOzV3kamtfFVg+euNLHMrKpSO7VkBTCX8QtZawc3RhF/lvNXyGXVZQ==
X-Google-Smtp-Source: AGHT+IHskFNDzmbWlQimxm41VCNVYyCIFVMg2aGaHpfy23pCfnR8TWBuraRDujvSkbfL/2NN7MtXbCYQujEBq2GJjXY=
X-Received: by 2002:a17:903:98c:b0:27c:a35a:1321 with SMTP id
 d9443c01a7336-290cb661ad5mr142178025ad.51.1760986936342; Mon, 20 Oct 2025
 12:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760869186.git.belkid98@gmail.com> <9a6eb6ff8b92a94de990303cc78026029a669cf8.1760869186.git.belkid98@gmail.com>
 <xmqqikga3mqj.fsf@gitster.g> <CAD=f0L9Bu2xcOt98n_iB6Td2+pdniOP-wU_KyigJdt+3Oy3wxw@mail.gmail.com>
 <xmqq1pmx38lu.fsf@gitster.g>
In-Reply-To: <xmqq1pmx38lu.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 20 Oct 2025 20:02:17 +0100
X-Gm-Features: AS18NWBtzvfFwrlR2iCRo4v-_YEDP6hMrGjsJ_1DCqHRNBX74WvWL8fc_TkuPZQ
Message-ID: <CAD=f0L_9Rx=DjiZdbmTATNPd5h2CtC3io+z7_0TFMAtA8b7OVA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 2/2] gpg-interface: use string_list_split*()
 instead of strbuf_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 16:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Bello Olamide <belkid98@gmail.com> writes:
>
> > I am just asking to know if something like this
> > should be done within the respective functions or I will need
> > to write functions for each and just call here.
>
> Unlike [1/2] that asked for the second string, this one just wants
> to discard everything after the first LF, so I am not sure if you
> need any new helper or hand-rolled loop.  Wouldn't strchr() and
> xmemdupz() that were used in my response to [1/2] sufficient for the
> purpose of this step, too?
>

Yes it will,
Thank you very much Junio.
I will send the new patch

Bello
