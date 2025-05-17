Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD779F2
	for <git@vger.kernel.org>; Sat, 17 May 2025 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747442888; cv=none; b=mHcrurAfcjwNrD8n/XDvuAS2sMu/446167Z4hyv8bHud1JpLOyJYY2sAXXsgzzRpRIbApsfEcgN+5uXvs5LK4NwjWX6wDOH0Vgz2Zxwk9pE1BtPetMfNQ1mFZ24Nx7PHIkWrp9Z5AGdXLkY1zVW8QMj1jEKIzninKIBpBdqACc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747442888; c=relaxed/simple;
	bh=8JhRk2sgMax5FuBO4aUbyGuFbv/y/cjeLAKs6jJPfzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+tBip9yog2ya1Yep1UyY2dTXPKme0xpbYKZ9rssJLJGnunjNl74zvd/cxoZBAFmyQdct9cUJS4aC3JAQRAFdqECWtSHcAXjlBfOGysowakkFMYsZCGFXLB95WHD/yxUVwuX8VtGcsg3Y6feWbwm2DgFJ6lN31t2PZ/VDzK5OVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9/9Xjav; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9/9Xjav"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d96d16b369so20462135ab.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747442886; x=1748047686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMnXlw3soiMmtw2/Vcm5aUFiE8fA5B8B4oRCrU5QokQ=;
        b=a9/9Xjav9siYFkTPYqoVcepjfrpkaxeDxMoK9W4u4A9UR5do4gJZOQ3x+yXcElzT8g
         KGTFSsTAnn6AkKcIEFHZv6YOc1bOLxr26+8f8zgmL91s65uRj/CweCtMdzLVo6O2J1QL
         c8tClra5Jt8ThWc4po6Bkj614t/c8ogPWAPb56TOpYX5cLsipYdqvfz+4YsWdkCcJ30o
         AAf7QxYpto+54P2XxkrhRGobPtyPHuTFOhG3oGLD55HsDO+O4nQVl3+SLkZO990DMiH0
         7QVOGejQbcAOHuGgkFIVz8MkDnt05WAfup04r3uZTWp22mNhLqzPQM+vRKn3NqaLGr85
         tq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747442886; x=1748047686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMnXlw3soiMmtw2/Vcm5aUFiE8fA5B8B4oRCrU5QokQ=;
        b=DFNvuIRzj41uRGzrXIppc1+KmgoY6G6YotKvfzI+bXsQtmiBN0G1WOVHA9uodVxLWb
         aRhtp/L3I2btDnU9O0L+zOe0SpQDnax/u7vEdMhc8Dgf/PVJjnqOE4bp6iy4vX3Fz1wU
         a+Iyn9Ic5R5oqJ77t9S0YbyMkNzZ5/6dUwqDh6fnVvyczBlOhJEDfVCyckVi5/DaHL3t
         7lIz6YSi/LI1eFnRCY/9fYHOtqbrKAoEo+xAJWoush0mBcr6GapZOgLJaRQWSmlYkAsR
         YaigFTngSPIZPVAh2lnIjmNYNifqWweisUcssLi/8OCZRqJDHrJXR8kFqFdolR+49aXR
         gJiA==
X-Gm-Message-State: AOJu0Yx7BENLady7OqVWS2k2xwrCbYTJJjMcDFhBgLTI0nrxyP3bo+rd
	V4sX2dfhTEQapsgj7qmt78STze4DAq7mCHnItvJTLlVikzzz1rua96lYLkqlcYim1N8dKI7/ETo
	RakG/gYhWQYnRPZpV9+UilCqPEDVOO0bOH1nv
X-Gm-Gg: ASbGncv4nHKnBNOiQTkVSW8/trFrxZ4yOk5UemuewrMVjEpwLXlSMpfuOoSU9jLAKPl
	6zoeRwTruAijwz6E4lux6McCLJjzyMAuYcVs1h12tf1QEw3jkvgAfNrRw9hxHsIIqJw9vzv6LwC
	2Ip0ka77eUEtKdrvm03S4bcIELcxPQkTva1CZV87Yuf5/FinBh5Foq3rObj7x/0ZVX1Q==
X-Google-Smtp-Source: AGHT+IG6k1tGsL3CjHlaMvbf55fmWh3RxO3Dmo6vhuUP2iSOeWu38CWTJBmkOkFGkLJ/rXd+KWLfYImXwWrgl9twWVA=
X-Received: by 2002:a05:6e02:1745:b0:3db:7b4c:309b with SMTP id
 e9e14a558f8ab-3db8429768amr75205435ab.2.1747442886055; Fri, 16 May 2025
 17:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjz6grtbx.fsf@gitster.g>
In-Reply-To: <xmqqjz6grtbx.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 16 May 2025 17:47:54 -0700
X-Gm-Features: AX0GCFt09uX01tfPpSM02UIGFibpe2I8iFI2zsY_GUT-hTKqzEJYdNk_c28ooP8
Message-ID: <CABPp-BHfuvme_6MEibMdZ936BEEFkwV0OM5qUGgUYVvphVgLzQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2025, #05; Fri, 16)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 5:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * en/merge-tree-check (2025-05-14) 2 commits
>  - merge-tree: add a new --dry-run flag
>  - merge-ort: add a new mergeability_only option
>
>  "git merge-tree" learned an option to see if it resolves cleanly
>  without actually creating a result.
>
>  Will merge to 'next'.
>  source: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>

There's a v4 that renames --dry-run -> --quiet, as per suggestion from
Phillip.  (cf. https://lore.kernel.org/git/23e4267a-34fb-414d-bae3-7f607d3b=
dbec@gmail.com/)
