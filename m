Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE76197A67
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916871; cv=none; b=qUd2HXEXfkEutdKTDxtCmAGY5xrWshgmnQSJK7uVUFhTlJnUm1uK3rpGwTgGK6rAZd0ZLrNvUU7Agbjv5S9sBPjqmRnPP7tL1HwkIWKAEa+QsbMI4pBSGyVSXn22g8fBlxL4hHha2SkOFdB7FW7S2dIIhjOMMduDoPtfN+X581w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916871; c=relaxed/simple;
	bh=RzZzUQ4ihDNllowHdZidRaNyJniCuhuG2AxWR+UuQGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CFXVxy9Sp6p5NOa4laPwoQhr6UGGBUTsvuaRb0WrwO/Lr7LYsgtc7SkARpWUM8cujV8Cqzn9exzxHA5xQNgbJ+156CXadWuzPbzU/0pF3o1717uTxTCg7jU1Phr+MmRPG+NdAgviAt34/f7vPuZGJmbTz3jFaTqEQIIqzBLXPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GxjR1iNx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oU0PDxSS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GxjR1iNx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oU0PDxSS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F6FC1383A1F;
	Tue, 25 Mar 2025 11:34:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 25 Mar 2025 11:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742916867; x=1743003267; bh=T5YTY9oOjf
	HX+vT3OcJhN7jfh0oHBBUvq8VCkqMusew=; b=GxjR1iNxf/EE9z35jfHYy9t04+
	FAS2iqocXzYcA3zaBLKWI6S7kziHOnI+PrnHqc0rKffulBn/3wkdiaoTAZNhqbbv
	23QvCtGRTaB+8ul619mOpr9/mbF/JLFJ/tj22JHG0EN1ztXYDKBHJo1Uwnjwqx+k
	ZswypSrOMmOYp+fAOMWmiXLNJdaHV2fGEmCv5Cx7i3yaWmNHTpwKVENNKddYAaRt
	qn2rHOwiEhI0Qkdk95mXO08YiPOhDKN8c9LYrR0Jj/ya2RHGa3zB0eD6Tq+E8Fch
	kG8QyFIsye8xUK/RipjFXPNkaPxCFuNnTWdg5fnKeQIqIGtMaV5g3G24UByw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742916867; x=1743003267; bh=T5YTY9oOjfHX+vT3OcJhN7jfh0oHBBUvq8V
	CkqMusew=; b=oU0PDxSSpt02n8Kr/rCQezjqtSMHZtaiDHU+JwA8az5GAv5iROY
	gnzn5z0F4JEkYTXTWeEfWoDBncJEfOTFoF/uzOgE9iV2XLFuXCyajUAR7fVw9Sw0
	9RXYAtvc2Ffj3YXu6c/8nd2NByoQJS5pIEjH878/XclWf993LmQaYxDRy4msDuia
	UERiPFgrmJsDZXeZX2bSjAl9wp+BaOWqlX+6MHTrGtfs08OgfgU7Q2iIhCp9X9yr
	Somb3guC9AYns/f6jiJRh8YzkFZjKKqQQDbodxZDWpLRx7rv6DNKpZ3vqIqWVM7e
	8REorYlCrAqG9JFSPg/avqpMsUSsTa83+Ow==
X-ME-Sender: <xms:A83iZ-N_XeMweDPYPUp4WPklkO0YukKMPnm7mfE-dJB20RdFniHezA>
    <xme:A83iZ8-B79a6J4YMyTLFAjip9gooX-CclWw_BzWoGUCScprFNBIRVtgBoyezELIIl
    9mcC0lDxSlS4upy_A>
X-ME-Received: <xmr:A83iZ1SXztZVRsVJIOyMLB5hYWI0WF9xbNMcw20_0w0Gvs_XW_avBDmlFtWHcDlTEp8w6xAhnny-DaOqLA0y2c1aZL0Zc-1OTKrN2l0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeftddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dviedvffelffehvdeghfeihfeggfegveeufeeufeeugfegvddtudefheehheetfeenucff
    ohhmrghinheprhhftgdqvgguihhtohhrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptdehii
    ihtheftdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A83iZ-tSP7Cp3NpfIOSgOjwdJ2fjqJAASzdh9BJUBHp8QLRBrghZPw>
    <xmx:A83iZ2c0XWY4p-SVJ1hz8eCr2GzOaOl0ZDdQcn1-N5DDd_semeFeRQ>
    <xmx:A83iZy12nnT6Fg_3gbdxagfkw9wyi2WeIYpwldQkMY_844gsAnU98A>
    <xmx:A83iZ69Qvm-DeEA5Q6LM_cCaQYBLbtElQSA8y57bm9GBFJwwnpjjnA>
    <xmx:A83iZ16m4UqLmTqlrgKpRRv3twWFdzC7J89mP4BfCVqn5p73yXVHdx44>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 11:34:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org,  meetsoni3017@gmail.com
Subject: Re: [GSoC PATCH v8 2/2] send-email: finer-grained SMTP error handling
In-Reply-To: <20250324145332.571813-3-05ZYT30@gmail.com> (Zheng Yuting's
	message of "Mon, 24 Mar 2025 22:53:32 +0800")
References: <20250321025128.68463-1-05ZYT30@gmail.com>
	<20250324145332.571813-1-05ZYT30@gmail.com>
	<20250324145332.571813-3-05ZYT30@gmail.com>
Date: Tue, 25 Mar 2025 08:34:25 -0700
Message-ID: <xmqqmsd9m8e6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zheng Yuting <05zyt30@gmail.com> writes:

> -		# NOTE: SMTP status code handling will be added in a subsequent commit,
> -		# return 1 when failed due to non-credential reasons
> -		return $error ? 1 : ($result ? 1 : 0);
> +		return handle_smtp_error($error, $result);

It was a bit surprising that the new handle-smtp-error sub handles
the case without an error.  I would actually have expected for it to
be something like:

		return ($error
                        ? handle_smtp_error($error)
			: ($result ? 1 : 0));

I.e., we used to unconditionally return 1 upon error, and the only
change introduced by this step is to classify $error with the helper
function better and behave differently depending on the error.

Having said that ...

> +sub handle_smtp_error {
> +	my ($error, $result) = @_;
> +
> +	# If no error is present, return the result directly
> +	return $result ? 1 : 0 unless $error;

... as the "no error" case is implemented as an early return, the
mental burden on the readers is not so bad.  They can concentrate on
the error case when reading the remainder of the function.

Still, it would be with even less mental burden if the no-error case
is handled by the caller to make this function only about error cases.

> +	# Check if an error was captured
> +	# Parse SMTP status code from error message in:
> +	# https://www.rfc-editor.org/rfc/rfc5321.html
> +	if ($error =~ /\b(\d{3})\b/) {
> +		my $status_code = $1;
> +		if ($status_code =~ /^4/) {
> +			# 4yz: Transient Negative Completion reply
> +			warn "SMTP transient error (status code $status_code): $error";
> +			return 1;
> +		} elsif ($status_code =~ /^5/) {
> +			# 5yz: Permanent Negative Completion reply
> +			warn "SMTP permanent error (status code $status_code): $error";
> +			return 0;
> +		}
> +		# If no recognized status code is found, treat as transient error
> +		warn "SMTP unknown error: $error. Treating as transient failure.";
> +		return 1;
> +	}
> +
> +	# If no status code is found, treat as transient error
> +	warn "SMTP generic error: $error";
> +	return 1;
> +}
> +
>  sub ssl_verify_params {
>  	eval {
>  		require IO::Socket::SSL;
