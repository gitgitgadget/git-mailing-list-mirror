Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1A3BFAF2
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275831; cv=pass; b=B32c/DvhCcwBmeW9gpwPrk5p5CY8iYBkomIx4Oe2iFT0rZgjx93fMG56xkPm8XC9zTSm5kfzIY4UcKS4OhF2Erhq3uo38YP3Gg34UuYjydeKaKS6dF0gC7h0oIQfXrB51nhZAXCc0q7yW01C7PPl7Q2LiiB/pYYnMJezsOhN57g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275831; c=relaxed/simple;
	bh=CTaYN04FnD6GTV3I5zyij8nqq6HhJKPOilhO0YHfU68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6BUduvjrlED9Ljq590rLwSK9oKMD2yREaGDBpvtiapLAlqkJIINa0BWHjKmyqXjC6t89Y3RExNN27xUxWfRaxQLasJ1UqFYAVV18oc5IXUIVjgeVSDPpLpujYRtS0R0lEYRkc1oNJyWjkzi2ONsLNi7pjYrX5MttYQj0S+L4Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXhDrqtT; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXhDrqtT"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so1025752a12.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 15:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792275828; cv=none;
        d=google.com; s=arc-20260327;
        b=dAnDR5l3jv43VTN4Au16kxk4S0axhRfq/o6QWZ38FVmNyHczF13hDhexm4ox9LCo8n
         2Jh4SJqgsKa91fFiErRLKvmd7XjS+tLQDDZVT2glJMYsq1No3KqMMzsfc/rmJnpXPZrk
         sWc1Uq2xi6e2Gtmg3XT3bLGuVcO/pJ7IdLH2h1f14OJ6fYpHYLgdqqFbt70nLHvKFf6r
         rcQEO0Dek8iMJbdHYWwGwqXHS5MIZxH5bsoMtZ3zP9jt/hyiRoeC93hVGPBVw1Bb0IIv
         ayGGpNiy3V1U4EuTWyEDz8OQ+RSwVUI6d4z3+cJHwtdM8IjcmTj10brd+cyiW4foTukd
         j3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2brMeTb4hjTZT575/sEfXgQbVMyMyoVAI53DVM1LjAU=;
        fh=SEsZhzwiiCb1GZa1suDZY4E+eeRRCFrDiFiilDXDfPs=;
        b=Pd2GF6yWGCoc2+X+yxfdJ34F61MLGuyTdGBRVM9BNk3dBbTvr49TCS/KQqnSS9btSb
         /58hQfHRCkQPxubR9oRQ+pDTaGb2ymwKFl1QtmVinfwFXSEq/DNZIlOYfg6AyLABOQkL
         bCa7CSxcKhCNlMUnPnPQqSiduaAyf0xuiViegI0KIlv2uvrnu1Xzb4lhtT3sXB+YUc8g
         RYtfJi2szzH10OwHt8RzC9t72lDOfecCk7UpySFW7qrwD0PHOWqdIFZzMgRoWYTtgR5M
         ZlnD4gISLH2/otKPItQsP/LWt4zNg50FKHl9tbigxR02IsA/sMN/cCgF3t+t2J8RNV3N
         9hUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792275828; x=1792880628; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2brMeTb4hjTZT575/sEfXgQbVMyMyoVAI53DVM1LjAU=;
        b=lXhDrqtTm8HAa6KQ/kaa0w3YWBEFp+a4AvoSgmYZqHlS5us6jTHEPZzarw6ax2EHyB
         awMeecyp6M/8zAiTOJEwRnE1QLTusziiwPWlveK4+fo7fciJVsi7W2UYr/4hKyxre1mV
         O949+blx06yPFGqmo6soJa9WzfHk+Em97j1ojJIeJLUKyV4x7DCMDut+0J0wtCjiclVI
         XcyOtlslaGwF9KIxGtmpWXgjcq0VYPBMnwuOmZJoA9JRK9DRJBfwExSzycnvYavx5U6f
         aKDyGFXKD2yflGM+5zlQeG/yvipQjQRlVqIVuzV8OXku8iKwYXGBWwd8kFKWjbBBWODI
         77oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792275828; x=1792880628;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2brMeTb4hjTZT575/sEfXgQbVMyMyoVAI53DVM1LjAU=;
        b=0wy6tpZyvV81tblO+jsO4zR5pc/RypEs/bmJYx6L7gBIDWObkRJDwKcSjDbehKdZsq
         Nhho7SSujzS5jT+7JNjjaD9dcCV3nwVdWjGg7xYGCVAA5G6EKQm2JbVs7A2cTTdzSmgm
         RM76uPWTUmy3MGb/zv2j0ANl32UBpYWb66MfkePbpq1TP2IYgvxGHL4d7WK/s1S2pwaA
         1Ev//QRi4/rSsceBzynsJaMzu/Vx6GjyL8YH0RAi2O3L6fpY+yT/bZNhIRzvk+VH++GF
         4J8enZQvTgHJr4Db//tAijetCsBIrWYNkA19++CGZ1LnioEAmbBWzrBSocrU+3G0WPG1
         CdyA==
X-Forwarded-Encrypted: i=1; AKwUvBz5wodsViy8npXbu4hB2546CG0GA+UuW9fMa48j0cD6A3rhnWBkfm4TxWoszKWMS58jwX4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+4QT1uJvkVMX+pwsaS0sGZGdXIWQoJhP09oQ/UuAN56umfEcT
	wwVsbnbanJ8I1VkNoddFHAzP1AhTuLAvWwWaTgkjOyXZTHG9ouexSKCLXc5+Tvh8nai4DB8Pg+N
	MW3cW9mdkLp5q7Dcm9cP56kzQDjDqhgc=
X-Gm-Gg: AYBFou1Egs4uoiddWQeaR27OiVC0bfyY9YouIv19+w+1xb0EiWqiec1a7e+UYeL02Lp
	10Fd0MBVIsMDlNhsSBLLyaJ4UYr64nUCa3achy4W//gjawo06y8Ec3fK0Kl7MHU+JIEqAnanfIq
	5WBdvcjurB2c2s9y/sNDfyqwKemwx4N1sn37tvodfkAoDw7GyvAh0VizhbUIEsugZqS2JJJPLH0
	r5kybHneINoQqlckoYqPO40HvgMJ6jsU8WqQkNgOPYU5wpaAcLCppZqYSv3Dn+mqTRQJTSYIGas
	2vMNvPmohO9lwiuLmyYoqq5YOiG0ljvN1xP5+I5RXzxszu7xFfXIBwCn
X-Received: by 2002:a05:6402:510c:b0:6b1:c2cd:dafc with SMTP id
 4fb4d7f45d1cf-6b3a8159b7emr2152248a12.20.1792275827544; Sat, 17 Oct 2026
 15:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com> <xmqq1p9vdalz.fsf@gitster.g>
 <03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com> <xmqq4ieqamn0.fsf@gitster.g>
 <CAHwyqnUP72njKKap16u+kShHmhssiUXFUVRhURPP_wzwZsvtdg@mail.gmail.com> <xmqqy0c21gq1.fsf@gitster.g>
In-Reply-To: <xmqqy0c21gq1.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 18 Oct 2026 00:23:11 +0200
X-Gm-Features: AclHuK_pkHs2XfnRwj5nhWh5tg74T1oHNRVrmByIjNCgZHdJHSDgM3T1Whx2uD4
Message-ID: <CAHwyqnUv_HDHobwSMuK5vxFBZT9zstyyQJpqTv_=o_XhA7TJZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> You might have instructed your agent to write a two patch series and
> asked upstream to pull.  Somebody else used the same AI-gen and
> created one patch that solves the same problem, which happened to
> have landed first.  Or that somebody may have sent their solution in
> two patches similar to yours.  In either case, your two patch series
> is now irrelevant.  You would want to drop your branch that is no
> longer relevant, regardless of whose work made it irrelevant,
>
> They may be textually similar enough that we can tell mechanically
> that there are already the same or similar code in the place you
> were trying to touch.  "--delete-irrelevant" would remove your local
> copy.  There may be salvageable bits (e.g., yours may have updates
> to documentation and tests that theirs lacks), so if we can detect a
> case where only some parts of your work has become irrelevant, that
> would be very useful, too.

I would be very surprised if my branch gets deleted because someone
else wrote *almost* the same code in parallel.

I think we can achieve a lot here just by focusing on the use case of
my own work being slightly mangled (squashed or merged).

> Stepping back a bit, perhaps "--delete-merged" should not be
> modified to touch anything that was rebased, cherry-picked, or
> squash merged.  It is good to have one stable and strict "if my
> commits were merged and safely saved there, delete them from here",
> regardless of how much looser definition of "the same patch" is used
> for "--delete-irrelevant".

If my branch gets picked up by the mainline, my work there is done. I
see no reason to keep the branch around anymore. How it gets picked up
(squash, merged, or preserved commit hash) is not relevant then
anymore.

Besides, I can easily find the work again if I want, since by
definition it's now in the mainline :)


Harald
