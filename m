Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550126E6F0
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413886; cv=none; b=I9HKfAiQbXq3UmXnP6D6LIC1Zt0X3df5bptIPLNN/slE2VsmHBeEmO2Dun2X/PccGZF0OP5guyZcuoUrdoanL3d+ViqvrTRTO+4dOT25+NXnk7c8h3HOs+STm4Wbw6ewAAi8akbbNzh5oacd3pvkHUAmhXzEcbGYTOS4fSGfCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413886; c=relaxed/simple;
	bh=q1iyDNZhvNEAwjv+rsci11AI7TDw/lERRVxoLWWytzw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZaESXH3aLvXCnPCuIf6woBBnH0D2udzomhJUeZYAbdIUpvokxaUelh/8V5x0yhyJKOKKuIb+EMW+UlBoW24hZQ7bNTr9rEZReFzjjU6S98g/c3Lm+gVEy9dPJPVzxrwLANXFDqaoDF9JC5kCMDx1PE/n5SEBK5BGEYEpms19ZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuber.com.ar; spf=pass smtp.mailfrom=kuber.com.ar; dkim=pass (1024-bit key) header.d=kuber.com.ar header.i=@kuber.com.ar header.b=eQwDix0c; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuber.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuber.com.ar
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuber.com.ar header.i=@kuber.com.ar header.b="eQwDix0c"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-559748bcf99so3583917e0c.3
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kuber.com.ar; s=google; t=1766413883; x=1767018683; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhyC3hqCSXzKtz+X5sZxDlxIRGOZLMQJdgdbVA9/g2Q=;
        b=eQwDix0c2f4Qd4I2JWDDP9o1jQCuujKO1xC8ynfgZvcQ7CghC8mHtpv+j83zeX6uhT
         BPkl9quVGLOropJnnmCEnCThS2DmLNeVr1Ab/vGmZcs3UMMZlL9irBttyPxmouL+a9qt
         YdN5Ct5VHTMl/Px6z63Sj8gEozlvFfbAXNHKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766413883; x=1767018683;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhyC3hqCSXzKtz+X5sZxDlxIRGOZLMQJdgdbVA9/g2Q=;
        b=icYWSKYr8criBmx8beNDefn/lQQnVP9z2a9Oyp3rGXKX+intYmTGSRvgbmPGZRpui5
         zRiu7z1Ytn71EHnqFJZUaTfBfiMPw2MQY6qMtAehMwDpgI+R7Wkp3R0uovI93QdVbNrg
         TKXD1jclvMLXcARvnx8H6Y9xLnlzpPzzYGisqn2OMSVd+HXciYRduW/MCvECBoFiFoCE
         Z1LDLNLHtKS4Mcwbhjc4AdiKa1J2N56FJ/YrKywtU27ebNK1N1H+o2z4KjOl26LarqJt
         azw8RfseHwIqzVFotTmobyye33asAloTH+EHT3i8nsvvi3Jn3s4Vv+fzXtXX7fUaKPap
         D2+w==
X-Gm-Message-State: AOJu0YyNeVfabWGw9LwGZ+9N+KvQGlA8E2XojiYOn46JgTWfPkkbFmfq
	iegjY+bbiRUxlvHKIszaHkYY8QXC4oIutK0kWwKZQQc9J8IVZX66fzyFeY/lAZCvRwdv1lo59NL
	XelKQ2tszfjJkF4BlLYmxM5hp9HhKWnie+7FWWP5dZ6O1ui9UMJ6pilO2fA==
X-Gm-Gg: AY/fxX4FAHAG2PC6IP0SAj9X/B1j9GyzY2Oa7iF52zUPVg1Uz+qzVd3ken2ok0V5DT4
	rK0R2vLnlGNRbrWJ2PcUmEXA+gASs2MKizvwpvyVCZkszX0PQbGveqvoqs7T6r5ywtJ/598vyjv
	HiziEZeNnFm/sXz5xxXCtm6Hy99UbEb+OdVz0mz7tck7IrwM3sWCWEZhdn7THjJmTgzRr3g12as
	la6kTO0ynsWuTK8S61Yvtffc3xhPkVfK2oVtr5JhP1l+cX8DDhQs21mWKNTs0D+B0bttbjfSeZD
	Qvh/2/E=
X-Google-Smtp-Source: AGHT+IEnF6N+lCJfXSCVFUd1k5Ldci8Xz5L5/JrS3tuApzbmZMYj2VsKiKe7VTKnPcpLL8lUsqwLRfLxTFR8ANR+CFI=
X-Received: by 2002:a05:6122:238c:b0:559:623a:3aa9 with SMTP id
 71dfb90a1353d-5615bcde233mr3803881e0c.1.1766413882701; Mon, 22 Dec 2025
 06:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Esteban_K=C3=BCber?= <esteban@kuber.com.ar>
Date: Mon, 22 Dec 2025 06:31:10 -0800
X-Gm-Features: AQt7F2o606fe14TdqXBdAHsXm0OheJghQ91N-7WCdqxGOoosoUdCxwW7V3963C8
Message-ID: <CAHnEOG2o784dk+OpkGt-1qjRJb34=sFMJvh-JRJ3v+GNBxFywQ@mail.gmail.com>
Subject: Metadata for merge conflicts during rebase (to aid rustc) and
 potential for better user experience?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! I'm one of the rustc developers, with a particular focus on developer
experience. This often translates into working a lot on diagnostics to make
compiler errors less verbose when irrelevant, more verbose when context is
needed and generally make the compiler talk to humans as humans, and not
compiler engineers.

I am looking for advice in interacting with git internals correctly, and to
open a conversation on what git itself could do to improve the situation.

One of the things rustc does as part of its parser is identify conflict
markers to provide appropriate output. The current output for the most
verbose case looks like the following:

error: encountered diff marker
  --> $DIR/enum.rs:2:1
   |
LL | <<<<<<< HEAD
   | ^^^^^^^ between this marker and `=3D=3D=3D=3D=3D=3D=3D` is the code th=
at we're
merging into
LL |     Foo(u8),
LL | =3D=3D=3D=3D=3D=3D=3D
   | ------- between this marker and `>>>>>>>` is the incoming code
LL |     Bar(i8),
LL | >>>>>>> branch
   | ^^^^^^^ this marker concludes the conflict region
   |
   =3D note: conflict markers indicate that a merge was started but
could not be completed due to merge conflicts
           to resolve a conflict, keep only the code you want and then
delete the lines containing conflict markers
   =3D help: if you're having merge conflicts after pulling new code:
           the top section is the remote code and the bottom section
is the code you already had
           if you're in the middle of a rebase:
           the top section is the code being rebased onto and the
bottom section is the code coming from the current commit being
rebased
   =3D note: for an explanation on these markers from the `git` documentati=
on:
           visit
<https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging#_checking_out_co=
nflicts>

In an attempt to make the output simultaneously less verbose and more
understandable and useful, I set out to make a change that would identify
what the cause of the conflict markers was, if a git operation is indeed th=
e
culprit: https://github.com/rust-lang/rust/pull/150233

What this PR does is effectively:
 - `git rev-parse --git-path rebase-merge` to get the rebase metadata
   directory
 - use the `head-name` as the name for the branch being rebased
 - use `git branch --points-at onto` to try and find the branch name that w=
e
   rebased onto
 - if the above yields no branch names, then *assume* we are in a rebase
   caused by `git pull`, use `git branch -r --points-at onto` to get the
   remote branch name (likely `origin/main`)

With all of this, the output for the `git rebase` case is:

error: encountered diff marker
 --> src/main.rs:2:1
  |
2 | <<<<<<< HEAD
  | ^^^^^^^ between this marker and `=3D=3D=3D=3D=3D=3D=3D` is the code fro=
m branch
`master` we're rebasing onto
3 |     println!("Hello, main!");
4 | =3D=3D=3D=3D=3D=3D=3D
  | ------- between this marker and `>>>>>>>` is the code you had in
branch `branch-2` that you are rebasing
5 |     println!("Hello, branch!");
6 | >>>>>>> e644375 (branch)
  | ^^^^^^^ this marker concludes the conflict region
  |
  =3D note: conflict markers indicate that a merge was started but could
not be completed due to merge conflicts
          to resolve a conflict, keep only the code you want and then
delete the lines containing conflict markers
  =3D note: for an explanation on these markers from the `git` documentatio=
n:
          visit
<https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging#_checking_out_co=
nflicts>

and for the `git pull` case:

error: encountered diff marker
 --> src/main.rs:2:1
  |
2 | <<<<<<< HEAD
  | ^^^^^^^ between this marker and `=3D=3D=3D=3D=3D=3D=3D` is the code fro=
m the
remote branch `origin/main` we're rebasing onto
3 |     println!("Hello, 1!");
4 | =3D=3D=3D=3D=3D=3D=3D
  | ------- between this marker and `>>>>>>>` is the code you had in
branch `main` that you are rebasing
5 |     println!("Hello, 2!");
6 | >>>>>>> ebbeec7 (second)
  | ^^^^^^^ this marker concludes the conflict region
  |
  =3D note: conflict markers indicate that a merge was started but could
not be completed due to merge conflicts
          to resolve a conflict, keep only the code you want and then
delete the lines containing conflict markers
  =3D note: for an explanation on these markers from the `git` documentatio=
n:
          visit
<https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging#_checking_out_co=
nflicts>

There are of course other cases, like a colleague who got this diagnostic
after a `git stash pop` yesterday, or caused by `git merge`, which the
mentioned PR does not address.

The reason to handle this in the parser is to avoid knock down errors, but
the reason for going out of our way to check the git rebase state is becaus=
e
it is a *common* source of confusion for even experienced people, as
anecdotally evidenced by the number of threads in different forums asking
for clarification. On the rustc side, there's only so much we can do to
help. When working on the change, I noticed that the git internal state hel=
d
some useful and necessary information for git itself to display (like the
branch name for the branch being rebased), but lacked others that would be
incredibly useful for the UI (and me in this case, like the name of the
branch being rebased onto, which would also clarify the user-driven cause o=
f
the rebase). By having to rely instead on `git branch --points-at`, I have
to deal with both the case of multiple branches pointing at the same commit
*and* pay the potentially large cost of scanning all branch tips in
repositories with a large number of local and remote branches.

The questions I have are:
 - can I *avoid* `--points-at` in any way to identify what branch we're
   rebasing onto?
 - is there already a better way to identify if the rebase was triggered by
   `git rebase` or `git pull` (configured to rebase)?
 - if neither of the above has a "yes" answer, would git consider *adding*
   that information, both for third-parties as well as to extend its own UI=
?

As a somewhat separate concern, would people have a desire to try and
eliminate or minimize the confusion caused by this by modifying the
generated patch output to contain *some* of the information that the
proposed rustc diagnostic includes? I have concerns that having this in the
text output would be verbose, and could get annoying, particularly for thos=
e
for whom the git workflow is already second nature, but I am convinced that
there's a better default that can be found that strikes a balance between
verbosity and understandability.

Kind regards,
Esteban K=C3=BCber
