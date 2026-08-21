Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA02FD1DA
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 01:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274563; cv=none; b=pRoRXDCJsXY2fSY0s/JHVsYvDZabYB4SShb5Y/arYXc62qdXaal13n2VAQpSke2vv92nDglTHPuakwaiWHJztY77n84D4oMNQz4ZSaBqrQh2V9qWCwMs2E+E0fWHTNI2D6JkGj+BLHUXh478dhErrYeQCec1jIRMIBOfdnQM08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274563; c=relaxed/simple;
	bh=pDBICcr3WItMjTrAVvy9bx90CSxRhHGg46ZkjzDTybY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPACNU/uT5qHHJDyqnhCzmXV51TGnNr8OVAhd2Aa9FJjLC866zDplKq1M1/NsKRpSHwzoVaM7gpRxW4S739/lJfComseHGe12FFMfEwddStQtWTXt3a+xxDhngiIkmD14Tp0s5C8yNbqxSXmLyvmwmvX2fPaN7eYwHAyfxkJZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JaavgMyU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YztmsV7y; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JaavgMyU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YztmsV7y"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 71297EC041E;
	Thu, 20 Aug 2026 21:09:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 20 Aug 2026 21:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787274560; x=1787360960; bh=TzHLgTb3mK
	ntjtGoGTOmrsdxSeRyJ6QK96cJWvgaewE=; b=JaavgMyUYeNTizKndaoQltLkW2
	01+Hp6fBEvdx1FaZdwoE1dl7KNeDsFOr67RioNP/0o2PLQmBsgbb9mn6Wpnwlpd9
	g72jB2LnvuA/U5O/GYSRT8ATjujqa2JLF6szo2JbdoPZtN0rbgSbDBnzqfGEYtr9
	gvR1gba0vQjudzygS3W4jg6JbjbWFQOBAMGPu5ZJucavlqFpRMjnRTe0OV+T3jbr
	rVdRl5kwlDRjRjTMwGA7EYrsXw92cNDQdSMM5l4rJFQzVrX7T6hgCAlcY6FqdH9e
	JS47c0yz08WSw0aFXyLFDxR0bJMBcCdr2YljghFm3LnXMX7pFbzdQr7tHexQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787274560; x=1787360960; bh=TzHLgTb3mKntjtGoGTOmrsdxSeRyJ6QK96c
	JWvgaewE=; b=YztmsV7yzNSbfsDA1f/CbMq2Sms/iE6hf9TxZiB8cMem6TlZaMd
	worHkzP6oMC9+hqQffv5GUrF7b9d0ZIMHTcDKw0xyiyTL94oihPsCRz6VtQFqih1
	shX8e/eytcoeXmtCLM+jyHLanyrHzV47A7iB6zG96AgmV4ivy47HpvaPFHmpTnr2
	PQ8MMUI0IPTHUf/I2FzVPJ4nIzsCvgY5bV6wlIoX//mURauFGRdIDccXLCAfnk9p
	GBnpVVtvFNOEgq/i0B2iYDlMrWJ33GWfP5V6LYxQEiBOyieq0zDTBZYY5sHBTrn7
	To1joCdnzdogaVHc/pSv8eTg0zh4kJMD31w==
X-ME-Sender: <xms:QKWHam6Mzg_M_pquZ4ZEZTrlV9gmn_QWzrMTlfY5101WmR9URdAc0Q>
    <xme:QKWHajng9R2suJUcQqFpWyPz1mUNGeWFn-6R5vl-eWspe3v1yTYXyT3Y6O-19rJjj
    Thw0GR-iEgjXGRhD2FtOUhppCpXJslybIjQiKpaPvRryN-3esiAvA>
X-ME-Received: <xmr:QKWHavQIcxSf1oz0i-VaHABMsjw0D6JC9zIj9cMejnaThb5JXPTDAUpBw0NaLsQry_Pi8t_6oVY9yIt-f4kDgQ1dJsAJC-UYxQ>
X-ME-Proxy-Cause: dmFkZTEPvJnt7mvCK5ITA/7FATsZig1O4uhnUSyZ+vbNqDa7tvnepuZtBdZISAQe2xdpin
    cuNE+EGsrKCIbR9N8y/d1EGi1GzWBh8IO4Qp1tDMGWoUWDOClpS4Do77N9GlfQ93N8y989
    XnlEo1TwVi5lDlVq4gwYr4v4Yn9W25+WzY6MGYXE/7sjnb7D7zMOXY5fWgAcCUUWSs3hc0
    MFzJ9WIDvZd8L8egXG8nd2n05Wkb3tGhhzGryXArB0EaU0SZI8RJsikDDgYC+iloVCz/T9
    I0ScINXRwJY7l6B35MGjbco4OOZXeG3/T2fs6Ttrlsj9e3bRJHjy5+OqxH6FhT+ISSyne2
    AaGKPNY2z8Iy+qmk7wjZtHQPZ0hmLZjljIiNLl1lyNK2P8z7hsUmVSq3u5HmbrWZWrEy2k
    rP+5L022poWH7i5euNEdi6M9Wu4Xk2vcq9V/Wbl2Rc5tJcyuGBINoOFnKidS7bNDc0R/Yq
    4oaRLV+Yiuok6jwIWvI50NfDqqRr7pPx6iSxBVoOPfzFeu6XiHB7brjmKA4tNtnb9TecS+
    fY3Z8yHQjghPP7RPIW6XfgjWqhTMfjCYKG6q9L49t1+tDvRv90PMhmCHpE6vFumZhs/IIO
    wCgRJ6iZuJCOyCGsWLnQGxjbPK8w9T6Bm87+2DehyLX4FaF/aMXLFAFsm9Yw
X-ME-Proxy: <xmx:QKWHaqF348uwEdFdW1Whw3hqVz8RPgd6xAhd7gIEU7FUE7DtrUMSYw>
    <xmx:QKWHasFkNnqRZdht2XRzFQoC56dygpUBz0ouSaKc80XF17waKXkYGQ>
    <xmx:QKWHagRryratF6OZjbS_sm6jBo_Axa36WzizYYHpP3-mofN51pQAZA>
    <xmx:QKWHalKfDd6GPeX59G4dsfuImOkMgcn9LZ-zxamgC8lBLZqY6iVm4A>
    <xmx:QKWHar1cn3oU1TvWCTtOBYwB6C_7XmltEJIJavETJMIARWNzBtwIJ979>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 21:09:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Artur Bieniek <abieniek@antmicro.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Artur Bieniek via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Artur
 Bieniek <ar2rekb@gmail.com>
Subject: Re: [PATCH] pull: add --hard mode
In-Reply-To: <2b9cc581-7c8e-4cb3-9524-2b466209ac7e@antmicro.com> (Artur
	Bieniek's message of "Thu, 20 Aug 2026 18:43:08 +0200")
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
	<xmqqwltn1o4e.fsf@gitster.g>
	<0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com>
	<xmqqo6ewsrzd.fsf@gitster.g>
	<2b9cc581-7c8e-4cb3-9524-2b466209ac7e@antmicro.com>
Date: Thu, 20 Aug 2026 18:09:18 -0700
Message-ID: <xmqqa4qgth35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Artur Bieniek <abieniek@antmicro.com> writes:

> One case where --ff-only does not seem to cover that audience is when 
> the upstream branch itself is rewritten.

It does, doesn't it?  

It is not like you want to always blindly follow them.  Rewound
upstream is w warning-worthy event that the user should be notified
rather loudly, I would expect.

