Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2618E246781
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780766662; cv=pass; b=f/iKPRE2CIDxMZuTbUJcLtxwD5hIKmEwmcFnl53Sty0rm+hGRo+bAXgHxwfLGIvyBXF0Yuz9l5fPWzKB7/m3jbDUV5D7pPbaQiOhXo6SVOvXppvDkkqap6NMiSmFeBQu6misddB80o4GAyFurvBZCPg3m5t0iV870nDO9j7s2D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780766662; c=relaxed/simple;
	bh=mJbNHVGqt5WPpZwJy9rLsf+48r7/eSfSmzMbQykJyTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3FWKA7WwyvY9zfDglxXbBzAthoqM59C4xdmxrwwr/jxNRPW7uI3tsnbezyqaPJWbafyheVxmq6ufI/YIwU0ZQri7/G2npFWE5baQyYlDePqViveNEbPGPdal1flFoyUGen0dTk93rZFIIhElYrexNZwk0p6mPLz/Lv7nmQQFYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Jf+zgftm; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Jf+zgftm"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dc6fbf3e86so32576967b3.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2026 10:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780766659; cv=none;
        d=google.com; s=arc-20240605;
        b=MvOKDth+K0C4Gqqp1Z6gBUNX/Spufh9Im4mhKfHJ+UwqLQhH+T/v8AmISmLBuBqQxG
         qJZOhAvlkqU8ZxPZcwxmgwyxt6Z07+qoSQ4lDGt2xfL1YpxDqrMkoyttt7F6JA6CN09n
         q2Lx3bcHt8R9INsMbhwVrM+ipxt6cKOlifNEafwbIJHW3UN8Co9ZvSvh8xoW7q9kYGKM
         vSJIcvtrimFcUu+BVNCO/71AnXQl1y6LVTiyGcG3M14r36uJSppBrdeSmja9DN84vpsC
         2zJrJqMjW8saoxVHeMzGjybroOkZvLi/pbSf8Ik+TXJBzMPSyjjx18IdcaXtVNtYRoN/
         5Bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BcOZq7BCNTLDT/GWKpKcFA5SlnOL2p2juf8dQXSXjGk=;
        fh=9tYIKYd26xL2tp09b3yUjf6UOyydo+kcdaqJp4XJb1c=;
        b=F3sq9GNEVjkCHI5Reiwv/YEstHSAzojNzv2mWUCrRtOc0o7AG/AVIjO7iNQb4Nw8zN
         unmm3gs6VnugVf3kFIaJOihBZz4ASR9usKj7OxgYEupsqWXxGxroj7l7Uj7B1Ib7HA/k
         T2hFTjpj1d8akVkFvtoZ25AqAcoUD0m+gWRQYVp37+e5DNONGeIg0zKgV4cS0YRXGiHc
         PL9mH5eoaCCrbTR8CLOJXmgGQfDFPxytSl3E27zZ4gyHPOmaTp0r3RVJkwiX4AI6wMsx
         XcfoL2BkcoQJjwnQAfGIHhfvTC30ZdplqTMYCrseKmXxIyx4klOCzDG00rva+jbbExlm
         a1ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1780766659; x=1781371459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BcOZq7BCNTLDT/GWKpKcFA5SlnOL2p2juf8dQXSXjGk=;
        b=Jf+zgftmzM7JVZSy8vskN3anGohAkSRC6x2dz47g1d9RKH9AJxtQ7hQT5fDUqpxtp+
         xiZ+lAG2mAWXsX9ICuxfcLZHfCgTXKp0lxc8uhXywGFRE+yDY8qsm0ZIvb6TIdQGOssY
         4vyOaPy6ccDnmTB93MrkNbzw3Z4B0b/XsFaCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780766659; x=1781371459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcOZq7BCNTLDT/GWKpKcFA5SlnOL2p2juf8dQXSXjGk=;
        b=kYNoWYnQZATB7RLL4vhGd8gUpZk2qSzCjMzafvsY3mvJ0FHxE0LvjevraWEZWpONcz
         WGynPK6FTFD6fPuZbfGOs8eFyaSTR4UjKIl4Qm/5TVVCIf95+kx3MGaE112+hyh1Ara7
         UdUjJb4bya3D0n54BzfGjU8Q8m7tB4sZVYu5biHxRjRn/NxnzIWJRZ9XO1xQfAy9cbRn
         uxoBOUUHBoCieTn37TrRlYhDOHk62lBalMs55tvVHC3h/qY6NUFbuR9dBSGPRbiAdATc
         3c08OJT3IrTm3Yh9iKVxtkhiQWBhrIfSkzV10mfUh/luILCTeTMtxRUufclF0AJzKGRw
         PKYA==
X-Forwarded-Encrypted: i=1; AFNElJ/d7NKuXN9Tzf4bPR7TDDdHXXOoa/tt/6eLdKLqQSQxYmXfnzcw4bgPHHdhMP0LNkQlmqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fiM//Prhc68G71S3WCKNe+KU/MZ5YIvCUUAP1Ar56qnP/Bg1
	XXh8YqvqCIyZVXc7ROIcBIqh4jUG+3EfaRyUyUguz4M98j0AfebiapM01Ch+Q4eqWNlEHdNpHGx
	JgWvHyw17clne8w90d8Y3S8p7e3ilLuCGanIUBVgfvw==
X-Gm-Gg: Acq92OGLV+CVa8DDi09RXtDM2bPtx5MbRfdU2BZV9glTr6WCn+rBK18TctKQcl3VkNp
	bet++vxYtHnCyY1IzZyuwlb8zbSIJJyghU+ARNV0UWSQwlQdC9STqpC66odXkRiZCq7mqcoVRNw
	C2Rgx3py9suYJVMSvDm7Oo1eE/kDzdY7OxhJ0h3b9ti/nTIDzRliw36EWB/OdEsoUVkXIT74DKg
	dtyJBEMKA+TRP99TQEUZu+3xIz1WSHl9PBPUAMXdd/q/d78AXW2Pf0BTWY5oN8FOLx72RRAuwUl
	Urz/PzS2enklZBwSQg==
X-Received: by 2002:a05:690c:c155:b0:7ef:afa9:7d1d with SMTP id
 00721157ae682-7efafa990b6mr1627667b3.11.1780766659035; Sat, 06 Jun 2026
 10:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2140.git.1780757885582.gitgitgadget@gmail.com> <xmqqqzmjbpfp.fsf@gitster.g>
In-Reply-To: <xmqqqzmjbpfp.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sat, 6 Jun 2026 19:24:07 +0200
X-Gm-Features: AVVi8CdmgO0MM-l1CwsFOt76DUpXrudhc1dXqUWotNElPUviXokOKNCh822CXHw
Message-ID: <CAL71e4MbC+tdTuN6p1HiHtE1XYuS1gBM-KSejFZJ1wbftxNveg@mail.gmail.com>
Subject: Re: [PATCH] prio-queue: fold lazy_queue into prio_queue for automatic
 get+put fusion
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> How can we be sure that all such users of prio_queue has been
> converted?  Are direct references to .nr member, outside of the
> prio-queue.c implementation, all now suspect?

You're right, and the patch is thus broken in its current state.

I did a rename of .nr to ._nr on the branch and rebuilt -- that
immediately found several callers I missed:

 - object-name.c: get_oid_oneline()
   (like you also found)
 - fetch-pack.c: mark_recent_complete_commits()
 - builtin/last-modified.c: last_modified_run()
 - path-walk.c: walk_objects_by_path()
 - commit-reach.c: queue_has_nonstale()

The describe.c and show-branch.c callers already compensate for
get_pending in their iteration bounds, but they still reach into
.nr directly.

> Perhaps the member should be renamed to catch in-flight topics
> that add more users of prio-queue that peek into the .nr member,
> or something like that.

Agreed, that's the right fix. I looked for existing ways of marking
fields as private, internal or hidden but the only thing I found was
the convention of using a code comment: /* for internal use only */

I will apply a rename and submit a v2. Perhaps something like
nr_internal to make it look less like a public API.
