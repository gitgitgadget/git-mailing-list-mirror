Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC174BE457
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827103; cv=pass; b=jrde24WGQzv/0BtfLN3I7XjXvZPlcT6jq18+1GX4eptzXpafFL1c+z7OCMO6dhhK6RYSbW3GT5dyhnAsdtbFqD4d1RFxeWDBb8uvkZvqCX3J58OJGpyPBlFK0TIYimU24v1+PdcbjF7NF2c7krqov9a2Z/GFwtLqqotWX62qLMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827103; c=relaxed/simple;
	bh=COcV2QN/rA8oIVrcYDSwUD6cmZwyXAuOpfteOqgYMRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odM6VOxA8pQAUOse25mNUzdbOiL/CZfu5xXtVNEuZWNeRUH8Gl/axFrmRFzA+c9FUGpN39TVaquLspvbCmXcWGRpEsqGy7S60Gq908hZ8MXqei2ieG2fczycV5JfOaPVWNaWKSg6CaBPAwpGqh85/ilMFmGCGRLxFKv4RYXnvnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+TPunuy; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+TPunuy"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso306110666b.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791827100; cv=none;
        d=google.com; s=arc-20260327;
        b=PbTCmC/gC/gO35xUMRbj4LB0hCLsYmgzNPH3s1sDkEuQ2641XhJQJs7Xm4aZRFNCjy
         kxEoojRPNResrtq2kPRo4qIhcWC6u80x6zwf/Qr7ZRAg8xQgedZLRensNntHKL+Gonn9
         Pqhx0aj4Rq7SomqLwotfjJwyqYED/wxG2lqmYBgeqFWB36m6g8WBRGMLhO6zudLBEWrD
         sgbblYETJfu+LUOH1khxX39+19P6623k4/eL8MogJr5Rwo2MPCQ2gOCUM57YgscIgiHP
         UnqvCxgHVLpFi9S8ZdXUBa/2NWO0SFCptywVLqEVrrRs/s4g4pTs/mRrI00yX3kW2/HD
         QAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=COcV2QN/rA8oIVrcYDSwUD6cmZwyXAuOpfteOqgYMRU=;
        fh=xp80hQ3+2ia/5ftpnNGEUSFRYzXB+3FwAA3QAHibcj4=;
        b=BQ1Qff+L6ckt7Nzn6yQoZC2YR6KXaDN/zttdLkonSCrQcQZnlDzAptW+ZJcUjZGiiW
         kI87NcTgNc0bh36eoWwUAznrmudtJdg2F3Ym/4HFbJipbLEPIeO3iLq+S5beTgScFumN
         5ExgvKWRNn0eKxg1hQ4/YTSE4W/bWoak6W9GgZazz+f5PkyWeeV/28DB1XYK7XFTwskx
         1msrXwReIOcb+dXq648ZOuLakZYvaeoEH4rqBxGJCpp706GDIoNxvZj3rKIIF+fdylmj
         ew0G99+XoGC8vjoTOtQztK/4L727ZtUHbfOOJSuBMtjq1NEDFaROZWSHEg4L3ubZs+e7
         Xh8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827100; x=1792431900; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COcV2QN/rA8oIVrcYDSwUD6cmZwyXAuOpfteOqgYMRU=;
        b=B+TPunuycQMb9uC20JIJjMnME8jTuQ4zVADLpqSGYJ+WapdJ3jzFSLpJdNyiCm/4SV
         P4ifCSL7ESeHflchZg8oYwnRL/gMy93vkpLKV7FAvz/k6aavihZ0K2FLDh6qd5fUlScn
         3rPnEszfNpiYruRgjOlBnHtQ19YG/6HH0VOZ2ls3qb97QKyv+idWWtMDCELioK5Ez7a0
         8UlnEmnsO2FycFeFo63QzVvP2RDeLQbTtofwnWd82Kv6Q4cwTJQ/SCv+oDYg8z0e4UNo
         /0sqlN/jz7gICA09MYGGwYkojneB0KO2CqkH2A8wdRMrePl0dXO5OjkYcSs6jRubQmFt
         h9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827100; x=1792431900;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=COcV2QN/rA8oIVrcYDSwUD6cmZwyXAuOpfteOqgYMRU=;
        b=VZ4S0hOGw3po9UNZADpCdJKVsf2uB8c7wzxghri0OxFj3v32U8pUsoTH6oRie24E1N
         SoW3Ad5DQcQ7uJbx5iIfOQfhBBtFouSYjxq7IkVoSS8XOPWfLXxLeH/ebxdUr6A1tAyD
         GRYSfETlhu8buhGuEWxYb1ysXnRz1x/KIQjB6DPe9J/metlGIMIqZGEbf5zdjo6snRx9
         MF6YjtLv+JxyIRqYQYWa56SCJ/14NQbX0OKrmqGFr+ejwS79pxm7Zybgyuc1CY7qs0cY
         IGRFdVL7bAD/1Q1vxXdQ7Lq+J9JygmiyyEBQ0vAX7lyu5RJ2tXTOxLQIid/pOLyxUaFs
         svNg==
X-Forwarded-Encrypted: i=1; AKwUvBzBh0zGk+og1WtNEKfdeVPcszZ3zlXOjQVGOoe5qucEBm+djUDYq82ZgbGIg23iResj15o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuL94g28c2+HQdimQOY4IaaJnQLRL3bfloewcscahv2HAvzLoJ
	pKmRzLW2oJQE5e7EL0guFNAiLsSB78NHegEyu2XiIytY7mH1wHPUWF6I7n9HFCIMQkofxgk1rNi
	qdg+5H3rvfULQeWLktKtiIa+6tKJyTno=
X-Gm-Gg: AYBFou1gVjzKshT5cNrIZkzXZ8LdEOcY9hwfxKb3Gb0v8xMeVUaoSroTEGgSlFHyf4Y
	dDGmQHWVDkH7QLGnKaysoiczJe1M/a6/9/qtnFF3pY5ShMv+IXbCkGEebX9rkLRuQDMgCWnp75G
	5a2nuD7MCqX5kJEbftxdk06+tEyePnTzASvq9xJUnBeWdH4UNLVOUDMrwjcEfwMFsr7MnZG6vBJ
	9NH72JfiTvFeUh+bquknxASeTApuy4G8S8t4A5C701ar6uelNslmy5FKORizlNQYMh099Y3inZa
	aMeVmP2fZksm2FK+1MgvSU8Rmff2ussoFgrDkvF7DmIMGRl2CcUfLuA=
X-Received: by 2002:a17:907:9720:b0:c2d:f050:ad4a with SMTP id
 a640c23a62f3a-c31a9a33cb3mr932611766b.5.1791827100121; Mon, 12 Oct 2026
 10:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com> <xmqq1p9vdalz.fsf@gitster.g>
 <03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com> <xmqq4ieqamn0.fsf@gitster.g>
In-Reply-To: <xmqq4ieqamn0.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 12 Oct 2026 19:44:22 +0200
X-Gm-Features: AclHuK9XUQLbvFR1bbnhEl8Fzxm90hhJUJSpsZV_Sx31D8bX0kIJS3PRPk2TASE
Message-ID: <CAHwyqnUP72njKKap16u+kShHmhssiUXFUVRhURPP_wzwZsvtdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> At least the one-to-one part of the operation should learn from what
> Dscho did in range-diff

Oh, that's great! I'll take a look.

> especially the part that does take
> similarity of the log messages and authorship information, instead
> of paying attention only to patch IDs.

Right, authorship would at least be a good filter to speed things up,
can't be the same commit if it has two different authors!


Harald
