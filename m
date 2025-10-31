Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D522222A0
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936602; cv=none; b=b45Ir7x4g55eRAzX1qzas0uQs1Fqd+G+cnhh4ed2EMA/iJAKyBNGARcvxo4nbW8uUoRoFuftgw1kgixtUQv+6orj/XYHEdO9On5st0UEj2IzF5pam57owSb33NxYp52TtHdCGe5zQK/rkWgWG4PT7QJGdHB2O2qNBkSio6glw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936602; c=relaxed/simple;
	bh=jdiNVIub+bsZZYiepv5OYjIXGY9sw3fvU24Z0+R0lqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erdVb88f3vWr3i4+gbP/hMbtAE5s+BSH1dXqihncm8TVETCaCC24uWXFmmDVRlJwtky3pVyEC2a4C+0cNiOV7xqbNhXobuIAjxp8/R/6o7rETDmKkn2L8v3/pkJ/CnhV4NMIzA+68fNtBU99CQaesrllwEDkwnLmlt2oZBdATBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kffRA4GO; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kffRA4GO"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-9435969137aso227190339f.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761936599; x=1762541399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRYoLCqn3lZyxSI0IVtgXFEnssoiPsnN25ZjXf6ZC88=;
        b=kffRA4GOBOTnqUA7GPdCu+HSM6tACLyidgNxTQH7RZz2BhtsMqS1Kk6L1Y0N6hU5PC
         CU+wqUVsOmnMDMcYEh3MEZiRn+VXHWkQq8+5kLcbByiyYeRUaXOLyPcc3Rj3T6Yz7Z5P
         PlDlUETtXbr6n5VABBwVGrfrbbdYOj8UvwAYbvIXvw57wRx65g6SjKiuDLux+W8LIdMX
         aIRu8wF38D5ew99kU76R+tD5RISAPCl4IS1ZmAMZ/bpbkSikZzIEWhkWgMsMkF+P/ktl
         9CJG1a3HM8cr+WcssNMYuSNJx1TEoyjr8hRFMH0uoJecu9HisR0n9zYlBFVQZ2EQ05T/
         ZS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761936599; x=1762541399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRYoLCqn3lZyxSI0IVtgXFEnssoiPsnN25ZjXf6ZC88=;
        b=nqYB5D12p2egoxThGmVVdWtBNGZMoPhKfRxVv13xxLF0UDldLoctIk3FdNAV8L2KtA
         2vdkeaOwVG+drljFRZPeTsUlVgkIV+WWvKFRVnxctElG+au+YE2evKyH1Ft/Tz61ouPZ
         S4SYHqGSsu2fY+xCX77WG1SmKoe89amtfAiGibg5tTSSgdUEFaoy8pB8g7QkVbsVsBc4
         4lUe1pI+7Y2RmXFP3jaMTkrSJL+wdxhKxNXkjEmWagiecji829ERL1D61Dw8ag3gH5eF
         DZHtlmasbtcxFN3KXO2e7VMIxDc3w5w0n0Mgk5zWsI6QXNcQLrkVeNFYxtXvu0HSaJqM
         xCTw==
X-Gm-Message-State: AOJu0YxEFQNhIMVDrHt6aSzJ+HdKxoA7WSGgyPLaJPRjuWgl5TnauekN
	jpCMW1LcGLZ7v20LtaJShKiReeh83x/m9nO+Ayx2+Fd6Nm1c5V7y1BGwl0xMWqS45K951vOm4Qu
	R2KfkO67S63wmPojibslnWNm2jJ9xd1g=
X-Gm-Gg: ASbGnctddSB2v+CkyDGAdZ+KoYPiqDIAtikvo/3k+cFVdvbJwLVqCjFIJuO33LlRmGk
	r8HNj/cBIQ2GaBm8XlCF6IhHJo/rnk3x66p4pUJlkB40cOEUK0aoYIUHo394w6IfK+M0tnpoedT
	cReyUryEUEsws+Arena1QnVTTMUIMH93HbsBwOmKR+o0PJqagNSn7bqJLskpVqBIfvrcLcrYwgr
	SBX5dCPPkEzfYFFHaCQxycJNXXkWMybL+/BHyWxKwCc5xI9Cod/rtop36KpTdMGFUEjLe3MIKtc
	qisRakQxxbKXfj2S
X-Google-Smtp-Source: AGHT+IFr6jWhkDO3WgxcrgMspghZtNtp01mXwBOmno8u8hMnCUj070vUtnHMGfWn1u2gc9WZwEA0t4FsaQdQe23xrms=
X-Received: by 2002:a05:6602:2c0b:b0:943:89ae:4200 with SMTP id
 ca18e2360f4ac-94822953a48mr676351139f.11.1761936598891; Fri, 31 Oct 2025
 11:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com> <20251030191931.30837-4-siddharthasthana31@gmail.com>
In-Reply-To: <20251030191931.30837-4-siddharthasthana31@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 31 Oct 2025 11:49:46 -0700
X-Gm-Features: AWmQ_bmyE87dWLs_R6RfrynGsnmi4x-ioCLlnJJ-gDrI-tEbxuoh2Y-HBi5Z4QQ
Message-ID: <CABPp-BE_pAQ8f-jjv16Ts-KRTEr3Qc402qRuJKFFW6G3J9shtA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] replay: add replay.refAction config option
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, gitster@pobox.com, ps@pks.im, 
	karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:20=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> Add a configuration option to control the default behavior of git replay
> for updating references. This allows users who prefer the traditional
> pipeline output to set it once in their config instead of passing
> --ref-action=3Dprint with every command.
>
> The config option uses string values that mirror the behavior modes:
>   * replay.refAction =3D update (default): atomic ref updates
>   * replay.refAction =3D print: output commands for pipeline
>
> The command-line --ref-action option always overrides the config setting,
> allowing users to temporarily change behavior for a single invocation.

The above paragraph merely states that we follow git practices with
this config options and its corresponding command line; I think we'd
need to call it out if we didn't do that, but calling out that we do
follow git conventions seems unnecessary.

> Implementation details:
>
> In cmd_replay(), after parsing command-line options, we check if
> --ref-action was provided. If not, we read the configuration using
> repo_config_get_string_tmp(). If the config variable is set, we validate
> the value and use it to set the ref_action_str:
>
>   Config value      Internal mode    Behavior
>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>   "update"          "update"         Atomic ref updates (default)
>   "print"           "print"          Pipeline output
>   (not set)         "update"         Atomic ref updates (default)
>   (invalid)         error            Die with helpful message
>
> If an invalid value is provided, we die() immediately with an error
> message explaining the valid options. This catches configuration errors
> early and provides clear guidance to users.
>
> The command-line --ref-action option, when provided, overrides the
> config value. This precedence allows users to set their preferred default
> while still having per-invocation control:
>
>   git config replay.refAction print         # Set default
>   git replay --ref-action=3Dupdate --onto main topic  # Override once
>
> The config and command-line option use the same value names ('update'
> and 'print') for consistency and clarity. This makes it immediately
> obvious how the config maps to the command-line option, addressing
> feedback about the relationship between configuration and command-line
> options being clear to users.

An implementation details section may make sense if it answers a
"why?" question, or it explains something counter-intuitive, or it
provides high enough level details that it makes the patch easier to
read/follow, or it otherwise does something more than just repackage
the patch in an alternate format.  I appreciate the attempt to provide
these, but I think they simply make the commit message longer without
adding value.

> Examples:
>
> $ git config --global replay.refAction print
> $ git replay --onto main topic1..topic2 | git update-ref --stdin
>
> $ git replay --ref-action=3Dupdate --onto main topic1..topic2
>
> $ git config replay.refAction update
> $ git replay --onto main topic1..topic2  # Updates refs directly
>
> The implementation follows Git's standard configuration precedence:
> command-line options override config values, which matches user
> expectations across all Git commands.

I don't find the Examples section helpful either; it's yet another
re-iteration that we're following conventions.

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Elijah Newren <newren@gmail.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  Documentation/config/replay.adoc | 11 ++++++++
>  builtin/replay.c                 | 39 ++++++++++++++++++--------
>  t/t3650-replay-basics.sh         | 48 +++++++++++++++++++++++++++++++-
>  3 files changed, 86 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/config/replay.adoc
>
> diff --git a/Documentation/config/replay.adoc b/Documentation/config/repl=
ay.adoc
> new file mode 100644
> index 0000000000..7d549d2f0e
> --- /dev/null
> +++ b/Documentation/config/replay.adoc
> @@ -0,0 +1,11 @@
> +replay.refAction::
> +       Specifies the default mode for handling reference updates in
> +       `git replay`. The value can be:
> ++
> +--
> +       * `update`: Update refs directly using an atomic transaction (def=
ault behavior).
> +       * `print`: Output update-ref commands for pipeline use.
> +--
> ++
> +This setting can be overridden with the `--ref-action` command-line opti=
on.
> +When not configured, `git replay` defaults to `update` mode.
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 0564d4d2e7..810068f8ef 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -8,6 +8,7 @@
>  #include "git-compat-util.h"
>
>  #include "builtin.h"
> +#include "config.h"
>  #include "environment.h"
>  #include "hex.h"
>  #include "lockfile.h"
> @@ -289,6 +290,31 @@ static struct commit *pick_regular_commit(struct rep=
ository *repo,
>         return create_commit(repo, result->tree, pickme, replayed_base);
>  }
>
> +static enum ref_action_mode parse_ref_action_mode(const char *ref_action=
, const char *source)
> +{
> +       if (!ref_action || !strcmp(ref_action, "update"))
> +               return REF_ACTION_UPDATE;
> +       if (!strcmp(ref_action, "print"))
> +               return REF_ACTION_PRINT;
> +       die(_("invalid %s value: '%s'"), source, ref_action);
> +}
> +
> +static enum ref_action_mode get_ref_action_mode(struct repository *repo,=
 const char *ref_action_str)
> +{
> +       const char *config_value =3D NULL;
> +
> +       /* Command line option takes precedence */
> +       if (ref_action_str)
> +               return parse_ref_action_mode(ref_action_str, "--ref-actio=
n");
> +
> +       /* Check config value */
> +       if (!repo_config_get_string_tmp(repo, "replay.refAction", &config=
_value))
> +               return parse_ref_action_mode(config_value, "replay.refAct=
ion");
> +
> +       /* Default to update mode */
> +       return REF_ACTION_UPDATE;
> +}
> +
>  static int handle_ref_update(enum ref_action_mode mode,
>                              struct ref_transaction *transaction,
>                              const char *refname,
> @@ -367,17 +393,8 @@ int cmd_replay(int argc,
>         die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>                                   contained, "--contained");
>
> -       /* Default to update mode if not specified */
> -       if (!ref_action_str)
> -               ref_action_str =3D "update";
> -
> -       /* Parse ref action mode */
> -       if (!strcmp(ref_action_str, "update"))
> -               ref_action =3D REF_ACTION_UPDATE;
> -       else if (!strcmp(ref_action_str, "print"))
> -               ref_action =3D REF_ACTION_PRINT;
> -       else
> -               die(_("unknown --ref-action mode '%s'"), ref_action_str);
> +       /* Parse ref action mode from command line or config */
> +       ref_action =3D get_ref_action_mode(repo, ref_action_str);
>
>         advance_name =3D xstrdup_or_null(advance_name_opt);
>
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 123734b49f..2e90227c2f 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -219,7 +219,8 @@ test_expect_success 'merge.directoryRenames=3Dfalse' =
'
>
>  test_expect_success 'default atomic behavior updates refs directly' '
>         # Store original state for cleanup
> -       test_when_finished "git branch -f topic2 topic1" &&
> +       START=3D$(git rev-parse topic2) &&
> +       test_when_finished "git branch -f topic2 $START" &&

Yes, these three lines are a good fix, but they belong in the previous patc=
h.

>
>         # Test default atomic behavior (no output, refs updated)
>         git replay --onto main topic1..topic2 >output &&
> @@ -232,6 +233,10 @@ test_expect_success 'default atomic behavior updates=
 refs directly' '
>  '
>
>  test_expect_success 'atomic behavior in bare repository' '
> +       # Store original state for cleanup
> +       START=3D$(git rev-parse topic2) &&
> +       test_when_finished "git branch -f topic2 $START" &&

Yes, these three lines are good but they belong in a separate patch.
> +
>         # Test atomic updates work in bare repo
>         git -C bare replay --onto main topic1..topic2 >output &&
>         test_must_be_empty output &&
> @@ -245,4 +250,45 @@ test_expect_success 'atomic behavior in bare reposit=
ory' '
>         git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse =
topic1)

And this line should be removed in the previous patch.

>  '
>
> +test_expect_success 'replay.refAction config option' '
> +       # Store original state
> +       START=3D$(git rev-parse topic2) &&
> +       test_when_finished "git branch -f topic2 $START" &&
> +
> +       # Set config to print
> +       test_config replay.refAction print &&
> +       git replay --onto main topic1..topic2 >output &&
> +       test_line_count =3D 1 output &&
> +       test_grep "^update refs/heads/topic2 " output &&
> +
> +       # Reset and test update mode
> +       git branch -f topic2 $START &&
> +       test_config replay.refAction update &&
> +       git replay --onto main topic1..topic2 >output &&
> +       test_must_be_empty output &&
> +
> +       # Verify ref was updated
> +       git log --format=3D%s topic2 >actual &&
> +       test_write_lines E D M L B A >expect &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'command-line --ref-action overrides config' '
> +       # Store original state
> +       START=3D$(git rev-parse topic2) &&
> +       test_when_finished "git branch -f topic2 $START" &&
> +
> +       # Set config to update but use --ref-action=3Dprint
> +       test_config replay.refAction update &&
> +       git replay --ref-action=3Dprint --onto main topic1..topic2 >outpu=
t &&
> +       test_line_count =3D 1 output &&
> +       test_grep "^update refs/heads/topic2 " output
> +'
> +
> +test_expect_success 'invalid replay.refAction value' '
> +       test_config replay.refAction invalid &&
> +       test_must_fail git replay --onto main topic1..topic2 2>error &&
> +       test_grep "invalid.*replay.refAction.*value" error
> +'
> +
>  test_done
> --
> 2.51.0

Looks good otherwise.
