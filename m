Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC9332EA2
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702877; cv=none; b=pTGvVrHIY+BdVOt0Nms0QZPMTxdria+LWsbiuhOS+kO+25nw1P/DGVnH06U9Q/7aYyg5QqLxmWHB+CLprZNQAD7giiq+1sq+RmQ3e1h3kdWvut0mom2qO9kgEyFIzmMMcfg5YwJFXm2Qx1McV1b2jWwuDNxa1vyhl0ZrGOptkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702877; c=relaxed/simple;
	bh=J8z7E7IVQAvdFIIP/MgKslRFFCgAPO9HS7g46UuxeXU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eDCFz4ZAosIDn3pR04Ys+CY3eXvggodj/9hnXqqdUUZEWbhbVovB60rjQSpSKdZDT1MSiMcjnMVjBuZp8HwtNLW6eQmeRviuvk7nGQtXkgLkWfQHDgUcftVoGLbg/SWN++wuEITzyQu84h6NrTwaR4yUJRD3qfdHrxdhmk9GFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VVBa3lpB; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VVBa3lpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760702872; x=1761307672;
	i=johannes.schindelin@gmx.de;
	bh=biJkLkMUIDqkScLP0CEHHUWJvRrA4woz/PDCI7gtikM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VVBa3lpB5qL3rllrSp8qsQGiRIwLaugzmNggNK+6GhsN0o+hVGZ3iXgM0CbV2iYJ
	 yfEp81qFNvkpKsEYlwx5tlXeZmRB2ldRMEcb/ktSTBBLIjYm2cf4lic/s0ogeOAlW
	 IY4YuQeptUlOAzWj7Lo2tr4lg2qLoVIxnxXU6bZTMln9Pr030wtkYp+xvQ5LDocfj
	 xSeqnqS0NtIHJ5baKMHetR/LD7uS+C0sNqh64aEoC34P0/YVlzz1yaq5Knm5KuhFc
	 sO8aLHpKBPTlCVLadmCCHdEPIYOoXhv9yakt4t2Udo+PWK9J4qb6wioS2du+sE7xG
	 ILYQaAPDojx+hNLMBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.131]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1uWo7q0umM-00aKP7; Fri, 17
 Oct 2025 14:07:52 +0200
Date: Fri, 17 Oct 2025 14:07:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>, 
    Lidong Yan <yldhome2d2@gmail.com>
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
Message-ID: <4ff55fc5-7880-b8bf-257f-3186552e9c36@gmx.de>
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wrf6oEU2Bhep/WhNbcliJvsY8OhDA00pNztgP9XAKLr+3ayRHDB
 4DrT7W7iGaUB4AYT2bOpbJNV6D57dcxGUWY2mBXUvuEDTKdTERqOu3M7BaLDhIB22lQxpWh
 Tj4zG0GOVa66w4jd/RFaYkesvtKlz5PmjZ83GBkbpKCOp4gT8k/JABvUV8FAJvA6br7ikMo
 ASE5mY9nkYN7FHVYYV4VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A8+GRDIq+H8=;9nPEWNYapfdTfKX/3/jGSfhwTNv
 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
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 17 Oct 2025, Lidong Yan via GitGitGadget wrote:

> From: Lidong Yan <yldhome2d2@gmail.com>
>=20
> In dry run mode, diff_flush_patch() should not produce any output.
> However, in commit b55e6d36eb (diff: ensure consistent diff behavior
> with ignore options, 2025-08-08), only the output during the
> comparison of two file contents was suppressed. For file deletions
> or mode changes, diff_flush_patch() still produces output. In
> run_extern_diff(), set quiet to true if in dry run mode. In
> emit_diff_symbol_from_struct(), directly return if in dry run mode.
>=20
> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
>
> [...]
>
> diff --git a/diff.c b/diff.c
> index 87fa16b730..4baf9b535e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1351,6 +1351,9 @@ static void emit_diff_symbol_from_struct(struct di=
ff_options *o,
>  	int len =3D eds->len;
>  	unsigned flags =3D eds->flags;
> =20
> +	if (o->dry_run)
> +		return;
> +

Very good. This is a minimal change that covers all of the `emit_*()`
calls (except for `checkdiff_consume()`, but if the `--check` code path
is entered under `o->dry_run`, it is debatable whether or not it should
output something, therefore we could claim that this is "by design").

I do see a still-unguarded `fprintf(o->file, ...)` call in
`run_diff_cmd()`, but as far as I can see, this call is not in any code
path where `dry_run` is set. Granted, this is quite tedious to reason
about and requires considerable cognitive load to analyze, but judging
from past attempts to land patches that simplify logic e.g. in
https://lore.kernel.org/git/pull.1888.git.1743079429.gitgitgadget@gmail.co=
m/
I have concluded that core reviewers on this mailing list delight too much
in such analyses to be interested in making Git's code easier to reason
about.

>  	switch (s) {
>  	case DIFF_SYMBOL_NO_LF_EOF:
>  		context =3D diff_get_color_opt(o, DIFF_CONTEXT);
> @@ -4420,7 +4423,7 @@ static void run_external_diff(const struct externa=
l_diff *pgm,
>  {
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
>  	struct diff_queue_struct *q =3D &diff_queued_diff;
> -	int quiet =3D !(o->output_format & DIFF_FORMAT_PATCH);
> +	int quiet =3D !(o->output_format & DIFF_FORMAT_PATCH) || o->dry_run;
>  	int rc;
> =20
>  	/*
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 55a06eadb3..25fa452656 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -661,6 +661,27 @@ test_expect_success 'diff -I<regex>: ignore matchin=
g file' '
>  	test_grep ! "file1" actual
>  '
> =20
> +test_expect_success 'diff -I<regex>: ignore all content changes' '
> +	test_when_finished "git rm -f file1 file2" &&
> +	: >file1 &&
> +	git add file1 &&
> +	: >file2 &&
> +	git add file2 &&
> +
> +	rm -f file1 file2 &&
> +	mkdir file2 &&
> +	test_diff_no_content_changes () {
> +		git diff $1 --ignore-blank-lines -I".*" >actual &&
> +		test_line_count =3D 2 actual &&
> +		test_grep "file1" actual &&
> +		test_grep "file2" actual &&
> +		test_grep ! "diff --git" actual
> +	} &&

Nice! While this function obviously is not strictly scoped to this test
case (it will still be defined when the next test case is executed), it is
wonderful to see the structure that helps readers along.

> +	test_diff_no_content_changes "--raw" &&
> +	test_diff_no_content_changes "--name-only" &&
> +	test_diff_no_content_changes "--name-status"
> +'
> +
>  # check_prefix <patch> <src> <dst>
>  # check only lines with paths to avoid dependency on exact oid/contents
>  check_prefix () {
>=20
> base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26

Thank you for fixing this so quickly! From my point of view, this is ready
to go. I will integrate this patch into Git for Windows v2.51.1 (which I
am sadly forced to release on a Friday).

Ciao,
Johannes
