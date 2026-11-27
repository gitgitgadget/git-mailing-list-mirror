Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795747972;
	b=Gbpi1KjZmtmdkyfptsN98c3gGfPWlSsFrU+doA7M/mh+LXqzue8AZEO/wWghqEF2dY5P
	 FMjnaqlRSJBLZkv4v0mga9iAglqpOribFvF+bwfB/JJiPOQymCNg2D6fQXu254B9WtEMU
	 R/J9BD2XGoP/F0AcRhId7a3IqmJToS+F0YUT3EvOmHU8SMzdCdoTDXMMtfgKI0CJxzKHk
	 rE38o945wXRsqpTg2ZBXfSKkqaStX2jOW01tEkNbJZ0WUp8Udx/pSdWHFemLCAZTOrbUf
	 99XjxKiWFljs4R5p8rxLZLXFlPTUA+kPUnADlaWtY2/xYCaFErsDirewkE0hQa54MpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OHiMOjRWrCAkhnRR9vc9ccjKHL5BEu4qdzHSAKv85nA=;
	b=UhGGLHUZfsNXuU28DN1v/5RyRokzFRJajr8WA7eSt98Bm6DFM6OzH9EdlPoWiOeeCm9o
	 fClsquNsDB2IWu7kvcHhsKP2OkGmO6mxamOoJyQIWQ+zIahg00ECve+GXi0yJkkeUNYpS
	 XWSaULAYB5rmmE+brHCbOIFr0upH4Soqv83yAUOE0HXpxqY3FEjXmWImCtWqW5i0WQ3ie
	 1CSYd7cTV92E3kns+oWEuGhGv9Wy+Bj0DKfuz4QMoCJguTnI2H7NR+ZhlIgVE7vcmtt3J
	 SkkQU6v3ML+yaQl8Dbi2fE7/1qPzW2ju/aVhVogb1HXQ58m8Imgox+scIjy+RFHdTRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T5cm2TO0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458C606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 02:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B458C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T5cm2TO0
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3afa1c39cbdso22307381fa.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 18:52:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795747970; cv=none;
        d=google.com; s=arc-20260327;
        b=TejCgHJug59WHgF+4wRMKeij2Zz9xwGbIz4KGrGbT1CQDvvL87nd4Ou8ZR7mFd51a0
         flvxDLT/Dx2MDvAQ7gz7kVMVjv3NFAKhscjIoDn+EleVSLEI04agx+EDJ9uj7ZXYVulO
         hUL1RhxWkZTP5LS7ofq/bzLEEzv0X5R/YTguIoBcOwqoJfyBvs7oc2/bqKvDBqn5aZ8a
         YHGWBkx7JA3ZfFz8ZwIgv5ZAZeB/+5MAAPEOGHqBqMXpKuM2orljRspU42eYPBI0riCI
         OKgvKa3+q0fK4gtHaZurLVz+I/TgJr7dU8PzZCoz8nxsCS9IWeV6cWkXwuVM+rVtUwEe
         QYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OHiMOjRWrCAkhnRR9vc9ccjKHL5BEu4qdzHSAKv85nA=;
        fh=5E0P2ZnFFG2Vq5SLdpGpugu7HOnUyHAbQv1qVpSIzrM=;
        b=kOF4KQOLyvR2Y8BwWBz059Smqnmbm90S0AInb5oUdIDvf22qySzOz4YwCaHgBt+u7L
         hstpxxqLoSzLa2Xt+/hBueyGXyO+0qTxohQVhFOYOXFUfG2bTXWS6awALnLt3tGuWlO9
         dWZLysQ9Nxg6qZdH4A4vfpizGnvjDLG3/T5E9KgSF4cMpLrm0fn30RLwFFFiSQJD+gB/
         sks/QkpuC3P7QjvmAIOyzOE4R14iEfgsvuAKPtYHe+th7+MMy71b5Dre0uvdMk/gZ6O2
         52M67Cm/qMbnI7qnvHLUIPHj87c5e+jYH7GTBnVYzTt/ICzIN95FYQi1tEoR47sha645
         4pkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795747970; x=1796352770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OHiMOjRWrCAkhnRR9vc9ccjKHL5BEu4qdzHSAKv85nA=;
        b=T5cm2TO0vt8xAq22ReEAIZdjsls6lDHnh+c+WvjBL+VcVkJdL+HMTPp/OuFNKMJWPj
         9WD4PK9d/oH9xpVTt15AnwOWJ7P37oVtFG5XYr/H8iOZdCH/ehLQ0ynKqZGY2e+gIvNE
         vHVjku6mLexDghZ/i2SgTfZQgPx/KKArngdVRXrhQeXavtro5o6Bz2ROv7jTfErXLlpK
         5Oj73PiEu3owcmdlqNLKsP5dQg6Di14hzi+SQ+hkjZxKSCCLWD1KOoOQZ4jqC6RHfIRm
         7FRPRScZAgA/5vKK5FAuveXzujv9TWGhQZHCZgley8G5FP3fKUi/iDaummBRqA8ud7Fl
         PHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795747970; x=1796352770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHiMOjRWrCAkhnRR9vc9ccjKHL5BEu4qdzHSAKv85nA=;
        b=qnp5hYVN8vhRCxv/m6dPZdvdkBVuuBLlMuZLJQTSKCQ6fNuPuCHS+ggXDQ7Nu6pfDD
         IZz0nfbX45k9ZUDU3fZsmYtGbYzNLBMdGRSY4ygCUpC/AOyDqhg09VbIjBoM0QOuWG0p
         9Ki8GpkVay9t9951UI+DIjMdVhs58tQOqLQHNIzAKRe5SYauEpPxbhGJ9S9KLTv+Pocq
         iOPWzLOg3NPsJuf7rHe01j9rBs/cAV2/Xndyf5REezutkniBHO444JqsM8UQx7gQ+w9D
         byKI0H3hpDgYDJrjc8FQcsHixC+LgaLH+ylWzi/OdAOCpiBt98dawevDgiUu7DXvhz3y
         PPhg==
X-Gm-Message-State: APuU4Z9T1qCFkWSdtdckh9e7yXB7l1w2RVT+gwDDBGZ1ftBFHD1uqycF
	1q4yOz/RR064b6C/rMO+2rWTYtu1R5M9LgAF4rgqHJvkod+wKCDudGTl0vERCW6oh6nWAW3ijqz
	pLvZAst/57POGX8ct/CFKfDH+NyYQ4lc=
X-Gm-Gg: AZFdTZfjnw5/K7m5L8CF6IV8bqcriSDVWLBU2oKyI3u2X6xxoLO71+hwwvk52pbfD0Y
	0jBKXR/7sr/keWWXHYiMywbUdPhY6eg8JEHMDNM6U/lhdg0VJHXiKHDL2KmGHgj8JBLe0mwPf92
	pGAdkOmTsOR8tVBw7VBJd4nzJO4+dUtcOzjsAdz2dS5wUiIhg93wp39xtQdE4KxtkCdWgTzTUbd
	jbrPQU0IGuwP+/y3EjEZYhHdVWsbEfDbwaFBnIm3TrKibzD8i0G7Wgrr3Q+oVeo3NlIt/UWswms
	9CKL+Jooa9fheuabl1RTkgprMcyhKp+CD/TaoUGyjR7zA2IOJaw5wTuZwQ4L0H6n0OcTJlBrS0I
	oD2g4JBL9xlZdjpggYP975NFYxOZFcH5E4UEidMoulDpvJgeY7WbaE1fE6cg=
X-Received: by 2002:a05:6512:3986:b0:5c3:3b39:a923 with SMTP id
 2adb3069b0e04-5c33b39a99dmr97904e87.2.1795747969304; Thu, 26 Nov 2026
 18:52:49 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2336.git.1795686173178.gitgitgadget@gmail.com> <pull.2336.v2.git.1795747717319.gitgitgadget@gmail.com>
In-Reply-To: <pull.2336.v2.git.1795747717319.gitgitgadget@gmail.com>
From: Nahid hasan Sagor <nahidhasan141400@gmail.com>
Date: Fri, 27 Nov 2026 08:52:36 +0600
X-Gm-Features: Aa3M54rKetQfpK1B2DTw6GNNv5eNO0NjK1n16zV6RjoyOyc1W7cBr-qLjlQ5Hbk
Message-ID: <CABQNq+mBfq5cPL7W31EcWPNJqb+3tfYRpyec4sRb4iD9oPYCbg@mail.gmail.com>
Subject: Re: [PATCH v2] push: shell-quote names in suggested push commands
To: Nahid Hasan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks for the thorough review. I have just sent v2 addressing all of
your points:

- Dropped the trailing clause from the commit.
- Quoted the entire "HEAD:<short_upstream>" refspec in die_push_simple().
- Removed the "die() does not return" notes from the comments.
- Quoted remote->name in setup_default_push_refspecs() for
message_detached_head_die[].
- Simplified the test_when_finished cleanup in t5523-push-upstream.sh
and removed the redundant single-branch test.

Thanks,
MD Nahid Hasan Sagor

On Fri, Nov 27, 2026 at 8:48=E2=80=AFAM Nahid Hasan via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>
>
> Branch and remote names in Git may contain shell metacharacters such
> as '&', ';', and '$'. When `git push` fails and prints a suggested
> command to copy and paste, those names are formatted without shell
> quoting. Copying that suggestion into a POSIX shell splits the line;
> for example:
>
>     git push --set-upstream origin feat-&-test
>
> backgrounds `git push --set-upstream origin feat-` and tries to run
> `-test` as a separate command.
>
> Format the remote, branch, and ref names in the suggested `git push`
> commands in `builtin/push.c` with `sq_quote_buf_pretty()` so names
> that need quoting are wrapped in single quotes while plain names stay
> bare. A HEAD:<dst> refspec is quoted as one shell word, and the
> detached-HEAD hint in setup_default_push_refspecs() quotes the remote
> name as well.
>
> Signed-off-by: MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>
> ---
>     push: shell-quote names in suggested push commands
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2336%2F=
nahidhasan141400%2Ffix-push-upstream-quoting-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2336/nahid=
hasan141400/fix-push-upstream-quoting-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2336
>
> Range-diff vs v1:
>
>  1:  5494c805c1 ! 1:  dad0b1673d push: shell-quote names in suggested pus=
h commands
>      @@ Commit message
>           Format the remote, branch, and ref names in the suggested `git =
push`
>           commands in `builtin/push.c` with `sq_quote_buf_pretty()` so na=
mes
>           that need quoting are wrapped in single quotes while plain name=
s stay
>      -    bare, and add tests for each hint.
>      +    bare. A HEAD:<dst> refspec is quoted as one shell word, and the
>      +    detached-HEAD hint in setup_default_push_refspecs() quotes the =
remote
>      +    name as well.
>
>           Signed-off-by: MD Nahid Hasan Sagor <nahidhasan141400@gmail.com=
>
>
>      @@ builtin/push.c: static NORETURN void die_push_simple(struct branc=
h *branch,
>         const char *short_upstream =3D branch->merge[0]->src;
>         struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
>       + struct strbuf quoted_remote =3D STRBUF_INIT;
>      -+ struct strbuf quoted_upstream =3D STRBUF_INIT;
>      ++ struct strbuf refspec =3D STRBUF_INIT;
>      ++ struct strbuf quoted_refspec =3D STRBUF_INIT;
>
>         skip_prefix(short_upstream, "refs/heads/", &short_upstream);
>
>      @@ builtin/push.c: static NORETURN void die_push_simple(struct branc=
h *branch,
>       +
>       + /*
>       +  * Quote for copy-paste into a POSIX shell. Ordinary names stay
>      -+  * bare; metacharacters are wrapped in single quotes. die() does
>      -+  * not return, so these buffers are intentionally not released.
>      ++  * bare; metacharacters are wrapped in single quotes.
>       +  */
>      ++ strbuf_addf(&refspec, "HEAD:%s", short_upstream);
>       + sq_quote_buf_pretty(&quoted_remote, remote->name);
>      -+ sq_quote_buf_pretty(&quoted_upstream, short_upstream);
>      ++ sq_quote_buf_pretty(&quoted_refspec, refspec.buf);
>         die(_("The upstream branch of your current branch does not match\=
n"
>               "the name of your current branch.  To push to the upstream =
branch\n"
>               "on the remote, use\n"
>      -@@ builtin/push.c: static NORETURN void die_push_simple(struct bran=
ch *branch,
>      +        "\n"
>      +-       "    git push %s HEAD:%s\n"
>      ++       "    git push %s %s\n"
>      +        "\n"
>      +        "To push to the branch of the same name on the remote, use\=
n"
>               "\n"
>               "    git push %s HEAD\n"
>               "%s%s"),
>       -     remote->name, short_upstream,
>       -     remote->name, advice_pushdefault_maybe,
>      -+     quoted_remote.buf, quoted_upstream.buf,
>      ++     quoted_remote.buf, quoted_refspec.buf,
>       +     quoted_remote.buf, advice_pushdefault_maybe,
>             advice_automergesimple_maybe);
>        }
>      @@ builtin/push.c: static const char *get_upstream_ref(int flags, st=
ruct branch *br
>                 }
>       +         /*
>       +          * The prose keeps the raw branch name. Only the
>      -+          * copy-pasteable command is shell-quoted. die() does
>      -+          * not return, so these buffers are not released.
>      ++          * copy-pasteable command is shell-quoted.
>       +          */
>       +         sq_quote_buf_pretty(&quoted_remote, remote_name);
>       +         sq_quote_buf_pretty(&quoted_branch, branch->name);
>      @@ builtin/push.c: static const char *get_upstream_ref(int flags, st=
ruct branch *br
>                     advice_autosetup_maybe);
>         }
>         if (branch->merge_nr !=3D 1)
>      +@@ builtin/push.c: static void setup_default_push_refspecs(int *fla=
gs, struct remote *remote)
>      +  }
>      +
>      +  branch =3D branch_get(NULL);
>      +- if (!branch)
>      +-         die(_(message_detached_head_die), remote->name);
>      ++ if (!branch) {
>      ++         struct strbuf quoted_remote =3D STRBUF_INIT;
>      ++
>      ++         sq_quote_buf_pretty(&quoted_remote, remote->name);
>      ++         die(_(message_detached_head_die), quoted_remote.buf);
>      ++ }
>      +
>      +  dst =3D branch->refname;
>      +  same_remote =3D !strcmp(remote->name, remote_for_branch(branch, N=
ULL));
>       @@ builtin/push.c: static void die_if_repo_looks_like_ref(const cha=
r *repo)
>        {
>         const char *slash =3D strchr(repo, '/');
>      @@ t/t5523-push-upstream.sh: test_expect_success TTY 'quiet push -u'=
 '
>        '
>
>       +test_expect_success 'no-upstream advice quotes a branch name with =
metacharacters' '
>      ++ test_when_finished "git branch -D \"branch&name\"" &&
>       + test_when_finished "git checkout main" &&
>       + git checkout -b "branch&name" &&
>      -+ test_when_finished "git checkout main && git branch -D \"branch&n=
ame\"" &&
>       + test_must_fail git push upstream 2>stderr &&
>       + test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}=
" stderr
>       +'
>      @@ t/t5528-push-default.sh: test_expect_success 'default triangular =
behavior acts l
>       + test_config branch.main.merge "refs/heads/upstream&name" &&
>       + git checkout main &&
>       + test_must_fail git -c push.default=3Dsimple push parent1 2>stderr=
 &&
>      -+ test_grep "git push parent1 HEAD:${SQ}upstream&name${SQ}" stderr
>      ++ test_grep "git push parent1 ${SQ}HEAD:upstream&name${SQ}" stderr
>      ++'
>      ++
>      ++test_expect_success 'detached HEAD advice quotes a remote name wit=
h metacharacters' '
>      ++ git remote add "weird&remote" repo1 &&
>      ++ test_when_finished "git remote remove \"weird&remote\"" &&
>      ++ test_when_finished "git checkout main" &&
>      ++ git checkout --detach &&
>      ++ test_must_fail git push "weird&remote" 2>stderr &&
>      ++ test_grep "    git push ${SQ}weird&remote${SQ} HEAD:" stderr
>       +'
>       +
>        test_done
>
>        ## t/t5529-push-errors.sh ##
>      -@@ t/t5529-push-errors.sh: test_expect_success 'suggest <remote> <b=
ranch> when the branch has slashes' '
>      -  test_grep "hint: Did you mean to use: git push origin feature/x?"=
 stderr
>      - '
>      -
>      -+test_expect_success 'suggest quoted branch when the slipped name n=
eeds shell quoting' '
>      -+ test_must_fail git push "origin/branch&name" 2>stderr &&
>      -+ test_grep "hint: Did you mean to use: git push origin ${SQ}branch=
&name${SQ}?" stderr
>      -+'
>      -+
>      - test_expect_success 'no suggestion when prefix is not a configured=
 remote' '
>      -  test_must_fail git push not-a-remote/main 2>stderr &&
>      -  test_grep ! "Did you mean" stderr
>       @@ t/t5529-push-errors.sh: test_expect_success 'detect ambiguous re=
fs early' '
>         test_cmp expect rp-ran
>        '
>      @@ t/t5529-push-errors.sh: test_expect_success 'detect ambiguous ref=
s early' '
>       +'
>       +
>       +test_expect_success 'no-upstream advice quotes metacharacters only=
 in the command' '
>      -+ test_when_finished "git checkout main" &&
>       + git remote add "weird&remote" remote.git &&
>       + test_when_finished "git remote remove \"weird&remote\"" &&
>      ++ test_when_finished "git branch -D ${SQ}feat-&;\$name${SQ}" &&
>      ++ test_when_finished "git checkout main" &&
>       + git checkout -b "feat-&;\$name" &&
>      -+ test_when_finished "git checkout main && git branch -D ${SQ}feat-=
&;\$name${SQ}" &&
>       + test_config "branch.feat-&;\$name.remote" "weird&remote" &&
>       + test_must_fail git -c push.default=3Dsimple push "weird&remote" 2=
>stderr &&
>       + test_grep -F "The current branch feat-&;\$name has no upstream br=
anch." stderr &&
>      @@ t/t5529-push-errors.sh: test_expect_success 'detect ambiguous ref=
s early' '
>       + test_config branch.main.merge "refs/heads/feat-&;\$name" &&
>       + test_must_fail git -c push.default=3Dsimple push "weird&remote" 2=
>stderr &&
>       + printf "%s\n" \
>      -+         "git push ${SQ}weird&remote${SQ} HEAD:${SQ}feat-&;\$name$=
{SQ}" \
>      ++         "git push ${SQ}weird&remote${SQ} ${SQ}HEAD:feat-&;\$name$=
{SQ}" \
>       +         "git push ${SQ}weird&remote${SQ} HEAD" >expect &&
>       + sed -n "/^    git push /s/^    //p" stderr >actual &&
>       + test_cmp expect actual &&
>
>
>  builtin/push.c           | 48 +++++++++++++++----
>  t/t5523-push-upstream.sh |  8 ++++
>  t/t5528-push-default.sh  | 17 +++++++
>  t/t5529-push-errors.sh   | 99 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 164 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 2377b5af55..3908f5f532 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -18,6 +18,7 @@
>  #include "transport.h"
>  #include "parse-options.h"
>  #include "pkt-line.h"
> +#include "quote.h"
>  #include "submodule.h"
>  #include "submodule-config.h"
>  #include "send-pack.h"
> @@ -155,6 +156,9 @@ static NORETURN void die_push_simple(struct branch *b=
ranch,
>         const char *advice_automergesimple_maybe =3D "";
>         const char *short_upstream =3D branch->merge[0]->src;
>         struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
> +       struct strbuf quoted_remote =3D STRBUF_INIT;
> +       struct strbuf refspec =3D STRBUF_INIT;
> +       struct strbuf quoted_refspec =3D STRBUF_INIT;
>
>         skip_prefix(short_upstream, "refs/heads/", &short_upstream);
>
> @@ -173,18 +177,26 @@ static NORETURN void die_push_simple(struct branch =
*branch,
>                                  "won't match the local branch, see optio=
n "
>                                  "'simple' of branch.autoSetupMerge\n"
>                                  "in 'git help config'.\n");
> +
> +       /*
> +        * Quote for copy-paste into a POSIX shell. Ordinary names stay
> +        * bare; metacharacters are wrapped in single quotes.
> +        */
> +       strbuf_addf(&refspec, "HEAD:%s", short_upstream);
> +       sq_quote_buf_pretty(&quoted_remote, remote->name);
> +       sq_quote_buf_pretty(&quoted_refspec, refspec.buf);
>         die(_("The upstream branch of your current branch does not match\=
n"
>               "the name of your current branch.  To push to the upstream =
branch\n"
>               "on the remote, use\n"
>               "\n"
> -             "    git push %s HEAD:%s\n"
> +             "    git push %s %s\n"
>               "\n"
>               "To push to the branch of the same name on the remote, use\=
n"
>               "\n"
>               "    git push %s HEAD\n"
>               "%s%s"),
> -           remote->name, short_upstream,
> -           remote->name, advice_pushdefault_maybe,
> +           quoted_remote.buf, quoted_refspec.buf,
> +           quoted_remote.buf, advice_pushdefault_maybe,
>             advice_automergesimple_maybe);
>  }
>
> @@ -204,6 +216,9 @@ static const char *get_upstream_ref(int flags, struct=
 branch *branch, const char
>
>         if (!branch->merge_nr || !branch->merge || !branch->remote_name) =
{
>                 const char *advice_autosetup_maybe =3D "";
> +               struct strbuf quoted_remote =3D STRBUF_INIT;
> +               struct strbuf quoted_branch =3D STRBUF_INIT;
> +
>                 if (!(flags & TRANSPORT_PUSH_AUTO_UPSTREAM)) {
>                         advice_autosetup_maybe =3D _("\n"
>                                            "To have this happen automatic=
ally for "
> @@ -211,14 +226,20 @@ static const char *get_upstream_ref(int flags, stru=
ct branch *branch, const char
>                                            "upstream, see 'push.autoSetup=
Remote' "
>                                            "in 'git help config'.\n");
>                 }
> +               /*
> +                * The prose keeps the raw branch name. Only the
> +                * copy-pasteable command is shell-quoted.
> +                */
> +               sq_quote_buf_pretty(&quoted_remote, remote_name);
> +               sq_quote_buf_pretty(&quoted_branch, branch->name);
>                 die(_("The current branch %s has no upstream branch.\n"
>                     "To push the current branch and set the remote as ups=
tream, use\n"
>                     "\n"
>                     "    git push --set-upstream %s %s\n"
>                     "%s"),
>                     branch->name,
> -                   remote_name,
> -                   branch->name,
> +                   quoted_remote.buf,
> +                   quoted_branch.buf,
>                     advice_autosetup_maybe);
>         }
>         if (branch->merge_nr !=3D 1)
> @@ -249,8 +270,12 @@ static void setup_default_push_refspecs(int *flags, =
struct remote *remote)
>         }
>
>         branch =3D branch_get(NULL);
> -       if (!branch)
> -               die(_(message_detached_head_die), remote->name);
> +       if (!branch) {
> +               struct strbuf quoted_remote =3D STRBUF_INIT;
> +
> +               sq_quote_buf_pretty(&quoted_remote, remote->name);
> +               die(_(message_detached_head_die), quoted_remote.buf);
> +       }
>
>         dst =3D branch->refname;
>         same_remote =3D !strcmp(remote->name, remote_for_branch(branch, N=
ULL));
> @@ -669,6 +694,8 @@ static void die_if_repo_looks_like_ref(const char *re=
po)
>  {
>         const char *slash =3D strchr(repo, '/');
>         struct strbuf name =3D STRBUF_INIT;
> +       struct strbuf quoted_remote =3D STRBUF_INIT;
> +       struct strbuf quoted_ref =3D STRBUF_INIT;
>         int code;
>
>         if (!slash || !slash[1] || file_exists(repo))
> @@ -680,11 +707,16 @@ static void die_if_repo_looks_like_ref(const char *=
repo)
>                 return;
>         }
>
> +       sq_quote_buf_pretty(&quoted_remote, name.buf);
> +       sq_quote_buf_pretty(&quoted_ref, slash + 1);
> +
>         code =3D die_message(_("'%s' is not a valid push target"), repo);
>         advise_if_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
>                           _("Did you mean to use: git push %s %s?"),
> -                         name.buf, slash + 1);
> +                         quoted_remote.buf, quoted_ref.buf);
>         strbuf_release(&name);
> +       strbuf_release(&quoted_remote);
> +       strbuf_release(&quoted_ref);
>         exit(code);
>  }
>
> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> index 22d3e1162c..23b20b0419 100755
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -134,4 +134,12 @@ test_expect_success TTY 'quiet push -u' '
>         test_must_be_empty output
>  '
>
> +test_expect_success 'no-upstream advice quotes a branch name with metach=
aracters' '
> +       test_when_finished "git branch -D \"branch&name\"" &&
> +       test_when_finished "git checkout main" &&
> +       git checkout -b "branch&name" &&
> +       test_must_fail git push upstream 2>stderr &&
> +       test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}=
" stderr
> +'
> +
>  test_done
> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index 2bd8759a68..0c009f3543 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -294,4 +294,21 @@ test_expect_success 'default triangular behavior act=
s like "current"' '
>         test_push_success "" main repo2
>  '
>
> +test_expect_success 'simple push quotes an upstream branch name with met=
acharacters' '
> +       test_config branch.main.remote parent1 &&
> +       test_config branch.main.merge "refs/heads/upstream&name" &&
> +       git checkout main &&
> +       test_must_fail git -c push.default=3Dsimple push parent1 2>stderr=
 &&
> +       test_grep "git push parent1 ${SQ}HEAD:upstream&name${SQ}" stderr
> +'
> +
> +test_expect_success 'detached HEAD advice quotes a remote name with meta=
characters' '
> +       git remote add "weird&remote" repo1 &&
> +       test_when_finished "git remote remove \"weird&remote\"" &&
> +       test_when_finished "git checkout main" &&
> +       git checkout --detach &&
> +       test_must_fail git push "weird&remote" 2>stderr &&
> +       test_grep "    git push ${SQ}weird&remote${SQ} HEAD:" stderr
> +'
> +
>  test_done
> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> index 5f8aa1ed19..57d50d8950 100755
> --- a/t/t5529-push-errors.sh
> +++ b/t/t5529-push-errors.sh
> @@ -94,4 +94,103 @@ test_expect_success 'detect ambiguous refs early' '
>         test_cmp expect rp-ran
>  '
>
> +# How a POSIX shell splits a copy-paste command line.
> +shell_split () {
> +       line=3D$1
> +       eval "set -- $line"
> +       printf "%s\n" "$#" "$@"
> +}
> +
> +test_expect_success 'no-upstream advice leaves ordinary names unquoted' =
'
> +       test_must_fail git -c push.default=3Dsimple push origin 2>stderr =
&&
> +       test_grep -F "The current branch main has no upstream branch." st=
derr &&
> +       test_grep -F "    git push --set-upstream origin main" stderr &&
> +       test_grep ! -F "git push --set-upstream ${SQ}origin${SQ}" stderr =
&&
> +       test_grep ! -F "git push --set-upstream origin ${SQ}main${SQ}" st=
derr
> +'
> +
> +test_expect_success 'simple push mismatch leaves ordinary names unquoted=
' '
> +       test_config branch.main.remote origin &&
> +       test_config branch.main.merge refs/heads/other-name &&
> +       test_must_fail git -c push.default=3Dsimple push origin 2>stderr =
&&
> +       printf "%s\n" \
> +               "git push origin HEAD:other-name" \
> +               "git push origin HEAD" >expect &&
> +       sed -n "/^    git push /s/^    //p" stderr >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'no-upstream advice quotes metacharacters only in th=
e command' '
> +       git remote add "weird&remote" remote.git &&
> +       test_when_finished "git remote remove \"weird&remote\"" &&
> +       test_when_finished "git branch -D ${SQ}feat-&;\$name${SQ}" &&
> +       test_when_finished "git checkout main" &&
> +       git checkout -b "feat-&;\$name" &&
> +       test_config "branch.feat-&;\$name.remote" "weird&remote" &&
> +       test_must_fail git -c push.default=3Dsimple push "weird&remote" 2=
>stderr &&
> +       test_grep -F "The current branch feat-&;\$name has no upstream br=
anch." stderr &&
> +       test_grep ! -F "The current branch ${SQ}feat-&;\$name${SQ} has no=
 upstream" stderr &&
> +       printf "%s\n" \
> +               "git push --set-upstream ${SQ}weird&remote${SQ} ${SQ}feat=
-&;\$name${SQ}" >expect &&
> +       sed -n "/^    git push /s/^    //p" stderr >actual &&
> +       test_cmp expect actual &&
> +       shell_split "$(cat actual)" >actual-split &&
> +       printf "%s\n" 5 git push --set-upstream "weird&remote" "feat-&;\$=
name" >expect-split &&
> +       test_cmp expect-split actual-split
> +'
> +
> +test_expect_success 'simple push mismatch quotes remote and upstream nam=
es' '
> +       git checkout main &&
> +       git remote add "weird&remote" remote.git &&
> +       test_when_finished "git remote remove \"weird&remote\"" &&
> +       test_config branch.main.remote "weird&remote" &&
> +       test_config branch.main.merge "refs/heads/feat-&;\$name" &&
> +       test_must_fail git -c push.default=3Dsimple push "weird&remote" 2=
>stderr &&
> +       printf "%s\n" \
> +               "git push ${SQ}weird&remote${SQ} ${SQ}HEAD:feat-&;\$name$=
{SQ}" \
> +               "git push ${SQ}weird&remote${SQ} HEAD" >expect &&
> +       sed -n "/^    git push /s/^    //p" stderr >actual &&
> +       test_cmp expect actual &&
> +       {
> +               while IFS=3D read -r line
> +               do
> +                       shell_split "$line" || return 1
> +               done <actual
> +       } >actual-split &&
> +       printf "%s\n" \
> +               4 git push "weird&remote" "HEAD:feat-&;\$name" \
> +               4 git push "weird&remote" HEAD >expect-split &&
> +       test_cmp expect-split actual-split
> +'
> +
> +test_expect_success 'slash-slip advice quotes remote and ref metacharact=
ers' '
> +       git remote add "weird&remote" remote.git &&
> +       test_when_finished "git remote remove \"weird&remote\"" &&
> +
> +       test_must_fail git push "weird&remote/feat-&-test" 2>stderr &&
> +       test_grep -F "hint: Did you mean to use: git push ${SQ}weird&remo=
te${SQ} ${SQ}feat-&-test${SQ}?" stderr &&
> +       hint=3D$(sed -n "s/.*Did you mean to use: //p" stderr) &&
> +       hint=3D${hint%?} &&
> +       shell_split "$hint" >actual-split &&
> +       printf "%s\n" 4 git push "weird&remote" "feat-&-test" >expect-spl=
it &&
> +       test_cmp expect-split actual-split &&
> +
> +       test_must_fail git push "origin/feat;id" 2>stderr &&
> +       test_grep -F "hint: Did you mean to use: git push origin ${SQ}fea=
t;id${SQ}?" stderr &&
> +
> +       test_must_fail git push "origin/feat\$name" 2>stderr &&
> +       test_grep -F "hint: Did you mean to use: git push origin ${SQ}fea=
t\$name${SQ}?" stderr &&
> +
> +       test_must_fail git push "origin/feat & test" 2>stderr &&
> +       test_grep -F "hint: Did you mean to use: git push origin ${SQ}fea=
t & test${SQ}?" stderr &&
> +       hint=3D$(sed -n "s/.*Did you mean to use: //p" stderr) &&
> +       hint=3D${hint%?} &&
> +       shell_split "$hint" >actual-split &&
> +       printf "%s\n" 4 git push origin "feat & test" >expect-split &&
> +       test_cmp expect-split actual-split &&
> +
> +       test_must_fail git push "origin/feat${SQ}test" 2>stderr &&
> +       test_grep -F "hint: Did you mean to use: git push origin ${SQ}fea=
t${SQ}\\${SQ}${SQ}test${SQ}?" stderr
> +'
> +
>  test_done
>
> base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
> --
> gitgitgadget
