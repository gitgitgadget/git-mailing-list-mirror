Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663061;
	b=zgAQOdQrf9mWHI3vj6KwglAQdkJz/l8XdGv1MY6pY4IEWJXlMsCmRrZwZ/TdopflYBJQ
	 Sw1LYGnezqeK07452ff9VrMKBWKlCPPlzoiYYHFUjODrLINucsx3McbNKTUlp9Ge1cCwb
	 /SvUKLYQBY+8gryhvheyEU7k1+JwSq3L7uq14R1YNvtofBrw3FSZfLMfsod0y7gyL+w67
	 V8hsejaRcIAE6HifN6hOlTvirjra7qbs82T32wPszENIPEJE6bRvNkDpRN6mLIAYG0Ulu
	 zY1XrZbnQ9PqNzsNIKfxzqoR/NPM3ireiwLb5ius182YX6N3JGk6jWOFrnGVQz7CylQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=h9vViEIh/qRWpkCicV0zihRCFN1GrrKMgXVW6/4cW+c=;
	b=O7t6wrayHHuyJkiWsCwcXHDdTavEMVoHwOLn6sVfr1XWd+5PYNm3iJhkPcg2guIm8Ruk
	 MTwBvsxzQyUE0acAZbyWQmcT+iIkJbx9DHTalmNRBHxReWr3iI94lYau2DNnL2OLNMeSM
	 gCvyQXGOKVceBG1BzlWG6CKMulNfdkqurhgvzymXTnbBam9Kk5kVnANCyMV4U9RLFVfme
	 geWQ0igrIRRXMAj0PgLALNW6UXqlDUBMtJ55tuymXMx+nqQteJlc4OXgSQq7f8kI//CT1
	 IddmxeeXnK1p5Fq5AV6/mMIpA8Ui1e4k+6apR+aDxC3RkvAY2XuSN8W+Fk0eqVPy41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QiVkqHEw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ei0fqSG1;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE42606A321
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE42606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QiVkqHEw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ei0fqSG1
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BF457A0562
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:17:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 22:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795663060; x=1795749460; bh=h9vViEIh/q
	RWpkCicV0zihRCFN1GrrKMgXVW6/4cW+c=; b=QiVkqHEwmEA+wzvHm9QbF7bW+D
	Ng5HHg0/x0DZ+JxHGFYXbMluFPLkVvmEbrq8dMIwr06vS4DdWYy2lWzcI3H26weE
	AKMjGREmPltgGAzdbMMTbdBxXcr2f6ENRLSuCPbxg3q1QxGN35v2/SmbPc5novp2
	SDWV0ZNcQq1YM43AOwFT3dJT3masfCyKG4Zfm1CloowMkIHfHFWuLfnbNZ0Lhmmw
	wT4W2bJN2C5kdKCSiP32WsysPyzteUTwVGuf3bdMVADlT3JsobPKXtFedutxTXs2
	lUfA76bjfCrGNxjS7HX0SJBNThAxIMLqlzVqwmbfm5qQtLXdNXlxfmWcky5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795663060; x=1795749460; bh=h9vViEIh/qRWpkCicV0zihRCFN1GrrKMgXV
	W6/4cW+c=; b=Ei0fqSG1/dpyrgiH55925ApIchA2zutoZpy5W2wd8l5rfWo6itP
	eEvIG42F8VFAVWi0EnSYh61w1+tYrWmvW/MULtsphIHBdg/QpF8sdG/YukkBfqK/
	BN3cinz6Cz/4mASHUy2zF36zSbaXmK12ELU0rQaeOeJVb3ZHcd3R+CrY/MHCpx5q
	/3bLSzEEM/FbpBnFVvFG8hSRxrNQzDtxiWlTQ14H+/bmFMV01BsmUIviEuq+pQZg
	AMMEYGAbZsH43axCxVR6aVgI1bSTbLbZVJ3MrhD6OOyA9uH3R1sOlQw2jOSaPyNG
	oh9DvoQpHinL21SRETLw52O2S73ShCaRnKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795663060; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DlHC3lftxgO7nQcYUWcWWUmqLDaTRK83ngE6kxMw0ppNkMU
	cKihS7CdsiFgQErOrX1QKHqE6jpRCbTsTNXHO3/U231in0F2BuHBPrDmKOdFK5bE
	5k7Og40dkpZ6K/mYiTd/0pStVTXmFJ8au6B3Cc7rOFOv/WaqObjEwlYqLyWVSmmi
	Nm3RIp3zu1fU1ddYRMbJ00/miIYqkQBQII6SaQ+/AZRfFtXCFdtNovVjaWkfL7tX
	p/Q7AP+1IxrRBO9aYjRLhCHNQ2VgjUQ7qcV95t+CRKqOeYkA3b8Z7o2Ou89qMsml
	959C/p11T8yocJeOojcKuJYVY0llcmdtamD2tbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Fc4nhvEN04BscGroSMupCEhldl8ThT8XeZw8SsGxbBk=:AhgFR1qBFCSEjs4IpW2ySQL+9I/l89bTccm/xR3ME9o=;
X-ME-Sender: <xms:06QHa-xyRI6JrqbOJ-NTystgjfnn70wIkMu6OWWAUiYEnq4y9K_6lg>
    <xme:06QHa3O0gT--iRyWPhN6YjzjwmIDVz9nq_7_vhkMalrMBp5_dgBGBtPmqPDHscG4b
    Aiuh5PQAnP6VyYb9loJ0aecT2I8MeEYglmwTL3PTQUZVX6XCH7S9CA>
X-ME-Received: <xmr:06QHa79ERhuttYP4MrnSgpB1a1IgAAeWeuJYNBqPkAd1ZJzZ2lvMvo7ur5GmpeSktq-dUwzdkrVUm80m77oaKwOy9WXpiixlGh3XjKg>
X-ME-Proxy-Cause: dmFkZTFl6WZDzrBSzbWZPSSmvVCLdgTlKww6HDetd3vWcJIlrwrZqOE593Y6+ARITIotRF
    oGmtxuxdjYisT8sBgLPyAZsX4Yiw+KQugN+V9ajAnYicQEHr5VdFh8Ggc39U0vBCQdid9X
    KCvjnZsXKMwGU+GvUA5v7fcrpPpPOcZEv3UAsdrSv58NxWs6TXDY1W2ZjBx1REcAwtfw8T
    MfjIqnUY1d+aIWZLQG6ilGMsc1WPRaRBMI2/+qB1Bj3j2j+hP7X0D86BktE0tVEFF2KzPB
    lZSKgrn0didiif7Zob3enoeo5RMSTHWoN3LNwKWa826kh7akVGx2e5iKp3AG70EnNs0kSY
    lltk10FUxZ2JAKGN7xNqk4K5hX7F5CDtYbMVeVsjLd9NHQky9d+zHgYbmGSEQJodihoKDi
    ZuFO56bmLMYwF17WViJj14uTTZLw2twaPGvcAnLF2DEeuYZrA+DdPY8o1mjUmhHhd+cAC1
    q956u4/XraMfj3WtTmp6F0R7zIQz/vs04Xf0DOt2LHu7wmhmTzlwoUlFtWK0Fkg5ZahNpt
    9zxlwumFuPZUh4RN76d2i/Mg4k4j9whdp+dkg1wdFthZEvYYruOBK7BemjtPKZwAqXS7LO
    lhnkwOhCa3/8ZIH7mcHFOKXLf4EifszLD62iBp3kBO+VfTDdZZ7BmZB+jV/Q
X-ME-Proxy: <xmx:06QHa85tAekOIQ7Mcxf4T9gKsrUmkI5EZeSzE04121uaVBFxxvobhw>
    <xmx:06QHa57S4jy7J3Hnt5MGZJ2HF8b_sxKJr99ZXXzEoK8DcZoDtAQ-lA>
    <xmx:06QHa9rxOGaMHi64uw3XipFOafKv3QWPjZ1-VPICzYfnOQRpgC143w>
    <xmx:06QHayO2NOMPp0Rdh21IdH8NZLEi1kgVWMyaDoWSAp3h_HDo52KuKw>
    <xmx:1KQHa8iyFAxHukNUXgSomFn6ePUFnnazZbtCwfEmttrYYQywOjE3uQg6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 22:17:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v5 2/6] notes: store the repository in struct notes_tree
In-Reply-To: <20261125220214.35881-3-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Wed, 25 Nov 2026 23:02:10 +0100")
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261125220214.35881-1-okhuomonajayi54@gmail.com>
	<20261125220214.35881-3-okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 19:17:38 -0800
Message-ID: <xmqq8q2gs2lp.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> A notes tree is always read from one repository, but the tree
> does not record which one. Later code has to fall back to
> the_repository.
>
> Store the repository on the tree. Rename init_notes() to
> notes_tree_init() and load_notes_trees() to notes_tree_load(),
> since every caller changes anyway. notes_tree_init() takes the
> tree first and the repository second, and saves the repository
> in t->repo. notes_tree_load() takes the repository first.
> notes_cache_init() passes the repository it was given. Other
> callers pass the_repository for now.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  builtin/notes.c |  8 +++++---
>  notes-cache.c   |  3 ++-
>  notes-utils.c   |  3 ++-
>  notes.c         | 30 ++++++++++++++++++------------
>  notes.h         | 15 +++++++++++----
>  5 files changed, 38 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 9f1f0ec840..725280c785 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -370,7 +370,8 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>  		if (!c)
>  			return 0;
>  	} else {
> -		init_notes(NULL, NULL, NULL, NOTES_INIT_WRITABLE);
> +		notes_tree_init(NULL, the_repository, NULL, NULL,
> +				NOTES_INIT_WRITABLE);

We are doing two things (renaming the API function and passing a
repository instance down) in this same patch.  Which is not too bad, as
most of the hunks look like the above, passing the_repository to the
renamed function.

> @@ -1025,7 +1026,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
>  	assert(!t->initialized);
>  
>  	if (!notes_ref)
> -		notes_ref = to_free = default_notes_ref(the_repository);
> +		notes_ref = to_free = default_notes_ref(r);
>  	update_ref_namespace(NAMESPACE_NOTES, xstrdup(notes_ref));
>  
>  	if (!combine_notes)
> @@ -1034,6 +1035,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
>  	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
>  	t->first_non_note = NULL;
>  	t->prev_non_note = NULL;
> +	t->repo = r;

Assigning '.repo' before checking NOTES_INIT_EMPTY or calling
load_subtree() makes sure both empty trees and trees loaded at init time
record their repository, and free_notes() already zeroes the entire
struct without owning the repository pointer.  All callers of the
renamed notes_tree_init() and notes_tree_load() across builtin/notes.c,
notes-cache.c, notes-utils.c, and notes.c are updated, and the header
comment above notes_tree_init() now documents both 'r' and 'flags'.
