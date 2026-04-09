Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB93A16A2
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778604; cv=pass; b=gZWW0HYvxq7Slx+tPb5rLARzR1/oR2mshLMjt4P7af9/c1EpyXHV2+bXYzPbeGO0vYxCNAza3lq8UmaNogI/lqYqksG3sgfxk2ZIsrbRwP3QMKvKSKt0pCgOEuVTQ/urQngzoFvDU18XWbXwZzB9BSGjXRTJ6jiyvFrekEKE+gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778604; c=relaxed/simple;
	bh=PGB9VhfmQOLAJ04t4QnTr9s3hsxDLxF6q8F9KPtGgR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4au/mFwQqfPpkIVUCRgK2k00OQdBdpL7grQq92o+Red95BhmuBPpf8v3EFy1yrLJx79wrK7g9aUcxqWW6GBCxrCsgsYBpKu07YNq8AlMBovtRYSVu+JQcrXu0AcQMVnsyaKPKgbjhyjw4qIMqrGexmajwafnL9DtFRkLL6SvMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TksxRB80; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TksxRB80"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e0c167fdcso11580981fa.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 16:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775778601; cv=none;
        d=google.com; s=arc-20240605;
        b=JnfNz7zTNR5kJnFEHwYW1h6YC12p4BEutfdNVKI63edk7imbS2OzQNv4Ek+0H3J28T
         op4vEkDaAngGbmlllmadO5Oudz6FvGZcjNu9OcAs+GRIMx2PG9kDC9A9jLjmn30qOUbd
         6S8yKh6wsTb5qsFoxnN8h2sWQbhnqThTW7ddKG8EJh8I6wHRUqSlpsS/gEf+ughzyH0k
         DqGnA1ue/nbGAWAdReL8i5zUy0VPaX/P0HlDiFi7MqKz83gCRRSMe5afLsLifxN6YWLz
         zVTjOA8MdT9tdPswZbhVVs66wpJ+ioLkuGC24tXEdAA5u1NTOtlFe15wm+/Xw6aD/sdx
         Whmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PGB9VhfmQOLAJ04t4QnTr9s3hsxDLxF6q8F9KPtGgR8=;
        fh=q5RBUwYaDIprwubB9TUfN+lDkw55bRlTeAPpqS9AOKM=;
        b=SGED7+L+CkV+LATRAiS0Gc1C260NiGkuJbMs8coRvvHM4IYlTTlj1Su26KdTUYk7Ja
         tPx5ry3sw3de5yhggKx9SPuB066n/ea9J9eYIjxdn5RPAGfNSNgCNE/CZVLGxibbDTIq
         1qfGX9aCqpmphyqILA7tDBtlLHX0XwB6iAo20ysd0U6C2SVXlCsbHdkv0FxU9BI/BfUt
         UUAOgdi7tnh8GmNmU2yekgGkaEyPYknQ5R8J0MgomXcoQdQg7FEO/leSER9HG5EJhLqy
         cQ8dBQBTkVJJP8xwUgsuQkAI06tq1PHnNlp/1qNnxpF7bmjVjOW25O1QkvsAt7KMmm5P
         Lehg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775778601; x=1776383401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGB9VhfmQOLAJ04t4QnTr9s3hsxDLxF6q8F9KPtGgR8=;
        b=TksxRB80vX2nHX2RiGKl6XDfmRfGXd3+Gomq6lxNEnrEhH2mKcUiTxmUc1j5RcCjNK
         TzDxAQd/oxFKIEGKjwZwQuO3//YtzSCwH8RtJhYgE93IVSi5GDIIf7BNxcJafNc6D/lq
         AYPnVtJeiGTZS1xNTQlykBRY3CpilmHzo9wbG8/meUWy7CtsvigOTCZGH/TbBE6xPHMp
         sPQhZJJuY7RVE/QUR5jqfKzLxCFdppDmRsNh1DC08lqy6xFqm/aO+ta192xXyGbMdQyV
         JC7TyjkUJnDbExJcWO6ZLP0q5QIeoYfurVYc+Hc/2SD+EQ+uaV08zICDENOIge1TEHpU
         B5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778601; x=1776383401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGB9VhfmQOLAJ04t4QnTr9s3hsxDLxF6q8F9KPtGgR8=;
        b=kVGcAGYsSxOZN35k5Z+Gu3qkF5nPqE+CMRVKHlBqD8E1d9LD17OGYFmCGmkfbHJsm2
         gHfFehwzfCT5wQfKZJGqwvMVLn8b/8AynOS+kssEqQuBxXl8Unvqob96/zs2JE54uvZI
         S78uTu6Nr6c+j9+21vZ5oqLsxZYgEtyVWa2rXHvjeQfxKrDprpNUqR5rgZW7n+KoeP3Z
         WDOjmUGIJVX5PXa57H7vGstnRKyOKBzPu0bjAqzLCuF352iEdejXt4zVnDsKzAjxE/z3
         jMt0yFuQahYuBqp9Y5roAkHBoUj/38vL7868SMJR5m1YyP3oYq3cAEgSmn5M2HmQpFMP
         erHw==
X-Gm-Message-State: AOJu0YwetpNH8oBqk36S/N/BLKbb7UreewcaSDEo3eVOiHmUmKZtd3RZ
	kXcCJtq44jDr2ETuh07FtX064LbJvBMVm2t8vKg1SJy57I10gN3AKcN4FnRHzg1zrxZMmWGh+81
	Rzv7Uh1fKBfon+gbFwTbmgbXMJmi1PTg=
X-Gm-Gg: AeBDievfvZA9n2QPknEJEgh4UR5GhXL5SE/h7h7lvnVJae+EEqI3jYgnOJlRfSHwvlP
	TnwGAQu2txS1CQ2Ry89Zn7H64nEC5vKjM9MCljJVYY59kZT4Wr/MpzViL4ElmYJbGCD3EHmEHuM
	QxfG6C1a1jlP6Rh9MIk6C3nhpn/Zcw+8KWB1VOkkLGBDIlvMMiG8E55u6s320W50jE/0NGMS+gY
	B1ZnB+4bKPJTSiPcgJtH+9ORu/LjLo9auWC8nhyf2PB25PEiy5bcnrC3Lv+3C/6DeEsLsTqDmg3
	smj0LlDg
X-Received: by 2002:a2e:b8d1:0:b0:38a:4dd3:6a48 with SMTP id
 38308e7fff4ca-38e4bf6873bmr2149711fa.26.1775778601185; Thu, 09 Apr 2026
 16:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
 <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com> <aa1831336297478e53ad1a2a2ab9246860181366.1775762235.git.gitgitgadget@gmail.com>
In-Reply-To: <aa1831336297478e53ad1a2a2ab9246860181366.1775762235.git.gitgitgadget@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 9 Apr 2026 16:49:49 -0700
X-Gm-Features: AQROBzBa_pWMJsGnsXmUg5pRPadtb8klNgtoQscqnttlN03HvBpWb3qBqCNhNdc
Message-ID: <CAPx1GvfGRx4rEEhqNbgsSKmW77o+uD2f+977cX_U_amyYdz8rg@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] checkout: -m (--merge) uses autostash when
 switching branches
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 12:18=E2=80=AFPM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> ... If reapplying causes conflicts, the stash is
> kept and the user is told they can resolve and run "git stash drop",
> or run "git reset --hard" and later "git stash pop" to recover their
> changes.

I might suggest that this should recommend "git stash pop --index"
(either always, or if the stashed index differs from the stash's parent).

Chris
