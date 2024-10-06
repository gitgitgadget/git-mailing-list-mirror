Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2CAEC5
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191509; cv=none; b=OEQ0z9PAiGIMFbT2oxooZXWCLSJrYwCfO3QHkEVzgXzNtnWltqHRIO4wSwBXFhD1YVsw5wP2HW4nOv9x+u7losxQLusCCX1ZEq/NFHwPEqcjGVe9XABh6rRPqHpCh2MDmno9jeX2HgMy/bxOA2IyPdr6xicHa+nkZtFf61G9JWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191509; c=relaxed/simple;
	bh=O/ubpcf1o6YB1PmGZZ+UqjI2oXCBo4oAvOidHsp69dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMntlUevTJ8mXSf3e7SZOfGcMdrmvABlpEt43t8zbqPjWs7RVZ4gzBEj0G9OF3xwOOeSZ6BFw5aSjvIie+Ioh1pXj4oGGXfGWs8Xaj3BaCA8y4PAnSAOP99aetSdxruiFLvjs8Db2rOAEhe8cGXS1j3htT48YsGjafKbapQy/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cb48e77b16so5273236d6.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728191506; x=1728796306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/ubpcf1o6YB1PmGZZ+UqjI2oXCBo4oAvOidHsp69dY=;
        b=HS06vuvc0iZApVL57eUl2dgdB1QTThhrph3fDhWGTk048PpxKbnhf56NeP5YJLPLnV
         QDhSUBxVTbMODsrNBBycDg4n6XyVOfTgidYguou8wwXWCYjNAOpNCIBsTOhi4+sSWw8f
         aZ6W+kqztnPlfx5uW/Zqdk4oKqUT7X46ypKJKrcn2F+r4qlgHTecb/QxF7udD43bAhZi
         v4hR4Vaw6YNZ2tsOdzeRs58reJ1NXiePGyPGNYfv55f6ew5QmOG7h0YRJokaih3ZAdHt
         ovoKumpLEqPE2ObZRY0UHo5bm2aAC426jwoCpOzSKdfd7ZP34aEFkiJf4vkAkfJzrmOU
         MCjg==
X-Gm-Message-State: AOJu0YxB1BFJj68909xzUTBxQfz8S/m36e3HzcDHpLTS6xPWZ0r1aGTK
	AGunSyvn1e4DhcaIDAGbxNY5xoA72SnwLZq7yoZmUUWviGbnPXEGCix5A8oar4qScyjA5AKX1Q8
	z//zvBMk/ODLskUNuY4gLybyfRfI0lHsu
X-Google-Smtp-Source: AGHT+IFdrtjt8c5J/ovqcnsHVL7GYssaFoM2rLnM+1nvNsZOUOIggbKqOW+smRZrnlpY+1tqjdH0uhJbOXSQNPW3Tuk=
X-Received: by 2002:ad4:5ae4:0:b0:6c3:69f9:fb5b with SMTP id
 6a1803df08f44-6cb9a02b35fmr58902256d6.0.1728191505934; Sat, 05 Oct 2024
 22:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
In-Reply-To: <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 01:11:35 -0400
Message-ID: <CAPig+cTVbXVffSeyNAV3c0zuSUozY7giWtMw3GpHs+xVEpaNvA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:04=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> On Sun, Oct 6, 2024 at 12:59=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrot=
e:
> > This patch series modifies Git's handling of worktree linking to use
> > relative paths instead of absolute paths. The motivation behind this
> > change is to enhance the robustness of worktree links when the main
> > repository is moved, or when used in environments like containerized
> > development where absolute paths differ across systems.
>
> Unfortunately, these patches are whitespace-damaged. Can you please
> resubmit using either `git send-email` or GitGitGadget[1]?

Also, since you're touching infer_backlink(), see [1] which makes some
changes nearby.

And you might be interested in [2] which may indicate that there are
some holes in the tests around worktrees which might need filling.
(Since your patches are whitespace-damaged, I haven't checked whether
your series succeeds or fails in the way the series to which [2] is a
response fails.)

[1]: https://lore.kernel.org/git/20240923075416.54289-1-ericsunshine@charte=
r.net/
[2]: https://lore.kernel.org/git/CAPig+cQXFy=3DxPVpoSq6Wq0pxMRCjS=3DWbkgdO+=
3LySPX=3Dq0nPCw@mail.gmail.com/
