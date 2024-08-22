Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821561CF8B
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316844; cv=none; b=chzpnRjQgQ/TAxnXpZPyuBk4MWUDjXzPGWnYWkXd5JL/MX5eNQl3GHdgXArHEuAA2CSX9SjMQ4h6uGuBZ14q6e8lSFxKN0xCZ9DVBjqSeFFfV+7qugB51h2Ljc1nwpeFoze4w6whSN6ZwLWYTjIH7gQ7pP9WHTKyDW5YfoywWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316844; c=relaxed/simple;
	bh=a7TK7vG2vh+QP+2WUY3VK7IKgyf4YvAxlhSY33lkeuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU8lausSBpzE83XcKmo3JavZrqxW2zyUn0wN5j6pj0Vnx1rTrxzN43rvJyVp2KE4dAIhHzH76Cb8bZdnLCYmUypYdys93vVLhsbbyLMS14XwCPG3swZ8g1Hs+lc5TWcDTc+Eq5WeHk2ZkpPwwWjkIWbXFSBwBlO5fyRiNADY4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tyR0Z0NE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9tWKl8w; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tyR0Z0NE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9tWKl8w"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 920CB1390070;
	Thu, 22 Aug 2024 04:54:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 04:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724316841; x=1724403241; bh=R89DilfjXq
	RScZYE0ulLybtLSOAapA1Oq6cNQsVz0qw=; b=tyR0Z0NECriOQE5nf789hqZP/3
	Yo0GKq0u6MSCCd3DGnZlw/YRp9YFjMspYCKZZVAsBC+3xRdy4VWn0oGV+r6lgzfK
	YVfNR2vIfNxVD0KyLgnywWbxGFi/eHsC5Vf+7gYDZVlUfx23GfdMlNtu4Xt5rNqJ
	wRYiV8w8QwbcJ8ICfqDqT3zgcDJ3iZ5M1gIzeDDh/7KC6Q+MhmP+zOrF6FfrO1xU
	XlE3ElHFlcd1OpJC4n52IY1tFGoybm+6LA6BpY2oVgwTER0VAuBP7hqqbws1eHOQ
	TFIWpFrK9nJVUI7L1u0mRy/U67rZN3RYxycqxJyxRRT/CL7sIjjJpnxSIKqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724316841; x=1724403241; bh=R89DilfjXqRScZYE0ulLybtLSOAa
	pA1Oq6cNQsVz0qw=; b=Q9tWKl8wjQdUYcbwwjEFoJ3IXmrhrVYaOh9VcqJjazmC
	XrqICKmc40olrt5kHmmkfifYIpUR//rb87RBPfC+Pqm6aXjo0H54/guEW9sszigC
	qrvze3bRvsMEyNUWhzEb6yoOlttrxVt9NcY9sih0TxduLQxulfYiY3EFemqri3Pq
	xytiF+I22RYk4rk7yFPrYkIq6jiteNP13rX/Qdrq+JqKoWaUrGzLIrTG6RMFXu61
	k34WGIdT/7ktYuINgG7UIUt8dt9yNWEMY0LY+Kekt49GnxmxEvjAWOdc8z41ITbE
	w6Z3AshgxSmDx4QwO0f1QN+4IqDBqOphTkyduIFvSA==
X-ME-Sender: <xms:qfzGZrfA2VEnOuBmtJuvqPXAvTvKwU8j6Bk1YY6fUWcCB7gqUQcFfQ>
    <xme:qfzGZhOUhR_gntZGtOIiUs5FnGTeHO9HoGSKClvCt584KSsM52p8KnoBJu7rU2Af4
    d89dCUbmn--pz1Vzw>
X-ME-Received: <xmr:qfzGZkh2zWFBSlmRmDqgeQ07hGHVLJc7lT5PzPrJQzcF1FumFpfokSXTXeOGA-6PAxb-4H2M4TjczjmIyfaMnt7VuHWHAplaA6ALEGd08Se7aao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qfzGZs94A_yEbFtAYIrqPOH0U4bhaqnFK_fy3g_5WiWqu0XtIq4C0w>
    <xmx:qfzGZnsuHIk6zK5wI_wz3piUNYqFq46xRMyrsZRAEkWS0sht0mXrSQ>
    <xmx:qfzGZrHoDLfV-JK_YPSKz3QHPmg8-GHNfpeBAux3GU-v1nKgVLoX0g>
    <xmx:qfzGZuOqV_2d8hZkFUGblpYXc5SaBb96zR-EVW8Zaeguke-_HFfWsA>
    <xmx:qfzGZhKTMCDV-tFtv8NcW_jC2hQEOR-mgn7tnVp7y70bXFaWcipbyWVI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:54:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f59ee4cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:53:24 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:53:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <Zsb8oDA-vyLxNY0U@tanuki>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM4OZWfylcP5Ix@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsIM4OZWfylcP5Ix@ArchLinux>

On Sun, Aug 18, 2024 at 11:01:52PM +0800, shejialuo wrote:
> We have already introduced the checks for regular refs. There is no need
> to check the consistency of the target which the symbolic ref points to.
> Instead, we just check the content of the symbolic ref itself.
> 
> In order to check the content of the symbolic ref, create a function
> "files_fsck_symref_target". It will first check whether the "pointee" is
> under the "refs/" directory and then we will check the "pointee" itself.
> 
> There is no specification about the content of the symbolic ref.
> Although we do write "ref: %s\n" to create a symbolic ref by using
> "git-symbolic-ref(1)" command. However, this is not mandatory. We still
> accept symbolic refs with null trailing garbage. Put it more specific,
> the following are correct:
> 
> 1. "ref: refs/heads/master   "
> 2. "ref: refs/heads/master   \n  \n"
> 3. "ref: refs/heads/master\n\n"
> 
> But we do not allow any non-null trailing garbage. The following are bad
> symbolic contents.
> 
> 1. "ref: refs/heads/master garbage\n"
> 2. "ref: refs/heads/master \n\n\n garbage  "
> 
> In order to provide above checks, we will traverse the "pointee" to
> report the user whether this is null-garbage or no newline. And if
> symbolic refs contain non-null garbage, we will report
> "FSCK_MSG_BAD_REF_CONTENT" to the user.
> 
> Then, we will check the name of the "pointee" is correct by using
> "check_refname_format". And then if we can access the "pointee_path" in
> the file system, we should ensure that the file type is correct.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/fsck-msgids.txt |  3 ++
>  fsck.h                        |  1 +
>  refs/files-backend.c          | 87 +++++++++++++++++++++++++++++++++++
>  t/t0602-reffiles-fsck.sh      | 52 +++++++++++++++++++++
>  4 files changed, 143 insertions(+)
> 
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index 1688c2f1fe..73587661dc 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -28,6 +28,9 @@
>  `badRefName`::
>  	(ERROR) A ref has an invalid format.
>  
> +`badSymrefPointee`::
> +	(ERROR) The pointee of a symref is bad.
> +
>  `badTagName`::
>  	(INFO) A tag has an invalid format.
>  
> diff --git a/fsck.h b/fsck.h
> index 975d9b9da9..985b674dd9 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -34,6 +34,7 @@ enum fsck_msg_type {
>  	FUNC(BAD_REF_CONTENT, ERROR) \
>  	FUNC(BAD_REF_FILETYPE, ERROR) \
>  	FUNC(BAD_REF_NAME, ERROR) \
> +	FUNC(BAD_SYMREF_POINTEE, ERROR) \
>  	FUNC(BAD_TIMEZONE, ERROR) \
>  	FUNC(BAD_TREE, ERROR) \
>  	FUNC(BAD_TREE_SHA1, ERROR) \
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index ae71692f36..bfb8d338d2 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3434,12 +3434,92 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
>  
> +/*
> + * Check the symref "pointee_name" and "pointee_path". The caller should
> + * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
> + * would be the content after "refs:".
> + */
> +static int files_fsck_symref_target(struct fsck_options *o,
> +				    struct fsck_ref_report *report,
> +				    const char *refname,
> +				    struct strbuf *pointee_name,
> +				    struct strbuf *pointee_path)
> +{
> +	unsigned int newline_num = 0;
> +	unsigned int space_num = 0;
> +	const char *p = NULL;
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (!skip_prefix(pointee_name->buf, "refs/", &p)) {
> +
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> +				      "points to ref outside the refs directory");
> +		goto out;
> +	}
> +
> +	while (*p != '\0') {

We typically write this `while (*p)`.

> +		if ((space_num || newline_num) && !isspace(*p)) {
> +			ret = fsck_report_ref(o, report,
> +					      FSCK_MSG_BAD_REF_CONTENT,
> +					      "contains non-null garbage");
> +			goto out;
> +		}
> +
> +		if (*p == '\n') {
> +			newline_num++;
> +		} else if (*p == ' ') {
> +			space_num++;
> +		}
> +		p++;
> +	}

Can't we replace this with a single `strchr('\n')` call to check for the
newline and then verify that the next character is a `\0`? The check for
spaces would then be handled by `check_refname_format()`.

> +	/*
> +	 * Missing target should not be treated as any error worthy event and
> +	 * not even warn. It is a common case that a symbolic ref points to a
> +	 * ref that does not exist yet. If the target ref does not exist, just
> +	 * skip the check for the file type.
> +	 */
> +	if (lstat(pointee_path->buf, &st) < 0)
> +		goto out;
> +
> +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> +				      "points to an invalid file type");
> +		goto out;
> +	}

What exactly are we guarding against here? Don't we already verify that
files in `refs/` have the correct type? Or are we checking that it does
not point to a directory?

Patrick
