Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792805769;
	b=PFU/PMYsG+/cyxxQQ2l05d/veGLhry3XEbd2yN+ChXwNI7TgtkQKeXF3v7W+qcM3CE4z
	 s2QxgrQ/+13IJq++4m7qo6EvIlYrin740UUP7LMgZax8M+DrEXbxbaUxzG2hcatZTxNl/
	 1205vN1knZs519QAhngQ1LKFoNWWVOTnP4qwLGKbf9QHs0YlgBe5ltzIcozsQ+OiJ+RwC
	 UoqdZlIIqPvl32kukdkKYwP/KVuB1xpzTDJWrUbLljRaTQNuNvo2KqLqYsfeUo9eTuMT7
	 dmFi687d2iHs2jPxh58dqcbZxBNN1i/rGluRWi6GFTtS85ToSCDV+4TwX+bVegMqOeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792805769;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=KZ+RNWIvURi7W6c7FZK4Pi0xrJ9r8mVI9L+zJL4CkZ0=;
	b=HfXREnXqp3hG2xgpKQfkDnetToTZsLAF4Y8Hr30PU8yfoD5J0TJwxb8TIzyeG9Nk3Fh9
	 2tywjuFkIJRBBZlaCem5dGxWpOIEUti84q2qKYgEaYxq2KjPovHKah1D1sMAGnt8CIlL6
	 1LABwmGrqVKcQouuzuiPs7tsJC74mQCEL4X3ZuJ3Lw3p0E/ATz8MlTwW5U6lWz4qOCfT2
	 zUmrnfuk/SIOUdFzkzJD7ac2655nWo7ZwWkkU5XBUJI5sdonHa8Q1x7sK1Kb/XU7U+w7X
	 E7rX5sw7EWCsq0YvjVk4XdznkP/pPQUW+rlpnU5txGnXMH/HbvvuszyaOuuVZMUqsyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="BOh/KGQk";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RZPPqzh6;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41481606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 01:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41481606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=BOh/KGQk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RZPPqzh6
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 515C614000EE
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:36:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 21:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792805767; x=1792892167; bh=KZ+RNWIvUR
	i7W6c7FZK4Pi0xrJ9r8mVI9L+zJL4CkZ0=; b=BOh/KGQklrwCtGKkM7QTh/icRg
	KcyldUKO2aJfqcgwV7TTsbYnzXSkDzeZUg/H1GwQHXTd5NBG6GNDTvt2UnB1FfXz
	Rod7WKyoDwk9HoEW3NxxfKsbSuG712BWyCeA8iC3JFR/ibUFlboLC0BXYxEYTaXC
	f8YlrqPr5lUNshqMM5jqml7TpKY66U/zmii0hUpn6HDfCRFt++5ocW0nzPhIXzX3
	0N2Ab/EhC3XN/Ly8GCMR7kV5u7ggqVN3DE8oX99tHD3GLdpekXpAU8B/VpHmVggR
	Xp3MqdY+BzafqzpTG0hBetmExHDW2joGfHoWjx29GEG3L77uzd0cPPxjtzAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792805767; x=1792892167; bh=KZ+RNWIvURi7W6c7FZK4Pi0xrJ9r8mVI9L+
	zJL4CkZ0=; b=RZPPqzh6UBpOv2RGC0bkcBdOtHknr/crMcRpLmmIYsaq//W8+wc
	W9n9c+uyXApeKkmCBg3jA7WlExPtL3lyUjShA20FG32s8XaIxM28wCNYifDQX+dk
	xrctdtPxzsW4ik89i4QSLnOdbdHFTaiiCOkkA/PGkAaRsqP3zKj0jtsbPCkmG8ND
	X4ZIOkCsj5a5TsDQ1hMmSZMMEfJ1KoIRgS6NtlueFVVDeGWkJJd760I+8E+ooh6D
	YKm8hJK97hJnhaNNvT6/sjUMiEsUmpFrYHyyVMp1eBl8Mr4o3dLDNxZYMn65Stdy
	LPdan6laLMyGQsqmoX0SvY3s54qdISMD/KQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792805767; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cXjmb4ZAwAFttIBM7QLnn1nVDtOtP1J6nPfO0usXInHXAc6
	laTjN7B4ySzw0DMQqIFX5yGzcxy+dEI/P1H07ndU9/4vtiffpdMicJFxRGQ043Nh
	rMpX6ImVJPxecpwIkdqhZT6vcFKbRqnQFeG9jVypokrpe529J9ak0dpAsFDg5lKB
	vuD37a6VlvpTx5xWnT/cKrtVUQHv+MkYwPzsfirPgd0BksXjCl9/Eg85F7nHigZN
	IRH2MizNkAaHwMCWOygmEI5UkgR4h4LgR243fwX1dgn/cdls3kbMCdEcaX3e1VXP
	p6mJwDZG8XjtTFC3PlrXg+JVX/P1nHNBoj1GYnQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:G7uISXB1Pg+Ok7p+IAQFBwhKvp0QREj2YaRU1s9rlxw=:Rc2Ye8g3geipJxCGKJKY4cTE5kQr1ZV4LJQAyNqU0ss=;
X-ME-Sender: <xms:hwvcag94nv4X5bP1oAU54EtE1O4PB3dVKc0L1ue7ZCQzTty4q5ZcdA>
    <xme:hwvcar-gqK133a9xmO2DvLM9hfeyCIZybBiF9xYvSdbJ_tU3SBU4JvC5at2gZrYhV
    ixmNNXurrn_65Gk_NGMrTYBVoDPlS0GhZBxWxftwNXWpCJRz7LKH-U>
X-ME-Received: <xmr:hwvcaveOFiycVj1vsQnkvaXOyCzWwAHoPvDeg9UwH91vJ-cQEnCw0xd8VDu-RW-TLqc_WT2ITpGjh1YdqBl6vmmrK1LVBxg6wb-F>
X-ME-Proxy-Cause: dmFkZTFxOltuaw4znJBU6qjIahukAe0GpI1nRQxyU8sQ9aPQ3dKTLQ5yiLBduCp7BN+lZ+
    P04getEb1rgA+WoBERW/2gRmD/aixZU5hmmzQh169fGkcnRXDnL2tmTaGDh94TxHMUwINh
    M+KZl7lkISQefJGnGFJsRn4vAFc4RUb25IJaFMmp3jV3jZhV9ogOYa1UlZpbVD4nbnymTH
    8aD2eJcZKsiO2t7DK1ZiD0gj2sWyCR7ecM2jNA+q93mmR/Nx7zFkYXt2qnuySpqsXcgva5
    h3P5ESMXxbu41XxYnyGsNiL5+iHCIBYi6LGEkIJk4nPPJ5PDlRJmMhEEtKdcwQ/TbetfUW
    0rVzmfBlUzcbC27ijugE6Lc3j/ue5iKz3UYJ2zpNoSeB8pG9vRVe05dJToHHOcHQj1M7Ao
    x84B2bWa2XxqvzY6IMKOWgIY9GIhIhjKzV0oTdBY9BZh0BXZ12EkgrhHdwCTa/nJy+Pybk
    bd3xqmClslk8z89E1yYgGj+T8941ALMWNW+qDzArOMdeG2JaE3NShcTbByiRqoJfymdlhk
    F3ot/UFngsUtxPDiBb3hhzujfoHuZAw+vceVBORx+b/y47Zpydh30TNXBR1LZAhcRPKwYA
    sKsYFwYRg7iE+KI+rx4mRpG70RqjiDfaP9QftVEiwZgwmTlmRmGF6DuNPlEA
X-ME-Proxy: <xmx:hwvcasFEInLiR-RmN4l5OPaXOMjRmrn8JT_oPyKGR5tdXXnsfnBY3g>
    <xmx:hwvcalct2iw6D8LBWDpD1UUQi2BPXigtnK_UPSZqDnvvv0BRn25SqA>
    <xmx:hwvcauGBqMlX4-zT2fqV2222Q5csVZ_f3-z9UOEMgnIW459uCKKafg>
    <xmx:hwvcamUzCn5ihzdMlgRkXdo11sHJZiPwcmlPdxlERhtN30f-Bg7y_Q>
    <xmx:hwvcagnaBvWNdpH0EyQokzLNrB_wrbLV-GUNkpctf23P_tl54bJfRLyI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 21:36:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] object-name: use Q_() for the reflog entry count
In-Reply-To: <20261023133118.456-1-aniketgupta3001@gmail.com> (Aniket Gupta's
	message of "Fri, 23 Oct 2026 13:31:18 +0000")
References: <20261023133118.456-1-aniketgupta3001@gmail.com>
Date: Fri, 23 Oct 2026 18:36:05 -0700
Message-ID: <xmqq4ieb3mnu.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> When reflog is asked for an entry that it doesnt have, for eg with
> "HEAD@{5}" get_oid_basic() reports how many entries the log has. The
> message is not marked for plural forms and a log with one entry says
> that "only has 1 entries"
>
> Use Q_() so that the singular is used for one entry so that
> translations for languages with other plural forms also can have the
> right form for each count.
>
> Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
> ---
>  object-name.c         |  4 +++-
>  t/t1400-update-ref.sh | 14 ++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/object-name.c b/object-name.c
> index 654668576..eeaac2ddc 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -810,7 +810,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  				if (flags & GET_OID_QUIETLY) {
>  					exit(128);
>  				}
> -				die(_("log for '%.*s' only has %d entries"),
> +				die(Q_("log for '%.*s' only has %d entry",
> +				       "log for '%.*s' only has %d entries",
> +				       co_cnt),
>  				    len, str, co_cnt);
>  			}
>  			if (flags & GET_OID_GENTLY) {
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 1a164c96f..1d1b46379 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -458,6 +458,20 @@ test_expect_success 'query reflog with gap' '
>  	test_grep -F "warning: log for ref $m has gap after $gd" stderr
>  '
>  
> +test_expect_success 'reflog entry out of range reports how many there are' '
> +	test_when_finished "git update-ref -d $m" &&
> +
> +	GIT_COMMITTER_DATE="1117150320 -0500" git update-ref $m $A &&
> +	test_must_fail git rev-parse --verify "main@{5}" 2>actual &&
> +	echo "fatal: log for ${SQ}main${SQ} only has 1 entry" >expect &&
> +	test_cmp expect actual &&
> +
> +	GIT_COMMITTER_DATE="1117150380 -0500" git update-ref $m $B &&
> +	test_must_fail git rev-parse --verify "main@{5}" 2>actual &&
> +	echo "fatal: log for ${SQ}main${SQ} only has 2 entries" >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'creating initial files' '
>  	test_when_finished rm -f M &&
>  	echo TEST >F &&

Obviously there are existing tests that cover this message already,
and without adjusting them, the test suite would not pass with this
patch applied.

$ make >/dev/null 2>&1 && cd t && sh ./t1506-rev*.sh -i -v
Initialized empty Git repository in .git/
expecting success of 1506.1 'set up basic repo': 
	echo one > file.txt &&
	mkdir subdir &&
	echo two > subdir/file.txt &&
	echo three > subdir/file2.txt &&
	git add . &&
	git commit -m init &&
	echo four > index-only.txt &&
	git add index-only.txt &&
	echo five > disk-only.txt
...
ok 12 - incorrect file in :path and :N:path

expecting success of 1506.13 'invalid @{n} reference': 
	test_must_fail git rev-parse main@{99999} >output 2>error &&
	test_must_be_empty output &&
	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
	test_must_fail git rev-parse --verify main@{99999} >output 2>error &&
	test_must_be_empty output &&
	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error

error: 'grep log for [^ ]* only has [0-9][0-9]* entries error' didn't find a match in:
fatal: log for 'main' only has 1 entry
not ok 13 - invalid @{n} reference
#	
#		test_must_fail git rev-parse main@{99999} >output 2>error &&
#		test_must_be_empty output &&
#		test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
#		test_must_fail git rev-parse --verify main@{99999} >output 2>error &&
#		test_must_be_empty output &&
#		test_grep "log for [^ ]* only has [0-9][0-9]* entries" error
#	
1..13

It could be that t1506 is the only one that needs adjusting.

$ git grep -n -e 'only has.*entries' -- :/t
t/t1400-update-ref.sh:471:	echo "fatal: log for ${SQ}main${SQ} only has 2 entries" >expect &&
t/t1506-rev-parse-diagnosis.sh:145:	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
t/t1506-rev-parse-diagnosis.sh:148:	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error

