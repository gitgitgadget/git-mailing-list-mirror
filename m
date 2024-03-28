Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A242A9C
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646660; cv=none; b=oH0MbRR2uOJLuw3OJKSCw5Y+lirgSRDqYXox2F2eCZQJCCAGvITol8ZAPcD8JBZ41JPLFXVrLSgNF0FMNjCoIV1/Jm1ka9CaQnwGPGxz9OG7T7IrWDrtAl+JI0cwgcxF+V36c8KEkzi4aenKAtM5R0h574NZtzlY+z64GqkNV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646660; c=relaxed/simple;
	bh=bXepF04mJhqqnk/Wlxn16wXYeAVRCMGCmtrMI84KbEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsZnAbGzdu6D3+JR8JftopntKYGHGKV8KoeLSLKMKoHDr2yb/jxKqPi7RoxD1+4YKP80Q0H3McoboH73sRcBp5sAz9ZSPXnlLzkN/X763cqP0ZnwBIXg1GIAQl1qjmJgC/+WQhvXA9GrA6L7jTRKK42bnx5q6SoVEJmlSyNlhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690caa6438aso6474986d6.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711646657; x=1712251457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QyDOzD49tAUqkNONhDAXABLtojeYh0hojG12QgoTTM=;
        b=bDextunj9yx0GigNpqGq1dsHQ/Na66eObucwNDjiEfEE27Ik7JNNyn6nzpu56ubszA
         cbR9Rf6jHQh950hu6qweagQxQfROe/vM+XqawR77LHPgf3+AVKCy0PBmSHNW5k35ZIIG
         WtdSd+MBDOLT7Ar3zPO77MJOVEyek0TnXft538YVlhw+jhPM5kFmjGrE8N07DGhHId3O
         3R7jGYEFXq63/Nyn7BX5SDQKFzNsL1R7W6Uk/V+0kG7gmgYM5cLBh3fByWu94c0KIkmt
         SzFvJNCggaQS3CbiRMRCDP1yqq7kYq3YjFqMSoLNUK6k1AOnCQHb1A6YU2oIgXSS/mLL
         pO9A==
X-Gm-Message-State: AOJu0Yyb+abVtpp0w6wBOw1a2D2Nqucx8sJowuEh53pVA20ED/7+1dRf
	EEIF8nf8+W+kqavOy6KHcCcfLwdSRHTitq9mEClWxmNuJCRqUxxnoUm7lpCwHRQhkkxe2mofyOx
	AaG8LiMEDuxMLsE3EScveBCTGVkujQk8WPpA=
X-Google-Smtp-Source: AGHT+IFT088FuMhUfpcUKtJ7nLCPJs4RzTa2J2NR98bXk+UDaG0Mx5HKOB2pual49vyRxWxMngpn44eEB8OAN1kTOVA=
X-Received: by 2002:a05:6214:14ec:b0:696:b106:916d with SMTP id
 k12-20020a05621414ec00b00696b106916dmr3061134qvw.42.1711646657099; Thu, 28
 Mar 2024 10:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
In-Reply-To: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Mar 2024 13:24:06 -0400
Message-ID: <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: Tamir Duberstein <tamird@fuseenergy.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:54=E2=80=AFAM Tamir Duberstein <tamird@fuseenerg=
y.com> wrote:
> % git branch -d cleanup
> error: cannot delete branch 'cleanup' used by worktree at '<my source dir=
>'
> % git worktree list
> <my source dir>  dc46f6d5e [main]
> % git branch
>   cleanup
> * main

Is this error persistent once it arises? That is, if you invoke `git
branch -d cleanup` again immediately after (or a little while after)
the above sequence, does the problem persist? Or does it "clear up" on
its own at some point?
