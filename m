Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470B48665F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058010; cv=pass; b=TSfmBs3TfIha0c8AEdMu+M1AHwwLPZZ8Dc5UVD4S9MXYNf3w51OH0/K0L9yDrrg1Al/9wiGssfn8oh8HIbPYeJ63dMGm1I9FA48dmJbYLk53XIQPWBAaxOO3qj4jmbuHJROPhg0UDpU+NRCJEAy8aJwMgOUlc+8Zq/H6uDOnNi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058010; c=relaxed/simple;
	bh=zjm5IME5y3t27tU+GbD/r6fMUtQ2t0taIYGQEKUY7VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag4X83APBB7888LzshJ9DmvyMbVndnyFJO+4IzQrwkEo79nJuksR8PyCztBwakIh40cByN9EUvoIDWaTFb88vTft644Tq9HRjsf/OFbFre3kUa55/AJwsjtOKV/fHoEKgQqajllVXciSyd5VTEHbWZw6BN3sDa2hSe3RuvEkSYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=H9/OfSUk; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="H9/OfSUk"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c9995ca60so6824203d50.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792058008; cv=none;
        d=google.com; s=arc-20260327;
        b=fYLMMHzMbnR0PT9XY7M5N1NASHRUFkFcbHL+dHYwgxI3yXikS8HPYtevYQwmljMX0h
         NDxuyi2sXu8x2aTh5sKCA3wbmLrsuYb5voiaDtFyaN1xMcgKXxpxOkr8/Eh3iv6DP1f0
         k9l2jQdcOz0hsv+QhQRLqhUNIi+jOodVXMLpCT8Wr26hZ1BVEACbIhrELn31dwqsSJJi
         sTMRE1GZIX+OLyX+HFoRCxC9p7CE0iTwoSO2E3GtgAuZDymoM0xOigMwTgALgiFoTXDa
         q8HQsan7UhTSPMTTzovBOtt1G/erB2zwrSbkKJ+Hf2Pze4Go5zTEcYw+mT9UwI1dQHWF
         KVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zjm5IME5y3t27tU+GbD/r6fMUtQ2t0taIYGQEKUY7VM=;
        fh=BtTayZOYyRrEaO32YJKFyOpOwLsAxV7rr+GD4KAAgiQ=;
        b=oXERsLEgM9wYiz7Bgy3gqLGrtB4Cj7FiIFuHtF/2wec66VeLMuj0yBqN0N9nM2Zsfo
         X29cynxREPR3OE6xNfY99G4nB9dGLTXhKDlofW9JxFZ/mTMthVNmlnYgaW9vYwlEkWuB
         VFP/MqPxifMbd5EMmizZ4F9tpXheR34SDdB4ZjzwR1NtjJLFPKR2goSQIQH5G+8lanPm
         /pqW9viopwgd06YIks5UIx2vZ1W+DQgTHgTpkuC/TzafucN0LAMXZICoI71uLDSS9r23
         DxlKloEnClCo1gt/NXV1it/Epc5bhXoHp9kJBDiVm6NkYi5ZndBuRbzMiTiytv5qEeIO
         BOJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792058008; x=1792662808; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjm5IME5y3t27tU+GbD/r6fMUtQ2t0taIYGQEKUY7VM=;
        b=H9/OfSUkyxGl2fzx/SvjxBXFQtMsczVeqcECh6cbcZHDeicYYYi0hClplhM8gNh7oQ
         yI2R/cY5bHkv0P3bDSmfmKuzbOVSSF08S/U3v+RtrnQUGO3hFUULc66PDwlpVxOuqc9X
         5ubNYq+wS+5EVSUK0ZPG0OeOCttT5bgP6y18g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792058008; x=1792662808;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zjm5IME5y3t27tU+GbD/r6fMUtQ2t0taIYGQEKUY7VM=;
        b=rBiXoMm06TqhsEDIth7SPcgwxXqUcmh2NEXLFYbnGnwgubDM7nsgQ0NHiHgz/ZWJRS
         Lcpj5cjjlJk702dxgqudPlOD38cwQI6EMelO/cYbpEthDDZFLjU585kcSj6QZP4eFAD/
         Mdg6JZxJJDP2pxpK/C0TamDwZzDgoxQbWpzxn4pHukuM09nIvrcwMYi2XJwE99cPan9D
         Uw3zSsJgsRYBleMhMkjeU6dWFIS8V8PttD+3L/O2PKIF3ueKUU+oviNwM18mpVtzvjMo
         YUwxslqr0K8HZIqioX+aN2kUTiSscuzp2E7obPVPcIjtF06bdLQd58b2ZSfsJXHQ3Id6
         YC5g==
X-Forwarded-Encrypted: i=1; AKwUvBwJhwIIeUJ6jBCHLeIi3WS+n0yJgE3Zwl5YAI5+gBZ4ArP7mZFVFtm3hkdTAQvBYJOjZ6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYId5l7K/6Ag7KUU2fteB8e5wmdjv6OTwqqm13+nZF/IP8yPRg30
	pv7q35Vak2Eu9zyZ+Y9pb9v465tXn7OGHf3xexY8CvqnXQch/Jxaw+KDYRfH391CvQGW7xUuE8k
	cmsTHMZg+N/GGHIV18laDOdEHGfrE8qwjwlNPnuqU9zZT63cSYHoZv/g=
X-Gm-Gg: AYBFou3vKUvLgT5n4z1oFa41AQ19h0WXKl0DuEwRuLwFh/mgHVTQTCySoNCc0UinaZp
	NCLQ4otw+IfZ/JvYIVmuWjjj5xZhTlVcuJzhzN6TwCOfJ239pJIBTNG3h6T/y1vtObI5zf2cMO5
	QcVHCSpRtshrZ5ocUEnYX/hNa3ARAQHp2XflAtu5Ro0+e+8CPmoaJqRHNX9V/GljMW/fIQsbJjj
	9TDVUZknhyThPuBoFObLavRaUJp5vhNwqr+BZQjW4aoWpyXTGYNtxzAkuQ4hEHD/5Nz7qC2kcUd
	KyGZt3v1Ypg7hcqVhu1KVX61380FGKAoY0/VvgXnM4vhyuRBW8X5aQk=
X-Received: by 2002:a05:690e:814:10b0:679:9f7f:5679 with SMTP id
 956f58d0204a3-6799f7f5a8cmr323809d50.28.1792058008008; Thu, 15 Oct 2026
 02:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> <cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>
 <atB49SAaLKS3lfGE@pks.im>
In-Reply-To: <atB49SAaLKS3lfGE@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 15 Oct 2026 11:53:16 +0200
X-Gm-Features: AclHuK-d8X-ULdPFvgAlYF1BmsfXNNHoBSEDRnOKMIAYSdzz-5aoNyEhhzoafeE
Message-ID: <CAL71e4O6jccjXbnNjJfZjO9d_t9kVi2PKhD5Tdd_6aUnfYQ4rw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] connected: add transfer.connectivityCheck config
 and rev-list flag
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 08:55, Patrick Steinhardt <ps@pks.im> wrote:
>
> > The rev-list flag is accepted but has no effect yet; the incremental
> > verification will be implemented in the next commit.
>
> I think this step is a tiny bit awkward. My suggestion was rather aiming
> to introduce the configuration option, but initially only accept "full"
> for the current behaviour. The "--verify-trees-incremental" flag could
> then be implemented in the next commit, and the final commit would then
> tie all of this together by introducing the "incremental" value.

Hm yes, I can try to do that.

Thanks,
Kristofer
