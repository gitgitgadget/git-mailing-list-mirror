Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B22360EC9
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513172; cv=none; b=igYocL3TMaAUuk7fQOOpK+XCHZ5tKDJSaQ77nQJxFH8hoN7t0d8aOEo2oT2/X/ri8Eq/FBtShe0tYY/hOkyEVH9ekff5UgbAh+mjzbnjYKX+XT+thClehNLQYo3W2PkUMVEwtP+N8sNBhuVJPif/V2WOoo8lYI1LOatH1n1KiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513172; c=relaxed/simple;
	bh=fi1O3ircmSon5jSNshphGMXtbOcjCMN/Fx1OvVZMWsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV8oc0Lv1fzakr9kajHUiVQ5IY8n8miOyqtkXMjxO9uwOim2pINTIDajcdkOO34LVgoggdKd502G/nh085eTJMHvTtc1vPqnXsCsC0vmvHuhqls9r/KKPmist74t75T7oPE6zszBOGMwvFVhCTXL5oGm3L38YeUloYWaqONDKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hb4jmm4N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HA/WRTvU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hb4jmm4N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HA/WRTvU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D6996EC0214;
	Wed, 12 Aug 2026 01:39:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 01:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786513169; x=1786599569; bh=0OA+waPSlQ
	4XVoDxuYzNXu532QlvB7pj3+2ZEnAojq8=; b=hb4jmm4NGDLJrFuqDONL6QwhDc
	MYdm2tM6fituoDYOlasE42GjWrKG+WGpN4JaYNAsQuVy6vca2a9+WePoDRc7Gopu
	qeglQnE+UMT1MnSE6/uUF3EAqfEO3u3exIJk5d/jWBKW7ETs0MgnjhJVESsPLCuW
	9YPuqkAW25pa2qXaJnW5EzlpkY9ytymW05h0N8B80W/w/0fU0/mKtdo3TtVq33Y1
	8f5fFGxtZPzEjTp2pKjdy/WRZIuqOPwu8ZhUhbev4jsNzZ60JkbRzhFwPopBLAyd
	5SuB3uGTi0cguoNN7HvNyAERqw630RxPCSoDlIyRQJUXTbB76ETj8BZWcU4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786513169; x=1786599569; bh=0OA+waPSlQ4XVoDxuYzNXu532QlvB7pj3+2
	ZEnAojq8=; b=HA/WRTvURR6JzP5HB5KkCS2dGLOp74W65eu7dccZiZtUQRmS1V8
	PMrDzGkKxly9ynYv1tvjwLe/I4Dh3T2i8DBHNAjb2+w+CWp3JOjUdMdYmAiT9IIS
	pg494q2RUXiizTNpUNqg3fMDp9NjigCZZQPf9Dyjgc4wwRtpva3+NcxpOLlW11Qm
	1ZOBqdyiAPTsuts7P/RF+Qw4XjrVe3cRN+hTn/qD2VbXvDuK+C1zgVNWfBWtz9Bi
	ljZHXXHOnd2qRya87Sp9m/m2l7aBYBASX6kiiJOtpJ1MCSTvjzGVz4ptl5HjvcUa
	zh2mWCUJ3lhBoLyPjLeLXX4Na1jAe8/AqNg==
X-ME-Sender: <xms:EQd8agj5FV4uYAvYG6Ljy5MD3jLyWd4dya6kmTZFUQHSzca-4RkD9A>
    <xme:EQd8avDXCyloL0nmyo8hR70OhqmNDjR6IvhpXZ3PKopGzpLjF1OeoYtMMBv6AWPYQ
    vmfqObONO50bIqqS5emISbE-Wo0ShpL8QPIyfO7V63w8wX7rubumA>
X-ME-Received: <xmr:EQd8aluHlYMZegGjRUvc725E00hjDrqpYJLulfyZrvv2le6j77tNzwwAPZ9fFHbkBpozmZo58hnBWE1Aa_3CglpL_-BxfGR_1LR_FufXJQ>
X-ME-Proxy-Cause: dmFkZTGr9ssf0/cMkN7fp9OZbDCNscLG3zZlA/yjmd+tbvzYvdMaKES5AdHFCYV4Ek7uYV
    9yDz+hADhEkZTT1WG8fBE3NgN+MScdedDTuF7WgTwHCFQ8+sB4kSGQSZSsxCIa1zipJne9
    /pPHNHBBKe/JI+o0/L3sqO77LwdN3Bdq/kl4HC8SasJ5RpaLc2AiBomdasGIuTPcFJo8oS
    eE7Y/1pkhfOLrxfdzAwiQziU1sY3JuRhv+pD2z3qNEy2M9dFISatkjuSvezbW/yG2u1iVp
    Egorg2Ca7lxPUfMrowWzWJzum06DVT1b9QPvYwwDdfFkp4LCXMY3ii2A8IKYhq7wUQNMgG
    adHSXPEDQxZX+/LdDOpKFKZSSn8dUiuHjakUfmC3RqEJSpmeDf0Ha2p7GhkafxkUwjwVCC
    VUHeaABX37fkgTU1R3vbtsTOGmeO9TMlbtVT+Y8g9yxSNvQHSejzc2nS0D72zNU76V/qqC
    3inIk8QN3PwD1cfbcWJ6iDIN/TgGSw82NZooYHU96yVMP3sRkwYIaPJVKjEU8t5RRInaxM
    0fPWY1amw6J6UREX46uLNDsX8hksrapcEBfwwFPeK88l2UrJJCjF1t5dnfvHQJPoL7UH6q
    bPzhrrOHIKQKlB1B/Rct5dUZ9yYn5yAULEBEMNrJdbuuS+Vi28B8mZ2eBH9g
X-ME-Proxy: <xmx:EQd8asasBDgSZLtYVI0lHSL8zOMLz78zklWnAPk2CnkKDT-zwsXirA>
    <xmx:EQd8agXyhfGJvzGjs47b4nLOIxivrEiMqOWCLKiOrLotRmEiRRyKEw>
    <xmx:EQd8ao51rD2nyCLRCK4H9VN0D0fDctVl13ru94sf59I-IDXLkUAwcA>
    <xmx:EQd8ajhUiJJfW0D-2tl1gab_XYlpaHv3PECSpFgbVY2TVAie_uuKfg>
    <xmx:EQd8aoREZySd8eVQBwnQSuRPRUBif9JxWF3a9E_26HSFYNGH6PTUj5hG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 01:39:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16b34b17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 05:39:28 +0000 (UTC)
Date: Wed, 12 Aug 2026 07:39:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] odb: drop `alternates_db` field
Message-ID: <anwHDe5PfAaT1k9W@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260810-pks-odb-eagerly-prepare-alternates-v1-4-f0fa4a4004e1@pks.im>
 <anug-cxSSsy45swy@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anug-cxSSsy45swy@denethor>

On Tue, Aug 11, 2026 at 05:31:17PM -0500, Justin Tobler wrote:
> On 26/08/10 03:33PM, Patrick Steinhardt wrote:
> > The `struct object_database::alternates_db` field tracks the value of
> > the "GIT_ALTERNATE_OBJECT_DIRECTORIES" environment variable and is
> > used in `odb_prepare_alternates()`. It's not necessary to store it as a
> > separate field anymore though, as we stopped lazy-loading alternates.
> > Consequently, we can simply pass it to `odb_prepare_alternates()` via
> > `odb_new()` now.
> > 
> > Do so and remove the field.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> [snip]
> > @@ -1126,7 +1126,7 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
> >  	 * the lifetime of the process.
> >  	 */
> >  	if (flags & ODB_PREPARE_FLUSH_CACHES) {
> > -		odb_prepare_alternates(o);
> > +		odb_prepare_alternates(o, NULL);
> >  		o->object_count_valid = 0;
> >  	}
> 
> Naive question: is the reason we don't need to wire the
> `GIT_ALTERNATE_OBJECT_DIRECTORIES` environment variable here because
> they have already been added as sources? IOW, when we invoke
> `odb_prepare_alternates()` after the initial set up, we only really care
> about re-reading the alternates file.

Yes, exactly. We set up alternates exactly once in `odb_new()`, and we
don't expect the environment variable to ever change in a running
process. And as `odb_prepare_alternates()` only adds but never removes
any it's fine to ignore those here.

I'll add a comment.

Patrick
