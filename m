Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FC4F898
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JOmJTTJP"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7831806c527so396654085a.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704925527; x=1705530327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkw1ZcHPuwSwja+y0s89lvIunM/aRf5Pf7GDPF5KP4g=;
        b=JOmJTTJPdgiYt43FFBNfdykecARNXExLyoIywnxyPvQHGuTZqiHYWvg7NriOogJRPB
         0CrfE6jkUlaSTxa8+rXOPNXdZ6bVc9EaYKjqTRR75H2J2+39DerElbMd9ABvKLW1IcV0
         7SykCaNFhZKPR6xBg54VDwi9GySqzV5o2NK6Aq6441omSvBJ/q/abUJMe1VYrOhq980h
         Kz1J1OFrQdo+I61KaNsv0pjyef9aY2B7VDskoEU/KOIE+jAicLUVGuDPxqgik8fCbF8Q
         sk67r96aAd9wmVucbmQW/E41xpbmExre82jznwM5lHlyocOZvGVh33e3o3XDZ8oPLqOi
         wGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925527; x=1705530327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkw1ZcHPuwSwja+y0s89lvIunM/aRf5Pf7GDPF5KP4g=;
        b=sxkfN8yf/o7FGfF6ZLUmlAf2r64QeeeRNuaOm0bGLqDGbJoDCd4FkJj433WyLlt8Il
         JjpTfFgxsGoxMhGybO0uZpwyyg8OaJa8Lc0hLYDuAADyv6Flv8j26G6H0T+th4xduf0A
         pe3OiUiRcnHzpqdizlBNrEcy7EBmMo2uKcVcF+UmPglL6qxpr1NKL7K7W/BGBeTWcB3F
         1z2IGYPN1XKfp8Ym+FIiEXMVSHgVNj94Oqbb6a3PXbzNgYMtM0iS4CtrYCa0CjyK0Jg3
         YEHY937EcF6yoDMj60acTCdFjP854gh5EUYC6zZCjfpnDoKWHQ6hG0TiUhUpjTvzW5xh
         pn7A==
X-Gm-Message-State: AOJu0Yxk5IoIoUarBDHEP64RmH/C8Wiu+a6XIXLkTD/9Ud2A7vdBE1b7
	s+c5G4qReaQcLeFWBPOxYS6sGs34+f4MWw==
X-Google-Smtp-Source: AGHT+IGAbA4yzBcHBohPTYvtZIZqKu5tZFLb520MTOMq0rtM6+k0ZBccsn9/oxwlsqBFHSzoGHEMgA==
X-Received: by 2002:a05:620a:a90:b0:783:3ed0:ffb7 with SMTP id v16-20020a05620a0a9000b007833ed0ffb7mr96919qkg.148.1704925527227;
        Wed, 10 Jan 2024 14:25:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u23-20020a05620a023700b007811b8e3ff5sm1900236qkm.48.2024.01.10.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:25:26 -0800 (PST)
Date: Wed, 10 Jan 2024 17:25:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5309: run expected-to-fail `index-pack`s with
 `--threads=1`
Message-ID: <ZZ8ZTAj3E8eGJvDR@nand.local>
References: <ZZ7VEVXSg1T8ZkIK@nand.local>
 <588de2e4f16ab090ff477088084e0b81d9615ec5.1704909216.git.me@ttaylorr.com>
 <xmqqfrz496ib.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrz496ib.fsf@gitster.g>

On Wed, Jan 10, 2024 at 02:18:52PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But that requires us to tweak production code (albeit at a negligible
> > cost) in order to appease LSan in this narrow circumstance. Another
> > approach is to simply run these expected-to-fail `index-pack`
> > invocations with `--threads=1` so that we bypass the above issue
> > entirely.
>
> But of course, multi-threaded operation that production folks use
> will not be tested at all with the alternative.

Just the ones that we expect to fail *and* are in test scripts which are
marked as leak-free.

> > The downside of that approach is that the test doesn't match our
> > production code as well as it did before (where we might have run those
> > same `index-pack` invocations with >1 thread, depending on how many CPUs
> > the testing machine has). The risk there is that we might miss a
> > regression that would leave us in an inconsistent state. But that feels
> > rather unlikely in practice, and there are many other tests related to
> > `index-pack` in the suite.
>
> As long as "make sure we spawn all of them atmically" has negligible
> downside, I'd rather take that approach. Buying predictability with
> minimum cost is quite attractive.

Like I said earlier, I have no strong preference between either
approach. If you want to pick up Peff's patch instead of these five,
that is fine with me :-).

Thanks,
Taylor
