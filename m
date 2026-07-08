Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674633ECBD7
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495717; cv=pass; b=Euj1N7KdlxamxlREakq5ufvt/Sa4KR9PQBnsbvszsQhfap11iHR9I0NeuX2+WzqlQy0sjAJGrwAq0CxhAXfrbhMfUhqYdpo4/0HxHlxm+JB6H0bv9dHCQAOiX4Q+06CbMckIaxAmbVXhpD4noQKHwcpXdvQ3ieWUNaFoP2e7Lgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495717; c=relaxed/simple;
	bh=9fM6f0dA3SeN7uM4OzdcjaqLRQe8GtNf8X6NjG1wOdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYXjdvW8/6D6xVd9RnK4D91FiWp0jrd23FhOZN5gqIoYlszRf+saooWBzZI2JEub8P9bqkHKnYYB1EVzb3M2XUJYoHLXXrP8HHo1JRT2m5hFXhLyqTLtYSdFEVFFYnYppJ9HRV2S9C1uCS8nVlcKUHl/v23uTL1tsjJ/T2l/Jhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Y0/dy9Le; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Y0/dy9Le"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664e3ed58bcso1836521d50.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 00:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783495708; cv=none;
        d=google.com; s=arc-20260327;
        b=IvuhXy0/yEQ3KFYU8SilYTJKwhaGLNxqS33FeUhaAPWeDuUvP/j1NpG2D6f2Je/+Px
         Y0ecA38Wy82VtgzP6DblsVGoWylQVg1rNxa4a4z9MnNHfySFG13BT+u2B0fDFNu2ELOS
         geYzhAEWXDx0ohYiKWlmqqSD4pFJr6gbI97tYwsFviuy1aQULTA20jmq7idqBY6z43WQ
         TZuZtpow+AfEzPi+ziWXjD9z2qIEo4ciFQLLQpKVTvDAEALCBwgtdBv0Qu27AYtL+S0I
         W7cwspwrCdG7zadigzR9LDFnppQCk8BcOoj4DUD9Eqt8inQeLqOybs5F1XDx2+BClWDn
         sIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9fM6f0dA3SeN7uM4OzdcjaqLRQe8GtNf8X6NjG1wOdI=;
        fh=Fvb+rwpWqnOcyr8Yhe6Q3YLdE1wB9guOPMoLBRkClhE=;
        b=Uj7CTsWSYxpDqs/NFFeXogN2y+yv0ACj511pA5akrHRKE3+qH5y60rwKL3h7FA+d0c
         AojfI5mrxDH9d+F+YI/Qt6uCbSuoar+P0+iqL2Y6cgjozHnAFpF3z/+f8li+7lw6qJdf
         5AcGey8AV+fVHCF8eSy6XJiOQ4LfeAZDcS+k22fnKPlbTFcbk/6XwyyHyP5XkqKQ9vVp
         uyf18ASy0AT6EttJzczKKLrAhUemII9k0Cjvio7maY72WoJCNzCyc8d1BjPNE1VrDyn1
         TYICr/hjeYLu8J9PzLoX1gANeYPfEweNV4yLhnJmDB1+zGPyRzbOecbjoFnmb7uso4lz
         Ey4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783495708; x=1784100508; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9fM6f0dA3SeN7uM4OzdcjaqLRQe8GtNf8X6NjG1wOdI=;
        b=Y0/dy9LeTWjmKuE2DeX5F15LOfLcsWEDOh2Gc77II98lmbDWO53qHOTzJM8dT30cZc
         AphDyhI9hHN/ZawQEC/TIFfVobvaGZ6EdbHXx3B6Gb6S3bdLxcbgm2FQ+cLxTXJOiTDf
         6FVcmu0EvOsAkp8EA/U6AdhJ8VHzPcPWIrCrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783495708; x=1784100508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9fM6f0dA3SeN7uM4OzdcjaqLRQe8GtNf8X6NjG1wOdI=;
        b=YIQhlAaXj+hpSJ6UtbS9XsjJ5PJioAlSucc1LwcjloY68Wh5+AIX8KNRSSyhtCk/Uh
         YBa++Lr9a/Z3z+Gr0fF8T1PUZPQL3ytqRFZKl2wPbQD9Cpb5O5L//RJTkDS2hBozVdkF
         PaxNdECcPQp1IPPYZgIWUs3WqKAlyKbuDO8yNDUmHyGgKfOziDNAPqBLChGRALyLpKx7
         6C7i+1dAfyrpEQQdLARDR5AhEBzT7EjNzsK2VxWe4ojuu+sbqDbEYkYdqq97y12DVh6L
         swUnaIZIhiVhegca3TkScwrfSoiMx27ZwcFsdE5rt4k2eUhRnor7AlnRZ9mSVeGCRW+t
         q29A==
X-Forwarded-Encrypted: i=1; AHgh+Rph2YEd2oobHVYENCna2Y8MzrxFX0QrB9J9ln3/O+HZr5BN1baZjUjU/QghUh9ZLP5kEag=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3D4leDbz4hLeEqKI63MAZKdeEN8y/IjQYsfLUuxn4fIcr6ZI
	hGRYP17+k/m4TSd+nNHkP7rA/0hkrSk7KF8v81eunR+qh8MzNxm5k8CksSCIykNccPR49uqhxhs
	Gvx0FuWXz84D88yhhH8bdlLMX62ARYUZ3trM2wO5lDQ==
X-Gm-Gg: AfdE7cmdxEbbeVjg1Bv5f4D7x5/6C4OX5a2MHPHQPKhCLYKGRC+EgP6pOx8tiOItgRS
	WJzCRblEQxec4vfleIbewf5caeTlO8qbUmyasqLoniECKInN5ZmQCoMe+HlCdy6aDQOzCZKHtry
	Dgl3kXEAzX3ZSGQtTTMwXZ/0wSRVmblY6ZeeeCMitynmi9klZELWXJhO/aOmk+ejcz9koJsMg1W
	aYmc7LLk3wA3cqsyowr8XhQQMFYXqEELsp8Pg3DqqY16hCqKO+WZ/zwavYC3foHb4wurvTJQg==
X-Received: by 2002:a53:d002:0:b0:664:a8fa:19db with SMTP id
 956f58d0204a3-66788d35658mr3607070d50.5.1783495707684; Wed, 08 Jul 2026
 00:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <d8ffdcb4f8c1988c109761ddb9daff8c07caa2b1.1783344957.git.gitgitgadget@gmail.com>
 <ak0aNrBpuo7ZwZ2k@pks.im> <CAL71e4ORdJXsz58SH71VjDNAWZ39T3+TrWN+gScAFx=Gt0CTkQ@mail.gmail.com>
 <ak3nWvyX4E9qB4T1@pks.im>
In-Reply-To: <ak3nWvyX4E9qB4T1@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 8 Jul 2026 09:28:16 +0200
X-Gm-Features: AVVi8Cflvz_Cep3P6MR8PkOmLqJeB6_ZJLkpAEpmtpplOYK2Oi_tSy9m_VwDlq0
Message-ID: <CAL71e4NuiRwXMHsTrrqPK=NJJTvBe6E4eqnk90zjj3Z2hgkbmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t: add tests for ref tombstone scenarios
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 08:00, Patrick Steinhardt <ps@pks.im> wrote:
>
> >
> > I could not find an existing test that covers the delete-then-recreate
> > flow (where tombstones are present when the new refs are created).
> > The existing tests cover creation and deletion separately but not the
> > interaction with tombstones.
> > (But perhaps such a test exists and I just can't find it.)
>
> In t1400 we definitely have some tests where we exercise this
> implicitly. In any case, if we want to retain this test I'd rather add
> it to t1400 itself, as the functionality that we're testing is itself
> not specific to the backend.

Thanks, you are right about the placement -- the contract is valid
regardless of backend.
You are also right about it already being tested this is implicitly
tested between multiple test runs since they have shared state
(the repo). Multiple tests delete the ref as clean up and
multiple tests also create a ref and verifies it.

So it is technically covered but it depends on multiple tests
being executed. I think this is simply exposing my personal
preference to have more self-contained and explicit tests,
but I am happy to drop the added tests -- it is perhaps more
important to avoid bloating the test code.

I will drop the added correctness test for the next iteration.

Thanks,
Kristofer
