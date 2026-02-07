Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783F23D7CE
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770498182; cv=none; b=cOb0d1kTn3qqLt0UDnwIU2Ao5hEv1HDZ3jIonmqBWzonBpF7Gv4xZyeEw0kBW0rzVsvEQ0oFHLWweQcoi2kZvFDjjnL0LhJc0B/in7aTua8hCFGrCk2ddAgyXn5gScvrfxEW6xWVrIemJqYGIByNhyMQpssAzufWYAydbz7EAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770498182; c=relaxed/simple;
	bh=tfYpSbOj0ikEDgHCT6PruMMldK62Y58rzIvm/3xFUKU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iIDcUVrwB8iSN9dm9RkhuPilhy6pTZSYYzJhVhDRwQ9g7WORRbqqHuX0KDbHaLYemdQPwu9i1ZZ3BEAe8J0o3AslCnYN9xKwPLh8srCy8W8tyUtt5w31m5WN2IEiaweCur43HuIWnJsEmHIuh1MFNgI1wXiA11F7R4RFiW0rf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKtZ8H27; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKtZ8H27"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79639c2ceb6so2389617b3.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 13:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770498181; x=1771102981; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd4FfgI3Cl9Krl8DOVs8P7qTluKQf+TsZkeCMH9PVms=;
        b=jKtZ8H27QJ8BqkqFcJCzeOnDEUzqQruB96p/4m42sfgpllkt2/vUYaW5LELhXOqcSN
         ukqUfnqh3HCnKiYaSCHRKvUf8duGRM6PmYaZsMD8nNTCPrn3F7+nsy1P/DsCGiqA8P3e
         klXdwiw/kFphRxxg7uL1+2kK2NbpR2rSPpN0m+VlJy0jnWbQWCwIsV7A+Ziuj6RzqdMq
         c3tSKYnOs66zr3sxDY/nbL7uLpcXHztSYqM2lWXqwekf3tzMthVXVvhR0fIay6erSbw+
         TWJ1CiXe89IfyZ12Z61MGP3M9sqXvTQlYmiq6O/t2os9RJD3MgH6JSQj9Dzb6mBiyO/L
         OjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770498181; x=1771102981;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pd4FfgI3Cl9Krl8DOVs8P7qTluKQf+TsZkeCMH9PVms=;
        b=SQcmUocIUpXP9l5qsECKU273Mg8WGQbtGrLlVPyRNgOsrGAmPnkB8OyX5zqp5vdcRV
         ybBrYATzVV9wgwdr53yJ4khs86VAdYtaMa8/VwiFeDpjSyYgPTNnPAjJEjYNhOU6T2bU
         w1OF6w2FWZkfmS0WgXRnO5kfJldKZB94rMiY4I+B/u/QKgMDLQxS9WvZjuwmI14YLZdw
         WQjYfRRbpT3mg9CyJsSBLohtgfD5gaSjJNO2SkpRbyRQGT7q+/P/e/w8hh6xkUJJ8PnM
         /lRzXeNhh4TlD7916iPMCNqXDozQDLdBATUrubyhyxhhqwXcwMnJuPLzWbcPiT7pYahe
         5cJw==
X-Gm-Message-State: AOJu0Yw7B2FUCnGrQJsx7/GlQyJpNH9WZfHotEB4mOSDL0pa4RK//73i
	Ol/zAYaASMq3ID7z2HB4XB9Db3QurW7cS7d/hbxK3o07WtXlWtLSJTdi
X-Gm-Gg: AZuq6aLJDYoLd/TMSeXuK6JZDUcFyvRbYzRguj9G01Kx8i9DaF/Qb8PONebrPJ30i4e
	MLiGQhpbsvAKV/bogWQySTGoP44/p8m5eSr4OYmlJKicKowYAAv1UVPTjBxcWglAuhWmpK5z9LV
	BNKeq5bFNfftkqqzW8I/rV3dgbG2HQsG6fcp+7HZfEoStH/5cAMHPC4fSkVQn5tndcTJJEhN0Ww
	Q4KEp1Rz9vGETF7IWg+ocL5WBjAD/RIJVQg1AivuM8M3B53NAhyK1ozjSWt9hZT7Whb0IlH8Sd8
	V5oCE6pxahd2DrpuWnfn5Jas8RV6d0bdzVXeRV/9zETb5nQ/n8f+0dvM+GT6b2+jPWQ+5cHH8Of
	C/FoQR8WzmtFSXkzR4Gk3yh2VLokJm71rgsBl3MtoHxCJ9yMiWs0cgXgbVNCYHgbpQRpEsKv+vt
	Yho5wREHb7hy85K5c+5w4Ds562cXi+fcpHGMWTkhSf
X-Received: by 2002:a05:690c:450f:b0:796:2ee6:3f9f with SMTP id 00721157ae682-7962ee645bemr30891227b3.14.1770498181448;
        Sat, 07 Feb 2026 13:03:01 -0800 (PST)
Received: from smtpclient.apple ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7961f313e02sm43604277b3.48.2026.02.07.13.02.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Feb 2026 13:03:01 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in
 read_attr
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260207114007.40-1-kumarayushjha123@gmail.com>
Date: Sat, 7 Feb 2026 18:02:46 -0300
Cc: git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E605A7F6-AF4D-463F-8316-6BE69AFE0369@gmail.com>
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
To: Ayush Jha <kumarayushjha123@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hi Ayush!

Thanks for your interest in helping git-repo-info, even though
this second patch changes the focus. It was my GSoC project last
year. 

Nitpick: there are two [PATCH] in the subject, and usually we use
only one subject prefix. I also think that this could be a v2 of
your first patch [1]. This way, this subject should be:
"[RFC GSoC PATCH v2] attr: use local repository state in read_attr".

Tip: use `--subject-prefix='RFC GSoC PATCH'` in this case, and
set `format.subjectPrefix='GSoC PATCH'` for your future GSoC
patches.

> read_attr() currently relies on is_bare_repository(), which
> implicitly depends on the global the_repository.

So, wouldn't it be better to make is_bare_repository depend
on a `struct repository *repo` instead of `the_repository`?

I don't know how feasible it is to do that, but it seems to
me that your change could benefit other places that depend
on that function.


> + int is_bare;
> + int is_bare_cfg = -1;
> +
> + repo_config_get_bool(istate->repo, "core.bare", &is_bare_cfg);

This function returns 0 when the config key is found. If the key
can't be found, it returns 1 and doesn't touch `is_bare_cfg`.
This means that if "core.bare" doesn't exist (which is unlikely,
but, who knows...) we'll proceed with is_bare_cfg = -1, and...

> + is_bare = is_bare_cfg && !repo_get_work_tree(istate->repo);

since -1 is a truthy value in C, then in this case we're
deciding it based on having or not a work tree. I don't know if
someone with more experience than me see something wrong with
this but it seems ok to me. However, I found this way a little
confusing to read. Perhaps it would be clearer if it was written
like this:

int is_bare;

if (repo_config_get_bool(istate->repo, "core.bare", &is_bare_cfg))
	is_bare = !repo_get_work_tree(istate->repo);


[1] 20260206152002.1244-1-kumarayushjha123@gmail.com
