Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393508F66
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931254; cv=none; b=QndD+ikRGKVSDJQ/DSPSS2z/3+VHBa241t4ThVP9T2y2ibX9iqSvbetZugA2HZOqjqjv3nJ49lyhnqjXfaRYUhmK9IfUWg23+ToyN4B8wohL/4BAXImJ08cnbtdsuUtiW6tHNNeR0nhxQU4hkpH3WUtk5jfG1Snk9evMgmpUf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931254; c=relaxed/simple;
	bh=vKNH78vw95wpEbvV3jTsVe9qds69skBdgv+0ENNbJlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWlI64i+T82LADcjp+vQBzlPxGw1jELQYyAfjWY45OGZV06hqn1j/Mi44Nzj9R8pJ2kFSmaKQCo6r0FwQPSOnrmLOriIH+nuztwoFSJ/0Qo7YMLFjJ6Ys0eY+hMfp8f5mr46yLNOlYPXUP87YablHrkiVlbxAldYE6UT/KAoFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foawZefJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foawZefJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4678cd314b6so120484911cf.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 11:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735931252; x=1736536052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKNH78vw95wpEbvV3jTsVe9qds69skBdgv+0ENNbJlo=;
        b=foawZefJMbzA876MkKJIXBy9HwYb5ol3Ikew0jgft0Wz9nhwjIIhFOZPw24owY/yZH
         WB4xrMJ0xW3Hf1Zx1ohX9nAOgNecZL93xdJANx0YBvC++/gOwi5YY4u0yVroLn43dl5D
         9x1xiWPjLl9kI9a31e7RKIxij9ktqwVDtnrx7UVPkT6sZ9SqqX7PS8YXHabu0RezSHYF
         IFbq2NoWXylTwyWafik4Ga+4ZzLPsayZDhcD+WsuYe9FcADJ+nIRvi5S9836nr7AMLRB
         pFmxSNm5mELI2DXj6801OyhsQsdV3ZODYnD1MaIgps1KlqfxUXJ6EZEPg7j187va7TuL
         GewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735931252; x=1736536052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKNH78vw95wpEbvV3jTsVe9qds69skBdgv+0ENNbJlo=;
        b=WefM906EPXGy51IxQINaXknm500KoQjbxZCPizI4qfHQbYQmdZEdMQfR+ZAuxq6sOt
         Sj4++/se/Hjts3QM2lJJJAoW86qFSEgaygUKVLj3LGenJVkLhKIvTatodUwJOsJmAXq8
         Vq/SEf+fzgTb3gSA6L/1pIE4D+PYG0CAft5NDIQr/bsT+WZgJp8dtfYBegLGHSGJDcjd
         cK/Z8YzH2VBmZkKHkcO0Z4h+2n6UPBbuoGydv9XO5o339/UIj08X4tbN69klif7RuSRX
         Zq8odxX+Z5zQS1r6rOYPryoyL20zkXoio87a9eERcgHVTTfCfgRMyAsuzBj20p+98+mf
         vkTg==
X-Gm-Message-State: AOJu0YynQjpk6DLgOY6uoQ14Q3G5ZFvG/9UYBanRAcvxqkXdtzEXYGH5
	GfTYzdfAotZVXZMQewBxOQhmhCA3dxT+kMnHwdJKScWp3uokJuoFVgvEEcfOiefRiodRvuqCuxW
	/BwZmdsjTLsIQ0I0CK5lEYz6tC/M=
X-Gm-Gg: ASbGncv2cZL1rRG6dbVEJ6DlGP5dPmu91TtB9Gz5nofY1boqBppbXu8gUbUvXlnmzQe
	+qF0FHQ0CSeYBUH9/J/v8JZZSUcixcfmz9C9FLR2mPuay/vbZ2X4xXpWzSS19hT+r5UbV
X-Google-Smtp-Source: AGHT+IGSyVMPLDCYOABVE4mh/Wr+n3MW75NCtcRwCvI2+g23CYvv9LEbOGRAI6pVpR4AmRZ4gysqLbNGCoBwcmGCUcg=
X-Received: by 2002:ac8:7dc8:0:b0:461:169e:d2dc with SMTP id
 d75a77b69052e-46a4a991a62mr788415731cf.49.1735931252167; Fri, 03 Jan 2025
 11:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z3fM1bT2Z_0GoD4w@pks.im> <20250103130035.79376-1-matteobagnolini2003@gmail.com>
 <Z3fiREGwXdILl-M1@pks.im> <xmqqfrlzsw4j.fsf@gitster.g> <CADyPGv0T7Wwrf_FidWDtLGOH7A88DcisAG4-jU3eEax106XEcQ@mail.gmail.com>
 <xmqq7c7bsrel.fsf@gitster.g>
In-Reply-To: <xmqq7c7bsrel.fsf@gitster.g>
From: Matteo Bagnolini <matteobagnolini2003@gmail.com>
Date: Fri, 3 Jan 2025 20:07:21 +0100
X-Gm-Features: AbW1kvYA3GwgrF9NNjXxkmyN2aIWxERVXXBqxLJThJ7Ly8hiVYg9g9W1znV84Ys
Message-ID: <CADyPGv2onyb-n80LMp+LNRij8oGZLstUkNpJXQcLKbVqcPzpEQ@mail.gmail.com>
Subject: Re: [PATCH v2] t7110: replace `test -f` with `test_path_is_*` helpers
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for asking; if there are no other things that need fixing, I
> can fix up while queuing.

Yes, everything else should be OK. Thank you.

Matteo
