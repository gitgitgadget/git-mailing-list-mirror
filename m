Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF72DECBF
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623392; cv=pass; b=U9eQzDgZwELq1Q1EYZODgWSkSpHRY6azs4HYCSEnDT9hZcfHzGsk9nadZOoaV8+Gs/NbMMhCXvh7zdF25u4pV+ir0dWXI9QEJVJgApBfouk1WGJa9Tlwxlc0+xNHbCE6PwQlyjnH6sgNUjt2dF3jS/6b71sV/5if8k54D0DkC7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623392; c=relaxed/simple;
	bh=Gsk5R+LhO0VRDdb4i8sgDEvtDqQKCoDLidQ4yYSDCvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISFSbayCUiPzTRI7SZ29ZXkkPF9iwvTHBwTbzy8Vtf1HuSrueSBJHcAwf4RjRWIOdzuwkhcYRXKiMnO0Pg/V822yjkytanSgDtHgg59PQyhaPwXp44SreZbND/ygRGro4rqPTiaMZKchems99KwF/We9LguR7T24CKmU9yEWFt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=Ro4r830Z; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="Ro4r830Z"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-676858d42f8so274468d50.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 02:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791623389; cv=none;
        d=google.com; s=arc-20260327;
        b=FjuC9fCz0n5SHTTH1smMPRm91Ez2Ddb/8jQASbeBSS82mg+sh3aWOxBtZEWU2QY9AP
         GbogUZyB+Z6L97T9qeiKDMLFRGhokxhCfpCt8MVYpv8JB4wTQEs4qUfaJWJ1+jACEkRF
         E4IPex8fIIi1J0grn7wdCY/wg4SmrOyAqCYXFgY3gOkRdZGVNK7XDiX8FgexpDmYuK3q
         eA7569g29IR27sh9oiHVEnX2mnLXRAYw4rg52ApDoL1ZaSaTR/waWgibdwcuan+f4FKQ
         f/cdVY4kmolmnPZ/xfErHP9srrmo/grF14ASTZqci4iNiXl3gHDvqIEM+VT8sy2se2l7
         EGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gsk5R+LhO0VRDdb4i8sgDEvtDqQKCoDLidQ4yYSDCvY=;
        fh=sxwabz8vzSBT336h1RK3zjoeNMy/3EOEUTwiDtwBgPw=;
        b=G4qAPBeSmW46oFQMXZ7+SD1T0OZjou73uGcge251gKpSiUsce7p6/ay4+Xotf5A/Di
         aOgtFdAPVpIZqXVuCQ6xYXgC83qtme1+CCKtQlLl9gYRaAS07VQQOZCYaEPQ3FE9BejC
         Y9Ati/McsywGn+C3uJN92TVd4AmSSI8teiGaf6SSNNGJMHE5QM3ro8QUboVztPEczOxb
         D01SQaf1CYnX2o/K2RWIgVAFmtg8jM+xX1ZpEk+CxrzIyIWhf8o9tvzwEw1rU7ep/p8Z
         J+ZE25Y4hxxckhgqx4/GBq3WMvyfz6BBuFAoJvnnmrb8mLLpU9tEXEGL6VK7P4A4Y9A0
         zA9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1791623389; x=1792228189; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gsk5R+LhO0VRDdb4i8sgDEvtDqQKCoDLidQ4yYSDCvY=;
        b=Ro4r830ZbQ1p7fpXCpjmLAN4dCINnPXst/ZyEl4rOns1qFnrndw49ftx0MGEe5XHAQ
         C9uyaudnn7OsYJ99bKN9U46a7x/a+naGLdlGdFH7FGYyQ3eBG6yNswvlhasM97EL1q1L
         /FlECmBoXaiK1YjpuOaYROTOJYj45PkDkRAGBXKNCcPXrO/icjbMCiYbXljFru8jcU9P
         PVs4NdDPzvxJlDn/1WX3N7YXHpkYm/rlE2yBmvUdQV8CgxzYeGQ7zwNWMc/afDYQ4Ajx
         YR6xNCZyVujXb5dktM0g90GUBogzSpEyzuPPlPTY4iRYYp8HczafUJZkQjx5UQM6Y3n8
         stxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791623389; x=1792228189;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gsk5R+LhO0VRDdb4i8sgDEvtDqQKCoDLidQ4yYSDCvY=;
        b=IUlb8a5P5jym6qVIcXEhqLz5rx0/kgZ9HSbnLxk9gzvWKhiSmy36pLUw2QNbSaaex9
         u5VFGL/MAQr7LnNqcWPsXvc8K/5rTi/Pr/ZErKeaSnwrQ5Gza5lgQvy4V6YrHE3LWhgj
         9jh5Pd0khne3QZeT+at7479OO30CKSHFP6iOnMoptxpcaMXnblG60IF8c++/8qrsKvdh
         VL2/LQafTG698KLAVKF0uzEq0IX6wdrXfhPMFYVmTAE9wQoxbADcOL3QYADnPpE0fxvC
         1a6ZbGg8LDf2DDECtR8Vw8tv9bmRQg1NLkF23tNNlBPY9CjPQcFuPL4kTpeZhPWtQaE+
         AChg==
X-Forwarded-Encrypted: i=1; AKwUvBybPF8UOQYsSSaCw/PubvirvejDymr73PeRZ+PdKsLhdcr2hiPSbk5kufK+VG41xoZEPtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcbXLjXvPH/3fuhrt3zyBiqTe4r8wIOlMgbquhdkKwHm7ac68B
	13BDdib2+bOzGXfOfFtb4ZWp8dXlKK89adUoiort8mc1+IMKpbZhY7j6eIaUpCvrhn2Ao7PIjOH
	07BaKQD13hmG5WvaMU/VM/griHqLzb7VlvuswibUGSQ==
X-Gm-Gg: AYBFou3UZgDUJ4RA5ZoPgME0vTHgCeBtM9BvgLDeu6oHju6rEk85/MO+kqHQBxIc/AZ
	OjB3T3SX0fzb7aPLwmW2SjyF/H9+W81KXms4xxa8Semf93k8EV3GjX7zw9xcCHZwK5/kuXmQckT
	SLmKS9q1rI6ZnMOZtUmgKE4SQZvkBwI5UaZMm6tYc3EYxoCe2Ae9fqp61xU+TiTbGKY3+/Zlfjo
	NfGhSeoqA+2qgcP429+kiVDL7K0f68uTrFZTZ6VG4gPBrdEvZHByA1dkgQPx9/VScoqvJ26MZup
	36TnXuZtkwF+YnayrRROxlWdjSpe6cpBC+zniAgv7VHUVPWzALhsjE8KRaCUbMQJAKiRxQQ1Iah
	1kIzKWe07LG1gO8pGbvfPEfGrwI4P2v7DJaJnWqMcFgWs/w==
X-Received: by 2002:a05:690e:d50:b0:677:b617:21dc with SMTP id
 956f58d0204a3-6793602f5d9mr1070051d50.34.1791623389590; Sat, 10 Oct 2026
 02:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com> <cd018289bbb330753e41a1e5b6156b6e85c12dbe.1790939492.git.gitgitgadget@gmail.com>
 <asiuemA6ouAW9NXy@pks.im>
In-Reply-To: <asiuemA6ouAW9NXy@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Sat, 10 Oct 2026 11:09:38 +0200
X-Gm-Features: AclHuK8t50cyV9Nwuyw4Vi5LD9Vjz3-XHTgR3B9UQMp8MTO7oHuQiPJL8pxmc1Q
Message-ID: <CAA0xjtpWELRcptFbY4D8f4s1erhHiZeh4xfEC--nYw9fVu_QLw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rerere: go on at a conflict when the lock stays busy
To: ps@pks.im
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 09/10/2026 11:06, Patrick Steinhardt wrote:
> Is this a commit that we maybe want to defer to a later point in time?
> I'm not yet convinced that it's really necessary with the other changes
> that you've done, and it feels fishy to me to just skip some operations.
> So I'd propose that we drop the commit for now, but keep the option open
> to reintroduce it at a later point in time in case where we have users
> actually hit the issue in the wild.

Agreed, I'll drop it in v7. With the wait, a rebase only dies at a
conflict when another process holds the lock for longer than
rerere.lockTimeout. And since tb/rerere-lock-grace, a rebase's own
commits no longer start auto maintenance. If users do hit it, I'll
bring the patch back.

Thanks,
Thomas
