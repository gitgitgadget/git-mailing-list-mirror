Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97191DFDE
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711499239; cv=none; b=NGgtB5gf5+EwTtl+mbhe9XSZA+fkhVmfkdcL4Oz5Q0inz+1ENBIG27B95dNDd3WpGXCMikS4DB7Qv9ogo1SpdrywDs++3hPDCovxkL+ZNzrEjauZZuQfeKZczGYER/KBlzcX2IjC4eRfKOJeduUskk2CyTZOzzlWLmHmqiS4SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711499239; c=relaxed/simple;
	bh=Nv135QtHVpKdofj5amDkoSDOXzIVl5RU8uyV8ACdjWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFbVBAwtOxmofIGTkWvPbD+zL/hfO7wLrCx+NRIjgbwTQCJpOrHWECh0TcFSGZAjZ4EpV4vcCD6HgSuRBzj50Sou+7Zk0PkGvfXFEiMMW1oyjBiL+/p3E2eTeqShYBFRoV6iuGvPnCt7SgljHSwS2SAaX8ZyipDo+xKlEgQ0Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=IOhRU/S5; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="IOhRU/S5"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 79D26BE0037;
	Wed, 27 Mar 2024 01:27:10 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from ra (ra.horus-it.com [IPv6:2a01:4f9:6a:528d::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by ra.horus-it.com (Postfix) with ESMTPS id 4EA0FBE002F;
	Wed, 27 Mar 2024 01:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1711499230; bh=Nv135QtHVpKdofj5amDkoSDOXzIVl5RU8uyV8ACdjWc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type;
	b=IOhRU/S57XYu+j5wVyAJBrPpYA+l4exg7yacZb4yDwDfAKvMXmVaxDeyZWAj1WMSO
	 Bn4fC8kkI3qSjwtpZY1L7pqiqht0rFeCWRoPsuS0okpgydRNXesFkzhRc3F4CAfS1e
	 FXX7ikVwLrciAGmoHMqfmvji5XsyXQTOcnx3irmyPoj7JX8nUrV3DIjr3CHlfcLylB
	 uCErC3mR2YIpp8c5HFNexEd5V7Wh3WnZWkU8qmzYRjCybzhAUi/VYeK7q5pr5tDlMA
	 ubXhJ+WZ0DxqYbqoal9la6l2MMscWY2ie8YU2T4kwJiz7R8m/gYdbUSp2X+Kdh+kQ7
	 kJf7SBIzH2aUA==
From: Ralph Seichter <github@seichter.de>
To: Junio C Hamano <gitster@pobox.com>, Ralph Seichter <github@seichter.de>
Cc: rsbecker@nexbridge.com, Dragan Simic <dsimic@manjaro.org>, Chris Torek
 <chris.torek@gmail.com>, git@vger.kernel.org, Ralph Seichter via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/1] config: allow tweaking whitespace between value and
 comment
In-Reply-To: <xmqq4jcs7evl.fsf@gitster.g>
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
 <xmqq8r2jp2eq.fsf@gitster.g> <xmqq4jd7p1wf.fsf_-_@gitster.g>
 <xmqqcyrg7imy.fsf@gitster.g> <874jcsvccq.fsf@ra.horus-it.com>
 <xmqq4jcs7evl.fsf@gitster.g>
Date: Wed, 27 Mar 2024 01:27:10 +0100
Message-ID: <871q7wv7s1.fsf@ra.horus-it.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Junio C. Hamano:

> The easiest would have been for you to say "Yup, the two additional
> patches queued on top of mine seem to make it better. [...]

Would it? Well, you wrote the following two weeks ago, among other
things:

>> I thought we already discussed this and unconditional "#comment" has
>> already been declared a non starter.

This unilateral decision of yours, and the following prolonged debate
about spaces/tabs (which I clearly stated I consider a waste of time)
left me with the impression that what I think doesn't matter much
anyway. Also, it seems to me that this whole subject has already been
blown far out of proportion. If this exercise leads to the feature I was
proposing, you guys can do whatever, and I won't slow things down by
expressing my opinions, or by continuing to formulate my own commit
messages. So much time has already been spent.

-Ralph
