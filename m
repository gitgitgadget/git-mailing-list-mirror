Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673108;
	b=4xZKplrJG7QcXL3ZQW2x+qVxtWo6IWxvlJfYcTdC+E6XzFJkNxLnkzap8dtjKQ9fZZgq
	 zAn6ChoC8T94DRXRL9HyAr8r+2j9Lcm040seLligW31s7Bv3AQlt0d1QpGmkNvjGw+m1L
	 JC2/pFEtIjEEAX0P9+QsCasgJxf2NKcGQWebxeg39K18Y+iqB8E8vnUxk8DSW1b+JEJG5
	 P36wcqXsDeN25NbDH4x4TS1XTHuwN0wulmWrMIOW3uKn3rSXWpdJA0rP4R6jb+1/LwbYh
	 swShNWP11SD4iEC+iKcA/TMZQhUCXK8RBhsjBzl4XovOBzQYLgRvp5wc1CzdBoSXyuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=if3JAJW0PQVbKPk155GrX5HhgROFSrdentrwsKUbmLI=;
	b=PF6s6o7X0nX8I4/cUPKFxYlTtEd+zkMIWDvh8lIdjjpbE0yCQlQRKuyn3KGkjSaRxDAp
	 F/z8dj/PuMaG+uWQAhGicJL9z57xNyKMBXDg8IQQhDl+csrGm369QilxPyJuEBwQ9w2MX
	 T0s67k3OLCuxgOT/IhcNeGqjz3hIkHUvVruaRbRk5zDmEYRTJ+AI0Zd/7k4PoT2rasNZH
	 ob+EneIICnPe1SeWE/d3eA6PEfbO30YydLwGTS+rNeeqtiNutpsbuFepk7/eAfJM9qVgn
	 pVathLBMqzRuecoY8QAme8Q1vpz2b9joTzSI3H//e+YLC4DwYdP/jpfqautmP9RoqKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1btTlCa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0E606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA0E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1btTlCa
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-843b6f8e2c7so4764752a34.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 18:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793673107; cv=none;
        d=google.com; s=arc-20260327;
        b=lAx1lsaz6L/4uZ1J6dVwKyl4zWOFDl3EYuqFNLclRyNLljMkEbiW6u3cyGTP8MToWL
         I54EsXvlgk7DXxkqDLRCGPCxot6by1y3QWrmrmk55jE54E+dvhKvryfLvtma4izUeFbl
         MrQzE1c84Kb+I6UV96F0aN5YHdPiTBs5DXFnaFXKCMJBewr41t0r5RvnsuS3fgHSVkTA
         JRxi/wF74fuLZd3CAyyfTIGM7dkXqgAktgJv9ulvzUOqNgkhUdsImimNPYrbULUOh0HC
         hli8vvG+lilYMH/u6b1oTT8wc1pioUeMGjpMMvhtOtEz4eMCFe/Y1LiBveF69f7hzqDp
         LvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=if3JAJW0PQVbKPk155GrX5HhgROFSrdentrwsKUbmLI=;
        fh=mv5zqN92u4yGkXYcJT4eDsfhsA+TdzFjZ8yY/QsyRCY=;
        b=BrDrCx2hLLoXAJti4npp+JQfyFTnw9VbkHN/Nl59O+6SWzw8qfZS1DrnJ1HCxixEhk
         aZ3NRi65INVAeaMwp6yqTTyQS/m6l0M5Cb2YYIpXrCcKPY4uZysdM5vb0uX3oCwqcfYH
         EcllUgSgGyzeqJ8JfQXH6bea3bujvhP1YnoubW1ckP0sR7s/a/Hu/dizamuddmBw3XFK
         8LhzGKpzeoe6o9y0guFm8I2HdMrCYihXID/A1aH9Yj0Ff+BGeKmga/xLz1jpiSHA6V2e
         ql8yKeR/okXIsf5SJuPCBdWKT8KpM+3BT9hltkjqH6126ktNl0l9eoH+GTIZIbRRTMWx
         eqoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793673107; x=1794277907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=if3JAJW0PQVbKPk155GrX5HhgROFSrdentrwsKUbmLI=;
        b=Z1btTlCaxt2ZBdBgBXuNwBU530GiB1WEWIZFGLzFTUtJiUyjRvSOC1q3ZZAVvtc9TC
         gpRC4behEU9AOwRcnDaUHhuYiO5lCKzwRCzniLQZc0QAEjkS7pLqsVb2eYi3RYG1Eccl
         DiaqWGvmxWhOLidoyJ5UrraENvqgSPJT0m/b0T9b9r/KccmwyN/jxUA4DAgIGpEZ+9bC
         DES3wleirXMRHHYvHFo3liALHhvFXMvFCVmISRSSkqtLobzHB02eocZKCMzjZUb2W5vU
         gLutV7bxcJ9d5f70op7llCQHZNp3Z5thUUXgNiafNDZ4DcCbKxrdkZhRwzGu6c5gyaJh
         TZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793673107; x=1794277907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=if3JAJW0PQVbKPk155GrX5HhgROFSrdentrwsKUbmLI=;
        b=DHUEouhTDqi61UPtQArMp14N27IfyC96uu+UjdNxb2pe3t4Vza7OrJEmFCyfmMGNr9
         tR8R018hGH0dsiPYUIi7Hn0EcY+0CA9uvOReaI9E3eRB0qCMJKGtkppFODD5pCwj5n/Y
         qQPjhZrrYpQiFupn+9TgAG23eMtGLRJvSH849i06N1Kjmv6COjMdevm1x0EbBfQiw3kT
         3iLkPRgZcjNIuBBCeNV7kJBlJKQYkORfL2P3bp4g2/mZ6Bc8ib2qkJk1AwtsiRj3FQZz
         kfOCd34eG7izZdxToUoxVvmIPyC/5CrUDA1Jvt9NLOyJBh6JKAk4TMnTWeZypA1a1xQY
         jnOA==
X-Gm-Message-State: AFq9FYJUOXS/vHcBMJMY0x/YEemM+19hP99HlXNNpRV9hhQIkzgv62VR
	8RTOvCQiq6ydlIS+1as9ZuNrWGP76oZZCP5f95ny7zpMUYj9wZZX0JufhUHN7ewqmH/up5PXdMT
	fXyuCVfHUP6AEG81xtbp0wFVKwmZy00Y=
X-Gm-Gg: AYBFou1sYFQJZk/OQzAPkGipsKrhj3ewYdO5c9zH5b5eK01YTNTNiU7YP0BlycStVbX
	RW+eBoUFEaTed0oM1lQ9VGlydNExYYfygjcuZwXHzaHTRsOGtf+5t1Ig1KGcT6kGSMSwCHRaRnA
	ROfLzm9nSPij0+Wqc4ebLpOwZz0lpp5KspQ4D3XIJbCQJsUlRzkJbkPMPcnLgdK+A72tdeesH3U
	zzXQNxd11YiZJnx4RI7u3pbNubJGSfmE+PcKTBZXfALMCxwC1ZSez8FERY2Jjd99fhgF/4vpnl7
	SzBF0+or4CZySo3A1a6Ws/BaopxTjv5gDu3oCDI56LQOu5DEcKKJ21zIO1eUTOmuXRhmo45wVbw
	85hfikhfZT41quT33qb/+KsAnxpMqBI22VwII1CT+CnDSMmCzNvrhi6kAsGu+9Tk/svTynpLiRV
	n+oWsVzSPzY5H++s32dSeuMXSZL1o84MGA4smkUiBiS7iLu1pmFWOaAU0=
X-Received: by 2002:a05:6808:238c:b0:4e9:df3c:c45c with SMTP id
 5614622812f47-5640dc207femr8242935b6e.19.1793673107249; Mon, 02 Nov 2026
 18:31:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-5-jayatheerthkulkarni2005@gmail.com> <aukHlEd5udC1gLYZ@denethor>
In-Reply-To: <aukHlEd5udC1gLYZ@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Nov 2026 08:01:36 +0530
X-Gm-Features: AclHuK9ZvWOFyPtXrT_kJKR2_52jzQ9HH2vprb_kujkcNbDV7-mewnwg-zlVUXE
Message-ID: <CA+rGoLeSfwSQs6hOyGxjRhyCLqjWBMQ4yfXUYWiCz+MHqsgWAA@mail.gmail.com>
Subject: Re: [GSoC Patch v7 4/8] repo: add path.hooks with absolute and
 relative suffixes
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 4:02=E2=80=AFAM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 26/09/27 05:14PM, K Jayatheerth wrote:
> > Hooks are an integral part of a repository's configuration and are
> > commonly used by tooling to automate repository-specific workflows.
> > Currently, scripts typically retrieve the hooks directory by invoking
> > `git rev-parse --git-path hooks`.
> >
> > Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
> > `git repo info`. This exposes the hooks directory as a scriptable
> > config-like key using standard format rules, allowing scripts to
> > retrieve it through the same interface as other repository path
> > information.
> >
> > Mentored-by: Justin Tobler <jltobler@gmail.com>
> > Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> > Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> > ---
> >  Documentation/git-repo.adoc |  9 +++++++++
> >  builtin/repo.c              | 22 ++++++++++++++++++++++
> >  t/t1900-repo-info.sh        | 28 ++++++++++++++++++++++++++--
> >  3 files changed, 57 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> > index e524a07f53..20836cf8f6 100644
> > --- a/Documentation/git-repo.adoc
> > +++ b/Documentation/git-repo.adoc
> > @@ -119,6 +119,15 @@ values that they return:
> >  `path.gitdir.relative`::
> >       The path to the Git repository directory relative to the current =
working directory.
> >
> > +`path.hooks.absolute`::
> > +     The canonical absolute path to the repository's hooks directory.
> > +     Respects the `core.hooksPath` configuration. If `core.hooksPath` =
is
> > +     set to `/dev/null`, that value is returned unchanged.
> > +
> > +`path.hooks.relative`::
> > +     The path to the repository's hooks directory relative to the curr=
ent
> > +     working directory. Respects the `core.hooksPath` configuration.
>
> So if a repository has `core.hooksPath` set to "/dev/null", the relative
> path output here would be something like "../../../../dev/null". I
> recognize that this matches the current behavior:
>
>   $ git -c core.hooksPath=3D/dev/null rev-parse --path-format=3Drelative =
--git-path hooks
>   ../../../../dev/null
>
> ...but I'm still not really convinced that is is a behavior we would
> want to carry over as it makes it harder to users to figure out when
> hooks are disabled.
>
> I would suggest we print the "/dev/null" here even when the relative
> path is requested and document the behavior.
>

I am more inclined with you, and
I see how returning "/dev/null" for the relative key makes it
much easier for scripts to detect when hooks are disabled.

One thing I wanted to check: in a follow-up series, Junio suggested
extracting a common helper library to share implementations between
`git rev-parse` and `git repo info`. If `git repo info` special-cases
"/dev/null" for `path.hooks.relative` while `rev-parse --git-path hooks`
continues to relative-format it, would that divergence be an issue for
sharing the underlying helper, or should we special-case it only in the
`path.hooks` getter?

> [snip]
> > diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> > index eec576a1d9..1da5db4942 100755
> > --- a/t/t1900-repo-info.sh
> > +++ b/t/t1900-repo-info.sh
> > @@ -174,7 +174,11 @@ test_repo_info_path () {
> >                       cd repo/sub &&
> >                       ROOT=3D"$(test-tool path-utils real_path ..)" && =
export ROOT &&
> >                       eval "$init_command" &&
> > -                     echo "path.$field_name.absolute=3D$ROOT/$expected=
_dir" >expect &&
> > +                     case "$expected_dir" in
> > +                     /*) EXPECT_ABS=3D"$expected_dir" ;;
> > +                     *) EXPECT_ABS=3D"$ROOT/$expected_dir" ;;
> > +                     esac &&
> > +                     echo "path.$field_name.absolute=3D$EXPECT_ABS" >e=
xpect &&
> >                       git repo info "path.$field_name.absolute" >actual=
 &&
> >                       test_cmp expect actual
> >               )
> > @@ -188,7 +192,11 @@ test_repo_info_path () {
> >                       cd repo/sub &&
> >                       ROOT=3D"$(test-tool path-utils real_path ..)" && =
export ROOT &&
> >                       eval "$init_command" &&
> > -                     echo "path.$field_name.relative=3D../$expected_di=
r" >expect &&
> > +                     case "$expected_dir" in
> > +                     /*) EXPECT_REL=3D"$(test-tool path-utils relative=
_path "$expected_dir" "$PWD")" ;;
> > +                     *) EXPECT_REL=3D"../$expected_dir" ;;
> > +                     esac &&
> > +                     echo "path.$field_name.relative=3D$EXPECT_REL" >e=
xpect &&
> >                       git repo info "path.$field_name.relative" >actual=
 &&
> >                       test_cmp expect actual
> >               )
>
> From what I can gather, the code changes to this test helper is really
> only required for the "/dev/null" test case. IMO, this helper function
> has now become quite unwieldy and rather difficult to parse.
>
> I think we would be better off writing the "/dev/null" test case by hand.
>

Agreed, reverting the changes to `test_repo_info_path` and writing the
`/dev/null` test as a standalone test block will be much cleaner.

> > @@ -213,6 +221,22 @@ test_repo_info_path 'gitdir with explicit GIT_DIR'=
 'gitdir' \
> >       '.git' \
> >       'GIT_DIR=3D"../.git" && export GIT_DIR'
> >
> > +test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
> > +
> > +test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
> > +     'custom-hooks' \
> > +     'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROO=
T/custom-hooks"'
> > +
> > +# /dev/null is not a real, canonicalizable filesystem path on Windows,
> > +# so path resolution for core.hooksPath=3D/dev/null cannot be expected=
 to
> > +# produce a literal "/dev/null" the way it does on POSIX systems.
> > +if ! test_have_prereq MINGW
> > +then
> > +     test_repo_info_path 'hooks with core.hooksPath=3D/dev/null' 'hook=
s' \
> > +             '/dev/null' \
> > +             'git config core.hooksPath /dev/null'
> > +fi
>
> I'm not quite sure I follow here. Are we saying that the git-repo-info
> command won't work on windows if the hooks are set to "/dev/null"? Or is
> it just some issue with how the test is written? If its the latter,
> maybe this is something we can work around if the test is written
> without the use of the `test_repo_info_path` helper?
>

It was both the command and the test helper on Windows, `/dev/null` is
not an actual filesystem path, so passing it through `format_path()`
(and `test-tool path-utils relative_path` in the test) does not resolve
the same way as on POSIX systems (where `$PWD` on Windows has a drive
letter like `C:/...`).

However, if we special-case `/dev/null` in the C code so that both
`path.hooks.absolute` and `path.hooks.relative` output `/dev/null`
directly without passing it through `format_path()`, and write the test
by hand, it will work consistently on Windows too and we can drop the
`!MINGW` prerequisite entirely.

> -Justin

Thank you,
- K Jayatheerth
