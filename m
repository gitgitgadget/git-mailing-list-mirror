Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCBE55E
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2KZAIsm"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1f33c13ff2so206201166b.3
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 22:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702882416; x=1703487216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KFOuhLcn2sIAVdfEBIWWZoeBFmade2nOP5e3/znLoc=;
        b=P2KZAIsm2tiEZte/XIUnPMda1w3YXzHJ/lnaixO0qDVSrxQseHy61jKaMB5tSXXdeO
         dmfXjveORG6Rr+akRcRd2B67WRYL7DI2AQEUoHFb05cbcfyPuD32eH9vVmZC7Nppj8NB
         BYS5xz5jl+xdrmJlXJjpM6djBDYEs5+o+3koPs/HnbJkt0U4QBB1J1qvPLkc//INKdP+
         DNCRVZaKcANI+yilNRNJ4yzpy2v1uR9alZQe+fpRTWGd974rASajCBqU0Fq3A3vZsg4R
         n9KGz7VrllDT5tltFBbyBSRxofvDf3kxlrHutY+FvrxXeLLhQOthSg90yImUxKabwOzE
         nc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702882416; x=1703487216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KFOuhLcn2sIAVdfEBIWWZoeBFmade2nOP5e3/znLoc=;
        b=t94biol6Kbo+2UkOYdZ6fMju1KePfQIJz/RuvBc5pIuhJUgD7wf7AbeL1geY/rbIIF
         ksw58vQhM4JblkQIgQVMmvqb2HmABWLkLYfSSVdQuiOVYiOaQf1AbQve5elWNRsaaRJb
         9qUGERvBtwkF0MxvTo1s80YeKbKGbMYw64Pcdu2yDKL5fGeG9n5wDcYZh+LzsJA+hkUJ
         vbJujeMJqmbpdv2n2nQxCZHrJKAG/Mt7FvxZe+i20fL4pR2w0WlKCnwVk0TFjSn9/v9m
         RPaQ9oBCDA309cONew2zUplnrwNdcQAjWW9EfzajqkB6uShUB7qDrQhAvmHKT5xVQdTW
         NCSA==
X-Gm-Message-State: AOJu0YyOe1auYFVKd7KRvYD82sLvk1sTlTDo5O+RyRH+oZA0tRK5+fjT
	nSu/u41QMMIND5spkpG032mMrveLGCtjdQ==
X-Google-Smtp-Source: AGHT+IEgTjpmfOJIsC4TcPg+bI4zweDITvpodEMQu07vFm0PICvYGYxE9cOkJGM3A+pg/ruMd2m2Vg==
X-Received: by 2002:a17:906:84:b0:a23:499c:75b2 with SMTP id 4-20020a170906008400b00a23499c75b2mr756646ejc.70.1702882415559;
        Sun, 17 Dec 2023 22:53:35 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-39a6-bdd4-29ba-7091.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:39a6:bdd4:29ba:7091])
        by smtp.gmail.com with ESMTPSA id hx14-20020a170906846e00b00a235c133583sm600165ejc.126.2023.12.17.22.53.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Dec 2023 22:53:35 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Why is `revert` undocumented in interactive rebase todo help?
Date: Mon, 18 Dec 2023 07:53:13 +0100
Message-Id: <20231218065313.55725-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!
I wanted to align rebase and revert/cherry-pick a bit more (for the
latter I am currently finishing my patch for --show-current-patch and
then looked into possibly implementing --edit-todo). To avoid code
duplication I wanted to reuse the existing interactive-rebase code as
much as possible and ended up at the todo script parsing in the
sequencer. I was a bit surprised to find that the file could already
handle the command `revert`, even though it isn't documented in
`append_todo_help` of rebase-interactive.c - is that by choice or just
missing documentation?

Whenever I wanted to achieve this I used `break` and then manually did
the revert, which obviously works fine, but it is much nicer to put the
command in the todo file... (Now that I think about it I could also have
done it with `exec`, but that is also not the nicest solution :D ). The
only other command not mentioned is `noop` which is obviously not too
useful apart from distinguishing an empty list and aborting, so I
totally understand it missing.

Yes - in contrast to all the other options it does not have a single
char notation (and 'r' is obviously already taken und 'u' for undo as
well or 't' for the last letter), but why not show it in the list
without it? Or maybe add 'v' for "reVert"?

Cheers
Michael

P.S.: @Johannes Schindelin I saw your work of making the todo files in
the sequencer more reusable and the many reworks/improvements, so I
added you in cc - I hope that was alright (otherwise I'll buy you a
Kölsch as an apology ;) )...
