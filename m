Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C23F075C
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337871; cv=pass; b=fcal+kUDgm9SkmqOGQCsRbfeeB7V/JjnPJQd2WSlf3VQPbIFmhBQU/tEzjqGjreSHtyCew3+W5qlMbQR0F1VUtL5uiHYjITEkKKXTVQJI3Xh33o1dsv4YOMc9gEoTXgmVEwpA1AxYgtfMxzQHDCNZLqVpudh400qeD9oh8Hry2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337871; c=relaxed/simple;
	bh=YgDTg6JU5hJMUoaiNspra02I//rvAfCcSuNoJbXf4yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZ+HvQB6NKVjOY5FCNpScubCBlVHdAJniUVDzPdMjH8QRcBNbotmR72hX4jwtZKOq3QVW37TqqmTX6qD1I+cXHb5w80RTEQWfe79Rl5bkFJFsDLx+BW3Y+2KMbB21Snle6MSwmCg++5Yh+Uq+OAZ3L2acxxisbfd183p2K9nXfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=D9lTbIOB; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="D9lTbIOB"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6651bc5730dso4723608d50.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 04:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783337869; cv=none;
        d=google.com; s=arc-20260327;
        b=sso54RF6QqKSB5tOHiPKKUqVy+yINiSGdNvKPVkuSVPdBWCI+jdIOicspNLqZJbVIs
         fRndpNuamwUHvIIPoztPLv4rLaMCbfT53eiUNktm5E9sYKUshT+zAlKB+JBT0hLMj53v
         JUtNq1mY2P8PLNhOgal30wGRAqp+PDTbEhFXYgogZD/+XHwSF0HBU+/0VUXq443xEN8q
         NB2vyz8RmljHOHWPaPoboGUteExfZC0AhtNp2S4OSYZM5Jc8eBq4WjJUqxT8pRT21nUg
         5zqUcfvPsEWW12Rw4p56eTkCss4T1Lb1XaAblMpncN1N44N+TDflA5yS6MjVzofpy7kz
         UJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YgDTg6JU5hJMUoaiNspra02I//rvAfCcSuNoJbXf4yg=;
        fh=7Mj23orcDXdzaxvFmrTy4PE7klIgO6LZdAdBxvTuMBg=;
        b=D8tMbkkT2rply40iI+a2mPIdpjSMrgnkHz0tHeSYs8leDI4OJpd14O89L6UKP2C5zl
         UFIIEEmHJVUUS0AeaZggrG7ewTJWr0U4FgYFrrGuQG5YnpPNpJ5C/SVNo48vdrhg5N3K
         AKbP70PDCyRFYhMeV3pGYJ8WmXbU3ooBk3B6FjIp3o6fdlZmrU1Ga/ny5xmn5cZD9c5R
         W5ZYX0TkDWvL4giZD9Eym84S/DyJ02J7SiYM8eV4IzgIexqphZ185skkRAxYHp5tTmxR
         Hjf146D6BnvDBviQ3hmcl3KVvIjIuurDkENfikpaQT/QBsXqQ2TTPz9OC7/+G2yBX3Um
         YHkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783337869; x=1783942669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YgDTg6JU5hJMUoaiNspra02I//rvAfCcSuNoJbXf4yg=;
        b=D9lTbIOBrYBZQ3FoUUy4//+IfsoLE9qXF/6bQq68EcJBIz4zx5mZNd+BR64l/YDSxB
         tmmJ0g2jsdW2rrzAjTM35gYIHMEUT78LJ2/mafQvIZCEgeiDP4Uzry+jcmNosNp9dVQ1
         nNw14shSClhg2KScXEbcbIIWTyqUTC0Ghcb8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337869; x=1783942669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgDTg6JU5hJMUoaiNspra02I//rvAfCcSuNoJbXf4yg=;
        b=hha69KSSOBI03bGMWVciNjXhkFJRfaEuws79X81dq+gXR86Htdcl4AFtsid10TlsAC
         FCPxpnLXjq8boyzfMXRPcdTndTfXUjHYQyxtupHv1YDYeRNSc3yqlCRglEwGDMEr/ptM
         jxgsDx4g9GKs3I3QSmfDuRE19Oz1gbUou5zb/p2ARRvPL9Fi7ohmKfoXt8/hzgM+EQGQ
         ypfn23rQFjYOKZVjfbo70IJx4xy6pG/cAJiupK8ydwVsT2urSUV45a9MtvE6IB4tH90x
         dn+95GhRsV0Fwh46fycc6UHYKnJMHcR2nm8Y8FQZUueFhLUf11S86h03qMGWJY79YTfL
         pndA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Tb9904BNGqUBl2TuxZ4FGYbRptqYbvKQsF3bjjm23Fb9nAT8URW6rc7569pvZsEtzWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBTJKlTHyWfWYnOzjlPo7XrkaDbQ5I35gjQi4ZFYqaOVHz1pz
	27irZbNeyj1B7WloHsRdK7UizFKOovx0i6DXCAKdGFf/I9rcfd6k9xIDgBt+yXQbQiHp5cKhVWs
	/OMtII01uocJOI7CORS5ZWw2fN3soTXnFGe3zbj5oYNvtmQ5m2qL/mh1AAA==
X-Gm-Gg: AfdE7ckvJHCMOKZBtyEa9VdMV8nx95F0RQ8j83B4TcTct46C31QkR4nFhvRLr+rXTDB
	ufafFEyIO4YNP6SgJN7wtcY/2rMB2qeU4IGjlVGrvdNXCl5w/z3U9sR/P4pYKsSVacRTt4Jkg/D
	eXXN53Bj7mui6kC4Nd5Hsy5E7AoAmblxCo2i//AQaQyZ8b+Pgf3YowdldXSHnB0K4OJq2nvqHII
	JkWVsADbVCYVmdtOqP6Lc/6V8jRAsCmhRzDqefnwdih93hnTHAOwVCZ/sL3lezRpV84r3fs9g==
X-Received: by 2002:a05:690e:1094:10b0:666:3df9:8643 with SMTP id
 956f58d0204a3-6677fa69213mr156613d50.19.1783337868889; Mon, 06 Jul 2026
 04:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <akIJQbOUbdBbkTef@pks.im> <20260629203527.GA1895313@coredump.intra.peff.net>
 <akOG0oMu2KTqqyW7@pks.im> <20260630234702.GA3759976@coredump.intra.peff.net>
 <20260630235850.GB3759976@coredump.intra.peff.net> <akSxCUfm2P7ocLJX@pks.im>
 <20260701080014.GA3748390@coredump.intra.peff.net> <CAL71e4PfXA-ixKR6r7fu_7_QmdzK+rTRs29mOsUYKaq+_a5q5w@mail.gmail.com>
 <akTm7BDohsy85sN8@pks.im> <CAL71e4OavgfXtjN7QxkvmctS3fTpb5MtDsi-iUg=2izZCG5yxg@mail.gmail.com>
 <aktPP_aRI5Xfo4RA@pks.im>
In-Reply-To: <aktPP_aRI5Xfo4RA@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 6 Jul 2026 13:37:36 +0200
X-Gm-Features: AVVi8CfqeCdRZCok2M5Se7fC9TBpQ9WauRrS5M58KFWFZvmFy1BwIX9NchmuzcQ
Message-ID: <CAL71e4Pzq176Weu_R7vvCQUgqv5Z=88W82-K-oZdqxoSOQ0=rA@mail.gmail.com>
Subject: Re: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551:
 pack refs after creating many tags
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 at 08:46, Patrick Steinhardt <ps@pks.im> wrote:
>
> An easy scenario where you don't have to disable compaction would be
> what Peff posted: you create X references and then delete all of them.
> That shouldn't result in compaction and directly hits the case that we
> care about.

Right, thanks. The recreate-same-refs case works with compaction
enabled and shows the expected improvement (~100x for 8000 refs).

I also found a worse case that feels more realistic: delete 8000
"old-*" refs, then create 8000 "new-*" refs. Since "new" is
lexicographically after "old", every create scans all tombstones.
That one goes from 27s to 0.09s after fixing it.

> If we can demonstrate a significant improvement in the above case then
> it would be worth it, I guess.

I will clean up the patch and submit it shortly.

Thanks,
Kristofer
