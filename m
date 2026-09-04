Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CD248F64
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501805; cv=pass; b=sh4wPpcBqXfIHYlslw2cgbaWErhBI7D21R65FuxsY5VSXD/DUUWqvYWzDOvSU7elYxVAB/XhfT/WyAGVXtO3nzNe0+KWkpzjyIyRpei/62BFzeAB3HeuNDmkyyGMJmoSW5n513dQyQdz3cOZINzsYDo3jC/PL8kol/RlJWENkFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501805; c=relaxed/simple;
	bh=jIOD1UB6XP1dXgXTbKxKHhB0gBe7+20Z0G5shSfuiiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdfnjJGkuEu84Q/Wt4xTIyptxMe5ZaW3VujZ0WPDIyu25Asr5dbIVzP1I25ft1ktZeEUIHT/5Dlq+eL50Rgh0KOvGLP75Avt//ZoKgBKzEW75HpoxgC9tSxqS0mMgZLuocaYWrRMA0Pavfn/niZNJwEHfyU8P4YY4ZvVazgotSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNKI/bFP; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNKI/bFP"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4b1bf68b387so279490b6e.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 23:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788501802; cv=none;
        d=google.com; s=arc-20260327;
        b=Ro801H7qZc8aoYjH0phkQ4/Df6ZKzzl3aLZZWDnlEgQ3H5qEixZUu9EPWH3q8fXGvZ
         56BVEAZgHYv0CzuuV+9OlnwsYXvtZjSPb6OU0biAn+gALVuLbH6nFh2LZY18ZpBWtP3c
         joyLsqdrM26QpwEBJZAqa1Q0+maifQ4gpF98NsC+CJ0OAky8U+WskvuKEaTI0wMMJ7Sp
         29SoyEW/1PSfoY3hnloC/5RVj7hcFJXnIWtEdFQGeQNg9/9ZiTiL0P9jCdNFuq3I/FPG
         k0KZD/zQ1OrpgnsmBTQzbXhQSDL/IeF62FwV17kJSbOPBpCOhivW8akU4Lu6ymnL7rXg
         fklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QOefjXkTP8aS+EkqAwJ+HL4aLtlJN53dIm4anI9aQQ4=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=ivU4lMF741j4mo4O5GgX3Og6QpYElQ8/i/VND0jNJLS14CbwIvN20e13J1VVkVFPr5
         CTYGdZRF7kKZ4usUx/gqAOYLSIat1QDNr19c0WxDcdHox6B2hq7nnNf8G+UjougNAGz/
         ldLU3mTPjeq2PeZfk0GEEEeqte+xkZoTMxjzYY9xNnHh55R3uoppmsbq+gqfcmjhDL7A
         gQQxHen5PGG+8ec450AJuczNQStr2YczwAqKDW8UD2iMNjZdKeYDb65TDSuV1netjKiZ
         ZsjkjbAWV4OyO79/NEhBEyDlBrDV85g59DSa28tpqZi1xng19906FTV0o0BozRWlOT6I
         hiRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788501802; x=1789106602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QOefjXkTP8aS+EkqAwJ+HL4aLtlJN53dIm4anI9aQQ4=;
        b=GNKI/bFPIbyeG0A2Jo8p3DTw0Q8vkOy3fNN8tGlEdTa760SBXNSk0PkA5i7u0bty9g
         FbhqesQ9NktWJjL5Dy66QfOJL4FaJcXbxTCkz4xpb8i5zNtRccwikFC97O7IyRZ+Hi7k
         rF5l8lbWxRbIC5sEH7iphcEJVjgJVt1UhU4CDVqwqsIKC4kazPWYVAy+h7RQiWGJKAYY
         pazJo+jph8yuKsjxTPsm85tmU0GlrUDPu7j6DJhJh7p1mTOQc2lIgz5bb3Y6qXsNsu/7
         rYEd0hbwHbUJyb1lTw3ca4uXZcjHg2PX//TnZoMSOruznYCPwi+3hK3Us9AH0E5P0j2G
         z7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788501802; x=1789106602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOefjXkTP8aS+EkqAwJ+HL4aLtlJN53dIm4anI9aQQ4=;
        b=WVPqppdbQnvF2ovYvU/OODifJdwSRT8ehMjWQKvG9NvIb9zPdy19MFZnN7Y5yv0uKp
         o7vzTba4MUjcwZqH24nvnFQMJ7smgGyBYu2DPSL7Q63JD7FfjKlR5OR4DGJpr6m5fq3O
         B9+aVkmPWcE0VLSccuyLBz27iHqLEM6vRl2GOnVAnLh8PW5D5FLvAzdmSTeViV7Ij+i6
         3qwuDBhwAHereW5izDCyOsctlV2xmgzVAjTbiyz15Nw00CB+9IjftP40gsqmS1CRWIbA
         t5eZm0Abzpy+CpDH/G8qtXQ5ZHoDsPt325xQIUU1Yj4cjh4d/OylkL82NCSuAdqbFnfU
         QdHQ==
X-Gm-Message-State: AFuF++lXPedq9etZmAUNvaBW+yw1Jnusvf3KhnX3wmIY8l1tB271eDIw
	zCCboeaF/4522dq0//TM6xJ8sYoZ6G0pQNJmFUh2HgqL7n6V/ZnSYTcuGmWV6klS5HjcWfiqn2P
	hkmzLlS1nG2GxuJIRo95Pk+lqUm9pRmfkFw==
X-Gm-Gg: AYBFou2wqkMf8/j9CZ+9XLSr76Yr0q7EtQLgjgtDPY40NcYHs+eCnFcSuTAgCeBcxAa
	R46HOTvbTROql+eB9ZFTU/xUCG739Zl+JrQ7DERPAC/Tu5WVRr9SI0f5fg2VW+1wrAy7iiOL73+
	vIBZ9tTulAWEWe2y5BFaPKZ2oQBGrpAsAZ5Q99FhXOabkmbteDNORxmPd3pD52eKFPJvuOZp2oa
	BYc0vl5HeJE3oyClDQEslgYS9lVL1fWjX+KBn8oEu5OcwHu9e0CkkVp/zuqJuYEUng+7bJ375A9
	KK11IZo9v3xJWmlunf2JMkBq9DLMruhJHlRe2bdOKBjyRvQH/sxc2gF7pbHiShFNoa4VaTxR07R
	GmVfrNBmZcVwhgQl5JpIMND40rJdGosVKe2eXzqzLTuNvWRMeMOEt+JRPDXTdwQ==
X-Received: by 2002:a05:6808:1b9b:b0:4b5:5bfb:f25f with SMTP id
 5614622812f47-4b9623cf7d2mr3115079b6e.20.1788501802027; Thu, 03 Sep 2026
 23:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjyp3f7mr.fsf@gitster.g>
In-Reply-To: <xmqqjyp3f7mr.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Sep 2026 23:03:11 -0700
X-Gm-Features: AcwNN1WfZUOffjP-ufZ9QHlsQ9AlqA_garkk63-ZAFbMkpTPcinVb8U4fr6DF5Y
Message-ID: <CABPp-BE+_YhTpOODe1OP7LWdEj9MKV71OCVSd+exWKSoh+1+2A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2026, #01)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 6:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
[...]
> * jk/rev-info-argv-to-free (2026-08-31) 2 commits
>  - revision: simplify mark_argv_for_free() callers
>  - revision: hang on to "freed" argv elements
>
>  The memory ownership of argv elements passed to the revision
>  machinery has been made more robust by keeping logically "freed"
>  elements alive until the rev_info struct is released, preventing
>  use-after-free bugs when options store references to them.
>
>  Will merge to 'next'?
>  cf. <apaSDqIEyc82Q_zE@pks.im>
>  cf. <apayIuf9kXQcQPvS@pks.im>
>  cf. <xmqq8q5ksvd8.fsf@gitster.g>
>  source: <20260901062815.GC1075462@coredump.intra.peff.net>

I think it's good to merge down.

> * tc/replay-linearize (2026-08-31) 3 commits
>  - replay: offer an option to linearize the commit topology
>  - replay: resolve the replay base outside pick_regular_commit()
>  - replay: add helper to put entry into replayed_commits
>
>  The 'git replay' command has been taught the '--linearize' option to
>  drop merge commits and linearize the replayed history, mimicking 'git
>  rebase --no-rebase-merges'.
>
>  Will merge to 'next'?
>  cf. <CABPp-BF1=3DDZAxX5Now4pCKPi8=3DcpXo506z=3D8QVu2vYCSiKdqMA@mail.gmai=
l.com>
>  source: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.co=
m>

Yes, I think so.

> * en/midx-missing-pack-fallback (2026-08-29) 4 commits
>  - packfile: recover when a multi-pack-index names a removed pack
>  - mktree: do not use OBJECT_INFO_QUICK when checking objects
>  - mktree: plug per-tree leak in --batch mode
>  - replay: fail gracefully when a merge input is unreadable
>  - Merge branch 'ps/odb-generic-corrupt-objects' into en/midx-missing-pac=
k-fallback
>
>  The object lookup machinery has been taught to gracefully recover
>  when a multi-pack-index points to an owning pack that was removed
>  during a concurrent geometric repack, and 'git replay' has been
>  fixed to not segfault when reading such missing objects.
>
>  Will merge to 'next'?
>  cf. <20260831231005.GA973618@coredump.intra.peff.net>
>  cf. <374bffe1-47ff-4cb6-9d69-f4b7da7292da@gmail.com>
>  source: <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>

I believe so; it was acked by Peff, Patrick, and Stolee.

Stolee and I did add some extra discussion, but not about any changes
to make, but rather clarifications about why the bug occurred
frequently enough to affect production, and more detailed measures of
the cost of the fallback to fix the bug.
