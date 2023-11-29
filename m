Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="StTxtaeg"
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BFD67
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:30:51 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b898c9b4cbso144807b6e.2
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701293451; x=1701898251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZyQB16iqiOZTmwhFmYAOX/K2yqQBIESsiUyMPGIGq0=;
        b=StTxtaegQiI26trzw05j84AHgA/D2LQt935Rjf/IhxUxiX0/Yi1edEMNGe/RyXWzyn
         V9yREN7TAc74CVDwIIW6bUnkWcPmqTBm66Zb9u6KucVlWfFZZAt8iT4HKGiBZvyxuGBd
         7kyTfLo+7Hrv/fYpyW555UVhHJykgOIDguq3UY7p+2CW98YlBbzMrto/wBtt1CaOXJvD
         KbRLOTsH8Z7suOqcKWw4iE4MsQWzYkaNl/ujJGMLETFm8COXI3mwV5h4Jvuuz5gCM1Y4
         Y0cTdW587XQ88YlG5RC5A0C1I/BOiJqe5pan+NMxwW06GKU9gSguhohiRhGeNypG+SE/
         Im+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293451; x=1701898251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZyQB16iqiOZTmwhFmYAOX/K2yqQBIESsiUyMPGIGq0=;
        b=poeP32SXdEUQwufvIZG6wmjdlxgKiTWICVTB/8WmaGT2KtnRJ2srphtiKzYs6JQ/AD
         QVchO+YO6qiZUE0rVw0eAWCWSLr8+5NaBvO9NmquUtyhNZIr/KuWUZE7/5mRuz96I5LU
         Y/P64pb90ZPLQNEP8ainM+rTh26Mnai1vZoTKVirjPRXFVWJUjHRpDKBEdv4VXSXpgHm
         DR5LZxDMaqXfAw8xqhDe17xzmMy9oo+Uqz96fo9QKXlo1uUew6CB/q1/hSZ8crXU2p4i
         LHAW6RKeUin+W+3XlAtvIKI+3Q+I8G2+DStGGEJH01TwMjGBRJ8bO1+ueZVs4ldeO/Je
         nH6g==
X-Gm-Message-State: AOJu0YzLghXuH6nElIdbwVq9H9iaNs/YuO0+oHvy0P8ax42lPV2Y2cWb
	leCvhu0aGYBesurHVkYjPabNTacFv/t5g9RmbLQ=
X-Google-Smtp-Source: AGHT+IHH5dJxkwirh5e5nzx1HyZ/6kRVMwaCL5pbUBSfuxCJoJ1SqSPEa4cTrfvGEukrZvTW6tebLw==
X-Received: by 2002:a05:6808:1249:b0:3a4:6b13:b721 with SMTP id o9-20020a056808124900b003a46b13b721mr22733417oiv.46.1701293451063;
        Wed, 29 Nov 2023 13:30:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ss12-20020a05620a3acc00b0077d62e78db9sm5711241qkn.128.2023.11.29.13.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:30:50 -0800 (PST)
Date: Wed, 29 Nov 2023 16:30:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZWethlRRtuQLDRlJ@nand.local>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128190446.GA10477@coredump.intra.peff.net>

On Tue, Nov 28, 2023 at 02:04:46PM -0500, Jeff King wrote:
>   - whatever is consuming the embedded repos could "mkdir -p refs
>     objects" as needed. This is a minor pain, but I think in the long
>     term we are moving to a world where you have to explicitly do
>     "GIT_DIR=$PWD/embedded.git" to access an embedded bare repo. So
>     they're already special and require some setup; adding an extra step
>     may not be so bad.

I hope not. I suppose that using embedded bare repositories in a test
requires additional setup at least to "cd" into the directory (if they
are not using `$GIT_DIR` or `--git-dir` already). But I fear that
imposing even a small change like this is too tall an order for how many
millions of these exist in the wild across all sorts of projects.

Thanks,
Taylor
