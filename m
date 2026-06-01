Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9838B125
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349465; cv=none; b=R5Cshoea9lADMf2gzhqE4nze7uMIfMCRph77xRFfoFcD/8FeKD9tnwBPMeg2w8ykQuSk1MSfzARu05HzSdqVgxAZrrY5BK5VpyBZoKkCqaIrho3elDzauKdO5rS/3LGwkhRUi8zGBzJHuOdtThycPxf8MhYeBzYu4XlB7idKBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349465; c=relaxed/simple;
	bh=alvKlOtGj88vn8udT6IEoeZ2waOauA70mtO4zH9kwhk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fbrBG+SBzzNdTH9NHmTMOt4Hr9p3LUjZKwKsc164HU3O5/DbfIYkRwZtE7Zux/zBAd5Gq7x2oRaz0JLPTgUDgCUhYXxMr3Pfmcqa8KTH+LF7vBwnbcYL3uMIYp2aFgAB0dVor668aIZBC2XOrP0RuImVQBymUXCSjoEIvphyLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVz8Bh2y; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVz8Bh2y"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59e8ededf4dso1464798e0c.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780349461; x=1780954261; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTZfXXpikRZ5OZPl3jwUNhIoZky9Z+S4zdD1+fWUvjI=;
        b=HVz8Bh2yOhe9VTHtU1gDo4s7huY69qwM5qD4dRZEzHP6yqtXMOHhfAEUJXja+DAdBO
         Sez5kOWshgh7cs4gjlFiVDjb5hSs58KVl9yIq0FC6ERqIWDJhmeQvAq73HCRBZs6fa7Q
         o72y1lU5FnRImcdLe7q5jzwAiQoYDVKsMsFSl9Hlxs4kMw7rMmUULi3FPxHbJGGCZVvC
         6qNXqR6p7zy5XGGKX1TG0v3dC2gciDJ3jgFMJ7xl730gF1dAvMJdCLDW+dyLF8nklc33
         BA09P0nfJ/Rz3eTnpLUvIg4HgWjn5cLPFbwy6nRjMvo+ZXi9jRU58VunBuzzhKaJtjo/
         sDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780349461; x=1780954261;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTZfXXpikRZ5OZPl3jwUNhIoZky9Z+S4zdD1+fWUvjI=;
        b=FoSeiLG+1TWPd4/ibP2aY0G30G3dJNevEY3IOJhMRxGNCoVn2PlZ20xWzs3ci5I7zY
         rS9c/eaCLFRginU3jK3BJJMh/r7PBNriuSihzj55SXDHmw0Fnrkus5X2x66aAsyAGigG
         zcfCFu6K8DYR5jCPIRQm/FShIJo554CiCtZLO6N/GTaQ/0YOI9zV9uz6rrsl521pLz1v
         iWzVm9EW3Mp+xG1dipNEobKD86b/NELVmwkKnLGyLDuraa4UljatMw2N6GT50qGofaH5
         SHRUj3dh4xRNAhSJwY5tAqyw1kFNlsGVXlUSbS1PViTfFd9/oBPFC3FnFK8KQ0Qz7LjM
         sbMw==
X-Gm-Message-State: AOJu0YzW5LTQpaAJ3vtBx4x1erEHu+oXhHywF72RZFth9vsadnXFn6nB
	0Q6jMvYYSjkbMOegxOEfcD/TS4pq9LENXVzdesFQoh3UFrA0wt0AhF1F
X-Gm-Gg: Acq92OEhZUExkhUtHesWagrwBoKE9tBI5R/Zbdw3ev8Dgfc7FBNFJKfUWc/d00497kA
	nat/0Ofz26GBJQCqbx1/23G0XgXNscHNm3DzRqfyNg3IYNzq7ySYDbHpsBKfvDaeaojB2zblS9Q
	9emxOJRVi994MYhEVCeZMXWITmaa5qJMjj5ubYnVxLYcA3Yslr9xTDOmoNyb3J8ZikXFSFdZGSa
	C3xeQeotqFTsgVfLJc8M/uPj0HY2h5I3LbnRnQqNNlNZqa+mr9n9yWYb23E21ZO8zO8glJo9Lvk
	egL5IQLQb9Qx2zHuC1GpBmLZ/by22kiUUVDPrNXjL+otV8bZ5g1E0yS/L09AxAuxYfSNkTW5yHZ
	Cmue2NNxJ57pFogqKAUnnjMBFpsFvzFeOqj0ddsExxIzXijg/pQf594AGHo1GkBlSPwuH7V7STt
	m8sCrwmTx6MgsWyr+FwsvEykoMHNKC04NUYzlKvj3nZY80yZNZJHQIH8wekHvH4cE=
X-Received: by 2002:a05:6122:88b:b0:575:634a:a604 with SMTP id 71dfb90a1353d-59bf26f38bamr6797093e0c.6.1780349461489;
        Mon, 01 Jun 2026 14:31:01 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-599d3c9649asm8339341e0c.1.2026.06.01.14.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2026 14:31:01 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC][PATCH 4/4] repo: add path.commondir with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260601151950.30686-5-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 1 Jun 2026 13:34:29 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <11C531FB-2397-42AE-8F18-BF78BA779088@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260601151950.30686-5-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 7c7dfbb052..dd2706e1f7 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -184,6 +184,7 @@ test_expect_success 'setup test repository layout =
for path fields' '
> mkdir -p test-repo/sub
> '
>=20
> +test_repo_info_path 'commondir' '../.git'
> test_repo_info_path 'gitdir' '../.git'

I was thinking here, maybe you need to take a look at
git-rev-parse's tests and check what are the corner cases.

For example, `git rev-parse --git-common-dir` documentation
says:

    --git-common-dir:
        Show $GIT_COMMON_DIR if defined, else $GIT_DIR

This way, you should take a look on how git-rev-parse tests
test those two branches (GIT_COMMON_DIR and GIT_DIR).

