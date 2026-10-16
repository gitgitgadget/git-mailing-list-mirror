Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DCD49BB52
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175799; cv=pass; b=I1aOL6/Ep+zNmIQRY4kLeSOXyXoaLElK/GlkBByUt9ijq445VdElW5czfa6EH+lAxOJ0Z+NfgfyWUcOnwVtwu3Te5dQ99E91e6xt768N618SiqF+UOQYbBye9GjWGX0ogMp5f00etS4bFVpr1kZ4ztxZJBihzoylkk+QTPyMuaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175799; c=relaxed/simple;
	bh=i+dhXyRxiNie+BvMUAX9iNj3lrqA6qd3N013Z/YTXVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5/vKDL4KiERkGgPAVgJWeJeZ0Z/says0bWAc4/oFpnzaGYHJiGr12cOwQtILOjdpvTjl6FH2rP3gSBcvkVJAEzo4puB9LRz8x/qj+IWAVpPrMQ1yec+OgfRoHty0zk3mM2mHmFQYoWJz8CUbbIllgmVpGleIlI+yYBbFOylmDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru9Q4KZ5; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru9Q4KZ5"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89f81643121so146416b3a.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792175797; cv=none;
        d=google.com; s=arc-20260327;
        b=iyEqHpTJFKCwjqAHc6L0axzmoQnROgfIeEq9KUIFTahl21cTlzQvy5CZy6K5I7ZoVs
         tZV/32MFqYS8dfI1TsNpx35cvGqHkkiOAo1nUuBO9vEI05tZufJYelnLfABSafmkZBUT
         1kgov1n0MqTgAutxvDboNsLSV6JmktpJNel+Qgmtl7EP7kH3bTTnxtCZCgQP0gAPe5eI
         MZXNLdJz2Fdn1D18mPpe5c9X13xSdLZUhxxAU3rDs+nuXLAg0MxDbGxkYkRcpdYVxedW
         Rk3Yhy0JqwOl6L6iAF8NKO8hkjJ5TvPr2MILhKnEXEvujABCa+c0ZlCLtZKw+XpVQpFu
         hh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F0FcUXGK5lo6xWcyJRd8zS76vdKZ13UpPzXMYR8tOSg=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=OLYE0gMKxXjpQlpFxecVEJB7bCX7Oq0Uvm4ExYN+Z6gzW65/W71VCMRz+1vjsnQQi2
         EF8Ljvy96Yfr8w9fyjMx4Xkn74UExMqww29YBHAxmsj+NZeaT/pyIWiBsh4HFWzIiQxU
         YPk4yY4nlE+lJUAgYBd+qXE2rc7fYAvhaV6lddFWPtcA2uLU/a+gvF8kG4smOzvSUOei
         qg04sFJZ/zRlMhlk20a+zZrkmzf8m2hzx6Dm9wq7Nv34+QANNMGP0r6xRZCbb4r88gs4
         HZQvXX0mVQdslxv/JK3XCPwLCeOfE/gx+WHAtpl6RNyew4bEqXnl8UpfAjQ30Aw0qSa/
         DMHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175797; x=1792780597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F0FcUXGK5lo6xWcyJRd8zS76vdKZ13UpPzXMYR8tOSg=;
        b=ru9Q4KZ5AmG6sRXu0G8lwHhJXKPk8xp0zyqrtdjIyxujIX5lB+oESXwgrXpt+7jxH9
         8TgYgdVPdVQPwmvmAKJRtwprErKSnGRpjRrTx2wRyvkcespYr6XA/NFQTJSw6GbYFI/G
         F0Aqdve5yElET9tP2TpMcO0HvRrorj40sn9T8bOUL3OJf+XjjPU5C4kLAGypz9B8TDC0
         i3VGoA8g53/uhZG6fOFj/ZVDT1kzGo5RdfiS85ARABYSICZxx8HP2rsIqluL2UcHrBPm
         Epkhc9P2Lr3tjERJb4V3Bm3m7cRHpi//50VextDJxmPed9AiL7ws0ei/6MxQT401HZY4
         iqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175797; x=1792780597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0FcUXGK5lo6xWcyJRd8zS76vdKZ13UpPzXMYR8tOSg=;
        b=zafdzh2yVpwO67Lhi0yAgKwZuBIxwFgnXdJTiylDKZMk1DqatUyeM7k7us4zIBTFXi
         m6Qi7/rt6x7Or3bJPcQBiJZj40+HEtFCO1DLX3Oa7HXl1b6RUg9kcvm0KjW3cJRpe5eG
         7X9j0DCjEIkJ6mcaa0xqpJ/0hJASO4GSCWxr8Y8Eo/jx2hPi61cdia6c2M+ZVXe9Emup
         G3/Qkc81ANI63p8B4Jl3TTaV6J0fCYWmHIY8OYNb5Q33RNzTvR1OUfo8FlM3yDVGL7iQ
         +yMR+EQMmRdU+j3aLBU454uInZ2noOJ8gnDObkSVyMwom4//fLrZzxh6VD5HyqT/vtmu
         Ayjg==
X-Gm-Message-State: AFq9FYKX3rW094o9a7E2UOLjPYkMJS5kGDLATWQ0HKLr87vFy1IvNKWK
	EcTpx4GAeD64khDG2xU45pPqrloJMIuuOQB+Mm1jGTvbVISgxFSeehC8REUg00NMfvrax7B5Srq
	jlTilVIQVgINizAsnXuVq20J45YHGMIzuQsKT
X-Gm-Gg: AYBFou3fKAYE7fPMGae5mmdZwaHOVzUzcsWFQRF99bhefGto1vgTW+C2FLPK2F8sNLW
	L9b1eu6zDC9khal5tRQW5WCefaXe0O6yLr+kwNqDfNSVphWLQtaTr0N7FRf6WvlKd2AWvzh/h8Q
	i+pcoblyMjVOSUU2bv9flM6zc5WF7aPbCVGQtrxw9LCoVyodvxdIy+bdZ4bYeVlpt1eQ/gcvAQT
	U3+gzZFqB9Tl4x8FbpPutfOQeSq8kuxSm1St6KkTEh2OZHMY2uXzplINaUnp8uBFL6ngwCfzrfF
	aD2v+20JYyPy1gPEYJNXUscbdOPK6YktvSHckKua2SvjFHtEycA4/PBTM+h9Wz5Ca8v07ia21o0
	u11R7NX4W+Aw4uuyKVI6juto4eUf14d+LlS/TOl0Gt/gUywHxKgRav4qAqXhCt5NvEJbYKodjH7
	7eSJTvDCDtnR3taevYOn0kEgJ6z18IXw==
X-Received: by 2002:a05:6a00:1394:b0:87d:3894:197b with SMTP id
 d2e1a72fcca58-8a04cb1ed84mr345417b3a.59.1792175797564; Fri, 16 Oct 2026
 11:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 16 Oct 2026 14:36:25 -0400
X-Gm-Features: AclHuK8gGKwFedrvk0_2-z_zG_tQk1GBCwERCJ9pGBT-IHnUiuaAaWNd3cgfLTw
Message-ID: <CALnO6CDOh1NCp4Y9euLbhVFJJnOc1jSk7q0ekdUeGniG8LTCGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Apologies for replying in the wrong chain; it appears I haven't
received 3/3 yet and it's easier for me to reply to a message I have
than one I can only see in lore.]

On Thu, Oct 15, 2026 at 9:20=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>   reflog: add --historical-branch to name the branch of each entry

> Teach "git reflog" and "git log -g" a "--historical-branch" option
> that decorates each entry with the branch it was made on, in place of
> the refs that point at the commit now. The name is colored like a
> branch decoration:
>
>   $ git reflog --historical-branch
>   4e5f6a7 (topic) HEAD@{0}: commit: add tests
>   1a2b3c4 (topic) HEAD@{1}: checkout: moving from main to topic
>   8c9d0e1 (main) HEAD@{2}: commit: fix typo

Notice how the "HEAD@" column is now not aligned? I find it really convient=
 to
have fixed-width data at the front of the line so that I can visually pick =
out
pieces in columns.

So I'd suggest an alternat end-of-line format:

    $ git reflog --historical-branch
    4e5f6a7 HEAD@{0}: commit: add tests (topic)
    1a2b3c4 HEAD@{1}: checkout: moving from main to topic (topic)
    8c9d0e1 HEAD@{2}: commit: fix typo (main)

That might make picking out the branch name a little harder, so I suppose y=
ou
could try right before the messages?

    $ git reflog --historical-branch
    4e5f6a7 HEAD@{0}: (topic) commit: add tests
    1a2b3c4 HEAD@{1}: (topic) checkout: moving from main to topic
    8c9d0e1 HEAD@{2}: (main) commit: fix typo

or (since the "operation" prefixes" are useful)

    $ git reflog --historical-branch
    4e5f6a7 HEAD@{0}: commit: (topic) add tests
    1a2b3c4 HEAD@{1}: checkout: (topic) moving from main to topic
    8c9d0e1 HEAD@{2}: commit: (main) fix typo

? Obviously the misalignment in all the examples (except the EOL format) ge=
ts
worse when you have some short and some long branch names.
