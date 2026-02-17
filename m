Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFB1F30BB
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771288413; cv=none; b=GdwewAhWhHzaosHjMi+253JFKgYInf8BzEkXfutPbg8vYE8y67dDv5TwaOzsyct5b0lxch/IK7pVqRnZx0qsfhFJFtw8hzlTRjJkoN0/pTew1wjzwmuYbNCKVAYKxa8DQ/IU9e6KOT94R/DuW8SONWVInCrOVjjPBVdh+c7lKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771288413; c=relaxed/simple;
	bh=BaJDV3mnppIGeJkvYtNevgN2BCMpglL3TpvKkb4ykyA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=BFN/KSg8gGcrLA9Aq40fkH3+7sXW7zc/hsGJUN6mFT+VqHGND4D+9ebqzTA04zaqnkEP4LM/Pflbu3epURmZ2yOvQZGoVRh88YRHtePkT7YjEMULQpuJnIQsiT26Yu3q+CpT1HSZjisPU7H8j08YZwDsmJkVqhwHRmA44w7etjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MarDAPYp; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MarDAPYp"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7945838691aso70938887b3.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771288411; x=1771893211; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdGOr8T2OgqykU6+2bWgm83ZOGUlmnpTzGjoS3sgGrk=;
        b=MarDAPYpcvmjnA8L2DVZDOnWnoFJnpHIN/bAtyucptSEeeQdsCyH7ePichNdhSJdKw
         GOCv4hUanBz9AlngVixlnFjp4YGbqLFbYERgLB/z+7NTtfF+o5VOgxgtV9fVqqKpQfXN
         C4FTxmrsyav5/W7wLqe9FlecOvg1DXAtUikgvTh8CRXI91+PGRbolDXkfpEOHyMa62I/
         pEjXX0+kBmpN+DDskJbdfrbGBkJHPKvVg67EY3uCueVcjSFE36sQz4tjbK0bqPfgvjUy
         VKr+Oc2toho86a12q2RAgbu9Pc58eJteMZ+3KSNEMAZXNvpDcHBzbbLeAzR6Jn0SjLTx
         q74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771288411; x=1771893211;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sdGOr8T2OgqykU6+2bWgm83ZOGUlmnpTzGjoS3sgGrk=;
        b=OmupT2BQYYwQGqvUhSmHBaaXsmoLAWO283IlYVfB6fCWhM2vKCoCzKRO2CyHJTEwwv
         WMXQ0LVTU3oIeqnvUUrh5LgnnWCZ/0ZWd8/f74MCqIPa6zIAY/B9ktMi/ceTa+CBhToI
         VJxXgluBgxKcJwwXNsZRNtz+P7vzH6eQVZWMiYii4pVXZR/7ow5I8IwAmtfFeUpSHH6a
         nB7BZsbAKX99N3a5e11kU8+zjlrXyZM3BSFLzWcrjNDeg5R70Sz8eOgTDLu0OgizzUZ8
         OkPXSJC4rgrBRfLMA5rdLgZKcZmd1HoD0Enkbtt6p9UzXv2hORTKjk8G7Gv1ddrF64dA
         t91g==
X-Gm-Message-State: AOJu0Yy2oeggazObMZt+/Gtzup3HZ2trCS2eh2bHYQSL/NjuNtnP1wHg
	LM50Lab7T5EBq2dOd5rU5ge+fw3/Af3KhfCZibnNVf3uGyyRRYvog5Dj
X-Gm-Gg: AZuq6aLV08s8ZSe1HJbNm1xs4bzd+aGjH7L7rdAQxB4rjqOSMAEaoh383iZmQAIkf8A
	LRr3mGBM6xHjsPPnZVe9WB6Gu/dL8yEYtKVLBQJIjRFkpA72sBy+mp4YMTbrTLRqB+VzRTLUAI/
	BP3Kil358VWeDtqYaSwXv3AX1cIctbn0u8amwteAHYedRSX67tINi3wrBVTnqZ4uQv9HCBv19GV
	YJlyinwAwb7YmOcMC0mjBjuD/LctMM0v5yqypPRQuLxohguSxLfaXz+Uf3KGnZTFOZyfRWhhYGQ
	kgweSIfppCYqIAQTAOlyMGDyE0mojvgtbBA5dMGnux+/OVPTdXY5XWl6QxBeqOJeYqf1ilnopfN
	L8Ve7LKcWHx8q8s3RtwHOSsA0qU3r2eaY1Ps/QWVK5UJCMZwlAkIRfKbwvzLFs04m/km/OT8U4h
	DLsSCvjxcIwnmjAiPZ6t787H4DpmbjwUsjbjOHsKwazsw4OFC2VrKqgx4ivWwvoOKXjaT0oQvNi
	Z/olLEX8859Ku3SQBiSDqdY5HDGMirjzJeqNBdowBr0VDZzYMQ=
X-Received: by 2002:a05:690e:d8d:b0:64a:d047:2e43 with SMTP id 956f58d0204a3-64c2017ed54mr8334561d50.15.1771288411407;
        Mon, 16 Feb 2026 16:33:31 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:6013:d4d5:a1ad:bf5e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22ea11e9sm4251972d50.7.2026.02.16.16.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 16:33:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation changes
Date: Mon, 16 Feb 2026 19:33:19 -0500
Message-Id: <286624E8-94CD-4C65-BB91-BF8338B8A79A@gmail.com>
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Patrick Steinhardt <ps@pks.im>, Evan Martin <evan.martin@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 16 f=C3=A9vr. 2026 =C3=A0 17:29, D. Ben Knoble <ben.knoble+github@gmail=
.com> a =C3=A9crit :
>=20
> =EF=BB=BFThe Meson-based build doesn't know when to rebuild config-list.h,=
 so the
> header is sometimes stale.
>=20
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
>=20
> Teach the meson build to depend on the Documentation files that
> generate-configlist.sh reads by having it an additional output as a list
> of dependency files, since Meson does not have (or want) builtin support
> for globbing like Make. We assume that if a user adds a new file under
> Documentation/config then they will also edit one of the existing files
> to include that new file, and that will trigger a rebuild.
>=20
> Also mark the generator script as a dependency.
>=20
> Combining the following commands helps debug dependencies:
>=20
>    ninja -C <builddir> -t deps config-list.h
>    ninja -C <builddir> -t browse config-list.h
>=20
> The former lists all the dependencies discovered from our output ".d"
> file (the config documentation) and the latter shows the dependency on
> the script itself, among other useful edges in the dependency graph.
>=20
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>=20
> Notes (benknoble/commits):
>    Changes from v3 (<0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.g=
it.ben.knoble+github@gmail.com>):
>=20
>    =E2=80=A2 Include the script itself as a dependency via depfile
>    =E2=80=A2 Fix output path escaping (spaces, octothorpes; drop backslash=
es) for
>      Ninja (I've used a loop because I couldn't find a portable construct
>      that could escape only the remainder of the lines in the way I
>      wanted).
>    =E2=80=A2 Mention our assumptions about Documentation updates triggerin=
g
>      rebuilds
>    =E2=80=A2 Also include some debugging information in the commit message=

>=20
> generate-configlist.sh | 12 +++++++++++-
> meson.build            |  5 ++++-
> 2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade209..63a2e8b6938 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -2,10 +2,11 @@
>=20
> SOURCE_DIR=3D"$1"
> OUTPUT=3D"$2"
> +DEPFILE=3D"$3"
>=20
> if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
> then
> -    echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
> +    echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
>    exit 1
> fi
>=20
> @@ -36,3 +37,12 @@ print_config_list ()
>    echo
>    print_config_list
> } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"
> +then
> +    for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
> +        "$SOURCE_DIR"/Documentation/config/*.adoc
> +    do
> +        printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/=
g')"
> +    done >"$DEPFILE"
> +fi
> diff --git a/meson.build b/meson.build
> index 3a1d12caa4b..e4b8f1e33d2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,14 @@ endif
>=20
> builtin_sources +=3D custom_target(
>   output: 'config-list.h',
> +  depfile: 'config-list.h.d',
> +  depend_files: [ 'generate-configlist.sh' ],
>   command: [
>     shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>     meson.current_source_dir(),
>     '@OUTPUT@',
> +    '@DEPFILE@',
>   ],
>   env: script_environment,
> )
>=20
> Diff-intervalle contre v3 :
> 1:  0a344f1f3ee ! 1:  9cdcc9de04f meson: regenerate config-list.h when Doc=
umentation changes
>    @@ Commit message
>         Teach the meson build to depend on the Documentation files that
>         generate-configlist.sh reads by having it an additional output as a=
 list
>         of dependency files, since Meson does not have (or want) builtin s=
upport
>    -    for globbing like Make.
>    +    for globbing like Make. We assume that if a user adds a new file u=
nder
>    +    Documentation/config then they will also edit one of the existing f=
iles
>    +    to include that new file, and that will trigger a rebuild.
>    +
>    +    Also mark the generator script as a dependency.
>    +
>    +    Combining the following commands helps debug dependencies:
>    +
>    +        ninja -C <builddir> -t deps config-list.h
>    +        ninja -C <builddir> -t browse config-list.h
>    +
>    +    The former lists all the dependencies discovered from our output "=
.d"
>    +    file (the config documentation) and the latter shows the dependenc=
y on
>    +    the script itself, among other useful edges in the dependency grap=
h.
>=20
>         Helped-by: Patrick Steinhardt <ps@pks.im>
>    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
>=20
>      ## Notes (benknoble/commits) ##
>    -    Changes from v2 (<c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649=
805.git.ben.knoble+github@gmail.com>):
>    +    Changes from v3 (<0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853=
297.git.ben.knoble+github@gmail.com>):
>=20
>    -    =E2=80=A2 Pick up (and tweak) Patrick's depfile proposal
>    -    =E2=80=A2 Include the script itself as a dependency
>    -    =E2=80=A2 Escape output paths (spaces, octothorpes, and backslashe=
s) for Ninja
>    -
>    -    I'm not 100% sure I've actually done the escaping correctly, thoug=
h,
>    -    since Ninja's source says that a space preceded by 2N backslashes
>    -    represents 2N backslashes at the end of a filename, and
>    -
>    -        =CE=BB printf '%s\n' 'foo\' | sed 's/[# \\]/\\&/g' | xxd
>    -        00000000: 666f 6f5c 5c0a                           foo\\.
>    -
>    -    So would they interpret that as the filename 'foo\\' instead of 'f=
oo\' ?
>    -    (Or, no because the 2N slashes aren't followed by a SP, but a NL?)=

>    +    =E2=80=A2 Include the script itself as a dependency via depfile
>    +    =E2=80=A2 Fix output path escaping (spaces, octothorpes; drop back=
slashes) for
>    +      Ninja (I've used a loop because I couldn't find a portable const=
ruct
>    +      that could escape only the remainder of the lines in the way I
>    +      wanted).
>    +    =E2=80=A2 Mention our assumptions about Documentation updates trig=
gering
>    +      rebuilds
>    +    =E2=80=A2 Also include some debugging information in the commit me=
ssage
>=20
>      ## generate-configlist.sh ##
>     @@
>    @@ generate-configlist.sh: print_config_list ()
>     +
>     +if test -n "$DEPFILE"
>     +then
>    -+    printf "$OUTPUT: %s\n" "$0" "$SOURCE_DIR"/Documentation/*config.a=
doc \
>    -+        "$SOURCE_DIR"/Documentation/config/*.adoc |
>    -+        sed 's/[# \\]/\\&/g' >"$DEPFILE"
>    ++    for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
>    ++        "$SOURCE_DIR"/Documentation/config/*.adoc
>    ++    do
>    ++        printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/=
\\&/g')"
>    ++    done >"$DEPFILE"
>     +fi
>=20
>      ## meson.build ##
>    @@ meson.build: endif
>      builtin_sources +=3D custom_target(
>        output: 'config-list.h',
>     +  depfile: 'config-list.h.d',
>    ++  depend_files: [ 'generate-configlist.sh' ],
>        command: [
>          shell,
>     -    meson.current_source_dir() + '/generate-configlist.sh',
>=20
> base-commit: 19a08e0c02faf1c5b4efd1add85598cf8390ff7e
> prerequisite-patch-id: 364ba1899740b93be5957262d3583348d030e8fa
> --
> 2.48.1

Hmm. I=E2=80=99m pretty sure this worked locally but I=E2=80=99m seeing some=
 CI failures on GitHub. Will investigate.=20=
