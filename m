Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBD20E6
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333943; cv=none; b=nzE1otgXFBt3TI6OCWiM92ggwli3dhQjkeDda2Croxmnf1kbYRIx7vVLyRipMPyvnZyrVKk6XdEd0/nMgDxOrun3l3hRutlTMTXkQ1v0K6TtYqQpUSB/f0DKogzUFPHG5ghBF9VJiqBWBc/EehYMcbRPwOT82uy4EuxNQ6/F08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333943; c=relaxed/simple;
	bh=P6G+Z2nxs7pYsZDEY2NRnfOQJ2C/0x016PNsyhbnRCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBmkBH6j8J7i7vVwSTM1RBf08UJq9VZf7Jdkul3eErUBKc1lP9SqnRh9qx6MPOSedCTUM9pEpnYPX0yP/UVXMqvUM79iwVeEZR/t3lzocQ+v72ESo4kLTPTrYC8aA6PCFKXivovbwwLNAYqc2Rli33qIRUQ05htOguika6LkVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wj1/Wsh+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tbF7NFJH; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wj1/Wsh+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tbF7NFJH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BA302540062;
	Mon, 16 Dec 2024 02:25:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 02:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734333938; x=1734420338; bh=wfXlJTgfkY
	xDqM2Lirj/pt7tIvxZUklitdXZTY8NZ98=; b=wj1/Wsh+bQka6gJ4jBdowPhDhs
	g8gLBxO7/PKOjYRLCCVCO6ZvOysRc3jmOPcE3r5l2gE6LktHl2i2l3vjKGpxCh5I
	QYg9kv2NadyhehKxmqolpDNidrf1rOR7HZNrZeICRwqbquKFGlU5HLJxOsALCOr/
	XvqbrShQicBlLxpBwxMEMi43xaUK9tL2iGfjg8XmvZhuyn2lDFbMxwKPw5PvgJ+s
	GrtHd4qPU82Hpdc/JQmKkn9L+nGgVN5yhxGJtAd5oUG5uLvHmhUvUrcvb+75zYbn
	ueyrAazCCPo+DibFzD6zz+HzYKh+em97UzuzIFE8oa4gR53GAoRzovvKQiyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734333938; x=1734420338; bh=wfXlJTgfkYxDqM2Lirj/pt7tIvxZUklitdX
	ZTY8NZ98=; b=tbF7NFJHgrAO2s76gaRGhIpVnf/wsncpeJrvXqzDCDlHeMdKo16
	XJYCVkg86ABvfK79waDgqyKOB91wQkYu7KlE2mH44gPqdMbDd8c8UQYUiFrPnjaT
	OWCh71MgIhWI+ebnLyTSg2EGOOB74yEqJgiyu67dGWrwompjUeo4junIsyv1F8ue
	lHKRysIpkE/9sqi/MUDN30RFlKZ/iW5Vxw/kqK7wERB4XsNFIRWtGuSqZHEl4PJn
	FjZ4pB+03Eig+Kus3RkEZwO1lDZ4Zjre6/I2r4RTEH9uEi6oAHlczOQgJSzV/xYq
	RJV5fqfYK+7IFCd8tKLi86mvUemV2iLfQ6g==
X-ME-Sender: <xms:8dVfZ7RoO9vASpEdBxLkK-XbEyYEKnl0_P3lXHM6BYkaoxLzfJd4sQ>
    <xme:8dVfZ8xoQ57QYayAJNXYTfGMLbASErR-FEOmWy2zrH1fksNfAbRIRVtp7kzW1c2fj
    W12LeOr8S1ErvO6pA>
X-ME-Received: <xmr:8dVfZw0_S24jkzgCuSbN_ZQp5LduZnaZpf0qbZpAd42SZIXTZTtf3h5F7vPA8q9R00c0EASkrv3TkpQHn1yvgp6X5YOeboX50IP8J2YCNi1NNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8dVfZ7DyjjsSpGmXiH4-A3cJ2drxEumOEdbVKgGcpIKp1P7oOEorlA>
    <xmx:8dVfZ0g5a2BsmmxRXS32XrQZjo8YtfzDZII7QewyIBPERXIdLctvuw>
    <xmx:8dVfZ_qvZCIZlcPk2haHdTyUFRQqOzqu4YcY5PLDj-Wda-0aS6pxcA>
    <xmx:8dVfZ_gaD5QG2bw5GRVnXaC-BF_CdmRIShItgKs2uFUVeOnMHMrSwQ>
    <xmx:8tVfZ9taEZNisNgzh5RYehyVCwUBTYXnTz_cq_69ovabzUr2LXihOKF7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 02:25:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 585c0b09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 07:23:53 +0000 (UTC)
Date: Mon, 16 Dec 2024 08:25:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 8/8] refs: add support for migrating reflogs
Message-ID: <Z1_KzlKc7RBfas4L@pks.im>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
 <20241215-320-git-refs-migrate-reflogs-v3-8-4127fe707b98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-8-4127fe707b98@gmail.com>

On Sun, Dec 15, 2024 at 05:25:45PM +0100, Karthik Nayak wrote:
> @@ -2705,6 +2707,52 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
>  	return ret;
>  }
>  
> +struct reflog_migration_data {
> +	unsigned int index;
> +	const char *refname;
> +	struct ref_store *old_refs;
> +	struct ref_transaction *transaction;
> +	struct strbuf *errbuf;
> +	struct strbuf *sb;
> +};
> +
> +static int migrate_one_reflog_entry(struct object_id *old_oid,
> +				    struct object_id *new_oid,
> +				    const char *committer,
> +				    timestamp_t timestamp, int tz,
> +				    const char *msg, void *cb_data)
> +{
> +	struct reflog_migration_data *data = cb_data;
> +	const char *date;
> +	int ret;
> +
> +	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
> +	strbuf_reset(data->sb);
> +	/* committer contains name and email */
> +	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
> +
> +	ret = ref_transaction_update_reflog(data->transaction, data->refname,
> +					    new_oid, old_oid, data->sb->buf,
> +					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
> +					    data->index++, data->errbuf);
> +	return ret;
> +}
> +
> +static int migrate_one_reflog(const char *refname, void *cb_data)
> +{
> +	struct migration_data *migration_data = cb_data;
> +	struct reflog_migration_data data;
> +
> +	data.refname = refname;
> +	data.old_refs = migration_data->old_refs;
> +	data.transaction = migration_data->transaction;
> +	data.errbuf = migration_data->errbuf;
> +	data.sb = &migration_data->sb;

The `index` variable isn't getting initialized here anymore, so its
value is essenitally random. I'd propose to use designated initializers
for `data` to fix this:

    struct reflog_migration_data data = {
        .refname = refname,
        .old_refs = migration_data->old_refs,
        .transaction = migration_data->transaction,
        .errbuf = migration_data->errbuf,
        .sb = &migration_data->sb,
    };

Maybe that fixes the issue that Junio has seen?

Patrick
