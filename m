Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792652428;
	b=D1DIh6uK6lTQJgUZE/aDAOhq/9w8b3qi9nIHqixBKvUWRe6J9SR3bs3v4WWzk5xSxGu8
	 K47zytCfMvAjMNAAHEoPRl9jkKMU5ZGqTKdShTWK0zcRR7K0NZ9InuYquWhTrZQYdZ/Ic
	 D+yUjXmZZYDbUlN9Ck5MExq6JO0AeXGIGwEELAIs/IBX7uP/gi+Y4PYaebVb+8Dr9m31z
	 CQ78rJxMkcU1bkWYd+S44MR8FwXFekB3qdGqBb3XlqxN/mDfIHpyR9UAlR5EDiGT+N2sV
	 bhgtK6jNFRTEMSTEz5cvx3JnRhkkKgh1YPQSEOXkWbVFHsNEW9Dl2Ct+CR8xoGwW2eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IjBFKONV7ZsqdkvLBTGiqKiIHg39WDWD7aOlr8ULfv8=;
	b=hpQZOMQ2gWhFaKtNgNdZMzXBVJLqIVGjlTeQsns9tnKgHfa36wBan2p5w3qjU90pyn/7
	 SOeyFc+eQJV8roEJgkTeGxMl+qZl6BFvbEaWzfCUD9hj7wIxEnZfcidKQi3EtyOuWrJZa
	 rogyvGM2f7RpSifMmXXP36rZaXGsBDimtZ1E+ZGaINTBXhVtGtXY76qTFqrgbXAltv2sy
	 UANxAhbIRZFk3DxvddmVy9BdC/luRPrYLd98USDv+a/OfQUAxUuoF+oHyeIovTfszhGqi
	 4O4k3s11gdbcHGVoic3ceELQHWaizJ1TI9aRISlmxkYfjX8//v9cOxsQ5taxvfE1O7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=QJKVdTnL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DB606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F7DB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=QJKVdTnL
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679a420b5afso1496809d50.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 00:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792652426; cv=none;
        d=google.com; s=arc-20260327;
        b=XwPCWub3hlhoDnlWag6nMth9F9uFOlTS3H9aC7NsWPWK8ZQUy2Zl5cuq2J+fd8POZN
         QXBn8qOA0hzPhV4+sNKBpHTpEwHRdbN0eRBkkTJvi+xWs3tB2wsx0Lto0bm8nxiDFBK6
         Ud9l/668nM0mE2PaM6KgHsgifFy4LbN0gRPdWaS4kcHlejZtMOiM4mQYWalZS4gw1LsU
         vVw82DZcNnw/p8G6umVQ21AejnlD0G0IZqZv0yB2jp5NMEtVScVMAIFDSLW5tPFTBQmP
         YSrxt4I0NDNLifyLBHkM5PcrOqPILvV4nHgaZoNz3UQLsID8Pjb1qwsziquNQUy9Zox7
         r2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IjBFKONV7ZsqdkvLBTGiqKiIHg39WDWD7aOlr8ULfv8=;
        fh=BBx69M02wp5I+462ILxJJ45pv0Asgjxki9qmShHYTxk=;
        b=sj7OizEWxEYkJ+MAdWB0TGQoMuBJryY/XWkieoqdyEgq60rKaSyp9AHUEJJPEBHCt+
         wqD9+F4BlkXwxDRT02qRxMQChRW+PiiwVdVPbCgKuCjMFWfSB3zgODsKb8dOWVz7x0vH
         7kSv9syu1M2BiQpDOJi0VNXyr0cOkgV8I7AK7Vp/t/U7EqfFT9Gi6LHFsgXjE5EsMisG
         CBxWEvFiKZh1tiM5Ll6WwQP0NxfIxuM6ba98Vsdr/lqFpg5S+cz1KTIHRwAtJFUV3Rbr
         EQ829Xmch7/YJYivPkuvNd1p9hRRHpg5V/y63UEPZmqPBr2dC1LDBHRd2LqSFqgb9yPf
         8Q2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792652426; x=1793257226; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjBFKONV7ZsqdkvLBTGiqKiIHg39WDWD7aOlr8ULfv8=;
        b=QJKVdTnLjIOGx5rXYXM470JP8leQTPAszVvoQcrK1lFt6whHmeHgJ1aJm96iDVZNar
         ZNhPBxnmRW4AuddmPsMtnE+EIdNKc7JTn7hP5RvTO5wti5muU5JgmQYq8KyuvTS88rwM
         uiWJbGoiOelCV1TdTnKBsFRCavEKNCSXSBAP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652426; x=1793257226;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IjBFKONV7ZsqdkvLBTGiqKiIHg39WDWD7aOlr8ULfv8=;
        b=ZaBFfHBQce8BfY3J7o8T9NXBg0oG96wRcXlm1PK1J7yAQdAWIznzW6LXdqpQEkLj50
         6ymFZLvxUnp5MrWCUIk4zCEdgx3ZF8y85YLRl+XhwcA4CkG2OKu2D8NGj7LfAlFN+Tw+
         83DBIlPb/N1tj4PqzOs08eUp4LRN+0LBZnNu2X4vYx298pAGBO7AcJSKGu00p7UegJlj
         ocVLvlKvXrhneVOKJGdXe4gUvsEd/H5Kg1xuUXLAh79oxrkbUHhq8HYdta/lzncIMIRv
         fS1V3GY0YiK+FX8pzV8856XiQW6nwP6qQklW0Cag6iWb9Dkeh2H6wRJB7RH4mchLEVpw
         PoXQ==
X-Forwarded-Encrypted: i=1; AKwUvByXGGyM78gxZxAM5c3DKMSbMYXyiUN37PtjVzJ9N5e4CeBy68JRdWqZ94nLfIol5lm2WYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIdFLPiPleibY7g9CgewyShsW4dP5swGhaOSVQrzZcDsd0D95W
	Y4CLv6fxeq0XToajFywh1iUEwK3E5yaEK6UmSOVL/gUpMDghidq4rQNODnnx3lc9DAFfUhREnOR
	Ov/Ii4qHZ7aagaUZhanPmjVHwzfQYkx18xEmhRS6FWg==
X-Gm-Gg: AYBFou3GE0IjqI78QF+TZZwy31pgfVMsgv0kljRDhisgI2pOoVK0koQLyX1EAneHFuY
	2lDRZ2IewbtnbD4vz7EH1tgxg2pcDNyCbvlLOpi8dmJCL8wOcz6GmHgGBfk8ub/jp9BG2S+3rbG
	G57QMBg+PQJ1Hk0DCwMLAt7Z34xItyeqT6IIQ15BSLlv5ZAvwHKxIYZNwnI3eJgDtLh+RtQPYyZ
	w6x/IYGLeqCLx/lDgN4JuSaIv6394M4wXI2fsC0KWSkTFlmJLWapPVNGTbmPY8S63tVhaOG0syD
	r6z+BbhCWFAreElcql3UVvCpjBbc48hd0v42JHmKAuCGVYbBib1gf1XqXIHzEsuwjJ9Kxh94re+
	eqAaZ1c/nnjvl8EXCf+wWf0gUF4l09aIMmmJ7dw==
X-Received: by 2002:a05:690e:4854:10b0:679:ab08:5278 with SMTP id
 956f58d0204a3-67a0e4bbf63mr1181309d50.32.1792652423537; Thu, 22 Oct 2026
 00:00:23 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com> <d76dae801b3303ef4271f71c7b3999c10cac8556.1792581744.git.gitgitgadget@gmail.com>
 <xmqqecdin6xr.fsf@gitster.g>
In-Reply-To: <xmqqecdin6xr.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 22 Oct 2026 09:00:12 +0200
X-Gm-Features: AclHuK96_eS5pVSXsra6UtYaT-3JaficPtk50q7vQJScu5b3-gDkVVVOKZGpF34
Message-ID: <CAL71e4Pe_NRxeu9_+pnp=pBOk3SBNyePUbT5DDtDhd1bJpwJng@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] connected: add incremental connectivity check via rev-list
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 22:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > -static void parse_connectivity_check(struct repository *repo UNUSED,
> > +static void parse_connectivity_check(struct repository *repo,
> >                                    const char *arg,
> >                                    struct connectivity_check *check)
> >  {
> >       if (!strcmp(arg, "full"))
> >               check->mode = CONNECTIVITY_CHECK_FULL;
> > +     else if (!strcmp(arg, "incremental"))
> > +             check->mode = CONNECTIVITY_CHECK_INCREMENTAL;
> >       else
> >               die(_("unknown --connectivity-check mode '%s'"), arg);
> > +
> > +     if (check->mode != CONNECTIVITY_CHECK_FULL)
> > +             repo->fetch_if_missing = 0;
> >  }
>
> This assumes that everybody that is different from full want to
> avoid lazy fetching.  It may be true right now as you have only full
> and incremental, but it somehow feels like a trap waiting to bite
> future developers.

Good point, and I think I could simplify this to always set
fetch_if_missing = 0 for any type of connectivity check, since
no connectivity check should be allowed to trigger remote
calls.

I think the reason this was not in place before was that
rev-list did not know that the intent was a connectivity
check but now by passing this new --connectivity-check
it always does.

> > +static int verify_blob(struct repository *repo,
> > +                    const struct object_id *oid,
> > +                    struct verify_state *vs)
> > +{
> > +     int type;
> > +
> > +     if (oidset_contains(&vs->trusted_blobs, oid))
> > +             return 0;
> > +
> > +     vs->blobs_checked++;
> > +     type = odb_read_object_info(repo->objects, oid, NULL);
>
> I wonder if this needs to be _extended() kind that passes a flag bit
> to avoid fetching from promisors.  repo->fetch_if_missing that is
> set does prevent lazy fetching, but I wonder if it is better to be
> more explicit.

Yes, and an earlier internal prototype (that I never sent) did
this. Blob and tree reads are easy to switch to
odb_read_object_info_extended() with OBJECT_INFO_SKIP_FETCH_OBJECT,
but parsing the parent commits goes through
repo_parse_commit_gently(), which has no such flag.  That would
need a no-fetch flag passed down through commit parsing, which I
think is not too bad on its own.

But even then, the revision walk around the verifier and the full
check would still depend on fetch_if_missing, so the verifier alone
would not let us drop it.  I think it is better to refactor that all
at once in a separate follow-up, since this series is already big
enough.  However, if you would prefer to have it now already, I
could try to add a new commit on top for the next reroll.

(My earlier prototype was more complex because it ran in-process
rather than via rev-list, so it also had to avoid die(), which
triggered even more low level function changes.  That does not
apply here though, fortunately.)

Thanks for the review,
Kristofer
