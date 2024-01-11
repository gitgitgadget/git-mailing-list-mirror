Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A818F
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5qcSpUB"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd7e348311so13471551fa.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704931954; x=1705536754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjQt3JGgSoFLOfOb4AN/1Etox6jyfYBRtxFq+Od16v4=;
        b=d5qcSpUBD5uSu6i+gSUKoyR6cfFC+Z398M/GX0hLLfK8MCE7SXjDsxW3C0LTzCjqHp
         TIuSAZGn2XreLDhBRa4UvCMxv3Nd3Luag2JYPXcbtytsVK5N4jJheoWfx0vMmjqV0602
         Ek4o/rq6HUptdu5gOKt7rEBGIyDByEzBK5D7xnwj+9M6nHFtTS7kZDQPrtG4lkMeC7Vh
         RId/t0KwetyEYwq7DJwA8MNryobbOJy/KReBGXdZ1JgnQ9D8QBy9O66HOKMjoxFLLbUP
         TT4JB1jvvxsh0LsI7HTKWpUBPS+iUmKMv955cEMKKgYhZZ5+uTtfQEpPDn0jfcT0yXLr
         uA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704931954; x=1705536754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjQt3JGgSoFLOfOb4AN/1Etox6jyfYBRtxFq+Od16v4=;
        b=iaf8mE7v4Li5rEWL3T+aVy6NXIXcFhuRRIE+ATyzfgbdxQWgkzisrYKNN2vbfo0pKx
         lI8/jMNjiSj5xCbnUhV8oR0lrOQQfxBaPFkz+L0l7UghJ5RwBpD278mhYQsIQitrnt2a
         jhPra9tDXwqhG8Yqw3ccIwkAFGx0/txXIw1m/pHn0YC63h3tkfTpnitpHxVNIa9B19mw
         wt8ACI7shRUdrUoNQzoPe5ri4+TEdAqPhuuBlNB3a0ptmMVviuYbXD3VcQXqk6kLN4a2
         7znotK1SD3CINq+ryGRZO57JI2lFIpZI462q8f9xMim2KuFyvKGLQu+qc2ZZW/KQN3lS
         eO2A==
X-Gm-Message-State: AOJu0Yy/TM6RA4Ox23zR0sRiCcRh4J/EgQiNxrr0B6XAVlsKeaF5G4sw
	bAq3hY3piN4XEYRNLRZ0cYalRW0bQ1Diuv8KJyfamfvo
X-Google-Smtp-Source: AGHT+IHVZyEDzQFEyxQlj2XfbEx9s9YClEHoNFXHco9vHxRnLuwcopnH9CwSlO3tbiPG+v8BjUW/J5ug4ETr13oHwHA=
X-Received: by 2002:a05:6512:400d:b0:50e:cc3e:2f31 with SMTP id
 br13-20020a056512400d00b0050ecc3e2f31mr99117lfb.82.1704931953479; Wed, 10 Jan
 2024 16:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local>
In-Reply-To: <ZZ77NQkSuiRxRDwt@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Jan 2024 16:12:21 -0800
Message-ID: <CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=D8wsCCVwqQ@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> Over the holiday break at the end of last year I spent some time
> thinking on what it would take to introduce Rust into the Git project.

I'm very happy to see this email.

> There is significant work underway to introduce Rust into the Linux
> kernel (see [1], [2]). Among their stated goals, I think there are a few
> which could be potentially relevant to the Git project:
>
>   - Lower risk of memory safety bugs, data races, memory leaks, etc.
>     thanks to the language's safety guarantees.
>
>   - Easier to gain confidence when refactoring or introducing new code
>     in Rust (assuming little to no use of the language's `unsafe`
>     feature).
>
>   - Contributing to Git becomes easier and accessible to a broader group
>     of programmers by relying on a more modern language.
>
> Given the allure of these benefits, I think it's at least worth
> considering and discussing how Rust might make its way into Junio's
> tree.

I think there are other benefits as well; I'll list them at the end of
the email to avoid side-tracking too much[6].

> I imagine that the transition state would involve some parts of the
> project being built in C and calling into Rust code via FFI (and perhaps
> vice-versa, with Rust code calling back into the existing C codebase).
> Luckily for us, Rust's FFI provides a zero-cost abstraction [3], meaning
> there is no performance impact when calling code from one language in
> the other.

I agree with the zero-cost abstraction, but there is a funny caveat
with measuring it if anyone is curious[7].

> Some open questions from me, at least to get the discussion going are:
>
>   1. Platform support. The Rust compiler (rustc) does not enjoy the same
>      widespread availability that C compilers do. For instance, I
>      suspect that NonStop, AIX, Solaris, among others may not be
>      supported.
>
>      One possible alternative is to have those platforms use a Rust
>      front-end for a compiler that they do support. The gccrs [4]
>      project would allow us to compile Rust anywhere where GCC is
>      available. The rustc_codegen_gcc [5] project uses GCC's libgccjit
>      API to target GCC from rustc itself.

Another alternative (as discussed at Git Merge when we were last
talking about Rust[8]), is requiring all Rust code to be optional for
now.  If we choose to go that route, I think that means that (a) for
existing components, we have both a Rust and a C implementation
available, and (b) for new components (e.g. new top-level commands
like git-replay), they can be Rust-only and those compiling without
Rust just don't get them.

>   2. Migration. What parts of Git are easiest to convert to Rust? My
>      hunch is that the answer is any stand-alone libraries, like
>      strbuf.h. I'm not sure how we should identify these, though, and in
>      what order we would want to move them over.

If we're happy to allow Rust, I'd like to rewrite git-replay in Rust
as a testcase.  It's almost certainly not "easiest", but I think it's
an interesting testcase because it's a new top-level command that
hasn't appeared in any release yet.  Further, it is currently only
designed for server-side usecases, so would likely not be affected by
more limited platform support.  (I haven't started on this; my
previous experiments were with diffcore-delta.)

> I'm curious to hear what others think about this. I think that this
> would be an exciting and worthwhile direction for the project. Let's
> see!

:-)

>
> Thanks,
> Taylor
>
> [1]: https://rust-for-linux.com/
> [2]: https://lore.kernel.org/rust-for-linux/20210414184604.23473-1-ojeda@=
kernel.org/
> [3]: https://blog.rust-lang.org/2015/04/24/Rust-Once-Run-Everywhere.html#=
c-talking-to-rust
> [4]: https://github.com/Rust-GCC/gccrs
> [5]: https://github.com/rust-lang/rustc_codegen_gcc

[6] Here are some additional benefits I see:

 - Parallel performance.  We avoid making things parallel in Git because
   debugging/maintaining/reviewing parallel code in C often isn't worth
   the squeeze.  Rust was designed to greatly reduce this effort (the
   whole "fearless concurrency" thing).

 - Single-threaded Performance.  Multiple factors:

   - We had (and might still have) O(N^2) stuff in a lot of places in
     our codebase, because we tend to over-use arrays.  (e.g. with
     string_list, or with insertions and deletions into the index
     during a merge, etc.)

   - Relatedly, using hashes in C is quite onerous, to the point that
     we often simply avoid it.  I know I have, and I also know that
     even after I introduced strmap and tried to use it outside of
     merge-ort, that I got pushback because "string hash-maps are not
     really typical for a C program. I'm sure they are the best choice
     for an advanced merge algorithm but they are not really necessary
     [here; let's use sorted arrays instead]..."  I then had to go
     through multiple rounds of responses and ended up reimplementing
     everything as suggested (before finally convincing others to just
     use the strmap implementation after all).

   - We use QSORT() which basically calls libc's qsort().  Due to the
     design of this function (where the comparator is a separate
     function call), it is slow.  When languages avoid making the
     comparator a separate function call, they can speed sorts up by a
     factor of 2 (or even by 3 when an unstable sort is good enough
     and the platform's qsort() is stable).

   - Difficulty of incorporating other libraries.  For example, our
     hashmap.[ch] make use of FNV, but picking something else is a big
     amount of effort.  Now, while FNV is faster than Rust's default
     of SipHash, cargo makes it easy to pull in alternatives like
     FnvHashMap or FxHashMap, which we can then use where it matters.

I'm also tempted to include bullet points for having a unit testing
framework built in, and potentially fewer platform-dependent issues
(e.g. forgetting to use STABLE_QSORT when required since qsort is
stable in some libc implementations, since rust defines those more
carefully to be consistent across platforms), but I'm not sure these
additional advantages are big enough to merit a full bullet point.

[7] If you ignore Rust for a moment, and simply divide your files into
different libraries (e.g. introducing a new.c file, moving some
functions to it, and then compiling new.c into a new library,
libnew.a, and linking both libgit.a and libnew.a into git), you can
sometimes measure some small performance differences.  At least, I
did.  What this scenario has to do with Rust is that if we start
moving some code to Rust, that will naturally likely result in a
different division of files into libraries.  Thus, for me to verify
that Rust did provide zero-cost abstractions with my experiments, in
order to compare the performance of my Rust changes, I had to compare
to a version of git where I split some functions out into a separate
library.  When I did that, the performance overhead was actually 0.
Otherwise, there was a tiny performance degradation in the particular
splitting I employed.  However, while splitting did give me a small
performance drop, it was completely outweighed by the performance
advantages I got elsewhere in the things I converted to Rust.

[8] https://lore.kernel.org/git/ZRrfN2lbg14IOLiK@nand.local/
