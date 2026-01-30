Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DA285056
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769733201; cv=pass; b=djp+P6gIrBvk9W62hAHYJyKHT9agSjsIXmvjStz54pntiyNFRDBGVhA3IdxRJ5+Z4TJEaNoTTR55KUuHjk6sGQm2zbGns4i737zyErJNK5yJ0JzvgtcWpIVcByf28R64UMXdqV9TQsmJNbvjzysSEJrkTKvwJ0FPVjuRqBLyDXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769733201; c=relaxed/simple;
	bh=qbMBMh2Ex/CxAEjrulvsPAQsTS/aBOHf88XXKv1an54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABlpLx29G3ym/II0ARSXiYTxykQj0q2hRo1rMROQx9m6+keawESU9qJNjCVNbJDf/7OfR9lsoPTPLI406i9pTkKsUDNIS2xWLhrKDfKHh13dOVNFf63kAihR8fbUHhW7zUbEFC+kbK5uNjVIqyoQHE/U0JoX9DLPOkHOoikFeY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b72b154883so2117eec.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 16:33:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769733199; cv=none;
        d=google.com; s=arc-20240605;
        b=IeaktCWOUSdzPlwhi+atEjb+GiRM8GT6lFqmmfoyfuBnWjXIfMKQNzC8xRZh5Zb0UA
         RYW0+WYrMZUaPWW7mCPfByMSvxXnnOkMUKiACptfV9OYot6dfnMRPVCL/KXzY3AXVFS0
         bAjjF7wZdQYhT6oJB0MqUvrqyP8cZaVO0oBByb0lvdzEMpCaysqZukA0kdOPEEfJNV1L
         NzpiAKiJJWt7mlkHF0eDfTF9mjpvefm+mErQ5lyac1MbfUW0zSgIRKACvoWPlMoMd8as
         Nqy53B39imU2nlpUft01qWKiBzMSsm01s3idv4xf4N+ZlZKLm1XHF0fxEX3MngAfdyq0
         FX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=UiwhmrFScFdv4+j52Xv3kCkbBQRefxlxsOzmb7OENZY=;
        fh=1iTW1ghlYThVEbpG54wHZWLTe8AgyCLV0rlmlrz4f/s=;
        b=l28XtsQMTfJ8Kc+uljLpwROnqwZaZasyo72hh6MzzfZoZHzfqt+/PeC+uERPEiSLbR
         M3UNUMOLD8CagluI2ojkSjBoo/pFRKf9NiH2hcDzZeSIDW2KLxdQYG0bSvi3O06TkajU
         908BMbIq8Jz4O7/BiS5ZmxFKVzoREkHEkGidAHbLZHxG0zDYo9lRLAQ3g3mNWXy/mfRQ
         9v6uwsLTjMbQIXRqRSNTmg2YH0CcjDr0j9ezMbIx1lpZdyEHT3owDYSN1Fh4AEDz7P88
         nxlDkurq7iIB7Rc6u2Wd/fnOvoQYg8H8gxNspy1li9wS1B81ysH4GGdginFvM17IzI5I
         +T4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769733199; x=1770337999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UiwhmrFScFdv4+j52Xv3kCkbBQRefxlxsOzmb7OENZY=;
        b=kEnqeTQXhRKj+uYNPCfbEQ1djYbUhHyUPk749FLbteh+VYoQVzwy5JNpC70DHD5ghY
         1y7uJJYZZ1Lmks/pE74kesJ/bD7N10tG8xvOwea6vmV4v7wSc/o2WCL45/NBMun7kA5F
         hvtKKzEJJUECAoArvaQb1VmPBE14ZQHJWio1edMdC9Pklqk5qie2I1/IZCegKvqJzT+I
         IEuZKePQuEWJKioxmaZZE67qjxJOzWxY8SAkO7++POoJK8MM7MgemUSnfiuj0Cm60K/m
         2CAKo9XvU4UZ8DL96T2eUwNoo3Tb7viO5kCpbSTY1Kg8bp4wyEDR0mw7rL3PoWLYkt3l
         TBXg==
X-Gm-Message-State: AOJu0YzAQDcm4/pWA34rjNbwNGC0oKfVmrb9TLLdAmoTvtzPfkBBjZQq
	6fEKcXwP7Nc9X+B4iOHzlAEt9mvXrgC4xk/hSrIUwMoZ1qskh5KSMSNlZdFVkdQLC0UYBDtf+YU
	7yzALSAgodsHlsQ8sGzCcOQQ2PUUTNTI=
X-Gm-Gg: AZuq6aIPi4LdKjXsMfM1uVXXYTLjojF4mkej+3YZLsFQ8bWknrv0zMzBc0rsgJ2RAou
	u3lj+9q86XvoJMOpuWtYjTKUZqn7GzeXet/kgfMkcueb+VtZ8biS6HfXQx9PYAhD8AT2h2vqZZW
	dKNBbfeImkRiXmS8EHRjcXuQk7ML8OsnTiSLPkL/nPP/E7dh0heRbBcYkRK7IF53/fdOjAyiGlr
	gUbKlpzujzWmFqptkrY4RRd2D0d9BYhcX3/vgyH6pY1IJ/OXVssyemgANIRf/l3q2ZFK+xuvVJs
	fak0PMFc
X-Received: by 2002:a05:7301:2288:b0:2b0:4a1a:657 with SMTP id
 5a478bee46e88-2b7c8948086mr334264eec.8.1769733199021; Thu, 29 Jan 2026
 16:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwm107za7.fsf@gitster.g>
In-Reply-To: <xmqqwm107za7.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Jan 2026 19:33:07 -0500
X-Gm-Features: AZwV_Qg3gKEFZ4MVnO0mqwIHyCzfXxs-msQiz3ri6KzTT4yfg8zNCrzVJl7cyhA
Message-ID: <CAPig+cSH3exmnXXarrGb+UU4izOt8bJJNkEwmU+wJFGXVC8XJg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #10)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sam Bostock <sam.bostock@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 6:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * sb/doc-worktree-prune-expire-improvement (2026-01-27) 1 commit
>  - worktree: clarify that --expire only affects missing worktrees
>
>  The help text and the documentation for the "--expire" option of
>  "git worktree [list|prune]" have been improved.
>
>  Will merge to 'next'?
>  source: <pull.2135.v3.git.git.1769578785381.gitgitgadget@gmail.com>

Yes, I believe that the recently-posted v3 addresses all the points
covered by the two reviewers (Eric & Junio) who commented on the
submission.
