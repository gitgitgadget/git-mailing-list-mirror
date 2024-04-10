Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31519E
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709405; cv=none; b=erpNkkuqGRLIwPCcL6Uu5isCpoPkrmXN6LlC2zZyC6nJW2R5RdoWfo3shEt7gSCkippadvLyfpjhkOeiABlfwX3CaGn76QjxxDJEcxCNrQQCrCF7L91UfVZVpooWcFBrWIsFYv/JKY+Vr4QhilAvxEES8CLQrO12jy0+cC6yzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709405; c=relaxed/simple;
	bh=pa5GxEqzObTILbgf62D50h/JQzLw4cPazJi3nvw02v4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KzOkyP4HNlr1bqwV3szbmWrcaq9pJr5XpNZACDYFPgN84Ihs6m/qSE7w5F1H+WvUiPHdFKEIRjhdWIffLz+zHItn9A1L8ZnwjcXpKKk4ZhxBTsmu7dS/CAgJHDx4VFWp7OMRepDJFlyWqb3OiqptwTcbtLXtGm/v6gSTdaw0GTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fKoyhYHA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fKoyhYHA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C93A329D01;
	Tue,  9 Apr 2024 20:36:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pa5GxEqzObTILbgf62D50h/JQzLw4cPazJi3nv
	w02v4=; b=fKoyhYHATCVMCnvs/CL4+PImDBVYRVGowQs80y7ubymxRQoMV+Gsga
	yjTACljrt+PmlPxbKrJjGIaCeJR/TzX+mz+Z2lMOuuBgIT91VEgbmiJ3hRpyfU7B
	Vt6z5L/87zglIOYlPyhD5ktoUZc6vijudPhVtQbc5RmnCPik7hugM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C104429D00;
	Tue,  9 Apr 2024 20:36:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 08BF129CFF;
	Tue,  9 Apr 2024 20:36:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 5/8] SubmittingPatches: discuss reviewers first
In-Reply-To: <CAPig+cSw5wsYpm4Szk6HzgT3u+wMVz77NfqR1rLJrmCzejxvmg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 9 Apr 2024 20:27:13 -0400")
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<6f71b1731f2aed9c2f4dc101bf4349344b575d73.1712699815.git.gitgitgadget@gmail.com>
	<CAPig+cSw5wsYpm4Szk6HzgT3u+wMVz77NfqR1rLJrmCzejxvmg@mail.gmail.com>
Date: Tue, 09 Apr 2024 17:36:38 -0700
Message-ID: <xmqqo7aiyrxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65708B44-F6D2-11EE-9342-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
>> +`Tested-by:` lines as necessary to credit people who helped your
>> +patch, and "cc:" them when sending such a final version for inclusion.
>
> Again, not a new problem introduced by this patch, but it seems like
> all of these are actively wrong. In every case, these trailers are
> _given_ by reviewers _after_ a series has been submitted (thus, too
> late for the author to add them), ...

Well, this is another instance that I may be trying to be too
helpful and over extending myself, which does not make the process
scale well (the other one being the "one final resend after the
list reached a consensus").

If the authors collect Acks and Reviewed-by's and resend after the
list reached the concensus, it may take one extra iteration, but I
no longer have to keep track of these trailers myself, which could
be a big win.

So, I dunno.
