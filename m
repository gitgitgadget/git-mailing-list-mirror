Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C738B
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297971; cv=none; b=uTPf8cd/N6VPKZbWgRSldGFDHH0xxPU+4W43QzYWeWyX6MmVLSuN+e/TGY1nJ34Zq8NU9MxNhA1aokeWHcIq1BRqRqNmaJOjS9o+AVnFtjF/XYz/oHeyJDvCXTYtljkfyiyKxQiMoRr58NBeZ3nTx3O8kH6MfzF3SUztHszpVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297971; c=relaxed/simple;
	bh=7dluf8bvl+dK9x8LO3evmPbLlwM51qctWUKn84ovS1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMCLN/pWxkMhyrogipO3a8zQF0pP193zPrNohciJ2Vil+ACkM6zJm+kpEOFA793OeWMNRsaR0Q7Y4TMhgMzRFq5KDauh/mZCpebtjYNbriRZi0KJD1Q88cOkpEtRPUsB7q4Q8mlGVFiTAp2wjNJLiGoNR0ornAby+YLpIrA4cIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d40f702d67so291797e0c.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 19:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710297968; x=1710902768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slbKvhsWenIR0htWbJ3SuhlQuemXDFEJpBA67Q3qq9U=;
        b=EnEc7FHm7HMlOxlVEiEet1ztlf4gTMs5f39KguMt5wahRuQEdK24DucVQD1CyW06R7
         u9SWB3VVPo8DcmfXsd6YKMhkI0BJjTaOtturpPLL8zOgXDiUjZ2chWcNBW+8fmdzMDKX
         UisdyHd8sKAFGv6wQ6/eBA3YK1nE4wOZ3IRvlOmRuozt5gTdS6izL7Dvcrdh/eWw/Zb2
         NF3jrt86sHbLbCcwRSzGaRy4Iz6ydjYkV8fg/Y8OLyNzWRulxzxSstXV+0h/rf2CczPG
         cszNi1PXw8s4OMz6G+5zA1nw1BlYA2iCZk5WMSKaIx72ABya3oZ3aXcXWNPbxriMRDtB
         hYsg==
X-Gm-Message-State: AOJu0YxRrx5EEQ/AaTMeH9SpAjuVCYzwmb78ExU3G4dYT1ze3buidrBf
	wdHU/UvEyGIZkwvQs+KJYUri5YMjWqeYwPRGu/aRwUQd8wirau/jVExHoYObiiq7ybVuBEpsDBW
	t/eenqq4w24JwXJi+pVvYoCz0eNM=
X-Google-Smtp-Source: AGHT+IGLKfCnCZj9Ux88MQD6H/v2U2whkcDopWezZxYp+if+8CNgIul7ua4ycwqsSNakDZ5UzyQy7vYjY3qFBj+hc/I=
X-Received: by 2002:a05:6122:615:b0:4d4:1766:52b7 with SMTP id
 u21-20020a056122061500b004d4176652b7mr513372vkp.15.1710297967927; Tue, 12 Mar
 2024 19:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709724089.git.ps@pks.im> <cover.1710198711.git.ps@pks.im> <53401299fa1f51954834e2507a2282cf60b02f20.1710198711.git.ps@pks.im>
In-Reply-To: <53401299fa1f51954834e2507a2282cf60b02f20.1710198711.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 12 Mar 2024 22:45:56 -0400
Message-ID: <CAPig+cTybDAqZeGXPi+hi5zpPD=7nGpknzM6MForaaff4H4htA@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] builtin/config: introduce "list" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 7:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> [...]
> Introduce the first such new subcommand, which is "git config list". To
> retain backwards compatibility we only conditionally use subcommands and
> will fall back to the old syntax in case no subcommand was detected.
> This should help to transition to the new-style syntax until we
> eventually deprecate and remove the old-style syntax.
> [...]
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -761,6 +811,22 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
> +       /*
> +        * This is somewhat hacky: we first parse the command line while
> +        * keeping all args intact in order to determine whether a subcom=
mand
> +        * has been specified. If so, we re-parse it a second time, but t=
his
> +        * time we drop KEEP_ARGV0. This is so that we don't munge the co=
mmand
> +        * line in case no subcommand was given, which would otherwise co=
nfuse
> +        * us when parsing the implicit modes.
> +        */
> +       argc =3D parse_options(argc, argv, prefix, builtin_subcommand_opt=
ions, builtin_config_usage,

Upon reading this, I wasn't quite sure what "when parsing the implicit
modes" meant. I suppose it is referring to the legacy style command
invocation?

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> @@ -11,6 +11,21 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +for mode in legacy subcommands
> +do
> +
> +case "$mode" in
> +legacy)
> +       mode_prefix=3D"--"
> +       ;;
> +subcommands)
> +       mode_prefix=3D""
> +       ;;
> +*)
> +       echo "unknown mode $mode" >&2
> +       exit 1;;
> +esac

t/test-lib.sh defines a BUG() function for signaling the sort of
programmer error handled by the "*" arm of this `case`.

An alternative simpler implementation, which wouldn't require any sort
of programmer-error fallback, would be:

    for mode_prefix in -- "" # legacy & subcommand modes
    do
        test_expect_success '...' '
            ...
        '
        ...
    done

> @@ -527,6 +542,7 @@ test_expect_success 'editing stdin is an error' '
>  test_expect_success 'refer config from subdirectory' '
> +       test_when_finished "rm -r x" &&
>         mkdir x &&
>         test_cmp_config -C x strasse --file=3D../other-config --get ein.b=
ahn
>  '

Is this an unrelated cleanup?

> @@ -1072,6 +1088,7 @@ test_expect_success 'inner whitespace kept verbatim=
' '
>  test_expect_success SYMLINKS 'symlinked configuration' '
> +       test_when_finished "rm myconfig" &&
>         ln -s notyet myconfig &&
>         git config --file=3Dmyconfig test.frotz nitfol &&
>         test -h myconfig &&

Ditto.

Same question regarding similar changes to several later tests.
