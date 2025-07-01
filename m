Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554A1B95B
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393403; cv=none; b=MSN5GAi/DJMVMV3A5bgsI9XnhPOoWjHzpfxfPDl8O/aazrZj32lK9Ju2fES7sjvHpMeGIMshEvE6hqjtAyvadumHu5pnouRjjswKmYUVFoRFVAb37+MaLumTnNsdCEujBRucfEdDY7a6cAsRz2EpHBFlM6HFkUUg/BW5o7e6O+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393403; c=relaxed/simple;
	bh=yuu+FrZTJRWP5yI9nXcB5rcj8DZorI/PLuemM0icipM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZRAUqRgLYjwEc12d/PSD4r8mHYYvPFYXDNTp4f7Wil3K2iISIypK5w9nUUTpnFZB4dufPYBK37Cm85pgKxip/7vLiEH1WW5kX4etnIJFBuVEA8T+371ynK/lxlGNPdYnLs6liWXx6gertq+BXEXP6gJNdJTNh+chavC1oaekJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TadAFdKb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TadAFdKb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso3564398a91.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751393401; x=1751998201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YeCqSymqJ0gTODSc+CgfxOC5uiJMFss5LhFu3xnXk8=;
        b=TadAFdKbELM10UjtK0wia8SyPQVVESlvU0YvDFJoxaiVatiVXWYMTc9ux8RuuCjm9A
         YdNteocaLV2VKBJfUps1hJ1bcKVe/6Vcp+9H0m0UZvdJ+fvpfMOyZFd5o3H38XJTzTwk
         VECWncc47Xe61zXDzDrOqWNs+z/61NW9csmq2tx99cihTiOIyR/hNjJdkVJZ4FEySChp
         fGam07V3L8mbrVyoMnKXhVnkvaPqK97uoCSw6ffA9ZoH4e0BaDGFG8yCwTDmpYBM0WXH
         mw8rs70SV22YHdDu1KLqXSCoAD1IUb35bow9T0Ylu+BEsp+t+OPn/LWF29DvqmXVl0Wk
         OZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751393401; x=1751998201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YeCqSymqJ0gTODSc+CgfxOC5uiJMFss5LhFu3xnXk8=;
        b=ABMtgl1DAnVyPc42TBPNIxdAE3F4aW8O+mGGKwyatrNdKgx9LdNFbZzT1z1+xVGZ1U
         zGGaN5wl3jL69DZfWltLLx8VZs9rmEc39U/gKPdKAeHgCGBVMqXHHoE56dfxBHNW/zd7
         YD01oGudWfCXp9XlDbk0VPE/SorXEG8i/hrRj8bcHkmVrRUNBNRJXnlvloBddSCtZGTK
         sWYI2aWqlDnhl2CrsZYp46l1w0GFsBlNsNo/UU87O/g/N/pOhR7gj3OZdFi+Wcc9NuKu
         Rv3qmGJ07IeQxl4QIzmPziy7F3uPN4+BPZQEC5WtXBWmLxTP+2nQQxVMTRvylgsMya2D
         6rIg==
X-Forwarded-Encrypted: i=1; AJvYcCUZyh9YoKIOmV/rO4tNF+9MntlVPPVLJd8hFBlQXiSF2N26Ui1ieyTNXtVLHV4taZQgWmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKTNLhq2zAIjmz5GNEpq12mnT5yyhnWyZLtxlvBJBzUWbhh7+
	UotUEiG+7uXVzY407jaqJVA6vQc7UK8h8sX2wnQjrFt7lCUoYr6QSCvfjBhytd06HInm+u8QZiU
	H8LettrexJ8RStbjj5noT7XyUMoNtH/0=
X-Gm-Gg: ASbGncvlnUeb0RlzvaLWbA5qkBUKj/ABkTMIO1vv1xfDdWvHokL1AMyxU8UmU9Qzc6p
	+X6JmWy7kbnmF5XoCDVvrRslRDtuXuXH/++Y25WCAbTyVs1J0Fuo+hSPY2JQa0UmSFTJ3JYPZBN
	54PzIERxB4OLw4hzSv6X4dNiym7WuGxWyiB3lGUASmJXDP0/aOMXa9o5SUG+DK2X6PN8Zr8QFX0
	nPONA==
X-Google-Smtp-Source: AGHT+IGvY8FUm2I+AHaWV6m+ClP1iGtUNFV+AhbhXDU4bk0iF7z7omsDZtfT1yWP2TVmLJNwGNN1Oahdsd8j0Nn9ZA0=
X-Received: by 2002:a17:90b:50d0:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-31a90b392a1mr10730a91.14.1751393400932; Tue, 01 Jul 2025
 11:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751296633.git.ayu.chandekar@gmail.com> <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcKgR0G72JRSlM@pks.im> <xmqqikkbkglx.fsf@gitster.g>
In-Reply-To: <xmqqikkbkglx.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 1 Jul 2025 23:39:48 +0530
X-Gm-Features: Ac12FXw7CZUHkoyfcKdWTEz7d4hZn8oqigJf0go3RQEH6_TQ94qIaPEuH6PtCQU
Message-ID: <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on 'the_repository'
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, christian.couder@gmail.com, git@vger.kernel.org, 
	shyamthakkar001@gmail.com, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
> >> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
> >>      expire =3D TIME_MAX;
> >>      save_commit_buffer =3D 0;
> >>      disable_replace_refs();
> >> -    repo_init_revisions(the_repository, &revs, prefix);
> >> +    repo_init_revisions(repo, &revs, prefix);
> >
> > Does this work correctly when running outside of a repository? In
> > general `cmd_prune()` is not executed and would instead die as it is
> > declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the use=
r
> > asks for help we may still execute the function with a NULL pointer.
>
> Good eyes.  "git prune -h" would safely exit in parse_options() in
> such a case, but this part happens before the parse_options() call.
>

Thanks for pointing that out, Patrick. Right now, `parse_options()` is
called just after the `repo_init_revisions()`. I can move the call to
it before this.

Although when I tried running "git prune -h", it still gave me the
expected output.
