Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DE3DCDA4
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176708; cv=pass; b=tNzWaC/XJ0bq6w0cjWV4/0AKk6pAJPSdlWUwCb2N5FzDU5MEy3NfIm4DpvjwTljlfTnSL9e7j0Dr8Sj2LmOCWE1TaQYfm1K+44FiL7ywtBCsxImVkZgwQZazBdVKgOA8SogyG5OAauIOVboZUA5ltPQTNChA8OFPAJHBc8JpgCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176708; c=relaxed/simple;
	bh=SJ5mSzZpbokYkTeUrojVuOzsFbi3P0a2bJKtN3SaCzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FijWcGJ8vugM+IoyuY86jnAWhjlB/CreXnoAhTHanMFs07UvUlTq7K4W08K+rMxHhSLaID75sF+g3brTVqRa1YrjPYKqaD/0I6e772+CnHHGOghJghpgfLxrrzMy7dkUoXUPjVS+g0g5+phkA14DYHZkeWqW5d2S4sx4v3vGPR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhfoKLTG; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhfoKLTG"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bebb72b845aso1259282666b.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 04:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781176705; cv=none;
        d=google.com; s=arc-20240605;
        b=b5g+pIrKer9niJRKrX3DYMJkgUVL+lM6cV5KhGt3ZTG8fjNWq1ghhWU33bk5CAZHdh
         UQ9rae9UWJcgjInpz9dfzJ4ejM4Q/C5385KDx3vG8Td7So3SBQcOBI4a0qjzgV8Z8gn2
         1v9neKm87vEx83vVr2O61zudRbs7ujjYJHOsL0xQp5chEB8iPU5iQrWfTyxdK+Y6MBxT
         18nkxsL7Af7eIBiqVF7MBffcLyjqSo3eHGBIHMt2QS0hR2nEpSrKEKGliSk1G42bLKUS
         PQlteOci0EwuZpR7Gd8QNtcffwwFLNSdsHyrj8uo0xm2zR4JOzwTk42um4/KsmXTFSLn
         4keQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SJ5mSzZpbokYkTeUrojVuOzsFbi3P0a2bJKtN3SaCzo=;
        fh=cnVTxPqFsYP+zazeOPiMQunEvSHtzPF6bPjKz6ST5zY=;
        b=Da9VwX1qrBJCWPGGq+VaW4yWLtnMTLQOVIcHBdP9VlCuvuayiL/+Tv93z6O524Zq9k
         HJUnyYbTs1Dg8a/hwrgfz+fjUbimJNcacvDh6uDz57PaI1opRC2zXxuRiX8NuSzAjor2
         etXNtd19gcKbLQ60Ldkkijh/UMXKLQDSlzc9ihiM1tibc91ePYUU72oJS1lJklBZaExU
         a1nWzvQ/3S7h57IAi/zIaDK5OWqnen7Uf4XsdhaMRJELKFbQB7D03eHI6IQ2PuuCndVM
         GPrXOaE0yMY/ePyiHR1nFjJqkg5VKK28QnWwZ0MiBisNr/XDtcGQtamFo+IQabwMQcLa
         ZbQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781176705; x=1781781505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ5mSzZpbokYkTeUrojVuOzsFbi3P0a2bJKtN3SaCzo=;
        b=bhfoKLTGg5ozQthJcvwgcvXCt3ZpSNQi+R0oJ7zkHfmVegyKD4qI3guhxqJ7BLlXn8
         o9H2boL/cbQsNKnkaWLXThCRNQxw8kEkq95FPxtmkJfRdzqXTd/7KRc5aHlmZUm4ebx3
         56owE7wJjajCGV5zE4R9A13VZuBk+lqCes0ghvQMUbdTmxk+v9zD1OHgZu9XAURR7qkw
         XAqz0C1eqGKQ7ZpSdhd2o3ytb7GAuTssS6Jp9F5bRUQTJJXDY/nC28UMDzPNbmrvfNHx
         A+odUGeFGf4sFsXuG34pPrp3pQm2EZKQaLw/uU5A3AHnFctJP0pyhClD9k/LTJ2ka4Cl
         +Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176705; x=1781781505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ5mSzZpbokYkTeUrojVuOzsFbi3P0a2bJKtN3SaCzo=;
        b=CPjMTHXrhCMnw2fdjQSnmq4QMqN8fzUVmWqguchhbpTUN1wBlHjybB5mOGBJ5l6Hn6
         geimOOEiZjoMaPi04LZO6nXQgkDB8VgisqOcl5W5Rj96O+hEULHeKrdGLMBIUad/Hbmv
         2tQOiws/jfMwrhfxyVGoss2snLQg7U29jWRiS1k9rVPinZnjyGkZK17Ni/sOtIhZlJhh
         rIHaumprs+t0rJ3TEqWyJEqK5m9lGw/9feSE+egaan3dq2TIfUJ/AfCJrplUR+CFBJMH
         YUzV1wvWWN1FKufq+5X+aGty3t8PpDgOqJyXYUU0mp1pY++AmVVU08H0IWvcoUhB1ief
         LbNg==
X-Forwarded-Encrypted: i=1; AFNElJ9Q0rnRIjTjsBeuQ2Pj1XjdXMgP+7YIibcCtGUImcquVORekjDR6UwaECkvl/hxCX3Z2GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAj2wmNarkkvpIuXomn61d+RuEzXL4eJiJuGw0dMaAYB5Fnjij
	Wj714wlK3Rrwi/g43wAIeSKXjxm26AJJ9US4KoDIduMKD+fkXmkh9toW91YR1+MB2/pwAdhcfSw
	HFJp2tCQ/r3kFk5zEyggdb/lAgaM2Fec=
X-Gm-Gg: Acq92OGLQGZmwWulA2zmM1fwtE9lBTN5Zz8fp58/z0lI8ssRHwVHzP/beRR0eKBGWm9
	PSlQqPs9z2dk26pyQioy2cLfV2Wr3Ax4fa07Rb1MmTYjB+i7Vh1wuSkx0VophH106mZ9Zo5wHOR
	NelTrk0uYzWwcO+1boPNcYIb71mgIwXEP/zKv/HdQdiqwqkKj1G3lZKBxEE/fNgGSvctfqCmODL
	le+uEkicHWfbP9EKB5d/lEEvjhawOL4SRNBjMA7eSQ8lEjprFlLFbxRCkfn4uq27EvMjI/mG1cQ
	Ac4mSGsKyX923VaoYQ==
X-Received: by 2002:a17:907:3e21:b0:bec:e6ae:2f69 with SMTP id
 a640c23a62f3a-bfc87bf96a0mr111649066b.30.1781176704896; Thu, 11 Jun 2026
 04:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
 <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com>
 <950f70ea-1615-402f-9cd4-3317bf177c5c@kdbg.org> <CAHwyqnUpiWmXo0SVr=7L-+cwA+qhVyqodpV-O4C46w=kLqaLMg@mail.gmail.com>
 <fdf7f988-d345-4107-845f-e089d7829c16@kdbg.org> <CAHwyqnVSnf9K50xgUjeHFM395Rvj_uTVvZ1U8EZayNDZeMP4Bg@mail.gmail.com>
 <7b40cabe-d243-40dd-ab29-fc4dd91fa20d@app.fastmail.com>
In-Reply-To: <7b40cabe-d243-40dd-ab29-fc4dd91fa20d@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 11 Jun 2026 13:17:48 +0200
X-Gm-Features: AVVi8CdBC1vH9usivn2jEpUGIcN9h6UPGjZH_kysvViuO5UwVYN_ESEUKnBiMK4
Message-ID: <CAHwyqnVvSBCx=KQck+Yb-+5Ff05suHVPFqdVrg5atnbt1=fOMQ@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: silence install recipes under "make -s"
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, 
	Koji Nakamaru <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for the explanation.


Harald
