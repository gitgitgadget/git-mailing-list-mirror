Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AF310647
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511737; cv=none; b=mbbRcK4GqcPVFWm+8mK1xcZdtyIz0q0uvQoK2NhnuiGPmWkCW93gWm4FFy3kHl/pfgUWerGdeQ98SEFazmzk247JKY/jJDSxIJXl7EkSe0KYXF1ISrSyvdtejbkgy+R5YTHjwv8NkiYg58514hkVOFTpip1M4MNQrqqRHyyV/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511737; c=relaxed/simple;
	bh=fr4qMm05D7zZxpMsQyUn/36Cv+zUxJJQ5oIOF5R5owU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=f8V6meFC8eRSUMUK4ZN8FtzVGpMiXh4ljdFlMiNTIWVUIh+dt7uiCsT3TdFwxbaQyhQrjVBYIxHhmSgMkYJ6zVjLNfIrjYvRoFDsd9UFrkbDWeR4oyB/3PML0WmD/K92H72fOHsgIjY+fZctA8hkUNpfoqtEfupcOSNng3ddYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6Jai00w; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Jai00w"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e93498d41a1so891265276.2
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755511735; x=1756116535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fr4qMm05D7zZxpMsQyUn/36Cv+zUxJJQ5oIOF5R5owU=;
        b=E6Jai00wpzCBj1+qi2rVjzdDdVZRzHhWGmVaTRaWrORbx5YWdQ0dnlbBKt9UifAtWX
         CKfXDSyDMz70CuR37vgAAkG9N114D41Jz3f2bb/UkbnM1vOqVN9TveTxLCN6PoadZkFG
         USCYXXzRFipTxjPYF2qYCJglPLVEZfj7fSbhcHDhrpAYEA+/dL06j1k+3plvar0SQmwR
         na2ZIYmjf6NcvbI3cM0Szy9d94Fae2uivqk68RY7ga9RRqMI3kjKU1VU3CceQsuBB4Em
         U5DHa02bg54Qjt68XV3AmnqsDmm1Cc98hiVmLWMz7TC/J9Rew8HUlwZZ8s/sxf1YzgZb
         Fu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755511735; x=1756116535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fr4qMm05D7zZxpMsQyUn/36Cv+zUxJJQ5oIOF5R5owU=;
        b=WMq8O0sphPWzkXeZhD8fiLzkWDk1nDvPiWMOhaBxszPOaAFWbbYm9CzZJjCiFDO0O4
         Ue/wmLmAEOF4inyMtn0q9YpU6kYgO3n5CdtqFDQJDb3/AznUj1EPh1kUucm56/sNYY8B
         TIaBBRWN9iWrWVCI4cewHADQRjnubZofFRXVGAD1pQZY+H8fO7VBxsy2lpNktDvhwzfq
         Uso0nZr4udF3CxS08onfwC9tLpu7ARz5uXfdlAbqhKYfn9M49eq8Cx0swcZ+lowlSz3F
         Ze5aS0pskHmcm08mjCMIu2PLnLjdwh5qzJe8ZAz/oyjEPTZ34cbxyZPJZe9ptgn+/ehn
         Uxag==
X-Gm-Message-State: AOJu0Yy3IaFaaF5E6VgbsaUGUJURMVpwLTsfdbqCv4Hm3WQMNzbFNbMa
	1k4KKhaJgcvtTuNx1s/xUFPZ1vgUIU+klIB8qXcRNUG7yrtmBXR77PvfE6K7oA3O/26pRSjCO4D
	7j9M+Br/X+rXkCACXWXGby3DHVBLeebZU3SKPCEDpfKyS
X-Gm-Gg: ASbGncuLit/HxmmsLZA3o8nMJuUIrqymPbbCAcG8Gdw+edq71PWv2GTqUf2gQ/rVmWn
	+CFOjPWcYoD86rHFVhy7BqvL70c5QVUr34XSU0r3yYgoVPY2FdzngG1DIWQpbzl3IBTfXM5SFXs
	WjzG3n26UaCycHTNxilJy3zLaDNe1xVUp1twK0bPG/VQjVIPv08kkcUrTJ31wnbZHh+Cv8R6SeZ
	i1ejAA=
X-Google-Smtp-Source: AGHT+IHKXSzOgLeMm+WvchVHtEsZFWVs9w+vdF0OZg+L/j//N099p/mCJAXnj/EyElUq1YudRgkN8nxMnRxHJ9KpPGk=
X-Received: by 2002:a05:6902:20c3:b0:e8f:fb51:6872 with SMTP id
 3f1490d57ef6-e93323d98f8mr14431568276.21.1755511735268; Mon, 18 Aug 2025
 03:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Mon, 18 Aug 2025 11:08:43 +0100
X-Gm-Features: Ac12FXyMQeee63V4aRNIVAubOK2tPOjyDTiDcVGaei-zbJspiskJJGXqeD6DxSs
Message-ID: <CAGedMtd_atWTAQXOPSJThB_tpHiOSY=PUhrfFxFZOEkgUtHf1w@mail.gmail.com>
Subject: [FEATURE] Proposal: git format-patch with `--with-line-numbers` flag
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

While working on converting unit tests and sending patches, I ran into a
pain point during review. The reviews by Junio, Patrick, and others pointed=
 out
issues in my patches, but without line numbers in the emailed code
context, it was sometimes hard to know exactly which line was being
referenced. I had to manually count through the diff hunks, which slowed
things down.

To address this, I=E2=80=99d like to propose adding an option to `git
format-patch` (e.g., `--with-line-numbers`) that would include line numbers
numbers alongside context lines in the generated patch. This would not
affect patch application (`git am` / `git apply`), but would be a visual
aid for mailing list readers.

Benefits:
- Makes reviews on the mailing list clearer and faster.
- Let reviewers point out "line 52 has an off-by-one" for easy review.
- Reduces friction for new contributors.

Possible concerns:
- Could clutter diffs if not formatted cleanly.

I wanted to ask for feedback: would this kind of feature be welcomed?
If so, I=E2=80=99d be happy to draft a patch implementing it.

Best regards,
Seyi Kuforiji
