Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBA80C02
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547162; cv=none; b=uAo1+aYKrU2AhvRn7iv9xD5ShrUoTfDemNfKYTNzSR4Xa7t+fPJz1FsK5c4N8wkp9/2dvJFUFBHyw63F+sw/xyU8La8bU/GYrlkY5jygJlfqogXr6d2+wqQomvsnNzEmjSdQ+3f2HPQcN6MN27mgyzyYcf3Q42tnK6xbKagbM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547162; c=relaxed/simple;
	bh=TXt8T2mYYwgHfHe9SrxecauUVC43fQ0RuAAQkCsIGwU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sQahOsSuBuCTT3JJFyLAu8vtKN4XAvG9Wpho1Gb8X1OPN+GY7Bv1tpy5CE4XfRB0CQnQDP7pkA0t/B2xkcPIfxWQn3+SdiAtBIk/Gg257wl+PhZcWMhvxpx/YvcfxHMq1G4tR+wY20JY/sK5oo61N3jNykHn0tNX7IIfd93fFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXBZNI3X; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXBZNI3X"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65cfb4beabcso3286070eaf.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 19:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766547159; x=1767151959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GhKCL8u6m0ttg9TjHxOXe+22h6wFngN7xVZUIovk3sk=;
        b=YXBZNI3XM6dgyABRv412u6iKKr7Voxt4+6KJCg7AGuin3qDCURZlFOGnwCYCaMCPck
         eFxRuS94g20EQfVdPGTRHO1PBpOSQjPaOyiZlBt07lPEg9lRPIyOz/vZoKt9JKeeRGcm
         ti7HplBjjAnglM0AnkYrL6J6gIjhiBdaG7CB7X2zGK++DCRN2ysny/4b74JBkK1REkka
         bbSK/MyrBMITw+v1lPeN2qXvftYqjkB9a+S6Gh6uM5BzO9sFpg2kMRFf3rS8uJn5a7tD
         H3hUaHOEkMRITxlfJglgOApIjMLHsxK++U1jBohACFxCW9LMIdlXDfX7zJ0Kqhfv/VYm
         SJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766547159; x=1767151959;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhKCL8u6m0ttg9TjHxOXe+22h6wFngN7xVZUIovk3sk=;
        b=lWQerZzxgKVubUCiB0xwVySLESzCNBVn5a1eX8MyiXnqOhoE5UnnHorcibfcrOuvTk
         BW3K36YxwHGXO2D3VHUFXnYNXCJ5podFHAFwsUPUSUxDDmtv86kdINX9DpAB+s9EWaxn
         ZwzBNta1Nbz1vvsqK8pH4vgTojRjBbettxJQ94qFk/zuK4LB+rMuCy8vDv8weUqgAnRR
         +0vuCyAqqJDsuIqaAzoSz5jBCYq6BVARAxmIsBx8AarS4YXNs2TGpz6m4M39IMnlWkra
         WPYO7CB8S3W3huAiK34qUqTfex/48ghdV4AAMauntkpz52etlmK+S8Azn8grz1KOStHo
         CPew==
X-Gm-Message-State: AOJu0YzKrBKuzBp7VA4OJ7cdpm+PfyiiOmGu5eGuzszgrW6svEFJPX+A
	Ipyja7mKXEelHLUwKUNGrRMHliVltlg7yAzEOUsBMdacfS7DFD3uK7ifXDhmnxJ6sj2+n7m1teY
	pFVrxZgC35y/4OiriHDCQyclowEDR+FIv5MBA
X-Gm-Gg: AY/fxX4yEHomm9+mihDL0Wp5Qn63tIXERB+0kru1QZk8/yByTfSIGKX8LzVoEBGHdgD
	exIy0UV1GRmCsE/34tnimVQ5KK9F9XhPctXWacJ+k2nl4ncAG9rtncuPBbDvOoszJKQa/ZH/nwd
	uhgmQyUrDdA3In4d5WGBqJNZhQqmrN7Q9jivI+TcsMeJ19lApC9C21TYd+w+mM2ZKGGKcSpicAc
	OGsqLS1vKzEBQQPZ/ahMkH4jApjcPCvfmGACsH5TdDuweuYF9IBU7SWu6jYWiv883kUkB3EIeQP
	Pv4f4SJO2vJZS24/cxV9xzSGcKwF
X-Google-Smtp-Source: AGHT+IH1iOe6pcaujMbZ64966q5lWqJtvUrUPC6K14r9RcqleV+nkANEcu0UC8Gp7vKa2hNp2JZ/cICYZzHH7L4k+Ak=
X-Received: by 2002:a05:6820:f00c:b0:65b:2944:7318 with SMTP id
 006d021491bc7-65d0eb2fed8mr7844990eaf.38.1766547159059; Tue, 23 Dec 2025
 19:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Dec 2025 19:32:28 -0800
X-Gm-Features: AQt7F2pBCDML_MBu6m2ppVGaY-A-5ob8RgQyHMclVZQTQqpfZU8E7SU6Nrk-k40
Message-ID: <CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com>
Subject: Possible regression: lost diagnostic message when pushing non-commit
 objects to refs/heads/*
To: Git Mailing List <git@vger.kernel.org>, Karthik Nayak <karthik.188@gmail.com>
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Hi,

git used to have better diagnostics about pushing non-commit objects
to refs/heads/*, dating all the way back to c3b0dec509fe (Be more
careful about updating refs, 2008-01-15):

$ git --version && git push . tagit:old
git version 2.50.1
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
remote: error: cannot update ref 'refs/heads/old': trying to write
non-commit object d19968fcf0d3193147b827c9e89668d619afd01e to branch
'refs/heads/old'
To .
 ! [remote rejected] tagit -> old (failed to update ref)
error: failed to push some refs to '.'

Unfortunately, the "trying to write non-commit object" error is no longer shown:

$ git --version && git push . tagit:old
git version 2.51.0
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To .
 ! [remote rejected] tagit -> old (invalid new value provided)
error: failed to push some refs to '.'

The relevant error message is still part of the code:
$ git grep "write non-commit object" -- '*.c'
refs/files-backend.c:                           "trying to write
non-commit object %s to branch '%s'",
refs/reftable-backend.c:                        strbuf_addf(err,
_("trying to write non-commit object %s to branch '%s'"),

but the error message isn't displayed.  Bisecting shows that this
started with commit 9d2962a7c44 ("receive-pack: use batched reference
updates", 2025-05-19).  That commit message to me suggests that while
error handling was necessarily changed, that dropping the errors was
not intentional:

```
As using batched updates requires the error handling to be moved to the
end of the flow, create and use a 'struct strset' to track the failed
refs and attribute the correct errors to them.
```

But it's possible I'm reading it wrong.  Was it intentional, or is
this a regression?
