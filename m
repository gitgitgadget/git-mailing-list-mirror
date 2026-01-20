Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801651F8BD6
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768875648; cv=pass; b=cC3qL8Y4Wa3zlcWouCnPoqVPf1K5ycv4ESTMQviwV0Pwyq8Urx4yUkIDSuvAYwf9/o6DbE+rc4WhH6vR3E0pYuMs4VueQ7Y/uXXc9ayfVuhksNSVA3ixEBIjBHPXPDU/jLgg824lJ6MTl8QgPYo6kVxkFDk0AIj5PWGPO8r/Xjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768875648; c=relaxed/simple;
	bh=2gYwzpzIj6JVgsqbYxFYRLnXFczqDp0xJhdzaAQiGB8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uQ5w6KMGig5jdCW4E0myhBALRBlL2uNvPiV3Wf7yZBVJGTqrARRu8xDYiCvUASSKkTCz++0P36nrRAEetJe4uml+TrddxHjFSd29pJWm5mnHQ+V1qY/ksBOOF7vBH2Y21ca+iM69Y/+a+BGHI230W+Xn1eERZZV6gTHOalVfzI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm4k6ulr; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm4k6ulr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c56188aef06so1851016a12.2
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 18:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768875646; cv=none;
        d=google.com; s=arc-20240605;
        b=HgaPA/0C0R0WirEv6IpsTox3WJpl+SvXXc5BNy+HAaG2fJc2CxqG82UcwHern1GS+d
         b9z/t/beNn+4x4cZLEs55wGHt5Ksf5YlO9Nt8r/r8fYW8eA42WUcRGuWu3wNDYKviqwO
         DcewnilLTu5ipKXcuUbGZI0gzoI3bmHICqpXdb7istjOBvCyd+nuXqdRz7oooa19PF8u
         jBdMr1l9AWqeeuhWlaLANODoeBFR9sbBqgOFGzFBjpLjTjYlxh2QkSrCEQ84FFlX9GmH
         Dgx+U42miju1TKH3ovwZ11ISyMa16h7d9HL7WnT9PXEiO0lPmoSDloRV2PBj4K0QCo5E
         WMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=1t+sJ5XANdIF/n+p83f3yZUalzbfcqrLLT4gSTov8E8=;
        fh=WfJB1YkHjfxkSMCsogHMbYc3pvCTmQRpLXh1eGJSZoM=;
        b=VxhsXZcAIakYh+iHBez78EeqgX343yIyNrfwtkuYONQ+o53NeY0MVYq4lah/yzGLDj
         MqHsqFrfLvIsxCJOBVlXhNHrTSgHrTRhpbv0KZrKw3MGlnIM8mhTBBUQQi8GpWhZOqA/
         W/Mj8n2F0GLVDmou1/8lpPXu1VBQFwxOyGletZWxGk/151OQRkKr1DISHsn/lB1EG8x6
         OgQOt20yThDv0LBPWcP/z8xCMVje7bdUtsRPLJUAhAc+u25FPwyXiTZWPbBnluXQuV43
         qwi3j5TLbhAcjrgF7Su0FKP6S9n/WNbmOaQLNAyoeLlhhXlVvy1geZ+jHlllkaGhCyS9
         xuTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768875646; x=1769480446; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1t+sJ5XANdIF/n+p83f3yZUalzbfcqrLLT4gSTov8E8=;
        b=Cm4k6ulrEKjdHE7ZiDsH40vmZ7D4dQOrPrQBqU8kyzJplNGChmr5scA3ADRW+I1DAN
         +EZAFdTzpRzkEt3lw6IcZN0/VsTsy57RkiOVGN+DEIeJEDQ8fRLohc1KB0a3By8Gz+Vx
         r5BONXpWt+KE8obhhyvSXuxjHg1OdLi/D0Hc7oWfnZkt05PzFj6d+EuSkl2tX1xnXHBL
         fT4hgT9AQjr6BjLgDagrEWOqQoTnr9zfsE3WeH84lkhBtIVlzF8Or71JgNGzmexlNvxI
         0gU28N4V97kBc4MpjVVKH15vlL9GiXTXqCHNfYGOaXrNvyDMsIOxJDzmjODVtKw6uQgV
         aZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768875646; x=1769480446;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t+sJ5XANdIF/n+p83f3yZUalzbfcqrLLT4gSTov8E8=;
        b=On7OX8RlBCR0U/GWm43inBCobOED8tfp9Dk3tgAQmw/wOAR8BvzGkCrWOYAn0nkfQf
         X5AzvRy3aZ7JyIst2NIExikFezmZ75XGuVPZXcDufcfbnKISJo7fbqja3GFs+JQXpYzq
         Qv9sYvJEbeOgDWg2RjvAWrUOcZsAxVSbgSc+hBUYQkOj4WEh1UBtaTa/31+UFR8iDBdU
         4XWYddYOau4RBe0rb7VbEtY5aEzO1OFrMEJqs9CTwu+dfviq4KtWT1wro2/Yh7Q5VWCo
         Zkukg/4eZBpZCzlevtm1Y1ONEg9//BGGlU1DTFy8fU24q5tlvgce5d216nr9J9HDxs9D
         ZMzw==
X-Gm-Message-State: AOJu0YzvnuJzuwwet5q221lVdR336z3mkA1RlERcwvYCbaXO1RU++MRo
	OfCS6b6XXY8+RoftdkXzDpCWDAEfp/qXPgyXePgxcPiAx1foaaDoTBXN/OdG8Y06Eu2d1y8j9Ky
	aE3So72pM55l4wtxK4LGdtt3hXXRROT8eTE3T
X-Gm-Gg: AZuq6aLj/SpnTh4FotHpsGzbWlmgRho3ZXcTEcYIE/JFYivdVoiYXA2NYSZ1NcU4mU6
	6vz60lxNNvFb1xHWM1souATISrWTFYq7AtDm2Cu7RMdA5DxtGbxj93Su4GY7tqY7WglqOh1Ygg1
	Y5TCDYbJfWvlzZZ134dmnIqvaiioXynjAsQnlSeaKwJJJ4puExAKVPzXVTZLvaA8sDRnDHzq5Ly
	LH0leiZ1qQIKzKrhcWIXmv4zJYTNFfsU+LYtYHtajO5FrQ3R1p23xj+oDVRjgo/f3mw9gDjmvzc
	bGKHDsRl3YcM9RSCjzEZFL48kreuwVFIBLIKe9H2or9wyPlwA4mPMV1snmu47K3V1ygn
X-Received: by 2002:a17:90b:5787:b0:343:e461:9022 with SMTP id
 98e67ed59e1d1-35272fa56cemr11587251a91.24.1768875646503; Mon, 19 Jan 2026
 18:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 19 Jan 2026 21:20:35 -0500
X-Gm-Features: AZwV_Qj7-04YHrfQZ6Lg8caWlWHfq_1yheXDCcTMxUBnJs3emk4wwJC6FVWfqPw
Message-ID: <CALnO6CCkcp-Pj-M6yCnr3O-DJE3PedEcqGah3e+E9C4Awqf+Kg@mail.gmail.com>
Subject: git submodule: update --remote --checkout + upstream branch change
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On my build of git.git origin/master (with ps/history merged in, but
that shouldn't affect this), I received a confusing error today:

    git submodule update --remote --checkout
    =E2=80=A6
    Unable to find refs/remotes/origin/HEAD revision in submodule path
'=E2=80=A6submod=E2=80=A6'

Turns out the upstream repository had renamed the main branch from
master to main, and the git dir
(.git/modules/=E2=80=A6submod=E2=80=A6/refs/remotes/origin) still had

    ref: refs/remotes/origin/main

This is weird, because I could successfully "git fetch" inside the
submodule, and "git ls-remote" showed HEAD on the remote pointing at
the same place as refs/heads/main. In fact, I was so puzzled that I
didn't understand where this error had come from (grepping in the
source found builtin/submodule--helper.c; GIT_TRACE2=3D1 was not really
any help here), nor did I have very high hopes of solving it except
that I happened to know where to look for occurrences of "master" that
might need changed.

A simple "git -C =E2=80=A6submod=E2=80=A6 remote set-head origin -a" solves=
 the
problem; is there something the submodule code needs to do to handle
this more gracefully, such as fixing it automatically or letting the
user know what possible causes are? Or something I can do to avoid
this coming up with other repositories I use as submodules?

--=20
D. Ben Knoble
