Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40829E115
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042039; cv=none; b=glYZPTLovFBhTJZIylrNVzYHYMFXBCOCE1cZ54RrJZfi3WsH/+yHRXnkHnfRiR4uV9XplykueHMeIzZdyIISGzHmIYPyjwLh9yWdhfBAKb4iyR0puI3ooAvg0PUO5RK6e0zg3iOjaHEs5Eroy+7NtzqAbaBZCCLbn+5B1Q4ueIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042039; c=relaxed/simple;
	bh=qF2Nl6ob2f1jF+jKQVqHXcvDChPytoPMqFT0IvAzPeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHfm6mRjSoq5oKdwPaxIcftDxmdWWY125U93q1+hKwq0ETdxQR1WeEz2u9uJQB68MLyEpPJ6xqA2JqeUSSgWynvujIGFnQgcZzC13p+VhzsTdW6gx3Kua+4rtr5okq7WN7HxLUHRFRSgxfvN6/Nxx39kjyYH08VpmgNcIvkhk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=VEYU3WIh; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="VEYU3WIh"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 6341DDF8F41
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 18:27:20 +0200 (CEST)
Received: from [192.168.42.213] (unknown [37.169.33.238])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 10B8813F8A9;
	Fri, 27 Jun 2025 18:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1751041632;
	bh=qF2Nl6ob2f1jF+jKQVqHXcvDChPytoPMqFT0IvAzPeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VEYU3WIhpXXChb3gHP9uqY1KWCzhy7rGYxHdH7FkggTkDXuxQZShrQ4squwA9XCYS
	 8ujeRj3gd8A77Q+sIb1OS5qvVxAp8NYZxm8YdHr8pDr3DNIweStJAy4x5CktyTwBd8
	 rU3EZuYgrhDkXFq+0MSMoU4diiS8gG7z9S0Moc4iuv7FPwVvMvL4yz89+HkkwwR5lp
	 9SX0CmW6kOHX3iKlt1O+xbZyZheQTF2RcV0lwIfrQeqP/EVA33gRSYrZRQWQXmFZuk
	 kpjSmAOm1z5MwLJ1cFS4gzAeI8LjxqiZiXmHm9TvMUU7dwjtYdyy4oY6e9ub5HTcFp
	 C05zaWSAyT6yw==
Message-ID: <0d3fe70e-2064-4206-9673-c0589a4445f1@free.fr>
Date: Fri, 27 Jun 2025 18:27:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][RFC PATCH 1/2] builtin/refs: add list subcommand
To: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, shejialuo@gmail.com, karthik.188@gmail.com,
 Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <20250627074934.1761897-2-meetsoni3017@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <20250627074934.1761897-2-meetsoni3017@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'm only focusing on the documentation part.

Le 27/06/2025 à 09:49, Meet Soni a écrit :
>
> ---
>  Documentation/git-refs.adoc |  95 +++++++++++++++++++++++++++++++
>  builtin/refs.c              | 110 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+)
> 
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index 4d6dc994f9..d8f81eaabd 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -11,6 +11,13 @@ SYNOPSIS
>  [synopsis]
>  git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
>  git refs verify [--strict] [--verbose]
> +git refs list [--count=<count>] [--shell|--perl|--python|--tcl]

please use spaces around '|' in alternative options:
[--shell | --perl | --python | --tcl]

> +	      [(--sort=<key>)...] [--format=<format>]

This "[(--sort=<key>)...]" form is new to me. It abides by the synopsis
syntax. As I understand it, the user can specify a number of
--sort=<key> on the command line.

From the description below, it seems that for --format, the actual
syntax should be:

[--format[=<format>]]


> +	      [--include-root-refs] [ --stdin | <pattern>... ]

Here no spaces, after '[' or before ']':
[--stdin | <pattern>...]

For syntax precedence, we have not documented anything, but the obvious
meaning is "--stdin or a number of <pattern>. OK

> +	      [--points-at=<object>]
> +	      [--merged[=<object>]] [--no-merged[=<object>]]
> +	      [--contains[=<object>]] [--no-contains[=<object>]]
> +	      [--exclude=<pattern> ...]

What are the ... meaning here ? Is it --exclude= followed by a number of
<pattern>? What is the separator then?
Or is it like for --sort?

Maybe use another placeholder name to differentiate from the <pattern>
alternative to --stdin

>  
>  DESCRIPTION
>  -----------
> @@ -26,6 +33,11 @@ migrate::
>  verify::
>  	Verify reference database consistency.
>  
> +list::

OK, synopsis is used in the first part, but this man page has not been
fully converted. Let's stick to the previous style.

> +	List references in the repository with support for filtering, formatting,
> +	and sorting. This subcommand uses the same core logic as
> +	linkgit:git-for-each-ref[1] and offers equivalent functionality.
> +
>  OPTIONS
>  -------
>  
> @@ -57,6 +69,89 @@ The following options are specific to 'git refs verify':
>  --verbose::
>  	When verifying the reference database consistency, be chatty.
>  
> +The following options are specific to 'git refs list':
> +
> +<pattern>...::
> +	If one or more patterns are given, only refs are shown that
> +	match against at least one pattern, either using fnmatch(3) or
> +	literally, in the latter case matching completely or from the
> +	beginning up to a slash.
> +> +--stdin::
> +	If `--stdin` is supplied, then the list of patterns is read from
> +	standard input instead of from the argument list.> +
> +--count=<count>::
> +	By default the command shows all refs that match
> +	`<pattern>`.  This option makes it stop after showing
> +	that many refs.

Please revert the sentences and remove the "this option makes it". The
option description should state first the action of the option, then
talk about default values, behavior, ...

> +
> +--sort=<key>::
> +	A field name to sort on.  Prefix `-` to sort in

Use a verb in imperative mood as much as possible.

> +	descending order of the value.  When unspecified,
> +	`refname` is used.  You may use the --sort=<key> option
> +	multiple times, in which case the last key becomes the primary
> +	key.
> +
> +--format=<format>::

Cite the form with optional param

> +	A string that interpolates `%(fieldname)` from a ref being shown and
> +	the object it points at. In addition, the string literal `%%`
> +	renders as `%` and `%xx` - where `xx` are hex digits - renders as
> +	the character with hex code `xx`. For example, `%00` interpolates to

the ASCII character only I guess: encoding matters here as we are
usually in UTF-8.

> +	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
> ++
> +When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
> +TAB %(refname)`.
> +
> +--color[=<when>]::
> +	Respect any colors specified in the `--format` option. The
> +	`<when>` field must be one of `always`, `never`, or `auto` (if
> +	`<when>` is absent, behave as if `always` was given).
> +
> +--shell::
> +--perl::
> +--python::
> +--tcl::
> +	If given, strings that substitute `%(fieldname)`

Personal taste: "If given" is useless here.

> +	placeholders are quoted as string literals suitable for
> +	the specified host language.  This is meant to produce
> +	a scriptlet that can directly be `eval`ed.
> +
> +--points-at=<object>::
> +	Only list refs which points at the given object.
> +
> +--merged[=<object>]::
> +	Only list refs whose tips are reachable from the
> +	specified commit (HEAD if not specified).
> +
> +--no-merged[=<object>]::
> +	Only list refs whose tips are not reachable from the
> +	specified commit (HEAD if not specified).
> +
> +--contains[=<object>]::
> +	Only list refs which contain the specified commit (HEAD if not
> +	specified).
> +
> +--no-contains[=<object>]::
> +	Only list refs which don't contain the specified commit (HEAD
> +	if not specified).
> +
> +--ignore-case::
> +	Sorting and filtering refs are case insensitive.
> +
> +--omit-empty::
> +	Do not print a newline after formatted refs where the format expands
> +	to the empty string.
> +
> +--exclude=<pattern>::
> +	If one or more patterns are given, only refs which do not match
> +	any excluded pattern(s) are shown. Matching is done using the
> +	same rules as `<pattern>` above.
> +
> +--include-root-refs::
> +	List root refs (HEAD and pseudorefs) apart from regular refs.

The description seems a bit off. Did you really mean "apart from", not
"along with"?


Thanks

Jean-Noël
