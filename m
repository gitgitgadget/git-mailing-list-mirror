Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88527482F4
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382334; cv=none; b=gBilwpHQOuONn/lzq3UMvNdIPZURHzE3ptt+uFz52nUTOEFMda2Lp7Whs7wirfMaUn6QYN2bJpkPodU+lpNQULdeWGVOX+bY53uvZec8BGeelIcsDskfGJxnttEmc4EW718LV6PIPwW7s+az1pWE8JpYR9MsjXG35ZLXbqWv0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382334; c=relaxed/simple;
	bh=Tyg2eJar4NkLzbd0VtF6ZjJCix5o/VmI7NqO4WFeNkc=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=kfhTK+svyiaeo4JL7epVRcibl0vqN+rGZKooCrJjUlVCduDppM9FMBYMepnQDUKK9OYiPV6aV1wlw8eIoVUwdRS2/CSR71Z5gpX9ptfxyox0PtpAHszThx2Zo5BL6lllj25GOUlQQ7DY+BFGaWJtrVdj1LF7cMHb0wi6NjaUnzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D675N41M; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D675N41M"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a46ebc0f49so1966213eaf.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711382332; x=1711987132; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tyg2eJar4NkLzbd0VtF6ZjJCix5o/VmI7NqO4WFeNkc=;
        b=D675N41MFLzscBW7nnJFRKvxDkUYrYZL5Iz+EpdXJa+ROUmO9APYGDjyfQCB3bRhiK
         dgi2lUfBQemBiZVnYo7LFAc4YA4P9/zHH03YDhB0CzXRsxL2EO6wXotpfBI85+SW8JSw
         w6Rfas11UovHqJ5B/MH0lqhSDF3JlOD1jT9x34FakPYLtbSjT8cdZgUXv0UM+c2AT5aA
         IRNaF8YgRiPkimSkt7i2o8B8wBPDrS/mP7iyRJlOMJMo9NY1yxO1ezG8QTPdZB/1x3Cz
         3YORQqJxBmE+/yNnMTI6VLoeBuFYQ7n5/+1u1afVev/QG7nJiALm2e0b26bUDzlp7dip
         5hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382332; x=1711987132;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tyg2eJar4NkLzbd0VtF6ZjJCix5o/VmI7NqO4WFeNkc=;
        b=a9799iWIKe9aWPvEZxPBHV9RiL85VuIcVOxwwn0+Yx+Mf3TKBKuXt702nDhq/9v7nQ
         YciFfMphOW3ONBFkeH2ZBts341QdylgxD+ydj0euLV358HZ/U6KBmoGApSgY3T32V/jz
         y0T5nYmgyrFkWXAtjoB9Ql72DnL5FNg1oNgOrRdtncQ5NoewMH6z+ljKqKX3BF0PO3TJ
         Ge6Dhz2X7S7/0f5Yd8xyKTBfqbk7PBgNeJD9/wmRBcL/3GCUcGRLbvGvzjBay+EEghbt
         UqBR2ENWWUhmzuKGvpaSb4zSTiK4gQBt9gL0pp75RDDFKDYq4B0YDVP0lf7qGZ9koNK7
         WVug==
X-Gm-Message-State: AOJu0YyZoIUCOZqFn5xVh9qdT1FTpoOrTvKcILsy7sAuqMyGT7kdPksm
	9oEUGmDA8Ev2u4/TmxlCqtZGGiHkBc3qME6Tv1Xvzhg+wSjH30taOg5mv8oD
X-Google-Smtp-Source: AGHT+IH+L3sHUibxQ4Tgzyyeh2CWrBZ0b7vHX684gbJoFXLzH3qzPS4mhHKoNYxY4vIs3uSwYaKghQ==
X-Received: by 2002:a05:6820:1e14:b0:5a1:262e:c872 with SMTP id dh20-20020a0568201e1400b005a1262ec872mr7280732oob.2.1711382332643;
        Mon, 25 Mar 2024 08:58:52 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056820210a00b005a52f7bed76sm1119395oob.46.2024.03.25.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Jeff King" <peff@peff.net>
In-Reply-To: <20240325094601.GB254602@coredump.intra.peff.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] pretty: find pretty formats case-insensitively
Message-ID: <17c00d29dbbdc86a.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 25 Mar 2024 15:58:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On Mon, Mar 25, 2024 at 4:46=E2=80=AFAM Jeff King <peff@peff.net> wrote:

> On Mon, Mar 25, 2024 at 02:25:13AM -0500, Brian Lyles wrote:
>=20
>> Use case-insensitive comparisons when identifying format aliases.
>>=20
>> Co-authored-by: Jeff King <peff@peff.net>
>> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
>=20
> Unsurprisingly, this one looks good to me. I don't know if I deserve a
> co-author, but I am happy either way. :)

Let's see, you... *Checks notes* handed me 100% of the fix logic and all
of the non-boilerplate parts of the new test on a silver platter.
Co-authored-by seems pretty accurate to me =3D).

Thanks for the review!

--=20
Thank you,
Brian Lyles
