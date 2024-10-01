Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC543AAB
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727757012; cv=none; b=iJ4CuJr35r9NkqGE8rz7r2Kk3kGIKFQhhHC0vUEtFG+0VponJLIxoYMpGRxeYIWdgqan1m1gjM1hSC3x1990aTIGtxe/HIGUQ4WJFXDs0BDs9vDONKp9bP1KAOzH5/TXBZjcSBmwtX05QqMdDsad6MLt12NSMJ3QpGu4rAI6Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727757012; c=relaxed/simple;
	bh=vlqTSAIEayaSI4wbEMdz1/QtEL6o76rp9B1nlAgffiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgPbvZw/a/NLbsVbAWLerOUj8FsoBQM4byZf3Trk55qDy7OmjwXn6zIXBTFGO4WLaVQH4q1nuQ5Oq11w2qivToGeG+cof+TgAE1bd8Y3CNt5ckN7nnmQuCPNBacwHXirnVaw5mb4XWh8dpJwUzJQyTuu0i8oXSUzXYLoPdUrCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb313711a9so7862486d6.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727757009; x=1728361809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7hW/+3DhDdCIZ0y9yFtlGi3toUuAjY/x7u3Dk5l7yQ=;
        b=NLs/I+AA2EpwpK/wycgR6UwtLxAMmliWELB3QEP/ApCJJQVEV+KDQHvvWaMGyYYMOm
         aQI9AqoPsBzSpLWOLRLAkMyk3W7theALp1WMDxoWGp2sYkVoSZLTWwI8BIpW7uD5vNqE
         JZ3GYpbT2zmUvqJUzeivS8yCeht+Tw0DNZrQhUJMFCl3RZtXnfb445tYPthdbkejcJJd
         M09C7PeiBJrezKcXV7qoE/ZJPvEQ8sZ9BJltfN2yW4zPwA/jf5F67bZZsk8oN0b3O01Y
         6qkIp7yueVz8wk7MEAeRwdLJLGDhYzg/t41I4P9DZceBDfPtSyBYUrCygGqr6p2VJrYk
         ck0w==
X-Gm-Message-State: AOJu0Yyw/nEGPYK898sSvFi5U370NHFO9OLvvwDrF+CoZPl2y1oFGNNj
	KzQRWGhqv+ot3Lo5YHuX0+p627n0hCy/36HkVzdVsVXuCZGjHyone0on8S4zo0Qh4SAgxFqZc5p
	d+80n7OICNNpo4A7+iwyMXj07D0s=
X-Google-Smtp-Source: AGHT+IGAvzlC8BoW3JF9IVDGa5hF51G7vB6OpocFj2yQQAZprnt+nCSpiEpx0eKB1/qqLF7KaWrnthIb1HhwZEQPcOo=
X-Received: by 2002:a05:6214:528f:b0:6c3:5cd3:9faf with SMTP id
 6a1803df08f44-6cb4bebd423mr70424616d6.7.1727757009042; Mon, 30 Sep 2024
 21:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ7FMP0RqfUc0TKxJWn+tGq6tRhhABmbpd+xJMc7SRL6F5=JgA@mail.gmail.com>
In-Reply-To: <CAJ7FMP0RqfUc0TKxJWn+tGq6tRhhABmbpd+xJMc7SRL6F5=JgA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 1 Oct 2024 00:29:58 -0400
Message-ID: <CAPig+cSBvU8Ne29SpV7fZeRPmU25EPQxxxmE+agyM303kDoPCA@mail.gmail.com>
Subject: Re: git commit hangs when run concurrently on macos
To: Bennet Huber <bennet.huber@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:58=E2=80=AFPM Bennet Huber <bennet.huber@gmail.co=
m> wrote:
> After running this, wait for output to subside, then run `jobs`.
> On my machine, I usually see 5-10 hung "git commit" jobs.
>
> > 3:39:04.020533 run-command.c:758       trace: start_command: /opt/homeb=
rew/opt/git/libexec/git-core/git fsmonitor--daemon run --detach --ipc-threa=
ds=3D8
>
> Setting `USE_FS_MONITOR=3Dfalse` in the code above consistently results
> in no hung "git commit" commands, which leads me to suspect the
> problem has to do with the fsmonitor feature.  It's also a decent,
> though difficult to discover, workaround.

I don't use fsmonitor and haven't particularly been following the
issue, but there are some active threads on the mailing list regarding
fsmonitor hanging on macOS. Perhaps they are relevant to your case.

https://lore.kernel.org/git/20240930194600.GA1805534@coredump.intra.peff.ne=
t/T/

https://lore.kernel.org/git/20240509162219.GA1707955@coredump.intra.peff.ne=
t/T/

https://lore.kernel.org/git/pull.1802.git.1727577690390.gitgitgadget@gmail.=
com/T/
