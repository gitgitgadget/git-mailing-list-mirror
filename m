Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353091;
	b=mtn2ic8hVqdeYnUfypvl9yFTXKoPQaZNPu4ife6p5lqBeJLsTiK7mOsNi9cEW2vhyhW7
	 YV8d8LkK2p7b4qsx0JkrE1Jl2a6tAfhaApt2lAZ9SIckHBt76vBEk7Vmq4LAgt1X0IUic
	 ruo36kGe1zIVEbZ+kTeuCYfLjemAL053rkDdGaXoq8/tIbzZyL9xgTuep2WiKV2Da0G9A
	 EElKqm/YJ5ccaLXo4tu+IiPC8ZdD/NLpxdRPgNEIWn3xj0tM/iGs528fifkKSoiIA5GDp
	 IT3gnwcmJxw735YHtEvShFoCTHcrCo0n+P77+Qe+YviPG8P/aaS+8/5X4AX4ALhfQqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353091;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JCK686AU5oVZg3/EdVls/axmeYq5ljmUGZS7BvZDMQY=;
	b=MflrDpJ7zwPAB7ZtL6XJp0OUkT3rTTZhsnjcoQao6Ati2X5scEkvXivzcEFSaNc3cWS0
	 aBZYrKUT82ljcP2NqoiNYe1NbXuiFwNDs2p9eNY2ecKeUNZMkuasAg6XtpGz9Wqg/7l4c
	 YXHXLIhWDGA6TaG0wf48hDep8y4i7ARPm+yppcOV4bHn2YuOap8VkvsfdD9mQz+X1YRcc
	 8BBsE2N2jsszh/kBpB7HtQQNv0KAVbgZD6uqkHCK+XQqWn3c33xH9WJqt3nkCd5+ryD/K
	 vPZ9W3AiplQuLN99qNMNbRmzI3LoGksx3ywMLXd/9IPbXzTsmRentg7QHdKXOaejI3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OpKJ0VWm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=arbcCZif;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD7606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBD7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OpKJ0VWm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=arbcCZif
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDEB77A01A7
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:38:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 30 Oct 2026 05:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793353089; x=1793439489; bh=JCK686AU5o
	VZg3/EdVls/axmeYq5ljmUGZS7BvZDMQY=; b=OpKJ0VWma0GhtDbDej5j2kc4yC
	1MgwMbW+kEOcG6aAUuK5MusITr7dATraMGUsNU4TPwITSRfR9UuZBPxMyC4JsWan
	IQ74dBdxcXnOzqh5mjfccvdgBb6cTVINuz6Ow9oXM+ZGwWb0rjsGv6K0OBEhogrx
	oVPQA2b6lG8d9emdWVbsXu7uafqwSUgWOH5kX4ElFhLpyEo3Pc6oSjvjPY40ot9I
	X/O8GX98RAMqO/wuudvvpNii+9NoH+9Sew/M7I+P7UVhvIO7AD/l00OVK1yj5ylC
	qDyi/77pjt3BCg/mnDtL0rn4ex6I5et/CAEOZSupxXb8EjXr49/QawVQi5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793353089; x=1793439489; bh=JCK686AU5oVZg3/EdVls/axmeYq5ljmUGZS
	7BvZDMQY=; b=arbcCZifvf+X/p2aQp6ODbMB+9Ow+gVriBcE/dsG9cMfCEFhHlB
	wyI+NI1GnJGjgs17ntmHK0xt/ISXhMlr3+5uWt3sthIVlJekzDpXv++ZuFZe2Ra6
	StfcBKPhn+5LA1iZrfdh5KTHv8eXmyZ9xHUAL088OhjLvw+ezt/J6YiFXXUQc8zI
	r6zos1p4uvFl5hdrjoKWl8Alu+wJM7Z/bwiHlSZsel0HSJkwFSXa+LZZBxgcVP5N
	ek55LlXJz8QT10uS0b3x4MkzyRGj791XihZnPrdcroIINUQSCwkZCnK0lKuGIG6u
	RKMvLGVob9FfD0DP/0wTG/YrePTOX1YfhEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793353089; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UvPiUj9jlcrW66iPWh0raDP+4wolqU44EmVSEh9dukJZf2F
	b1Ktwwe+tZk+6lqQRjYyQFb4yHhsmb1bnzsv1GqXnQ4UCPM9L6x7xQFWPZKoQTx0
	1gNQVaVmFkWLQYuP1hJrHi+yCF9XooP4WJiGjdGSRdzZToWU9d7kRQkcAJTHEXDg
	NvOu8YmZ05MiMukEJpDhszE8AvFPitbTGGvI6TP04XqPqcCobjZJxLpef4dx4Rwu
	LM3CgiQNz7Gu/LG06wLSluCvJzEOl4kFkvHTpHGUJfgcKrVckyKItrT9sBnHHcZ3
	7yoLcNAihYGUirJeyABq6/opIS5has5VzFyscNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Bu+SFaHO0FIkVjY8XEXi0WnKorqjfg5IBtxupUiIbMg=:nSPfE2CUNnVGCdWul1gIV0dS5W/NWhxifAOH1m3a9Rs=;
X-ME-Sender: <xms:gWXkapuAMhScRLA245AfqGzn6khs4nM67WI0z5441SPyRwVNQQPvfg>
    <xme:gWXkaoejg8plvgS6Cc8XYXudtviOOA2RqE1-qVy-1FOSqwpsUWgGYW_JwkVLqL2J1
    YShENEInEjurAH7nw-FOt_FaVQopAMqEyxaF7XrZKMedxlHmuYHfx8>
X-ME-Received: <xmr:gWXkaqbgtIUZgXySAujinRB5EWqpE9DTBpMI0n5Bd4Y2dCaKzJw8j_ZmqWP0asoarlcG0A>
X-ME-Proxy-Cause: dmFkZTFjt4EOH/P4uKB4dE3XsQH60Skwgwsl03cA+ntxyX2PlBC0+8RvcdHnpzPB3jkezd
    5sRveOvriNl5U5zgq6VlPUUt6UhNTmT7/ql052j5f8KzTZDUZ0YU0eQu2bclhPml2EbT/x
    cddS+BIvcHWSs2i6SFOlAEzRzXPKYOVYCBKOTXiS52D6Xnsyz1AT9ovz4RhAUXKZW0AXu1
    WFtPtMeH96Ks1vNs1HgfNwXoHBrEuNvA1Ne6zcCdnwH/+swcOKzvQNqbkeCd9XoaWjPtci
    bD+a4ZYxrYyLoxocSuR5Fdvlr0M68BKsj/Ox5K1dkRStgWAf5j/XnQIe3IHUCyP+/SbUPu
    X2AXN4JV7QA/RNvknomsDF+oz1UhGzlAY1KAYbdUd9ykKa26IAV9rUBB5scQP4iwzf5wpt
    V56gmvnJHdw+cqFguQ6wEQhNB2kSD7iBSqACd5BPszidsY0DzvPvBzP7+4XvbAyErC7Ysu
    MzRV7c2xpBQznTjRsrZ8eJaldP5u6Gcx2MZ/PbTziOo2nyKmdF/Zi2FtcrGg10XdBW1CVW
    itAi5EdcM2NcIj6g/1fn0Eom5l8j3ZMy3LJimau6++AgojV6jm1gr5zqq8hGQiU/JpD7lJ
    hvy8JH52J9j3crDWT6kX/vPkofAEfd7qCVBIeAmefNb4hYrEgjqWOXxRzb9w
X-ME-Proxy: <xmx:gWXkarUTu6RpnnPlWBhGadh9mus-hiE_bYyCcHE7mzWHtCG8W4NbGA>
    <xmx:gWXkash__kEaUthCpyAj8Stde0beK5m0nTHpQAIt6HNuprtR5uPH5w>
    <xmx:gWXkapUDIpoATGx3K5oFV3X24eGs0RUd8yy7Eg0IxFzDUUMjDReUDA>
    <xmx:gWXkajMXpI5HfIrmkwREpcmbQUCq5a4vHZi8OCSx9TmKf-7vAY7kvg>
    <xmx:gWXkalH4UiOA0l-9LJhVd5QRRyY-h_5I0CI2YXAOFVnQah49czblYEd->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 05:38:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 106b0779 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 09:38:07 +0000 (UTC)
Date: Fri, 30 Oct 2026 10:38:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add -i: hide init/clear_add_i_state() functions
Message-ID: <auRlfDXPhp3RjNyk@pks.im>
References: <xmqqh5i58uo0.fsf@gitster.g>
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
In-Reply-To: <xmqqh5i58uo0.fsf@gitster.g>

On Wed, Oct 28, 2026 at 12:57:51PM -0700, Junio C Hamano wrote:
> The "add -i" machinery is encapsulated in run_add_i() function,
> which uses init_add_i_state() to initialize the machinery, does its
> thing, and clear_add_i_state() to tear it down.  External callers
> have no need to call anything other than run_add_i().
> 
> Make init/clear_add_i_state() file-scope static functions, and
> "struct add_i_state" type as well.

Nice cleanup. For historical context, these declarations are not needed
anymore starting with d51b61f5dab (add-patch: remove dependency on
"add-interactive" subsystem, 2026-03-02).

Thanks!

Patrick
