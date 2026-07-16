Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3E30C168
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231281; cv=pass; b=RAqPjuf+BUV/ONyd37JgQ0ZlSyFnGqLBIYdr04p2OYY/RrRN3N/r7ftAe7Wddpp34+TeaEEs9TGCecFRWyGQB9DLINvOCA31l8/dcAXHERCMLAhuFaKey45C4dQNg9NqhM6hgIdBk1ZeYzJFitHSeGUFEG3Pk5u9gg3V9sAiqF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231281; c=relaxed/simple;
	bh=kUU5PdaPJ3VId4Xyp9BlHs3ZQBHU5qgi2wRbK5mRxDk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=djyrgOyWJbHIq7prD08c3Yg46uEDRMZMsyBAjLuy4VB75CGK/vCStnRS+/o4BZ1KQk9AjtBcjJ4gwRtIquJYnbm7T9EQiNqwWj/OVj0rdjBr9ceGMH1Wm3i6TLetmO3b3ga/nkJpSZQgMlro4jrPqPJ2nwvIO/OXCTALPOLQsCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx9iHbYx; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx9iHbYx"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c106c38e99so3123330e0c.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784231279; cv=none;
        d=google.com; s=arc-20260327;
        b=CfPAn6E6FaGyZT/DFtFVCMDJnJpROjoKrOikiBULLGXMFmUATXJOWvQzf0PWMi/F3w
         tkbsco0tWTL5PxxXaWodxnSfiPCkMvuesQ5yBFTTOJ3Gh2GWq/QFWDh8n9M5PQp/sYtn
         EfEfrW1/fvMGdkxYpZr7FkFMlagLw6tBXcCPkf56OqphE4bbWsfoF18QQYvayqHDF1I3
         xUZr6kDQzPhz/zgpqOxQXQGh4E08cMSSM//jxFihn+Y+zYPu+pKiU4VN9sQj0gRufobx
         IKsstbp4hkG2a4G1rn2H8BldggYtzgjYFu/Iq1xnggKGKs0ZuBwHDxWwH8JE5g+4TTGC
         E6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lWLS1rhbizPlXl3oXd/EtlZ/jxw7PzitE5HyxFrf9ys=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ghNOVmOTsmVYq3K13JgweaxLYjjKfcctF56g3KSR1OJEpT1EYB9RCAiD7bdLt2RyF2
         g6xTRJ+sEmEi3AIq/sn3XsSP5VaP6fnIhdYeF2VUnof/oyuFlMNNHPZ9wlAKkmB3XMeI
         ours85MmpBfOBzwGspBSjvVnA1HXuMi8rQL8LQ5RSv6zS47xVfpFOy9ZzYesfEU9I8Lj
         HGMnPPhF2lRir9rM7U6Defnzkt2dN82xiICaOCU1wQzyC8psumZNiBr+nbw26qQLI3Yk
         1nZjIYQXvdkbwqb/A75gXSfCJPj3QWQGHJbZJ7567F3x1JXCeVe6J0if5jGDrtQxSZUW
         GkLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784231279; x=1784836079; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lWLS1rhbizPlXl3oXd/EtlZ/jxw7PzitE5HyxFrf9ys=;
        b=jx9iHbYx4LbhLfSVrSuT7qXMoybWsPOmrix1OhkAElRyiprdU974XGnXPPy7tqWcwM
         Yn8kfm4pyQpbZtl3rOKxEJWRt5lCQpveRZ9EEBa0RC8a1pFdNIt2D2RfY/Sw+U4fqkg+
         NkXSYmqksEQ8+JhsIrxk1Ke4OYR7R1qlJYof/Lvs6fwHIn4a7iw5CL/6XhcxrARhuuWZ
         n+VxyfTsy68Xg0bQ0sLY+fqRlJfgCwCuRDqesfqInDHzTUdgwkAdsNd5RT0hZOUFgeKG
         +xGEDp9DeHKubwkmWEfW884odBpc3yoDp1hxHwWO/7QlNUFe5ABb95a5q0/bENPg4zAM
         MKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784231279; x=1784836079;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWLS1rhbizPlXl3oXd/EtlZ/jxw7PzitE5HyxFrf9ys=;
        b=A7YzBLJso9CXbUFc+lOFx6PyD7pXIaWTuPZib7klkpnv9ewmFnAJcL9HVk257x6QZZ
         o73qXdET34H3swoIsDVCpAgyv+jjBKbtcPP58B+zo5V0iPjduq0s8NBIjg+8KRbo3ito
         5EMuV0WzeO0bDEZtY3I4C4xKhUbo+pS7QKIkJHmpSu9jbqOca5BM/KUAW2I0D/QOBEny
         u+cw38ikgdAoJo0NFj3NJyNLvukHdsYZw/Y7zQt2u1QZ/Pzq5QOZPXLLfDGqsLdjeTNQ
         bom6qJ9zgmNXfKUhNfQsAl6zoTiWJjejDwbHS7m86Emzf66IivLHbbVDxrtbANCKzX9N
         fkPA==
X-Gm-Message-State: AOJu0YzHAyI43A6hrNH1Ny+xNh0oUXIEnxmPBrabXXVmFIpgNQX4kJHU
	vEHkm6a8VykPvoh3+umUqSZWjLfsEf/GDjICN8ARnT9iooJm1+2Z/BgqJRtKa+b16d0DaM+RuOw
	Vgpsn3lVzQHrzgfsSt14N+elL+ORIUedstsRC
X-Gm-Gg: AfdE7ck+uvlCmopcMnoEeCBZnFfzLULkx1tK5k3o6+LJgJyw2jGe0GV42onFuNytmiF
	emyA4fvcTPqTpAsKAk9OGXNzuXm+E9Y/DYabcAxdgX4/rm4vWlDrK6X7ZXwUzWfxzIg8CJe4D9n
	yDpyhhLGrTFq3GRLKFpWiLJhqBRKNeffWWSUMO5yeSZsPYoWbcCdpdcaaiCQfY1OFyInJJ0p9Qx
	SqPIQz55EuqIa/LTA/dE8j5ojg2mIvqbkzAo6cOoEC0r6GWZKLKaYjDQibMRdyBzx3N0wM9tgQA
	5TP4Ui0P7TNZpOkaaexj
X-Received: by 2002:a05:6122:17a3:b0:5bd:73b5:6d25 with SMTP id
 71dfb90a1353d-5c14c25ad1bmr401310e0c.5.1784231278958; Thu, 16 Jul 2026
 12:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brad Larson <bklarson@gmail.com>
Date: Thu, 16 Jul 2026 14:47:42 -0500
X-Gm-Features: AUfX_mw7GgNRJu87dj54qhMQ3X0IgPWNNHeOmANkl_bObC3o4dD6Sas8VbggSAs
Message-ID: <CAJ5prAm+t2pVGjfqqU6c9aASYf7sa-jpxG8v5rezJNYx__xaWw@mail.gmail.com>
Subject: git submodule ignores sparse-checkout?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I feel like this is incorrect.  Curious if others agree.

sparse-checkout is fantastic for working in a subset of a large
repository.  But if that repository also happens to use git
submodules, the sparse checkout configuration is ignored during
submodule updates.

git 2.55.0, built from e9019fcafe00
Steps to reproduce (I chose rust - it has a lot of submodules) :

$ git clone --filter=blob:none --no-checkout
https://github.com/rust-lang/rust.git
$ cd rust
$ git sparse-checkout set src/doc
$ git checkout main
(notice how we only have src/doc populated)
$ git submodule update --init
(initializes repositories in library/ and src/tools)

I think it would make sense for git submodule to only interact with
the set of directories in the sparse checkout configuration.  Would
the maintainers be open to a commit which improves this behavior?

Thank you,
Brad
