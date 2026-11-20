Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173344;
	b=uozBo2jAjKrdm0/dCqUy6shMY+MXk5+Pvk0PQhZc9mDUvgps/+1s/GiCkm4Eioyh1aTa
	 beci0hnlwcEE5ze8EjWGpsFgAdOg5GHBM9OtGQAcDgmoA5CWlYMVvTDuQYJysxZhlOadR
	 gnHvTp+Ls0qU21a0xWYUOVQDlS2W7BZ36qllK2ZGhEcflOd+dacxImnvAKTtVWd5GjI9R
	 pGkuDTmOAsSD5WAy1qZlxjySmd5UNXBxPAYO/ePdazwCOhXFokCgRKorHWU0inYKWksIX
	 r/I+cJMAEW6CiO+/xzP19EO1gx7Aczqzi71R2ySlhTRr1GgAqE0/loWI2VCZL8dUaKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173344;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nNCKtNYc2CSI8JjMNgNfdIM//HnaYVYTmuT9qgxcAs8=;
	b=SgWdYmlfzBlXztnhsJinRwgEdlZdPqQqc3xITlEJQ/mTT0qfRbd8Dm1KsBCieXpJjJYU
	 Q/MZY4I5PmMjd6v1WBgeL85seiHdyx73znoqoRHcIbwsVjYfye+IUGTMKrH4QJQW0Sup+
	 L79RU80Bu1469KzYOQaojcWpJrubnsmpxY7EPvnx33/tmw9I985foxBjjThOQjMuMrIXA
	 e0ksX3pdEmcH0AgZEmEyyYoofnFZ5WHjtlFFt5R3eKRmCfk+NRldPV4psYaFjh/AS7C2I
	 llGJiFIFARnfWy8emN+Yu1KmSVlzZ/VMz56UK7nm3E8sh+wXEdmml3u+w6mjXe850Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="DTq/nuuG";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IT1kUWA5;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D24606A33B
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D24606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=DTq/nuuG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IT1kUWA5
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B8F91D000A7
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:15:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Nov 2026 06:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795173342; x=1795259742; bh=nNCKtNYc2C
	SI8JjMNgNfdIM//HnaYVYTmuT9qgxcAs8=; b=DTq/nuuGjg7HbHjS2rpzXcLGAI
	z2V1/76vr6Zi+a40SF02nlzyF/WLl+c1+U7+TVftmTj4kmDUlEn44+W1xAKQXdsX
	HOMwlGVABCns9TdjliOc3kLjdwc8oCvHkitJDLJkf/ExFQvrHj6MRNEcJtGf2V19
	xoNF1+ExPpTg2Vzhc0RnkMCC0daHoSVKCox/9/Y5xkKqGx4KX9GrdgT1lM9lSF04
	au0Inyoc426BYAIQD9B8w3E7OK2rrYMq7F0nQBYgy9fieTCsDWoSGd6hyaMSVuj/
	BLDI+1BOBj6iDudAHSAcAuPzE15v+qepsXgP/rdqewA0L4rV1Ofwj8HFua9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795173342; x=1795259742; bh=nNCKtNYc2CSI8JjMNgNfdIM//HnaYVYTmuT
	9qgxcAs8=; b=IT1kUWA5mKhbF1QGquymXPd6eNKNFJH7rJ/s41ThgcTi078RWbs
	k7Wvbt73vnDO4o/PtHG2qhnkwYaeSw8zrhYaO8z9sAa4IETsM18iSu6DScx0fFiT
	wGwYiVU5kYJHELnf409a6GMZQUwDAmH2IMRCYUi/IbuRrhTLjY1yoewLAN5pYXPO
	msKUkF8Rmc7myEw8khRpVCGAiJ88x2/zqqwedcFmIhLzE58tV/O1kMPjurkHW/mm
	o1kUESryI9zQLpUPGN/pPKJ0n3txxAJ6hDv1F7sKi+fMbbUf6uH6fegIZqc/o0I1
	be5tBBAQ4nO/AOMWClUabrrPyhuHjmlBn/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795173342; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:XHA4phbHwyk+G6OzfD2lejtHr+N0Zo8/b3kOo7VE3wxRnn9
	lkvQnGIZYoi9eDczTXGzVE2UdRpe/y51bXEYiewhMuqTclZBWouQ84fLkD6zWCPI
	BPUXDoZm9EHKZ7+Ftzg+CZFEcVvWDZn0SW82NzrPlw5gUW19+oQ0azHmJ2krsW4Z
	MBeLDhnKarvheWroaL5X4eZ5Fwtu7oXsn7XvzTnkZBUBWM1lfng/0hjTkR8wp/QL
	OaU6CaLdCGIfyeGcOhhlVmP9SwJAVl8owjv+6mLiBm/ubUigBZlU7jcj3G/ZKM4O
	Eh7tc2Hf0z5qhWmKJu9zcHvHSFMhtozUo4DohmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:anOaNeMc8RupkGSkYLHmxoRFeNWGnEf5CLObBnwpvpE=:lpU6jpV6LJj89vs+nEPBgh9yMQIvryx2SWQDQYn0UXo=;
X-ME-Sender: <xms:3isAa-i_c1xkrxK6Mn-81GDVn17V6nTEGpYzaZdIlycli3CVzcrkpg>
    <xme:3isAa1DFJk7nD58hvWfnLLllG8kkdPb_UqENe6lKhNwJ3QVZujHnn6_fjBTjsPpXg
    qM4hu8QLei-aC92WH7T2NFPYxLuUy20H3sJW7uUfTprMRYpo83cv2Bx>
X-ME-Received: <xmr:3isAazvZ0JVpBSt3q_sm94uKNGHi22Kr4qqtADN8gl4bv1hLCIbW_MBZziJEaCPAocBhIWQ>
X-ME-Proxy-Cause: dmFkZTGttkAbzpYhnJo7NzNld9gBRqlZJLRMAQP0QZd0ZBWbKnCdJB3r70C9sm4Eb+a0Q3
    /hKS/tJmUxfK0wQMDGuvCKN4VsU7vHsRNFwp093LavHRlChWyMhhTCWmbalWbZ5D5oh5Fv
    4uQfmR6E6uy1I+OFyWx1d6LpKWxnIRWRF78/LZOAILN/GQYHkHdGAtkgcLsMR+nC3/SRNq
    Yxs9eVpAZ7rfW31lPpxjS8YTxyapgI3aN7c/U4M8HpQ74shuE3df7uZlqk28CDM7nPbfM8
    nvvuS7vQAJX+/54wGxa6I0ph3lWMhe3NmaRs6TLkMq+4pVppFd4zUTTnxVaBtcfA3dbxjp
    I/HdaucQhtI8+38twEbYR6xcYZAGuTnmDn63L5HUNwWz0RpvRqymXMbuEjALADoC6eQ2qM
    cGE9hJqE6gP1cPHWmkAxV8RVlQVaFCICVa9TNEnmhEfAadFBg//5bZXYlrSsmLgxXf6x7l
    RiAtVzG8/9O+jVnSmhBDJl+UfOq6GBWWEgotFntpsd8FnPjv8HYk/912W76q3ABdLD0O9f
    VsM0dZUc5NByxgpXICLp5GqbfRcXjseA86JkGaeTvxiVhr/FurM9+QZMmSv7mLBpzEWzpj
    GDmmlEYeLQ6ynZBT/Cp6RwhkRd+mP4MFKFLRCeyKg4bUkurdkYDKv92swMTA
X-ME-Proxy: <xmx:3isAaybJVQF81RNdhiDVdKO5ubEbjZV3N31h_eQfuvuNmvNnDNRpzA>
    <xmx:3isAa-VGDfGArE6JhzZ2gXAujFlCH29ibZAE41nChunRRiJFIzBhPA>
    <xmx:3isAa-7YDB8UREfgz7duLGdvYxmt3tziPjgKDNcT63iquwQgeS2O_w>
    <xmx:3isAaxjkWv5P2JZp0mDqbx6U64xjAI1FfOcoa1ezezc8f5-TMkvQpg>
    <xmx:3isAax7ibgHnnQIHqHCoQjSK42uO1dfw-T_egwsuuPbDIWjuuYHMW64_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 06:15:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7baba197 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 11:15:40 +0000 (UTC)
Date: Fri, 20 Nov 2026 12:15:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] commit-graph: simplify linking commit graph chains
Message-ID: <awArrFeY_B98IGoI@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
 <20261116-pks-odb-pluggable-commit-graphs-v1-1-a83fc1ff0808@pks.im>
 <xmqqqzgkjy57.fsf@gitster.g>
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
In-Reply-To: <xmqqqzgkjy57.fsf@gitster.g>

On Mon, Nov 16, 2026 at 12:53:56PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/commit-graph.c b/commit-graph.c
> > index da65cd3deb9..94c761907a0 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
[snip]
> >  	if (n && !g->chunk_base_graphs) {
> >  		warning(_("commit-graph has no base graphs chunk"));
> > -		return 0;
> > +		return -1;
> >  	}
> 
> It might be obvious when reading (and writing) this patch, but it is
> a welcome change to standardize on "0 means happy" convention.
> Should the fact that we now use more common error reporting
> convention be mentioned in the log message?

Yeah, that's a good idea.

> >  	if (g->chunk_base_graphs_size / g->hash_algo->rawsz < n) {
> >  		warning(_("commit-graph base graphs chunk is too small"));
> > -		return 0;
> > +		return -1;
> >  	}
> >  
> > -	while (n) {
> > +	for (layer = base; layer; layer = layer->base_graph) {
> >  		n--;
> > -
> > -		if (!cur_g ||
> > -		    !oideq(&oids[n], &cur_g->oid) ||
> > -		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
> > +		if (!hasheq(layer->oid.hash,
> > +			    g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
> >  			    g->hash_algo)) {
> 
> We no longer check cur_g->oid is what we expect, because we lost the
> array that holds the value to compare.  Would this make cur_g->oid a
> write-only member that is only computed and written but never used
> other than reporting purposes?  In commit-graph.c before this step,
> I think this is the only place that reads ->oid for purposes other
> than passing it to diagnostics like die/warn.
> 
> We seem to still be making sure in load_commit_graph_chain_fd_st()
> that the line we read into local oid there is a hash, so perhaps it
> is possible to validate g->oid against this oid after we load g?

Yeah. The thing is that this whole is somewhat flawed in the first
place. It seems like this check is designed to verify whether each
respective layer that we load matches the expected object ID in the
chain file. But that's actually not the case: we don't verify the base
layer, and we don't verify the topmost layer, either.

So the obvious fix woudl be the following:

diff --git a/commit-graph.c b/commit-graph.c
index 94c761907a0..47a97c9fbc0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -679,7 +679,10 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 			free(graph_name);
 
 			if (g) {
-				if (!commit_graph_link_base(g, graph_chain)) {
+				if (oidcmp(&oid, &g->oid)) {
+					warning(_("commit-graph chain does not match"));
+					commit_graph_free(g);
+				} else if (!commit_graph_link_base(g, graph_chain)) {
 					graph_chain = g;
 					valid = 1;
 				} else {

But in fact, that is a stricter check than before, because we now verify
that every single layer's trailer hash matches what we have in our chain
file.

From my persective that's an improvement, as it improves the validation
and also makes the code more obvious. But it does cause a test failure
because we implicitly rely on the base layer not having been verified in
t5324.

I'm inclined to add another preparatory commit to this patch series that
fixes this issue. Which makes me wonder whether I should further split
this patch series in two, as it has grown quite long by now and is thus
quite involved to review.

Patrick
