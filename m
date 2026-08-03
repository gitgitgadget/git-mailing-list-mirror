Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582738399C
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774964; cv=pass; b=L/+WfP+9XsZi+oTk8GBNRS1RbOWDfiunk1TKMfH9wRdj0vtu5NaSwhGP5KBewlczpe1/tCtzLECHuHGieGTkzJtYyVWRH4YjXGdnt8K7nhKXPmOZrERBU71T9CLfbHwJp1coMvbLjKDOzItZIMVE3XYqiiKBM/bpVSaDXfrS/kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774964; c=relaxed/simple;
	bh=zgQhBDf52tsQmQUBW8ruHVUXt6HsYd7ZuOdVnJ2+3Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da2EWVJRK3KSx10G7rZ08Kc6hIfwhqPPFPi9lJ7ajHmQ2loiGWv+nvXh978hRYi0BXLxISQlARDsPw1R8xofN6PH9BULhGHV4Cu5VBuOGsQd/b3OA+CJlm5IL6tACn99S3Ho1trAFUmrolUqfMQeUan+Gc86ThU7uBIkO+rBWgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGkzSuF+; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGkzSuF+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso510192066b.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 09:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785774960; cv=none;
        d=google.com; s=arc-20260327;
        b=NcCn3iiViMf37NJaE35g66q1hxuNkFrNChsVKPxSzMCjKGn+cznjP1I0KQacm/JgvW
         cxi+5bF/0iv9Vd9so7hZMwdQ2GIqxkUdUwDl3NXBgfojAnCHmyf4NpJ0BB7/nV1W0BWI
         wbdzw3iQx7QDYc1z1qWHKLtql1yr9q+ndfPx7Ou74nOLWhqHKBbyvXPq6j6s+iXFM+9o
         XZ85qRypdqKUMegRjmJKN1jN6n8orYRLQ3PsVBz9+r9jIHc1Asg2sJ+tQ7fLZNskGN7e
         uxD0FHFcBDOGqaYsE7TXY1VaXDL7SUGSb/CjWG4m0ScgxeAHENXB9Jrb4sGWs51Wmd1e
         0Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5tfI1SPMbP5YB4sM0QDpi0sA+xE7pbvIylxxbHBW7xU=;
        fh=no65VhfDbqrRdoG2wIk4QjWRml4Jff0y50NtjxbYdBc=;
        b=J4Tc+wKgjIBsoJ7lUHtiTdKeC3H/c2SctxDTedcnKSZrnKlVXqGNFFfRX3WC4fzzWi
         gvp5KKdjGLHa48/n37qQl9pdQONe7SLxQSnvuUv4geN6yW5QkmoMIFFP3ACaC5Mv4ePT
         rHlWR8PCv3g9ziQDBLxCiTwPl/o9PRAyRwiZCZLYRXOs9yozmmaQR4MTsbRnf2QfXRck
         Qsju9UbPUkt4WKewHVYeGkgO87AIwWqWpvd6tt+ODnrSENgQVpymgGsyRuhv6sHvLxgq
         +TeGVZN4lRTNw6Nza6JEz14CxpkQsQuvuu/mZlOlGhzoBvlPbmq0ptFzmrq56g2/EP6m
         3XVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785774960; x=1786379760; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tfI1SPMbP5YB4sM0QDpi0sA+xE7pbvIylxxbHBW7xU=;
        b=LGkzSuF+thn2XPDgNBQNab4czQhk+4L4eqXAGrJaiRPin8591PeiUinRJstmDuoCf1
         ai56yxPUybM/hSs1LNndptOCa7jW/Dqm22zZaTLmqpPhYpSqLgfKeXwnOUk74OMAOSGO
         AtZigmZz1EwV06Rrz0wHa5dYcWBSdfTR1HOlWJVfJC1J/ZA/qJjJwE4Z5GuejV/wgSQz
         1EOuq0OZnj90h9bN0eNNpod8llmJoqM+8kiImi7F13CGiw8qg9XyhW4YGaVSndiuv4pQ
         YWhD+KQNj9qNl0NmwprA4+yqaSa1hc1eVWZ/Q1D0jB4OvDMkBqf8IZCfQHO68kRDgFAq
         Youg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774960; x=1786379760;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5tfI1SPMbP5YB4sM0QDpi0sA+xE7pbvIylxxbHBW7xU=;
        b=SNb2xw5SmuJdKZigXYAp/SdgpeRcqd6DqIbZa8VDY0lxsFg10ebyaxVqqZ6706bQBU
         wyf1X72E7X7LYKaR6IWDHH0Fp3uRLkZdEg3lJzr1j2SdiwrUKILur8uLbigRVQyBU2CU
         tgMIlEEUU9swl61DaizuLo/lCeANag5c2uqCAvGuXk79X5GYZiXNrOWWeH1dg/zL/ROD
         YsJZgMItsuCipK2YnjsyFbBQ2x2W+WtxCMKdvpG5phSdQEC0vm0ZHXJ67ec05e3RoC2i
         uGugmXGSs5bboSsY8tEW9Ts7UjiOxCIIUtT5OGGcf4txqGpfzLsLA/V33bM2lQn2LCsw
         ALNg==
X-Gm-Message-State: AOJu0YxxJ1oKmso9yyIsFLHUSVEPZ8A8np5nsx004/EWOM0j8P+3snx6
	4hBWa0lsi732IUFazbKTUocUMKG6WaYEGcsgoQHBGmWPg3MUr/z21CNI0ypB0f5CX1Jw+fCXJSf
	dPFPPa0tvA7TOKmRCNQPwJsXf+msjoos=
X-Gm-Gg: AR+sD12UDijgRVsyBMM6ZtR0kCwwgQtjE5lzBb2BFD9KNgQnqem9nAaK2s9jw1+jSi8
	AgJmM9GUQe5CsqHLZB4Ny7PeSIgkFV+XhPXDWY0iz/tH4406aI62yUP+FdsYpl0HzviaFDok0Dw
	7M2Cgq2fCwlrxkDvBnKu9zbiq3ILzCFTcAbnXaW5l2aCOYa11RGJpcNyxvk6A7FPYkDqXeyAzs4
	gVMVIy2FadEXXXa/rHEAXedlv26W3bfWsL/tyeXaOqYfbn/5rdeYy5V3vOrPHCcea3OeKB+OZo3
	3n/ImdJS6scLsJBY9q4QbhFZR4bEdkKblDC7PcocXiV/Kn79e+RBXWY=
X-Received: by 2002:a17:907:9610:b0:c1c:5c90:1bad with SMTP id
 a640c23a62f3a-c1fe7f9ec95mr932128566b.14.1785774959791; Mon, 03 Aug 2026
 09:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 3 Aug 2026 18:35:22 +0200
X-Gm-Features: AUfX_mzT_1MQaG8iDAYXa427tMYPk5H5qiLjkDV4rjCASV39dvqcFx1Xh8_sGWE
Message-ID: <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
To: Phillip Wood <phillip.wood@dunlem.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Matt Hunter <m@lfurio.us>, Patrick Steinhardt <ps@pks.im>, "D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> These patches can be fetched with
>
>   git fetch https://github.com/phillipwood/git wip/hn/history-squash/v10-early-part
>
> note that they do not support editing the commit message of the
> squashed commit.

Thanks, what should I do with it?

Is it a replacement for my branch, or should it apply them as fixups
(if so how do we handle the lack of re-edit support)?


Harald
