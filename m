Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308838;
	b=Cm18u1Adck1XiXfyjm1W35YKW5xinmszmp1pTCHUwdzFBu1NLRMa9OJN92B17EYmY7rV
	 qWkKKn2ZhAoOH/bTE5trqZx4cTe1JnfCALbe8vjh29YUb4I0FYKMLPfiEAyGMwT2Is1ZU
	 qehuwpFFZwgwwD7XCpHDfCje+234OCqD+ZTmAL/eKM6GjyzOveTjProup6IxISSpZUxkA
	 WtUqoeBBw/lpYHK241at42rnSCyR29vIOJhmJtJWRk6r9KzIRqNfyIinSbUoegvYb6MM8
	 rQY+GZVCQmyS46Q6kPnviL0siwLM013qUZGvbrzNHy+k1F+E1YhvbRPMO5Xp6hXhHJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RZlVVghsARSJ3budySc9Tk3exls/qVV9TTbgx3rntEE=;
	b=cioTwnVVW6OCjdMj9/22Jz9M3ak2tjWLdlz0AihlWnbmBWAMHwG4+3Hs7IPhSeRQJvns
	 V7B/A3DLtfd78WglClqHR/43pGdT3rgoJsdaS9jDNgsxJHs/4SLyA+NYZ6ZfUo4tBZhf8
	 bG8QP1RYvpC8sbHJ7SvQXjAQcrchzt6yFwgg1qYVSZo+SKTiQzDaIlKJCpjevEKDvtFry
	 GOrGE1GeNV0wsIM4SwqX4aJ3wuGZEXm67l+sqjUYhbgIeDFnp3Clt7UIQH5kBAYJaJXdN
	 vhnpernDjVdynYYG/hCwNBjWBQo1CtXCJdgi4klASm/k45pPzDSC8Yc1rU3VE0Xn8Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdD5EGzW;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062D606A324
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 21:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F062D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdD5EGzW
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-84a248254f4so89288a34.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793308837; x=1793913637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RZlVVghsARSJ3budySc9Tk3exls/qVV9TTbgx3rntEE=;
        b=mdD5EGzWl7uPFya1mD+x9g8C+wqBoX3j7jZgGhofGO3Ht9E09BKXnCgHzdyQU705pB
         xZZ457AUmHvmgto7PWEID0XRJtxm6bnjgRaF0kJI1/jNQbBz3U2V5BWmwu4yg5KofdGE
         kWowQdsVcwchxjQpv94ZIO5b4iDIRoZLTWdOlXPKsY2vzrRmN13ZPgMoZKaKEkyuL/y2
         KjSlYpY31L11mj0W5bRcbDS/IK3Jo8XS2pmKgYhxEItkeYatHFQl01qMeChGoB8fUx9V
         +XKyBFbjpI25KD19XJxRoawMzwr63DJj6nWVWS/Z1LLpwIcELD77h79cxZ0VjHYlC/Us
         gapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308837; x=1793913637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZlVVghsARSJ3budySc9Tk3exls/qVV9TTbgx3rntEE=;
        b=cEvnNIc3lkS/gz9bvdERBQ59svXd+i5CrLw3L7HEUmFZxy0CZfcu4J3KCOXv8P5w0x
         keRqM2DtDArIA4rhPFdrsFrXnVuwuDLU8GDa+jPH/TLoScW6yco7bcX9u2aObh4lnSRh
         0GrfZdO0DlATZuZGOJDoBT2PmmxbOTh1cvgZS1xRBjO+QQ/UYPX75LtKoo6adaGDSSOP
         LirI8J7URUcfeFUpjMkkWCJyw3i0p5oAoxpnqA/0IIWIciQb+SSDaTfLmfAJLKXVIT8k
         i0jwI7XdpM0/cgFJVGoIRnU9MxRwup2hbV4XeDwBHTvvwsTw73uMXLhd0Tjl+TD0ilOU
         D+Uw==
X-Gm-Message-State: AFq9FYJhQ1eftR3e4Tl0xG2RhbEQd11KtRr2ouYbWpV4keSZp32HORkS
	/GI1watDOg4N+jDaX88N5s300gJdw41QjcSgDl8NYDQ+ypOmO6Z7muphDZbuAw==
X-Gm-Gg: AYBFou3wmXSv5NaMe/GM5kz+mFKwtnnBSMlR3GKMwO/79pEgUw4iBrzzZ8EUZaRI3DS
	DW/XfGpPtraM6d21VipqZCJF/KVzLGOrxzesH7p7zmyJIxhP86Zx/Gp63josrTesAhpBtduo0B5
	peZp+JR/ypBswDYXT5XPfGuknnaUpjklxxpMfD1KtpbMi984DIkPMjFeyzGeKAPdqjdlpf8xXSs
	mqaAHMjVlalk+LkswnXNLbRBkdqmB0XNihk5l2zrm1VI+OTMr9hoiSgT/n0gXgDB7xT3y0uZTfi
	0sCnQRGbkHFSFq8AD3ORvsWfDxMofkNQpF0Skduuf6L6xAadpumkakTiJ28WzYj40f5TC65UeqE
	eYOJLfUKN9T+AGIxz5pFPvAD5JG9kqOn/pO01Wki+IpMYfyj+e0tEa/FqhSlhtYZoqdTh49Ueu7
	0RIXgJg4YFIihTFaqySQq4NitWghXP26S0SpUY2KAVtbL920hl5JX9SOcWVSjuccqPI02BFF3ZL
	DBgBj2rpK5kTjxw8PHg9bh+JPLly617XKEXugq8a+/0Pd8MVbdYWa4C1+fGenCHS1HbwbVndPsN
	13vdJmuNWP0igvOD5XEodz9pGqmGuCiHu6skfo9NpJ4kOTx015wxbwjsP4sCmx899oyhnUqF2FY
	=
X-Received: by 2002:a05:6830:2b0d:b0:80c:d34f:5f61 with SMTP id 46e09a7af769-85d36484c70mr368718a34.26.1793308836895;
        Thu, 29 Oct 2026 14:20:36 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985b2sm510464a34.11.2026.10.29.14.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:20:36 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:20:35 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tmp-objdir: merge loose object index when
 migrating tmpdir
Message-ID: <auO4Photxmne1R5Z@denethor>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029002413.3291184-5-jltobler@gmail.com>
 <auL-ZBontaECu8vo@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auL-ZBontaECu8vo@pks.im>

On 26/10/29 09:05AM, Patrick Steinhardt wrote:
> On Wed, Oct 28, 2026 at 07:24:13PM -0500, Justin Tobler wrote:
> > +	if (loose_object_map_read(repo, dst, map, NULL) < 0) {
> > +		ret = error(_("unable to read loose object index %s"), dst);
> > +		goto out;
> > +	}
> > +
> > +	if (loose_object_map_read(repo, src, map, NULL) < 0) {
> > +		ret = error(_("unable to read loose object index %s"), src);
> > +		goto out;
> > +	}
> 
> It makes sense that we read `dst` under the lock so that we don't risk
> losing data that a concurrent process writes into it. But to minimize
> the critical section, can't we move `src` out of it and read it before
> we lock?

Ya good point. The src file can be read prior to acquiring the lock.
Will update.

> > diff --git a/loose.h b/loose.h
> > index ed663ac550..35b46f4be5 100644
> > --- a/loose.h
> > +++ b/loose.h
> > @@ -23,5 +23,7 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
> >  			      const struct object_id *compat_oid);
> >  int repo_read_loose_object_map(struct repository *repo);
> >  int repo_write_loose_object_map(struct repository *repo);
> > +int loose_object_idx_merge(struct repository *repo, const char *src,
> > +			   const char *dst);
> 
> Do we maybe want to add a comment to this new function?

Will do!

Thanks,
-Justin
