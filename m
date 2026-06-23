Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E033D7D69
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228170; cv=none; b=a2EK6x1aZuFUYmUBJp7KBRnuiE7F8IcOMjLSifsZPqOZ0yP80tMnI7AJ4ZfcJEefRU6do1286NS2lGKtJeIh/gcbQvMNM/MzXclmZbgHdLxACLw5BXQP9LECvKv+oQCkFi5D3G5KYgc/jdmxsoH0PFSn4nBV7JwmvQfIaz+7SGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228170; c=relaxed/simple;
	bh=/QCjbDSaVebXcBpp0SAACP2cVPkvC79OUP1GKqCBPsE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HDaUAK3pJjm5RMKuoJ22JosQ6C+G72T+Fqk6xhdSof2Dr9rzU+zRinILKrM9vqDsoEilp0x88NFsnSu0Bua7uGqjiYyfkaA1ax5OPVfE2msONQ3hf8WDQ16q3sR2KsRTbZ06Len//apN1g3KWEHoABpuyP7QRB7J883pLyW6ZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qObPV+j+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qObPV+j+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37c8e7c8137so61007a91.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228168; x=1782832968; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeAT8AkIpUvQLt3k6PmxlXjziK/XjBXputAgaefFDTU=;
        b=qObPV+j++Pv481RcKfayC+hG1MWThtkmj/QUYehfDN6BVjl6RVcJZSNSRfARQL9LBZ
         1PjzEfQNLVyJ0syMRMvFamZxa/WEoCqMpn1pWuzyxXdXv/LB51l4Dg5zBbGOThgEORwi
         Fz3T+u2y5rwKgc4OPhsomeLutkAm+wVB+CGUnQsor4vNuah/zMhomQw9lgKdrquzvnZ/
         xMfdvnH61fUeIvAZWFcNS3QGLKU8ratb0IfzPE83Bkf+ojIniiKE75himjjAB4fr+a9x
         kV1zTBuyPz+I7yJtdPKWV4+FnG5/M5FeIhlCK8/hxWa/X/ZkMq+AZIEgtpALqGc5aQhz
         xQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228168; x=1782832968;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeAT8AkIpUvQLt3k6PmxlXjziK/XjBXputAgaefFDTU=;
        b=FUhXznsV6FKpFHtYnBAHfAPdTrdyNhMP80rHb83NaxDDpsVTya1faGZ6+dVXBibMgi
         pM9Q6c5hs4Hs0MGPArpkSDri7qf7BOq90FTv+9gaogeDwkfLpMgW2iNfp8Hi1e6QKj80
         MFmQXXGMmMS6kY+7Uy+3neVX2gKtRHSxc86/gV0Q5GR6EPAEq5dHRFqt91Y5I9cOTvWC
         PnLKT/4aRdab3q1OsFWQVwEJS/uEaMZBMsKD6RPc65yqA/joU+qKRc08tzQk9U2F2baS
         n0q/nv4HwjQoXrhEhjqy5EcGbRYcZh9mcaHUCUAnxlQkkjMRkCmiT4dsQTZ9AbHvpdJA
         Q2wQ==
X-Gm-Message-State: AOJu0Yz7/mtMnkoM3bgqxBjPE2P4WwefYFQQaxKpjlGcv7ysIrz5h77T
	oEKUXYSO3+1PxS13jIOrFh2BTPK0SpWqHK7iEZuDW0rSmEbKrvqhtwI+
X-Gm-Gg: AfdE7clM0KzRFaKBkZidBgL122UUByzj+5XNz9JGi4tuhC0HaogZ3eqSGbar15pG3Of
	c9LnwcjEoSs3O98Aj65bEkqTRA3ed0PU1vdRVq9/09K6SG4T3EJK9apFaXpGAC0RTRYAE9W6G6Q
	ZkzSzMcl359epy6Ag24mDoIJVU4SEPTRX/Ozx/I80tc/ef295jU2L8Bo5NA6/f3eY6sbEizTNy9
	W7IAxZYN1EHNNP9/K7HjX3aJCDf+ez9ev07a7DzGE41J8kZRUEimG1DX1FW9ObCMXiC+ymdtN5O
	CeE8/mD3jTdoG1GPTWGSEs4LqrurwezowVXXtQ23q3jT8WjL1sIRwwyzqaY4Sf1TDLhrZUZz6OL
	p1dc6sMUbxq6Y5cOhgvBwRBQGhSH0CfzAjAsqzDTObsM2PAlGBASEpUssq6TQU3ONXqrf6ed8/P
	+iwz0ZE8Pf1J+s4+FZJJH+g1zbxKe8VOx73g==
X-Received: by 2002:a17:90b:4a42:b0:36d:f28a:c5ee with SMTP id 98e67ed59e1d1-37dd0e341abmr3570787a91.25.1782228167991;
        Tue, 23 Jun 2026 08:22:47 -0700 (PDT)
Received: from smtpclient.apple ([111.92.66.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15e0b1d4sm14469403a91.17.2026.06.23.08.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:22:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jishnu C K <jishnuck26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] help: include arguments in autocorrect=prompt message
Date: Tue, 23 Jun 2026 20:51:34 +0530
Message-Id: <9D9B615B-3B80-4F97-9DDC-4B043519F26D@gmail.com>
References: <6a357689.0f9b68c4.317a5d.1919@mx.google.com>
Cc: gitster@pobox.com, Justin Tobler <jltobler@gmail.com>
In-Reply-To: <6a357689.0f9b68c4.317a5d.1919@mx.google.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23F77)

Any review comments?
Sent from my iPhone

> On 19 Jun 2026, at 10:34=E2=80=AFPM, Jishnu C K <jishnuck26@gmail.com> wro=
te:
>=20
> =EF=BB=BFv2: Reworked as an incremental improvement to the existing
> autocorrect=3Dprompt code path rather than a parallel reimplementation,
> per feedback from Junio and Justin.
>=20
> ---
> =46rom a4e8fb6fd6dd6a501e565c7500cbf927d7cb0b42 Mon Sep 17 00:00:00 2001
> From: calicomills <jishnuck26@gmail.com>
> Date: Fri, 19 Jun 2026 13:01:40 +0530
> Subject: [PATCH v2 v2] help: include arguments in autocorrect=3Dprompt mes=
sage
>=20
> When 'help.autocorrect=3Dprompt' is configured and the user mistypes
> a git command, the prompt currently shows only the corrected command
> name:
>=20
>  Run 'checkout' instead [y/N]?
>=20
> This leaves the user unsure whether their original arguments will be
> preserved. Update the prompt to include the full corrected invocation:
>=20
>  Run 'git checkout neo' instead [y/N]?
>=20
> The help_unknown_cmd() signature is updated to accept the args vector
> so the prompt can show the original arguments alongside the corrected
> command name. Callers that do not have access to the args (e.g.
> builtin/help.c) pass NULL, which is handled gracefully.
>=20
> Signed-off-by: calicomills <jishnuck26@gmail.com>
> ---
> help.c                      | 49 +++++++++++++----------------------
> t/t9003-help-autocorrect.sh | 51 +++++--------------------------------
> 2 files changed, 23 insertions(+), 77 deletions(-)
>=20
> diff --git a/help.c b/help.c
> index 30f32a7206..9ea4c076e1 100644
> --- a/help.c
> +++ b/help.c
> @@ -739,7 +739,16 @@ char *help_unknown_cmd(const char *cmd, const struct s=
trvec *args)
>        else if (cfg.autocorrect =3D=3D AUTOCORRECT_PROMPT) {
>            char *answer;
>            struct strbuf msg =3D STRBUF_INIT;
> -            strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
> +            struct strbuf full_cmd =3D STRBUF_INIT;
> +            strbuf_addstr(&full_cmd, assumed);
> +            if (args) {
> +                for (size_t j =3D 1; j < args->nr; j++) {
> +                    strbuf_addch(&full_cmd, ' ');
> +                    strbuf_addstr(&full_cmd, args->v[j]);
> +                }
> +            }
> +            strbuf_addf(&msg, _("Run 'git %s' instead [y/N]? "), full_cmd=
.buf);
> +            strbuf_release(&full_cmd);
>            answer =3D git_prompt(msg.buf, PROMPT_ECHO);
>            strbuf_release(&msg);
>            if (!(starts_with(answer, "y") ||
> @@ -762,37 +771,13 @@ char *help_unknown_cmd(const char *cmd, const struct=
 strvec *args)
>    fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'.=
"), cmd);
>=20
>    if (SIMILAR_ENOUGH(best_similarity)) {
> -        if (n =3D=3D 1 && isatty(0) && isatty(2)) {
> -            char *answer;
> -            struct strbuf msg =3D STRBUF_INIT;
> -            struct strbuf full_cmd =3D STRBUF_INIT;
> -            strbuf_addstr(&full_cmd, main_cmds.names[0]->name);
> -            if (args) {
> -                for (size_t j =3D 1; j < args->nr; j++) {
> -                    strbuf_addch(&full_cmd, ' ');
> -                    strbuf_addstr(&full_cmd, args->v[j]);
> -                }
> -            }
> -            strbuf_addf(&msg, _("\nDid you mean 'git %s'? [y/N] "),
> -                    full_cmd.buf);
> -            strbuf_release(&full_cmd);
> -            answer =3D git_prompt(msg.buf, PROMPT_ECHO);
> -            strbuf_release(&msg);
> -            if (starts_with(answer, "y") || starts_with(answer, "Y")) {
> -                char *assumed =3D xstrdup(main_cmds.names[0]->name);
> -                cmdnames_release(&cfg.aliases);
> -                cmdnames_release(&main_cmds);
> -                cmdnames_release(&other_cmds);
> -                return assumed;
> -            }
> -        } else {
> -            fprintf_ln(stderr,
> -                   Q_("\nThe most similar command is",
> -                      "\nThe most similar commands are",
> -                   n));
> -            for (i =3D 0; i < n; i++)
> -                fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
> -        }
> +        fprintf_ln(stderr,
> +               Q_("\nThe most similar command is",
> +                  "\nThe most similar commands are",
> +               n));
> +
> +        for (i =3D 0; i < n; i++)
> +            fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
>    }
>=20
>    exit(1);
> diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
> index 6fe2da1595..75821d63e1 100755
> --- a/t/t9003-help-autocorrect.sh
> +++ b/t/t9003-help-autocorrect.sh
> @@ -70,57 +70,18 @@ test_expect_success 'autocorrect works in work tree cr=
eated from bare repo' '
>    git -C worktree -c help.autocorrect=3Dimmediate status
> '
>=20
> -# Default behaviour (no help.autocorrect set): when there is exactly one
> -# similar command but the session is non-interactive, fall back to printi=
ng
> -# the suggestion list and exiting rather than showing a prompt.
> -test_expect_success 'default: single match non-interactive shows suggesti=
on and fails' '
> -    test_might_fail git config --unset help.autocorrect &&
> -
> -    test_must_fail git lfg 2>actual &&
> -    grep "most similar command" actual &&
> -    grep "lgf" actual
> -'
> -
> -test_expect_success 'default: multiple matches non-interactive shows list=
 and fails' '
> -    test_might_fail git config --unset help.autocorrect &&
> -
> -    test_must_fail git com 2>actual &&
> -    grep "most similar commands" actual &&
> -    grep "commit" actual
> -'
> -
> -# Interactive prompt tests require a real TTY.  On macOS the TTY prereq i=
s
> -# skipped due to IO::Pty reliability issues; these tests run on Linux CI.=

> -test_expect_success TTY 'default: single match interactive, answer y runs=
 command' '
> -    git config --unset help.autocorrect &&
> -
> -    write_script git-typotest <<-\EOF &&
> -        echo typotest-ran
> -    EOF
> -    PATH=3D"$PATH:." export PATH &&
> -
> -    # Feed "y" to /dev/tty via a wrapper that answers the prompt
> -    write_script answer-prompt <<-\EOF &&
> -        # Write the answer to the controlling terminal
> -        printf "y\n" >/dev/tty
> -        exec "$@"
> -    EOF
> -
> -    test_terminal ./answer-prompt git typotest 2>err >out &&
> -    grep "typotest-ran" out &&
> -    grep "Did you mean" err
> -'
> -
> -test_expect_success TTY 'default: single match interactive, answer n exit=
s cleanly' '
> -    git config --unset help.autocorrect &&
> +# autocorrect=3Dprompt should include the original arguments in the promp=
t.
> +# Requires a TTY; skipped on macOS due to IO::Pty reliability issues.
> +test_expect_success TTY 'autocorrect=3Dprompt includes arguments in promp=
t' '
> +    git config help.autocorrect prompt &&
>=20
>    write_script answer-prompt-no <<-\EOF &&
>        printf "n\n" >/dev/tty
>        exec "$@"
>    EOF
>=20
> -    test_must_fail test_terminal ./answer-prompt-no git typotest 2>err &&=

> -    grep "Did you mean" err
> +    test_must_fail test_terminal ./answer-prompt-no git lfg --oneline 2>a=
ctual &&
> +    grep "lgf --oneline" actual
> '
>=20
> test_done
> --
> 2.50.1
>=20
>=20
