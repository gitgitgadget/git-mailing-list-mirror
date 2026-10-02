Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CA175A62
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928291; cv=pass; b=oVnAi0PwyXIlJcXZC2Ih/3GbfILpFn7s3HguRX2PbDrRz6PiIUl88PM56Pq6b+4sScvIsWqQt0UE8IGH4Wz/DJp/4BqifoM10ny9k9SzMVdn2PM4jzF3p/eCTORW91KLdXKZI3PDur/au3kW6BnMav8EqknGvCT/WD1wia81n+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928291; c=relaxed/simple;
	bh=epUED7KhmQg2pQyMt8gPOONVJ6ZcXHJjVuHZWXZ8hSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATDnIAC1WcX2kVQLnpwfP7FXHo9giv7BjAOTyOitdtE2o6DsWcLzELSFKJXn8c/GHvBmLEe+wV5wvdGSdrpNR7z3quovsK4EJb3lTtBfLlKgWfgzgAco9/1uDXysm8ANN2kCAFllf2oNx/lq/EvlmXL96Wvn5zXJ9HWoEWtaJms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/nhYpGm; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/nhYpGm"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso11319833a12.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790928285; cv=none;
        d=google.com; s=arc-20260327;
        b=c2vdzFirBxBj0z/7DvW4NovjB6i+GCmvY5/K1ZOzWhWykYv/oAKXnTScZw7g//sQCE
         5QFTPuqauk6StqNM/QfJMf53GVMotw5C+txDazXu0nMRgUvOemiWXnvYWbO4uIhfhuHn
         8ZCMH+FOItwPAJ0sUBShm+KdEFZrvQzWNoD4ZrF31wG4SRyYMDijbLlZ/7ycB64RqyCS
         QY82HStGljypvMGIw3SFSpxIKjwBaiv6AbCMVpFvF/6jqxk6l1WKerP6dlf2+lti4k8B
         MswBmQHv8zTQFnHR6UZHfuWbIZJWba6B3035y61Tn3s2ZTWsqoqx2cSEY4XyEvavPaLQ
         BAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=epUED7KhmQg2pQyMt8gPOONVJ6ZcXHJjVuHZWXZ8hSI=;
        fh=8Cx1PFzGWqT+vtZlVhFRpgeRm+cee/XDMD3NCUQzfPw=;
        b=KPQmWTZaYEcntrG4Sz6geGx3il+CUWr84lr5JaJiaQFsESBVAN7eI/qz7y7VrU5zgK
         HtYAimsm6Xqf4DzFRFr2Hdh1jGGtzz8s+FKpa2IN/4vksoHstHrylMXjRV+n2ALbqrp8
         G/OWGyEtGUFNPWIPOWwNXSWNN7MbxGxEm4CPEumvQraTbWAGkxI4UelJ1EIHG3NRbNoH
         AA32Mbhz9SVK3MxbaIVKC7u9eOmKmalXIfl+LIqSg+Yu/7AEaWfgSixxThMXy80ujG3K
         pu11HN+fftwvbKY+DVJZzBtjvBSl99aW3YohvrGThoUPqpVo6c+WLSa+6jNLJJSxtK9I
         P4Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790928285; x=1791533085; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epUED7KhmQg2pQyMt8gPOONVJ6ZcXHJjVuHZWXZ8hSI=;
        b=W/nhYpGmDjt8J2WvilMPL/j+W4qJKYOaOZEqTSgdZqbs8N8B04SXISowAP1wxr3lsk
         042At+aSbE7FKe7ZFRzF4yGd8GukNaviZzAHsOWReSyO6+MJU4Yia0nTwHYyiQJZL3A7
         yCvObUyHdfLnBWDvXkYXw6LwoUAC7Fj+qlUAYUfqJZa3vpa54cLAkJ/ZpFNIi46LG8mM
         Ix2JfVS1zC21RhXZEBuHhqJYY81gjFO+jUlb0DcdF3SSz2r9kKzeBjcjGiMG/WZ1pUmW
         /5vnwX+xDP/U7Q34NbG17u/mXFOTBDqRnQ8tQYgWMOnoIpH3BD6gFrx2bpZuAnA8bYvd
         D9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790928285; x=1791533085;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=epUED7KhmQg2pQyMt8gPOONVJ6ZcXHJjVuHZWXZ8hSI=;
        b=tYzPqaFFBu/zQTjvil7oCzd8uxbAV8conoxnM9+BNBa+L1TBSsxEGeCTDNeVG38Xr1
         7eblKcERtQ5m7e50b+xFSimcfIXiiP/BhHxKmM2Crh+I25xe8X9+4vM/a+L8zXTKMEDS
         npW94jSYBtjKw3bRWAoFVJsGteGpUwq4j50cLzE3o1n6s3djRi+O33zr0jnoDR2/J8LF
         6oYHMrtOcK5lR68d/CBjzx91I5yeLS1NqSbusxW3ReVrMIiNAE8c0a5SlEj/LDsHQmxV
         UlQL1kIG9WS5RThs6GlicpVwu1/wVG3gBAt/kN+5EMtyJcRA1wigUXoXcJXLtPtLl6en
         q96Q==
X-Forwarded-Encrypted: i=1; AKwUvBxQLDoyV+qXh1lwczNBtLkJztDezpAtG9hAVnOdnV6n5asdVWHA4uucIFZIvKDeMyN9nXw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVWw4WbjZUTmGh1CtmHUqxd5vAz+iMS4GCoWUxN/QAncEtSSmY
	GLuV0tAqFLej/WWXvUn6S4MI24BArsQNQgCNjLyvF77NeUwx7PkXDBJCH4X5c9wRWcwaoeD9432
	x9MI3M0nqlCm+himDFQx3BLgBOVWgPsQ=
X-Gm-Gg: AYBFou39Kjna7FCcXBBnEsOeo0gndqalxHdpX1dUGsb5GEW2rLVLYIIrzxue9gg07la
	PyG8VTYmFO471s51BtRXH7ak4eRL677CxKFps4kPar2I/gf6DBjVk1kpJzl2LXWHcCQmZWIdj3+
	P8oAjvMM65iB0z94RF+6xCKW++lTZupWNY5IRP8lHMWnp7549DNPy+76TDfs/KMiiDRcZFQnDIz
	rIb6oO+5Da3LptLpWZ/UtXxM+9mf7S73AVszGgFwPI9dQoA4+JnyRJsg54kJWJCFnVHecqLJUfk
	59ChmWklcvkdRWQO2xhzyGC02yWq/OUl5x2v9Oy2zhC901SwgX7Biq43FCTYEUQ3cg==
X-Received: by 2002:a05:6402:5507:b0:6ac:6c00:bd27 with SMTP id
 4fb4d7f45d1cf-6af9e03ad05mr1088595a12.2.1790928284934; Fri, 02 Oct 2026
 01:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com> <8ec2b53d8265e1219b5f1279cadda2ac44c96ae0.1790880255.git.gitgitgadget@gmail.com>
 <0e0972b7-65a2-46ce-84a9-7e403620802a@gmail.com>
In-Reply-To: <0e0972b7-65a2-46ce-84a9-7e403620802a@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 2 Oct 2026 10:04:07 +0200
X-Gm-Features: AclHuK8snzKTzVc1z_TmshmdkXLjoGxHmnfVJvEUqBNvvYomVDiKdMoAoDF31ys
Message-ID: <CAHwyqnWyKRd_K0VfEMKRd79AJa2ygcq3wfWOPKS2+YqJ5UYqWw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ci: point test failures and fixed known breakages
 at their file and line
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > A GitHub annotation is a single line, so a `%` in a test description
> > has to be percent-encoded as `%25`, or GitHub misreads it as its own
> > escape sequence. for-each-ref's format atoms use plenty of them, e.g.
> > `%(raw)`.
>
> That's a useful example of why we want to escape the output which makes
> it all the more puzzling that we don't escape the existing annotations
> that I mentioned last time.

This feels like a rabbit hole and probably better to just drop the
escaping altogether. It seems that the only thing that would need
escaping is the literal '%25', '%' in ASCII, but it doesn't even
appear in any of our tests. See:

- https://github.com/git/git/actions/runs/36976989079/job/110742888375?pr=2435
- https://github.com/git/git/actions/runs/36977041388/job/110743045462?pr=2436

I'll just drop this now. If needed, better to pick it up in a
different topic. Thanks for pursuing this!


Harald
