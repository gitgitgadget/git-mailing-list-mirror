Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335131619C
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366939; cv=pass; b=bc682MXInha/1Jrz5stEo3vbBDMKNYqU8cGS5FTRhJkaAK1fmbl2HXgBPppySHd/Uf8xQen8E8+qcbgzP3yOMv+jc9kwS5+CeOV7Ls5SsPbdrEyAyVgJVCMTyEfWgpr258UyYZa1QY7UiXMvrjRGhzgMaPWSR9s5i6FxjIIxH3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366939; c=relaxed/simple;
	bh=e96tKFDDPuqbmTaZJBO8UdPTTUQUDTACXybYEoPTvmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6S3Asn9DWPULnjabae+naCkV29iz9iQUDRI7fIH5MO/rlbbEq1z7f3J9zBt1y+tEjL4+PnJE+/qIGp8+wMDSDHOn8QQQyRgk2FeAAdG3VjzMl2rb4HXAHCW0rH45TiXpOoMAi/Do01sIV4CAmAlHfRomV5Y1yn91vkU9Oyu9MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTE8TlgD; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTE8TlgD"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so8815797a12.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 02:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784366936; cv=none;
        d=google.com; s=arc-20260327;
        b=N5YyjhOiBaOx13KtormQGV0I9XSmjmlxV5vxf3jB1Kj7+O6mpEUCAXOtE1z0qIcTiP
         9o6zNJAlkG/feU8BrfWcaSrwoGR58SNtatQwBXJXY6Q7QbLGk1coKslF1c/7WxI1N97K
         geWrEPBE/rMGq7w4MptDmaSna3EWWKUQ/MCIAFWbTnnMuNeqVqM0fuhLu1gcolLsk0Wv
         G6LhtNnuyboRPQeIpMrx21PFGqkKbG+ZPKz76ffJgR281DnnJvVfdpFJeUFTuluwQ5q9
         KHX5AxjajFeg7nfjrwVKwOApt/RnOrjLUZCco8f4wZGPWGkAjhW6MwFE2Z+7Pda9nGBq
         JdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e96tKFDDPuqbmTaZJBO8UdPTTUQUDTACXybYEoPTvmk=;
        fh=jRI8aNXUVKYKATZRCN1esd9y8VutgkUSrU2yp96Ef4Q=;
        b=ThV3vFpFri70Lw4ruc7VzE537PeZLRJgVm55yaROSfHElukiKG6w8QJgc9mrTaqV5R
         wOw7pXg76jEb3+0g8j5rfAMx/AKCClmQTY4+slxq114U193hJETEDAR819RuQnavF9+9
         AGIzumzuXpvn9lluol+dvIJtHBau/wUJHi8E/F4jUGHcWYs8sbFrYQffX3l/DB3WxwXh
         Lf7n816N0GzeUyH32i+DGbuX9hRteXEBSodjDw4/I3avQ4E2lgpk9nLNuzf954AFSaMH
         4CtWbGXjVsEbSLrsieGGnEKqDG7Hl8kPqf3NKZz3/hSHES/xFzDxaWpzWkFU0vy6cHHw
         X7qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366936; x=1784971736; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e96tKFDDPuqbmTaZJBO8UdPTTUQUDTACXybYEoPTvmk=;
        b=pTE8TlgDdgASd5473qxkPEubMu1dWoclIx9bDlVFAYj0FVj2VJrjW8MIHSUOTXQwB7
         F37hiA1YIszq4cq6aLfx3G/XB/oKuRXGZ5EmGxHGTjgRzk6g4JgQo/9hHxhtjMBF6zed
         5+rBKfyqdOu15SyUXhx81k4szGzx04bloIOGQhxAzRyI/f8qXCArrLwKr/+yL0Xt8u7Q
         x6WaI+RBMwQHxF0QPMLfEUEXFgsEJuEJUaqd9r4vF8mlep69ZQUd+ZcR3rWX4VLc6Mo8
         2oeBH5QxOoBR0OXWkZ6Q0BMljLq/BfCFID523XqDErWwZsuOwMYPDlKd9KL+qxhBUZFx
         S0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366936; x=1784971736;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e96tKFDDPuqbmTaZJBO8UdPTTUQUDTACXybYEoPTvmk=;
        b=M5/dof435Dd2OHRrGZTD1CM5w8flQHR7+IKOKyld80+keFD6Umea5PQnwTAwxfwThZ
         oZ8LHxseEmScsFmxgYysz8jxhf8Ase2rlPCAOQoohm4bDlpG6J2kbrseoWsPGasx2RL+
         eSwVOOLf2QFhA6CbJeCwbMgg3Y/+ZfMpb4RHXcRbiv5gLfn3B07EN7S2LHew5byvX33j
         6eddpoXgfPpsaJRARcHDPojJVPh5Qr8dxvYRcHt982KLoHnrLrzMuZ2Il1veawvaRFQo
         a9Y06Wk+KTmI/6QGqMe3+zSlL3WNwmonDWluH1b4HzZ7y83XcK+sl930xGsH02WZwDeM
         JjWw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3yO2F2b17O28914vkspYF9HpOpgeNhDV1huvJzdD34Td7LNlUuHaalKMY+z4DpkTADM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueN2trtk/I3IY44kvek7vAAf9skzebU6TDRxzhgo07kq5CQim
	LVzv3APYWIH8pfBYjd1gI6ohWeeGq6jEXlGTmkdld0BmS+q4NLYpwSeOF3R2fhDN12KuXjzHCIV
	mbkFTuQlQFXI7sicwWF77/ntfQ1sFvE4=
X-Gm-Gg: AfdE7ckpwwvanURjyAPR/TEtCCK9GrsyA4cv5uLWeB80cRiwcWK2aA6lKGk8JnKJlkt
	8GHBWQ2OExB9sxiJH1Gg6+P3RSq6AvpN50wCC7so07AGlJjdq2w4aIfZkBxuD7RgFUU3J7y09jO
	RIVtC0CoYqOuZP8KJzGRNtEfWHYZjRbQulX3rcuuASTFxhS/dyQmE36BFnpXcUVD+LtwSSmsAEm
	CCTAQvXpzBqnlu7RbbNJOZq7hn/Tz3iJfi+KxPbZn4LWt+nenvRySL6U9DZWg==
X-Received: by 2002:a05:6402:26c1:b0:699:244f:69f0 with SMTP id
 4fb4d7f45d1cf-69e6525b189mr2503562a12.5.1784366936350; Sat, 18 Jul 2026
 02:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
 <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com> <ead974c3173770f9230d2ba8442ff06dd9e91e00.1784128573.git.gitgitgadget@gmail.com>
 <DK1KIF2OI8IF.11188A3YEQV1C@lfurio.us>
In-Reply-To: <DK1KIF2OI8IF.11188A3YEQV1C@lfurio.us>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 18 Jul 2026 11:28:19 +0200
X-Gm-Features: AUfX_mzQCpiHQjIjHw7ltOEu8Egj68TpkZDnBtMe6tIcea47YkHlVG6VvX6MMe4
Message-ID: <CAHwyqnW9aLUGDQAYcJa=z6Zs4q8vaLfcWVuM7r2OWX9pg17P=A@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] history: add squash subcommand to fold a range
To: Matt Hunter <m@lfurio.us>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Thanks, good points!


Harald
