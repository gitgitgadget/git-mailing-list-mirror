Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793996659;
	b=uHZQ2YB3Ef0J0Y2TzTIZkQ28GwjRuFNVRlqdEgQlt6OTHRzqJQha6X1SGOD3EWyqb/0r
	 6+L3R1X515H95L6SSz3Y5HT4sGyXDnUMkSJB0QwDpr8T7lGNyowcT6d/wegK8eUw155pV
	 YVF5Lt4yGgO/MA935u9c04wTtkML8SkvRFU+HDYDEUsNjdFxwpdag9V+rBlpxKLYC4mX6
	 q08/uqhQGq08xYzsA7cc02zlGAa/+wJGsHx8YVK5c6MXXycLBs50yw+Z90nITmI+XK0NH
	 Dr+lWWX9RJvM+iU3gowgeKLJN/7P2rcJe4se9awbQmteIP+jq1lt2cmFPgfF/x4z3SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1sMuSZOiU+0aCp32xb19R3gYEmHFW506PwWA99jTJ5E=;
	b=zhcdhpxSp78uzj8VFfRqGoZgGd8k7AT0LoJPSf8jPakRQwRmOUsDQsFJyPxXdtet+zSr
	 ikH0XyJALDi29JFj3IK6RJzCPh2vTU6pLs2GinDFZCHdYPMrTvBb89UthWIsMosxt3m7s
	 CoK3XKKRbuoobuGUkD9ikp04sw7iPmoT9UXxRYTt78Y9YF6Ecum3V1IbNUhma8Diln+5k
	 ITXe+T1Pwky6ct6NVbJ6iC3fABgcuPH+aiiEXVZRfb/d5fW7yeKwmJndKXbZMZiDztnXC
	 AOsl9/RGs6SZrg1OW5hcmgdYRxQMFr0d8mP61hnT78RC4R6xu22VqRgoxwX8QuYaLAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWJNTOak;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C476606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C476606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWJNTOak
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so1565858c88.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 12:24:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793996658; cv=none;
        d=google.com; s=arc-20260327;
        b=qU/Qq0DjeF4xJgYIa7qNHVyp37nURsVH/KFl07ZPf8wBrnzIjOLqqL+XkAii9MVyi0
         +DNEvPTPDZnFzFgj838N5qExcMMxK3CkY+juyetoTeTPZfxzB0Ifbeyld6waPoWMEsiu
         W77xGfvY5eWBlpUCJJpW19tKMIcEvd7Bbzcy4TkVEavLn2wKIRwCpmppvoz+2Teuk/HY
         ktlDXZquCFPSAhia1YQPzZzVlDNZ0WryTGUrxfUg2FhOQXTPzgmYoBoWYY3Zj09HcS08
         8jM4kuw1WlYdGRz0pAveOInuWsaBigjcodLZ1SiZOgEmdd3AVDMpdmCDgbXKQyeOWsRe
         PmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sMuSZOiU+0aCp32xb19R3gYEmHFW506PwWA99jTJ5E=;
        fh=JpoxCm1brqk0+q2yYxreOn1plhWTfNjuLbSe4K2/kl8=;
        b=r/zfcXe81VKrdGphcn40oMdPFCnhHclGTcBPKlGWiNl++PI3595HILJgKExNAhUg4r
         dwIqF7+6kPbBl40Oh578/PEVEVmjVo6Rw0ICEqAqGo7KzIw9JX6KfARaqGXgSwmygy2i
         LS++7B9O6oCqxnEfDTEbzkkEFq2ppIVLkHAsM0jePqTpMnJ07adc+uH35XFRPiXRE/sj
         2cdcelBkv7M3MbuZXK7xnHHkcZC037DaBtcZN2rSYr8GlFYgA3OJ++s5SOHhYmfBttXR
         0t4ubhzN6FG4d1g3vEFjaNDhPqXO6zC68sK2cqSyadjc2R6fZ/ythv3DLu2anwBV2Mgs
         qavA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996658; x=1794601458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sMuSZOiU+0aCp32xb19R3gYEmHFW506PwWA99jTJ5E=;
        b=UWJNTOakAnGuZLYcQ5To323MDp9o3Vc+pRCC5S/HDVfjk5OArMf7Z8MuP0UoxCTbKi
         LLzHFhjaCc+RLGStbXbZ5xYClQQ4HS71H10vDX4yFIW+OXLWFE7l+MIFM1SEc8braod3
         QzKh6+wnunrg45cZV8UW/oghyeBrccLOnck42yo6jCsJVJaNVjROxg9VTloPhRc2wB5w
         MGgdb3Z1ug9LPqX55BbReAHe9P9knJK5+YPoR8XFHSSbqxziJDVRaJ8wxU5t84lTqvid
         tM7F9OMuNPhlp0mo5Q4Uo5WdO8jcqyUt7VebAoD3VPlG+9p5w3/SP3YaGR0oExosp0k7
         b1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996658; x=1794601458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sMuSZOiU+0aCp32xb19R3gYEmHFW506PwWA99jTJ5E=;
        b=aSY+Y1JHDnGAekpU9FgQLIYhOt9F5FQIRZxvQ74YQDEVjXMectrdle9LQ6xGwD2Ud6
         I1iAaBgZ7hNXNTRFB76T/CWnyaNkWums7SIBOsEJu+HMH3iALIhU2TgobaK5M6qzuFr5
         /uNSJwVnKLmEnJkqMmvYVKx9ZDmgc4B2v4ToCrf6gp805Ci+r++R1VPyaRD1cimGWRPu
         qXLlSXX+Dj9dxXwppB4Aas/s+AT8v6/LoGyMtDzm2MThYPKttUrBJ6lCbkS0UGTVCEqP
         dAW6bwEBSCLN3dofvtMuTuF2MkzDxtCSFrEVE40M1Gi4hI8hJiBo3I3FZgY20d5nCabh
         85Zw==
X-Gm-Message-State: APuU4Z8yAyaaEiZzz3+S9UcGRZ4SaMu/xiGoabqRl/jvP9OGhZNi/d2O
	BZQeILfOuksW5wVXKFALY2xkP5RpRWj/DZs2XyRS6n7zYWeucB0mAVAGJ8H/Bhtqic7qUYLAc2Z
	CHr/eNj0/UjAPsjikaEN80ci1/EuyUwQ=
X-Gm-Gg: AYBFou1f20uV6rwhUBrMl5m55smDvY4BnvN66kpdWy39c/v9gg7oXIDhu3s0CGhJfvz
	YIZK+w0IVq0RpVa8A/Ws7Rpqn9gWXbzXgBzlRQcwuyE2FD+1MlZ0g9TQmUoJ0xCJ7PRiUu7EDks
	ILilwt0jjuUdwH8AR9CJLb870Bagb4EDaiVyzq7Je2TtptOdFr/V4bZtQnXfgvYTkY1FPw9Xi9+
	Dn3v8VdSnji2tj+7iNYOtNuBY5uWmVjQE6jjdI4i/fCjc3UgdGR/KZmiMQ+bZOe2M/apOOW7a/v
	8rmg0q1uBnmCAIEOfcn3S47k25vrstnMJisIaQffuf/2ntRlheN8YgE0UMq6h35olwU6ZQPPCH2
	uVr+L5YH3W0ifkYWc9com1qyL8DnwrJ31pb3Uev31Bntgv9/FUCJmmVKvq8j67iUagE7bbFOMgJ
	mdDSHvGeIK5C+zqw1KxEA2xTmJrl+Z2retRLtkKp3M0jzIemeXfsf+MmFZMLaLJ2rGLlejqHb6t
	ENn3YqfsKK8Lq2kLBPV7oVU
X-Received: by 2002:a05:701b:4544:10b0:14b:cf58:ce15 with SMTP id
 a92af1059eb24-1b25d36093amr3967899c88.43.1793996658359; Fri, 06 Nov 2026
 12:24:18 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101210623.622-1-herroyalpriestess@gmail.com> <20261104025340.7799-1-herroyalpriestess@gmail.com>
In-Reply-To: <20261104025340.7799-1-herroyalpriestess@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 6 Nov 2026 21:24:06 +0100
X-Gm-Features: AclHuK8m03P4VSjBfA9VPK7WS4ATg_bu7cJdJCmTvHqOQFupi24y6oVCcqVke78
Message-ID: <CAP8UFD0uA+zF4x8WBRA6sGxSGX52Nw=GFBznzdFnX3SptHDUcw@mail.gmail.com>
Subject: Re: [Outreachy] Proposal draft v2: Improve how command arguments and
 options are scanned and parsed
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cynthia,

On Wed, Nov 4, 2026 at 3:53=E2=80=AFAM Cynthia Uche <herroyalpriestess@gmai=
l.com> wrote:
>
> Hi team,
>
> This is the second draft of my proposal for "Improve how command
> arguments and options are scanned and parsed" for the December 2026
> Outreachy round. v1 is here: [11]. I would appreciate
> feedback, especially on the candidate inventory (section 4) and the
> timeline (section 5).

Thank you for your interest in Git and this project.

[...]

> Why not make parse_options() do a dry run? Because it would be a much
> larger refactoring. According to the 3/4 commit message, a dry run
> would have to avoid writing through opt->value, calling callbacks,
> dying on invalid values, handling --help and tracking command mode
> conflicts. Junio has said he would prefer this in the long term [2].
> The scan is simpler, and it keeps the option array and the
> PARSE_OPT_EARLY marks, so it does not block a dry run later.

Yeah, improving the early scan can result in refactorings like the one
in patch 2/4, which could make it easier to implement a dry run in
parse_options().

[...]

> Why bisect and rev-parse were dropped: Junio said he saw little
> practical value in them, since he doubted users would name a bisect
> term or a --default value "--", unlike fast-import, where the bug
> affects a safety check. Christian removed both patches in v2 and said
> that bisect_start() could use the early scan once it has been converted
> to parse-options [2], [3].

In https://lore.kernel.org/git/xmqqmrt7c1zf.fsf@gitster.g/ Junio also
said detection of "--" could eventually come for free as a side effect
of using parse_options(). So not sure an early scan will be needed at
all.

[...]

>  - git column (builtin/column.c, cmd_column())
>    It already uses parse_options(). Only the early step is by hand:
>    if argv[1] starts with "--command=3D", config is read with that
>    name before parse_options() runs, and a die() follows if the
>    parsed and scanned values differ. Observed:
>      git column --command=3Dfoo               works (exit 0)
>      git column --command foo               dies (exit 128)
>      git column --width=3D40 --command=3Dfoo    dies (exit 128)
>      git column --com=3Dfoo                   dies (exit 128)
>    The three failures all print "fatal: --command must be the
>    first argument", even when "--command foo" really is first. I found
>    this rule only in the die() message: searching Documentation/ and
>    t/ for "must be the first" finds nothing related, and t9002 does not
>    test --command.
>    Fits: replacing the scan with early_scan_options() and
>    PARSE_OPT_EARLY on --command, once the series is in next. I have not
>    yet checked whether any option in column's table would
>    make the scan stop.
>    Risk: user-visible change (errors become success). Question for
>    the list: is the "must be first" rule intentional? The callback
>    receives pos, so it could be kept (pos =3D=3D 0) or dropped.

`git column` is "used internally by other git commands to format
output into columns", but `git tag`, the only internal user, doesn't
use `--command`. So I guess not much effort has been made to make it
user friendly (which include allowing --command to not be first and
allowing `--command foo`) because it's not supposed to be used a lot,
nor by regular users.

The "must be first" rule also looks deliberate rather than an
oversight. "builtin/column.c" has the comment "This one is special and
must be the first one" above the scan.

>  - bisect (builtin/bisect.c)
>    bisect_start() has two hand-written loops: one looks for "--"
>    (the bug of the dropped v1 patch) and one parses --no-checkout,
>    --first-parent, --reset-when-found[=3D...] and the four --term-*
>    options, each in a "--opt value" and a "--opt=3Dvalue" branch.
>    bisect_run() checks only argv[0] for --reset-when-found, and
>    bisect_terms() compares one string with --term-good/old/bad/new.
>    Fits: convert to parse-options first, order: bisect_terms(),
>    bisect_run(), then bisect_start() as a stretch.
>    Risk: bisect_start() is called from "bisect start", from
>    bisect_autostart() and from "bisect replay"; the original
>    arguments are written to BISECT_LOG and replayed, so they must be
>    kept. Abbreviations and "--no-" forms would start to be accepted.

It looks like bisect already uses parse_options() but only to dispatch
sub-commands (OPT_SUBCOMMAND() with PARSE_OPT_SUBCOMMAND_OPTIONAL).
The sub-command functions indeed don't call it

>  - check-ref-format (builtin/check-ref-format.c)
>    One loop over leading dash arguments handles --normalize/--print,
>    --allow-onelevel, --no-allow-onelevel and --refspec-pattern;
>    --branch is special-cased as exactly argc =3D=3D 3; anything else
>    calls usage(). git.c lists it as NO_PARSEOPT.
>    Tests: t1402 covers --normalize, --allow-onelevel and
>    --refspec-pattern, alone and combined, and --branch (also from
>    outside a repository, and with the name -nain). It does not test
>    --print, abbreviations or "--". Fien Dora's patch adding tests for
>    the precedence of --allow-onelevel and --no-allow-onelevel [10]
>    was merged to 'next' on 1 Nov and is marked "Will merge to
>    'master'" in What's cooking #01 [6b]. Her commit message says she
>    plans to explore converting this parser in a separate series [10].
>    Observed on origin/master (v2.56.0-307-g50fe5cc63f):
>      --norm refs/heads/x           usage text, exit=3D129
>      -- refs/heads/x               usage text, exit=3D129
>      --normalize -- refs/heads/x   usage text, exit=3D129
>      refs/heads/x --normalize      usage text, exit=3D129
>      --branch -nain                "fatal: '-nain' is not a valid
>                                    branch name", exit=3D128
>    Fits: parse-options: OPT_BIT for the flags (--no-allow-onelevel
>    then comes for free), OPT_ALIAS for --print, and dropping
>    NO_PARSEOPT in git.c.
>    Risks: commands that fail today would succeed: abbreviations, "--"
>    and negated forms such as --no-normalize would be accepted, and
>    so would options after <refname> unless I pass
>    PARSE_OPT_STOP_AT_NON_OPTION. --branch needs an explicit check
>    that it is not combined with other options, and "--branch -nain"
>    must keep failing with the invalid branch name error (exit 128),
>    not become a usage error from short option parsing.
>    Question for the list: is accepting "--" and abbreviations
>    welcome, should options after <refname> keep being rejected?

I haven't taken a look at this, but I saw that Hussain Sitamouwala
sent "check-ref-format: use parse-options API" patches.

Thanks.
