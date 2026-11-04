Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793788388;
	b=me24oSzClj5jfnUB5D2kzKmd9SQUaLD3JlIqGSGeiXLG+HP1jwhsm8FC1dSqJi71okob
	 S3iqd4gGa8fB9EBednwE06nIGNSGu5KTLpPDg2qJNLESR/fe3Q4JWkQ4Wy7wH52Wd4XNT
	 +3ORmEjVqoo/J09jvxvkTnuLbgFFkRygdZsr/Hi2s+1dUuBklpjeC1hBJ3NIDpcSBvgFX
	 0dcIL2HRLfiFzfcHnwM7wFkaF7yNnvsaKgT8P0gzSUUWfUMgBg7jR+/flHD5+2ExEUGwc
	 An27dA/vtKoqrYq6EbTwFr9F0K92OcAACj6ZXIlbTfkG/Khzw5Pgh3aNYqcxJ5/wJBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=p0Q4NSbPonUHpedsMAngwbowyC1yKu8H0aNTciFKPd4=;
	b=Y5SUU6DXYjpAFcs0mUc+tvW6zHUyJ0cO497jE2R4u05Ua9zdqlHoXXGr5IZoi9cG126l
	 Im00KHIh7rlf2A1i+3OZb/e08uJU00TdkDxawJWM5OTaRvj6QkIbzcTzRx99B2sFsE+tf
	 rhDldDRopUMOO0nkDDcQbJ6Z8D0KZWPNAJt9e9/vVUnrIjpFnNXmKiMIm2+n3qvmKrfkZ
	 EKEi2zjcDXUlrCoLs/Aj34vN8PjRJ4D6cgSuJ6DM66bQaVJh1GOCTINJfWtAW/vTbNXEi
	 cffP7w7aIydgkGK3GDaJMFYVupT5xqcrC752KxPLJZhiFYACVWGskYyyhXq3vdf85JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=ZyXIpmBY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277D606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7277D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=ZyXIpmBY
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so736265a12.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 02:33:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793788386; cv=none;
        d=google.com; s=arc-20260327;
        b=pQ1JVVxCBcsgwMcyeLLDKgpL82aI04fITrGzBcZ2rVo9Jqwm6SrVjtatAQ41y+PO6B
         Xvq3njXsgkQoUPKg2VOFE0EbxbKPS83xSEujwbf96XQmna+peek7PwdIOhElHPWn1+gz
         IR8W/lxntDV+yHeyN7ReZD/GZTdnSLmPVbVknGh8ssx+hSqXWVQxNuz+DhwJmJUFDbm7
         tphCyaujEnM9ZlxsBHrwjABMKxR9BjvhisljrS9/upi728MalMIoUMG2VD/r/iX0cFcW
         +OslsC/RSzWgEDSCT8ZfGGArCY1VPvy99zgrDHW8nwuAAuAPH3n/Nbp8eTnQxiiXw5az
         958Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p0Q4NSbPonUHpedsMAngwbowyC1yKu8H0aNTciFKPd4=;
        fh=E2Ycn6n1UdpEEay+gaMFT6iv+BAQJ7CZ5JCIXu74FRM=;
        b=qG5qqhsfxPIcpUbUnO/qQ1TYcqV56RsVxd6AppQ6XsQhJxTlRZ1LFRmH2S/+Ococ7y
         Uk8VvN9Quux3qug2KlrN9R3fc+19ylrpWW5jUwoNa/sjJmjsra+n8dxKG6JhE6Ly8fOx
         ZDz2ylJHfoXx4YFUZjpbYV00pOchpW7a1fcFq8hZzymWhHYiCC7itQ2gc+EM5loO/iOt
         RRZ1o75Ug2gMVdSoRZlvBryYH9YPuv9799mB4wRbqE2GXxj9r0kq93wjus+D+8PTVEfI
         QPWZXtgo9Oc9t+Iq6HxqloJHVPZ7w/gf0a8UoVNc40n5gTUEkRbfrykrDd31NrNY6b5o
         YsOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793788386; x=1794393186; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0Q4NSbPonUHpedsMAngwbowyC1yKu8H0aNTciFKPd4=;
        b=ZyXIpmBYCg0Wf/7WeyK5n0OK6ajW+EjjEYQWfaaAiBbeM8zHFTFYbo1SbxhCZOweXD
         P6RAsgjcVkA/OOEJYRVxbbvzsWKaSolnqussTjv24wPB9GOXHbcPHhcYrrY7t3Xm9xwk
         g8lq7wes1dgPPpWYtUIhiCT43dVQjWxspFHK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788386; x=1794393186;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p0Q4NSbPonUHpedsMAngwbowyC1yKu8H0aNTciFKPd4=;
        b=SnzAsux3j7i+aj84cMGBsMIm4GsqS5XKdBCEGhQbJvsSYRtqCnBxH6I7l4BH6hPIVx
         gmgSpgnezKDyHMSGeAGdUh8Kfs41zmYbeQGl9sjH0z7ILjN+i1j9pwl+Vr5sH/VxbT8y
         31ObwBQ0YI863zBK/Rj39ejINRAB78EX07UELe7ppVqEx5T0TwE7sgQ6WAEECH3r7Ayo
         by7s5VWXPx8l89PWXMtVFLrS+9lZmTrmbniFdfL1+oNxQvk/pRnhSI8UH1eqNuCaVwBA
         G+ABCNOMPc3s8U0hR/ZQ8+Vaej1OBEEQKrO1oOlEnBYlcBt/Osr8Bbr4jaBCEFfWrx/I
         5i8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYrg4pSDP+wlQtRswiy8Nf80CcHuNQWeLxry7wm3yK+7XvPMbQIVEC5BeKenIY/znfCC4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Dqlm/cAzpNeTO8yxxU1rLtL0GHnvLxPk2nzpDG+GQMcUGP3XC
	lkPTdGSiUqnE8LMrL4Q6kGvRA/dnUdGnFednJnoPVMzQpqYBqoF7F1eJn6HIWo0dYITid7GPyci
	AFt42EAUid2w21gA9HuJ0JCYnlAIuvqY4Io0WUVIVJhxlHjeKqi4hZDrZbQ==
X-Gm-Gg: AYBFou1dXWqqL/2RSvBh8vOnO7bnLKvzqyNsDkgW7lG9Xq1ZXP1kaTuIaLl4fsaiypY
	SbBjSIAo609VkFGaQYwLMl/RkwFEr+zdW+crSlbeXgzDTMVoVajG6gyt0oBHVFYxSWKy0RLup6u
	9zo7e3kfPN6skWn3DjeNcyWJ0G6zL3hw3luMyUdKzNNGQM6FNDL3XIT4ufF8Ej4bOAqqSlRLX3d
	8d976fFMos1pcFeN4lE4pr+zYtwFpFgJDj59RV27AB7t2rvnreOzuzIsKHsI3/N5GA7dYXSerYF
	D2JuBJTMiJCi5p6Yq5NWZfBz8KKBW4dGJX1WEB8hycJM8W8SbT1vojLkhKH7MTUCERS36X20vkj
	mfIvMxcdiK5R8jTCosV8HP+s=
X-Received: by 2002:a17:907:2d25:b0:c41:6de7:7dde with SMTP id
 a640c23a62f3a-c4ca7935796mr1379203566b.4.1793788385853; Wed, 04 Nov 2026
 02:33:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com> <aum-34I8KZvTfDRT@pks.im>
 <CAL71e4McZzVJqFHnmpoQkC6+hUkhz9_HtEy7dqC5rDyXdV6oaQ@mail.gmail.com>
 <aunS6dE0B-JAJnBk@pks.im> <aupPATAGBWH1RIe6@denethor>
In-Reply-To: <aupPATAGBWH1RIe6@denethor>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 4 Nov 2026 11:32:53 +0100
X-Gm-Features: AclHuK8aidZMNWtg9xZ3R7PNTM8XNb16nki82d1RJ0D26jslvBPMrgtxVBYEq3g
Message-ID: <CAL71e4M0t2ZgbqOd4MXeX3vH2W7pPRSMg+8i8epXYbh5-5t8Hw@mail.gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in the quarantine
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 22:53, Justin Tobler <jltobler@gmail.com> wrote:
>
> Regarding the fix proposed in this patch, I'm not quite sure this is
> really the right layer to address the problem. The root of the problem
> is that we are swapping around the "real" and quarantine object
> directories to facilitate writing to the "files" ODB transaction. IMO,
> this is already rather fragile. So I do agree with Patrick that I think
> the better long-term fix is to stop modifying the primary object
> directory altogether and instead propagate some context about the
> pending transaction via environment variables to the child process that
> it can use to reconstruct the proper environment. This is certainly a
> more involved change, but something that I've been wanting to do for a
> while now regardless.
>
> If we are interested in a more simple fix for the short-term, we could
> adapt `odb_transaction_env()` to have a "read-only" mode flag that does
> not modify the primary object directory and only appends the quarantine
> directory as an alternate. For the connectivity check in
> git-receive-pack(1) we don't write any object anyways, so configuring
> the environment in this manner should be sufficient to fix the issue.

I agree with that long-term direction.  What do you think we should
do for the short term?  I see a few options:
 1. A smaller, more focused patch in the alternate refs code, as Peff
   suggested in the other message.
 2. Your read-only transaction environment for the connectivity check,
   (if you want to take that on, I would probably mess it up :-) ).
 3. Only a regression test for now, with the hidden refs case marked as
   test_expect_failure, so that we do not lose track of it.
 4. Or nothing, and wait for the long-term fix, as nobody seems to be
   hit hard by this at the moment.

Thanks,
Kristofer
