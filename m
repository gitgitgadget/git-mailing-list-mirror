Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F741F16B
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764421454; cv=pass; b=IGMa0fCNwn/EMliPBleW6WCrnw0SSc0ELW5Owt2E6jxYkQAVXdZFYpVRavhW6Y2MdMTAWkiMLPD7YbkJd0n4vbGXalPkNGbu77c60GrGapSdlFZp4yWDTwvd2vhH2tTw+i2xv7vkkvSo6K6rwe85OuKhdv2dqf/OapM1jsyBQOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764421454; c=relaxed/simple;
	bh=ZxHsGuKkoEHD6pcEmdmA4vGPvKiTz9nfCZ+GdoXjzFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ezfDF6Dg7Ifp919RwrUEh4N0HmdrHRzbpj4wqZqhXG7gFPtRbCaa+xI4NbP8/zuUzJqdVZ2SILdWrU9Ll9v6sc0r7tSbjHYpMJvG3eaCrQUJirXIH+9B7lY/JuZFhNh+MRgFAKuPEhzNA3qfpo+Xe4Jm7g52tDKr5ecMDo4kE5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=erqkPvmj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="erqkPvmj"
ARC-Seal: i=1; a=rsa-sha256; t=1764421440; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C/EcVNIqU7OF3I2P0Dmcl91/VqH4x2oX7MnyDFpOAM/nWiFYbJ8Rqh+oQw8CKbGhhFZJbk5YvEfx/ecHhf2ZYibcrOlzkoRRPyoO6oyNG6s8N1/4Ic2fP6bR4Q9/iQCrwglouIqrgPX7lveVsFLhELtUVyZH4Tynb+p7ZL01wyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764421440; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nhAu/GdRO5QNtzKmdK3x3kk1Xg5O9QtqMoKce0X5Kwg=; 
	b=aHHD1lEdqla8UAD0s4GCvOFN5QdDH3LM14CKs0i1zHLqPnKWANX/NS6K44pG+mYVHXBNyriMZrACMRCwcVR2Gsu+Bzc/iILtnB6ZR2PWPAkmW+0jzt57KxEvxM4BEIfmewhVRWqXzoWqOniYucnuQz34aFcamvn2vemEclazt40=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764421440;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nhAu/GdRO5QNtzKmdK3x3kk1Xg5O9QtqMoKce0X5Kwg=;
	b=erqkPvmjLmYHlR77NGdSQ/ROcAz041MBuqTRbZHtDji9WtdwQMcY7It9rNzygBHq
	gt1U8rRB7NH/ij7aFYdfS8Ca0LAYLTZvt39P+bV7QFUFlevWuki7aRtUel2TCwbUpZ8
	JDU3zAacU4P/4a2F+IbmCz0N0CM9L4r1yqgJ1+5Q=
Received: by mx.zohomail.com with SMTPS id 1764421437388763.1574374496838;
	Sat, 29 Nov 2025 05:03:57 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 02/10] hook: provide stdin via callback
In-Reply-To: <20251124172043.1650014-3-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-3-adrian.ratiu@collabora.com>
Date: Sat, 29 Nov 2025 15:03:52 +0200
Message-ID: <87iketf0sn.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Mon, 24 Nov 2025, Adrian Ratiu <adrian.ratiu@collabora.com>=20
wrote:
> From: Emily Shaffer <emilyshaffer@google.com>=20
>=20
> This adds a callback mechanism for feeding stdin to hooks=20
> alongside the existing path_to_stdin (which slurps a file's=20
> content to stdin).=20
>=20
> The advantage of this new callback is that it can feed stdin=20
> without going through the FS layer. This helps when feeding=20
> large amount of data and uses the run-command parallel stdin=20
> callback introduced in the preceding commit.=20
>=20
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
=20
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> ---=20
>  hook.c | 15 +++++++++++++++ hook.h | 38=20
>  ++++++++++++++++++++++++++++++++++++++ 2 files changed, 53=20
>  insertions(+)=20
>=20
> diff --git a/hook.c b/hook.c index b3de1048bf..cd2bb7418a 100644=20
> --- a/hook.c +++ b/hook.c @@ -65,11 +65,22 @@ static int=20
> pick_next_hook(struct child_process *cp,=20
>   cp->no_stdin =3D 1; strvec_pushv(&cp->env,=20
>  hook_cb->options->env.v);=20
> + +	if (hook_cb->options->path_to_stdin &&=20
> hook_cb->options->feed_pipe) +		BUG("options=20
> path_to_stdin and feed_pipe are mutually exclusive"); +=20
>  	/* reopen the file for stdin; run_command closes it. */ if=20
>  (hook_cb->options->path_to_stdin) { cp->no_stdin =3D 0; cp->in =3D=20
>  xopen(hook_cb->options->path_to_stdin, O_RDONLY); }=20
> + +	if (hook_cb->options->feed_pipe) { +=20
> cp->no_stdin =3D 0; +		/* start_command() will allocate a=20
> pipe / stdin fd for us */ +		cp->in =3D -1; +	} +=20
>  	cp->stdout_to_stderr =3D 1; cp->trace2_hook_name =3D=20
>  hook_cb->hook_name; cp->dir =3D hook_cb->options->dir;=20
> @@ -140,6 +151,7 @@ int run_hooks_opt(struct repository *r,=20
> const char *hook_name,=20
>   .get_next_task =3D pick_next_hook, .start_failure =3D=20
>  notify_start_failure,=20
> +		.feed_pipe =3D options->feed_pipe,=20
>  		.task_finished =3D notify_hook_finished,  .data =3D=20
>  &cb_data,=20
> @@ -148,6 +160,9 @@ int run_hooks_opt(struct repository *r,=20
> const char *hook_name,=20
>  	if (!options) BUG("a struct run_hooks_opt must be provided=20
>  to run_hooks");=20=20
> +	if (options->path_to_stdin && options->feed_pipe) +=20
> BUG("options path_to_stdin and feed_pipe are mutually=20
> exclusive"); +=20
>  	if (options->invoked_hook) *options->invoked_hook =3D 0;=20=20
> diff --git a/hook.h b/hook.h index 11863fa734..dd87326a5a 100644=20
> --- a/hook.h +++ b/hook.h @@ -1,6 +1,7 @@=20
>  #ifndef HOOK_H #define HOOK_H #include "strvec.h"=20
> +#include "run-command.h"=20
>   struct repository;=20=20
> @@ -37,6 +38,43 @@ struct run_hooks_opt=20
>  	 * Path to file which should be piped to stdin for each=20
>  hook.  */ const char *path_to_stdin;=20
> + +	/** +	 * Callback used to incrementally feed a child=20
> hook stdin pipe.  +	 * +	 * Useful especially if a hook=20
> consumes large quantities of data +	 * (e.g. a list of all=20
> refs in a client push), so feeding it via +	 * in-memory=20
> strings or slurping to/from files is inefficient.  +	 * While=20
> the callback allows piecemeal writing, it can also be +	 *=20
> used for smaller inputs, where it gets called only once.  +	 *=20
> +	 * Add hook callback initalization context to=20
> `feed_pipe_ctx`.  +	 * Add Hook callback internal state to=20
> `feed_pipe_cb_data`.  +	 * +	 */ +	feed_pipe_fn=20
> feed_pipe; + +	/** +	 * Opaque data pointer used to=20
> pass context to `feed_pipe_fn`.  +	 * +	 * It can be=20
> accessed via the second callback arg: +	 * ((struct=20
> hook_cb_data *) pp_cb)->hook_cb->options->feed_pipe_ctx; +	 *=20
> +	 * The caller is responsible for managing the memory for=20
> this data.  +	 * Only useful when using=20
> `run_hooks_opt.feed_pipe`, otherwise ignore it.  +	 */ +=20
> void *feed_pipe_ctx; + +	/** +	 * Opaque data pointer=20
> used to keep internal state across callback calls.  +	 * +	 *=20
> It can be accessed via the second callback arg: +	 *=20
> ((struct hook_cb_data *)=20
> pp_cb)->hook_cb->options->feed_pipe_cb_data;=20

I just noticed the small inconsistency in this comment (second cb=20
arg vs the actual code example). Will fix in v4.

I also have an idea how to further simplify this API based on the=20
parallel hook execution work I'm doing (that is a separate patch=20
series built upon this one), so I'll see if I can make this=20
simpler, to avoid going through hook_cb->options entirely, similar=20
to what Patrick suggested in v2.
