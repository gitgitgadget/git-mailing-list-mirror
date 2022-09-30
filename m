Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C59C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 22:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiI3WER (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiI3WEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 18:04:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD91A40A3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:04:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB66514550B;
        Fri, 30 Sep 2022 18:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2wINJ4YeI5Mg
        mw4VUXLytZ/CnodM6o4LWF98kdKGhak=; b=KqZBl8K5bXtwMrjD7ZAR1X+8Fmor
        WjTONjgVEdEvPSe9I5L3zHpRQWgCBGZEk0fg4IeTlEKIKEG7ncPU1o3GWRIdy3zd
        BrbBd2q0xAVic9VkLcLaCw8HREIzwSY6tSHtUfWz3Wb8SjfHyJdW09t9wJvu0WZA
        5p8+4bVG4LjMiIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2B0414550A;
        Fri, 30 Sep 2022 18:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34AFC145507;
        Fri, 30 Sep 2022 18:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 18/36] doc txt & -h consistency: fix mismatching labels
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-18.36-3a439c4401d-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 15:04:11 -0700
In-Reply-To: <patch-v3-18.36-3a439c4401d-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:41
        +0200")
Message-ID: <xmqqzgeg7c4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0D37636-410B-11ED-8651-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pa=
th>...
> +'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pa=
thspec>...
> =20
>  DESCRIPTION
>  -----------
> @@ -20,13 +20,13 @@ Normally, only files unknown to Git are removed, bu=
t if the `-x`
>  option is specified, ignored files are also removed. This can, for
>  example, be useful to remove all build products.
> =20
> -If any optional `<path>...` arguments are given, only those paths
> +If any optional `<pathspec>...` arguments are given, only those paths
>  are affected.

If you replace <path> with <pathspec>, then "only those paths are"
must be replaced with "only those paths that match the pathspec
are", because you are losing "those paths" from the sentence.

> diff --git a/Documentation/git-credential-cache--daemon.txt b/Documenta=
tion/git-credential-cache--daemon.txt
> index 01e1c214dd8..74832d06806 100644
> --- a/Documentation/git-credential-cache--daemon.txt
> +++ b/Documentation/git-credential-cache--daemon.txt
> @@ -8,7 +8,7 @@ git-credential-cache--daemon - Temporarily store user c=
redentials in memory
>  SYNOPSIS
>  --------
>  [verse]
> -'git credential-cache{litdd}daemon' [--debug] <socket>
> +'git credential-cache{litdd}daemon' [--debug] <socket-path>
> =20
>  DESCRIPTION
>  -----------

The description text (outside the context of this hunk) still refers
to <socket>.

> diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
> index 972a055fbd8..c612a5fd5b9 100644
> --- a/Documentation/git-mv.txt
> +++ b/Documentation/git-mv.txt
> @@ -9,7 +9,7 @@ git-mv - Move or rename a file, a directory, or a symli=
nk
>  SYNOPSIS
>  --------
>  [verse]
> -'git mv' [<options>] <args>...
> +'git mv' [<options>] <source>... <destination>

This one is good, as the rest of the document is written in terms of
the source and the destination.  The description of --force may need
to rephrase "target" -> "destination", though.


> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-rec=
eive-pack.txt
> index 014a78409b9..eec1268b10f 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -9,7 +9,7 @@ git-receive-pack - Receive what is pushed into the repo=
sitory
>  SYNOPSIS
>  --------
>  [verse]
> -'git-receive-pack' <directory>
> +'git-receive-pack' <git-dir>

`upload-archive` below is updated to call this <repository>, and
that might be a better update, but the goal of this step is to use
the same word in both code and text, so changing to <git-dir> is OK.

But "OPTIONS" part of the document (outside the context of this
hunk) still says <directory>, which should be corrected.

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 31a97a1b6c5..c15ec895720 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify a tag object s=
igned with GPG
>  SYNOPSIS
>  --------
>  [verse]
> -'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
> +'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>=
]

If you want to do "keyid" -> "key-id", then you'd need to update the
one in the DESCRIPTION part.

> diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-u=
pload-archive.txt
> index fba0f1c1b27..e8eb10baad7 100644
> --- a/Documentation/git-upload-archive.txt
> +++ b/Documentation/git-upload-archive.txt
> @@ -9,7 +9,7 @@ git-upload-archive - Send archive back to git-archive
>  SYNOPSIS
>  --------
>  [verse]
> -'git upload-archive' <directory>
> +'git upload-archive' <repository>
> =20
>  DESCRIPTION
>  -----------
> @@ -54,7 +54,7 @@ access via non-smart-http.
> =20
>  OPTIONS
>  -------
> -<directory>::
> +<repository>::
>  	The repository to get a tar archive from.

This is good.

> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 61d93383f51..96052541cbf 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_i=
nfo, int nongit)
>  }
> =20
>  static const char * const bugreport_usage[] =3D {
> -	N_("git bugreport [(-o | --output-directory) <file>] [(-s | --suffix)=
 <format>]\n"
> +	N_("git bugreport [(-o | --output-directory) <path>] [(-s | --suffix)=
 <format>]\n"
>  	   "              [--diagnose[=3D<mode>]]"),
>  	NULL
>  };
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 5466636e666..6f039f555b2 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -26,7 +26,7 @@ static struct string_list del_list =3D STRING_LIST_IN=
IT_DUP;
>  static unsigned int colopts;
> =20
>  static const char *const builtin_clean_usage[] =3D {
> -	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] =
<paths>..."),
> +	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] =
<pathspec>..."),
>  	NULL
>  };
> =20
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 13cbb75ca28..e8f77f535f3 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -10,10 +10,10 @@
>  #include "tag.h"
> =20
>  #define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
> -	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[n=
o-]progress]")
> +	N_("git commit-graph verify [--object-dir <dir>] [--shallow] [--[no-]=
progress]")
> =20
>  #define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
> -	N_("git commit-graph write [--object-dir <objdir>] [--append]\n" \
> +	N_("git commit-graph write [--object-dir <dir>] [--append]\n" \
>  	   "                       [--split[=3D<strategy>]] [--reachable | --=
stdin-packs | --stdin-commits]\n" \
>  	   "                       [--changed-paths] [--[no-]max-new-filters =
<n>] [--[no-]progress]\n" \
>  	   "                       <split options>")
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-ca=
che--daemon.c
> index 4c6c89ab0de..ca672a6a619 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -267,7 +267,7 @@ int cmd_credential_cache_daemon(int argc, const cha=
r **argv, const char *prefix)
>  	const char *socket_path;
>  	int ignore_sighup =3D 0;
>  	static const char *usage[] =3D {
> -		"git-credential-cache--daemon [opts] <socket_path>",
> +		"git-credential-cache--daemon [opts] <socket-path>",
>  		NULL
>  	};
>  	int debug =3D 0;

Heh, so we are allowed to change _BOTH_ code and text to make them
consistent.  We are not limited to pick the existing word used in
one or the other.  If that is the case, using <repository> instead
of <git-dir> for receive-pack may be a good change to make here as
well.

In any case, reviewing code part of this step is far easier than the
documentation part, as the latter must be done more carefully to
spot the mention of the earlier word in the entire document.

