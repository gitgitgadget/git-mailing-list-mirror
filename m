Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE72DF716
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650772; cv=none; b=HCCPeeDbS6LYSYr4goXghDdlWOqJvZiLac1hQ5Q5VeNaF8udcGW9XZ2SsGiPkaruI62A0z/WY2JIwIlKGdoH+dx53Tj5Za4z4WOkLGRKa3HRgTYMvN44WB9cXWhIyE99eB9SjuFsVNwwyQA6Qni/2xkIwlKaKHLc/qgvlO9mlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650772; c=relaxed/simple;
	bh=Jm4fLWaEaRuEY0TuQ0ZiWt9HcOaQJPKJFdZgBvNCBFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+N5f96VMpE+lb/oub8Q8Iw9Uupb+UHK9ObNC3w6063EFD2ToBu5o9fBKlFJ06KkIbf/+N3VIq43JdzocksM0zMqhMP52XhGuko4UwNFtmAMTIxeA5O5pCDZbcwuK3s9cw+lA1LhkTbuWnRyfkU/7AXaQGBizjudc3bkA1jZb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3owiPkI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3owiPkI"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36620862d27so1269961fa.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650769; x=1759255569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm4fLWaEaRuEY0TuQ0ZiWt9HcOaQJPKJFdZgBvNCBFs=;
        b=I3owiPkI0kgaiW+qYer9vv4nHdY05/UXlyAvjfY7/ibu3+KgX7ErKnjUXXh05yOL0G
         jSK/4/vEQpDfERVOW67JPbL3PvKQMBntBBB152ueTDRDsRRe9Vd/wMEsaNfg7HkF1C8k
         aN3VnXdwVDSEkZYOi0KJsOrm2TaV3QE9UHxwIDY+AYUsMuLleGQZDrD5BN8OefUz0+XQ
         +hZD1YiLUkRrUPAqVMrvrvWbzY6NdmhHjF8DMljC4wCFyPb155nIX4DYJGDpOwexn4iW
         F30Slrn8OXNZq5HiR2+//DDykqj2IZr0y3iy0rJqQwuXsIYwy93r2Gqj+ATu0npAzJcu
         wo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650769; x=1759255569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm4fLWaEaRuEY0TuQ0ZiWt9HcOaQJPKJFdZgBvNCBFs=;
        b=j/JkAZxkwOubc0bBxDleCFiKs4yV9yspEJkhz/Dvz2RdxuDzkN/Z99JUewMJ9GvgdP
         WmmXMW/dC5et8JrIHgjmvTEXmxQbXVhojoWxlYIx67vVHOXGsbmbihEEh6JfkZxSFNdc
         30z7oo52rtTqrU+H09OV0DMo2wu8vPOKL8YhGjFYecyGrg3d8g++mO3A1OuJKqAB/pv8
         zCTGNWUaCq2ioc4p9JVNOSMkAZ5/jUv1SJSe5mv4Xf9T79rCsUIanY1xy7UYojnzzKDZ
         jAIbZGFrVTcKoYoG0Grm+VXvNNN4+vSER9qzlhxnM6cknPc/1GLiJkwyDk0yERT1F4XT
         TlZQ==
X-Gm-Message-State: AOJu0YxP1bmxAEaQw8vXMBvZH3sR6S2OFrxJgKO2S4HXNjP8nydVE/Da
	mKYJ6u+fOLV4YVgLjExr96Asvo+b4+fZZBFX0tC9XzVXzQlzd80dWI2kfoKy40bPg3NILDpEiQ2
	sf64P2iM687SW0ISIOH60wk+fKmTejHURsH8F
X-Gm-Gg: ASbGncs0Kh303UCdcRXj5HGqVhimmOWU3mw3f8I9EQJkBkpVLpWcZNmdTzkvoMIs/pe
	+RNNgDHYSl/Gd66LBQsqZDZEqxf+okMcGu0K0j1dSpoCpUiIm8dE7yNnRZ61ZAG87YUJ+IpKmta
	NnwMHmnpZV1YCD1BPneBx13Xwfu7QLcCqALK0NJXFYggj26XFJOIX9J4R+OOm6+BZmnOG9mzJpn
	yMuatkZ
X-Google-Smtp-Source: AGHT+IEMSTUpaDWzB3CczTYa32dmRgWahwJ7ZM1dt+0WU3MRnBb20/B8b6uf3CsAErYZ9sVOnUrYBKvmxRkk3nIzMgk=
X-Received: by 2002:a05:651c:512:b0:337:e0d9:69a0 with SMTP id
 38308e7fff4ca-36d192ea8c5mr13044251fa.20.1758650768548; Tue, 23 Sep 2025
 11:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com> <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 23 Sep 2025 12:05:56 -0600
X-Gm-Features: AS18NWAlbF9knRtdly6u3v11q6QzqDojTAJ5-TFqhEgEBOhYgQUFRYJhS0Tx3SE
Message-ID: <CAH=ZcbBO9bkZTTteZkLK6Ca0qS9v-_Xyw+Y471TFzpNSr7escg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:16=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
DROP PATCH SERIES: I am dropping this patch series in favor of
Patrick's. Everything I want to add can be rebased on top of his work.
