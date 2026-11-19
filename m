Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089489;
	b=FVwRCUo1vZoMF4YrdFBguO62VAUtSwQ8Ua3ec0IJNoeElVo7JFfjLsa98Ac2eHGhzGJ5
	 gOdaD5/ZWYm9cLofMLMQSI1rC/sEJTy5PSuGdpCltgDtEDOR2IFbiPX7NgLDcW6wa+2VC
	 jwsSR9bj33Xbc16cly7Ii4MSHU9lH8sS68HcypoukkClwLgqi+hGfZYTtSaGpn47rWhOx
	 KAq8Fn+oChKswJLZfelXDjJI8rbYHzv13O28J4M0GOGGBfKetNvYmIARp1DstmNXsGKhg
	 t0FwN6lNzq5JXCVOW7nvSupz3CsVJ5nvIrmPgMxzMRhtlT+Q9o23ubbWsLt+7NS4TZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089489;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YiHsJvmZNBT3PSZFo11XvVMpJFfTIW6Lxd9my0Ee46E=;
	b=YjpEuL6KJxgRWtTt6dK2holpGBuBZIbbDXIgMKsy/Zd7X8QnzRwim2D1vpiPiccIrwbu
	 56aJ6rvkKir0Npnacq+WmMMt5jJzeEi/BBQNQIsOg9Zp0LZRhHP8KzsLLWGXlqjC7ognG
	 0lMHvHY4cEJZz6NpVlut88b3DJUZpxT+cKPjYVW6iDRO+bUoXp8M4ERozoUZrMCxUb2Lh
	 mai2OYkD5+Au5w9qGVLpxhaB2wUcfPzisteAKIhK8C+BoWAmJ8oZPfGUIrcMr6wgHaEPT
	 Dw55521gTT/lakfuow97CIyLFwOkdLpDYQ76e0oaTZjZfJZ48QAZOgYgQVBz0o4NPBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gqjbWSHE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B4SW+ekx;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77849606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77849606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gqjbWSHE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B4SW+ekx
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 900DD140014D
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:58:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 19 Nov 2026 06:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795089488; x=1795175888; bh=YiHsJvmZNB
	T3PSZFo11XvVMpJFfTIW6Lxd9my0Ee46E=; b=gqjbWSHErHs3HMRja2BThZoYc5
	FdL/EJCwnFP/ZMv1ND79wbMm0THGSEIB1A0R6dCcWru3ipsIII/qaVss9H1gR/sT
	7uXRbsvVMwGYiFUfGl5AJGcI9t1xtzlQlvpjkPN5xl3/LBUQfo4/h7U5n25hTNWC
	ItVGts2WbnXd+l5q0MZ+8ZFXQ17BNhHiLRA6QbNeFl0UcZkSsHQ8PA/RPm1JfBT6
	nDjnAAivnYy3xCDfp/nwNOHXVFhMxQYAw7Z7vk8WwxuIJGpD1zq+VmC8hH7uGXhl
	KqsgLmzlg/VFuETbXGLS2AY2kZfrGGLBcXXs+CvU+oWgBSmbIebBhm5rc2Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795089488; x=1795175888; bh=YiHsJvmZNBT3PSZFo11XvVMpJFfTIW6Lxd9
	my0Ee46E=; b=B4SW+ekxgj3zI7QHAop+C8N//U/HMTyT/b6IxREyywiNkdh15xQ
	bfT42yRLohw5wlDtP9/Im4ZUqNdVskPUNNG2SSOgg87QWgMFfH7mFRtjO6XhP/jZ
	2NtTsYNQzw5oS7O6rlnAV819PYC2eUuec57J9LKMIn4MXk6NcvjRo1HhL/un8bRz
	A0Svk5Hd5es6w1BinJlCNKbm3hGA7P9lx1b9wMlpelo2ZWTz6V4TM5mU40bEMiCc
	QqVRXH/nvVQVnxl5uyRGIcYFbP+pSlvCssS3O2DPiYtenfyvweYIFvCsJYMsTjHM
	vTkxC763D9ShXhQPDeFHxdYY/HkauIHUrFw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795089488; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:jsFqEEbHvsTqJYawTbz93rwU5APl9wOyJEMOHr70zotnW+f
	j9gTu7+xA8UwmzQ6R5hJ3PrKWGGTr5DaoAqyqWi2mLucmR0kp9Fmlp0wLLbMaZJl
	QbC8e6bbiFDB2rBENOqvm/5I/39B3zDVxF2GRiInj0TbW/EJZjN/UFbBuMq5OqIw
	t4lrLY3wF7vx0ry6V4miRUS0tN6QA7qdj4JF8yx5JPd8j1WmELSidj/G5PwiRj30
	z+N+2/JjdRDPW76N4bH5/SiNC5P9fLztzzJczlz8Ko6dFkYEqUlhAmAk+VUGVDHW
	N78+LFhq03cTAR/7FfmaC+fNVYXbZLpAZj1zhbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9qUzCsG9TRdKkQjZYP+gsPBMduAmhsSNhhHtBoPXTVc=:sPUzpvayj/WiHDT0UzVefE0Iw4Rzaw46A4x7FxIwZgE=;
X-ME-Sender: <xms:UOT-anP0PVne-RJHFnf5LWCVVYA70Xp5yxnzniKPPQU_X-lrwkdaXg>
    <xme:UOT-an8GmJXNErqA8uV0jIkHM7hvUZeSAgatpVNW9wqDAXV-C1M1r8MtMbZ0eV7FS
    o_yrqFFhEQaXMVTT6_vJEeOIHwEke1mlzR9167TdNeW_5L5IZiFmp8>
X-ME-Received: <xmr:UOT-aj7U7ZpnXQr-NF26asm3HDHP5frFIQksd-nBhYWDezOYCu_pNfyBtJZLl561I1Fj6c0>
X-ME-Proxy-Cause: dmFkZTFTy9HdFjUvbgocAWysPQZxTFK888d1jDT9oHlDbasVQclKNnJPaOv7QjW3B/KLCC
    fA4rSt+nRlcL9UoxMdO8YTw9PawBTiuRUGtqZU6ArTlGDoLU73QUDsurlivFzzdjnVfCKz
    XxeYVky5dzoG6tUQtGS3iIMrf0gK3ASrOQueGvpAI/5r4djimnpOm6uSjQjmu2DV/eU6Ko
    oKvDHRPSsalqA3PdFs7VuLNyu7WGnsrNeAuLoVvlpch74DeNGdy87Ecgp0vHNsdjS23qiB
    Gvez2rNZgF0RUo0LLoDjqh/galX2/JQndYSaEXT7awvGA3TPpuOalf3uVoUwqmVmX6aOpE
    FkX6ItEijgcEIrPqt4/7WF2aQRiTVE7JIkGDTxspvKixfv3qGByNXFIGw6fzejSJGbkQ4/
    mUOJtmWN/hQ/ng2nshuigPBxIkMbTmbGaqJsWweVQqSgIOmg7Gyop6R1SW20gj9y276d8v
    /oha0z2Kj0ngAo7UWMVBo3pr/R3sOj8Vx4qi6lYhOMzcb3i45y3FZBe0DvYsJnKjPTolQL
    iHZp7+VPvxS6aXgRdttzkfoMqRUBhB4u4A0dq0WEXQfcsdAOZExn6IJbt2IDe4zLLpDNmS
    dUCPNN3jcJRsSn4j/5C4JkXGsOXdDBxtAxvfyif2/u3Z2vmCqDzCvaWSDwYQ
X-ME-Proxy: <xmx:UOT-am1b9TiixE32L3vIjuaJ8eRb62EsblIcUEAthkzClWs7kAvU2g>
    <xmx:UOT-aiBZ3mhwuPSnWqdh4lQakIv5idMRIX-tm7V2A5L7mzTABdlN6A>
    <xmx:UOT-ag2e1vHs3QoLmRAebSICJjUBhX_Gtfi13K3mGSnx7oBuoRn-mw>
    <xmx:UOT-akus8Z9nyMNHaJ_QBU_Tqcm8IRv3GgE5m9K6I3uU8q-VhFDr_g>
    <xmx:UOT-aik4HYIYsdUBTqTMOt7n66S8qDRRjEfZOb4cKgkKEKnjN4_5xWwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:58:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 598a3b2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:58:06 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:57:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] refs/reftable: don't write new table when expire is
 a no-op
Message-ID: <av7kRjkcrmW_FtQK@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-2-10b9263566a8@pks.im>
 <87jymajgqw.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jymajgqw.fsf@dev.null.iotcl.com.invalid>

On Wed, Nov 18, 2026 at 04:34:15PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 4216a18684d..e2027bb9c02 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -2696,17 +2697,25 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
> >  				    logs[i].value.update.message,
> >  				    policy_cb_data)) {
> >  			dest->value_type = REFTABLE_LOG_DELETION;
> > +			has_changes = true;
> >  		} else {
> > -			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash)
> > +			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash &&
> > +			    memcmp(dest->value.update.old_hash, last_hash,
> > +				   ref_store->repo->hash_algo->rawsz)) {
> >  				memcpy(dest->value.update.old_hash, last_hash, GIT_MAX_RAWSZ);
> 
> I cannot help being bothered by using GIT_MAX_RAWSZ here, and
> ref_store->repo->hash_algo->rawsz the line above. Would it make sense to
> be consistent?

Fair point, will fix.

Patrick
