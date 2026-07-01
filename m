Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430033B42F3
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940542; cv=pass; b=ejAQaiL73sKbx7a1bivbcJwmZrYVuQG/HAq1Ykhl4099XucKP4ah2WNtZgyadu/1uS2lL1cjJPcrycqRjbYYVfbperis4gD7lnxOCyr7J/FLumrdx8aLJRsJjjDkR4DR23rQi2E7CiKqxjsBCu5xeSePWAkCMu8S94UpDod56VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940542; c=relaxed/simple;
	bh=sPUXXEABP50/G8LthV2WZP389+ac+8PA3v1DIrlDVs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hS/L4y35d2Z3KHRfaPqxDx5wCjkK4AZQqbq7WVkr4HYcN2bsEscbmSMcqBdcihaJSlHLktP4e9bFtyfYhOsfHqGBYB8Wb+zIwVAg+sDhoYG8yltuiwb58IHe8v4Yc7f2YwAkScNIY6eZzSeQGoWUPiOekbdXZCUmGJfEpHBhIF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=cs58f4LP; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="cs58f4LP"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-664f0a76a74so1455326d50.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 14:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782940539; cv=none;
        d=google.com; s=arc-20260327;
        b=HgWQWekUaYFwbhYylgl2/b12GqpmAb1uUacrjVLrt0UTVxuXDBka9al/920E5Isvf1
         zz+L3wrAiYGTREccvWUOlXrzirPPEueosITMkU2H7q+pAGuU423BpJbjkcB/74GH689s
         VFFrgNZkeTluIOsk2mCH+QgOwIQdQJ1yK3traGR7EeUxIUk+Qb9Vxp1lluVdf2/1O2x8
         kODall0YV8ILFKOZ8kU9sJbHfnTQHPrkK84T8yRPw7M7vhoJ50REAelWVu6r/nl2qZBw
         V6O20FEPmDa/QEQzbiqHDS9+6gIT1Lp145UU/0DOX3QZZR7vzIr60iluiA0POgA2q1hq
         zwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sPUXXEABP50/G8LthV2WZP389+ac+8PA3v1DIrlDVs0=;
        fh=PMRIFEClJJR6Eok8jXV0bMzkcUEdRWsbKChVxkQLq24=;
        b=XieCwRMkKFWHh+Obv/ROhsXwUOVYS5i3GOMXJuDL+ELHELteFqzaPuM7W3+XAWoyTs
         4IWqhFCE0TuYYrTrmU9gHW85Cy3iTGcR1+RNxFDyVC9PbaXTLr8ZQHcEm+p8MUvmvom0
         yHK6zydkGU72fnQeEOntyqSiMTcF4zr1hJ2eJNEgWH0qzP1f/Jsy/oaLW39itpIOlBVc
         a/wcht/aaUBQiLxCLbAsUv+7KGG4xjEQTIFWQLeMPkwKzKRG0gTPyh0m5qlJSamKPCeN
         mzCLkLfssQBIKxpJ2e/n/AseQP0n5JY5yhaFVII5Sw/D3XobL1B6Jj5ri+X54a8r9hcg
         mk7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782940539; x=1783545339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPUXXEABP50/G8LthV2WZP389+ac+8PA3v1DIrlDVs0=;
        b=cs58f4LPZPpi7b2gyn4R9ZcGeUNaSrhYD5SRqaCT5FhC8LkaaAqYas4b52I7RoY1s9
         N1YVKEmblq0DZuYFx+zXvZsSBqtgu8vYek+OC1VXuiMoogobWpimD15tqC3ZA79qKVPK
         a8xtLAMwf2OLE1qrlETAKjOsqX1zv3SnAcZO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940539; x=1783545339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPUXXEABP50/G8LthV2WZP389+ac+8PA3v1DIrlDVs0=;
        b=GgRgJy52dox6p4iVp84h3ZFXi2NLCdDziF8vl1sNdp0+tMxQzPIBMmojZv5MmTbeRn
         X8DLUABIG/YTE6YGSjFxa+14RvHinOAd85cU5NhNBB8VJkyYEVmxtEUrI0lsp5fiuFz9
         oNPRqhkG5D7Snerdf1mcMcLZ38h9Nrmnkc8iY6w0RIZL4QLihlNQPkUa6LYt56UQIndS
         Ws/Y/ikotj3nGOecU5KwJCnrURBi2MEg3NSe/NxkA8WjJUGJ2jrEGUc0gTThyvXTxdSF
         JLrumA55JbIoDPos6bqxbDEYBoEsnp8QJvagan50YcvWBfXQai0R0zR20PidrJqvbpax
         /shw==
X-Forwarded-Encrypted: i=1; AHgh+RojXVlqBNk7GP+wa1CgtAU/6Rur/GdIpVkgLkZQjQUMDsnrR7cWhrKVDw40Bx40cMuO5RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxq1HtAhOjWf07dTKyw5+fqs+RXDC67m2D7Iw4FoGppZ5rHR7
	d/CHHg692iRVwVt0ilEpU2150ufAREDpn4+w632NlvOO6W8aBo4uWmqS8GguJ45TLHOOG4itaW6
	+7A5FiZ/4JekHctn7kRdjWf/CBch0fCv5w70Y3XI85g==
X-Gm-Gg: AfdE7cmnBLhH9z4EzlKN+PtgZYp26Dk8D6HQcXusSLyRsVVYKWch7JXGOh/joO1bn7W
	4n+p7iw8/0/nnVehaTOZNc4HDJtjuM7pmicodMoVz/YLVGfvjF5+KFvpBnME38hKeRmyHaioYkl
	0ADnaW+yADBIz3L4X8XBdRA8nvMfe8+XRod+ChepL6n5HY6t0pulIK3yuHmXaTlNgZkxKdPRLut
	rmWp9RXcJKNEaT1QsFGh45/791om77Ep0iGBz+2NH0xgzu4mi08KnFpRNRemongA1exi2g=
X-Received: by 2002:a05:690e:190e:b0:663:9a0a:7b80 with SMTP id
 956f58d0204a3-665219eb176mr3213557d50.19.1782940539016; Wed, 01 Jul 2026
 14:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
 <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com> <xmqqpl16mq3v.fsf@gitster.g>
In-Reply-To: <xmqqpl16mq3v.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 1 Jul 2026 23:15:27 +0200
X-Gm-Features: AVVi8Cf-DNOAaC6agSS2pAIwwVppXrUPx_Qf0pzwV0-Oey2Is3zgPS108TmH2hA
Message-ID: <CAL71e4PgcZDK-gJziJa_yjEqX9TE+PFMwZn0xbjAUzuUDDDBYA@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Jul 2026 at 22:06, Junio C Hamano <gitster@pobox.com> wrote:
>
> I thought that the plan in
>
> https://lore.kernel.org/git/CAL71e4P4GbYYv1LdarAbeodm06q841wj4gdGpn0QYADQjOB5gw@mail.gmail.com/
>
> was to make this v5 on top of kk/commit-reach-find-all-fix topic.
>
> I tried to prepare a merge of kk/commit-reach-find-all-fix into
> v2.55.0 and then used "git am -3" to apply these patches on top,
> but there were conflicts, and after resolving 7/10, t6600 stops
> passing.
>
> Perhaps it is best to ask you rebase these patches on top of a merge
> of kk/commit-reach-find-all-fix into v2.55.0?

You are right, I am sorry about that -- I will wait for
kk/commit-reach-find-all-fix to land and then fix up a proper v6.

In the meantime, there are still some aspects of this v5 that would
benefit from some discussion and feedback -- specifically the new
test diagnostic helper (patch 2) and the commit-date ordering
fallback removal (patch 10). Both are new in this version and could
be seen as optional.

Thanks,
Kristofer
