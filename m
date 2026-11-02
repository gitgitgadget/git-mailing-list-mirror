Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613677;
	b=hhOayd9AtY7y0mw52GqDJ+wYRh0NglAd/HNLf1HD5wezBpDW89+zO3Ilu3w5p68I/xVU
	 ZKhRnWrxF6rq2YCnoDIYqOULgH4U8y9MPcRRfak1Zdf69N9Jf3N37SssN9/NuuBj1cmCE
	 D8jUIR/mn6NwxepjJ5oyQlDzYMUCXG2sX3tIJyuKnrZp8DvXRic8EYkuu3m9fa9SuNqwF
	 m/ixUbiN5wj92OqrMC3loREn3lkyD6OLtKd1+9zURKEIcx/cAtP7jH3dw6jeryJnjLbeE
	 IiHA6W1h7+yUZ2eLY4RNFlKtC9c74AEsVMmRjsfoqGow0SaHL2kFJl/UEvTAklM2CKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613677;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uJ1H0wJ/netMRb3XaFQ58EykPiFcsD+EdnN8847+Nyk=;
	b=TSjI/LpahoftxFpTqa+iPClpeAAXGOVBAEemOr30jXlti8uaxU2knU1kHxo0pw2N6BT1
	 t1pN/LcnrO9EZhYl1IOlKm1aRaC0Zbb40oWL6Q8sgnTNm6s9OhuWluWBO87gz9GqyS6aN
	 qVUfY1a+p7+zhshmnYYgbn3LOTzTUDClKJfZ/ZUotUK057Kck0vrXnvjc0vE5IUsUbXSG
	 wQyZm4oX2S5O0WUuW4vqZp/HfAbL59gGh9IMTBFNvAfyJM9dL67W3XYEyZ9EufKmkmMBW
	 isnMWPGdjYWiKYhqqMmbGXJFZx87A7qvM1IsoCUjC6i5pZX20aghtJSi16jMn/YRk6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HKJUfLEC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UF9Zvmua;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD16606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 10:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD16606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HKJUfLEC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UF9Zvmua
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 807921D0022D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 05:01:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 05:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793613676; x=1793700076; bh=uJ1H0wJ/ne
	tMRb3XaFQ58EykPiFcsD+EdnN8847+Nyk=; b=HKJUfLECHrWtSOhmZg9kvCugqk
	rJY0rxWnoXNGZYMO/wJIuHZ7WKVIhvWj1h8FN4PMXag/5GE+XpWV+CU4/JofJGMN
	B5540U5wQ6ljkLo12BA/PNyvxzIYr/0c8HQ3CK+b/tQ52atksTEhYtChOFRnYoVT
	PwkIO4ajvhLSPyTH6OkHOtyQXhVG5YkqPyiVhusrW44X/NxBgHWKZsv+g85kWSUZ
	/EcHuZwRi0IGXdtrHWWyxXCocaI1fjJatBAysGNtmn3mBTHJ6pjSOJyk6G2slQ/z
	MUHtPsEhGdY69bYE9Mfhb8UAPeVq7FlG8ky+x9rPMbsVxmByqfyCBGQ8mpIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793613676; x=1793700076; bh=uJ1H0wJ/netMRb3XaFQ58EykPiFcsD+EdnN
	8847+Nyk=; b=UF9ZvmuaoSayEcL2tMEt/Z/6k8Pw3EEkgCWFZkb5m/0XJRt+ZvO
	Hv09tPCI6KXDuTDIMtT2Zv2GBrDrx603YpCvw841yuaRK/aYl7p8Rc+cD5XyyEkX
	bhTnr2fbUfVeiQ5krE8DAdWAvytg6FidsnEG/KKq3TPrcFUmuDXEmOpONnzhYx1m
	IRrDf0mHwh7SpSCzT50tdyo/VJlSpECCdd+77UCuuYcdF8DLhqPf3KiapDSVhv3x
	4BVCwR9zKebpvBHYKjqT/0HSaUveB7r6MgBYcYeJezzpg04mfSKGHw2s+nLKTfpQ
	06AQIMS4AtT4R8d2xo9UbnBcHI0BcoJINFg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793613676; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ISu4lQC58AzSUGjuebaloK9fa5Si/SJBlzNWvcBljoJC/dl
	SM8/OtNN2a2CHlV4ugk/+JN1CtTa0jbY/gZLgonUXRUvJOUwUGS+ELxS6a3tcNCp
	RfDFAXvPi9IozDo4lVIoDAoRKwZkD1sq+W3gDfx5JWdIu/XfAf0M/v+eLrIGx/98
	UOjVIMoqfo3rw2Ecx6KoHoC+0HwRKzR9nfED5PVW3F7GPts0wt+Pp9bZbeWsul42
	VjzRNxsUNvFZWvFELF/rr7MtVSCHJjbJdb5j9xI5gvEnX2SR+p4OrpDa3CRVoSPY
	CvXDs3UJP+Apx5yhuzY32SfFaQdTHDbxxH33qJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YYcHjXto1bZU5eGgdg//0MD2D4uGtWnZpudNaqSQnxw=:TIDLvChv/QOd5PI/oEseIUk4WpR6lwUNLV231f8M5/w=;
X-ME-Sender: <xms:bF_oasnG679NVneI-kCm3xWk1eNaCMNSj8YkHkq83g-ruKDdZuUAzw>
    <xme:bF_oajQxGs3HqLvoHirc2M_mP_q_SU4PsXr5VjRiLaf6cJPr19UnU-cA6jPoute73
    Wx3WvZXEtwbEKOcdfjZYwZG7omj-ZOfWku0LWNr2vj6p0dCcxNTAg>
X-ME-Received: <xmr:bF_oaoCzyYQVfftWIvYu7iGjVo-53hQKQugblfIxW7D_8KLPfA9I3r9mbmRYmivH4Ekq1QEWfqu9L83psJlE4R3sJB4Nrkf8q3Jc>
X-ME-Proxy-Cause: dmFkZTEpvYP8W1IjmMhdykHQK1UPIYwGyHw1id88TJ7+2U4WQnFZ8hKDaw5k1Kr7mrR3gp
    P64FIn5nSX09OMyqpDZYlS2OS04mjlI9VGdtCh+CxUVqALXlmbc4dKtvRJ/EUnL3Ccr9qD
    +9AVNAclOLvoxPay1QDrsd8Wb71EsFqmDab/E1bJJ5wmKqlzD8eXBZHsviLe/c4sjMxYrb
    tntGydE6wibQ8KqDhGWDhNh3BCJRgWDXu2Bh33syUu/9iLWQEZMsPUa7Gmjtch1Eo9WlM6
    CFOc8bJkyGjp9dv134mYSsbLxr3xQp34Xd1+zyT4sOBDhCTti4LO5fHXz7tqHvCV1h8MFm
    buGZnVFOfKoaVeWtx/MQLN+xj9nWjeRZetgyiwDYozRi1s/XoziAArzHnbd01MifzfDZw5
    umrHvooWh9lecZks8piPwcWfxtBqZr5oTz4BJRi6wDf5zsC3TWKKq6J5cRzwQ+G9gbd8+d
    1d8a8K99MCxzK4hqbM+qhXsRqTb/QC/sbmo1RDHGuPWadrpSwjvQU3ER8qalPbiKzCKvfi
    YEL/j+8hL9yHHbE6oTWwZhyHayigxedUTZUXhwmi+eBIJuBKv2KIM7MFgklqLF+NXMfn2M
    04ExAneoDqWVI8r/LOdcF40TG6XqndeojwosjnEhErwbxlK2bIOdVp40WBgQ
X-ME-Proxy: <xmx:bF_oaiTx8CPeQmNTjA2y-ucrEsHE-UXvTn3vItY2eSqn3oY2AJuRKQ>
    <xmx:bF_oaup_zrVcH3P90RsNuQgiYWy6uFUX_LZ-WW_oCw9vsOshphDfpw>
    <xmx:bF_oaswzItJ2jDxo8QKit0aAdv6ZS4psVirgct528-Lo8UghiCRUOQ>
    <xmx:bF_oarJf_EjOITLV3buG47Ppk8jqfNCwe46pPisA_WsNTpdT-DH3aw>
    <xmx:bF_oanTkyVlZ5G8ZxKcYsfVf2rsueYS_w23e-kiufbvOhCgRsJppKVFj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 05:01:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v6] builtin/diff-files: convert ad hoc option parsing to
 parse-options API
In-Reply-To: <20261101192502.1920-1-edsonwasswa54@gmail.com> (Edson's message
	of "Sun, 1 Nov 2026 22:25:01 +0300")
References: <20261029203904.432-1-edsonwasswa54@gmail.com>
	<20261101192502.1920-1-edsonwasswa54@gmail.com>
Date: Mon, 02 Nov 2026 02:01:14 -0800
Message-ID: <xmqq8q3blfh1.fsf@gitster.g>
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

> -static const char diff_files_usage[] =
> -"git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
> -"\n"
> -COMMON_DIFF_OPTIONS_HELP;
> +static const char * const diff_files_usage[] = {
> +	"git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]",
> +	NULL
> +};

The loss of COMMON_DIFF_OPTIONS_HELP here gives us a regression in
the help output ("git diff-files -h").  By replacing the single string
with a string array and passing it to parse_options() or
show_usage_with_options_if_asked(), the COMMON_DIFF_OPTIONS_HELP
macro is omitted.

Since parse_options() or show_usage_with_options_if_asked() only
knows about the options explicitly defined in the diff_files_options[]
array (leaving standard diff options to be parsed by
setup_revisions()), the common diff options (like -p, --stat, and -z)
will no longer be documented when the user runs "git diff-files -h".

You probably could shove COMMON_DIFF_OPTIONS_HELP into OPT_GROUP()
or something that produces static text in the help output to avoid
the regression if you really wanted to, but given that "diff-files"
is plumbing meant for use by scripts, I am not sure how much value
we get by rewriting its command-line parsing.  Being able to say
"git diff-files --bas" and get it understood as "--base" is
something we may appreciate if it were a Porcelain command, but is
it worth the hassle for a plumbing?  I have to wonder.

Especially when the parsing loop the patch wants to replace ...

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
> -	}

... is not anything that is ugly or overly hard to understand.

I dunno.


> +	argc = parse_options(argc, argv, prefix, diff_files_options,
> +			     diff_files_usage, 0);
>  	if (!rev.diffopt.output_format)
>  		rev.diffopt.output_format = DIFF_FORMAT_RAW;
>  	rev.diffopt.rotate_to_strict = 1;
> @@ -73,7 +74,7 @@ int cmd_diff_files(int argc,
>  	if (rev.pending.nr ||
>  	    rev.min_age != -1 || rev.max_age != -1 ||
>  	    3 < rev.max_count)
> -		usage(diff_files_usage);
> +		usage_with_options(diff_files_usage, diff_files_options);
>  
>  	/*
>  	 * "diff-files --base -p" should not combine merges because it
