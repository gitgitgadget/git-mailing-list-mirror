Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664261;
	b=djZWfH7am4nraf8Mq9FUhs1xfkRNSPo1+HIvTjmQagmBGs3QHIqTXcZbgWm+EP/nGge1
	 89H809l5jXZNeoSha3Wp+awLYccGTDkCg4HXp1XNxCpOroV8v8EJ8HAu9B1o7C9vsfQZu
	 QE2B3SEv079tR8ipgAE8MSdlj5FEal1ihTx/zCg7lgvpn6ae60Wg7yn+Mnqve43J20ky8
	 7XuTVzie3pF3ZdugxA8pQuh4viEZqmXqrcCa/CKQKQTRHmA5zP5BA5CB/z+v9SfnA/ogu
	 i1YR5NOMSp4BAYoVN0VqFxuju1NuFx3iOSrD5XZSJcznxBxhC6dEKCyo1Cl6NJg8qLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664261;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=x0jAjT410dV8GCQiCDUiYZrMveqVDBHz+Dur0WOaIYM=;
	b=VJftsQM5V37R0tQ30F7KJil3znMgqb/11Rnjz231AhP9h8T3kY26239/+EsnEbZpGBO1
	 VouIY2MgAYJ3snqJChy945PaUb9/uc7xbH1nU8RrK5nkn09bM3bY3df4xIYfFJnReaZUY
	 PH4zJSRDXZ/HgeEJwVQjwXhOtTfO7T1SPohmtww85e6gfd2PHEv9N6AvSxL0jp3LLccng
	 Eo4DmLYvSrbatODgm4PgfVvgc/kBBRP3h4Lf+XlIUm8FJC/q3jHXj9gKO6r2Bp6YA37PL
	 Ml6v2NrQ0Mo9wTFJb3oo2xRk9TYI8+cFe3YNa8HRZ/FbX0ByikmOKN3lRYad3zCVMwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OoaVDjOP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WUV1yBwW;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC9606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ACC9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OoaVDjOP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WUV1yBwW
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2BEC7A05B3
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:37:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 22:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795664259; x=1795750659; bh=x0jAjT410d
	V8GCQiCDUiYZrMveqVDBHz+Dur0WOaIYM=; b=OoaVDjOP9s4Q5QWQTAV+c/kZ+e
	y5ZSL4NNtux3BT8Yk1RIiOk9VnCcFOvFHDPDsbmZbVndAZwXPquvDBAZJmrcaOsF
	SEXlEcweqd7uUiJ0EKPnRVL+YJk9Rl/1DvB2HKj1li2o+GQVsg8Te36qv3HQ1Ed5
	jiW3h36ihHl0f01JkTQ9eaC4ZK2XcUG/KjEw+hgHie9HjbQ47gYVmSfeAjbHnteL
	l73nJv67jCcCgGkFAgtX6U9RWu7la4QMNODrLySLo+SA+kuoCoBeWVWuT+9K1UUp
	ZEtrdoUs+omTXsOZmVVAx1nR9uiPOF1AMHMFBgF9qL2OaW1nE1TjyBJH+NYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795664259; x=1795750659; bh=x0jAjT410dV8GCQiCDUiYZrMveqVDBHz+Du
	r0WOaIYM=; b=WUV1yBwWXXkUdXGb2LrM8pNKsocO1h10aSJ65O51wHHfkxwx5gz
	oJJtFVcHYOv4wNzh0y4fcLryjqQ/bbKWnYmZvDwbLFT5+M1hMcB04n2j7gE0SGTo
	dEwYiiRPgX+ND7zzhY8HCXzqcxgPnl0T8AMyVfmltsTFoF7uzlrI9SMcJs7JmnUk
	fSAOsTbnIEmNZom/94OemG/QB9KXt3effnbs5aMfavHOMnCynKcFbv+rh7d9vcmi
	YB6lfIU+nY18EnzGYYjLbZ3COiQhjX+JAIGdyQotFZwBM4UVc5paMFTxvvw+yg/9
	srPbWgvTIEZKft3/HwLQdqISPl5RdVg288Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795664259; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fA2L2fH5jyVii8VC3RjeffNRv711CSAZM4g3pUAcmuoGihN
	74SsCS6hZXDr0/kH91SB/rJNEQnzeqBjCk6JzbPoGT+b762VVuKtTGu2uivyazpa
	rndR9HjSqp+ey+7n0XAriDL9sShMDSa8SVqB8xV9AkqybmtwxR9JUtU0mHhISjLr
	Dg9Sts+qsDRL3jVa998U4G6xbDSH6kctnsiSIwm8m1u4RLyIYaA0BVd3AuBcyLEp
	uNyzwVb57tVSuPuOKOgccw+WTWWUY5ENxxXXj/qKORWcTcn/CJ0Ik2HrYT7B3Goj
	UDP7lOT42QVW99n2H5CeH5TTusbgEVxgQMtxTfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nMMuff45vzsv4sxWt2Y7FkWr8bOp/uk9FFBqzpY2CDQ=:IPhV8VbWl0d2uEBX9PWJ7DE9P2XfSSnKU3oG2tkfeT8=;
X-ME-Sender: <xms:g6kHa8iQipnVKh8ssizazOOBecJPe-xISbxu-KJlNV0pvecIyvdf0A>
    <xme:g6kHa0FQ3FRvn6o_OiPIyqYGRwcRgxnq9ZFWlJBjJpVezPG9F5gkkAM4GQGGNKluW
    HMYKKBE7I-Gf6dOtldBpWejRch6A7w-U2bvfSciLELx-fsBId4l1TU>
X-ME-Received: <xmr:g6kHa6RPYf-SrdzIIBjRY8nGSh8NwLhpd0odF5LNXQzHT9SCIFEBWOmA2Y-uspgEwp-rLKORsryvYXwayVIoW3_-likKJxM7IGVqvrA>
X-ME-Proxy-Cause: dmFkZTGkmWRn/D4at7fEoiALks2NKTVbuyc9aIspb+v9Wy7iKTiumHGtI5b8WxHc7BLd8E
    +13fS3XeTBil1PZvI6keqsKv4hnL5QL0hMkJh69aU6Vwd6VdtyYDBuFc9FcucB6NZSr+pM
    +Gmn7snwLJdoy+qiAn4qDlVxLANnYrqxrG9WOh494bcnJ53yll7ddU5MSYk3szfnVNHIpm
    yzGQyn7jT7ngEL6fGZaVPc/f10/wOx8n6I62YbOGDytI1EGRy76vWeGES47u4xxK6nu3VX
    DBgS0ZHJsO2CCc1JyLcGvqOanNciSkDqsaW2OyMdTSvka5a/fXGevm+fyzV4ub//04STfj
    dEl/POdJdgKJIyhNmvOQlh0v50GsghekMOyYocpLRk2SPOHjaby7Vl/NkuasbZWsWHTXeG
    K1d0AgbN4GhMz/BBW+d16AlBVNlW+z3BO3RFNnVeVyUsM1BW+A82c19JkEocLJ3p3lF2RX
    T6orQbbMObuPT20XElYB+U9dDWMfa7poLEoEeIWdmKgzPKIK8QUvJzhDKiCS6Sr76oQUe0
    U81ejjVa/FY1/Gw1adyN/iu3erfp79dnjQRupFIls2z4bZDnsqjuoTfzpcKl8LJPJfRaBx
    f2eT1lo/deG3zSeF+w81NHWJ/xuodtWeVU+Mbo6Fjk3LsjwKQ1jLqo0qif5Q
X-ME-Proxy: <xmx:g6kHa5xeFULgcMsDERwIQ98K0AhgvUTD_ZFpcz4ffrE8JXwXeyyT0Q>
    <xmx:g6kHa-f-J_6c-g6n1Np_CxBer54Kc3x1OYr6qehtkpk3vgc-HxeHqg>
    <xmx:g6kHa0MQt1WvirPA916Y7tCuOI1WYjOxWrbkMtjVNflLB6Z6-Y0stA>
    <xmx:g6kHaxtvFZLFBQD-Ryyrp58I6w9lhgsQ7rbt5yvmIJVuWE_TIhpeQg>
    <xmx:g6kHa1glSmHyP1wa8Ym7hy2ikHAAOlG5yWRlHpTHW51TbQxUO3K7yDPq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 22:37:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v5 3/6] notes: use the tree's repository when reading notes
In-Reply-To: <20261125220214.35881-4-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Wed, 25 Nov 2026 23:02:11 +0100")
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261125220214.35881-1-okhuomonajayi54@gmail.com>
	<20261125220214.35881-4-okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 19:37:38 -0800
Message-ID: <xmqq4id4s1od.fsf@gitster.g>
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

> note_tree_find(), add_non_note(), load_subtree(), remove_note()
> and format_note() already have the notes tree, but still read
> objects and hash algorithms from the_repository.
>
> Read them from t->repo, the repository stored on the tree.
>
> note_tree_find(), add_non_note() and load_subtree() do not check
> for a NULL tree themselves. add_note(), remove_note() and
> get_note() replace a NULL tree with the default notes tree and
> assert that it is initialized before those helpers run.
> format_note() does the same NULL swap, and initializes the tree
> if it is not already. load_subtree() is also reached when a
> lookup unpacks a subtree, which is still after that check.
> copy_note() is the one public function that does not do this;
> the next patch adds the guard.

"A, B, and C do not check for NULL, and D, E, and F do." may not be
stating any lies, but such a description gives a very disorganized
feeling, as readers are not directly told where you are going with
it.  Make it clear where the entry points are, who calls leaf
helpers that do not use notes_tree_or_default(), and state that
these callers themselves use notes_tree_or_default() to cope with a
NULL tree.  Before going there, step back a bit and give a wider
picture, i.e., have you done enough to make sure readers understand
why notes_tree_or_default() matters in the first place?

    In the previous step, we added a '.repo' member to a notes tree
    object so that you can tell which repository object you are
    working with.  The notes tree objects are passed around in
    various call chains, but many functions like note_tree_find() do
    not pay attention to '.repo' and instead use hardcoded
    the_repository.

    There is a catch in the existing API contract around notes tree
    objects.  Passing NULL in place of a notes tree object is
    allowed, and tells the API to "use the default notes tree
    object".  Which means a few things.

    - An existing call chain may pass notes tree 't' around, but it
      may be NULL.  You cannot blindly dereference 't->repo'.

    - High-level API entry points like add_note() may receive NULL
      in their 't' parameter, but they replace NULL with a pointer
      to the default notes tree object by calling
      notes_tree_or_default() upon entry, so after that, the use of
      't->repo' is (almost) always safe.

    - Helper functions that are only called from these API entry
      point functions may not check the NULL-ness of 't', but rely
      entirely on their callers to have turned NULL into the default
      notes tree object.

    Now, X, Y, and Z, as we saw in patch [1/6], are the high-level
    entry points that guarantee their notes tree pointer always
    points at a valid notes tree.  A, B, and C are helper functions
    that can be reached only from X, Y, and Z.  We can replace all
    uses of the_repository in these functions with '.repo' safely.

    There are some cases where such a replacement is not sufficient.
    For example, copy_note(), even though it takes a notes tree
    object, does not use 't' itself, so it does not bother calling
    notes_tree_or_default() to ensure that 't' is a valid notes tree
    object.  In order to replace its reference to the_repository
    with '.repo', we would need to do such and such things, which
    will be done in later steps.

or something like that, perhaps.
