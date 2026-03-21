Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291FB38BF85
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774100176; cv=pass; b=gXqaq5j5YmGtBWoFqh+eOxVUNng7rCFtbryrdgeuyX3caQ1/r6lMzv83TOAGu1xoXrvgXQZAczDvjcvit+iSQhEh5ynCGdHPdw2B6HrREXbDzV8V80OuzJfn5PivWRMKTYBC3/Rgw9C9XBG+ADicai6Q0oCmB7ShJXwMOUn9DVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774100176; c=relaxed/simple;
	bh=PXqdU2gI8hO04bYCcO/FkyHiUsP+7oOCwglU1Ms9Vc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXTXFZB2+D7y4GwIgqgKl4sFOkzrBrRrNCNaNPLQLb0InsudLZ9P9DL9avuS+UYc0t8WJuoP7ynsn7cSHnqRDvD1bgpvtoab55SOBalEAb4cjHY2K1MybKjNom6wDhITwJ5OXTxeaFIZmUkDbXiwvebJDTe5/vK6xtpX3wLQRvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i082ArxJ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i082ArxJ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1274204434bso3082654c88.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 06:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774100173; cv=none;
        d=google.com; s=arc-20240605;
        b=WoXQhQCvYjB1hfzXtzVsjb+I2aer6he9yZo2+xTvaN5llZHntiXis8ybbO+/Ly8ZzW
         cs2/7jQcjVA8e+zNx2V0z6AIShqKgKvJ/P4ohxJ29iUwhbXe4pjOXUBzqwrKUvxK89Va
         Z/qdnPmnuSAyuzLlotb3UR4bP6kDFkrVpwVMD+uywi/qVI9RGefC5/+ayIrpnYwT1RZX
         Z5YTMrUhBgEjbjfYrVhQq7Vlv0Z9UGMyME//uTl/pvVmikz+9fRSwYTSQeVRiC88so2Y
         4r6CVKR2QTw2SONDuh2WuLuJUkc8oVmgnOeljSSMvX+S1blq04HJpTOeJ1CSr6EdjANw
         I2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tr3HuGTA3FFUQUhS9c8PLlLBLA0kbYiRHab19/hGrg4=;
        fh=6OWf6tj4hIALvOa6WQM72LFyHa5OnM1ZmulFTFFFiwg=;
        b=ZQCn7bz2QMyv5laB1xL0YArUR2Rr1knl3uCaJT8YrHkfnvaQzPUDtPFLhNf/7txp8n
         OHSpj9FtMi+R0FqaT6ECEMukXVOtd7iRRXXBMDYZz7DVYRgrktW1JQ8xIq5OzYmYFNmh
         nbG3hmqmvqCx3dK+BZFd+NT6FULAJo+3MVUu2g+ZUL62AyuHkUa84tjEQdAAcHjrRAkJ
         kkhUjtIIfTZIXP/wkHt6wA4hdMhrq78XaNRFOWgbusml5endg3aRDUb0xoV8AhCgEoFK
         KUBbq6UJS19orAfV7rcHWlHavFsujdsxZl5Wy14MUjsXe5gCP0b2shgg1/gdJYVgSGc9
         VnmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774100173; x=1774704973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr3HuGTA3FFUQUhS9c8PLlLBLA0kbYiRHab19/hGrg4=;
        b=i082ArxJuMC2oPgikbsCqYQzWFYLYQojXkklPu8RwMqJx+3WMx4kFNNxD00zN3hYQ2
         ruvvfwEf/9GLGoCibvTXLuvk8+65Q++Kht4zxazWxOeEfm7Z4v6KfoOL3Z9A2y1et5Ph
         0HCu2DP2AQB6s9ElF7vs22gr7jhcnOvuM26g7FZ7Daqg7iPFIkVXns63iYhNjzg6EK4s
         udpCJcZqCjLCofSaF1NyCM2rWIXIdpcS3K7T2XgIPt68Zg7j1wsNBrHGOOqSkffeoJu2
         293MzgK/W6ldU1QFg7dT9cwnYL9uRjCCarV1DrJHcYO2CXX8WigWmNeSvDtu86H8YSfH
         n08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774100173; x=1774704973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tr3HuGTA3FFUQUhS9c8PLlLBLA0kbYiRHab19/hGrg4=;
        b=Id2Oii/TXY61FTX92kiTr9YBtrDocQyqH3o+gxICMFKzfBpePSEd6+wNO5szLfPwda
         Ef5TEzEs3kMQN2mOTYx3oTX2PeOdDzzVi7Uk8NvaikOKKS1sLURl540mum17637aOLlC
         xbZFxMnNVZ7+6VrLn55/MlyzdRRfN0JwKve9FqZCzWX+IfhZC0BMxQuIwaeP3hLelnSQ
         Juv3y9WS9nzc5GOrC+HRUNVVvRzVq/EidMJQ12/eym3nA7G8AJKs0Cav0/cfhadYXgx9
         CIzIboRHs0Hr0Q/3J4Cmgp9tOPL69KHQDfid5f3+lG6KuhCqx/Kwd95w0cvs7bxe0syu
         QuJA==
X-Gm-Message-State: AOJu0YzoXpVM/F5Yj9ZljqPAZhk/dsvrPcGRitOIZ03V3zjjrm4x7h/A
	tKFcJU/0abaenVSuYZgl59ETCqtK9hbKC8HPBBS7NTfbv7IXsR/47y1aySTgqQ80hHmepGziAOx
	pqjsnk/OkBJ4s93DTlRkq5LzLNRShb5E=
X-Gm-Gg: ATEYQzzQOBFyKla/caHUe1mFNAEKdQ/m2qaChxLDbECm0kP1rygj7Dz+azBc09f2dVx
	LIBIwJJjGHh2YKqL5gtqqywc6bO+XoIPyxdK1GaAQzaj4mMAdCD6g/5vmSe+ctDQQYeIS1mUM73
	U7fVlmyvazWa/vLxb1N75ReQ7/p5jo5mH8C1g2RKEVpSMZmvRL0pX6U6bH5akEMAAEgxiyxFTZd
	6AhgvOhqjiwZAoSNvPlctWc9iuGpzF50337gpSXqwl2JQIsfKVLqrsGirW18hM/C+H5igFIgLUY
	I0IZHmVCeWiYs5oXRVJCX2xILM5jdfU7WVeszYqS7ZNWpOaUykUx8sR/bQoI+fob0XK+dZ1m0+1
	iJKE=
X-Received: by 2002:a05:7022:41a1:b0:11b:2a5:3b9b with SMTP id
 a92af1059eb24-12a722b7d25mr2638486c88.8.1774100172743; Sat, 21 Mar 2026
 06:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEaT9_9jAoXkxKn+2+q654aKybC1=bk6p7xiVHmcy+YDDe7GXw@mail.gmail.com>
In-Reply-To: <CAEaT9_9jAoXkxKn+2+q654aKybC1=bk6p7xiVHmcy+YDDe7GXw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 21 Mar 2026 14:36:01 +0100
X-Gm-Features: AaiRm53rKKc6sV1SrRuwwLuK-N0sEy3Si8QzUOATomHI6cXz43GbSk_jE-T0Mfs
Message-ID: <CAP8UFD1H8ZsxfGSnnvX9xkKLSSpDjA3e3KNZ7eHN3ruq-sC7fw@mail.gmail.com>
Subject: Re: [GSoC Proposal] Refactoring in order to reduce Git's global state
To: Francesco Paparatto <francescopaparatto@gmail.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 17, 2026 at 6:54=E2=80=AFPM Francesco Paparatto
<francescopaparatto@gmail.com> wrote:

[...]

> So far, I have made the following contributions:
>
> * [GSoC PATCH v2] t3310: replace test -f/-d with
>   test_path_is_file/test_path_is_dir
>   Link: https://lore.kernel.org/git/20260228005939.9012-1-francescopapara=
tto@gmail.com/
>   Status: Graduated to 'master'.

For commits which graduated to master, please give the commit ID of
either the commits you authored or the merge commit that merged your
commit(s) into master.

> * [PATCH v4] t3310: avoid hiding failures from rev-parse in
>   command substitutions
>   Link: https://lore.kernel.org/git/20260307103631.89829-1-francescopapar=
atto@gmail.com/
>   Status: Will merge to 'master'.

[...]

> Context and Prior Work
> -----------------------
> Not all config variables can be treated in the same way. There is
> a fundamental distinction between eagerly and lazily parsed
> variables, and conflating the two causes regressions.
>
> Variables set in git_default_core_config() are eagerly parsed. They
> are read at startup, and if a value is invalid, Git calls die()
> immediately with a clear error before doing any real work. The user
> gets early feedback and can fix their config.
>
> Variables in struct repo_settings are lazily parsed. They are
> populated on first access via prepare_repo_settings(). If an eagerly
> parsed variable is naively moved into this struct, invalid config
> that used to crash at startup now crashes mid-operation =E2=80=94 the use=
r
> may have already started work that is now lost.
>
> During GSoC 2025, Ayush Chandekar moved several global configuration
> variables into repository-scoped structures [3]. Through this work
> and subsequent review discussions, the eager/lazy problem became
> visible [4].
>
> Ayush's work also surfaced the getter/setter debate. When he
> introduced getter and setter functions for repo_settings fields,
> reviewers pointed out they added no value without calling
> prepare_repo_settings() internally. From this discussion, Junio
> suggested two approaches for repo_settings variables that must
> not be mixed [5]:
>
> - Common variables: populated in prepare_repo_settings(), accessed
>   directly via repo->settings.foo. No getter, no setter.
> - Rare variables: prepare_repo_settings() does not touch the field.
>   A lazy getter checks a sentinel value (e.g. -1), reads from
>   config on first access, and caches the result.
>
> The appropriate pattern for each variable will require reasoning
> and discussion on the mailing list.
>
> Phillip Wood suggested a third approach: passing a
> repository pointer through git_default_config() via the void *cb
> callback data parameter, so handlers can populate per-repo structs
> without touching globals [6].
>
> Building on these lessons, Olamide Bello during the Outreachy
> program introduced struct repo_config_values [2], a structure
> linked to struct repository that stores eagerly parsed configuration
> values while preserving their startup-time error detection. An
> accessor function repo_config_values() enforces safety by preventing
> access from uninitialized repositories and guarding against access
> from secondary repository instances that do not yet have their
> config populated.
>
> So we now have two structs living inside struct repository:
> repo_settings for lazily parsed variables, and repo_config_values
> for eagerly parsed variables.
>
> Approach
> --------
> I will follow the pattern established in Olamide Bello's approved
> patch series [2], which provides the concrete workflow for each
> variable:
>
> 1. Add a new field to struct repo_config_values in environment.h.
> 2. Initialize the field in repo_config_values_init().
> 3. Update the config callback: get cfg via
>    repo_config_values(the_repository), write to cfg->field instead
>    of the global.
> 4. Update all call sites: replace the global with cfg->field.
> 5. Remove the global from environment.c and the extern from
>    environment.h.
> 6. Run tests and check fuzz targets.

By the way there is also this series from Olamide Bello:

https://lore.kernel.org/git/cover.1773127785.git.belkid98@gmail.com/

> Timeline
> --------
> Project size: 175 hours.
>
> Community Bonding (May 1 - May 25):
> - Discuss project direction and design approaches with mentors.
> - Study Bello Caleb's and Ayush Chandekar's patches in depth.
>   Review remaining repo_config_values work and identify
>   unfinished tasks.

It would be nice if your proposal started to look at the remaining
repo_config_values work already.

Thanks for your interest in Git and this project.

Best,
Christian.
