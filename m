Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5537A4B2
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258612; cv=pass; b=k4HBBNCSUa9yLe+Mo1b0hQcoO4pmUOwZaIb4/AxYbBqYAvMbfFgonqIHqyinxy+jwTTqnBGgJUBhGG173PvDpr1nznFPp28xpKOxTFCRUY3J5ef9JujlpJ+v4dEYQ6QJ1iRZSGOwYjTAtFFIoP7/CkDzPrvyO8kJolKfybp+my0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258612; c=relaxed/simple;
	bh=8ug+GfjrhyfA3+joRfCfbPredjlThLNK1c+DWCipnlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdL9U/HU9zs7zwGEpNpuxMRtWdqahOgTAdmj+7/a5Enr1YJCTUjsNrSihiVAttSpUC+71Aks20A8pABtL90o3L9tn71AnjpzKLXIfyRWWYCJQ1GQt1Wh7D6W3EFWJqXBcsLZfE34/Bn14mYYxdLpAlbKEWUDaa3Zz7kOsTgIrQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdLdHkJD; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdLdHkJD"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ca423ad53so308659d50.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773258606; cv=none;
        d=google.com; s=arc-20240605;
        b=iOpfKY8+V5KNiEuaQMd63lVgxiUywGqMaNMTROrCx1jQ2nnv/D+8klhfYgGkZPCeqK
         xMMqX8vf3xOxKlTdVoU+o+RNhG5JWDVfm9KWejIhWwfkPdaAbaetVFpeZk73JxasJeCw
         H7To5hSWFy1EJ/QbUzm5525RDU8pYjE0gBgCZ3RwyNrG7Pez7CUROwPbKWuA12p9+V76
         /bg7ZAAyr6QIAh44wjZblQ36MooRtlJA2eirkVAY8k1S8GKu+HINK49c4Y55wTaJWR63
         CHErly37Va691sAh4cDrtnUdeHGb8rvlSPc9zu3+PLmKoukhUgAFsH08xLs5t1i3WQwV
         Fzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LcbdbG4EnT85TY5xZk+R3/iHDA98RzqyDx9CTnoymtU=;
        fh=6G+GIbRNE5qEjne8uKZrvRjzXCq2aWpt1YG35J49a9w=;
        b=Qlg8JwYrms0hvexRRaka2FM3YjSW2R+NHuwMH8WKqFhjambzyOfyAFezmOO0y5GOPp
         2pDO4XIw5QLTE6P/Im8cVXnHQDmVpc4M8KkLS3+DIrawE7cD++TeXvMNdNMKhgHdZ8Gv
         nkLF00zOFJI34UeGoGIU26+BSRfE0zXSQ4r50Q+TT85b8T6HGUPApRATOGmmzY4v+pep
         yhgRuiRjg6DEZdg1qTCXlusL9V83ZTWTOa+lnujekJ/cYlIlwiUbh4qgU815CK42mqRT
         pEUDzdYi1eeBzIwKocsrd0R556hx9a21HYOT5PFpa4e6muiFQDUa+qeCM+Kk1txkOfAR
         MOew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258606; x=1773863406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcbdbG4EnT85TY5xZk+R3/iHDA98RzqyDx9CTnoymtU=;
        b=SdLdHkJDgKljq23CU+Jsl1Oo6m5IyLh4IxzPUZdGqREeiFxBED3F1TRQ4z7zF0MT1c
         KTk+KbckC4Ula64YzbhbabNE2V82r/rFW13rV+acc8i8tsDdnrEgTTs/0EJaXR4VF+9L
         +GjGRxyhifof5QNcSt9NqiUCgbmrg6lwMbn4WWwAjy4/jtNvaxYFV9tURHO/XBibQ0k5
         X/mRHw4t70ryfSaRFForfygqEO46LUGE8ns7IfxugyyzJDSx/wFdw51znleXJqU5KEqU
         /SzQYpOxpG/1urXy2TydVL56hNsWDk+mSmhcanBFSq5u6j+o8mdbHzLG27AMHkfXuTNB
         yzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258606; x=1773863406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcbdbG4EnT85TY5xZk+R3/iHDA98RzqyDx9CTnoymtU=;
        b=r4P52qIOuLVeG7ZjKoPK4ebpdCPAzXCiWgJ3ly57xBx93A+XGxVbHujuPdRfDOa1TU
         VhlPlzUdnZCHhgvyZszsDCoiVA3FFdUcBYTGGZciLw4ZLeEngjdGPQgf/pcsMLjIv2V9
         ZFlwyrYljBrb4cKSgDnoBOzyS9Ikd8MFvDYasRTg6ss1/ag1CQQlo+IUK8fsdDaGpyXr
         Yg1THZ5RcLi/66FIeTm+mGefCO3gpYHAxXbH8E/4bgw7PIfqbRGunDsXLjLaMdaexA0/
         IHjA7VLmDXSIqEE1MhskPo1CeBfp8IEW2dYz2FL/47vT4VtKRxETPV0bR1hj31gNNQvV
         2BZg==
X-Gm-Message-State: AOJu0YwfgAlwD7xJY1EnnIRMVTTga36a2cHElT3vbZG9KM9Y6EOnKLZd
	4akBPqvHpVh22fTtnH2AwI0Dmmsun74KBiNYbRDIQsB70hPJ9xN2prrWBHisudFL9yWe6viFoFa
	4PoBn7bRcY1Ta76KDyVCiZD+qEgfE/50=
X-Gm-Gg: ATEYQzwH+Zjul0akO9Lp3+7MYVR3BqTR8VBy82wG/M02rcjwPfHQyR6o7bVq0UkuuiG
	CLcG3f2UjCxhJJ72XBR5HAIhTd7Cedc9IraH7EgQw8muIIK2DDnlgALeQKOW9SkfQMYmh5vLwiK
	P+z9MPd09gvDd2Zt42rb1h8i9BJ7F/3VZCQ5OAKo3MQWi5vueYDV9DKVH5ojqFBUO/ef/bXm+Ux
	HfnJZqtDJ/ux0rHcR/r+RHJlrcBYfyUp/lolCCQTsr1J0kC1GvJty7MoLrXWt6CapgTXhE2FDsu
	zUL+Q8RJTqX/o84hYLZi3Eq7m8xp6zSBka64licV+OdBfKUb7SnfMMHZS6h5pI/j90ZxMHubGeM
	poCbn0aNB1zfteeKmsCpZXyE=
X-Received: by 2002:a53:bb52:0:b0:64b:1e85:36e3 with SMTP id
 956f58d0204a3-64d657d0da7mr2742501d50.67.1773258605996; Wed, 11 Mar 2026
 12:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
 <20260309230134.758107-1-pabloosabaterr@gmail.com> <xmqqwlzip82b.fsf@gitster.g>
 <CAN5EUNRZQP6ATE87AeZiJx-OTnNn_4NxhW4zyH6AspGUfnV7TA@mail.gmail.com> <xmqqbjgunofq.fsf@gitster.g>
In-Reply-To: <xmqqbjgunofq.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 20:49:54 +0100
X-Gm-Features: AaiRm53v8nektPiRT8KyyP8Do7ng9fJUXTFmtQc1EVlMm3lLDH2ssCMauLMsmGY
Message-ID: <CAN5EUNSmZmdnDzpAKAh8fZRex3--tnKaWZZSQ+o5WATc6sLy_Q@mail.gmail.com>
Subject: Re: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Yeah, but if we are going to do so eventually, it would be pointless
> to use the path helper in that "set up CVS environment and make sure
> we got a sensible directory structure" check, no?  Upon failure, we
> will hit test_done that loudly says that their CVS installation is
> not working as we expect.

Yeah, the new patch will change it back to test -d because it ends up
in a if condition instead of an assertion.
Would you prefer to drop that hunk from my v3 or should I send a v4 ?
