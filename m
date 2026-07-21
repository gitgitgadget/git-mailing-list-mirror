Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B34307AD
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664738; cv=pass; b=h2ZP9sXeOuc0pZ8mun+/6pOfvafCjJzYiAO50naiEVZl+qEJH0WDrzXG9LOBuyASec2w/opryb6xl+qlawrxgp4TmZ/vQbBC89FISIOv+Bi+YHtCDosjpuyd4PyBHJD1dm8lX3TAK9M8jIRnv+WFfDKc65mDJb39XwsCQJpVeGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664738; c=relaxed/simple;
	bh=9YauZlTB8+vzW/zEEPlzbOhP4qGR6ofjnexdRBX8doc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rd0qBEDcskrZQG18+T7aMRSBtvFQoi2z5kVynP0c7EP41GVCtU/L8bLWjPmG3XgSwsOYmL2zbiQmssdnCYg9ceSnry5kSOEdpX09lzrxfbjDpaozavG3KwMEC+xNZud5C6K/4IUHqe9By/V00F6ra0XeGcKfH/LHDBOcdrtliY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atpz99UN; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atpz99UN"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-737f6e70678so7591919137.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 13:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784664734; cv=none;
        d=google.com; s=arc-20260327;
        b=Xw7luS/9LY1mQ6rr3lYuEMUK/Y60QFG+a4Lrf+OKXEvFNWI8XpAsN9Kz41rrYgjac7
         r1l26UzLKQ4ry1J9xb8hi33B9GfVfFZZs4M5YCusYcXUXEP5sDlevgRhIjpMndVUr4x9
         cY3pqitfzdP152MKOSm+XfOiXfhY+Bno+VeT+4tOuobSneFY8T7+gpYMOHtHJVsYl/oR
         +GhojP0LQPeqTgj336zVKEyPd9/27p6UePUy+jMJlUnU+yF218PsbWc5ADW2dpIAECPP
         B7Ugd91ckR6qVFwN+V0H90nUuW2xQNEnyrs6mz8mkv+qGUDR/HYRWm55gapcbjWLsV8q
         Ukmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jHcvUyG663eiSyLSeQvvRa3j/9+qbOq/ZNIRyGefstA=;
        fh=6NFYcSDm26httaK1pPWseyIbiYoT7uMwBh3u3/xppW8=;
        b=KE5BBSvaeEqZotP6P2ZOQ2dKob3kfJW+jiBFWFvWR2R4/aPgkR4OYQS+yS7pNKXrd9
         4FfFbHLoNFfUuBMUDSd+EQl+wnmu/9SjDHwqLFEu8j//5xAPsOTMGiKf3gcrwL0clq8G
         La/xr+3P3dt4juys9psZwd9HFNFf4bD/3rSQstLXCFRq52LBvkq+D0Lb21q6KFo5JrwE
         oilScn3Up0mb/wXzzuc72zNNz9WAMtvvwPctZXTY/E/vMbD2/esN8EakJeNhKpHMtvI0
         K39s/G1aNyJCGwQ/QO1H62znvM8vS2yRf15gn7/3OzWPL2OfbROjWhuMq/69IY5I+rZc
         qC4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784664734; x=1785269534; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jHcvUyG663eiSyLSeQvvRa3j/9+qbOq/ZNIRyGefstA=;
        b=Atpz99UNwzFq1L6TN+kOspgLVPhYdPQ/LsmGP+JAzrLbnMNWiS4Tzhg+B2Jjg34a2v
         HwDlf4lrgd05VGCwOQoplErtLaGZU47WuhZHM9QcLswxoSODKVqzXLA+dFcSjNhoNRxV
         IrQO/ARsQLlW8yxkLJfIcvqQjMuHuaEjTm8Oxxf1RckvfijUr4RmCMeM6+xmoAJKUKxn
         Euwu8mH6JsEKgkSeDidoPYzbsEmwozxm9x6huSYkn+YhEjT4aYO97oL0qB4e2+Mw5HQS
         HTdksbRkyair02tXnWxwHC6BtNJxiV5dZNvVEXbYFi49aPT50xoy79BvrvixsFKELO86
         GW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664734; x=1785269534;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jHcvUyG663eiSyLSeQvvRa3j/9+qbOq/ZNIRyGefstA=;
        b=QeZCaXq2FlykZIVTLh+VmvXcXIxPPaEuVSElhqXZyDwInF1EUicWSeGuZVBKBoatto
         a1QNwnumVBPbxBzUsmyTop/yLsq8blXhMuuvVBgCFhydad3rySPEAjfr67a5pB5YI0xQ
         zh5OoMw7bIp/adad1Y2FQ4VVzwsUFU6SHXghi1r/hAmgB/ELtgPH1E5puat/lKLzjp/H
         HbVpEF97Gi+GK7fBd/+BP1GdV9aqcC9TmpZzNo8diX31x8iE+bhZVVg3XOV84poYkZu5
         5HjHsuBWYQD++4bWoyFwyPYcbQA2qPPD5FrM9DnRUqyip1iKSgY9Ta5QvrV51oNYQSv7
         lEUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9+4CPWVZ7p+tPrwDj4x0bSD9ghqDHOSaClkb/l/7p0J4F6UHEG2gQ6QYoQAhnZnxNMQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ReiYZphgEzw8vS6KPBfDo/8Cp2rgDuZE5pO8ORN7CK96ltr4
	nBcAKT7FyJvlHJdTwSRsRrY5bdjWnBkVICBVH7htivpDQ+wJwAFC+Uw1CY0P2xG4oSzUpNNcYIJ
	4IPJZglwFx34EOSwVNz6mju1WOPmU8tw=
X-Gm-Gg: AR+sD11Uq9m3tw7GB/3WhTrCPGi7GO1UVosQDlR5Ts510npuW+KlxD1aoiquSQXBV3a
	jiwKxwe4R38G/oTU2X8nF3oLtlPBxgSmG6ClFLAl5EHPdsY3FUis/6Vzbm2PFSQ12Ll1rf40Zi/
	a/ZbFxHT3u4gSPNVFhhsYNiJe/nSnbtNIDkOy1j5pTLg6LmDHSGqnNqwl93hBlL/hj4/DIcF1Jl
	DbDjjA8mA09qaqqeAxcUt7PxLFAV52bwxHbP8TEOFDw7tf6nqoExh9FoPvqV9wG8YchzLwiaEGY
	09FQzYuW+m+K4kIr9JqRCUfijEgRc0eZJZs6AhKVOFWAG1DZ8Yby
X-Received: by 2002:a05:6102:3f06:b0:650:9174:32b with SMTP id
 ada2fe7eead31-74753439e95mr7855941137.1.1784664734196; Tue, 21 Jul 2026
 13:12:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 16:12:12 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 16:12:12 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com> <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jul 2026 16:12:12 -0400
X-Gm-Features: AUfX_my8Gly7cVkN6YUmUOfvJ1AltiLuUzaBH62P369NbSPSBUoSEH5ReYRhoKk
Message-ID: <CAOLa=ZT77L39-jSZxgrvVFwdY6_rapBmKv8gCxr7QpdkCsEzXg@mail.gmail.com>
Subject: Re: [PATCH GSoC v20 00/13] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, szeder.dev@gmail.com
Content-Type: multipart/mixed; boundary="00000000000086bd81065724a359"

--00000000000086bd81065724a359
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

[snip]

> Changes in v20:
> - Moved the prep patch that fixes hash_algo's type to be before
>   write_fetch_command_and_capabilities() being moved to 'connect.c'
> - Reverted git-cat-file.adoc documentation comments about CAVEATS
> - Fixed style for EXPAND_DATA_INIT
> - Added more context for comman line die()
>

[snip]

> Range-diff versus v19:
>
>  1:  6df5bcb3bc =  1:  31b02f10b5 transport-helper: fix memory leak of helper on disconnect
>  2:  141d85a76f =  2:  7d62e0586f cat-file: declare loop counter inside for()
>  3:  87457a1fe3 =  3:  082d593fb7 t1006: extract helper functions into new 'lib-cat-file.sh'
>  4:  c26d378931 =  4:  8646b9d7cf fetch-pack: drop the static advertise_sid variable
>  -:  ---------- >  5:  5531a3c399 fetch-pack: use unsigned int for hash_algo variable
>  5:  ee16e17228 !  6:  92b4122642 fetch-pack: move write_fetch_command_and_capabilities() to connect.c
>     @@ connect.c: int server_supports(const char *feature)
>      +	}
>      +
>      +	if (server_feature_v2("object-format", &hash_name)) {
>     -+		int hash_algo = hash_algo_by_name(hash_name);
>     ++		const unsigned int hash_algo = hash_algo_by_name(hash_name);
>      +		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>      +			die(_("mismatched algorithms: client %s; server %s"),
>      +			    the_hash_algo->name, hash_name);
>     @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
>      -	}
>      -
>      -	if (server_feature_v2("object-format", &hash_name)) {
>     --		int hash_algo = hash_algo_by_name(hash_name);
>     +-		const unsigned int hash_algo = hash_algo_by_name(hash_name);
>      -		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>      -			die(_("mismatched algorithms: client %s; server %s"),
>      -			    the_hash_algo->name, hash_name);
>  6:  bb915f57ad <  -:  ---------- connect: use unsigned int for hash_algo_by_name() calls
>  7:  b3b06b0cae =  7:  b954a5994a connect: make write_fetch_command_and_capabilities() more generic
>  8:  79a87c7011 =  8:  627242a7a1 fetch-pack: move fetch initialization
>  9:  37c3f93975 =  9:  0578594733 protocol-caps: check object existence regardless of the attributes requested
> 10:  c5062ecaf2 = 10:  816bfa9162 serve: advertise object-info feature
> 11:  22d72168bc = 11:  2323f45cb2 transport: add client support for object-info
> 12:  2cf3b24a35 ! 12:  a39975766b cat-file: add remote-object-info to batch-command
>     @@ Documentation/git-cat-file.adoc: one per line, and print information based on th
>       You can specify the information shown for each object by using a custom
>       `<format>`. The `<format>` is copied literally to stdout for each
>      @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
>     - 	reports).
>     -
>     - `objectsize:disk`::
>     --	The size, in bytes, that the object takes up on disk. See the
>     --	note about on-disk sizes in the `CAVEATS` section below.
>     -+	The size, in bytes, that the object takes up on disk.
>     -
>       `deltabase`::
>       	If the object is stored as a delta on-disk, this expands to the
>       	full hex representation of the delta base object name.
>      -	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
>     --	below.
>     -+	Otherwise, expands to the null OID (all zeroes).
>     ++	Otherwise, expands to the null OID (all zeroes). See `CAVEATS` section
>     + 	below.
>

This chagne is still unnecessary, no?

>       `rest`::
>     - 	If this atom is used in the output string, input lines are split
>      @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
>       	after that first run of whitespace (i.e., the "rest" of the
>       	line) are output in place of the `%(rest)` atom.
>     @@ builtin/cat-file.c: struct expand_data {
>      +	 */
>      +	unsigned is_remote:1;
>      +};
>     ++
>      +#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
>      +
>      +static const char *remote_object_info_atoms[] = {
>     @@ builtin/cat-file.c: static void parse_cmd_mailmap(struct batch_options *opt UNUS
>      +	line_to_split = xstrdup(line);
>      +	count = split_cmdline(line_to_split, &argv);
>      +	if (count < 0)
>     -+		die(_("remote-object-info: %s"), split_cmdline_strerror(count));
>     ++		die(_("remote-object-info: failed to parse command line: %s"),
>     ++		    split_cmdline_strerror(count));
>      +	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
>      +		die(_("remote-object-info supports at most %d objects"),
>      +		    MAX_ALLOWED_OBJ_LIMIT);
> 13:  ebdfc22fb7 ! 13:  70a11d2aea cat-file: make remote-object-info allow-list adapt to the server
>     @@ builtin/cat-file.c: struct expand_data {
>       	 */
>       	unsigned is_remote:1;
>      -};
>     +-
>      -#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
>
>      -static const char *remote_object_info_atoms[] = {
>      -	"objectname",
>      -	"objectsize",
>     ++	/*
>     ++	 * List of atoms (i.e. "objectsize") that the server supports. Built
>     ++	 * from the server's object-info advertised capabilities.
>     ++	 */
>      +	struct string_list remote_allowed_atoms;
>       };
>     -+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, \
>     -+			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
>
>     ++#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, \
>     ++			    .type = OBJ_BAD, \
>     ++			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
>     ++

I guess this is output of running the style check script (which I did
recommend, but I should've mentioned that you should take it with a
pinch of salt, it doesn't always provide the best solutions.)

>       static int is_atom(const char *atom, const char *s, int slen)
>       {
>     + 	int alen = strlen(atom);
>      @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, const char *atom, int len,
>       		       struct expand_data *data)
>       {
>     @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, const char *atom,
>      -			if (is_atom(remote_object_info_atoms[i], atom, len))
>      +		size_t i;
>      +		for (i = 0; i < data->remote_allowed_atoms.nr; i++)
>     -+			if (is_atom(data->remote_allowed_atoms.items[i].string, atom, len))
>     ++			if (is_atom(data->remote_allowed_atoms.items[i].string,
>     ++				    atom, len))
>       				break;
>      -
>      -		/*
>
> ---
> base-commit: 44de1520f08d1dfebc3ab2d9f644208eaa5ac925

I reviewed v18 last, but the diff here looks good to me. Thanks!

--00000000000086bd81065724a359
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9329ec02cdacf1c0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wZjBwb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUJ4Qy80NHNaRWM5MS9zUDN3Z1BQeG5Od0VnUmc3cApJSmRVTWJSbnRr
U2FZTEVnanRJeGFzR2RKQ1F3dCtGd2g2b2lJSXBGYzg4cDNiTmoveVVxR0lhMFlYcW9aUVFMCkNN
SEVuOERIZXdkRjVGMHdZejMyd2xWTjByeTh3UVhPcG01TkZLNGw2aC9WUEExY3VKUnRnS3d4bnhP
N3J6NGUKOVh6UVpXTCs0NnFheks4TXFSZGVaSTRzajRRdWNweVp5aFBieVJHdDZFMW5WUnZYZDR2
ZG1paU1xOStlbnlBYQpYaHkvbDBpWU5oaFlkTVlQTklhakdwMWh1dDdFSTk4MmRXcHdDL0g0WUhV
dUJIdyttekxoQnI2ZGJFdFg1SFg0CkwzbWpUSE1kVG9VU0lKVjE2WEc1M0dOMXJGQlNmbjc1a2Nv
cjdabTgzTUdvMEtLSEFIVEpFYU5WYmpGSHlUTUQKSTZJS0pTdHFPd0h6dW1wZ0M0UVI2blh0TGpu
K2lZOU5YRWpaam5xc3c2bVNxSExwNDNpNFQ5S1o5NXRrb0xMNAoydG1YR3JoaW5McW1SZmsxczZE
SExUQkUvZ0dQRVhZa3RXZ1NSK0JrblF3L3E0Q0ZTRVNpaU9ocDU4ekRzU2pnClZMMGJBTDk4TU1Y
bzFWeFhvSnFDS1NCcjdqKzNnZXdSekxaQTdTZz0KPW94VXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000086bd81065724a359--
