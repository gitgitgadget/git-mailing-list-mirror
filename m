Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1A13AF8
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNIx9BcA"
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E81AE
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 06:40:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9cf83c044b7so45171266b.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698327605; x=1698932405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bYvPC04otgWffIjA7siF0To0j8nzgk2kaSND8RbWwg=;
        b=jNIx9BcAdRWbxhHmUheGJjs2f2oxKqUdbgzSRDUCsDiAM8XMPmSmlAgYXVN9IJCJyd
         094K7VHsxKR/ZTL7bo+unmlXMp7jmmgW30ygJqRTw8SZIf44MhRVRAu7gv+21FFz3Dsi
         hYE4IPFYkKbbYroNyCWFjPn+7L18uXjPAttk878gpOU1JPcSUgS+gyWgoA88vBQ1YYxs
         li+oFlLb+v4gHkHwpFQqSaz2+gZ2yQaYEsb48UvrlQ5q9HQKPs53ufiGV7L7i1FLfeRk
         bP8XW0E6jCMA/al3j7wWHnuYuBWQBL6VUQNHD61mfkVSoxqlWIVp/cNUejEQNkHKuo4w
         8B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327605; x=1698932405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bYvPC04otgWffIjA7siF0To0j8nzgk2kaSND8RbWwg=;
        b=KEFnpkDzscmUgBB8hRc6Ou9sC7V2K1e7BpxKBrHqqpMS94Q1BHVVOCzT0JN8H4OsQi
         httUyuA7+059UZgXak5bHL0/Ntjo+qzdqLpdQs95kd6G+bNhJ9nk0AROdPR9ZmEzdJqL
         tCutlarp4lqDzZmNKfWB8SoFeX4fMRwiwivtDCl1l26HJhpA6nJqrYWx8idKN9+TWyZO
         zsVMO16WQ1z3vPO7cwFk/PWquPJtPfUJkCp/UkdolyLXlNbEghXDjtouqhAfL1g1URKo
         RHEBUQ/6Z/mUDUUQxQB2l7GPdLR9Rddrz9WxjStvxE5IXF8LWQVhpwnKAH1OWWGUMU7L
         H1wQ==
X-Gm-Message-State: AOJu0Yxn7BvFFvPUiTfg/oeYHjfmq4sBjI/S6BKQj822m5/hhE96kZaF
	DGBsbsoYWpULWbAz2ZQPS9J476pUiFTd42KDiNc=
X-Google-Smtp-Source: AGHT+IH/8r1DRHtDWeh6GI+J68ZmNkxKuNOtFoNQ/L1OHihD/nfbsE2pysI1EllqPf2Cw8corRc/tw==
X-Received: by 2002:a17:906:2551:b0:9cc:450c:b0d5 with SMTP id j17-20020a170906255100b009cc450cb0d5mr5240393ejb.4.1698327604887;
        Thu, 26 Oct 2023 06:40:04 -0700 (PDT)
Received: from [192.168.192.11] (mm-143-13-127-178.mogilev.dynamic.pppoe.byfly.by. [178.127.13.143])
        by smtp.gmail.com with ESMTPSA id rh8-20020a17090720e800b009930308425csm11642081ejb.31.2023.10.26.06.40.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 06:40:04 -0700 (PDT)
Message-ID: <877d95d2-b978-4fa7-8216-8743fe155019@gmail.com>
Date: Thu, 26 Oct 2023 16:40:02 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
From: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
To: git@vger.kernel.org
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <da246287-8530-4680-8fcc-f68f881bc24b@app.fastmail.com>
 <e38ebf04-cf92-c80b-3432-bf86ecda1054@gmail.com>
 <840358e1-05b4-4730-a89d-1efae568d04d@app.fastmail.com>
 <c37ba153-7239-49ff-b40f-370bc695986e@gmail.com>
Content-Language: en-US
In-Reply-To: <c37ba153-7239-49ff-b40f-370bc695986e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > Squash and rebase are functionally identical in this case.
Sorry, but for me `git merge --squash` doesn't work.


Currently, I have a global option --no-ff for master
$ git config branch.master.mergeoptions --no-ff
In this way `git merge --squash` crashes with message
 > fatal: options '--squash' and '--no-ff.' cannot be used together

In other way it writes something like
 > Fast-forward
 > Squash commit -- not updating HEAD
and... not updates parent branch.

For example, GitHub propose for PR's:
- Create a merge commit - the same as `git merge --no-ff`
- Rebase and merge - the same as `git rebase ...; git merge --ff-only`
- Squash AND commit - like two different operations. So after squash we
still have to merge our commit properly into parent branch.

The new option just dynamically selects between --ff and --no-ff for
`git merge`. Nothing else.

-- 
Ruslan
