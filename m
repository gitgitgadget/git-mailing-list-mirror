Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF59212554
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740996; cv=pass; b=HkD20Yzogc1sr3dnepmOOfggNb/tT2mesjasDTzuNgVNwlpMgO6SDypXK+Ukvx27Mqqw6dLj4Jx2B9F4tfrnRuaFWz9/juAxwbll89T0XcUyFEYFozkDXdecVjtPlSnnyuiu/YTtqZH7Uj58RGH3pBAsB/DdjOFivtPowpfpBc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740996; c=relaxed/simple;
	bh=qQ1ixr2lfYCO1DKtU+r3rkzaQ1Ii+Dskd79sRmH7pcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGfqKif+Nxv7eQdILpyj86OOI+VNlfjqNmLN+2PUs5rZhEREDP11g+uldn7AKrn9iLQZItp5ycimuqfNzkdoyV6u7LAacz0I3NRWolNnyUyXmrS91PR5HR/KoQfPP+GiCykdeLhjwCBImKHsd7FMk1Iw7u2v8HoterXed8e2M2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrwB5K4P; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrwB5K4P"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so5785369a12.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782740994; cv=none;
        d=google.com; s=arc-20260327;
        b=hdiXj5N7LmE1KctnjxsWy2uo8KZ4kOd02jsK1H5M4qe/6m5eKNsp+flH3Ylai1LOMo
         h0vT/OjUnNmb0usyl5KZNAMZokuRRaacyU+YNaISyMYka1qpAG3S8nqL8s/ORf8BVQKc
         Oe1mFEpUFS3uPnIbFYKUZl7IEd5CONjy7zTnjel2otxFoDIp1FkJskazaNzcjchds1RQ
         1B3gFUtn4TqVE2CdEibvG7KplXSyyI0HZKpTvhEhNgqYYAHcHRPdKoj6jEcORNWid2Rh
         5jcJJWZZQEIBQ3UGvHpmHZDaZHPJFYhC+TZRV/V8duU5VYMlONniE5mi8mys/zgjkCeq
         xlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qQ1ixr2lfYCO1DKtU+r3rkzaQ1Ii+Dskd79sRmH7pcA=;
        fh=wZijdXUoGRBwZA2T3sPsoqgjyKpP/PnUagNAddZ/48o=;
        b=JuxQOCDvMjiZNUn5XYXbFBiVhqwwnFmTx/H5tJlWgTtW8Jh/MRRsxWezGczon/H0nJ
         ERPHjj1PNISaLdu+4dfdJlIZXdZbiFUu0qlHcIc6dbQUtH0N/BgcH+ATaqu1R0zf6nGt
         VNon0tRL3CU1EtDmeZ6wAdw4kwt4SB62eu9wwyMBoYIrKlwWC5Ii1BE3tth8HklFWvXP
         Nfh3SZZhOM9hCHeAsFFKavJaGPNF8A5hVjVW0wH9gWacZHJeQARfERtmI+JETsrj4XG6
         UjtS/fyEfrbHRwwiuAn/YXXUKYy3sTxNHNzlxmds2tKPQ6q+InEfHtHfmWIqTnsBSTZ6
         qRDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782740994; x=1783345794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ1ixr2lfYCO1DKtU+r3rkzaQ1Ii+Dskd79sRmH7pcA=;
        b=HrwB5K4PeTCgW/4Ns7jwPI8rD6gxu9Wypg/3BxkKh9M6ga7KEIlp65SoQD82fiL3zG
         W8mefB4izUxy4hjDO8qnXVKF8guHabreijx1Gscm3B3uAT4MzyMF2z88kV4SEle7pRJ3
         Moo0DetoCfhCw/Yp3BX4DucThIZ5xCHB74guO+bIzU65A0iX/uxjL2o1FXruWDOOyEkS
         74pagTsap+wknAjxd6c9GT3vES1PqeIjiAasz8aHFgpfPhEKYG67m2Zsbzp3UXQi24ne
         WbsgZiQE7qkqGVuSaPrHweHSSMROQyQ28Y/xqV/mIxAZUgee7q6q10x0CDyu6F9f4FB0
         3jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782740994; x=1783345794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ1ixr2lfYCO1DKtU+r3rkzaQ1Ii+Dskd79sRmH7pcA=;
        b=i8V8aSTUdzeL7/EJkmcQaxJNFeqTVkM/saEPKoa7LznsJ9xkJPJQbpbxRlUpqVRz+y
         Br4E3CwZ7OT+NjbTCURs1q7wnyMAJz1BR4vHJWnIMc4YLZvncfNbLxq7GPpSOZ1xCXPa
         IlBwYxoJHTnZDhozeuS1TVlPyZI9CEPGSTNRD6DHkXnCXCj3qz620LOb0lbmdSznbbk9
         P/7HUBZhPyduvsukExt4r/2HDjRxeYhBhv9mSqdi/7Ao2SVVQnL5h8ijruXZ8qs6wVVJ
         46iQAWOBQFM90bIDwY4MQCDxo1dVDVo6NNZYzY86iJUrFTvjmcafbrxTLJ04GPFU1aXi
         Zv0A==
X-Forwarded-Encrypted: i=1; AHgh+RpkBasQN8uo8WTTf7zrAEFTE0IBDVmJlTaavzm4Q5sNlqiJ9KGGdcvazd6aBm6o+H0V5wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjql1mgfBHTjPubso4ACB52FSHRXDsH5/+tzEvv+XMU2c7RuP
	Va+r6VonHcBGz1c242Ux0gCgKyho1BQyk7nyFUQs08/iJhS1bPYyKewEGZQTtxydpBNU1LL7pUA
	ZI5LZ5Q0UJaL5yMyGyTq28ChZ8Zu7uxY=
X-Gm-Gg: AfdE7ckwKBjry+u5mb7NBa97KCa+EOIkEyxsacsCvj6ZlwUrb7kfT38zzaUwXMFVpk5
	/Rwttc/EvAywGA/l0SEQS5Av9CQEkxknm39ALGXi0YtBB7lm2N8tkjWmtWdXNbRKCrRsEdmgC6k
	cn0+IM1lcqe5pDdksDZS5Qvh3aJJtQde1Q1JsoCqjo7TruFG/66O3lfIRLgdGFgBPuEPIHnO3TN
	n/003clo123TWuDyjz7cftyCQTwtlUkJ30xLDjuCzZmtTY79/JAMwFxaX4zO/tQ0GB3xSGT
X-Received: by 2002:a05:6402:268d:b0:691:2ef1:354c with SMTP id
 4fb4d7f45d1cf-698368427a6mr4897347a12.27.1782740993667; Mon, 29 Jun 2026
 06:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com> <4edf012b77fd2f2fb2a51eb10863bbf852fffa40.1782635349.git.gitgitgadget@gmail.com>
 <xmqqwlvhzyhz.fsf@gitster.g>
In-Reply-To: <xmqqwlvhzyhz.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 29 Jun 2026 15:49:16 +0200
X-Gm-Features: AVVi8CeQbM89gKYaVWeE7EjIe5-kmAiPfImiHaZUwfZRaDMtkMDtl9GRAt5K5uk
Message-ID: <CAHwyqnXXFz4z_ULUq7Oqu0ykwpLJyEyW-uoF2bKfoYZQAjrNdQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] history: re-edit a squash with every message
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I doubt it would make practical difference, but one thing I notice
> is that unlike "git rebase -i", this one does not intersperse
> markers like "# This is the 1st commit message" in between the
> messages taken from the squashed commits, so it is not exactly
> "mirroring".

I wouldn't mind extracting that logic from 'rebase -i' to show it
here. It would be nice to have.


Harald
