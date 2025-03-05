Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC8623
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133251; cv=none; b=PXywoVB1+tByf0Hio/M7MRdzEcWvX03SuG7eR5pvZEN1U6gN1kxVQPUKD1bjJsSoZCEqYNGkPEBVNhe0U9D+qsO0uByOW+FsYXVzrcTOBruXiMWRkbdDDDQfP7mOT4SXo8Sohtc7EZWl3GbpK+34K17y5OKgzixS4I5vnziQ93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133251; c=relaxed/simple;
	bh=g5CUuFYM6O9N97zwSujWTjZRGyI/5jiOmzQbQNvgCKA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dbKCyyqvG7bU3Bb5YzIX/Ylv38R3ZdT60j/8xMuFHTGcs72OeRbgwmiR4kptmWyUX7L6o49kEUjTfkiCXct3k0WVgJ11itJiI0FNPdUq1c8Xr0zWqz93vGGBOWqNxGILqQxhXNb5rIrhr4ZX0xDsKkmRNBZUtdFJjltxe5ObEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=miJ2xYFI; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=obrRH59y; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="miJ2xYFI";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="obrRH59y"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d3e28e6bb4so44503835ab.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 16:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133249; x=1741738049;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8yCFBtR8PU5oTSUwLuSnKgkAAnLbvN+ZHxQ0sOI4vc=;
        b=nrKG3BV6UcpC7LtZ/2plnC0kKJzELEDWh4LI98VyrgjzuGiOE3IY/mBxHu3PwDIDLq
         bD4ZUbiqlypts4dZjkG6/J3w8iFRk/29xHKvDR/pEAjtvMOWFp33DUlzYFUfNYSzJ6l0
         C1tn1jU721CmOnHEmQ+KB9o59ophEimZ9mEjadL6SwsBB7xHvCumXlk3LSyUfeG+Pi3/
         GwVrzIUKarv02T0suWslZVKVZKeef61rgUjXEQE7y6mE+wJ6Xk6FA/L5XgICg6mpoCv2
         DMZfsA+oPEs1OeURC9FAY3aDT+w4Lk84ANvDjJb6lEg2Lnii4IyX/ND38GFAX2VasA3+
         xuFg==
X-Gm-Message-State: AOJu0YzTLlfgyYqXLAKsM+nDfwarz1ovqrYlPkcP1np8Dc9z0xiKTHK7
	9KhjbYi+Xog4cmLgID9xpzhNWNe/Js79YdezEqENkQztwcI+oEI4y9nEna3oQTPv+TaVHuYMx1L
	a18GhhzYcZwg4CHyz9ImcCVL/hYkBSeIahHg4pQyQhiWuPVsO
X-Gm-Gg: ASbGncvGu0ke6V48SYxpq4JHggujmYpasKqFrhf/c2YAoY2XcBd7WqnztQxI+Ck9zDA
	IsNEsLdR8tLOFXJGx32F6u4rGR1NS4HUIWf7QwP5D6zPdoMIUZ/WUVmUC6pl9VcYxH3vv49I+ea
	tDhHnWFDfBQdNzvrVARjfzQ79/D9xI87ol4Wc7AJDiQBstcdY1cbJagt68pjenqU+lTsoCZ4CNM
	zSHNtdvUA9+5lVsG03z3ZgsMKTzqdnDXjFHTBTOR0IfoddtPUhRe0cK80HVgMJ1I62YHM6ZfSWU
	4uxH6YCkxZHiqAa25zx3VLMbBpzw/n6vA5bgNL9u
X-Google-Smtp-Source: AGHT+IGji9F+wjFaJf+yIhS+IZLJn4wSSNh1AjHhT7GCSXZ9iplivAhMZo+M1g/ED/zYPQUo2+i7XSuCApIV
X-Received: by 2002:a05:6e02:b28:b0:3d3:eeec:8a07 with SMTP id e9e14a558f8ab-3d42b88ba48mr13465555ab.6.1741133248930;
        Tue, 04 Mar 2025 16:07:28 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f1e8782516sm119329173.72.2025.03.04.16.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:07:28 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741133248; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=g5CUuFYM6O9N97zwSujWTjZRGyI/5jiOmzQbQNvgCKA=;
 b=miJ2xYFIAv3seALzjSy4SZMRcGIG0CxArHuobqw2PDxU+uz9FtOkVhux6trpjcXPL4NTS
 UYXmVo+D0XNFSLyBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741133248; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=g5CUuFYM6O9N97zwSujWTjZRGyI/5jiOmzQbQNvgCKA=;
 b=obrRH59yUPgWvniVgs83MSis1Aba9Dac60tcth/s9QsVMhkgs4WFfHrRu87Nnal1bWNcS
 BN68FgIrJTtH9vjBhrjksE18nPBKptY/oWifapb85NMKqCQAfYw7DJVmkIe+/KqC0H7O/Hy
 TgcDJQrF4i9OxWNWbtiQaxUoyCUTts8uYuSfN7fRl+YLuZ49LVsWgkNCC+qvppPqrIyn0o9
 wIcljygQ0dkq8VrwT4eCy2bZ/Evazdm/5bRPfkdUaXWcJla7EWpA9ZDA7Om7GgQwWWh+HrU
 zqk9sRfWFv21LCCPi14sEKQoJnXpbHVTJE9PAe+yKrsagjtfr2YIwOtbJJ0w==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z6tCg74sCzySw;
	Wed,  5 Mar 2025 00:07:27 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Mar 2025 19:07:27 -0500
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] completion: fix bugs with slashes in remote names
In-Reply-To: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
Message-ID: <d5860dbe1e6a149d72739af3271369b3@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks everyone for all the reviews! I rewrote __git_dwim_remote_heads
to fork a constant number of times instead of a multiple of the number
of remotes. There are still a handful of forks, but I think they can
mostly be parallelized.

I tried to find a pure shell implementation like a few of you mentioned,
but I couldn't think of one that would work in both bash 3.2 (the
version on macOS, I think?) and zsh. The only thing I found in
https://www.bashcookbook.com/bashinfo/source/bash-3.2/doc/bash.html that
looked like it would work to implement GIT_COMPLETION_IGNORE_CASE was
the nocasematch arg to shopt, but
https://zsh.sourceforge.io/Doc/Release/zsh_14.html#index_split-13_fn_letter-S
doesn't list shopt at all.

One unintentional difference with this approach is that $cur_ is no
longer treated as a glob pattern. Was it supposed to be in the first
place though, or was that just because of missing escaping? I.e., this
no longer works to complete unique-remote-branch:

git checkout unique-remote-br*<Tab>

In my original commit message, I mentioned that HEAD was no longer
listed, but I think I was wrong about that. I think HEAD went away in a
bunch of the tests because I added another remote, so HEAD was no longer
unique. Maybe HEAD should be filtered out too, but that seems like a
separate issue for a separate patch.

David Mandelberg (2):
  completion: add helper to count path components
  completion: fix bugs with slashes in remote names

 contrib/completion/git-completion.bash |  49 +++++-
 t/t9902-completion.sh                  | 206 ++++++++++++++++++++++---
 2 files changed, 226 insertions(+), 29 deletions(-)

-- 
2.47.2

