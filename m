Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35E13B780
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325005; cv=none; b=LlOP4Q+92f9VAUNEvnpcw4dWTuUMdkc/Y2P6MN2FH4XYMNsUr8WEdBFnqzVJrhwmNOqXcPw9nXAesfBcilwus/2+wRGgTID3iRax5Pt49dah91IHSBQt8H2EMbhK6g13haSg5I+9fLZeokd+xO3x/2xNoZ4Zb3NsaWex9qir0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325005; c=relaxed/simple;
	bh=NVpvYFFSzqHDEMV2VjhiYfgARWxQ8VjzKW60jqrR4MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dl7OnL95QfRAuxkEC1o4OlN8s3CmZy5zKw1q4kFabxc6INQG92JJDsLuAebXJ/mqfg46CbSycBZs9Yqvt4vDf5zF5AWyc/QU1eqnTCz63SUwl2zj9PZkT/Ty6PIOjpbFB1+fqDY0sl5fWdIM/LFPoPBhEEAoky9bYIA3cO0hfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so32226796d6.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325002; x=1722929802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVpvYFFSzqHDEMV2VjhiYfgARWxQ8VjzKW60jqrR4MQ=;
        b=fw8PUBH43LGr0qOyAV42J06Q7DzXc6vYEuhKiyADeGZ61/mN6+QrJQPauXr8cq0qNX
         WQUeASxYiNMaobz9V2v6ocCGxzLOhAl3mSqcCiXddF83ymnFO3OsyGtQAqB4D5PgSBzl
         Fl8bjSYADXnfG/y+vTfdROH4BxYZK6dWa5g+mrKpfnBlcjowFHbDXW+/S/XQmqx3NREP
         wbyOhaQjHZeLar3NAGLojDxY+PxEb22Wpygln2z7ihBo8HJhLsosXjkzPmh5E6un7PDD
         0D4w1YgCKE0c4lyEGWFz0rf/q9o0fF/rX0b/h0NqAqeMu7+sqG/84db0GPjzNZQjSgH3
         nGgg==
X-Gm-Message-State: AOJu0Yxk2CTdYUI8jq5to+EBFUYm8D6HD0i41bRLvMTdLHh1id45HwcP
	HNbWjxnC8qlA6TEPRj7c313xpTmuCKOt7obbny0CZCwX5tvs6X6hXObyS6/b5FbempsYcNS/GtS
	aday9+cd1XpLL5h7NcMwvjheQzqHF8/Wo
X-Google-Smtp-Source: AGHT+IFfsAlbfABqQlM4a1cOiw85ZjctRBsT+ppq/sXMBAhyZLDBIMA+W38Q6Z3a6DqfwDLOvbkibZJ2y0I+E7Y3cNk=
X-Received: by 2002:ad4:5bc1:0:b0:6b5:8d15:d139 with SMTP id
 6a1803df08f44-6bb7804e4c2mr20368106d6.28.1722325001913; Tue, 30 Jul 2024
 00:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGW38fkr+OuhpcyqNFxZNkhNDGPxTbOmCJLVHpCGUmbj05tMg@mail.gmail.com>
In-Reply-To: <CAFGW38fkr+OuhpcyqNFxZNkhNDGPxTbOmCJLVHpCGUmbj05tMg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 30 Jul 2024 03:36:30 -0400
Message-ID: <CAPig+cTGhzZom+27WEHFbij-_MdFL+tNQ0uQZ3wskB1v10fHVg@mail.gmail.com>
Subject: Re: Output of git checkout goes to stderr
To: Sayooj Surendran <sayooj.surendran@bigbinary.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:44=E2=80=AFAM Sayooj Surendran
<sayooj.surendran@bigbinary.com> wrote:
> Noticed that the output of git checkout command is going to stderr
> channel. Is this an intended behaviour?

Yes, it is intentional. Git's Documentation/CodingGuidelines has this to sa=
y:

--- >8 ---
Program Output

 We make a distinction between a Git command's primary output and
 output which is merely chatty feedback (for instance, status
 messages, running transcript, or progress display), as well as error
 messages. Roughly speaking, a Git command's primary output is that
 which one might want to capture to a file or send down a pipe; its
 chatty output should not interfere with these use-cases.

 As such, primary output should be sent to the standard output stream
 (stdout), and chatty output should be sent to the standard error
 stream (stderr). Examples of commands which produce primary output
 include `git log`, `git show`, and `git branch --list` which generate
 output on the stdout stream.

 Not all Git commands have primary output; this is often true of
 commands whose main function is to perform an action. Some action
 commands are silent, whereas others are chatty. An example of a
 chatty action commands is `git clone` with its "Cloning into
 '<path>'..." and "Checking connectivity..." status messages which it
 sends to the stderr stream.

 Error messages from Git commands should always be sent to the stderr
 stream.
--- >8 ---
