Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90164330650
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749948; cv=none; b=K26pU1FKhHUZVapA3By4YVvcvzeR6W1JocI1ugAcHHRFkoAPyBqPmx8lHSxbDmKfmeNqY/BUr5JDD81Z3x1NI9Mjlav/KaEXN2S3ezZjK4w+6EC6zW6jPt9g8Jd9M81yVuB99Ami+lgxIN/Dy8LLAvigIygF9ygvzGfJqLWeZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749948; c=relaxed/simple;
	bh=ipx8QFynWsd85cAFMVizSAhiCvSDQ1W7Mlr3ZKwA+tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozACfNcKPcBJi3ADxxo4KxjLML2MOFja3GWIDbGvNhubZMg9Opj5rSrIoYjxuVjrBVfq8OVS4532rrsuRNjXb3xgjZE2XpHSmQGEt0Kqyao5/FVWxjDamoX2fZEIg0VIG2+y2dxIhkliTWi4oLxSqJgTGPuvM2CJtoavbZBSS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sZChfUq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDZ+4/VV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sZChfUq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDZ+4/VV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A2CE4EC0227;
	Tue, 21 Apr 2026 01:39:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 01:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776749945; x=1776836345; bh=ktmzH3I3kl
	evUHwyQFe56IXJyV0ORUHL/rhopaboRb8=; b=sZChfUq2nQXoBB4tU81qCSh6Iy
	amzGcLxUtzfsUPtP/ET+fnIlmljjniT+5qHGkXJHPT+6cWb2ldh/+MHv1sk66Gmt
	ddbuvzWPk4SwaGOQml0Z1ruhX08/7w2nI8ImLp//Ei3Cz6gAcn6EIx9zMlh3AEBW
	d6v2FdSfNJhF4/NaXZqN9HQgVlwyU9e824ISCvR7ISpZ8irJkNT9yyMZiqGV1WLu
	uYD1z7wxcvpDz/7tqM3UwV1gIAjA3Tp5nQrz9uQLHey05IzaRqK0ENrxHjuGQyEt
	C3zIuN9FoSHvxLb3GpYMFc7/h+TQ7cyvMsy/VguNKF7KwRALfpB04dJR52gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776749945; x=1776836345; bh=ktmzH3I3klevUHwyQFe56IXJyV0ORUHL/rh
	opaboRb8=; b=HDZ+4/VVRTWYslHn3pe4Ob9ZDI8/rikG9OGlXRt2IRGYR7qyY0H
	zadE/3WRzCfIX1weauuFtAU2rRJJCaNlePqWxFd65OuybQ1yVkOG9e/63kZhvTdy
	cx1tZg1hQR70NEZPVvmo39YSH4mB8BAmJM7wohHy2jRlm2YuY7jKk3T2232FDdeu
	qAA/gMQ5BVPzlDqBxhVTaOYD5QcSNONxy0u3UIx0LN4dRDFtHdVpBJ5GeV73F/RX
	ctfatNTdaCXTGymYX2xq3rTxOlWtrURY+4uGCkg7NWHC3+EWr+PTx/expT6r0ez/
	RyiQxzpnH+Ks5rMei9Q6WQwsO/k/530RMKQ==
X-ME-Sender: <xms:eQ3nadhUugDpzvnBcyJWFWuAqWBrNysLL4yLfmyB7gaVF_kB_re8jA>
    <xme:eQ3naVtxITZF4nzVwGCAFxdUN3HStQUwz_ESHfVnQAmFdC0TNVkXFfpps1c3MA8qY
    DXKsaM6HUWugzB18N6qIWbQa9sO0wuu5Yzzc7gimcgaVtF9ZWLBbA>
X-ME-Received: <xmr:eQ3naW5gvMoT25PDpf8VWqEa5C8UJwH0XuDcaK6tDjHgCuOtQWhiB2f8h_fM2qgq18dl2B8UEZX769m9F-TNKbjZACHFlnNSaBTRqVok-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehrrdhsihguughhrghrthhhrdhshhhrihhmrghlihesghhmrghilhdrtghomhdprhgtph
    htthhopehjohhhnhdrrgdrphgrshhsrghrohesghhmrghilhdrtghomhdprhgtphhtthho
    pegrsgguohgsnhhgrggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfh
    gvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eQ3naZNSLb47cnAPjd380xKCxUFLhkHGsi-eT74O1JwS2mC0fD6ZUA>
    <xmx:eQ3nacsJdrH1_SSFBAMuczsJgnqxsRPmKUNFI2qmeFBCtcQW0vKQpg>
    <xmx:eQ3naUasYjw5A8GogWQDxjLp0o3KnMiTANMLEtDLe0S5rGHK70XEUg>
    <xmx:eQ3naWy0Wu8u2vqg9KGGFZztsBra9a_0z9-ct89WG994t2EsBNGkMQ>
    <xmx:eQ3naeunFFgNjH-7AfKPTpkrwqOcLuDSGsZMWD-U7LB_nC2f3B-mKbxz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 01:39:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d86b98c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 05:39:02 +0000 (UTC)
Date: Tue, 21 Apr 2026 07:38:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, abdobngad@gmail.com,
	bence@ferdinandy.com, john.a.passaro@gmail.com
Subject: Re: [PATCH v2 0/3] t7004: cleanup and modernize brittle tests
Message-ID: <aecNc-BNwaqFlg5c@pks.im>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
 <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>

On Tue, Apr 21, 2026 at 11:03:31AM +0530, Siddharth Shrimali wrote:
> This patch series addresses brittle testing patterns in t7004-tag.sh. 
> 
> In this second version, the first patch has been updated to follow 
> Junio's "belt-and-suspenders" suggestion. Instead of simply removing
> the tag count check, it now uses 'test_cmp' to verify that the repository
> state remains unchanged after failed tag creation attempts. This
> maintains verification while removing the reliance on a hardcoded
> global tag count.
> 
> Subsequent patches continue to modernize the script by removing 
> hardcoded global state and replacing subshell patterns that could 
> otherwise suppress Git exit codes, ensuring that crashes (like 
> segmentation faults) are properly detected.
> 
> Thanks to Patrick and Junio for the feedback on v1 regarding
> state verification.

Thanks, this version looks good to me!

Patrick
