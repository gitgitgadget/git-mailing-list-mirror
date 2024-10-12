Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3A4A1E
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713271; cv=none; b=loPpB/jHCVhNzIiSROpreSGdwDqMiPB8n/StKTGoE7wqPK4818iVdnb+YImt1np1UW0CpWUdsbAMBpCIY/0gQ+ZWJtGzEmXgo3m3lEafXbct5+BMgseNmbSlblfi6TZ2iW2JUJPHRpLFXEvpnA7n4usLQP4loxsMdDKj6zt5KG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713271; c=relaxed/simple;
	bh=AiyJxw/XkZ9eKJvJ0sugrLaDAn0iDK4RfGqmD3ZCI9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtMzyVckL4k378cpORzVaSm3rVmiizoGItMJREfmlruK5/hsediO0dBZC/GwFnwY/6FdzlKb6bhK0bt80OQ+JI4egsd0Ur56dGJNx185MtXVWEEpyZMAM//6DG8JC2M+KBAntXyD4N07f4/k/9338JJU8GBCNRw2fR3l86Cm4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbc46f8b3bso3373396d6.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 23:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728713268; x=1729318068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwqlTlfmhUmbei5BZF441t0HP+eIl12iMkRcA43PIyg=;
        b=u3+jyc9rGgAIvODPH3gVM4sR717bSHcg6YRq4pRgfLUMtTVZUNyqNRCUynNyeIJj+U
         nTxEKN8ExrdzFcugX2FZD3lFJjVv8sL6s07xM4NTsBVdB0iPGR+GJLjvDWjU+uqjFlFq
         y9ro896L8KjIO5VMWbrSoJyu+/jO43/Lg99NmL1TAOJFRCh251PunmmqXOX1vViKd9RT
         R1fc67gjvaW33AaQCKM8onumegtybV2satn2QcGFKb2MIQy7HcPcH+ImiRsS+V78QBQB
         B2EwlHpbl5qYMx0W1GF17nUye5xM19rFoIJ6oWZaQupMYlZzMRms2V+LnWC9ErMMqK2E
         bYKA==
X-Gm-Message-State: AOJu0YwT0BxlewCOfyMuOGs8dWUpQm4v0yjh5B3xlgi/tiSbT6tkj2oI
	ZhEy2R8Eyu4/Mhbq4LTXhYE/aF3XHOxrPNCq+6gu0nwNjCYsEiyjr6xzaWNdRrJdX4H/AWF0ThV
	jtglpPHCPhH5q8huMaQ+PA+IO8w4=
X-Google-Smtp-Source: AGHT+IH0/38BykPeXF83zf3+dXKNiujhRB757SWk7JC2NBmwX3lpTYhtgeOTiMrm87k1fbg9e6oZxsYnJcX3v+XyOGw=
X-Received: by 2002:a05:6214:2481:b0:6bf:6d90:c084 with SMTP id
 6a1803df08f44-6cbeff3daf1mr31085706d6.3.1728713267570; Fri, 11 Oct 2024
 23:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
In-Reply-To: <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 12 Oct 2024 02:07:36 -0400
Message-ID: <CAPig+cR4WbcDDav0cdXxOMC-EDe2ipWxEzB+0C7zbFjvY_kXtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>, 
	Abhijeetsingh Meena <abhijeet040403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 12:38=E2=80=AFAM Abhijeetsingh Meena via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
> git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
> This is useful for marking uninteresting commits like formatting
> changes, refactors and whatever else should not be =E2=80=9Cblamed=E2=80=
=9D.  Some
> projects even version control this file so that all contributors can
> use it; the conventional name is `.git-blame-ignore-revs`.
>
> But each user still has to opt-in to the standard ignore list,
> either with this option or with the config `blame.ignoreRevsFile`.
> Let=E2=80=99s teach git-blame(1) to respect this conventional file in ord=
er
> to streamline the process.
>
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---
>  builtin/blame.c                      |  8 ++++++++
>  t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

This change should be accompanied by a documentation update, I would think.

> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -1105,6 +1105,14 @@ parse_done:
> +       /*
> +       * By default, add .git-blame-ignore-revs to the list of files
> +       * containing revisions to ignore if it exists.
> +       */
> +       if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
> +               string_list_append(&ignore_revs_file_list, ".git-blame-ig=
nore-revs");
> +       }

A couple style nits and a couple questions...

nit: drop the braces around the one-line `if` body

nit: this project uses `!foo(...)` rather than `foo(...) =3D=3D 0`

Presumably this consults ".git-blame-ignore-revs" in the top-level
directory (as you intended) rather than ".git-blame-ignore-revs" in
whatever subdirectory you happen to issue the command because the
current-working-directory has already been set to the top-level
directory by the time cmd_blame() has been called, right?

But that leads to the next question. Should automatic consulting of
".git-blame-ignore-revs" be restricted to just the top-level
directory, or should it be modeled after, say, ".gitignore" which may
be strewn around project directories and in which ".gitignore" files
are consulted rootward starting from the directory in which the
command is invoked. My knee-jerk thought was that the ".gitignore"
model may not make sense for ".git-blame-ignore-revs", but the fact
that `git blame` can accept and work with multiple ignore-revs files
makes me question that knee-jerk response.

> diff --git a/t/t8015-blame-default-ignore-revs.sh b/t/t8015-blame-default=
-ignore-revs.sh
> new file mode 100755

Let's avoid allocating a new test number just for this single new
test. Instead, the existing t8013-blame-ignore-revs.sh would probably
be a good home for this new test.

> +test_expect_success 'blame: default-ignore-revs-file' '
> +    test_commit first-commit hello.txt hello &&
> +
> +    echo world >>hello.txt &&
> +    test_commit second-commit hello.txt &&
> +
> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&

style: drop space after redirection operator

    sed "1s/hello/hi/" <hello.txt >hello.txt.tmp &&

> +    mv hello.txt.tmp hello.txt &&
> +    test_commit third-commit hello.txt &&
> +
> +    git rev-parse HEAD >ignored-file &&
> +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> +    git blame hello.txt >actual &&

I would suggest copying or renaming "ignored-file" to
".git-blame-ignore-revs" rather than running `git rev-parse HEAD`
twice. This way readers won't have to waste mental effort verifying
that the result of `git rev-parse HEAD` isn't intended to change
between invocations.
