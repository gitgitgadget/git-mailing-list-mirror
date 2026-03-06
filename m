Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7989329C54
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763267; cv=pass; b=aQELsbapWn+nP0VVX5xAMRdjsuKU9KdInZ6dJtQwaSkeDt37jgsTdD2/O8WEm7FrjXEH/f5qlTE9hMqlh1GhNuCQoiPuKfvg0i+/bZstEa2wYRfDHlDa/UetsnRopctzoJ62HZtqGwtAV2IUlJYv2GlKAWZ4IvsgYt1k27Kf88E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763267; c=relaxed/simple;
	bh=z/aRDtssIjPRYe2gSaWccGk+oLHKjDfmvR3+68HghHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CxbQqXPHCHF0rZae9Frf+pE95zA35KAVT1kfwqv9yap0EOUebyZJNgLODujqfdPvFnJDC3crdvSikGVZGG3DbLM+ugourXDk4SPJU0fKnK/lgLeR2xk4h7+NAXxPEb8jfyqRPU5vyRmJIaTXcr1UDzHc34dZu6HNglEw0A1hMN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUlem/xq; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUlem/xq"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65f8c8c3a4aso16099693a12.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 18:14:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772763264; cv=none;
        d=google.com; s=arc-20240605;
        b=OBRfGR4IggyLG4Q9TLBcWz3kBJ5rdQGgzUTNh40sFAL8V+ikZl1lNwr1RFAjZtjs5U
         fO/LhB8eeW+sfYPQlycj1VxEHPGRszCSbL3XzfXgkdfOoxbDJdD4WxrJ0HSN0DdFokV5
         b8zii4SPT0U0TSlIO43Se2EQC3s4692U3+t4gXa2oWpZwv+X83pRP2Sm3ACLAK4fqGgq
         AFvv5YZNkxm27OVciv23NalNNAKbWNvPUqXVTuyQDzK6EfWnTSOSgvFWWUle3Hnfh8YU
         Hkhl2lbjQ4MEn/Khbov2fdTXMi0LlqDYieF74xvyuCL73ur+BPK6fmn8G3rk2GzU1+BQ
         j71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=z/aRDtssIjPRYe2gSaWccGk+oLHKjDfmvR3+68HghHM=;
        fh=wjSRtrEBmvh7r3aBZ9Xq0TDKSV1u8Nrn+o6sKyqYrNI=;
        b=LqM57sagwF/hRmFMnLPC/L9BxaSJ6zUyf6wmloOyh127TdUYTPCDKrgIdiU2ibEbsX
         CyEh4BEa84z3NNY/el2SRGj0r/Rdhyd9moazeoI4+ZGCsWbqod2A3B0tFCXw1WOCdQMt
         MY43aOOR1q91pnoTUn6XwS25XEKKfEAy/aCoE/EjfgRPHN1X14zY7uTyI8LfTULD7rq8
         0UQbG07GKIUrt1Pp8CAW81vqaGQW582PZ/RUi85kgEiqr/vv2MVHPbpE5uAkNRr9lMHp
         zXGpPJg7eLFJ6Th6kqUvs31fCcvitoH8+wlNh8ojwPaVGUR18lTNUVi9x/ErwmVp709a
         YEDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772763264; x=1773368064; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/aRDtssIjPRYe2gSaWccGk+oLHKjDfmvR3+68HghHM=;
        b=EUlem/xqrJnP7dlnFXBO8edZxyHFtseZpoJfjWPfLHayW5YbL5nRYUH/SkH/NDsLUU
         6T5hOXFK3Uytwg8piKYrLJqDYYeo+NxJFq/HrcQFp8AoUGefdY7ImDyu88KvP9UvvceY
         Ape3EWCCE0jleczczIZz1FDFmSbjY2RKmdPV3bVxHBGGsKK4aXC3Yedmq6bUT3U8aWuC
         1Ch6gNJnka/4qbH7Xv60ZlPhlHe0PP8fHgNu3T9g5hOyPUlJxCjPrZ9RupYls+Jj4JLC
         8CIW8Y6Pse+4SMRy/E5v5LKdmESxF4Te3mm6EILbPqPMhvlENhDslBqulUs+FU6KqlaQ
         DsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772763264; x=1773368064;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/aRDtssIjPRYe2gSaWccGk+oLHKjDfmvR3+68HghHM=;
        b=gDXlepquat/b/3YZLkljJ8R/hmB0zagaebvvpkHatJG3Hixq+S9EB6xS5Y84IMfA8V
         3nujtuwWYc0Q8d+kr5F2R1Qk2KUm2u3RBrrLo1pAPJnun11oqjBMcjD9R31/wb+RvyTP
         8d7pOsRQOnP2fXZjWl0JcMk++FYGCncR3LiWFKGsuz4bZToGaobOU3PBMQzOakZCX0Vc
         6MI8Jwq06/wYyD0Cis0i82qZqUbgxUkDL/SPayB/UCYYEyBqCJ11WPVt4tBNFjymGhfW
         g/uoPzs7B22TZR6eutR/+Sic/OspWC4bEH6Vnb9wLh/rSJQRwMQwWSGodVLTj2jOLCnN
         ymAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/c91wazO5ayfcJ/sMaUxnE2OiEvNEacAUjIGc/X8SMgtHIwfNWeQg47TNtrM0OHt4nQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1Eq2wmPdGmkgFtHt2dmS9ukDsPjPaH4WckwMt/iH4qGXhF6/
	WCMnXE3K1pOghLW0CH/aFAnH+UzdjsOAxKPszmokdw5xjjEnl1xNeMAj48t5Ac5w6mo846HK8jo
	ZR1YUAh7oM81F7kqP9qVfa83V2t5gGl4=
X-Gm-Gg: ATEYQzw93jrEAq71sSgTfryEkfP75hOOywRp1f6FiRJzSGwrspm8CD3E3v4i3nVclvc
	p0ty2U2TheAnsHUyhfn3QDl8Y31jiXVGe71667/Vg8ZTYsm2mmAPle8qXhv/EEh0coC6JXND6J4
	JK053JsIt3R1QvS2tZtbX+CE4Yg3VKq4kAkUgj084V38CUQCf1h0/RewIgo+/uxf31PFQrNvYdZ
	8a626o1g1T1X07ncueG6J7fv5OmNYjLInyYTSTFx8+SnRHhqIjZ8Si0VOIZtIx0XgxtSun4e7dM
	MHEBzRWFJ09o/clRvvprLArtz4fCdmsW4zFGVLIHPTggipVDFghWzlFYlYjNJW+5ntLGHQ8V18K
	Ij3ji4I1tu4qlqmkxLL2HeccrZ7dSSdy2Q40=
X-Received: by 2002:a05:6402:1ec8:b0:65f:9c21:e69b with SMTP id
 4fb4d7f45d1cf-6619d4c4254mr222434a12.10.1772763263913; Thu, 05 Mar 2026
 18:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net> <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
 <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net>
In-Reply-To: <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net>
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Fri, 6 Mar 2026 05:14:12 +0300
X-Gm-Features: AaiRm53TQPjk6W7WBTjP06DH6mk3xbvTAUMb0a7TN3aVM0bLkX6r00H3YKqKMZk
Message-ID: <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Ivan Ivanov <qmastery16@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Brian, thank you very much for checking my logs: indeed, unfortunately
my system is Arch-based so we can't compare it directly with
Debian/rules. Thank you for an idea about /dev/shm , although I would
like to clarify that while it *might* be what is failing this
particular test - the causes of failure at .out files are different as
we could see by the prior 0300/0301/0302 and some future tests (could
share more logs if needed). But the external appearance of these
errors (Username/Password prompts) is similar to a user and that may
indicate some common pattern between the problems, i.e. maybe there is
some extra shell precaution needed on some systems (although I'm a bit
puzzled why my distro's packager seemingly didn't have such an issue).
I am still trying to build with skipping as few tests as possible, at
the moment I have to skip the following: t0300 t0301 t0302 t5003 t5411
t5540 t5541 t5550 t5551 t5559 t5563 t5564 (adding them to
GIT_SKIP_TESTS one-by-one, maybe there'd be more)
