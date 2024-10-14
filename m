Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1944683
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940133; cv=none; b=Lx8FLFFNXHlUGHeUbV3Lnc7PoUQAa1KifrVohSkMXczXzj4IwS5YaCUCPufHO0zoP8u/aAspNvvvs1BmbA1ifh6gLse4+PUO/apBxxPKoOzOfBSZItIKToc5qGCD+8qMc7nzO10MgxedFJ2Z5OnGca60C5UqWMKp4V4jrmOmuy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940133; c=relaxed/simple;
	bh=BPEtqK/veOg5LiTDFCy/81yBT+Nkb/fQAuOF6tFCnEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgZPyJKWooq/6GUNzkP+2icW3G7FyoQs1cksvjcTQQEfxfWlFmjOuDUY9E1Ap/YvcsZtKpz9khrFObLkXFewnzdpNrVRov725qBSUQaipCigZQPbm8MFr/AAa8fdlMslck9DWXR6ChL74ztTtOZHXRvtLAE+zqVo+fXV5Rt84+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EKUBu5kd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EKUBu5kd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dfff346a83so43252877b3.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728940130; x=1729544930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAEuqHA6jPSL4FQ1TuicXlQX9OGiSxI2Y7ijJvekoKk=;
        b=EKUBu5kdctSrgeB2CcRh8rg7FUBWUjzcaeW9BM7ee0DHdF0J7oo8Nb1O5B+UofVLFb
         tofCOp11FAYxLCcwacz1zoYCo8Xfd3+T5anKGFlbbjJc7+kvHnwkKO5W6SdDvXCuouRn
         NvZFQJ6/hXoyw8K4BcULGQGdqrbNJbwE5kuLd1Rr4tgHvSWlNYgZDhPUEps8ux8DmL+h
         9hrKw2r1Q15rDvfhgy+rmSEH4rcCmuoEgTcpNpVErX/3Mvs81Y/JAYbYmFjbmGVHaN3J
         VK01Wq830QnDcsIc+PWntWM4XoCi6aFpjzDBx76VLi6axEIui4Dxl7tnwGBlMmYwXw69
         yYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940130; x=1729544930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAEuqHA6jPSL4FQ1TuicXlQX9OGiSxI2Y7ijJvekoKk=;
        b=HcrcF544FdnxpOWWGxu6pZ2eqLGAhHXYM3eTRwOEZ/gNmIARUzzu3POt+2TywnotJM
         4JhIXqzlnchFmPUogZx2okc+lAfgtkmhns3U+zCANicJcKwKJuZ01gS1Rht2oT42ja0O
         omOqGts7y0LxnTM9oAJBvNXz9CZ9jNbAGDkIsuIXuTltn0Xks2VIH2Ym3Mr6GwQn8+pA
         CmwDC5J0fH4TR7JW1GG05tXL9tvPM26UiXDgr7BfID9PgzfDX6lW+Do9TBnUvKxN0jb+
         yuO/bkj1dYdp/wk73hOMv/h+/F+yZZ+AvrEaBuXvcmHoTPVdjECP8m5YNltF0NwMTW2d
         rpuw==
X-Forwarded-Encrypted: i=1; AJvYcCWbSzkfNonTDnWrGSmsUmhE1ut5tp2nUhn27J8NvyXEDkZ1wUidvdFnzRYB9YxA6JjdqEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSz2sQIhD8DNb+9ccudCkNEqv3tWisgGCC1ANymNd7An0cP8P
	jEwLscvtL4cABP8pbUGsyeB1GIB6DHDLtBIUs9y0+7esDdJtNs4s5RJlZy5Z5ZU=
X-Google-Smtp-Source: AGHT+IGOgFbQnCdi92/TAcQH7kzpaZNzvJ8ulrwIc957AVZt6JnYKDB8aP2X/vCtyQM9Qp2IGICdiw==
X-Received: by 2002:a05:690c:5719:b0:6e2:50a:f43b with SMTP id 00721157ae682-6e347b368c0mr70395657b3.35.1728940130088;
        Mon, 14 Oct 2024 14:08:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b612a0sm16587147b3.25.2024.10.14.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:08:49 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:08:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
	Abhijeetsingh Meena <abhijeet040403@gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs
 automatically
Message-ID: <Zw2IYMPsywFCN5Yj@nand.local>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
 <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <CAPig+cR4WbcDDav0cdXxOMC-EDe2ipWxEzB+0C7zbFjvY_kXtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cR4WbcDDav0cdXxOMC-EDe2ipWxEzB+0C7zbFjvY_kXtg@mail.gmail.com>

On Sat, Oct 12, 2024 at 02:07:36AM -0400, Eric Sunshine wrote:
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > @@ -1105,6 +1105,14 @@ parse_done:
> > +       /*
> > +       * By default, add .git-blame-ignore-revs to the list of files
> > +       * containing revisions to ignore if it exists.
> > +       */
> > +       if (access(".git-blame-ignore-revs", F_OK) == 0) {
> > +               string_list_append(&ignore_revs_file_list, ".git-blame-ignore-revs");
> > +       }
>
> A couple style nits and a couple questions...
>
> nit: drop the braces around the one-line `if` body
>
> nit: this project uses `!foo(...)` rather than `foo(...) == 0`
>
> Presumably this consults ".git-blame-ignore-revs" in the top-level
> directory (as you intended) rather than ".git-blame-ignore-revs" in
> whatever subdirectory you happen to issue the command because the
> current-working-directory has already been set to the top-level
> directory by the time cmd_blame() has been called, right?
>
> But that leads to the next question. Should automatic consulting of
> ".git-blame-ignore-revs" be restricted to just the top-level
> directory, or should it be modeled after, say, ".gitignore" which may
> be strewn around project directories and in which ".gitignore" files
> are consulted rootward starting from the directory in which the
> command is invoked. My knee-jerk thought was that the ".gitignore"
> model may not make sense for ".git-blame-ignore-revs", but the fact
> that `git blame` can accept and work with multiple ignore-revs files
> makes me question that knee-jerk response.

All very good suggestions and questions for Abhijeetsingh to consider.

At a minimum, I think the style nits need to be addressed here. But I
also think it is worth considering seriously whether or not multiple
`.git-blame-ignore-revs` files should be considered, and if so, in what
order and how they override (or not) each other.

I am generally OK with adding one of these special files and having 'git
blame' respect it automatically. But once we do so, it is going to be
considered part of our compatibility guarantee, so we should get it
right the first time.

Thanks,
Taylor
