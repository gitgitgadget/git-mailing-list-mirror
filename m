Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38858ED2
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvpu8xsE"
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1DDA
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:14:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9c939cc94so13085735ad.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697861691; x=1698466491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ljys1NDsmy0m6YtsI+cT0lIRqGdOO0nfJ4LPEeYuPk=;
        b=vvpu8xsEHRACNSFlUA66gF7DzDwavG7VjKwh+QCzO2eaQRLuvKzQu1ag7vDWU8rAza
         RjD2oX+34fATlAD1mHCk2ay0KS+xTcaxPkcMhTtrLXa95RnRmubkwPJoJFg0ZStJiC46
         jc8ol4xrUmnBjNmBJeSem+6Bzc4ijmq7iQgMPTa1vjf+Ck3u2Xv3vBxh2uhaf6GwuKOF
         ViYwp1tjOlSCEeAH0f9VBmuMScRjdh6W+RhmxptEEI8f7YEZVSZ/W15TwJW322W2nmRk
         LYNyalEFmyTG9pFpoIBrXkfluZIw48tuNm1p+7HpfteT8I3vY15EmNztbtXjsMuap0v3
         p1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697861691; x=1698466491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ljys1NDsmy0m6YtsI+cT0lIRqGdOO0nfJ4LPEeYuPk=;
        b=mqAnT1ylsoNdpTnSlyXH0BYCCivFR8Fl+at2tb+rWENTW3ANPztCTyBozoDudqEQVW
         sAry7szWSbzQ6HUpct2vLYm6v3hh0hCmjbrbYqoAANfSkuTBR/kKYaEyXjT2P4Fwp6TX
         AdJLCTSVS/7Zt27ZMXml2MT1HAsEj6ym7O6sV+BJZsywVyIsDHam7Uf7zIE40TcyLqYQ
         UOTV8ZMNF0hrL6u8IVak4I8epfabhA4irOMK1qWlNEq4kbYbzFtzr0XDotqtU1tD5c19
         yjmxDlSoNrLi6MZ1Lhlq6s28x1+GBwdTEsDCZxDc+9ICnSZunMuceDXyniDsIuZGuVg7
         zzAA==
X-Gm-Message-State: AOJu0YwfpjQyD73tZ6IeGajIheLKZxPbNNmrL8ZEiAHuuEro/1XI7SEo
	jpG3HzMp3Z4/WsMIqDDUb1uAZQX84hs=
X-Google-Smtp-Source: AGHT+IGXx8KVQ5SzZOvKzkBPdsKqupNoew+vlAJ2e1G+cM/S/Yi7/Wta6YVCCAe8od6bGpb1KPZfBH3fK90=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:ab0e:b0:1c9:bee2:e20b with SMTP id
 ik14-20020a170902ab0e00b001c9bee2e20bmr67942plb.11.1697861691512; Fri, 20 Oct
 2023 21:14:51 -0700 (PDT)
Date: Fri, 20 Oct 2023 21:14:49 -0700
In-Reply-To: <02ecc00e9c7226c9eeb960cc49c8c03dcb182a38.1696021277.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <cover.1696021277.git.jonathantanmy@google.com> <02ecc00e9c7226c9eeb960cc49c8c03dcb182a38.1696021277.git.jonathantanmy@google.com>
Message-ID: <owlyh6mkr4qu.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 1/4] hex-ll: separate out non-hash-algo functions
From: Linus Arver <linusa@google.com>
To: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

Jonathan Tan <jonathantanmy@google.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> In order to further reduce all-in-one headers, separate out functions in
> hex.h that do not operate on object hashes into its own file, hex-ll.h,

Nit: I was wondering what the "-ll" in "hex-ll.h" meant, then found
d1cbe1e6d8 (hash-ll.h: split out of hash.h to remove dependency on
repository.h, 2023-04-22) which seems to have set the precedent for this
naming style. Might be worth including here.
