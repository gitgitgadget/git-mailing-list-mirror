Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783147;
	b=ElCAaFwBjzMqlFdB8OCPCyahJ7D4j8io7K/2Y4jtP+NR7mbY9ASFkBmR7liDryhmCpNz
	 4pg2cRYX753ldaeGEv3phALOBg6HJ4rpZLJY8m4kwu8LovOfLuRUByygEj/VkRI/FV3Nx
	 INCeHNQwV5VhErhgEU+Wnc6Z0Ov8mUlfByCyfUpuwdY0/kA+p+H7Psps0M+QTdGxMyeFd
	 scvsMuguFtu9q78jYfRxabSvSfHSL5m9OA9RbEnDMPzZujdOfm33WgY0/nvJSqF8q1/eK
	 gWcMsSvQz9ggXIHm+hPUPXYbuWhNsg208JrECdAqMh6h4uNP5AuZ49uIo1AGTn7EZEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XNcwAgFnNRhK14xIZWjwo7fK6cRV2KMusl8/moO03O4=;
	b=3WHfsofjGU5Qq9Q5sB6oH9wuj0v5nFtZ3aM0CdSci/5OMumDSLGd/ONFNHvqcoJrqKl0
	 yUWxaqTzTJgOfBdu7f0crk4rKj6HCIsAy2v+TkUSt9pWPa1uvOlbmtm4Ss0j8YPPtpNbZ
	 AapmABEm9e9qHvqbxiGrjwFflBfDxgf2tXu5iiRa9vAEPJnjbWl0Qk3xNEbAJ8/9PLMOj
	 5LfrdrokTW7RKzLWQnM8nRCC9rZ8GDtIa1U5/DBnycPi9MRnK6TjR5mbizlR2BJNI1BEy
	 FzjTlu+kE9QewSnjQv0XN2FgaBfwbWKlOVm6mGAQ1S9iJVtRh2vfUSqcG98XZjh1mnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uNeIRVJK;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB25606A32C
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 09:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FB25606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uNeIRVJK
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so2687345e9.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783146; x=1794387946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNcwAgFnNRhK14xIZWjwo7fK6cRV2KMusl8/moO03O4=;
        b=uNeIRVJK7ODDWmJc8OYktcxgBiBvLZudqb0/7r+VxaZNftvtO+wg3c5VCgrZisTAQb
         m2xjRm1x+0QgrxtS4FgYAjUfr6XBOnK2SnPRCeLV/BI+82Q8AgDMuSNSTbkyf+P/R90e
         v0lhi/aC5p5SMGqextYGH1v41vKTSvFbvCFA34PiFAmPHYiC7qlrCaSelltSQomNAMZa
         5xNfOxG56DS63LKfHsZP4u6XLyOqbZLRGMdDLGHIRWzIM+aySlRjpCyvWEQzCpLngayX
         qAKgrvGdoHQCXUJ5PY1xNFqn/h1GD7Vp1bgrJyQk8uaBaXlSSYhTJ3p7FBb7uttp6whh
         QSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783146; x=1794387946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XNcwAgFnNRhK14xIZWjwo7fK6cRV2KMusl8/moO03O4=;
        b=Ga+Y1kIZh9nZlIUKFHSamrAiE3OYsjI8OY/44L3GgJLTs0WXYyOtO28zUzyC/TDnd5
         nIUWU450PRuFk/M3nrpZGGjh3LodU7Ct6j0vfderbTwfawZHH0G2CQkwRaU0Lb0f9jnb
         jinqoCTR7h7vW1TmdbmlRHnpMHNXnNqDmbNR4sxvpDIobHfbNBvoi60TsfpCnD3pzlZl
         5P7RL59Unw85zy0hA3d7aI0sJKsvEKkfkIlQZFHKO+DN5jJeiBU67N4Rn64A19JJtkPi
         OruE8cPPegIw3HSay3vJwmNdFvokK16aylaU406DHlHyNj6nQuryKuKNCRQdSWuYVZwa
         z+JQ==
X-Gm-Message-State: APuU4Z/u5JI/akCMjkFyapzwcb3oFAYrre3muB9eC+mrv0lXK/uy1bKP
	zImINRrQ3jArPLauWB9b3JN85CIcSqtjxEVp5arGyBJoiKvoLtPKzits6Y0bP2DUuaw=
X-Gm-Gg: AYBFou0n84zteFwCBseiSbl3olGbCkB9EkB682Ot3sgK6kfiPBTS/c6F3rhTJAISXLa
	qTbbMtXgJbmCCA8gpybTf/7vueuG4mSPdhXa1T1hpE0o8Y2Z1kQcv7BXU5nCFrHxnduu5leu0PD
	GSxhDU336iNSGI3HgcwOPsHxwJo7uvWvrzp8JJXxW/WyxBLWXX+PLW5lqya0NpQnMWpw9tXrEAz
	aIzJ5QDXxstZ/6PkvuY9svwvZCdJ8p8Iaa/7LQHV9bZ4DnwRCYbU6N/7Ch6gn9OX9ie7WJXswr3
	svsV+ESyQ2HEN5Djue0zsbNPX56lfkcmJqsPGLcPopQbIT8EP8anlI1xrUoJE6btPZrujp5uqMv
	Myr4Ei2XzC6cwjpxbFB3kGcfxD5+X2stvxGedjG5B0q/cB5ZVHHpYzwOUf/Z9l1h66fD2dl72aK
	xO9CNMKitBgcy/doASTgzdJs+p8vBCISrTaY5EWnH9Xem+sbULehVsQ/3Zc0qKZ0H3baznFx2aA
	bjSHsj9GAO30tlqG1BB+WmAHZXwUTMe3BihkHWAQGi0BWfWqEXLEZYLI/zKXANJP9/02HI+U8RW
	npGimoAUkBD5Ak+wfxYEDK1+k2Ixz+wUPjyC3FmDq4+aeDGVZyc8nQbqZdo64KBIecg3JGXISk2
	N7l/oU8HR1DbeSB+argwM3eVPITY5b4ABbaS1nklFw1Mif0/48r6lL3t8OWOXVL5BhRXmw7cfbL
	YAi03E8f0m6aLZc+E35ADpTFF8Q9wZ
X-Received: by 2002:a05:600c:5295:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4b3c3545146mr55766305e9.21.1793783145417;
        Wed, 04 Nov 2026 01:05:45 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9fafe08sm201732925e9.3.2026.11.04.01.05.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 01:05:44 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v4 0/2] checkout: make unique_tracking_name() use the given repository
Date: Wed,  4 Nov 2026 10:05:32 +0100
Message-ID: <20261104090534.21838-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
References: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
- In patch 1, unwrap the lines in repo_for_each_remote() that are
  now short enough after the switch from the_repository to repo, as
  Christian suggested. Patch 2 is unchanged.

Thanks, Christian, for the review.

Okhuomon Ajayi (2):
  remote: add repo_for_each_remote()
  checkout: pass the repository to unique_tracking_name()

 builtin/checkout.c |  3 ++-
 builtin/worktree.c |  6 ++++--
 checkout.c         | 13 +++++++------
 checkout.h         |  4 +++-
 remote.c           | 18 +++++++++++-------
 remote.h           |  2 ++
 6 files changed, 29 insertions(+), 17 deletions(-)


base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0

