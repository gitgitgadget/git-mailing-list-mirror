Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795591891;
	b=G9tgjVBCvJgVkja1l9qrJChuQZt7WS0WROk7ybkZBUQ3H8wc4G0rYacB828kr1Tb1Wyg
	 x5Y9rE6pGj1mqJxN4roJgQ7p236QG8MwP+m6wG1KMI5HlVDXiOueUEXikzbVX4WMlFadW
	 W8JyEvoxG3xKYE6ModeNJ8/M2g8+fFLilfWDMzt+GPH1YZ/RvKF2MjvTjhujR0loK9/Me
	 n8i9JiQ3Cy1SGizwVefOeb5Kp7lLdz5efE3FROkZwKRjqzAYV6pVIT4x3LgXwCHE+/iH3
	 uBNUXdeGAHdMQETP0QU4Ui7L3hY4FkB56pH7P5Oa08QLOl7c8djCHIPfSXFrdsSKYfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NzG/0XP8i4XF8St2lFyTXtPaqYHS/X//7acUPxUOlZk=;
	b=cDQJY6PlEqC9LEaEm0UcaVLO0eDpW2FI1C//+XStlQwFP43PsFX2qmAiKXJQB8Kyhgm3
	 ncw3sDYMEJhpON4Wo5HAYgqXpbhTlF6Fr1RCDnWu34225tHOBnEvGjHA0A7+vSJh8LwK4
	 qorP8/AdfWPwYoqUK9jfGOljb1gxNyEcK461+KdzrNkb8P2AWMs0uyP6zmXBWQPRqvM0H
	 1RoJ5OtL8Y0xx/NqArn/UNjiCg+vDdToSa7mVaHO3VhlOPOAntg3ac89bZtVlbO2/oujL
	 2l7npFTioL4hbdWYVT+sWkIS6PMNoiHztw6ulDxvzI1AprREb+cJBVnFGs5jHFlk5DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfOxUD51;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041A606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 07:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B041A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfOxUD51
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71b30ed75a1so3137266eaf.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:31:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795591890; cv=none;
        d=google.com; s=arc-20260327;
        b=kvpj6ofDoc5cfg/OsuiyQsIeOeIzFzm5CroG2Kyl0lqdSA7TWX67KrgiPb4a6kOlS0
         v/ryXGM/xtJCl8hL4KdzYNnZKbvcVo3cst0JoVEssziMZ4C0fnwpgbIhQAaEDIiqawJ0
         b5Hxjhya5IL7QVo8pEQJCCZ/23DDDsOAeHcORpeY/Ncz834srzUJScrU0jTcvHujc5GV
         U0GBh/an82b6FKE3fiqgNwjp1BfnZiu8KRmzlZ7OVwzHenlUkUcv9lQ1faCujVyrizcf
         j58x26w+0B8Oram/AU6uiibp/KPK/1IRpvZ3HQTl67xZdwx23SphYBuzuVz6aKj4Mv2A
         HmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzG/0XP8i4XF8St2lFyTXtPaqYHS/X//7acUPxUOlZk=;
        fh=gXmOIgH0oM3c2mdQuTqFFQdbzvnvkOfYU0t7vy0otQ0=;
        b=Zo7cFsNMSxQO9JgGQS4l2SGUpRdV4SK4dEvB8VJ3NY2kfx1TSzN9QKrkYxQYdUJzgO
         5LQM1V+hbLIlCEB8KrVXZiIkUOT3JzkbmLahFnoq1SNIzqJXbSMcUUVtkJyMgcH83DMr
         nGZQkSe4YGK78lnRfteffE0bjIvv52B5EeG7DoyJXYlyPuYNr0y4vMnHuCxSX4Q/nvSv
         hCcKIExDv+G1EN0qYriLatbAfH9VBLzv8FQgU9RQRXP9TtE8/5kw9VC/IOXdgfoiwkBv
         lffYtRMn0nrgi0yA/GaGJyWaD9eXOMRTR3b6ug8ccuIu6PEN0p/MK1J+X4jJVqj+/qZF
         0OlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591890; x=1796196690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NzG/0XP8i4XF8St2lFyTXtPaqYHS/X//7acUPxUOlZk=;
        b=JfOxUD51jWBZUBhF6fwuKAFfxay4abExm9mK3zkurbkwRl1rRVPDidVn2h8Nd1x7Ey
         sXx2p9S7vfpSPi3+Wg/CVyN828Homgx6Ao+dFPTyR57GoBD8Q7AlDjCYMqZ6GfbYSPUG
         Tg2vo5k8M5CVpemEzyBMLWR3cTcaq3qIV1PiAzfbpaA40zjou8vVHtDEgCjMssAxHIbY
         QeNS16V4VjjKv9u1jGrdwvmSrMmMqULJQXg0w+awZhfoBwS96L9D37MRtQmzQGgJBVOr
         iAw33Z12xLDYp9rNG+HuennNHgdSYaG1Qel9uFyjHpft7uBVpNBU8ZjJymGt8fKQgctw
         Gz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591890; x=1796196690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzG/0XP8i4XF8St2lFyTXtPaqYHS/X//7acUPxUOlZk=;
        b=eUDiD0MzBv1cgrb/1f3e8AyM9dTl1cMgR2yCI0SapH+hx3F5h2ss1YlxUux4B/tp5y
         jgmdC7liyshXNEcWSChXGasGSwztT2Ke1Zdo/pjxtn0jwda5TrCX80jv11zrHN814SPp
         BjApDUHA3xY60TuOnuJSTWhYAvdbPRFc/lxc8ExCLjXQTKN7D1uPoouY7Z0+gM6dJ9+Q
         ngXRqMDpKOwdEtM+4vANVUhMHZBBUwSETL+kjlSoOxEf0t1goXRMpv5osnZIqsBhayha
         xILuea8ZXAAmQ2sp6zx/U3C7SqIF8ob7U4SQnBRVcu5SGWDef5/MaKq6lPhYxAoqRm+H
         xjvQ==
X-Gm-Message-State: APuU4Z+uIEvY2dsXGqw1AquJqmMy3FzsxTw3KUdSTKI7HQDo+bTf1Jk4
	e1ZfeLfpfnXbmSKiTxWr06xEXYnRPplyx+KSwfiQktFl8jngUgGdfK59QfZ59MnIUOv84yaIiMY
	70V1syMLYlmNCWwTo36y+D7pDLjjH1gk=
X-Gm-Gg: AZFdTZfSC4IeKwqV8dtPREBKy3rT4LEES1QCDuXPTyEyX2lHH3KX5d/+OOL7mBPyB64
	3zbOomgrJt6OFJt6YzsWlRukKi80fM1z9EV9xIsykMbLGkk9/AwigY0SO7PVT0xsZBbpzDHN7Sv
	Al3L8Qhok35jPOEiVdNLyOQ9cP9mQPkYbyJpxPv1vwN8HZlorcDRlEQAse12Q5TBAUnzbY5y0UX
	PKhNBPXumnclHiKUVo/QeHO3JVAG5MPEYFqByAtXLJTLGrxp+8UXRhlfW1NEFAfZddQwNS8C3X8
	0qle3x+CF7Ay5of7sD0wG1mvZWWP40Uu8+E4+uXTXhLBDiWi/ck3QpSOi49YPsVp7QzIwI7s1I8
	r7oGVcUDyvp0d2rn/l0rVr2ugEW3Hj64OCg==
X-Received: by 2002:a05:6820:f004:b0:71a:fdba:b6a with SMTP id
 006d021491bc7-71b39552c2amr17386768eaf.69.1795591889620; Tue, 24 Nov 2026
 23:31:29 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120113233.783523-1-agab0323@gmail.com>
In-Reply-To: <20261120113233.783523-1-agab0323@gmail.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Tue, 24 Nov 2026 23:31:20 -0800
X-Gm-Features: Aa3M54orEiJ96Dqg3SLMR4DANqXAzKD5yol5Z8HslBNie9wZOf6tNRZctOdx75Y
Message-ID: <CA+P7+xqzb+D6y3HZ0A18VucWsqGo1Wi9giRzkdaXrpiu6QbwBw@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: check 'update --jobs' like submodule.fetchJobs
To: Abhishek Agarwal <agab0323@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 3:34=E2=80=AFAM Abhishek Agarwal <agab0323@gmail.co=
m> wrote:
>
> "git submodule update --jobs=3D0" aborts:
>
>     $ git submodule update --jobs=3D0
>     BUG: run-command.c:1574: you must provide a non-zero number of proces=
ses!
>
> "git clone --recurse-submodules --jobs=3D0" passes the value on to it
> and aborts the same way. A negative value fails with a confusing
> message:
>
>     $ git submodule update --jobs=3D-1
>     fatal: data too large to fit into virtual memory space
>
> Before 51243f9f0f (run-command API: don't fall back on online_cpus(),
> 2022-10-12), run_processes_parallel() turned any value below 1 into
> online_cpus(). That commit made 0 a BUG() and moved the fallback into
> the parsers of fetch.parallel and submodule.fetchJobs, which already
> die on a negative value. The list of callers in the commit before it,
> 6a48b428b4 (run-command API: make "n" parameter a "size_t",
> 2022-10-12), describes "submodule update" only as a reader of
> submodule.fetchJobs. But its "--jobs" option is read with
> OPT_INTEGER() after the configuration and is used as is.
>
> c39952b925 (fetch: choose a sensible default with --jobs=3D0 again,
> 2023-02-20) fixed the same problem for "git fetch --jobs=3D0". Do the
> same here and use online_cpus() for 0. Also die on a negative value,
> as parse_submodule_fetchjobs() does for the variable. Negative values
> meant online_cpus() too before v2.39, but they have failed since
> then, and rejecting them keeps the option and the variable in
> agreement.
>
> The documentation of --jobs in git-submodule(1) and git-clone(1)
> only says that it defaults to submodule.fetchJobs. Say what 0 means,
> with the wording used for "git fetch --jobs".
>
> Signed-off-by: Abhishek Agarwal <agab0323@gmail.com>
> ---

People might disagree on what "a reasonable number of jobs" means and
not like it being equivalent to the number of CPUs, but its the same
text as git fetch and I think it is an ok enough default (and often
the expected kind of behavior from other software).

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

>  Documentation/git-clone.adoc     |  1 +
>  Documentation/git-submodule.adoc |  1 +
>  builtin/submodule--helper.c      |  6 ++++++
>  t/t7406-submodule-update.sh      | 20 ++++++++++++++++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
> index dd3b44817a..a64084488c 100644
> --- a/Documentation/git-clone.adoc
> +++ b/Documentation/git-clone.adoc
> @@ -375,6 +375,7 @@ repository uses a non-default object storage.
>  `--jobs=3D<n>`::
>         The number of submodules fetched at the same time.
>         Defaults to the `submodule.fetchJobs` option.
> +       A value of 0 will use some reasonable default.
>
>  _<repository>_::
>         The (possibly remote) _<repository>_ to clone from.  See the
> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodu=
le.adoc
> index 57a21bc8d9..8abeb69cb2 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -465,6 +465,7 @@ NOTE: See the NOTE above for the `--reference` option=
.
>         Clone new submodules in parallel with _<n>_ jobs.
>         This option is only valid for the `update` command.
>         Defaults to the `submodule.fetchJobs` option.
> +       A value of 0 will use some reasonable default.
>
>  `--single-branch`::
>  `--no-single-branch`::
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 461b682d0d..e06a724ad9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -37,6 +37,7 @@
>  #include "wildmatch.h"
>  #include "strbuf.h"
>  #include "url.h"
> +#include "thread-utils.h"
>
>  #define OPT_QUIET (1 << 0)
>  #define OPT_CACHED (1 << 1)
> @@ -3079,6 +3080,11 @@ static int module_update(int argc, const char **ar=
gv, const char *prefix,
>         argc =3D parse_options(argc, argv, prefix, module_update_options,
>                              git_submodule_helper_usage, 0);
>
> +       if (opt.max_jobs < 0)
> +               die(_("'%s' cannot be negative"), "--jobs");
> +       if (!opt.max_jobs)
> +               opt.max_jobs =3D online_cpus();
> +
>         if (opt.require_init)
>                 opt.init =3D 1;
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 10adeabf0f..2b5551044a 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1096,6 +1096,26 @@ test_expect_success 'git clone passes the parallel=
 jobs config on to submodules'
>         rm -rf super4
>  '
>
> +test_expect_success 'submodule update --jobs 0 uses the number of CPUs' =
'
> +       test_when_finished "rm -rf super5 trace-jobs.out" &&
> +       git clone cloned super5 &&
> +       GIT_TRACE=3D"$(pwd)/trace-jobs.out" \
> +               git -C super5 -c submodule.fetchJobs=3D1 submodule update=
 --init --jobs 0 &&
> +       test_grep "up to $(test-tool online-cpus) tasks" trace-jobs.out
> +'
> +
> +test_expect_success 'submodule update rejects a negative --jobs' '
> +       test_must_fail git -C super2 submodule update --jobs -1 2>err &&
> +       test_grep "${SQ}--jobs${SQ} cannot be negative" err
> +'
> +
> +test_expect_success 'git clone --recurse-submodules --jobs 0 uses the nu=
mber of CPUs' '
> +       test_when_finished "rm -rf super5 trace-jobs.out" &&
> +       GIT_TRACE=3D"$(pwd)/trace-jobs.out" \
> +               git -c submodule.fetchJobs=3D1 clone --recurse-submodules=
 --jobs 0 . super5 &&
> +       test_grep "up to $(test-tool online-cpus) tasks" trace-jobs.out
> +'
> +
>  test_expect_success 'submodule update --quiet passes quietness to merge/=
rebase' '
>         (cd super &&
>          test_commit -C rebasing message &&
> --
> 2.56.0
>
