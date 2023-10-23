Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95944C6F
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coup.net.nz header.i=@coup.net.nz header.b="YkJb8Ej/"
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C38E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:29:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507bd644a96so5333125e87.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google; t=1698085747; x=1698690547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hLG9Tyq292Aazy9wW1g0ZgI5eKXZki+6jjmBEo4tF8I=;
        b=YkJb8Ej/sXfUbnN3+plgbhdZSj8lKBivrCVr9XCxqQcguhX+5RQlvauHveaETX/P0b
         qYM/SorUGioVDClUNgTv1wqd915pHcXszQV2ezSZ/hrLZn18k7ULw9HHakAW1UxThcPN
         CFc3l90/fQVrZsWJ8eOX4rca/LTS4Hw/6XkZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085747; x=1698690547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLG9Tyq292Aazy9wW1g0ZgI5eKXZki+6jjmBEo4tF8I=;
        b=Oc8ujMKmVkyl5TImIBOHSj1JfCeder3x9yQoYU2Mbc01MPA5BHm6td5g2b7RPJhwsw
         ec/W6K4MvXKyQOywtfPPk6u7VZAWk5sI+vVW6p2qCpyd2i5LLRbes5WGVSvBgPOSj9m6
         k1b5+l3HLMKfdOv5FIUk21M167vGpLF7yvCGRF6orlnaMqlIZSNv+6aqlMVofpj6PbeT
         ctdgcOwYKcgjaU5Am10ErVbaMHmpQR7SaEjxyK/TgKctYmyJsMR+jWogsdt/uhEB2G6c
         mOOWCY6MPGZuGIKlp0UT+Ghqll622PIwsj7dMUmfjTjrHzMK4zXbMBAGt1bJhtzmUgu7
         o6pg==
X-Gm-Message-State: AOJu0YyDTGkTi1GP9H/pRvcqSp8oG1g2BuGJD05zkCyw4KhEmI4O0KbQ
	DEOpsNyOTarIIKxNy4lskGUBWWtVHuSr63IhLX41qw==
X-Google-Smtp-Source: AGHT+IHW7BuvyfMMKKIlZaM7/2Kj2aDrLNSxpjl6ak9dZjesWHBM8NmIVdwCuVaOEZzzv+3MhQZ9LxOBm1f0E5tO0lI=
X-Received: by 2002:a19:e05c:0:b0:507:b8c5:654e with SMTP id
 g28-20020a19e05c000000b00507b8c5654emr7202066lfj.1.1698085746879; Mon, 23 Oct
 2023 11:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com> <pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com>
In-Reply-To: <pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com>
From: Robert Coup <robert@coup.net.nz>
Date: Mon, 23 Oct 2023 19:28:55 +0100
Message-ID: <CACf-nVevRU+yxfv44UcV9VcfAwuWLa+4w_OAMAVD5Z5nshqq7g@mail.gmail.com>
Subject: Re: [PATCH v2] upload-pack: add tracing for fetches
To: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jeff & Taylor,

Sorry to nag, but would it be possible to give this v2 patch a
look-over? Would be good to get it progressed.

Thanks,

Rob :)


On Tue, 17 Oct 2023 at 22:12, Robert Coup via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>     Changes since V1
>     ================
>
>      * Don't generate the JSON event unless Trace2 is active.
>      * Code style fix.
