Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF43233944
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180057; cv=pass; b=tMaT+/u9HyNOh5F32Glaka22WFSUoRKTnTes/wAesD2MRR+l61dYxVl0h5sCZcK1NI8HjWSU41PQTQv29nMjL5khJDl4jHbQHbgcqFr5MW0yL0faMphIq5+jyFGE/9IliwDhoisQIHZU1myGeUCjqvo8aveNinxFcg2baVrZ0Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180057; c=relaxed/simple;
	bh=tAeSGk967WE5YboODOgEltLzGPHhASpTP8jYk1YIXC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ujvk5abiBQs8k56VEHeFM4u6EGf/0yHOTCaawxjXL/+72atvU/j4xcBmNBtsug2B+YY3mWw0j5B5sdK8dBeKsNz4bJH1iYcx/0VDLNEt0jDmfh4rCGBBrXIyAxcpGLvmgFpSiMfWM2OSQ8nouW5oSIAu9liw2fs3oKQJuykKjhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKNYYyt5; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKNYYyt5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9aea40d799so791650a12.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 15:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787180055; cv=none;
        d=google.com; s=arc-20260327;
        b=q0BkhUKLix4n6N7Ieo6H1oMIIMqZ0/kfOqxw10RA8toMv3Vr7UYOnLU8L21ANFT8Er
         aKRRTUaoCoWo2VXUJxJ5GTH9OOhgGG/ePRJUOj4fZN6YG27XDGQ7r5M4/od1VZ2u3b1T
         G5YwRvS/4lGqC2bNEawqldftDbgUXtNCk9d8WC5j6UU18cow+toh4tNYRw50Tmr6AiXk
         BzPBYkk5R0PPxsnlcmC6PPnJRJcLRUFC/I2Ur1En/eVNEtLYsVbgzFA6EZSiuQbHOIUZ
         O/HDREBZ7VLIo4Coni5mPYwjkRfFP53ee6jtV65zfXSBGjnQsMcrXK1Dl5XaDh/eYpN3
         5Muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2z7caFgO7u2FrsEGa4XstRUKdlGBbmWhDu/QxDJ5XuA=;
        fh=uyD4Gf0iW5PjCQV8rP+ZRRbcnURbMS9XmPm0eLcBg30=;
        b=MyDfo5Lmxl1xCsu1Pwi7t/Fpxzvxce6v5qeOoC80jdb/KETX/11T8SNMiVVN3GWEVy
         Uz97pTDbBwFDTJMkmvLQJjvqJHyWSF19a5JfU2Oresq7MeCoJSHYBdWaV64G8oESte6Q
         tgRM4HrqVSQJh1KrFTD66/RL2dd1Oxlb83CZN2jL4A/BvdMORU28OWPfS6o7IbcratNy
         SRU4ptuNl83fz7SOPBb2O/1LzekZuDDtOco4xBestgrvTcbo3tSc9T1fbkZs/tnfBX9D
         o46YZlmbek5yUh7ZSwd+AI1gnXzv7cMXVGMd6hkHFRTh7Q7ClFz8pXIBWQe5k1AXWeym
         OYuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787180055; x=1787784855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2z7caFgO7u2FrsEGa4XstRUKdlGBbmWhDu/QxDJ5XuA=;
        b=PKNYYyt5XitPgA4dWDU8MelE6M3EIeBh74hV7iuRZiIPk1qpSxXa/mj8gI2QUlTMta
         Wy4x+ahgM2km9SkIXXXiCIJhchmjNK3HCsNM8C4t0mJSwYN78Cwko1PG4XJyXREkVTHl
         ASosteo1nmVkWQpXjYCrYHSZyjnHMMC8FZRvnJ4ygH2jM/B/r1MWxMrzzaex0xyy4hhc
         Nk/wA4d7pU7FD14pb1VbyDASVZeMvUH5gWyI+WIEaPpg/1eg7xPnilOrJLxkd+LRwBlN
         tqDJ1AUYNGZepD2shEJ4OS/3wdcCJO1QhCVPFXEI79e56xqy+UsfJ0T20sGFX0mc/EHl
         qBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787180055; x=1787784855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2z7caFgO7u2FrsEGa4XstRUKdlGBbmWhDu/QxDJ5XuA=;
        b=AQeGw3voZWYJBru5TtZ0EG3/LOcI3k7ghQ/p9Inaiggr98lPQXL/Z73THfDq1TsHkl
         C3dLTBmG0gS6J1egmMP4vqacjImX/DGitFCecyBzLQrR81DEBTHcDxNnmi22cuq6N88L
         I6h2vjdj1wlS0W90P54EUdF/+QIZizmmYLzI8eWtbSJfXflk0JvocfDfVe2Q8n4B2g1g
         wROXlvHa3xe0iDJR8Xog3/Kj7dBeARkf01v3XOC06HlSK+Eo08K3mvnE0Endo8J5lnND
         zUsd6RsZMO7aS3KyK3AT1GHARbi+A785CgxbQ6BfALBsk9sD79rmZCK4EFYlR6j2D1pq
         MZ9w==
X-Gm-Message-State: AOJu0YzmKiIWrtFBCKGLVUctY4vJab8G3Kq7JkJ2V4NBWd0NJ8Mc42ps
	E76l8aR821YrDSC0Po2/XO7fXucO8ZW0rvAXlNjK8uJGRgA3ASwnc31LrhN8+U4n08eKMI4BqQY
	nFE+9NMURnYEGPz6H1o29139a2V1jKOI=
X-Gm-Gg: AR+sD13OnhE54foEmzx9F7tFiMOjToGAi8fQTgVL0YqYTNFe24LmsebpuTce85HuGzw
	3qKnasAu1yRyXoculR7jYo0Mjz0S1DSKuUFT+gjX0vljzjQD434a2aEN6F37XzPd4dSi08T7six
	+JCuAiMu0oHtwsjmMOSomGoetuJK/2mJdd6135isLY+DQZUsadf3LOxyIjcJ1yLRUUhml7gNfNr
	h5Kpg23BIPnnw/Mx4MEuQmogtKv7/9QaXy32qatbTaj2j6dlduEnWb4RoHpLrIWPlk0kWs4ltEc
	2nbR3DEfVbE0FYHe7Ue7cz+NPTU8ywju8OPh3plprn3ZpyQbFS08dw5LOqIUy8sBLhTcSpOW5RV
	qgS3UDgk4zyBi2vYDkXf6r85Ruwb6wl0jS9SEbof5TWP+kEHnNcx0qS8Q5dSKQajRd44BVEc7oM
	1WpalLNcz5XV5Dk2yo0tI=
X-Received: by 2002:a05:6a20:2591:b0:3b3:d0f:7883 with SMTP id
 adf61e73a8af0-3cd0108952bmr14383975637.7.1787180054761; Wed, 19 Aug 2026
 15:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <pull.2197.v5.git.1787143859.gitgitgadget@gmail.com> <b838fdabb7cd0d044294d54fd30cb51f040505ad.1787143859.git.gitgitgadget@gmail.com>
In-Reply-To: <b838fdabb7cd0d044294d54fd30cb51f040505ad.1787143859.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 19 Aug 2026 18:54:02 -0400
X-Gm-Features: AcwNN1UcwhJMEUNC7kVKs6vg19ibsg1H9U7DtscP40mSfx8YdXUtROogTBF4-H4
Message-ID: <CALnO6CCQppTnw1Y-6ibmcko0dM3hy8riPanD9BNyb+MW8a5nAw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] checkout: improve message for ambiguous remote
 branch name
To: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>, 
	Yoichi Nakayama <yoichi.nakayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 8:51=E2=80=AFAM Yoichi NAKAYAMA via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> When the user runs 'git checkout bar-topic' command that does not
> exactly say which remote they want to work with, and there is no local
> branch named bar-topic, we try to guess which remote by passing
> bar-topic then create a new branch named bar-topic which tracks the
> remote branch.
>
> If multiple remotes have a branch named bar-topic, we cannot determine
> a single specific remote. Therefore, we provide information that the
> user can utilize to resolve the issue.
>
> To make the advice more feasible, we will provide matched remote names
> for the specified branch name.
>
> To achive that, we add an optional feature to the
> `unique_tracking_name()` function that allows the matched remote name
> to be exposed to the caller.
>
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> ---
>  builtin/checkout.c | 75 +++++++++++++++++++++++++++-------------------
>  builtin/worktree.c |  4 +--
>  checkout.c         | 14 +++++++--
>  checkout.h         |  5 +++-
>  4 files changed, 63 insertions(+), 35 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 55e3a89a85..a2749352e6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1343,13 +1343,51 @@ enum checkout_command {
>         CHECKOUT_RESTORE =3D 3,
>  };
>
> +static void be_explicit(const char *branch,

Be explicit about what? Reading below, a better name might be
"advise_ambiguous_remote_branch_name" or something, idk.

> +                       enum checkout_command which_command,
> +                       const struct string_list *matched_remote_names)
> +{
> +       const char *cmdname;
> +       struct string_list_item *item;
> +
> +       switch (which_command) {
> +       case CHECKOUT_CHECKOUT:
> +               cmdname =3D "checkout";
> +               break;
> +       case CHECKOUT_SWITCH:
> +               cmdname =3D "switch";
> +               break;
> +       default:
> +               BUG("command <%d> should not reach parse_remote_branch",
> +                    which_command);
> +               break;
> +       }
> +
> +       advise(_("Branches with the same name appears in multiple remotes=
:"));
> +       for_each_string_list_item(item, matched_remote_names) {
> +               advise(_("  %s"), item->string);
> +       }
> +       advise(_("If you meant to check out a remote tracking branch on <=
remote>,\n"
> +                "you can do so by fully qualifying the name with the --t=
rack option:\n"
> +                "\n"
> +                "    git %s --track <remote>/%s\n"
> +                "\n"
> +                "If you'd like to always have checkouts of an ambiguous =
name prefer\n"
> +                "one remote, e.g. the 'origin' remote, consider setting\=
n"
> +                "checkout.defaultRemote=3Dorigin in your config."),
> +              cmdname, branch);
> +}
> +

I think it's possible this refactor is a bit distracting from the
overall goal of the patch, though I don't think extracting the
function is a bad thing. Maybe split the steps up into

- mechanical refactoring (no behavior change)
- changes to improve the message (easier to see the diff)

? Just my 2 cents.

>  static char *parse_remote_branch(const char *arg,
>                                  struct object_id *rev,
>                                  int could_be_checkout_paths,
>                                  enum checkout_command which_command)
>  {
>         int num_matches =3D 0;
> -       char *remote =3D unique_tracking_name(arg, rev, &num_matches);
> +       struct string_list matched_remote_names =3D STRING_LIST_INIT_DUP;
> +
> +       char *remote =3D unique_tracking_name(arg, rev, &num_matches,
> +                                           &matched_remote_names);
>
>         if (remote && could_be_checkout_paths) {
>                 die(_("'%s' could be both a local file and a tracking bra=
nch.\n"
> @@ -1358,37 +1396,14 @@ static char *parse_remote_branch(const char *arg,
>         }
>
>         if (!remote && num_matches > 1) {
> -           if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NA=
ME)) {
> -                   const char *cmdname;
> -
> -                   switch (which_command) {
> -                   case CHECKOUT_CHECKOUT:
> -                           cmdname =3D "checkout";
> -                           break;
> -                   case CHECKOUT_SWITCH:
> -                           cmdname =3D "switch";
> -                           break;
> -                   default:
> -                           BUG("command <%d> should not reach parse_remo=
te_branch",
> -                               which_command);
> -                           break;
> -                   }
> -
> -                   advise(_("If you meant to check out a remote tracking=
 branch on, e.g. 'origin',\n"
> -                            "you can do so by fully qualifying the name =
with the --track option:\n"
> -                            "\n"
> -                            "    git %s --track origin/<name>\n"
> -                            "\n"
> -                            "If you'd like to always have checkouts of a=
n ambiguous <name> prefer\n"
> -                            "one remote, e.g. the 'origin' remote, consi=
der setting\n"
> -                            "checkout.defaultRemote=3Dorigin in your con=
fig."),
> -                          cmdname);
> -           }
> -
> -           die(_("'%s' matched multiple (%d) remote tracking branches"),
> -               arg, num_matches);
> +               if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANC=
H_NAME))
> +                       be_explicit(arg, which_command, &matched_remote_n=
ames);
> +               die(_("'%s' matched multiple (%d) remote tracking branche=
s"),
> +                   arg, num_matches);
>         }
>
> +       string_list_clear(&matched_remote_names, 0);
> +
>         return remote;
>  }

[rest of diff snipped]
