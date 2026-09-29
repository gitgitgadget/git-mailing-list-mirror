Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF05208DC
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689490; cv=pass; b=HSXRmS4lrd0M1huOQ3G8aEnW8rHg5mKQ+v3jW+MaTKcyD2Bi3pnH/9lh4issqqro1wiNvFbVAJrrcJowOmqhGXfthNifllqivM+IYjxoa1zpkcuc7vJ4qezHZA2rD04rFQ4IOlKwpaParqtQ4jKBn3eq0YNjz+3NSnrV0SN1ID0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689490; c=relaxed/simple;
	bh=xzRhvjABfEX43teJBuWbjqMV+qUbkEzVLfSWuPpjEXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QD9nXZM8ra5SNx6PkFtj/3QmiVDc7PIIChHBcOwSms3tZRndp7gkJ1HX+55i7ZPvmgBrxrNT5v5RrZjM0RHvJytS4q0caxQJhGOMh+5W8+gi8fS6fD2l/qX2PsXuvSztt/3CHVCyUET/qaiJpnu5A4tQQpTTtT0Slb3Kw8aIqhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+WkjAwp; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+WkjAwp"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac62c88c7cso5027595a12.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 06:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790689485; cv=none;
        d=google.com; s=arc-20260327;
        b=cOg+k5JFHvtVRcRIrlQwseO5InNCcLZ9eZtnsNF58PryPHCDr/H8XEyD/gXuLRkxW3
         +rmgyddQQgr29+66YTasMHDWc2HjN7W3/STye/OR06zlt+ti9mudZ5dJOqzMwVFc63ER
         1uuakFrGJYmkE21lC6Zu0Xukuc0YghdYFFz8WpGhcKB3mA+V7h1QLW2uUZm6sBIRHvJI
         /BrSnOpBgkWK7Lj7DRBs0r0t13g7iMlxnNp6oAB6O8SYsr4JQ5u7mESpJ+ObuLwGC0Gn
         zfdfLQYzCEwIAMTCPm0WIMKRW5ixP6Ly3NmV4w2KVd6tnuEfkW+z8Cd6mUWulE6FWkeX
         ZjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yANbjX0Aln7hU/N0P49+8iJydsWJX2ELDWcYeuVVHtY=;
        fh=AhyQCBrFe8PfDLRRV/vmuqmgZ+IbnSQkX5ddiFUmw/Q=;
        b=bFPnPhZnNPmKhFyV6QxUC1rfuQBK2zAryYl8g+uQh7Bg5OG53HYsU4obq7GJIIK5hY
         pLeGgBbiQbaLfqN3FogLqXgeGVm+5Ag03E7TE3nSR9Bp4iJjzpQB6NehEq7AqzYXRaVW
         jOZocGOEBFOZIVGNHU1zHi/FMlvAWr8hxPVXMgcIBtgRodJmB2SoBUwynWbB0GaSZh0+
         3iL2Sfh84xwz30546kpVgwNtUcmIAJvGY60j3Qw/yd8fgxroOBMetRXIQAhKfx8gKhlF
         O21dPMZJGHl6ADJw3+fe6glI6yox/VTuppWgwtXFvUx5I/Avhbj/jfsQ1JJGpe2dr/O6
         yR5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689485; x=1791294285; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yANbjX0Aln7hU/N0P49+8iJydsWJX2ELDWcYeuVVHtY=;
        b=r+WkjAwpsWSq2XDSuSM6ONX/n0jZxM8FprnhnLm2m0sOO/SOCA0JHMTpK8ETz/bPzl
         OSzxymGW8mcGNSzFRIJXgIi4PEVmiSWo/p909wq8e/z2DXJGpe3QxSvraupxgNGMphPU
         E6OZK8GTTO2pgT7j2PBDx/zOcpFRy50v3hSxntIz5k7LMlGN2ro9YJ2qvJFDv7bJ8Br5
         BfTY0vQ28K4itmYu/qF0iy3bp51pJL25NgrV5obUTlMzhNagBXT0Qi92FvrFy61T83eM
         ThVUcAVMcO0xv8CpxwDAjM9hMFljjM4tUxaLyWp0i/1ziRQAzRpAEt3E0uYhQmHDQDPP
         vPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689485; x=1791294285;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yANbjX0Aln7hU/N0P49+8iJydsWJX2ELDWcYeuVVHtY=;
        b=y6p11QX7T+WUvRDxYcyZyoieAChoG67ipxfI1jQpTsgTAu06AuBIgJqhuGrw+c7FAO
         Y/Kgvh2ru8VMqjoKUsMb1RNw+W/4G3YomKyuhfq73q/u4emlBPMUlDaoOvx44VrJy7nY
         toYrzSNNhbvsy5ts93RvEUL4gUGE1Hfy0Ai8CmgKdO1hyLqtBE2lqw96UM81YAs+mNfe
         tkEJsq/dhjqirIR3lbY/qP/C7C/lD5BukO5ns55+AdPzab7KC5oJi1X8Y0dYt/eK/h1u
         0Yfuog0AIDIVaz6GX93JYpEYJj2+nuQr1+KLPd2B3lz0QPr7dqgW+RVeh6QWYE6zxkkl
         J9dQ==
X-Forwarded-Encrypted: i=1; AKwUvByICG3LBhTmL0RneNXbGeyin4wWFrX5iLIov8D76mFhtTXZ3EsJ+DAsiWCY6+4mJtEM57I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlsfBmvfuLlxfiDPRPioxYhJlfme3y+5GnOyKKd/tXj/4aEOZb
	X5f5aiG4JogQMgITP4SPd5/ufoe2qnkHtVFjsMLsrLJVux3bYQEgiK9aGKTL8ZI91pe9BJuPAom
	wM8dfGbug2p28e94UbKNa7wwT7EoFk4w=
X-Gm-Gg: AYBFou2G/wd1/rUO7lgsPsd/khKQGMolP7p6QgA0zgI5KllfIgOZ3h66f2tQQ5VGZnp
	zouL8bGg8yL+fee6LGWG1d7aFS1XNTr0taxi8X3WLVU+LNfXjyocs0YEB66d7XJ4H0K5BaNQry1
	bLLDzrQthK0CmQnjfo86zjPxyWH3COzk8sdkoAqQWhdTRJ7ylmHM9HXmW9h3laCfiy9iiqom7rQ
	7CmKGWB14QI6NHfzp8fjFNxxGWdRgwyKgcf9m89ZcHb+cuSAO090i9mH4ZeI/x8DUOweb8YixVy
	dAHN3NLqaA/V0K1uEK1+bNZFGzYvuwrk38xhg769tPf+ji0eG7Q+8M0=
X-Received: by 2002:a05:6402:5004:b0:6aa:985c:7bae with SMTP id
 4fb4d7f45d1cf-6aae8eb57cemr9519074a12.20.1790689485291; Tue, 29 Sep 2026
 06:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com> <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
In-Reply-To: <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 29 Sep 2026 15:44:07 +0200
X-Gm-Features: AclHuK_PEukcZE9JBOBEazCTRHokmVsLjHM2-fL-jymmRC7ezCvVZEL0_mhT8lQ
Message-ID: <CAHwyqnUkz+7FH4QY-EB__dOc2rWNNwy9EL_b7R7cA1oPvequ=A@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > After the release of 2.56, I saw people liking the --delete-merged
> >    feature, but asking for this. A lot of people, me included prefer
> >    squash-merge and it currently doesn't work with --delete-merged.
>
> Btw, I wonder if you can share where you saw this? 2.56 was released
> so recently I'm (pleasantly) surprised there's already feedback on
> this!

Reddit thread: https://www.reddit.com/r/git/comments/1wsnrl9/comment/pcncf5t

There was only one person asking to clean up squashed branches. But I
also started thinking about it the other day, when 2.56 drew closer,
and I realized that friends that work in companies using squash merge
won't get any benefit from this.

Blog posts that is drawing attention to this new feature (not
necessary feedbacking on it):

- https://github.blog/open-source/git/highlights-from-git-2-56/
- https://about.gitlab.com/blog/whats-new-in-git-2-56-0/
- https://9to5linux.com/git-2-56-adds-new-options-for-cleaning-up-branches-and-resolving-conflicts
- https://linuxiac.com/git-2-56-released-with-safer-conflict-resolution-and-performance-gains/

Btw, I love squash merge!


Harald
