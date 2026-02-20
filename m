Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549683EBF10
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606791; cv=pass; b=Z8t5Nbb7VYrx/vRr73vFDzMHp1lyRVn4kNqS/TUMH1ybbSHXX4rGViSaZMZJ3iWMCl/EK40VZABrqQpgxSKtCf5U2cz0ViXwk9cebEsWwsJG5wyHETiVukfpv4o2m2NwjHcAntsWB/2TMhMenrB2L2khoGI8xXg116dUy3ReEFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606791; c=relaxed/simple;
	bh=TrQSvGs5jcAXPnduOtQmkU5QzbOKWRi220hTX3L2coM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/LVBuwyADR7koS77ckvYhRD2ZrJxvSCy+82IPeN0kfNX/PFmhzvgbNrHTb+jV5AjfPeFJLjL/BkCz5Qs890dPjKmpooLL2PxrM+Zg5LFFFtXdXySM4/O1UReVhhPF8gP7D8HonNIg0e5GTSU+329ATGRGJfuIYOWrKKLmq9AzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvHfGk0U; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvHfGk0U"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso2378491eec.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771606789; cv=none;
        d=google.com; s=arc-20240605;
        b=HQSwcDPPQRSl9aSNc4Qk1xJdONDbSfT8/eiPZGa0snzynIwO1IFRLhANe9B5CtdWHc
         Kuw7AiKCbbVnoveSnF20TfwWE2+ARbhaFL2XeF4EJI9YO761lvhOx+HZp0smDrQmKfmm
         fxH2qXfwBLCKXk8iKr27k6sSI2Mc72mgNmM9l3AEXnF2h6iTOng1GCg6lWBaCPJS0/Ho
         jKVLJJl5MXxfZFfsdu7dZHcLGVGZT2hRMIQt6eKEk43KjhN+f8JIKnGDROiqC75Q2sZ9
         u803fKfLhxL0Q3dYc7rXyKaCvd5MWDOnO9symvR2DElpWHccj6a8TQV50Jq49gMLfITA
         5tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mo1QPuXC+AvYeNZLFUXRD/FmckzfnjqfdMc3PQ2VWqc=;
        fh=8xBWsRwhFyTcbAbk7jhxmTpHuLIjAWAyNoNJh705VGM=;
        b=Ars4NfobEa592FFaI/AjyE7XsELGZTWjWlqgfKpxTlotBylfmc57rn1Utot6I3SvYC
         jy+5NBghIkUuEHBmqjuUjmBJq8xzucG2nyyQ59/ve1GXiqhHolPTD9ce6k1ixP0Plob+
         n+J1sqiZ8eU6V5bCrCj4Iu+SZqbipm3rt2RJp5OGEurS6YiFYmSdtl5oGKxyb60+pCxZ
         2KKw/BGWQ3ODb7++rbqYce1Bs4UJEzoQVrA89tnKsjVQn7K1Up7p2VclNVHl+lKPTlH3
         wKqwwkhgwj0jE28tau6DE3NsyeqzHDj4hBq3hfiENDnutGdtStx8keFY5SVazs28nVI6
         wZsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771606789; x=1772211589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo1QPuXC+AvYeNZLFUXRD/FmckzfnjqfdMc3PQ2VWqc=;
        b=IvHfGk0UCULgvAVejHi3bZqJYVA9/n51iU4QpOwywORYV5YqjIctzcFW9R3d27yfTe
         ulEZjhFFhZbWSCenpyZQbFJRQG69lqNu5hdZWqY36S3TrMLCd8aTyoEGwaL5TK2y1BPu
         pzhUF1gTrVNpEQFKm55gm0f78DR7ULsXJlFJM5lKjFPenWN67OBUMuYWJ+HxFCatOSq9
         2W8op3zuQmuNZCj3EcuhzskTNo7QITEy059K85hNcl+LuHVXRzhBIJeO1FdOW6ZcT72f
         GSFA2hoAIUzXRG4ZZph5qlhe19c3i19YBnt7J67IWajBB7MLXsT12sBW4/H7LxzcBzrp
         xJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606789; x=1772211589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo1QPuXC+AvYeNZLFUXRD/FmckzfnjqfdMc3PQ2VWqc=;
        b=FzfuuztGT5AurwtCwzmenbBsNjBSLuIssUWRu9gDq89zyVneEUXaNYPbHJu67y4BZw
         hRlyBTVpznV2eUCpy0yf1/7F3kvo/hOE9srCRJpBEozxITWpot1kpeaLxfrFH56NfTir
         zdyR/ZK7+BRIHZi30to+qR8OHUn7+HhcdM+NpXnKCowAngfFcM5aJKn4DyKrjgzyfD+j
         pOhXpKf4VoqG1Ce6CuWKnxusf7gmVDvIbZDeqyuPEwxNs79IRvrKKTtgr+BL3o+rjD/L
         YdsCMiEo0zL+nK1sO5A0vQa/OVO9YW8uvqqU6gR2ArkHhaV64q4b65JMml55xfykCQHV
         chkA==
X-Forwarded-Encrypted: i=1; AJvYcCUIDTini3vHwnltHfS4EVkraxbUaBJUkC3ERtZ2ul6u4zhN3jZ9vN58dzqxlFsWn/Y6JzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmS9ebX7AC5pUJue+853OGrucIot15Uf4DKVOwtr3OYQBcIup
	IvGYrni5O0hoIBfq9CO9gqlvk59dgUjICQzlUGhgZjkP5Mg+XKptN6hTXzwjL8SvTrjDbVcGDCq
	xe3pIGrRg7iUozv8ohkyUtGCrbjkiPQQ=
X-Gm-Gg: AZuq6aIAwOlqDBGowzk+jurxQyo32XESLsOYmsE/b9OBgoeNoQ+y6inkB2fvo2MI8nV
	4i1t9ogRWrS5wwBpu+Q+IualKaXn/qYGvq7DtGbqIVfoACSCrrbSMieHXIemL/8AIYYgBe0i6Rm
	Hli28+l2Zg9U7PlO4elslOucHiNEyyCTOPcs2y14PUGN8xE6pfTB/EWjJ17jGPxVX67NipSzE5v
	DHCXFpg92+mmYhQSStucYpTFTSf5zzanu4ML3aj8N4kxfWDger7rQZQrj4trJf/UBVXVG+YOCxK
	igT2Qt3BO9Isc4BRogj1IxC/1CDoaWbccnJDFjoEng==
X-Received: by 2002:a05:7300:640d:b0:2b8:26b8:3426 with SMTP id
 5a478bee46e88-2bd7bc64893mr159138eec.13.1771606789176; Fri, 20 Feb 2026
 08:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219152407.12160-1-deveshigurgaon@gmail.com>
 <xmqqikbs4iod.fsf@gitster.g> <d2bf79b3-4407-4fa0-ae2b-fcb3178f36f7@github.com>
 <xmqqzf5431ek.fsf@gitster.g> <xmqqldgo148k.fsf@gitster.g>
In-Reply-To: <xmqqldgo148k.fsf@gitster.g>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Fri, 20 Feb 2026 22:29:35 +0530
X-Gm-Features: AaiRm5201iAu6dsCb86eUcj4EHyy-R9Nx1T4THmiNencveZTRBEPw7qQllP1jiQ
Message-ID: <CAG7UgETZFiB_J3wO+OD+R76GtOR5eNNNv7XAT_HPBksM9FHGsw@mail.gmail.com>
Subject: Re: [PATCH] t1006: fix %(rest) test for object names with whitespace
To: Junio C Hamano <gitster@pobox.com>
Cc: Victoria Dye <vdye@github.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We already _promise_ to chop the input line at the first whitespace
> boundary in our documentation when we use %(rest), so there is
> nothing we can do to "fix" on the implementation side.  What your
> original tested, i.e., if the early part of the input up to the
> first whitespace does *not* name an object, then the test cannot
> succeed (not just that, the test should fail, unless it happens to
> name another valid object), is the advertised behaviour of this
> feature.

Thank you for the clarification. I understand that the whitespace
split is the documented behavior of %(rest), so there is nothing to
fix on the implementation side.
