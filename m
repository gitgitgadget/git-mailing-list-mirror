Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207064;
	b=r3QAK/Cf7DA9fJR2AJxeW4Xz6TdBX/TNc3cZsxSr9+hobWXb4T1FGtLpeGFlQNaXKim/
	 LEW8oJvldWumIIExZcsIBFVc5QuAWT9xMy687DOsVBXx97WBLSUgCNpnDeCYW0e+j1vNN
	 +VKGUdSk5kNvDja6ermkxCXMRDGAWZr15PS/HEgDW5IxqWlASp2AaEI2TNY6cjRfEp5Zo
	 0CFV8VHHJRMtwSCXn0018ivmQGiohPZUtYWtTcChEQ30zpjQVOH2XQtEFtpnicLQTViX1
	 5eeWtNCzt8PVvDMm9tMMMuf+gjD6B/6iuIF7HWBAajbeIyXXF1AV+ITyRKRTjwTV5gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207064;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WtJrlTVNGFV2j4MmSrBY83nZ9xyvN9uC4jZ6DbOiJ8w=;
	b=gpr+cLKrVMw91QhKWt1B8XbciT8XPlNTSjVtT8r6hT2+X6WwZPg0WHM91fqtUdv8QS9I
	 WUSgbb2oPBhhzgTA8JqFhy2fE6suVqYIu7GxlK26qQ5imF773o1iYbI2MIiw+kuwph/C4
	 wOqx+0/9TntC+tuy2BdbEMIEhzXUrbDFCiWZ4X3WQqVNFdBxgWmwHssXyKGPBkH57gZ0K
	 bD2oSGCwGJlteiEJS0daNuHs389UDzTpsX/peT1Cts7I1OwANOQKuEPl7tEmPcgX1ED8i
	 fHiLzXxxI3LiqZzI/1hhuR639DgpIDmUBvyMiEizHVZOSbVNq9yD9WHpthUESPbU6Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eQH1RIM8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kyVlRuq+;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5A606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eQH1RIM8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kyVlRuq+
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 521CA7A0100
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:04:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 13:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793207063; x=1793293463; bh=WtJrlTVNGF
	V2j4MmSrBY83nZ9xyvN9uC4jZ6DbOiJ8w=; b=eQH1RIM8JZ0T/gCdjkKNt4jZaH
	OavMdSHwQCkI3FQpQXF57/JU9CRmg31eSpvstuOWM2gLKaIQucwO4Sv+CJLhZslC
	Ory+/3kvLehzDqPqPpbz99mUbPLKv0M+7famHgka+6bl4WrFbKT+NZ9Z59qXM8v0
	0S1Qk7VzKeRWqomnZUwqt8psQFjHBruu7lr+MWBMbBfCAauH9VpELyMBMneAJIn6
	VOkEGpsRQOAnUjIZ18fN/cV8Exj6QAvMvsZ7Jf0sxHQHAmYauqRmuS057/u9hcq0
	ITIDWqhaqtYeWTUPjRLkvjSIch4E4unCrsbyjgv2XwBUbOYEERWQVYhdFU1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793207063; x=1793293463; bh=WtJrlTVNGFV2j4MmSrBY83nZ9xyvN9uC4jZ
	6DbOiJ8w=; b=kyVlRuq+dyPKmvkkRi7pB4uIP4bn5vt4KIgaQquOyZOgWhAbHdj
	Ra+V5pcyjW4L2jMdAhqKqU9jBCpvWLAY4JomZON3U9NnVvAYi8vRabI7K2eej27M
	L6PYgacSWKBid1zxn+dxErSVFCK2Az3u3vWMiaZkiZ8DXWzqTLxjitHSgVd6N2LX
	N8O/QHvr0L1XRP/dY7qMf7gTI3+4i7qQe/lyzhxILoDCXOVI9PoW1ItnOwqyuinZ
	NNl06a2Mpgs8pSzbw+CyGjMvbdVpj1gyHfHdw5bOuMpf9S3KKlTRo2cYh2+ced6K
	xxbBSNMC2nvGJXo8eJi8Fgpe0kDfvGyoAbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793207063; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eZsvKQOtWI6mtE26ELKXm2Gl+MW7+a6jWlmtNVsvgNrYud8
	VOO+DoKPCSwpJiQUMDMlw4QqLSm/LBVuE1/RuZg0EXZma1c6cQOIGDUfJzBFfA8g
	KXvMdl6m0fn4qGLU/AXOM1N6yTUn3XZ1WR9vF0fv07CHusUdu0OIDAsGU6psl2pI
	kK7JfUgdcSBGvQSmlM6zK8+RdxFApps2+A58UBdlJU0YdPr3oRRoIVJBVpfmA1C2
	fpLDupri6s1sghWFqzO+fmQ45MjcT/HTvnO5i/uCX6WNM5ycG1cVrHtM3F9yGsof
	pmhuej4W/wrpeAVrn5IuotqEjYSvzkqUMYoETnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rwf78Y7LkUb4In0/Vg4hb3d+dC7pi+vyfjfxyLTsa6s=:k8OhoranXFDJFHxu8fGQcTCCB7F5Bixtvl3eaQC0efY=;
X-ME-Sender: <xms:FiviaprTWe4AKAk2rKQTrTa4XFSHH-Xo9luAEiXDWxRN3JU6sf1LSw>
    <xme:FiviajFsJYAGikdWBm6JFp84ENTycMYwJ_DZjNeHOQaEKUmFFQTu247aqz4duQx8b
    CiBdnk2LQrXs0h5RQ8cYhQonw-DJfgePfZ0LW4uO5y0PFeIqOHDErE>
X-ME-Received: <xmr:FiviajkfzZ5ebOeHcxt6sCYHupxMba8OnHyW00dJB8ydkiXrq09oopo_IIN7PGLyBuLtOjHiIpuPc23iXAcc7kVD-YVLG0kzw-_d>
X-ME-Proxy-Cause: dmFkZTEA+F9S9Fg0HmvkfBBIMk3PmTGm8Du1hBBCD62Z0S0vp2mfs281Y0Xf8ZxUU8i47N
    Afo+5Pgs3FOqxy+Sy2Kr4sMiPV6j4vjdMrn2suQaqp0WL693QoEyAHIj1yl0uHE67Ixvef
    7KwgTOe08illo/tpWWDDLgNg8M5xTtrMSmcIzGiqMF8DcMR/eYaK9r3Rq8hWAwQMJ6eTKd
    2sOC9M4nixD+x6dYqgeqcIIAbgmBaa5rg4FZYUi6f6N67ax0eSxYPXMxFqw7+caKshM53x
    upIupj3OczO8DKqIOCs/XamK8vckYwWqjD5b3FXt7yIwHfcuCdcEBAiq256zUEEnRH/0gL
    58tv6BsFqfdxbUhGMSTmOpJ48BjbmCZNNjU8tuzeu3HqjBjE0mt9OXf5TdZH1cNfeEXnrB
    OiX9Sjv/B/XWI0NOnvZGszgPLX0rjoSfGTOPsId8bkUjSMSjJNp3fyWnzDO2ZADbgnMoKR
    O1KqkUz72ka7Kee+a/fO06dtUiLpmg0WEP33Q87fzMj6K9EyEOZyDm/TshYWi9uKJ99LCA
    fjP4b9RQ9qcVvcYR7zPcLxlPKAUF3qSAos+plojP+Veeu/K3aw/DS041CGVQWJsOoipj27
    MBsMLYNvA6HMpf77OTs72n6S/P1wOqOFrLbwPoThvuRMc9D6S0EkGADIf+6A
X-ME-Proxy: <xmx:FiviaukEugYlsdGcjoPsBXJ7b8S8nifmuGFna2X5bWHtWZ-r7hVDcA>
    <xmx:FiviasvoyvxDVwquEUYuqCMiS5OHoV7blBnYPsy2zbaPaIlSpx046A>
    <xmx:FiviapkBQZ9TrUGlnz3JN6GnxIOIUryXjfkg6fWibT9Lqu805LQQ4A>
    <xmx:Fiviavst_MoqYiPidA4hUWUQ1gTLZHjCWcBmjttkbfnkrPtYXqMkcw>
    <xmx:FyviarHd8CH8Wl8479W8Dn6ypyAkrMz0PX_f48S14jVSDBt2dBOP1XvA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 13:04:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/diff-files: convert ad hoc option parsing to
 parse-options API
In-Reply-To: <20261028141354.1155-1-edsonwasswa54@gmail.com> (Edson's message
	of "Wed, 28 Oct 2026 17:13:54 +0300")
References: <20261028141354.1155-1-edsonwasswa54@gmail.com>
Date: Wed, 28 Oct 2026 10:04:21 -0700
Message-ID: <xmqq4ie5bvu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Edson <edsonwasswa54@gmail.com> writes:

> The cmd_diff_files() function manually parses --base, --ours, --theirs,
> and -q options using a hand-rolled loop with strcmp() calls. This is
> error-prone and inconsistent with the rest of Git's codebase.

The first sentence is correct, but is it error-prone how?

> Convert this to use the parse-options API by:
> - Adding option definitions using OPT_* macros
> - Removing the manual parsing loop
> - Using parse_options() for consistent argument handling
>
> The --base, --ours, and --theirs options use PARSE_OPT_NONEG to prevent
> negated forms (--no-base, etc.) which are not meaningful for merge stage
> selection. This follows the pattern used in builtin/checkout.c for similar
> stage selection options.
>
> This makes the code more maintainable and brings it in line with Git's coding standards. It also enables auto-generated help text, git completion support, and option abbreviation.
>
> Signed-off-by: Edson <edsonwasswa54@gmail.com>

Earlier messages to the list from this e-mail address identified the
sender as "Wasswa Edson".  Are these the same person?

See Documentation/SubmittingPatches [[dco]] and [[real-name]].


> ---
>  builtin/diff-files.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index ea91347ce2..a0c3981407 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -14,6 +14,7 @@
>  #include "commit.h"
>  #include "preload-index.h"
>  #include "revision.h"
> +#include "parse-options.h"
>  
>  static const char diff_files_usage[] =
>  "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"

Using parse-options API means you'd need to be careful about how
you write the usage string, as the parse_options() call itself will
list options and its meanings.  Doesn't the above need adjusting?

> @@ -48,18 +49,21 @@ int cmd_diff_files(int argc,
>  	prefix = precompose_argv_prefix(argc, argv, prefix);
>  
>  	argc = setup_revisions(argc, argv, &rev, NULL);
> -	while (1 < argc && argv[1][0] == '-') {
> -		if (!strcmp(argv[1], "--base"))
> -			rev.max_count = 1;
> -		else if (!strcmp(argv[1], "--ours"))
> -			rev.max_count = 2;
> -		else if (!strcmp(argv[1], "--theirs"))
> -			rev.max_count = 3;
> -		else if (!strcmp(argv[1], "-q"))
> -			options |= DIFF_SILENT_ON_REMOVED;
> -		else
> -			usage(diff_files_usage);
> -		argv++; argc--;
> +
> +	{
> +		static struct option diff_files_options[] = {
> +			OPT_SET_INT_F(0, "base", &rev.max_count,
> +				      N_("show base version"), 1, PARSE_OPT_NONEG),
> +			OPT_SET_INT_F(0, "ours", &rev.max_count,
> +				      N_("show our version"), 2, PARSE_OPT_NONEG),
> +			OPT_SET_INT_F(0, "theirs", &rev.max_count,
> +				      N_("show their version"), 3, PARSE_OPT_NONEG),
> +			OPT_BIT('q', NULL, &options,
> +			       N_("be quiet"), DIFF_SILENT_ON_REMOVED),
> +			OPT_END()
> +		};
> +		argc = parse_options(argc, argv, prefix, diff_files_options,
> +				     diff_files_usage, 0);
>  	}

Is it necessary to introduce an extra block that only increases the
indent level?  I do not think so.  Move the "struct option []" up in
the beginning of the function.  If we really have to use the
parse_options() API, that is.

It also is unusual in modern code to have "struct option[]" array as
a function scope static, even though older code like cmd_fsck()
makes it static.

>  	if (!rev.diffopt.output_format)
>  		rev.diffopt.output_format = DIFF_FORMAT_RAW;
