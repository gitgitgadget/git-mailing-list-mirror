Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED68303C97
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889688; cv=none; b=TWYaADTkpfiOjbhLJMrZAub0hqJiTvi3uV404nMR/syci3zJ26NUHE6m0IDfNQfb5XIpLUTpMN4hsw17h9tBVWH/AzNaysY07P9xtnVcnOKfYmMTE1RYKw6S21FZWZ7gNuWwIGt8Jp4PPuJtmZ6/spaZOI8ogyKis0WLe3EJA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889688; c=relaxed/simple;
	bh=C2mjhtB86IJbHun3aayUl9vUw2Z/QVKVFaMV3JF55pw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=uuzOJWyxq8vHAffCTl3xPtis+xg8JX+idIC9ug31F42v3GknFJB7ucHITHqYnYyzQm5sX5Tg3RjKm1ajdY2ImGIvcqAAPuzDChssrCDFkNphQXINu7wuibj0Wic+J2GqHuy8WHyPNDyTz0x8/VtFg1wY8RMOJBbgUkZaimkHnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7vdQrh9; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7vdQrh9"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-467964b7c4fso535211fac.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787889686; x=1788494486; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GN0rzPvERF9mQJvzko1JspnRvf4ouCENL3LR9rdsuTI=;
        b=P7vdQrh9JjT8JjGxwzpVGmziChziudZX3/0gN1ll+fCKs5ySR3VDqOVYZyYYEcz2xJ
         Iw7JA9Dag8AFX61yQS3lyOFyP+q/5GEw0XZ0lqKixVj/kHfrBZLz2O1+yao7BFnq5vnf
         81vU9dfnRCDPl38GzI9aJSOF0CBlOpVRWUTauUbSLBlnxQRcuGHu89njU1dPZKEcNUV4
         dXkbfRv/8XNEVnVguEznjoN8W4ZIXiD9EzwTAvfB5dFoVP/WmQX45TNBW+PwOcg+Zd+x
         hXjbcGoHZZg+3hAzBps3AnBCKGuVcINTwu65kcb+fHD2g8yFLqttksgxGLaCsb6Lspbg
         6SEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787889686; x=1788494486;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GN0rzPvERF9mQJvzko1JspnRvf4ouCENL3LR9rdsuTI=;
        b=masEneA5bDB4/iJFZ7O/x3/IymE5mZ3xn93o7fzi+nI6WrZvetOwUbLF4EOD2y2Zb4
         8YYdAcRxO7UxjJV69uwR7gESpfmOdpTteoi1qlGWQ2Q+ZGk4dgeX44VkFAIRihBXpYgF
         cR6h5dL5qo7h9Sczh1NEvHUlTyZBLdLqFNkyPHyFhFZl909qtwpjhwrRx+GfJgWmwGHx
         4Edi8XApytjAUqxNRhk7g4wrSzifS48taTNjv6YcKrBFgUJyNJPZDy2rYPnuiHriGAuu
         B3YWxTnZdYJLV7GGPUV2PgaWw+QFpSH4CsG+x/jASmXHMNU6sZ09ypS6V6ehp/qj1BCN
         INVQ==
X-Gm-Message-State: AFuF++m4XPTg9aJt/dsqs+VYdxrg8YqA8iKccMOPebpouetVuGrUJRvG
	0R9oGzvoo9GG1YZUQq3OQP88Xev+BGAzg+IBjgdlLsqJt/GamJHeywXe7zkj+w==
X-Gm-Gg: AR+sD11TdihYrQ3b/+tDk5HnpMyTBlaQrtWuz++Ynx7xNFKhdEfKmYA60Z2MaNLkWoG
	DStYuGKeOroE4k+JIaVfd/+Zz/ohzvzkI+/WmMqoMaaJfnOHpdUGqSt57gdbbHhO30eea1MdY+S
	DRQPkEC++na0pyw/TFUsVFBdl9wS0/1NQKaZO0i98HezJCtn0i0850qf9XX9VZTq0e/v9827mLU
	taJ7IynZxS3/88ONowC2BQkPqI+Uy0tgOzhTWp6jpvFZRECRtwASictIoWM9SuXGJyQhJtU70FF
	TLpQCxrd/vQYPgFf2SjwfU2uiKzNqEtgkymwTGGYgyEa+NPbBfd7rdpecI8KLueHj8Ew782qY6S
	PkRTpdkBUEzBuZgJdm4+reLzpMgcpSzjHE12BO/qzwSWvRu8qLQifiqHMD2IVUFGRcJgqn2tHmC
	hv6dHBYnJqRnaQyKtpjYJ2elg0xJ0ZASlAyb8se0kw/GZhkUDhMhXeFofj0Q==
X-Received: by 2002:a4a:e0c4:0:b0:6b1:c571:a591 with SMTP id 006d021491bc7-6b1c676d7cemr3040340eaf.32.1787889685651;
        Thu, 27 Aug 2026 21:01:25 -0700 (PDT)
Received: from localhost ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm3056683c88.14.2026.08.27.21.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 21:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 09:31:20 +0530
Message-Id: <DL09ZWAJ69WQ.35RUJEJ5039GR@gmail.com>
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
X-Mailer: aerc 0.22.0
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
 <xmqqo6en8jof.fsf@gitster.g> <xmqqh5kf8hqc.fsf@gitster.g>
 <DKZZYSTLY6TX.2TDQEBBOG5IAV@gmail.com> <xmqq7blb8g04.fsf@gitster.g>
In-Reply-To: <xmqq7blb8g04.fsf@gitster.g>

On Fri Aug 28, 2026 at 1:58 AM IST, Junio C Hamano wrote:
> "Hardik Kumar" <hardikxk@gmail.com> writes:
>
>>> In general, builtin/foo.c::cmd_foo() are concrete programs that work
>>> on specific repository (i.e., the_repository), and there is not much
>>> reason to rewrite the use of the_repository to use "repo" given by
>>> the caller which is git potty.  You'd also need to deal with the
>>> case where "repo" is NULL (hint: "cd / && git foo -h").
>>
>> Right, but would safety check be required for single instance or better
>> to find and work on only the specific ones which could lead to an
>> exception.
>
> I do not quite get what you mean.  In a single function you use
> the_repository and repo interchangeably, relying on repo, when it is
> not NULL), being the same as the_repository for correctness.  If
> they ever refer to different things, then your updated code is less
> consistent than the original, which would not be an improvement.
>
> I actually think a good medium size project is to fix the last
> parameter given to cmd_foo() built-in command implementations that
> is a pointer to "struct repository".  It was a misguided design.
>
> This pointer is either NULL or the_repository; it never takes any
> other value.  It is misleading and invites confusion that these
> functions can take arbitrary repository instance.  It also invites
> people to replace all references in cmd_foo() to "the_repository"
> with "repo", which may lead to an error.  Depending on where
> parse_options() call appears in the cmd_foo(), "cd / && git foo -h"
> will cause segfaults with such a change.
>
> If we change the function signature of cmd_foo() to receive a "bool"
> that says "true" if the command was run inside a repository and
> "false" otherwise, cmd_foo() can still tell if the command was run
> outside a repository, and programmers will not be misled to use
> anything other than "the_repository" as the repository to work on.
>
> The utility functions builtin/foo.c borrows from outside builtin/
> directory are being "libified" to reduce the hardcoded dependence on
> the_repository, and cmd_foo() can call these functions with
> the_repository as a parameter.  But we have no reason to waste our
> time updating (and also reviewing patches that make such updates)
> the built-in implementations themselves to take a pointer to an
> arbitrary repository.

Understood. Thanks for the clarification.
