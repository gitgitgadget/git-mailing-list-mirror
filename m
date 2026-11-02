Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793633805;
	b=Pz4ZEOIzsGgfFEXIiovCWfHn5+ZVGcamCvf/yjh7oof3d2b0YKJNcZKfkIp5bz8sMq6D
	 TnACqHpvOu0a3mUs6nbqbXKj1qr4q40fs/+Htv/6fOlt9Nt8R6Zxzpnj+MppZlOj1Huo0
	 SghR7dntfyLZsB+ArIhR3FOaU9A/hvve7NYrelKdu8yQLrCAOyfnnXFNv77B0Lyk3pNqi
	 KOL1bY7QvbU+XXhUvnYyHhjGy3W+H5l1M4FGqmtA9fq9mjexECTAxKf5zAYgFnyk357qj
	 dx7xOayk8NOp5hUB1aa8k6ybJYiqZuiTEsqkErhWQYJlat3GnNa5PkPRIZg+zrZXtuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gaSv7wmyVGwG29uWEWbGBoYMk9gKc63ur9oli218zvA=;
	b=j28eGtdbd7YwqZqrLT71Y+ogtHgHObEV/OCyrgKjJaf/srabCCIpyqoWOgP7x5sTT3gw
	 77Upp70aPob7U3hSgSUArTpq7bWFPUa9yb1D5RetkjnTjpcWl0nHQxVhnMsHsvgDvCh10
	 NxMP78dLP+zZqahYGsS3pJEyD/jL6G9VQcwvSWTxmyggWY4uH2FN4fIZkOISmDzl3OSm0
	 R/jbavEW2RlxRaKfLcMGwWAcPoE2d9ij0BR7JTbdgA871ledBpeS2k8u5DU8bsFEfUuRx
	 VHPB+nFxxcX6r3GaNcsOuWWOLwcO7PQ1hndIVsnR/Xl42Ia1YuCP+Ybh2WMb1FUGZ1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cf97UKMV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AD60A5626
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A2AD60A5626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cf97UKMV
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-18cdcfc05ffso3588462c88.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:36:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793633804; cv=none;
        d=google.com; s=arc-20260327;
        b=RNuhHw3VxFSgqVnM24gqya7Tj2ahCrmR/YxlgyDYSVOalYb/GfDT64RuVH1r6osSPI
         p7o+vBnCXw1DbecI1IV8Y/R0g4j5wmbXvDwsW1oYBZADfdMjLxzZSPab1P+MVdAwk/Mp
         nbIwIEOB/9Mk3pj1CoX3tg0ybiRIxEonsrAkQ0re45KQ96ecMZWHORsdXDseqgu9w0PW
         GnRBYZ4Bl2Lejn8lXrokUFEUxmjRDmXo9DdvspnGHUzE3AxfVx6PNCZGJLV/wdvirfqR
         ImzzrN4gKhWy8E8mZP2yl7zObTOXf5ASv2ZTalM/WQuZBSiqaLBWD1XCI3ScsNPtEjb2
         sgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaSv7wmyVGwG29uWEWbGBoYMk9gKc63ur9oli218zvA=;
        fh=9Dtf5cvvlGVK6PLlUKwkyzVB/bvnsDqG6QPdMs1iRQM=;
        b=jaR+kWjjOmGwYPJ2799YQXV86LNVi30KHPrzAU6HuCfjFdSCIL+OtolBtexLcX2Mcy
         yJ6mAgDZ4ws9bXDFOt7eaAEpTQdQNo0BHVhmo0nAcaeWaU+rSCo4gPxFYEfOm/5aQL5u
         IvP/5N1Aa7+Hz7WOtTCH+w192d0n1ou1K3okTz1H/Ef46wDb5/SZW2UfbQvMmk8Gl1+t
         LQYvLz7U4bXOw79ErSgxeZE5rZ+OyZpOkgWNYM+egbwx2jATW6wl9DkuC60Ld1gntaAH
         2kfy9F8YdKYrcjJuvZjwNlZiPs8jAJ1LtTnuXlowBqzXYakcl1z4oWSbsAaqsTJflNW8
         1n0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793633804; x=1794238604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gaSv7wmyVGwG29uWEWbGBoYMk9gKc63ur9oli218zvA=;
        b=cf97UKMVqYOxSW9Vm4zbliDUayDKT0YzeSzXNqoV1hOpeZiep2bCWVY4tnAOmOEvB+
         wJ0/p/HWbKlO5zaBiqZDip6eOkjnc/AvbDPFuUNV236Og4k90sGVYqNpsV9eXWYyN3fX
         uMuVo8u/NlgaHVttys+ukkvxInu5n1OMN6vXN87nXsylaqC02gwyuv9wix/RTpxyPvkp
         D0ugIOkIaqn3Jhxwasfqm823z5INnxFD8NJdtcWvNK9VSfqWt6d9m3It7SkwSn6+VTuk
         2JdtyJYbZ0HCSiHbkj7YUpadSF9uqaw8Ako29GNGGDDgOepLjWyUv8hUmtiaeY5bdjWC
         hl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633804; x=1794238604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaSv7wmyVGwG29uWEWbGBoYMk9gKc63ur9oli218zvA=;
        b=R/hrGEoS6IN5ENIVxtxB94UKiuRnVCeTaqfAg/EdgUd/6A694kVfXX/D6vPlSy4lrH
         p9y2r681CmGj/4DMiUW7o+yyvHdwryOtnb4a00wqKjvfySnH6BguU59+smjsGdxYKIBJ
         9Y8R4j7TbWEfJUdC1uZxwN10PXWwyyIMcrMhHLXppE8nE1ENTUlI0xYE2pORzuQvF6/Z
         OnLW28WgElI5cO8EKMShTjk8fTqhOovNLrERmd5U+85VD2wrydtobaatuw4eWyeSUusO
         KByS4KAYnt5EKEFP6MfbseY2b0Es+T6ld4IS3jqgABIkYFs/znlOb4F+uV4PWZxX1eNb
         yiew==
X-Gm-Message-State: AFq9FYKD/Q7AMAgqZdiw2pIlRnjR5zhzyPRoEtxWRwh85aLAjWfFOpIv
	m6yqPE8cB7xlyMfpnQxLYDNl2DHGYsq6YD7THav/4YmO/2CS5DmjvXEGk/5ZRrys9U1IHDwytHV
	L+hd1GG8O2dYT4ggog8cEasNwV7J2K0E=
X-Gm-Gg: AYBFou2lE+aPJITJto9dBnVkeABx+GvBb9YLXR6YMz8NVikyn/9u3KhbO5NwghMnX3m
	WDVknM3M4YOHujCSCSgZqZEFf2PvZ0RfB2fuUzyHkPW9y/JuVi4MkiVsqWRq3S64jJx2IHEiDwS
	PA3T7PBFNIlN7dybcp3Suyn1MoEaGje+JsaDilW4XjqnBR4I072w09CwOE9VesWftHsflTjTHPn
	VsjEK/fLnwQcQiPTbh5HPm5M4GvOAzcNYwN8ZPb5s0Hd0xefB39d0L2OkKyfkdax6oqXUC5oDIm
	FgFFFQOkMCbCHGeyYz2wjngLmgmT+9qw7QY/q/k40+ZOavHYHDZeOeJ58lZqKaAAoNfhE4NTkdB
	79J1QN352KxzsJKZUgLi9T0NRhgHokOxHtjqVtdFMyY91BrUPBRAOsZhA3YZG0Fih431ZMy7mJR
	qg1x98qt1l+iB+N3rM7Es2R/VPyEfOhFbYR8dsVtkS3hxcqlmaLAJ45m4VKfPELR01qaiqTbomi
	1xxfaGgiDun6ew8I6w0VQL64Q==
X-Received: by 2002:a05:7022:d82:b0:191:444:425 with SMTP id
 a92af1059eb24-1ac56302334mr14838537c88.2.1793633804297; Mon, 02 Nov 2026
 07:36:44 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012074413.337183-5-christian.couder@gmail.com> <20261031142255.4941-1-herroyalpriestess@gmail.com>
In-Reply-To: <20261031142255.4941-1-herroyalpriestess@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Nov 2026 16:36:32 +0100
X-Gm-Features: AclHuK_79vQD_ZbzXsXOP5C_FUBi4-AnBwVciSvjdrUtQrof9ZW8YwL37dIR-bg
Message-ID: <CAP8UFD2m+wpcgqB2SasWLxyekY+5khrYyPkOuLoYwANqZws8fw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] fast-import: use early_scan_options() for --allow-unsafe-features
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, kaartic.sivaraam@gmail.com, 
	ps@pks.im, newren@gmail.com, peff@peff.net, sandals@crustytoothpaste.net, 
	Johannes.Schindelin@gmx.de, jltobler@gmail.com, cynthianuchepro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cynthia,

On Sat, Oct 31, 2026 at 3:25=E2=80=AFPM Cynthia Uche
<herroyalpriestess@gmail.com> wrote:
>
> Hi Christian,
>
> I read through the series and ran t0040 and t9300 on the
> cc/early-scan-options topic, as in origin/seen (tip dabb68a20d).
> All 118 tests in t0040 pass, including the new early-scan tests, and
> all 261 tests in t9300 pass, including the new R: tests.
>
> > +      * The scan uses the same options as parse_options() below, so th=
e
> > +      * two agree on which options take a value and on abbreviations. =
In
> > +      * case of doubt, the scan stops early, so unsafe features are th=
en
> > +      * refused rather than wrongly allowed.
> > +      */
> > +     early_scan_options(argc - 1, argv + 1, fast_import_options,
> > +                        EARLY_SCAN_STOP_AT_NON_OPTION,
> > +                        option_parse_early_allow_unsafe, &state);
>
> The call passes EARLY_SCAN_STOP_AT_NON_OPTION, but the 3/4 header says
> to pass it when parse_options() is called with
> PARSE_OPT_STOP_AT_NON_OPTION or with subcommands.

Yeah, the end of that header comment wasn't as helpful as it could
have been. I have reworked and improved it. In the v4 I just sent, it
looks like this:

 * This requires the scan to be told about the way the later
 * parse_options() call treats its arguments though:
 *
 *  - when parse_options() is called with PARSE_OPT_STOP_AT_NON_OPTION
 *    or with subcommands, callers should pass
 *    EARLY_SCAN_STOP_AT_NON_OPTION,
 *
 *  - when parse_options() is called with PARSE_OPT_KEEP_UNKNOWN_OPT,
 *    which disables abbreviations there but not here, callers should
 *    not use the scan.
 *
 * Passing EARLY_SCAN_STOP_AT_NON_OPTION in other cases is safe, and
 * useful when the caller rejects non-option arguments itself."
 */

> That is not the case
> here: parse_argv() calls parse_options() with only PARSE_OPT_KEEP_ARGV0,
> and the table has no subcommands. Stopping at the first non-option is
> the safe direction, and it matches the old loop, which also broke at
> the first argument not starting with a dash. But the comment only says
> the scan stops early "in case of doubt", and does not mention this flag.
>
> With an input file containing
> "feature import-marks-if-exists=3Dnonexistent.marks", I tried:
>
>   ./git fast-import --depth 5 --allow-unsafe-features <input
>
> which succeeds (exit=3D0), and
>
>   ./git fast-import --depth 5 extra --allow-unsafe-features <input
>
> which dies with "forbidden in input without --allow-unsafe-features"
> (exit=3D128). The stray "extra" would make parse_options() fail with a
> usage error, but that only happens after the stream's feature lines
> have been processed.
>
> To see what the flag changes, I replaced EARLY_SCAN_STOP_AT_NON_OPTION
> with 0 locally and ran the second command again. It then failed with
> the usage error (exit=3D129) instead, so the scan had gone past "extra",
> seen --allow-unsafe-features, and the unsafe feature line was accepted
> before parse_options() rejected the command line.
>
> I would suggest adding a sentence to the comment saying that the scan
> stops at the first non-option through EARLY_SCAN_STOP_AT_NON_OPTION,
> even though parse_options() is not called with
> PARSE_OPT_STOP_AT_NON_OPTION, so that readers know why the flag is
> passed.

Right, in v4, I have improved the comment to explain why we pass the flag:

/*
* We don't parse most options until after we've seen the set of
* "feature" lines at the start of the stream (which allows the command
* line to override stream data). But we must do an early parse of any
* command-line options that impact how we interpret the feature lines.
*
* The scan uses the same options as parse_options() below, so the
* two agree on which options take a value and on abbreviations. In
* case of doubt, the scan stops early, so unsafe features are then
* refused rather than wrongly allowed.
*
* EARLY_SCAN_STOP_AT_NON_OPTION is passed even though parse_options()
* is not called with PARSE_OPT_STOP_AT_NON_OPTION, as any non-option
* argument makes parse_argv() reject the command line, and the stream
* should not have been processed with unsafe features by then.
*/

I also added a small test for `git fast-import --depth 5 extra
--allow-unsafe-features` as it looks like an interesting thing to
test.

> I did not find other issues in this patch :)

Thank you for your suggestions and your review.
