Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F226158C
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719316; cv=none; b=lnzwMO3+l+2szNIa/73oFcE3/IgEyaRc+M6oyD68vv9qzfLEA6w3dENRq/alXyQ8+F2Av9AylRafLy7HDPa0SgasDTiMd/U6ifd//cWNM4yFmUhyPCQaAJKKOdxgmyrlef2Fa8CoZnAeKoElnx/2jgsLA1MR0yTJCg41DBFGBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719316; c=relaxed/simple;
	bh=rjubhvM9KVxlr/JGHmFC+qCigi8Gu69HFDtZ9Ya8+38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of0jP5oGOQzq4b7bvnvzRdnukZG7sEUQYWOr30ZQlCLutjO49qsJekJKEToJRIwdarAvEq8MVXLP+7Po+5R3z5D9iB1RnFSAhtXFiAYvpJsEn0ZreYywEQscdaPG3lw6lGE+WJtKvw0eqdO6/p7nUJ0nCb0KLANu+Y/ugCgK910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R61xb3hh; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R61xb3hh"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce868498d3so20430805ab.3
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741719314; x=1742324114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YBXYJJ0O3Jhz4OCocplGl/dFjvXB5s/HHbYomLfMIk=;
        b=R61xb3hh4SwjsY5CQnLrmm9td+Yeu6xWYhN/5k3zx5ickMpGhddGUxKd8HNRjIh2rc
         FNlSBNX4VgC4I9L0/DuqefQxx1w0Zg3bx/jLjJlYc91M1FEhdPNclh/M4ty/JJbrO3yR
         PCPtUgSkJLSFI4ibAg2CRhPmjoUPxIgP3XED8BJUzHfRt0LN8CZfLRdK2SAX5LgRc+no
         CMd5L8x0qz3K+q3ZbYmcdyA4PgFhyY/l6iJgcWvS4+ppdyz4eVreTpnWAeuRixP2KK89
         /ZpuTdUv7ac/ldgv/pottZi/IAT6rBvpftDy0FxVNXz1XNp8PguQfOl5EoaCJrMZfVCQ
         v+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719314; x=1742324114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YBXYJJ0O3Jhz4OCocplGl/dFjvXB5s/HHbYomLfMIk=;
        b=UjUKGOAQIMtgCVK/MRlKMosnxfY8gJk4hkPO3d+gbhieZfrutc6n5NZvEOjSlHW9qZ
         gmklCtub4zS81YBPdsH2MGSClrhwSRqvkFNVfB7wmel1MiQUUowZ06AyCWcr+kCLqc8Y
         0Yy66nw1u7Tcti7DAuM31dc1KbKHd2hDvHIESABVuOedTSRo5EKuwgDchE8FG/bA6MMK
         n0rSxkYGynuaTYjEjSnQMpwEe+nY3lt1zehK5AcYjFzlgh2PB2NfKKpqAPet/hnlnqz4
         P2wJv0EH71SO9KjXRZXsXMDrjKp9p2EMBfzqR1V8he2CYFi6PDvW4IvoBokznGj/zCod
         zfsw==
X-Gm-Message-State: AOJu0Yw6lwS7thiHR1vtvx35FZqyiOnTsKKeKutIZ7dTZiwsnkeUslto
	ArgkkfZ0Xqo+kNDkHSeFT6vTStsKdy3+SS95Z+VgrtDXRCSU+T/uDeykUQOjV9kcJSFCFO+VHWj
	vjWwtCA/6tMRYjBcVqcwGyhx+18syKA==
X-Gm-Gg: ASbGncvxiGd0nElq0ynaM6BKSafElwlf7XMcoqbW15tKdzXCr+Kql2eVvusoCrJ9zNQ
	PLQXzNuvUMSW6UrmRl8QPjylbOQW04XxfmtxKUmEBOyxLg7NFLHx86Q6ttBmotowwe4GJcX7sen
	HrRcwMWle3RsWBivW+gvePZ4R6Gh25abTJWB+Js5wmaGvggHz09TQ+Z1J4CO8=
X-Google-Smtp-Source: AGHT+IF8Ke4XVO/arBiW68wplFreTRK2Uw3oowSZS8kVXVWRZQnX4O+m+UR65TWlZUzCPrImVedkgZEOI3/DfVJLamw=
X-Received: by 2002:a05:6e02:1f0f:b0:3d3:fdb8:1799 with SMTP id
 e9e14a558f8ab-3d4419b2bdemr240588915ab.22.1741719314338; Tue, 11 Mar 2025
 11:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jz8v8mlj.fsf@gmail.com>
In-Reply-To: <87jz8v8mlj.fsf@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 11 Mar 2025 11:55:02 -0700
X-Gm-Features: AQ5f1Jqql7M_4tS1CzdzTy8JaB7Dbt1GuQHvvmyKFZX2j7EhmImHBfJdblDFgz4
Message-ID: <CABPp-BH0xziowZx4S2aKJL5wjPHbJQ8wNstPUSLaw0FNdDu-fg@mail.gmail.com>
Subject: Re: git rebase skips reapplied commits
To: 45mg <45mg.writes@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:11=E2=80=AFAM 45mg <45mg.writes@gmail.com> wrote=
:
>
> If the same commit is made and then reverted on both <upstream> and
> <branch>, and then reapplied only on <branch>, then
> `git rebase <upstream> <branch>` will skip the reapplied commit.

Yes, as expected and as documented.  Another commit exists upstream
which introduces the same change, so it is omitted.

> The following script demonstrates the issue:
>
> ```
> #!/bin/sh -eu
>
> # Set up a repo for the following commands.
> repo_directory=3D"./rebase-test-repo"
> rm -rf "${repo_directory}"
> mkdir -p "${repo_directory}"
> cd "${repo_directory}"
> git init -b main
> git config user.name test
> git config user.email test@no.mail
>
> # Create a branch 'br' starting from a commit other than the tip of the
> # 'main' branch. Switch to it.
> git commit --allow-empty -m 'initial commit'
> git commit --allow-empty -m 'another empty commit'
> git switch --create br HEAD^
>
> # Create a non-empty commit on 'br', then revert it.
> touch a
> git add a
> git commit -m 'Add a'
> git revert --no-edit HEAD
>
> # Make identical commits on 'main'.
> git switch main
> touch a
> git add a
> git commit -m "Add a (on 'main')"
> git revert --no-edit HEAD

Note that this does not match your original description, and your
comment here, "Make identical commits on 'main'" is not (always)
correct.  If there's even a little lag between when the last two
commands run and the ones before them, then the commits on 'br' and
the commits on 'main' are not the same.

> # Reapply the reverted commit to 'br'.
> git switch br
> git revert --no-edit HEAD
>
> # Rebase 'br' onto 'main'.
> git rebase main br

I would have expected
   git rebase --onto main br~1 br
due to the non-identical commits issue I mentioned above, though
without --reapply-cherry-picks it doesn't really matter.  With
--reapply-cherry-picks, though, it matters because I would have
expected you wanted 5 commits rather than 7 (empty initial commit,
another empty commit, Add a on main, revert add a on main, Add a,
revert that, Reapply add a).

> git -P log --graph --all --oneline
> # Sample output:
> #
> # * 5b4d655 (HEAD -> br, main) Revert "Add a (on 'main')"
> # * 7881a38 Add a (on 'main')
> # * 907f1a8 another empty commit
> # * 6c094a9 initial commit
> #
> # What we expect to see:
> # The commit 'Reapply "Add a"' should have been rebased onto 'main'.
> #
> # What we see:
> # This commit was skipped during the rebase and has been lost.
> ```

Yes, it's behaving as documented.

> Using the '--reapply-cherry-picks' option prevents this from happening,
> but it also creates empty commits, so it's not a proper workaround.

It'll only create an empty commit if (a) the commit being
cherry-picked is empty, or (b) the application of the changes from the
commit result in no-change.
In this example you provided, no empty commit would be created
(whether or not you used your original rebase command or the
modification I expected).

So, it looks like precisely the appropriate workaround if you really
want to reapply these commits.  Why do you think it's not the right
workaround?
