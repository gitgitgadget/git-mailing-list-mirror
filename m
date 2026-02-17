Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92331E1C11
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363855; cv=none; b=LAj67eBulBiogCiq8441MagPFGZ24S2YzxBv5bMhS8GOCNqubipdiMz/n+l5PoiOqRHL9yFUK/dYY26FUZURZR17zWFVEmZDIvtCJadZxvINKNztsLK+vOecC4rzIACLGRE8VSDpaSr2o3JQjRs/RAlanbANUo3iW8vxq0rs4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363855; c=relaxed/simple;
	bh=jKqU6s85uZftnRowsQ63H1Y656X64yXmWMTI4KMRcXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qHV1jnOkonOJoPMMStIk12by9l2BmSif5eeAy6XQkffMsG9mStxnpzDWwrul4LLeSwyxzHC2448EdKFSK492IkGIFMmFQm2UufROGaVg3gxMdJK8erSJecrlyOhha8jyIO54irmVosLhGlTKgeWL1/WLVbpVPAMzSr4q0fhNkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Y88HfhQG; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Y88HfhQG"
Date: Tue, 17 Feb 2026 22:30:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771363845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UIk+2KTremvmjF733c0VvCIHzcUqMyv0gCwKaYxF1MI=;
	b=Y88HfhQGMuodP03kAJR7IE75kuj5Q7uTJ414hWPLTESvKwiUOIgFadRcvCtXKDr0GPsBFh
	gXoyB6Y0NBsibMwXOxrr9kftPKgzsks5QF7tVOjHNtw1Qg29NhTL1dtEa6QmsvBPmmYzoR
	MhIZ8+8t8ogEui/M8o/DBO3BwNa6GlTe65E5kmyvBzoPNkJIYP9Cf7DMa3rZo+jyGL5niJ
	cC6HGIEM9ZxFnVkmC3MIeSqcbEyRGQnUQg/KuaLFM1KQefOyHhSyHx6//1CQXpzvya7MNq
	+fHdAa5rhdrsscWmMN3nnf4Ev4JapTNzgdwkBdx39s5B4rAgBRMTHacsaSQ1FQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
Message-ID: <aZTcsow2QtBpRiJd@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=mroik@delayed.space;
 h=from:subject:message-id; bh=jKqU6s85uZftnRowsQ63H1Y656X64yXmWMTI4KMRcXM=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBplN3TlL3a735PUCgP8FoFewMr1/QshgbPYbGWF
 ytQZrxZeDqJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZTd0wAKCRBIeX6hnBm+
 0eR3D/4oKhgwhpI33Anh2jFPxKL11OMwCMhv6NilnhSmB1EJeZ4warMb2DOyHZ+gq6MzZCwTbeM
 Wj/rnnOtf7ut5LKM/BlWGbusSh5H5hwdY68BMHo1Xw2vbLY4AN5WqfPgnj76HddVNBIFnA+OUbY
 rIE4apfUWcTBl/m/Btzb9oAfpADqnK1Rmt9hvbpKyK+6GWX/rfgaGlUDDdBTvNS5k3mYgYpAoJz
 Pvxiexa1YozEXhVtOJsKq3oXYHR95A0YD0ezKupD7qdnbbzZ3K6ibPHI57/uvWUbWA2f1XtWEiK
 0UiA7YikKwygl9cRT9JBAxi/jT8ldSCQIb+sPwpQNO0HW7sL/cgBA7Z0U2ydll/fuHtK03DQQd5
 UC0+WBsv/YhXVw/n2g+mumrC/7zt7cgZyFxY2HiengjVZ2yyqE1bcGod/0it1prbJhaNOp8lC0e
 wV2OuBN7DKP7VxgoWdEujp9tnFiBOm+At7uVgP99uFEpUNTcKynZ+mrDnW5iiBj1PatZbijwVU7
 C10Qc7YYRKPrB4GNYDrD2+UUtTT8J0kTglORXTw4aBNYET+mFWiFjd6OMCkItEqljwHZPlelDOX
 MCUK06FpBsx+FGyRZzXiq8l4R9pY7Jh3c+/yrcTEfKu9gjSF+LRdGLaUZ2kQew+kedB+E7optWD
 xX9oHuK2QXePFwQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Bar: -

On Tue, Feb 17, 2026 at 07:22:08AM +0100, Patrick Steinhardt wrote:
> One thing that made me stop though is the folowing sentence in
> git-format-patch(1):
> 
>   Use ident in the From: header of each commit email.
> 
> The option explicitly mentions that we use "--from" for the commit
> emails, only, and that may be read as implying that it's not used for
> the cover letter.
> 
> I don't really know whether that wording is intentional, and I cannot
> come up with a good reason why it should be. But I'd say that the
> wording is something we should adjust.

I don't think any user would reasonably think that it wouldn't apply to
the cover letter as you're sending the whole patch series in bulk, as the
same person.

I will change the documentation to remove any ambiguity.

> We're not only testing the cover letter here though, but also the other
> generated patch. This makes it somewhat hard to verify that the test
> actually works as expected. Would it make sense to maybe use something
> like the following instead?
> 
>   test_expect_success '--from applies to cover letter' '
>   	test_when_finished "rm -rf patches" &&
>   	git format-patch -1 --cover-letter --from="Foo Bar <author@example.com>" -o patches &&
>   	echo "From: Foo Bar <author@example.com>" >expect &&
>   	grep "^From:" patches/0000-cover-letter.patch >patch.head &&
>   	test_cmp expect patch.head
>   '

Yes, makes sense, wouldn't want to generate a false negative on the
compliance of the "--from" option.
I will apply the suggested change.

Thank you
