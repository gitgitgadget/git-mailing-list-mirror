Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704DE2066DC
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495810; cv=none; b=lbvDgu+13QLJVRiIzgj0QjPFh0u/oQNGcJuwKXVJwApqtvtXSCk05SmVI690LRBBVDXLqO4EZJelMl+WmVuy85e/zAB7ZZI0B4i/OXqcg1jGSKP/Nx9HMzOqwDnvJNDcm8o9e0LqOlS2LpCBRvWfg0i87dc+w+HZJuQX9k0+QP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495810; c=relaxed/simple;
	bh=uhu+K7bpFWzF8NkepwREb0l7vfQQiSaA5XaciNGySD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS6IK0I75nc6OEKT80ngAskZgUui26AX9nKcckmEJbMkfsmKhFGUfpNoKd0NWb7RUzTmVe277ZeKZ2EWN4Fdqd4j8hp+xRCMReUCns7FP9EWPIcHEBj85RHk1UWERRYHbLq8O1oMH/JqXq/WkBR0bq9lOGk1gtA15IYbEZoEmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4767d8e5b8dso304721cf.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495807; x=1743100607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhu+K7bpFWzF8NkepwREb0l7vfQQiSaA5XaciNGySD4=;
        b=mlXa0IclCsYWKq0bw8DEIGuMquitkPClPnKa+iOfi0thUgQ6ExesH0cRYUhmGdGcii
         BjZq23jn64LS38f4B+vmWYmlRya/MRjcIx66zFmZWGmW7rJ9Bs8y0yM53iBQe/shnZ4z
         cTpdgL6Dzl/ip/E7CCVEe4iCle8iqSYo9q+K38dUh+xLhi+mE3CFtmYTPGRwGfVQI1tQ
         gLSOZ6di7yet0/7STl7SaDIJnLXc/TjOPetUEESPT32eWm3odwPIiY2iOiNR4N+G4HLh
         s1yk2w9xJjNH33vLqr6L4r80L3B60IfBGJrLudbaaiM0P+G6po6qp+W64ZWw0/YqKGDj
         z3rA==
X-Gm-Message-State: AOJu0Ywie5UsyYYfzJEUJzuFW72sTKIJycpy1HlTGM0Ry+zSoySGuuoh
	CH9mdXyOzS/VnUWtOoUVfmkkOnXGNzu001rGmFvxoeLk1xIw2pH4FcExw7DoDWgKPQPAL2iEkBH
	NzIFrEA3oD5Vz6YL4Q7FrhzXm1Qc=
X-Gm-Gg: ASbGnctRztfBKYzIo43FqKC3isTtNQTklmRi63WYMJwDZ2SqM3tqvA3Mw8q9nE6bD2N
	5Spo1Q2na96qvcUNqvdDXTr+ayoReegMmyblwqGTy3DbiAMI8PEJIure1kFgN3SXnb4UuW9aiU1
	WUcbSA8CievngLzucJfL0f02v9
X-Google-Smtp-Source: AGHT+IE0S2d3+ZjTxdkWFkv+LCARjtHl2XohB+xdl+lFjZfj1IOpv/8/lV+2h9droywwBqPkIa7KSqkh/qTMCuU0gxc=
X-Received: by 2002:a05:6214:c2a:b0:6e4:29f8:1e9e with SMTP id
 6a1803df08f44-6eb3f1b21d3mr2669666d6.0.1742495807252; Thu, 20 Mar 2025
 11:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250320-b4-pks-t-perlless-v1-1-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-1-b1eefe27ac55@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 20 Mar 2025 14:36:36 -0400
X-Gm-Features: AQ5f1Jqn-qW3DCAU0daHf33PPRcYRtafh6l-nhg8QzRmI-oTyHPEpKHlvT13wqY
Message-ID: <CAPig+cQ0ny060F1fdnCqZ=kALgMe5msxvKE-Dq+ECKxwwgfRFQ@mail.gmail.com>
Subject: Re: [PATCH 01/20] t: skip chain lint when PERL_PATH is unset
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Our chainlint scripts verify that test files have proper '&&' chains.

It's just a single script, so: s/scripts verify/script verifies/

> These scripts are written in Perl and are executed for every test file

s/These scripts/This script/
s/are/is/g

> before executing the test logic itself.
>
> In subsequent commits we're about to refactor our test suite so that
> Perl becomes an optional dependency, only. And while it is already
> possible to disable this linter, developers that don't have Perl
> available at all would always have to disable the linter manually, which
> is rather cumbersome.
>
> Disable the chain linter automatically in case PERL_PATH isn't set to
> make this a bit less annoying. Bail out with an error in case the
> developer has asked explicitly for the chain linter.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Not worth a reroll, of course.
