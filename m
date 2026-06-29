Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1738AC80
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767660; cv=pass; b=eKOUTufVPZ9eLy7DVJKAQuRRWpoZv4F5CJn0d6c5GwQU9rj1F9pdFX+Swmvo5sIqlWY0w26Nijr7RvukADISNyHY1DWK3mrSGqnzlRw4gvizH4M3dG9TM3gJtL8WtF5pyCsZQUVlAlDrOkt1MtZ9gcdF8Duoz31tXoWYfRKlf/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767660; c=relaxed/simple;
	bh=LKQoDYs8v1E5bgTzK5v3NQNEykoTQ6nJRgmHvg7lB/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbmfxejf0IwTWAgeWZnw+Uy+KX4IL57pwLhJz5uM51mc2S5USBpftuuW7dFyJIe0eVK/KD4vz8RoqGDsVzzQLqHRVL1iepg4Ir55rrazzezDJqSGcYbvaBMzvFede2DvhrJmKonxSCVwBWFx9VbU6J/+8mL+Igfz3OSbViPXXck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPu+o7eG; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPu+o7eG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so6519233a12.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 14:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782767658; cv=none;
        d=google.com; s=arc-20260327;
        b=P8q6wxpEKE/R4X5I9FfHsXs5xijV3BgYG4YxRqJ4CqjsZs2BGxsrorMyjpvgVm+SZ7
         8EWqD92WA8/DzFlBeXUJwp7qw5KyUCRu0DUaQity/zUoemZT+ONpsLY2MiqG7GxDr7bg
         c49txBFtN692kcj44w6pLPTtvRhFOJC5HNq8WOQ1exQMmRRioLs8C25g7xkgUHOUak3R
         cFykuaF3yXlPSoP/jrDU3tb0APR5brnRXByGstiIjwpYRBAhwSBpSxS0C8wLef4JPIbR
         f90IDjvpFQPWWpQUsCPVADlCj+NYv0F1G3Ag/iQMUuncA2tCfDjW/YVcjwONyUWdjxui
         bzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2uF77w4vbPLlI3s4iOBrqa+5Z+0qm92p0UGl2GeOddA=;
        fh=uiQo8pk+duXmgh885311ZtSpLin3Bjv+GOkrRkn7pIk=;
        b=PTCsPXp+NzhUmdHHpcR2CzRijAM++YkDI8I7txmR4LpeghZ/LUQyWhHp+ajC1Bd5j7
         YmKIs1svSGf8a56tJKS2XEB3Nkq9NCPvH1jGQhirRbftK8qk3kRxylCSJse/Gj3GK1ml
         SaXPxEZu4XxMJrSY3BkZ22s8gaO0rI2By1+/9Y4wXTBWlVJyjdjzhsUtUvvkvXysBr8B
         gWudranVj7mZHFMzFTtajua/7XIT3r0pSxL5a26TtLLvx1HXa+FOC0HqyrVAy/ETONMH
         XrzgE+9HWs5yA5KreF+Ze3F/eSY2IxssYL3qLETyTEyc6e1uKSZuqZZ8odUOGMBA2ncZ
         YLkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782767658; x=1783372458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2uF77w4vbPLlI3s4iOBrqa+5Z+0qm92p0UGl2GeOddA=;
        b=SPu+o7eG+YgcrAZfcg/NhF0NwPokV5sgTUZfgSKlZ8xcO+ZeSDWh9zIsmmXqSjAuze
         Ei+JQ1K9E59OyY1soIs50/h1ct3wmCNn//r6McXe4wtDIQt2hFvr1fbppQPCcSFwDL7e
         BXIuZyiU4PGq16oj86PQx1Ut2E0XZzw3Gk8LHcrpm7rXPLAx6qIv8A/XdrCVT7Wq8RDE
         Bz/KBsHkJXFw2SU0tVYJSh64K4WMJLZaMsh/bwAdT2rhQfQ/I0RjU+fsyARhncZsfPJo
         dTEJqN9FrbTPPCwNdvkl0x4eXt9qmDzpUwd0f9GVf4z+qCwaTp3cXFBcC0O/XKXxOdVD
         MPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782767658; x=1783372458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uF77w4vbPLlI3s4iOBrqa+5Z+0qm92p0UGl2GeOddA=;
        b=O1bHFrgFppphO6b6+3T8fvsjDxqF7l0QjP656rKTnJ3PQG4d5ZkQ+nmw3J0GTKb8Ng
         XfBMx+1Y3kGFnSUiWVZ78l7OrVlOEG657dvt4U+4DzbC23Hx2JAlM+xvzPNOkLnWlSMf
         7GNmxMsqXlWocBy+0bG1F3TH2lCe+LFiMIZKhlPZZvs9o6uO5CO3wVN5m3jpezolfQXO
         HciLFvxu7fUoAcxya688hYBR/HRtxu5FZFtUEU4AMgPzN7CAhCk8rSFzA88uG5af9gIt
         NKPP0A0BvDnSsOqC8oGenaw8rtRd4e69fmFN5jl6aMQ2qhSwu6nCgMymYIKmLwKT4FP/
         1ECg==
X-Forwarded-Encrypted: i=1; AHgh+Rq11YVwAlApzHoNuTRvWsySefFhaT93n31rLmr3/Z4uY+D5OeK3tAUTBKc/YFCILKbXN1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzJV4iqXMzLUBL7apP4oDRJiyty1b6pT/2ep25w3gNwrKwwHt
	3O+LItJS+XEGKbraMexK+mdZDeS5QGus7iGZCZStcbjtfQseZXwmoI4/qF3znxHZNQ5WhqOXrug
	c7xfGXQWY+jKHJpNOPUpmbCl9vCLdeFoETaRH
X-Gm-Gg: AfdE7cmL2M82FHhYLm9q2/kievctSyz9ETc/6XYH5H1DfPb5Y19hyQb0sHFzs+fuyf4
	VeSFmwK2s+1sRPmv7Vl62+mSs8MbXQtswOdoTS6cxmoRzUN9K2WDKIi+r95CpKhISjIYfA6c//3
	CQgSw9T2uqobQCEs3JfmOA5o9hwg9lIfMLrf2w1ZGjStm5vuq2kiFyiro7uQ10ziJTxp7TGaGtA
	fcQlQjab6DZy2IsrF7plhNfNuQUEVEMLc+iUHVz+AY+N6TqQfabfMrPbVQ8aNDMDmV+J3Fw
X-Received: by 2002:a05:6402:3983:b0:698:3b7c:be6c with SMTP id
 4fb4d7f45d1cf-69879e4fe18mr342443a12.40.1782767657482; Mon, 29 Jun 2026
 14:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com> <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <akIQLM6xZTHBudWT@pks.im> <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com> <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
In-Reply-To: <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 29 Jun 2026 23:13:40 +0200
X-Gm-Features: AVVi8CdG8dhQXF_TLdu5_V3iQJrudeH8E6IjPPJYhZ65WGhNbs2qpbxoUGVQYqc
Message-ID: <CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> You've trimmed the line where I said
>
>  >> Possibly with a comment before each message saying where it came
>  >> from.

Sorry about that! Can you show me the example of what it would look
like? It's much easier for me to reason about it then.


Harald
