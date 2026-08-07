Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D83AB28D
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086224; cv=none; b=Pkp9S2O92oxelFizdjT/qtVXHgGGuhoa7dDh1HaNFNcoXYbc6OLeqbHev8BtNdTMZX7gjG6p6fQydspFLAxY3YVwUl42X6b0ulITgg1kUDuKR3+5HkQ6DJfWRXeA0kvOpHpeX3sibZ2U7iZdMAcUGq7Mx+5bC5NeEVIUG9nhACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086224; c=relaxed/simple;
	bh=AwiBLtcqaU50/LI1lcVcLYtTX8ip77lHoh++qVPvkTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoP8VFolFDA1J3WJwGHVclcewmnvJ8+cPGrBO5rUmNPKhB2wV7m+FzrNtSSnTBAvmjA5Tv+RWJ+J1dTCEaVHymULSsuJ1Cfl9OjkiNLwtRfmUQxGHNtBN1oKPZDEEVmQwNd2eMP2X7e+o/ccQu6+JyO+TGxEljR83dkwO8n1dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BbLownRL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZEKORnYv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BbLownRL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEKORnYv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CEF414000B4;
	Fri,  7 Aug 2026 03:03:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 03:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786086222; x=1786172622; bh=eWtbCrKY7C
	HCkX8n7+aTsUL+ye9gqvVmRmQnEAs0MQ8=; b=BbLownRL2gMJ7+W10FfKRhog31
	0xGkqHIhFYH9+DXbazrgae3W6OO4m+elThIMcNPBVTf8TYl31ovawd0HP73Dvh0v
	PzWWwl0NnSyjN1o5W4PdAYyCKxd+5N5m/7GNLtvZlm7GyHK1kH7IQtmi9dbHNkPs
	tlT5SPfvWYTZuQV5xGbTsrQyibmIslgIGEd1VOH+JviNYUzBOvy3Vh5U1IZc/R+J
	trswhxQB5mGNYuHNCvC8CPl6jl1thJhrg6QIs722d9vwujEhScZO0zIA6NRnkDt5
	sLWUKis4bb4/AAcSVOlt0BCpHjLioFYbw/9ApcIX8gx7a7wg7UwaBUNfjCAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786086222; x=1786172622; bh=eWtbCrKY7CHCkX8n7+aTsUL+ye9gqvVmRmQ
	nEAs0MQ8=; b=ZEKORnYvVsIOMahe6uU1Fiv2rtiMMT00Bn5+WcVFkpX6W0VIl0W
	ZqjOGGKakhcw/ThhoBi/oTGTETS+mK4ucyOJZBIM4dhduPdfHTmaL2QdutzTY8an
	kqcYYSFA765GcRxKElVsJh/yjVB//6OZiiyf6nCLQaGEQZeE+6b6KYJ1yJyMc1cl
	NmO/+XUgWqvob27giVr7SqTcp+Jpjb4aD2Ryv4TmJBL6RtpxieaoeURjooaLF1Lr
	0yajqxFlCrxTTnTZ3e/0DMQ6LEMYoPpPCtTqlw7hTsmLMB8f9eVL/CznznGsUmwb
	xaPw90KchxrvalFk/jsDRXROtYH6p8Bo7ow==
X-ME-Sender: <xms:ToN1amZ5yBmLWJm-AV-UjUDIMkFxMQpA64clLf-Hhj3AMEOWbnlGgQ>
    <xme:ToN1avbzCE7MscgPqLS_ejxS1ICKEyc_t2gwM1MO_wqA_4LCSGzNAH95Tkmoy7kAv
    _FtY9O28y6wdCnZoV0-n9-77cluG3_-FWjqRAf8A4SL-03qsxPp9w>
X-ME-Received: <xmr:ToN1aunZD7Si92yUDrf8VBqWM-xN0cPYdr5sIUOQfGBOpT8FgaYciVUCHG0qtp6CMMML_DvyyU5RPjdtJEE2oAQ0QY872xXu4WYvv13C_et9VQ>
X-ME-Proxy-Cause: dmFkZTE26y9njCNpXPcmZxYe4ifaNpV+sYlC5mYRUIr+ln+pB38Sh4kjo5WX0zU5LY8sit
    +oeUUeuwuVDmjatud2iyJtMdnBGrHtsLnRGmbTcsfv4XslNEpw1gmYRc4vkyxvvkVzb6bZ
    FW+Hc4Ewp0bN9yMqVLHrPU0VZXSxvfa2uONHO4C1LZMZN/4xo/SlyjWqoa1PpzuveaGMel
    tb8CZN49JwAhjMMI8vzeUDPe9GRJE1Pij+NlRwONiI8W2cbrpyJAIUbCY4UmewvnRVelNo
    mmLmZkIFSOfTf9/ExxwJZ9KjT4RrzlQa8TreUzcLYfr16STGdtDWK6anYTN5DZxvjKF6Nt
    q1KxqKInJZZBJE1C8oDy66AANguOy9xDghfkKBXAzFIRKeP0LiToXB9FlGxlfY8t7nso9O
    igDwK4A0YFrsMipFlsSHY4Y4c6lZEZizYFwM3QaAZbEIj2V6m1i0D0csQN3UOstu3a+CXc
    6xqKnqWLp8+bcdVXertarGFoiDafI5YLEuZbiqtvIdkDi0Fem7SAKJI37zM6Li/gw3Yj2G
    kjWc+YfX1UDlL/NmCh5j+gp0gg1Y9OnqqB0qIDVgVix57tmOBX0tB0JemaWxKpVR5KkdmK
    He2IEVkBsKL+lUj35TZzukyn914zAj1zh/TUdtOrMSNtnj72CLwhEeEeIYxw
X-ME-Proxy: <xmx:ToN1ajxnLQFObvvyl-ybzTuxlIIg_-33dAH3b-vyturJUT1UMcdPEg>
    <xmx:ToN1akNaK2jh5IpMvTw37GUjCVBaCEGSFpOegWUcOT7Z6fSRRE8aNw>
    <xmx:ToN1avSL6Tq8DDQxYIivBGEu7ZHlEuzrYdPsHzk7DSA4DP9kWKnjBw>
    <xmx:ToN1aqaBsmHY4cvckEn2a5qRWqssKnrm2s9aSE0OD_tuGKCZKLSwVw>
    <xmx:ToN1asIaUqmZxL_MfRBWLQ884cU5KOHQSJewJRXN05nkp3VYWk3IaVBF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 03:03:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efc56621 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 07:03:41 +0000 (UTC)
Date: Fri, 7 Aug 2026 09:03:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] builtin/receive-pack: lift global state out of
 unpack()
Message-ID: <anWDSt155Y9hzHGM@pks.im>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806213859.816157-4-jltobler@gmail.com>

On Thu, Aug 06, 2026 at 04:38:56PM -0500, Justin Tobler wrote:
> In git-receive-pack(1), writing the packfile to the transaction is
> handled via `unpack()` which relies on global variables to decide how to
> invoke the underlying git-index-pack(1) or git-unpack-objects(1) child
> processes. In a subsequent commit, the `unpack()` logic is moved behind
> a generic ODB transaction interface to handle writing packfiles and thus
> can no rely on these globals.

Nit: either "can not" or "can no longer".

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 6da854fca2..8c2d6e5789 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2333,18 +2333,25 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
>  		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
>  }
>  
> +struct unpack_opts {
> +	const char *fsck_msg_types;
> +	const char *shallow_file;
> +	off_t max_input_size;
> +	int fsck_objects;
> +	int unpack_limit;
> +	int reject_thin;
> +	int err_fd;
> +	int quiet;
> +};
> +
>  static const char *unpack(struct odb_transaction *transaction,
> -			  const char *shallow_file, int err_fd)
> +			  const struct unpack_opts *opts)
>  {
>  	struct pack_header hdr;
>  	const char *hdr_err;
>  	int status;
>  	struct child_process child = CHILD_PROCESS_INIT;
> -	int fsck_objects = (receive_fsck_objects >= 0
> -			    ? receive_fsck_objects
> -			    : transfer_fsck_objects >= 0
> -			    ? transfer_fsck_objects
> -			    : 0);
> +	int err_fd = opts->err_fd;
>  
>  	hdr_err = parse_pack_header(&hdr);
>  	if (hdr_err) {

It's quite hard to see that the function indeed doesn't rely on the
global variables anymore, and I'm quite certain that I'd not spot cases
that you forgot to convert to use the options structure instead. But I
assume that the function will move into a different file in a subsequent
commit, so we'd notice in that patch.

> @@ -2428,11 +2435,24 @@ static const char *unpack(struct odb_transaction *transaction,
>  static const char *unpack_with_sideband(struct odb_transaction *transaction,
>  					const char *shallow_file)
>  {
> +	struct unpack_opts opts = {
> +		.fsck_objects = (receive_fsck_objects >= 0
> +				 ? receive_fsck_objects
> +				 : transfer_fsck_objects >= 0
> +				 ? transfer_fsck_objects
> +				 : 0),

This looks quite ugly, but it's no more ugly than the previous code it
replaces.

> @@ -2441,7 +2461,8 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
>  	if (start_async(&muxer))
>  		return NULL;
>  
> -	ret = unpack(transaction, shallow_file, muxer.in);
> +	opts.err_fd = muxer.in;
> +	ret = unpack(transaction, &opts);

Hm, okay. I guess this here is because we only want to manually read
stderr in case we use the sideband. It's a bit unfortunate that this
requires us to modify the passed-in options structure, but I guess I can
live with that.

Patrick
