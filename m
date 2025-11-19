Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD613191B1
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535019; cv=none; b=dKxeGd9KQlf/Cmn8vWsgx2noi0DCEFS42AnmjPizVoPJchy8c5qGrpQohY866Z8lBo3SMjwG9IfuOy+OSP2Ega5GHhGgt9gKW82nKiEsQmKMqdiWJpUILsAKEI/sF0lM3rqm+rYkeFag1Nu8JedV2C3hmX+wcQol6M2IMwp/qbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535019; c=relaxed/simple;
	bh=6aV8GX5wbIilucoALp0ftrXfSfqePZAFHPNnTo1TYWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvK1wVeylSs3Ekqgdfdoe3EssvhhYmJzFIfljneESVPVagTzoKYeXGCJATSWRhtYh4Yy4rOfinaIAQEPQ9NloEMBUBifjJP1AnFmsLpWLGhclHuup2/xr1i9MYRJytMkkAMa0gJHAhkn5nyKoqkUeoYFC7EZpJHo0Dqo9cQqUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2e2500517so81073485a.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535017; x=1764139817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aV8GX5wbIilucoALp0ftrXfSfqePZAFHPNnTo1TYWc=;
        b=Bh0czDUYiJWAEfC59cgN4gn0zDlCegb0NxGXY8bRDim5xKPRuhMdrCTXyaZXtotA5T
         qOK3diuQ3JGkJgH10EdjyqB4hReJrlryn4d3y1T5yO0TUn0HPDeqJBj+a1fQZBgLqcDE
         r5nozM3kfFgMyGBk4sVHoacD5G3Nmh46NDoCT+n+MNxKAyPQURaICUbzQM/xLe0ylw+p
         +onlfrq/BPpkRy+BC5VsvcEyaKL5Ah2aruZYVg0FOpImfzhJ/CY8UjMdm3DXcVX27Xu8
         hG0oR8ySxhwT6PjfT03cAcSO+Xpz0xv6M5GtF6O8QNNqN/3war/dLER+D8JQeS9h3RA8
         on8Q==
X-Gm-Message-State: AOJu0Yzh3yhCMhWg5X/zNeu9J50+HEszKkL/0S/2ZETOT/OBz2e4QXW0
	KzHgFMcPakE4suJowv7mWOeIYHkj8COpRpdC+a3fxnOL3fFm+4JooN1FmPcyVuHXQ+a2QWuAYFI
	x0h4HjkKmxEGEQ53zwgZxFvgHgfavFF0=
X-Gm-Gg: ASbGncu6bcsUcsJ6he0ze0GOdpt+oJ34RrTqVnsPXKno5MNcr6vvoQ/ro//iCs5UZaG
	D1WIX1OFjCzaYk3+ACbU9neLcN3lUq4EVInSihi+ITPPR4PhyiTmGlS/9T/F0ikCiMob74o2IKE
	84dPHAbWK8BpCcj44ulBFbleKv4cCUe+HQXrS4J5bUexuaJLBfARtPs5zuPRIWp/TxPJdzya97m
	Xev4mjlA1dmFGrdPqZ7dH1dKYpaAvAN3wuErY/Rn1kCPzc848mVjXGaWh9zJFkBHs9FL+yZFEFd
	6CFFpPmfyTIAqXyvR+yWpx1IQ6I9mVeQzWKKt4yPst+tm5I+
X-Google-Smtp-Source: AGHT+IEoWt0jQ+Xcn9Vwpt+rB66OvOd5aicb6p6GakJ5WctspjN/ebcFYw0NmaWUdX9bsSg9KVJIKAeAj55VEn+ATVM=
X-Received: by 2002:a05:6214:4101:b0:880:8322:8617 with SMTP id
 6a1803df08f44-88453c19c00mr55495336d6.5.1763535016695; Tue, 18 Nov 2025
 22:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763482051.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1763482051.git.phillip.wood@dunelm.org.uk>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 01:50:05 -0500
X-Gm-Features: AWmQ_bkhGCIK4JIi7gKsq1lBnsLAahl1vCI1uUnmrHAsDb2eZo2wCmVNnHxUXKw
Message-ID: <CAPig+cQyP=v2MBEUE=fSON-N-vJgxT-bmVV8nWnoz0JYGc89Ww@mail.gmail.com>
Subject: Re: [PATCH 0/2] worktree list: fix column alignment
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:07=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> If a worktree path contains a multibyte character we end up with
> excess padding between the columns in the output of "git worktree
> list". This series fixes that and quotes the path to avoid control
> characters messing up the output as well.

Thanks for Cc:'ing me. I've added Michael Rappazzo to the Cc: list, as
well, since he authored bb9c03b82a (worktree: add 'list' command,
2015-10-08) which added the code in question.
