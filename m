Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D88134B1
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725722117; cv=none; b=uM0M5fJW2Gmv4RXP8fYo6a7DrEvqWRz8uFcVOD5cmMf76oCVmcmenzjxFiyBXYODl9dbyApJIGB/72bPvaM8gWm1GozVPqS5zZdJ1TaW7t7JCnvzImwfzbnRi+kWb2baUPQOeJBv6AMkUWJVFiik9F0woC7NoE7jojRNhl+MYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725722117; c=relaxed/simple;
	bh=baJVWO13CjcYITy4Kj9RFWZhzLpe51d7+ufYTjAMoj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GAYTYD4Uo19e9hDoFTqgzOf6MvUvWWcPgYz5wJ6Sob5+2b7DlIDBMb7xpj2hP0dMGQgJTg+/VYEohYcMpxiZGGGItRbaJ6SwPpw4IKzF37lMz61jk/lpIwZM4rBvcmfWEM+e9SZ2QKw0QD/AgjmI6z3cGo+lRl01qA1kSyD7Upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y13b8sQf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y13b8sQf"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso16531046d6.1
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725722115; x=1726326915; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ua8DsPiRAwq/A8bRYQEYMOMrawlQYdLNMkq8wvsjiXk=;
        b=Y13b8sQfUNsvr9PPHC/UAFtfDp+AOuHbjJ+usG6weiKDrvMnA3b3HoWHh/9MrpUHSK
         TLU4VCpw1Wscc9ahnvgsxB5BEDtd9dFmHsApIat/E9A5GuhiLuGi6HApufDODB1kxRqt
         xVhNFb7H621RC4T/LliOG48/wsTbtKToGQwAaWC4o9FAEv1MoNH0reWK4UM9qMXQXiDz
         h/pNbtPOPiGJm8LzOfBJF6B0gSED47eI+k31lUxnKZrqoWxeUQTMFkkzhiQSwgUBib1+
         BRn5h960DJ55YYKAeSk347aDJBGxSLra4/OdiIJVKdSdSfrnCJk0EdlkG79gUJ+66lmH
         SXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725722115; x=1726326915;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua8DsPiRAwq/A8bRYQEYMOMrawlQYdLNMkq8wvsjiXk=;
        b=g3iUHxLJHmiaRrsXhwPdh5RM/EuLMeQuSyHRPKMOeKc6Mk2518+IOk+aO1daSgrcIy
         UjVmIjl6B0J9tlG1MzeFV2wQ4R9taJ36WU4HlaYEQ5PxNNHmSnVDke9v14RxAbWljgwW
         4/58eV7R/Egt1HPe3eUrJktC61fyA7PNETPlZPJIrRwCkkDea8GpsTb8WRrXnuQyWe49
         nP68XZuTrNs9GYI6rFkVTJyBHQPMZE3HrIpk2hweMOACKFi5tqPLfExa2p5RIxcH12I+
         xurtwOIcRD2s0uE8+MUAuXV84iFzZLIIjPI8s2v28Ba+EtJe7keomYTZdBHReNW104L+
         rsZA==
X-Gm-Message-State: AOJu0YxqXNNmrlH498XcFwdK5XSBcU34Qn+zhnlxQhJ5StefZGN8EZIb
	6u0uTeI71+n5liPAjPmjzFSFo+ndiB+7wF4OUU4Paf2w2QOfqagR
X-Google-Smtp-Source: AGHT+IHlkSgD6L6bMyNC1aB0XKa0QMxehY7jUtbRRdAFFqMY2GuTVm/NxY0bpNCnRA/C0yvieGZGnQ==
X-Received: by 2002:a05:6214:428e:b0:6c5:1efe:f285 with SMTP id 6a1803df08f44-6c52850ba10mr109207326d6.37.1725722115391;
        Sat, 07 Sep 2024 08:15:15 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::3e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432ded8sm5119166d6.5.2024.09.07.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 08:15:14 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  gitster@pobox.com,  mh@glandium.org,  sandals@crustytoothpaste.net,
  Jason@zx2c4.com,  dsimic@manjaro.org
Subject: Re: [PATCH v3 6/6] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
In-Reply-To: <20240906222116.270196-6-calvinwan@google.com> (Calvin Wan's
	message of "Fri, 6 Sep 2024 22:21:16 +0000")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-6-calvinwan@google.com>
Date: Sat, 07 Sep 2024 10:15:12 -0500
Message-ID: <m0seubo5q7.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Wan <calvinwan@google.com> writes:
> Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> to their respective Makefiles so they can be built and tested without
> having to run cargo build/test.

I feel like clippy should be run as part of these somehow, but I'm not
sure where.

> +libgitrs-sys:
> +	$(QUIET)(\
> +		cd contrib/libgit-rs/libgit-sys && \
> +		cargo build \
> +	)
> +.PHONY: libgitrs
> +libgitrs:
> +	$(QUIET)(\
> +		cd contrib/libgit-rs && \
> +		cargo build \
> +	)

We should definitely be setting `RUSTFLAGS=-Dwarnings` as an analog to
`-Wall` in the C world, no? These crates should build without warnings.

Very excited to see this work; thank you for putting the time into it
:-)

-- 
Sean Allred
