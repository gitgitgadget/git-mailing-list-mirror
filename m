Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A0395ADB
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215607; cv=pass; b=VXazKv66doZCDCR+UHDadA6znHiYFCoxhrn2IyuaXvmyfRzFhOwXem4yua8z2MH+wjvCXvdWYdJaqrbQEQbZL3+KyxAma032Ev2jJwJ5Qcvxq77ryV/uZU349PAakEMcMy92PelpRI/2OYzqpZ1O55OdOpT9fDw6WdbYFpuLhKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215607; c=relaxed/simple;
	bh=tkhbiAP1st8+d7w3FJIwRB7AVt/XdElYkgo+D2D/tD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzyK0AMHnI+TRP7rHdnIZrGxu7wx+uYbeEJx8/AhjfmQAbXYThJ+B9BxhgOIUsEto6CJSvkVJEpLAatYU7AP5xCWSThSbumy6OA7RAYnlouYTINuFxoekdez3Dq82K6QU6ZEjc31wlqMN07fKuc+eDRH6wfVRfu0Acm8wy9Fi4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxpONRVb; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxpONRVb"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so826197a12.2
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 12:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786215604; cv=none;
        d=google.com; s=arc-20260327;
        b=HCxQBRoXT7FYeG173S0VgrcnobvQ93RWcUtvjWyKr7kvYWoE616VIqzLlPZxLtX2P/
         P5n9cYYHbVYuX0sh71xBSOIe/hpNdBPOH9r0iEoSGvB5yFExvhDEy0dzRVo58C8D6MjE
         DSoK6EOL/p2dIo62NR478iu/zY7OMeiYO2KG6OrIoW+n+TFSLL1/CtYFSws/028Z9aNB
         XrPmsMXswC+Gag1R97kmBIywOwue9/HhqVgON0oT5XXO6fP/fjFffBQ3HLLQhqxhIUBE
         Vjx26+wUpJdg39M83lqUTVoaorNsdhrdinqmFBGtVAV5fxvrj+SYCZ7fUY98f9KD1xbi
         YJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tkhbiAP1st8+d7w3FJIwRB7AVt/XdElYkgo+D2D/tD0=;
        fh=Qj4/ypmBc1c0Yz/RsEW2kJ5lh9qNYkks9i7GTZKNGb8=;
        b=g1hragjztGbSPkqOCBJ7x6Z3LzrBrweZskN0q+dHGlI7WynTnspl/FJ6A6zZDk5KPX
         7UPHtWYwc7ZNHA+tQVxV60zf+WL5VJzAaHDkHYJKbRG4BDueSSYAI9WyPYZUm+Cjfnuz
         aD0xYX2EfdofwHRdErTyjnU+8+LvE2XE7UsL/szAnguf3q16/fidj0xO0WZSwRWfEoAp
         valFAYeiMLibDs+MkkTQExQsJuKiMdgUaEDP3NX/px7eMrcrt1tVG8+ONQGmAEavwQTt
         ttHa1KZOpOuDmJCBOn/r8bxTbiIflN4kWqcB46jwcXDwKw1uhKZkATqdcXW2Ajjrd57/
         eIiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786215604; x=1786820404; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkhbiAP1st8+d7w3FJIwRB7AVt/XdElYkgo+D2D/tD0=;
        b=HxpONRVb3/EH1qsDCGi+HJJ57NYUAZXDWfcZclRiFKYdBe0RihpF5iQzeRbcfoJe/0
         qu05gb9nmNOv0gAvLKr61KQHxH4sFhACYg2ZF96dI3QYYvSwMougNHopa0mITMGDYio5
         eAUSDqXR3gvJ8RwQnb0ozfZy1TUrL5qZqrLz4Dw+y7zfk4dRuK3z4VmEpaYn257nVYll
         APiwy3e9mYPx7qcdOnpjihGncODFqypEeE4gv15Mvn2OgAB0bAftG4whF3Nmma94S33d
         MMJqqMQh6/iFz6UoyIoF9RnEUV48SOGMtBg0Dwx8i9vLN7XOZdeFlz9riJC4M5RzPDcK
         H4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786215604; x=1786820404;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tkhbiAP1st8+d7w3FJIwRB7AVt/XdElYkgo+D2D/tD0=;
        b=GyztPEqCr4GmdZyChHFbsB4EfEwHoic11Pzb52DyOuItmNtlsrnzpqmi8X7/U2wlTV
         ID5czWCH1TbSgXTN2yPPTNEgKfw6NZ0ISlcB9XALzTYgXexoum4MIcIzx9NWDlp1jg2m
         +go9nNHNNwCMFol5Zbj4Q9n6PlcEL+/cF66Euono2smEesvQq6eEUumguLqVu6b8mBUq
         iXGo57cmMjRFqgFjxYLNczoWAxG0O2QGE4WjfK05w13Xm+qv3GVop9DuwNyCVGz4HpYA
         U5HNEUFQPzIU+eL89f+ZojUlbQnqjayuwWrYCUTOFiOxyiYol//5Ovp3luGUMhmURDZ3
         RZ3A==
X-Forwarded-Encrypted: i=1; AHgh+Rr8c0+Vs3HfHsVjAbACAkrcYJyDhYdR6vFHDExmYQ1N4E4wYdom7Jdt77xJRXMSEMsok0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVJdjaz5LPCpEAMCSAlttZqYo8zvR1zwFjPqOvbsy7siyDVR/
	0FSDvnojQmgkZcVH2XNx5xf793Ug2e/i2tUxVj2OfJRnQgCcx7W64ELOOmKNnDT44B2GOlzL9bf
	oI1KaBSDN4zxKht5UE2u2eba5pFvX5nPz7Q==
X-Gm-Gg: AR+sD12IWpM2ht4pMKBQ4IBFrC4loQ38U7uEdgvxtE1tWzk3/OVvnP1b4xjmQAwOzAj
	V93J9tB6EqZl/N+ykzWnLbBeW6PapKJCtwpRyKydyXUDqP7GyUbLdEk2JBfgghpGacGJNYEK+PU
	/BWDMpaFtwXvI1TUojNJPwko4EXG5yReMnAFNQi9uRVhzOqC85KCT3Y9NXIv3B7aBP7/zUxVZiw
	R4LIq3VbBiMTkt9PrMjXye7WcURVl1CB0n3RnSAbaqqSWKNj1sSylqU8wmIsgvw6UuVxFCibhIZ
	e17rPnYJ4d3V9MiqW3/d8SzO+vEpIiPuR/UVXFRDIWZw0SU+D8LXGI1H2rC8Iu+7j+MimCSpyO+
	fIm0p7Qfs06kT/6zIXNBPZAuF
X-Received: by 2002:a05:6402:529b:b0:6a1:e4b0:3385 with SMTP id
 4fb4d7f45d1cf-6a1e4b0357emr6249924a12.11.1786215604068; Sat, 08 Aug 2026
 12:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
 <20260808-objecttype-support-v6-6-e5cdaf27a49c@gmail.com> <xmqqmruwbn21.fsf@gitster.g>
In-Reply-To: <xmqqmruwbn21.fsf@gitster.g>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 9 Aug 2026 00:29:38 +0530
X-Gm-Features: AUfX_mw8HWXxdPplbIWwPAUGf5OTEfwX39CXLg_v070hqs66kTpa52hjPBksNS0
Message-ID: <CA+J6zkR5ZkUc8c=xiXgKiAYmbgcoyGfwpgm6aaG0Gog8OVmOjw@mail.gmail.com>
Subject: Re: [PATCH GSoC v6 06/10] transport: drop remote object-info fields
 from transport struct
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Aug 2026 at 21:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > Rather than take these as function parameters, we take only the
> > transport object, and expect the caller to have placed the other two
> > into special fields in the transport struct. But this doesn't make much
> > sense. The set of oids and results are really only valid for one
> > request. There is no reason the transport would need to hang on to them
> > outside of the single function call.
>
> Thanks for injecting some sanity into the mix.
>
> With this fixed, are we happy with the entire series by now?

Just went through the series and everything looks good to me, but I've had
the same opinion for the last couple of iterations as well.

Thanks,
Chandra.
