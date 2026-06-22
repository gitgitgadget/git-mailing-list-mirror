Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC06283FE6
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156002; cv=pass; b=XuxcgotYOzBD+npNkTVWIYe5IwtZKJJovBU9GoUUY2jOcYH0ieD+oO6KC/DJ4og9bnZVADNbPPd4cEx3k3v9yO8y+8CnUNJ5hNHCCwubkq7DcbOIlPHlZLTzfB5mYcjcajpHCIbXXywnN2HlO+mw9N6ThjV0UUEMNU7PUSd8IVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156002; c=relaxed/simple;
	bh=qpXRrskvOVcQv3sDJ8mjohOFajDpPAu0zXRS56DyHMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVohNqdV0NEoLw2E0Tr7JUv4WFd7fGWU8P3s/x65Vthk4moMUOlnd7YJBCdkLya2MNn+b3Lm9Z/EoCB3aJK394b+n1rHFUudrIEkWjCJSYqfoRuXiSRz3Vl59RiJXDgmIeY3nv1g+HI89UbYtR7sCYAjEpuOJRkXbnjS4Bol34s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=YRCya1YG; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="YRCya1YG"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662bb4dc1d6so5285538d50.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782156000; cv=none;
        d=google.com; s=arc-20240605;
        b=jcJdQ+VN1oHBV4dOwdvQdrAf37pDz5V4MyXRhFv8XDVgRVJpC+hPJhdtcspmX5jqB6
         aaEjY9Ys7lv2Ad3+LMqwXwEislxZdHMDtrXccBFm0g5m30HlSZLAQQQfyccbwiRBT9Em
         d2eYN3EEvPjz1uZZNz8uMqujUcPsVssVinFJBKtBEN+PB0nI7A9s2B7GLldIxTh8V8yL
         Advy2pM1fBTGaiDikb9MApOilEyGcJ4zXImWgJzunMViz9GTcO0Kdc+ZGzOkxn1Q1G5n
         1BFCQKoJcPQWJgtnTOPHnOXM+r+MyoTudUIpjjee015RjDCjASz1L2jtgetrH8xFB4pg
         ZHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f9urnAXPu3ryueOmPpx63q0HmbRwgKiphdXAxAMbl40=;
        fh=L35iaVAf80L90rbTqs7/8tAS0Pa/RSP4DNpLjVYDt9U=;
        b=RD/SvA8gw2a1Ra8eLvsDmCrmTBm/Fxlifaq9q27ZBbh4Jkt4foHhRf4hmWnXcwh9Cv
         mDSIWkIGRpfKVT8c48RPdalY/Dk8XXw5Cbyzyh4R1ofinqe6bYKzcy12oeOgSKUMdVIb
         dvXAZZmxhNWA5hBcZdz1yRdrX/bUwrF8KPqMSH38CK80UqaA0cW5N8NARsRts1oNz+EK
         /9dewao861TQQZv0BSfmJXCuWvlKJwMvi7kPOChjG3hwfrkQKaPfgtJlz+D2nD1OpwXL
         xHR4E4LMQQR8F4uYeJQl3Xl8S0X5YyU4lV/sHNtcxBT660RYbSA5PvvF+zMG4NBW+4GN
         1txg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782156000; x=1782760800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9urnAXPu3ryueOmPpx63q0HmbRwgKiphdXAxAMbl40=;
        b=YRCya1YGRm8ngezx25KLFw1IUEtpOTACwji+0zuxdqz6Zn/qgNikh34zsz17gDElVd
         RMB9dn7WhVZlFZoaRSsrAFRxkPWdF8tS/O1JhUB8+K9A66aK3pRaiiO4DxntCaspfP4j
         AM36UMM3JUQdS50DDOW0GHbQKIDOvNUCQT3nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782156000; x=1782760800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9urnAXPu3ryueOmPpx63q0HmbRwgKiphdXAxAMbl40=;
        b=Pd/c/yuZcV+eYXVbxrgsZljLhGXu8vx6kkNlVpF5zA5P5Wl3EvYH11LRNdT7dV9/oU
         jHCXfNwLre0p8TpUWwGch3WYppvwBRKBqHucmMf8CMfqEfbiAoVpK6vYImoR6+XzlLmN
         oHvRhuOxBySGvOj9hUrCWyXLh8Bvo759ZTi6AAzVI8Wnu2eJBurWKDPOv0qjt68FdfLv
         60TZ2iNwdPD8qdQGsZiAIVyLP9Yj9ub2LHCytmNnhS7Rl91MSMea7HfOQPDg4awMnAZv
         QR201R1EJIT0zQHYpe08Ibrp9Zpn3MKpRSc4n3GUgAd2P5aHIRMTin5NTL2HSOZC0SSb
         9bKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kLS54GsHNKeZwkZhVRiRBUs6IcGztULV1qOLFiwxWGyhJWubjdPwy7+aXJQ/l9UGmRkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi64zuaGvt7h7btB9XJJpseh2TKibCCR6O941sCZ+Clo01gM/N
	SuoIKk6jYX/vKu+Cz0G7EEWtAKFK79oNiL+vyUMl0TNzWpFA+6x0j2cHPpS9pRV6U0vZIY+oY4o
	dBgjKglFnHT0E4WK5OSonCKHpTKBNKs3YYWJ9DgDOnmiRCT7tiDTIgfI=
X-Gm-Gg: AfdE7ckh3hIAE+JAC48GGtkc613n45o5ZUWqWhYFdpkaxBqs3yixbm5SIrZKDezPW5g
	QEXg8KTAEz7fwGMytQDj68QyKIfprKyGqrP5unWOckljum70hgkU0g3jjCl+E+bJYT9MPGCMPIe
	ugxHUaO0FqDL/f9nG0Xp3tY3nKUjeDg/VRqNdhC+bbr33/rlF6XBH8hOo09/r4sF7u0ENtmLDIR
	kl1NqAuch1xkyqTUx3MFPwP9W9zaWguCQjsYA+7VaueVxLJ8tI/KgvF6VSqlsTcRYpN33/LUA==
X-Received: by 2002:a05:690e:12cd:b0:660:446b:7aad with SMTP id
 956f58d0204a3-662fffb397cmr13247478d50.57.1782156000440; Mon, 22 Jun 2026
 12:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <ed12a5cb5b76925cff08d2ab61efeda382b4477a.1781951820.git.gitgitgadget@gmail.com>
 <5c43f6ce-4dfe-47dd-b96a-80de57ecf108@gmail.com>
In-Reply-To: <5c43f6ce-4dfe-47dd-b96a-80de57ecf108@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 21:19:48 +0200
X-Gm-Features: AVVi8Cc1e2E1k9SOIL4-bvVoax2-U2-aamqQLKpRZj1Vh9c3_S8In6BLSDCAFOw
Message-ID: <CAL71e4NJZ9c_=0W4djRFCYPw4z_dkh_ZHEDWBk8cuwXhxT9jgw@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/6] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 20:12, Derrick Stolee <stolee@gmail.com> wrote:
> > +             if (generation < GENERATION_NUMBER_INFINITY &&
> > +                 queue.pending_merge_bases == 0 &&
> > +                 (queue.p1_count == 0 || queue.p2_count == 0))
> > +                     break;
> I mentioned it earlier, but I think this check should be in the
> dequeueing method instead of in the tail of the loop.

Yes, I will try to fold this one into the paint_queue_get as well.

> I like that you broke this out into its own patch to demonstrate
> that this is the key performance boost. It may be good to have
> some performance test numbers that demonstrate that patch 2 does
> not add any substantial overhead (timing should match previous
> code) and in patch 3 this single condition gets us a huge benefit,
> though it requires the data tracking of patch 2 to work.

Good point, I will try to run enough local tests to ensure that patch 2
does not add too much overhead to slow things down.
I think I may need to create some type of (temporary, internal)
test runner that runs the same walk multiple times to reduce
the noise from parsing commits. I am not sure if I should also
commit such a performance test or simply include a brief summary
in the commit message

Thanks,
Kristofer
