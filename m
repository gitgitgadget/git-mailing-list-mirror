Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801354;
	b=tV2pkjuHnTmif3nL1j8fDaY7ypkwyH3XSZI1CvNCBlG1VbtYr1alOhqyWyh3bAeRlaHG
	 Q2A1Vbu/+ux/ZjGh6YFxeLyHSP9Z0lwWYsHSEI0KP8j2PasIJU94GLd7mqlaKXjLsySJr
	 Y2dwb6NitubmuZm2UUK14bcK8v+yqXyapANFmXjVPTzqTJnoZDBQGLYLKf/P1bhltpcwM
	 Sn3zVCE+jj1k+ICevL/3QnAGtcxjnfLk+iiNzQdDpsy40+c4TXxF7u102L+/wN14irefH
	 LhEjXrGV3B40HU2qpIidbcJ6OABmagz9DuroV/6RtHlQLPS9m1LazWJIbsRttBL4hCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801354;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=HQgMnKR2/FxMbClVY2YmG0ZEj8ZQNPn/W8gV/KU3PVk=;
	b=Ao6Er6V0znBecfaRpup3OHGWRRui9lK0voobaggDF9Lgt1UYjoFK0dppEHxKfw8D9lLj
	 Ghb+ItGhfcKHiM1d4AI0NDhwYvcI7oX2NDIS3jKhG4TBAl3YwP4iCY/gx5pC1WUZIm5Mn
	 aDF03UADaNmq7FZP/RVW9Gk/bShzjioZL0Z53M+dKiyuJCKmJiQXuvM6ZLKJxwfeS8Rjh
	 RRspmcOxWAo2bAUxQxOK02he/iJxET5uFWSRRSRJp58ryMR0Ist9k/kKgv4bdLGXdIrN5
	 VOVjDlgzAawkyuFioDWMSGWdZLJ+UAJ8vpCqHb44mBNLPnsKVKMDmB9+4dEL16dkm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=cBDPWOWY;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4094606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 17:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4094606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=cBDPWOWY
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6ARHgO6J025081-6ARHgO6L025081
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 27 Nov 2026 19:42:24 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xWzxo-00EGgk-Eb;
	Fri, 27 Nov 2026 19:42:24 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 19:42:24 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 7d387034;
	Fri, 27 Nov 2026 17:42:23 +0000 (UTC)
Date: Fri, 27 Nov 2026 19:42:23 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 2/2] lint-docs: ensure command-list.txt lists all
 guides
Message-ID: <20261127174223.Yr6v-%taahol@utu.fi>
In-Reply-To: <xmqqy0aecnyd.fsf@gitster.g>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261126201110.9046-1-taahol@utu.fi> <20261126201110.9046-3-taahol@utu.fi>
 <xmqqy0aecnyd.fsf@gitster.g>
User-Agent: s-nail v14.9.22
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
X-ClientProxiedBy: ex19-07.utu.fi (130.232.247.47) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gCHQQBCSgC
 HgYbRgsJSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=HQgMnKR2/FxMbClVY2YmG0ZEj8ZQNPn/W8gV/KU3PVk=;
 b=cBDPWOWYxxUD1bu5qm1x7XeSyrw0aVzVuEjfSmhXEqi6fKIBLRDxz0OJTY4L7JRfRo0i4ZknHJHL
	UqD1qkQ1bovqs8qa3U8G9agt78I5KSNeiQWISCY4pF+2xADiWIBUY5gAmKLOhZqaWJcON5aK5Mmy
	PBAeyuoPjjhanxYAke5Dyq0oHNKU/Y5DC9ZIh37oGh8qhr75lqI9E8zynUoSQRTvwKoXjTzxmRuu
	+fh29qyYLiYZGpwrg113nSjURJnjV6vqXev4kGnlNoS1y+A6WIVxUzWNz0hyS9KPQ4g6X8aHz78t
	G6u2zIHVyqtMbbvzXtfcpZf8jkCswl96umQYaQ==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
> > index a0ea572382..87a652bd22 100755
> > --- a/Documentation/lint-manpages.sh
> > +++ b/Documentation/lint-manpages.sh
> > @@ -1,21 +1,27 @@
> >  #!/bin/sh
> >  
> >  extract_variable () {
> > -	(
> > -		cat ../Makefile
> > -		cat <<EOF
> > +	file="$1"
> > +	directory="$(dirname "$file")"
> > +	shift
> 
> The first argument to the function becomes $file and then is used to
> compute $directory; and we shift it out and loop over the remaining
> arguments.
> 

Yep.

> > +	for i in "$@"
> > +	do
> > +		(
> > +			cat "$file"
> > +			cat <<EOF
> >  print_variable:
> >  	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
> >  EOF
> 
> The fact that this patch does not touch these three lines gives a strong
> smell, especially the reference to "$1", which was part of a single
> addition to the target Makefile to ask what value an arbitrary single
> variable has, dating back to 2dd100c513 (Makefile: extract script to
> lint missing/extraneous manpages, 2024-06-06).  Now that you are looping
> over a list of variable names in "$@" using "for i in ...", shouldn't it
> refer to "$i" instead?
> 

Yes, I already noticed that blunder (cf. <20261127103346.vPrBT%taahol@utu.fi>)

> Because 'for i in "$@"' does not alter the positional parameters, "$1"
> inside the heredoc stays bound to the first variable name on every
> iteration.  When the script later runs
> 
>     MAN_GUIDES="$(extract_variable Makefile MAN5_TXT MAN7_TXT |
>                   sed -e 's/\.adoc//')"
> 
> extract_variable() invokes make twice with $(MAN5_TXT) both times
> and never evaluates $(MAN7_TXT).  None of the section 7 guides
> (including gitpacking and gittutorial-2) are ever visited by
> check_missing_docs() because of this, I suspect.  Have you tried
> introducing discrepancies to section 7 entries and seeing if your
> version detects them?
> 

I did all that when I first wrote that reroll.  However, my draft used 'shift'
in the loop which looked a bit funny when I revisited the patch and sent it
out.  Obviously I should have replaced $i with $i when I dropped that shift.

> Even better, instead of running make multiple times, use something like
> this (warning: totally untested)
> 
>     vars="$*"
>     (
>             cat "$file"
>             sed -e "s/^|//" <<-EOF
>             |print_variable:
>             |	@\$(foreach b,\$(foreach v,$vars,\$(\$(v))),echo XXX \$(b:\$X=) YYY;)
>     EOF
>     ) |
>     make -C "$directory" -f - print_variable 2>/dev/null |
>     sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p
> 
> perhaps?
> 

Hmm, I think I decided against something like that but perhaps I should
reconsider that option.

> Unlike "make -f -" that feeds the top-level Makefile,
> Documentation/Makefile has a conditional include of "doc.dep" unless we
> are running "make clean".  And doc.dep has a rule that depends on
> $(docdep_prereqs), which includes cmd-list.made.
> 
> Does that mean running lint-manpages.sh in a clean tree causes us to
> build doc.dep while it attempts to extract MAN5_TXT and MAN7_TXT and/or
> fails the build altogether (we cannot see, due to "2>/dev/null" in the
> above script, the error message)?  Have you tried?
> 

Good point.  That indeed seems to be the case.

> It might be less error-prone than the above gymnastics to add a new
> print-guides target to Documentation/Makefile, next to where it defines
> the print-man1 target, imitating how the print-man1 target does its
> thing.
> 
> > -	) |
> > -	make -C .. -f - print_variable 2>/dev/null |
> > -	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
> > +		) |
> > +		make -C "$directory" -f - print_variable 2>/dev/null |
> > +		sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
> > +	done
> >  }
> >  
> >  check_missing_docs () (
> >  	ret=0
> >  
> > -	for v in $ALL_COMMANDS
> > +	for v in $ALL_COMMANDS $MAN_GUIDES
> >  	do
> >  		case "$v" in
> >  		git-merge-octopus) continue;;
> > @@ -29,6 +35,8 @@ check_missing_docs () (
> >  		git-stage) continue;;
> >  		git-legacy-*) continue;;
> >  		git-?*--?* ) continue ;;
> > +		gittutorial-2) continue ;;
> > +		gitweb.conf) continue ;;
> >  		esac
> 
> Placing gittutorial-2 and gitweb.conf in the top case statement
> skips the "test -f $v.adoc" check as well as the command-list.txt
> lookup.
> 
> Moving those two arms down into the inner 'case "$v" in git) ...'
> block would exempt them from command-list.txt while still catching a
> stale entry in MAN5_TXT or MAN7_TXT whose '.adoc' file disappeared.
> I do not know which is more appropriate for these two entries.
> 

On the other hand, having such stale entries still makes 'make check-docs'
barf:

$ rm Documentation/gittutorial-2.adoc && make check-docs
make -C Documentation lint-docs
make[1]: Entering directory '.../git-docs/Documentation'
make[1]: *** No rule to make target 'gittutorial-2.adoc', needed by '.build/lint-docs/man-section-order/gittutorial-2.ok'.  Stop.
make[1]: Leaving directory '.../git-docs/Documentation'
make: *** [Makefile:3984: check-docs] Error 2

Hmm...

> >  
> >  		if ! test -f "$v.adoc"
> > @@ -84,9 +92,10 @@ check_extraneous_docs () {
> >  	)
> >  }
> >  
> > -BUILT_INS="$(extract_variable BUILT_INS)"
> > -ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
> > -EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
> > +BUILT_INS="$(extract_variable ../Makefile BUILT_INS)"
> > +ALL_COMMANDS="$(extract_variable ../Makefile ALL_COMMANDS)"
> > +EXCLUDED_PROGRAMS="$(extract_variable ../Makefile EXCLUDED_PROGRAMS)"
> 
> Note that all three above read variables from somebody else; running
> an extra "make" process might be warranted.  But ...
> 
> > +MAN_GUIDES="$(extract_variable Makefile MAN5_TXT MAN7_TXT | sed -e 's/\.adoc//')"
> 
> ... here, you are asking for the values of variables that are defined in
> *this* Makefile.  Why can't you inspect $(MAN5_TXT) and $(MAN7_TXT)
> yourself, e.g.,
> 
> 	MAN_GUIDES=$(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))
> 
> or something?

Huh?  I'm not sure what you mean by "this" Makefile (this is a shell script,
isn't it?)

Oh, I think I got it.  Indeed, perhaps we can invoke the script within the
Makefile with the guides fed in as command-line parameters:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b574ca2044..0ef57503a9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -532,8 +532,8 @@ $(LINT_DOCS_DOC_STYLE): .build/lint-docs/doc-style/%.ok: %.adoc
 .PHONY: lint-docs-doc-style
 lint-docs-doc-style: $(LINT_DOCS_DOC_STYLE)
 
-lint-docs-manpages:
-	$(QUIET_GEN)./lint-manpages.sh
+lint-docs-manpages: $(MAN5_TXT) $(MAN7_TXT)
+	$(QUIET_GEN)./lint-manpages.sh $(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))
 
 .PHONY: lint-docs-meson
 lint-docs-meson:

I quite like that approach.  So, let's make it our plan for v5(?)

> 
> It might mean that almost all the things I discussed in this review,
> including all the changes to the extract_variable() procedure or the
> addition of the print-guides target, were unnecessary.  It is great
> if we have to worry about fewer things going wrong ;-).
> 
> Thanks.

Thanks!
