Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793890038;
	b=O46h1QtXlZJuNcoGuSQ8+YsUdDl2mdB2LcXhyEWGn4ck4mCop4x9Mko+p5SZ8ZQbJn96
	 /sef5PkSoDp4pjLiMXtqTV2G2KR420rc4hZlKwCk06yXw6BFwQzTWP62JRmzJS8fkvFGN
	 JQ2I1U7pF2mqBwapzFjDzMnnHCVckh9b6fjVhiWPw2BE1pXhyKXvULEmLguhM+tRXATkz
	 Xar84DG/8Gg2JGXfhJ6kZ0ZjO8hiR86OsBQtDJVBZ5tDsJEdT1lvoDGfFU3C5EKXGR6SQ
	 oMn7rBbX1FlqAfRtyQV/g7Az2gNYtET4to6u8FrTjzdr8Z5nWIvn/eVkX+JaK4HrAWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=VUdkt13Y5KKSyfAY0cUy1ggOzED+r947hgFm3jCqmLA=;
	b=AEtWeEnqW1wI+BcvZVGRR/7WnDvClZUI8Bl90FmgF8rzqV205a00FKg0I9N1qtkp1EHV
	 k31/7QN1dVDqdiSjFuiRRkdewJwhSjlnSNN2NEjb74jj9p10aN/+iX2aR2fCAe54oT3GH
	 W5CUlwdtCeb7e5WsyutQ+f3hs9zi751XT4GkDBHrxVJnjuawLxEbhe6pG4EMEjUI15yla
	 /BQ519ub/asiFLjIcASFfiAquHCzyWy7QKi7f3IGmi2JztvX3pxhM0kF96J/GZVnzr2DY
	 1cFJ62viBochhDxa6XDZ03AB8pZjqWAJyeVNS36dZOZK6KlW0q9Yr2XK7SgBtQIdOYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bBjlNL0J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527F606A329
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A527F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bBjlNL0J
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0db268bd8so15199937b3.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 06:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793890037; cv=none;
        d=google.com; s=arc-20260327;
        b=LUeCgV6EXW/ohKgdRo9C2tXj8F2WW3mTqy92ApwWd1UJ//qeqIUK+eEk2Ky0DnysC3
         SQ8J0lAet6BHEScVR7mOIYNNUWUc+dIwqsHn8WAEyk3K6lFmmYqxZC0pudbicRh1pq4y
         h7LUDO4vc4iNkzaXzlHFR5VejNNrQ4BQuBofq0wRGWsHzGusWPXtTp+hOTAwgnxE2dJE
         24sid/U9M9ztjEVH7IrZH0w8hA68A4MpELPPT2iBOYiN2rSa/02J5yyrm7l/gVpjWVkP
         Tyr56ZFHYhUe06Uvquah/8o0tJOJWC+zunQmOWVwD/ei4VcNTDabe9F+oAnfCOJyjNe0
         Em8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VUdkt13Y5KKSyfAY0cUy1ggOzED+r947hgFm3jCqmLA=;
        fh=wD7r5U/29oRH1oMyXDa2kV60OPf+auDH/aWeu6necSg=;
        b=q261g5ZVG9IKsLA9ULPqVb+yVpAGVpt39HPynPisihgTojDJf/gOFgvnvZwbs5xZgC
         BY1+W7QzViZVTdwYXp/XQwKjpDKwMt1jIMgpSQ7gspLCvtCCePcdUXapDNWL6aU14gte
         BCbNcoHVSRQMvDABcWdg5EotkJLATB/zQ28SmJGQu9gQTj32E9uwWfrQGZNAaaSMZPx8
         ILDKYVQlegXukQmMVkxtWO7sqry/5oJCrFcpZGjmgMmDDZf+zDTwoNqzWIdpwere9lOT
         5U3p9ElJr4QQIw+hin7jOWdwVC7SFF8+tZVHQ83W4GSDdIwi4PzHSCSLafb/qzmjhHq+
         ARNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890037; x=1794494837; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUdkt13Y5KKSyfAY0cUy1ggOzED+r947hgFm3jCqmLA=;
        b=bBjlNL0Ji7uB959PB+eosIrrhVkFbxs7k32EXdnVY3nCvW4XZL2ebvCilfTYQ7yUhf
         fQmvqJQawMMXzmv4NnzaS4cyi/wc1Mu7AA7lY+0lBSPodo2qcM2+FbPhqKj1N49WgqcL
         EnscKMuMR1Sh1Yc/zjOYv1WOEzWfL+UcX9Z67XuzNuKjd5XNw1LueWs5navkYklhDWuz
         naDZXqQA5j/kqXEm1LxhJwan5iEWPBN75KoozbFc+WLWq/p8e+qz77GKC0PGH6tz21vj
         WHnA3qoSSV0ib0uNgzvgdxONpLsSUDy0lNM8A97x3/VkuDZOKnDQBIClA5iVkqOfKTeW
         CpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890037; x=1794494837;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VUdkt13Y5KKSyfAY0cUy1ggOzED+r947hgFm3jCqmLA=;
        b=pgpO76sZjoj4ynuE0synfzIpY57SOH7nenItnbfWJbou+aP6dvV8juFDCaZRzyG5Qc
         VGGWWfGJbHh3/hu3yfVNsuxoQyX8WIpo9z1bnjltD3LPWa/y8etqCTvZgPK2H4yIJqEI
         MY4JtAZmd3sOKlfpwSfQ5XsO/ktI+geMLZYZfawTy8ov3GRQOvvPzGNxUkHJ9vDF6lNt
         1GzfOCZB6Y6nhcU+nCCddZfn3LEH8M7Q9eWkH/tNUsyQzWXM9IAQ2hciV5fVpreDsixu
         bcLw9I+dU6tMFpp/AYzMaGPpoGR6AyzJVIm8L+mMR0Tv5jEYzAT9QNvRBXOW0GodtGj9
         hKxA==
X-Gm-Message-State: APuU4Z8m9yseQPTSx5s0iB3PU9yryxf6tRZlsF1njAyIxnNE3Mv9xSnq
	Cu/4anKR4Db5YR0J/8jKlL18wz0zpZBnFhxVp/h4rKG4aohrOR5Vlm8qKs2FmFWL9vuRc6Lcx5S
	u8voMp4XSIvlZS3oX/T+dfXW2Vrm8na4=
X-Gm-Gg: AYBFou1hfBdoL6s8TNl+EYzKIls5NOgN36ApTjZmvyMW8e345wf4+BfloBQiKchdInW
	r1twKE4oPCmPhWJigdAKV8ObPikP/bMubPiw7TKUNsc5MYm8GZhxtkLfwmHLW0hprbWOtJ/hilw
	5PCXCAeQNIpeTCRSVNCSJP3IP/MuroVEfQKkmMq6pwN8VOXeWGew77OtyaSiqYVOlMFr22f2swi
	Wjlkprk2hy+Lb7Rnvt3yaC5oWzxecRprbusg+bCviQ5u0TLNNW06qVr9zj0S+fvUEGkOBDtjUki
	M2u2/CGANb9KXkVRWh7AaXVTBDz7yWegtiQ+iSPCYE+IefZs//FmnT7RVaRHjO7FB3fS+PZHj3h
	Vqh6rew5Q+/gvcVlixaCiAPCEM+0rymoCLnW6sGeZaLU1ZChqe+hdOowIu4gTB+YZQmeEbz2KSB
	Oqt+mY9EjLVle7+xtBpY02K5GQo1rzA0z04myuhewDOMJN32ZxVGMcOUfKOw6sxrNQLTSsqNQrN
	65gf/e1x1n+NP6yMOkPYe+dR9LWmpUTZTmKBKk=
X-Received: by 2002:a05:690c:e213:20b0:8b1:e7c:cde6 with SMTP id
 00721157ae682-8b2b66ceb02mr77780637b3.14.1793890036066; Thu, 05 Nov 2026
 06:47:16 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqqjymt94l3.fsf@gitster.g> <20261105074333.16756-1-okhuomonajayi54@gmail.com>
 <auyRGpaHb5rdVP0d@pks.im>
In-Reply-To: <auyRGpaHb5rdVP0d@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 5 Nov 2026 15:47:04 +0100
X-Gm-Features: AclHuK_FCT8I5emYsX40xEvIVlTJZ0RZSa2-0I-TW-ypSydyf-oZ-yjVe3yJCnI
Message-ID: <CAFpMFfBzx8jAn2u3wPM5poeP1hBcy87Bki4RANwmd+sAFYAvEg@mail.gmail.com>
Subject: Re: [Outreachy PATCH] notes-utils: hide functions that still need the_repository
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com, karthik.188@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 5, 2026 at 3:22 PM Patrick Steinhardt <ps@pks.im> wrote:
> Hmm. Wouldn't the better course of actions be to instead fix "notes.c"?

Fair point. I'll drop this patch and instead make notes.c to use
the repository stored in struct notes_tree, then remove
USE_THE_REPOSITORY_VARIABLE from notes-utils.c in the same series.

I'll send that as one series rather than several small topics.

Thanks,
Okhuomon
