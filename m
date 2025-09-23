Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AD286D4D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650231; cv=none; b=mTsImWrIo2d4g4cT6/DE2O0mu6ipR3+6hjeNaWEYc/ixQuMD/dEVryhx07GYdPyV5FO77sFlIqpL3mZkOTlQ6C7E/H928MHj2jaRqSiyxcM3Ub1BoK/nw2C572kWbhm5t1YC/Ha/m/pLrRKg1R2MHfUrPrZFyCC1dapg5CbyQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650231; c=relaxed/simple;
	bh=FadMCwjqfJD042OJUxKlBbh+jUSKfF1UYovuK4AXguU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYwt3TkpSPOl272nC7l+rFGXmhjKKuX376Nat0SMwNXkXQTFAQkMJRjyIqPg+62ZvJg27+e8qev6a/t4ehKbH2x0dLa6bvofdLDxix4F3zj6Z7jwPoFqXgxVUCYUDA15wc90VmhU6+xot4sLP+cqGjsNXpIncz9TXX2mwKuND60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ0gr+6/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ0gr+6/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fc2d92d34so8528333a12.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650228; x=1759255028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olRRqCb0qZPKoIlHMxEcbQNLe4SJMZIsaIgK/20DcNw=;
        b=dJ0gr+6/vNHgcIxBY+QHHz0+HVBgsNh8zrdoQ/RPLlhw+g1afjMp3HdODM00GExWA7
         y8DgDc1Sb4zbLQWCEBcJndIAEw1XsrAee6RCtEwOIkAyT1rzWB7irRZGIy86lk1s46OA
         WevQ4jUS7v9wsvMVz/JmCia6fYReInU9XD0Ae9ZbMmY/3w0PuXiGFlOG3LPNhQOibg8K
         /ApXP2yc8AEG70aUUjMQoyMijg7OqZoBExy3nV2pvBvQyQhZlN2Q97PEvdjdLrZFuxzk
         FVC301PM3571/SACeeblNmiCua29nLJHwjP5MgKnKPqBCbwX3/tjHHMLlJcmnW+tihCx
         a9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650228; x=1759255028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olRRqCb0qZPKoIlHMxEcbQNLe4SJMZIsaIgK/20DcNw=;
        b=J9x9LSlbsvEBfjcZlUX4bDQk9tFgHDqBhjDkG2M9c3EX/yXcyrWP25r+Ipp+h8MrhL
         g0czfkh6YI/p//J9USFsKoL5aiHBpCnM6UUsuGLtiaN/gPngiheVwyIWqVhe2p9gSK1y
         wmTasCDTOG9L7kCbJ274kvs1IfJhcf7lDH+aHJovNYHeWYWMkz2v+XARrKnMZ+606rfV
         IyPb7N5EyuSmB95lRaBXzSUajLDVBCUO5kjJ91kp8twNsDNGnEH4XUhAmkDLxi27MHBH
         WPekHQSCFZgVGtgeaxmZnxQVsjLAdwMCrjRvJofAK4Ia8N06ny3DcIhxX0MmMibMuvm3
         ohZw==
X-Gm-Message-State: AOJu0YzDZb9FLAP27aoahUOEUQV9dxYdkrH3r8WAeD807PYlF10lqTyG
	vuNirtnMfHtTlXO/C1IiMiE0z2P4Oltiwex6CQ1sw87L+B2E9UO/xBR4w2UF12ZQmIWCWZZruBh
	02ejb/SJsHLcOWc76wSQHQinUu12B4NLQRKTW
X-Gm-Gg: ASbGncvBqfpv9tyKJblSCYgXEaNL9+0TnunoN8ufn/vJz12rfZY4c+ecZafIhBRUNPw
	hwAIzqK+G0nZUNsOr7EbzieDSDvle1VqvroyWn8jzm5v9vhdHYy4AJ6h2OB+l9WbSZEUHheeGMF
	pRiGfGU2xzfJfnPJwkKdiOPxM+gKA0Bndi9i/kSsKumiOeflws2e1WtkVGad6C9d6/yeWvNrIMW
	qwTcQKFrW0VfycZ+IDVZ6MZrjH1CFUwO19hU3g/Ww==
X-Google-Smtp-Source: AGHT+IH19qU2oX83qIn5FuQ73hhD4ALRDlGf95mNlAMD2KgULMs1Yq9E86dfuePd/Is59ZURIP23Fy6OLwtdShcAsTs=
X-Received: by 2002:a05:6402:46d5:b0:633:d0b7:d6c3 with SMTP id
 4fb4d7f45d1cf-63467796dacmr2846934a12.5.1758650227599; Tue, 23 Sep 2025
 10:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com> <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 23 Sep 2025 13:56:56 -0400
X-Gm-Features: AS18NWAut7wIiScr3uEjeuGYgMCzu0oKVgQnOY-iVkUVoAmlxk1Q63e6tMZAQoY
Message-ID: <CALnO6CBLyVsMKuQhN3Rf+t0C1boHuumocahKE1vZ9U+7UbURRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] doc: git-push: clarify DESCRIPTION section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:44=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> I surveyed 16 Git users about the git push man page. Here's a rewrite of =
the
> DESCRIPTION section and the definition of <refspec> based on the feedback=
.
> The goal is to clarify it while communicating the same information. The m=
ost
> common piece of feedback was that folks didn't understand what the term
> "ref" means. Most of the users who said they did not understand the term
> "ref" have been using Git for 10+ years.
>
> changes in v2:
>
>  * The biggest change is to add a new UPSTREAM BRANCHES section to explai=
n
>    what an upstream is
>  * Drop the "refspec" changes from this patch series, I've made revisions=
 to
>    them based on the comments here but I felt like this was getting too b=
ig.
>  * Added some backticks `` that I'd missed, from Ben's review
>  * From Junio's review, "The current branch must have a configured upstre=
am
>    with the same name, so this will fail when pushing a new branch" was n=
ot
>    true, so replace it with a less detailed but hopefully true statement.
>    After a very long conversation with Ben I realized that actually
>    push.default=3Dsimple's behaviour is not really that simple (perhaps I
>    should think of it as more "safe" than "simple", since "current" seems
>    simpler), so it's more realistic to refer any questions to the
>    CONFIGURATION section which describes the behaviour in more detail.
>  * Rewrite all the commits to explain the problem they're trying to solve=
 &
>    thinking behind them in more detail. Let me know if I added too much /
>    not enough detail.
>
> changes in v3:
>
>  * mention that git push also needs to send data in addition to updating =
the
>    branch, from Junio's review
>  * fix a newline, from Junio's review
>  * un-rename urls-remotes.adoc, from Junio's review
>  * mention pushRemote and git checkout in the UPSTREAM BRANCHES section a=
nd
>    be clearer about what's meant by "the relationship between the current
>    branch and the upstream", from Junio's review
>  * fix AsciiDoc formatting issue, from Junio's review
>
> Julia Evans (4):
>   doc: git-push: clarify intro
>   doc: add an UPSTREAM BRANCHES section to pull/push/fetch
>   doc: git-push: clarify "where to push"
>   doc: git-push: clarify "what to push"
>
>  Documentation/git-push.adoc     | 43 +++++++++++++++++---------------
>  Documentation/urls-remotes.adoc | 44 ++++++++++++++++++++++++++++++---
>  2 files changed, 64 insertions(+), 23 deletions(-)
>
>
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1964%2F=
jvns%2Fclarify-push-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1964/jvns/=
clarify-push-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1964
>
> Range-diff vs v2:
>
>  1:  270edd2b00 ! 1:  2870c77e80 doc: git-push: clarify intro
>      @@ Documentation/git-push.adoc: SYNOPSIS
>       -every time you push into it, by setting up 'hooks' there.  See
>       -documentation for linkgit:git-receive-pack[1].
>       +Updates one or more branches, tags, or other references in a remot=
e
>      -+repository from your local repository.
>      ++repository from your local repository, and sends all necessary dat=
a
>      ++that isn't already on the remote.
>
>        When the command line does not specify where to push with the
>        `<repository>` argument, `branch.*.remote` configuration for the
>      @@ Documentation/git-push.adoc: corresponding upstream branch, but a=
s a safety meas
>       +You can make interesting things happen to a repository
>       +every time you push into it, by setting up 'hooks' there.  See
>       +documentation for linkgit:git-receive-pack[1].
>      ++
>
>        OPTIONS[[OPTIONS]]
>        ------------------
>  2:  0ec629d403 ! 2:  3ecfb5c3a6 doc: add an UPSTREAM BRANCHES section to=
 pull/push/fetch
>      @@ Commit message
>
>           Signed-off-by: Julia Evans <julia@jvns.ca>
>
>      - ## Documentation/git-fetch.adoc ##
>      -@@ Documentation/git-fetch.adoc: include::pull-fetch-param.adoc[]
>      -  Read refspecs, one per line, from stdin in addition to those prov=
ided
>      -  as arguments. The "tag <name>" format is not supported.
>      -
>      --include::urls-remotes.adoc[]
>      -+include::urls-remotes-upstreams.adoc[]
>      -
>      -
>      - CONFIGURED REMOTE-TRACKING BRANCHES[[CRTB]]
>      -
>      - ## Documentation/git-pull.adoc ##
>      -@@ Documentation/git-pull.adoc: include::fetch-options.adoc[]
>      -
>      - include::pull-fetch-param.adoc[]
>      -
>      --include::urls-remotes.adoc[]
>      -+include::urls-remotes-upstreams.adoc[]
>      -
>      - include::merge-strategies.adoc[]
>      -
>      -
>      - ## Documentation/git-push.adoc ##
>      -@@ Documentation/git-push.adoc: further recursion will occur. In th=
is case, "only" is treated as "on-demand".
>      - --ipv6::
>      -  Use IPv6 addresses only, ignoring IPv4 addresses.
>      -
>      --include::urls-remotes.adoc[]
>      -+include::urls-remotes-upstreams.adoc[]
>      -
>      - OUTPUT
>      - ------
>      -
>      - ## Documentation/urls-remotes.adoc =3D> Documentation/urls-remotes=
-upstreams.adoc ##
>      -@@ Documentation/urls-remotes-upstreams.adoc: git push uses:
>      + ## Documentation/urls-remotes.adoc ##
>      +@@ Documentation/urls-remotes.adoc: git push uses:
>         HEAD:refs/heads/<head>
>        ------------
>
>      @@ Documentation/urls-remotes-upstreams.adoc: git push uses:
>       +Git defaults to using the upstream branch for remote operations, f=
or example:
>       +
>       +* It's the default for `git pull` or `git fetch` with no arguments
>      -+* It's sometimes the default for `git push` with no arguments. See=
 the
>      -+  `push.default` section of linkgit:git-config[1] for the details.
>      -+* `git status` and `git branch -v` will show the
>      -+  relationship between the current branch and the upstream,
>      -+  for example "Your branch is up to date with origin/main"
>      ++* It's the default for `git push` with no arguments, with some exc=
eptions.
>      ++  For example, you can use the `branch.<name>.pushRemote` option t=
o push
>      ++  to a different remote than you pull from, and by default with
>      ++  `push.default=3Dsimple` the upstream branch you configure must h=
ave
>      ++  the same name.
>      ++* Various commands, including `git checkout` and `git status`, wil=
l
>      ++  show you how many commits have been added to your current branch=
 and
>      ++  the upstream since you forked from it, for example "Your branch =
and
>      ++  'origin/main' have diverged, and have 2 and 3 different commits =
each
>      ++  respectively"
>       +
>       +The upstream is stored in `.git/config`, in the "remote" and "merg=
e"
>       +fields. For example, if `main`'s upstream is `origin/main`:
>       +
>      -+```
>      -+[branch "main"]
>      -+   remote =3D origin
>      -+   merge =3D refs/heads/main
>      -+```
>      ++ [branch "main"]
>      ++    remote =3D origin
>      ++    merge =3D refs/heads/main
>       +
>       +You can set an upstream branch explicitly with
>       +`git push --set-upstream <remote> <branch>` or `git branch --track=
`,
>  3:  374740c678 ! 3:  bfd6072983 doc: git-push: clarify "where to push"
>      @@ Commit message
>           doc: git-push: clarify "where to push"
>
>           Be clearer about what we're describing ("which repository" inst=
ead of
>      -    "what to push"), and start with a positive "try X, then Y, then=
 Z"
>      +    "where to push"), and start with a positive "try X, then Y, the=
n Z"
>           instead of a negative ("if X is not specified..").
>
>           Signed-off-by: Julia Evans <julia@jvns.ca>
>
>        ## Documentation/git-push.adoc ##
>      -@@ Documentation/git-push.adoc: DESCRIPTION
>      - Updates one or more branches, tags, or other references in a remot=
e
>      - repository from your local repository.
>      +@@ Documentation/git-push.adoc: Updates one or more branches, tags,=
 or other references in a remote
>      + repository from your local repository, and sends all necessary dat=
a
>      + that isn't already on the remote.
>
>       -When the command line does not specify where to push with the
>       -`<repository>` argument, `branch.*.remote` configuration for the
>  4:  59732f1e47 =3D 4:  be6453d010 doc: git-push: clarify "what to push"
>
> --
> gitgitgadget

Range-diff looks good to me. Thanks Julia!

--=20
D. Ben Knoble
