Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571361;
	b=Fifa1WDyn+fI5Lci6lHMYxJQb78xwUI9Ylx9eUG4jBNf5pbAgQyLk/AazBFTG1GYBOp3
	 0h7Beqp/bCd9EH1NpahqKUcDDmpTDqc3zI6sx+DZMwagoV4q2uIql06FH0gQx1RXA1vH7
	 vav8ZX3KOhp+sBwEVO61OqYTO1YcmEmVTThzb86isl+Iko49AjRsHDvffYUPgVsgZJW/O
	 MmaNl1Hr8yKnGeRhxIL1J1Lpq28lNScFowyKF2jm5XxIhiReeAMTvg8pLDZyiPJbSnrhM
	 8e56OUJWMJo7JACfRKX5RnScC6l9Nq03ZvZkfRhLnPdG2f3r4Y4RKbGcBBsNxGYdELg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571361;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MFbY0u1Gay4hO/oTtZuo9jA0eBki86GWEPXcHknY/4Q=;
	b=ez/uGRpUqYEIA4aT55/hPJN9u2hRjLKCFX8NpzqjNyvdG6YmqtVYOgMigUADqnXZ7+4z
	 tLRIns3r4du6xQooIVDJFsXUCcfqTum8Wz+q4SsDAjqqvTeOhCU+NzQ8HyCjuegjj0w9o
	 lCFgHA2OQlDcpUXFNZjk09421HISyTqN3/Ju/f65b6q9NdBXTKi9S1mBDN8A5fjHWqX73
	 fez+drVJLaerrGCE7NWqSzNNkhzdUvTd1DoYBdidTcbpZocDhjYdugo912BV+cC+f5Uji
	 +JfrwOJ8P/AyneJEZAnkaC8M8X58y7EJg1UmzkOjqE++JDr9w5d77JDs2j8uBs5cNgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="f/Rzx3/E";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p1NUdYoJ;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC5606A326
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFBC5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f/Rzx3/E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p1NUdYoJ
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E3C5E1D005D9
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:49:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 20:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795571359; x=1795657759; bh=MFbY0u1Gay
	4hO/oTtZuo9jA0eBki86GWEPXcHknY/4Q=; b=f/Rzx3/EHJViBFcQ+4skk2BDFO
	598va0X1YZpa6wCqpjP2iDc11Ruz7mYmgBfp3VBuw3qQoSXfiu+U7EepQMPx1F/d
	fqrrZ+qkeBtRmGRSTbTH8UXE42l0yEBBPfaNDF2NVUQsG+z+gNVY1ZMyKUmKQG0T
	8neM/rrowbjYe4duLybBWrU2dr8Dgt+y8loEFcCpNEd7XhUHIy81K4GTf1veCJGy
	nO4Pdvn7hjPLao8TC8UwLqDQz6CCvp9/A6xU+7vvs7SUsccLbSgpbis788xO5pin
	TPLHtHymA55OQRzByss8Lv5AqPbtS1cJ28sp1DF1pkz9ObIc/iMPztqiBzXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795571359; x=1795657759; bh=MFbY0u1Gay4hO/oTtZuo9jA0eBki86GWEPX
	cHknY/4Q=; b=p1NUdYoJcOW/1bweM0KlhKP4nQ3BCYZGQ0ZNM0RV7N1ngHZ/euN
	WPJdimi1tPJiehs8RO2y0kX4VD21V0mGXDeNwLND730r4P5XN82/WuhAuaieXIDe
	8M7ICYSbYo4v3EsNRWhs22K7/dcwLUr6VR92PX3AYRnDTcudqOUxJi6vySn+Q+4C
	oI0IqCjZtMPcLJy1Z9yQ+C2IUK1HOcH8c7laU9kHDGnjlzQwYR4eE79P2i1aYM4u
	uLvS4fL6KsfZrX+M3JAaTYHIcs6YgM1jfhRAR0TxMHJR/HbEHqXHEepDHmekslj7
	Hkv3UaDSzG0CN3OwGwk5s2fgLMv72Vv1w5w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795571359; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fbhnfE2oEnIJgLdzbIX/kAIunbdezXLAQrVh46HVtDgVb7k
	2iKIgFcYWpjRG/WtKsVXb3n90/OXObvlxm9OVbtq1fxJGydIEs/lBfsX7Alm+wbc
	lRgr7NU+i8y7wSvoEIAPheyiyFGXR5tTlfm055PX8nzlDY3C3JkYc8rw7mUnjC1o
	NUomI1g88c3AOuE1j1Oo+p77WbHNLUnnyKZe7jMUGeluUcLLo5kiF6CBX6zYbpXN
	1fIM22DzjojAKfzyWZZjUuztEKpryAoOMrx7QAa4z3RaC0sh5eG+EYXEzO4w1Cix
	ejrynkdUaKt6/2mrwak7F0UehteZXOBMKRx73xg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+KHWhhW5Q7DPWu6M6/0tSQd/SQMpPvTGpCsTyWhLpl0=:iEbYaJNB5tR6axcKHRjSllzXew8pXrdoWdkK+YYHASU=;
X-ME-Sender: <xms:nz4Gay62tS8XYrfxaiiIWMw40TGzv0VimqchFNO27eO3ah2rAkxUOw>
    <xme:nz4Gay6mossdBQpXT_NGvpl5I--HXwrK9FVHxQRTNZ0P7FRiuyBgDhxdysProd5c5
    licRXdP5sWnInphr_l870iz6UvbWFxdBP7pHgbWxb-HDuFMLeY6f2o>
X-ME-Received: <xmr:nz4Ga2cj4Fk78fvcYy6CSigAhjtya0uO2dEWxIYwd46Wa2H22MGKR8Xeon_xWx53QlxpkpgCRZXR9MZNjTPV5qIQj6ZYAHStUWmgLTg>
X-ME-Proxy-Cause: dmFkZTEMnB+8+42lLbK59Roo7S9FASC34m/JBbK7ZZXUEZfl+2uQvkz8KqgwKKfBq4Zg2b
    hJVY3nQTXmlaAfYnMuGpHk5xTyxOI4NN2E/kcfhwa2N8QLDsmxXO1ctkLwYTkl8WYKulbM
    Pl9LmD/uF3ZJa/QEYL6dOMs4FcAnprtkx/9OEqx4Fn04sDTNu0A1R1Y1Lu7pQu69qnBdsR
    OTScnVzLQW9yG/WAFo202LEybKVV53L/m8Fr455sOyPVF31s13M1YQ/IyFW8bXsi9srIfW
    tiOp8Xq7x8FdRxWDmHNP7ayWALX4I8NONoXCZ/6VG1XXnValRm3FSfTiBod6Nei+D/oBIn
    kdFqnbCht1SM8qxljWrc/dFSpa3IQ9A1Lihg1d4y1NIbUB0Pe1r2PviMBD5sMu7dcXz39c
    YTgCWJbLgNy2Fp2syx0qVzN+XeT26sgnfQa7mnwlpiVuFO1DG62ocOUrhGv94q3I6pB9hR
    VZ6bj5NPAVFTa1lfjqowAYWI9ZFjimfc8snjk/QftxsNo8Qr4EySvCdwoDrTJEAPUKCuoJ
    xg1UxZpXiY/nvY9UxJZnwhI79pSxguvXKI7z0862WJe9AiFEUAoCwdiTiN1E5ksh6AKVwz
    uFfr8grpdPZXMiPdZB65/eTNPG4ytLP6JyYwuU4MhLfgrI/t9bcc2ZHdfWvw
X-ME-Proxy: <xmx:nz4Ga-CqUXL_tPBKbPNYVBb4dnMgYk6N5gs0QoRBMXwUjf39mJdl3Q>
    <xmx:nz4Gax83DICKu0Ko-5SQKRoH7Nz6q1_hLEw2wu1l4G07gS4WbZlbSA>
    <xmx:nz4GaxKg43-RXNQ_iWuwL3oxc5363vWiUVJMKNR-do6zrSWYvzIkRw>
    <xmx:nz4GayhnPqqMYNEequLXZrTvUa_qvtlNcskmzQ7IST9nZxFetVZrDg>
    <xmx:nz4Ga1_wAw8IcTqT44HoJdKTDy9LjKO4_lYaw8FrMLK6MhxWAaz8ZV0i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 20:49:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] imap-send: make the header loop easier to read
In-Reply-To: <pull.2508.git.git.1795560535063.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 24 Nov 2026 22:48:55
	+0000")
References: <pull.2508.git.git.1795560535063.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 17:49:17 -0800
Message-ID: <xmqqecc9fzoi.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> The loop that looks for the From, Date and Subject headers of a
> message stops at the first empty line, which can end in LF or CRLF.
> The check for LF also moves to the next line, and the check for CRLF
> depends on that, which is easy to miss.

Indeed, hiding *++line inside the first part of the condition forced
anyone reading the !starts_with(line, "\r\n") check to remember that
'line' had already moved past the newline.

> diff --git a/imap-send.c b/imap-send.c
> index 1b5850a80e..c2d6b7c55a 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1462,7 +1462,9 @@ static bool has_required_headers(const char *line)
>  	bool from = false, date = false, subject = false;
>  
>  	while ((line = strchr(line, '\n')) &&
> -	       *++line != '\n' && !starts_with(line, "\r\n")) {
> +	       !starts_with(line, "\n\n") &&
> +	       !starts_with(line, "\n\r\n")) {
> +		line++;

Checking for "\n\n" and "\n\r\n" symmetrically before advancing 'line'
inside the loop body makes the termination condition much clearer, but
is this correct?  The latter expects CRLF on the second (i.e., blank)
line, so presumably line[-1] would be '\r', but nobody seems to check
that.

Not that the original checked that, either.  We are not interested in
seeing that the first line is an empty line, so that is perfectly fine.
The strchr(line, '\n') would take us to the LF at the end of line,
whether it is a LF by itself, or it is the second byte of CRLF.

In imap-send.c, this function is only called by count_messages() on a
NUL-terminated strbuf holding the mbox input.  When strchr(line, '\n')
returns non-NULL, 'line' points at the LF terminating the current line,
and starts_with() stops as soon as it sees a mismatching byte.  So even
if the input ends immediately after that LF or after "\n\r", neither
starts_with(line, "\n\n") nor starts_with(line, "\n\r\n") reads past the
terminating NUL.  At EOF after a single trailing LF, both checks pass
and the loop body runs istarts_with() on the empty string "", matching
the old *++line behavior, after which strchr() returns NULL and exits
the loop.  So as an "identical behaviour, but easier to reason about"
rewrite, this looks good to me.

Will queue.  Thanks.
