Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792061;
	b=1VtLA0+9ozTo8nyIauw+OvwGZf/gJjceGJoX5c8F7HHnbSzpUz2YB7H1wb+5p76Tu+kM
	 zrUA6nXqlp/3LVGjNFrhqkFkYqsVZQZE9NOvy7x3Ppzoz8MZMng+6usBnIEuDspuZ6vHA
	 DPnM2y94aGebty2RocK34xWpBKfxHsZiNMpTmzt4lfYr/Yz0wCzV8/imgtWp8SMFQ+zYw
	 uk7jQP/mZPKOocp9nhdfMk0zAXHFBXOdyuuAB5LYbXbg7zzkYFMleRN6ODcuN8sGCEqur
	 oQTN+WFrnL0utsGQieE12sNjcDgLNN+sLval28DNxAv6zyXneEyrQUgJgpScZ5mkxGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=IApPpva+GWvTBi0HbuEXLnRUm1/kCbGG3Q3dyk7JY7Y=;
	b=nqGtgzFPX4CTmErtUw3lUbb2V0tmZewTkiLgaxUY7y2j2Fi90XLN2h9pySn7rxTCD8tk
	 3XUYD84UNqz4oFmsynqYbN2iZxG5nWRFq9Efb2vYoGK6w5sQ5JcF76T374yJ9gAXkXSz9
	 X5LV1axSGPX9rz4WSI89adV9lz4crr2kvNoXC2QClvjw3jhlEj4DoPkNN6O0IGMd+3NFC
	 /66mXqnbAeYSuzmpBWTM4nHl9A4Jcz0+4DySZqgbK74VA43XdjCiZTPO6WH2g+GhySoGY
	 BitTIGNPrywTSKv91tCtXoYljTUKOsFLDjik3BUzynjfKH+kXCzj9Qo5ywPPjbM8RVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WDAbatAS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kytOqgiY;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D1606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 15:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WDAbatAS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kytOqgiY
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EAE41EC0B1D
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 10:07:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Nov 2026 10:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795792059; x=1795878459; bh=IApPpva+GW
	vTBi0HbuEXLnRUm1/kCbGG3Q3dyk7JY7Y=; b=WDAbatASUMzWEvNfwX53X87zgb
	5ihh850aI+kTNUrTqgHlqjtiPa2mxFKV+oNEVGQjzcxZES0gir/6J6zzVtZHD/OF
	ccoioZgN1yG6E3ywNTVQZ8/O0lsPLM2vx1GDCp9wVtbrsABl57eF47yOrW8VFEn+
	tNag2sv8fIt0uVfmhpZY08XntXIDedxlFJv6Qs7fiEA1qOtZXsRJwxdOzYiyOA4P
	Em/wV3x58yfylLVoSOru5jzLoPsRE2PIf1dNaJX5I6b5h/3SCA/4ZXyOoRmCUUU0
	0uZQuawwa5rlec5bGfxV3o3KdryyJAWs2IA+By0Bs16L2GbOxeVlf4BwrV2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795792059; x=1795878459; bh=IApPpva+GWvTBi0HbuEXLnRUm1/kCbGG3Q3
	dyk7JY7Y=; b=kytOqgiYGYND3qQqi0Dn6G7PIaYF7cHOcOp3enHfPeRAvXQ2f5/
	28MEFPH0pfn+c3VJxzkA/HeU32o+K6IKIVvss9qE2rpmxWkeZekTibXE90rL7mcd
	RiES9AT6RCFbBI614w1QxGz3ELG/Wz7Xoef8pqUiyXRv02zo3Z/hplU31fGdP2eE
	US1aOMuKLtfJZckJY3AooO7rlTqFPp2BZZWvuwbOTzzYEaouR64dkP3YtQyiLpun
	wYOWYxAg5jW7Oo+Na/3ghKqLwEXWE1ekSX/IHlzANqoacuD2D5JgA0gtSnUXNvhL
	8Y46A4IqVmpQijtje70/Z8OWXPNOR1X2kIw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795792059; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GX1d922marFU+fwhAPzb6Y6plAS7L5S4P+rDxWewhvFPyUB
	rPE1PtIFALKIe8roDhOWPqWBDIQbOh+Noa5UuxkPZOJvcCkg0244eNQ1Gy545JxZ
	JVuHYUCv50AtT6jiPZSOkuGJW2m33LPvB+o0FPNsB34wqPCgEfAhAqbQGnFRcXWD
	47hkQtG+k+TTm0929NYv18RdlLer25oqBDm9H1Rao5FzxCXNq9RF01XylLuhtgZJ
	4a0Gz/FzD6oKBZ1S+JthkDoE+0VAzhnW1EzpfSuUQRtfISa3fSkkOYyuR50Mj20I
	/rPf5MvgIvkIIvuifAYOzdHD86OWwCqoki55Adg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jlZW9Xsv/+yS2yGBVUoSMko7xGMttajVAXJDMjv78XA=:5A17Sujj1xW3aFd0PZlkpOK3UqhopDG21q+UVzR2R5Y=;
X-ME-Sender: <xms:u5wJaz0_KlHsRThvHF4K52YHsgrxE_9_TBBB-OTnHapqLGPy_-o6gQ>
    <xme:u5wJa5F7OBlfoHcZpmdpMmPUwH_2aP6TKIPxxI8qI_A8gfVO3PP_07cVNGlO3gInW
    5WjpdS-S_JVpMcgBDkv-HS5ZRuKlXZ7viz9huTYawGxeDXa6qt-hIg>
X-ME-Received: <xmr:u5wJa47wppEDVam7KHya2dFhcWmTmcOsN3ILJURJmV3l-B7ZcGQRKi60qux0NC_J2idBGfNdz03_wMNO1KGlD4dtdjoAw2x-a8M4FWE>
X-ME-Proxy-Cause: dmFkZTFUfdulX2SnLOZmIZv+aIQcKzGzVprZMHjwuRmd6ITJLmm29qFNiWIGTLQ4/xCfMV
    xI+jSiB5NdjQOS0xQxM/sTSlS35GOyE0SIPGT388TCugCB1co8SY5yeLc8dQOac1HCIaJF
    ZTOShGLfS7pbcEW2tdf0aVnHNiXiiwrDAHxtGdtxw/DxICMg8Vke3N+Ax8q8pOH4zyWg9z
    aUZbPYT9hlgBJDT4MDGoQJplRkPLjeIhY/t70/IDvExnQ64iCJ9ZPHlycnEbeC0vqnNF23
    yvm4xWza2fWIifrz5o6+w9XdHqOaOkr/MrSpwfnR2sni5YNrvCmxfAHzmuCImua0BsK/Yi
    GOF8Aht45nWXUFSJRcqIPw059TtVEZTntD2fojW2q2zzv0NjXIjctDYu9FHQy+2ixoHXys
    ftWbVwg7zthb7t8FaZlTJl/GircrhfcT94yFvYzHMuQvm2BKr8IEBAwyaQZ2k0nXx5ED3N
    XqyfnsKNjOSCHtJFhln6/wZjF4xV4s2lGfhNtvo57FNW8fifB1e2WcGNjos8Iftrdgc9Gw
    7zhgTNEcI2CTjulpF65I4yJtK1PSfJPFLF37wc+XvcxV6w2bXe6pSMuIFSifY+4jHrmxXp
    3rJ2zx4UwpSuHWdfBrqa2otjgCjsD3A418yjvCfdWeA4Z6UUH+kyeqpJpEpQ
X-ME-Proxy: <xmx:u5wJa3sOPMDP0TiZuc5r2mA20M3GXsIJY8Rttv7Biyo-bt8JcrWT_Q>
    <xmx:u5wJax7iOX95fAA3PfoWK_7SxgEQkA_WC-NLHBUigtkGoj4oC7YgAA>
    <xmx:u5wJa6WICvO0_riDkpsG_fXgHwyYZO2AWZU5oCUeeejwd-arTR4Ncw>
    <xmx:u5wJa79_R4ir4CvRJhX82nfHgRt9x_1fFY2lylgUcb6igkZIhyOXAA>
    <xmx:u5wJax9N4LaozgmkOFLRIgqP9Ot0Z0yI8Q9m1xPGGkUYTTDjt6wBCdOy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 10:07:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 2/2] lint-docs: ensure command-list.txt lists all guides
In-Reply-To: <20261126201110.9046-3-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 26 Nov 2026 22:11:10 +0200")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20261126201110.9046-1-taahol@utu.fi>
	<20261126201110.9046-3-taahol@utu.fi>
Date: Fri, 27 Nov 2026 07:07:38 -0800
Message-ID: <xmqqy0aecnyd.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
> index a0ea572382..87a652bd22 100755
> --- a/Documentation/lint-manpages.sh
> +++ b/Documentation/lint-manpages.sh
> @@ -1,21 +1,27 @@
>  #!/bin/sh
>  
>  extract_variable () {
> -	(
> -		cat ../Makefile
> -		cat <<EOF
> +	file="$1"
> +	directory="$(dirname "$file")"
> +	shift

The first argument to the function becomes $file and then is used to
compute $directory; and we shift it out and loop over the remaining
arguments.

> +	for i in "$@"
> +	do
> +		(
> +			cat "$file"
> +			cat <<EOF
>  print_variable:
>  	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
>  EOF

The fact that this patch does not touch these three lines gives a strong
smell, especially the reference to "$1", which was part of a single
addition to the target Makefile to ask what value an arbitrary single
variable has, dating back to 2dd100c513 (Makefile: extract script to
lint missing/extraneous manpages, 2024-06-06).  Now that you are looping
over a list of variable names in "$@" using "for i in ...", shouldn't it
refer to "$i" instead?

Because 'for i in "$@"' does not alter the positional parameters, "$1"
inside the heredoc stays bound to the first variable name on every
iteration.  When the script later runs

    MAN_GUIDES="$(extract_variable Makefile MAN5_TXT MAN7_TXT |
                  sed -e 's/\.adoc//')"

extract_variable() invokes make twice with $(MAN5_TXT) both times
and never evaluates $(MAN7_TXT).  None of the section 7 guides
(including gitpacking and gittutorial-2) are ever visited by
check_missing_docs() because of this, I suspect.  Have you tried
introducing discrepancies to section 7 entries and seeing if your
version detects them?

Even better, instead of running make multiple times, use something like
this (warning: totally untested)

    vars="$*"
    (
            cat "$file"
            sed -e "s/^|//" <<-EOF
            |print_variable:
            |	@\$(foreach b,\$(foreach v,$vars,\$(\$(v))),echo XXX \$(b:\$X=) YYY;)
    EOF
    ) |
    make -C "$directory" -f - print_variable 2>/dev/null |
    sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p

perhaps?

Unlike "make -f -" that feeds the top-level Makefile,
Documentation/Makefile has a conditional include of "doc.dep" unless we
are running "make clean".  And doc.dep has a rule that depends on
$(docdep_prereqs), which includes cmd-list.made.

Does that mean running lint-manpages.sh in a clean tree causes us to
build doc.dep while it attempts to extract MAN5_TXT and MAN7_TXT and/or
fails the build altogether (we cannot see, due to "2>/dev/null" in the
above script, the error message)?  Have you tried?

It might be less error-prone than the above gymnastics to add a new
print-guides target to Documentation/Makefile, next to where it defines
the print-man1 target, imitating how the print-man1 target does its
thing.

> -	) |
> -	make -C .. -f - print_variable 2>/dev/null |
> -	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
> +		) |
> +		make -C "$directory" -f - print_variable 2>/dev/null |
> +		sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
> +	done
>  }
>  
>  check_missing_docs () (
>  	ret=0
>  
> -	for v in $ALL_COMMANDS
> +	for v in $ALL_COMMANDS $MAN_GUIDES
>  	do
>  		case "$v" in
>  		git-merge-octopus) continue;;
> @@ -29,6 +35,8 @@ check_missing_docs () (
>  		git-stage) continue;;
>  		git-legacy-*) continue;;
>  		git-?*--?* ) continue ;;
> +		gittutorial-2) continue ;;
> +		gitweb.conf) continue ;;
>  		esac

Placing gittutorial-2 and gitweb.conf in the top case statement
skips the "test -f $v.adoc" check as well as the command-list.txt
lookup.

Moving those two arms down into the inner 'case "$v" in git) ...'
block would exempt them from command-list.txt while still catching a
stale entry in MAN5_TXT or MAN7_TXT whose '.adoc' file disappeared.
I do not know which is more appropriate for these two entries.

>  
>  		if ! test -f "$v.adoc"
> @@ -84,9 +92,10 @@ check_extraneous_docs () {
>  	)
>  }
>  
> -BUILT_INS="$(extract_variable BUILT_INS)"
> -ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
> -EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
> +BUILT_INS="$(extract_variable ../Makefile BUILT_INS)"
> +ALL_COMMANDS="$(extract_variable ../Makefile ALL_COMMANDS)"
> +EXCLUDED_PROGRAMS="$(extract_variable ../Makefile EXCLUDED_PROGRAMS)"

Note that all three above read variables from somebody else; running
an extra "make" process might be warranted.  But ...

> +MAN_GUIDES="$(extract_variable Makefile MAN5_TXT MAN7_TXT | sed -e 's/\.adoc//')"

... here, you are asking for the values of variables that are defined in
*this* Makefile.  Why can't you inspect $(MAN5_TXT) and $(MAN7_TXT)
yourself, e.g.,

	MAN_GUIDES=$(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))

or something?

It might mean that almost all the things I discussed in this review,
including all the changes to the extract_variable() procedure or the
addition of the print-guides target, were unnecessary.  It is great
if we have to worry about fewer things going wrong ;-).

Thanks.
