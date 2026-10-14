Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27923E325
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937549; cv=none; b=dMwI4ytQzhbyDzYXxEXvVtVAKQ/fJCFggIWJKQiIOAcDQ9ORNNeSu+1O/W9V/38c52Ml1R0HMY23EsvNA2rwe1VkXgIa6FlAOhQ8kYmmAXB+xwx9haAh29HFVKkWAMWZFmTa652R/CNnzvBvWQgjXc6PChWBhOJDTnQpmRLEjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937549; c=relaxed/simple;
	bh=Fn6y7xzUd1Oth2cAlNE/IqkvMfju8nmmAERCefvwll0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=sSmealdPkwduB6H84zcyxe7O1bKXfrgxY4cDw/A32XG3MbBHDzdgd/aTWN3yGw9eofkvf8c+gACH03hnkWieTmKJXT+jDQRZs34Oq/CIvliHbYg5Ldxj4DIz+dEtRHGdfuIvXnvb8+s8b1oN2+LyUpwZ92q4vKiMjNZiCxz+1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrTuakrN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrTuakrN"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0a28a720aso22615917b3.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791937546; x=1792542346; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fn6y7xzUd1Oth2cAlNE/IqkvMfju8nmmAERCefvwll0=;
        b=rrTuakrNU8XbwejqZOPXvZTvfENIAMIP15ZYuDN+nbK6ahYqZwwwi5IUfQgpw+tWD/
         R+cSouvh9rOyj8tFwTuDyPevuVefCJIXh15D2edKmGEiUvRiJFb4R3OWy76u7iJajIf/
         Ixf9zRxLwR4hkTXupcqFA1lahbosa+1xDiW4+Oyc1FxUzrArgLs0SlokN5c337/8IIMT
         esA42UHJekKYA80vFyuvK84yit4y3IBCG2Pe7OjySxlrrrfDy0foqQbFtp27FOzXmvYC
         1fJrd7EEEyCRiC6DQsmOACcfhzG/kskAzsklcwaiAAYS7xU5+aflVlbq8fbMifG48OPd
         re3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791937546; x=1792542346;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fn6y7xzUd1Oth2cAlNE/IqkvMfju8nmmAERCefvwll0=;
        b=eInHZKjpzJPPqUoTnE7mCbcxNErZ84AOXF9whtAiz1O+OR5VIaUPhFgkHFbbS6O4JG
         rJFJpllhuNTK+QHCrpm9CBMo/MRDPv5YInER2TihHw3Mndx+wYgB4taSayNTNtO5AW0u
         rOYqBreU9bXtQd1Ud86dcRXf6FTu3m1VWYNYDHQ+XTkU498l7IESQAfFCZQ413BklJdV
         yeriRf4J0bbToCWzxSmxbkg7hQ2850ETyteH6ncZ47+D5TgaYUU8UG69xuzv8Rz2KpxB
         KwlyiZq9OuXi/EoIFUn/ORRW+QJeWByRXLy7pzuLFIeCMXHAt4g21gqPJoIhPrFWKyBV
         tC+w==
X-Gm-Message-State: AFq9FYLWbfcZ2i2ssGKjsIwz/nva8heTplzXE4VribTu4aDMooKW+HTM
	ezV7MZCs6cbTu84lP4suVe82u07jDTmhE8mlyepkJrRhhCzMHmo0j+WmknhheA==
X-Gm-Gg: AYBFou3B4qo46/AYfpCHipQ9HMN7ENA5tl/Pm4m9iJ2O+0an0ETAMRmKVk5W2i0T9By
	Qp/0KtGfqKveZmrNiMRPGP21MvpYnIB0TqvH46z+Hw/XzGFXNYHMG57jfh0P2Vozsthg8o1Ftg+
	MCueO5VhvMskjebXUm+jvkXoa9eEad/ecJGuCNcIyvRTCvQtU7TapQgpY7spIRnoJqyDgFMNMd4
	67vBGsRllV8tuuwDzOw2Mf79goWH2q3jKfWiJUT/7lYwdk5d2vuDLPsKeuH9dFd8UN44Gm/GFlo
	LEDiQrn1Q2UfEIxaRrwAxgSm2P/tF3U9aqxHmkmH2hZeW6s/rI0kTDub7KVFYomnllhV2rBIG7/
	xkWB5txn9ZzlfTHtXJbcve3+UvbQGywicM686zja2R7XlKsyPHtEXXUVhBOsKMbFfU+EMzitn04
	Tlkf45Yhn0FACUybMbJu6xfoKm5OF9XrRxpigW6fPZfeHYKVs9I+3kBNPyisbLvjlEobrsc9A63
	IHpnRehkEJmNOciVB4FLhWpQ9K2mgz5df1mwQaIRGbB/ro6ZGQRUhD0L8LZYjn29VfHpm34nuJs
	CmFI9ILLm6LG2i+dIsUWxfs4Q0DsqQ+dnra+vGsDD77vVec=
X-Received: by 2002:a05:690c:3181:b0:8b0:a883:2937 with SMTP id 00721157ae682-8b0a8833134mr24491497b3.32.1791937546089;
        Tue, 13 Oct 2026 17:25:46 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:3c7a:6130:4ef6:6831])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee89e76sm50085167b3.7.2026.10.13.17.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:25:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What's cooking in git.git (Oct 2026, #05)
Date: Tue, 13 Oct 2026 20:25:34 -0400
Message-Id: <589E58E6-C642-4F3A-A929-4D8BEE7B0CD6@gmail.com>
References: <xmqq33u9uprk.fsf@gitster.g>
Cc: git@vger.kernel.org
In-Reply-To: <xmqq33u9uprk.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 13 oct. 2026 =C3=A0 19:50, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> --------------------------------------------------
> [New Topics]
>=20
> * dk/stash-completion-updates (2026-10-12) 5 commits
> - completion: drop "stash save" completion altogether
> - doc: drop usage mentions of "git stash save"
> - completion: fix Zsh handling of stash names
> - completion: extract common stash listing code
> - completion: simplify stash subcommand completion
>=20
> The command-line completion for 'git stash' has been updated to
> dynamically discover subcommands and to correct a Zsh-specific
> formatting issue where stash references were improperly unquoted.
> Additionally, the deprecated 'save' subcommand has been removed from
> completions and synopsis documentation.
>=20
> Needs review.
> source: <cover.1791827304.git.ben.knoble@gmail.com>

Thanks. I forgot to write a blurb for the release notes, and this is better t=
han what was mulling in my brain :)=
