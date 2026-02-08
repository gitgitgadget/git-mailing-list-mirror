Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516F2FB0BA
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559795; cv=pass; b=t2B9jNgzvIJhGoRbvyeiFojaHhnxLDeTfFwZkbxOIifk+NiUvJzSawmgwMKttXmyBfk/qDFCSvogd+zEuCFYnHAQnQnBfxWw4px2f8UoBnQLWNa/5/C9qO8rLBH2tFd4AqsQqOJkKkjOK/yRF7/ad1GZ16JUlsVjRqG553Z0EjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559795; c=relaxed/simple;
	bh=9YgLAxuRxkS4y4Gioh98HvKnRCMSTmxCD1oGCH1gJUY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tslZoCdC7fI9hvjy39Xo1JS19ZjpVIRX/UprzAi700Fo6Olk8peVJ43mQ7wwWlrztDHLW8Jao8lzbxWB235nlc8cjaZ/k8di0rBSQUnvjIe9X7EfPy0w0/sU2vB+naDJz3kNOnR8r8+gk1v+7Yj4jC3m1YCL0ncY2vaKkjtgZ+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQiz2jbd; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQiz2jbd"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35621da1a7dso627866a91.0
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 06:09:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770559795; cv=none;
        d=google.com; s=arc-20240605;
        b=JNXdCD9aIUX56toSYOn9wCvBr+pduVS8Bkx+QAR6g2fQS0DQMO8b/NxfS1DCbDx+AV
         BraZOVWF7kssRZM+k65Z+JLAJwmr4Ql0WWDPbNP2joFbI/iuqGdUqOzLjEbATsE+vHow
         AzkHAiTM3zE9ejsGZI3TnhVWlYvRga1mRPrjEy8Q+Qiy0m5PmoBaDp5JN73FrkXrIALQ
         LrUbdoLTzDcUAGI8dUOquLTMZYziOyAjLXW9Qu/m6vxksH6lhvZ1zQQvCToUqoZZ6dJX
         0qpEMVxBfJ+WT8YSqsXoa2oUPRMiMEr21dy9zDpympsTePE9R69AivNLeftNlTR2p6CX
         qyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fL4D+I13ZwKy/CAMrafzKCwh7Apau6qCW4UWQzsXsR4=;
        fh=EOKr5JiIhCLnFNjaU4XylZy9/DVNi1uPK5+nd6CoT60=;
        b=XD+wENETjIVgn/lWXPfn+fxZdxlLGBW4LIxACZSRorlxa4rmnVgua4kiuFU+yozs66
         6W/CKFjSsPoMIrPk6wM4kJmJhu4o7V3x6Os9ib80g4R7b8neC3FwFMDV3u4Ya3UDephN
         3NLpS4e/Wbvmg0VggSNPQ0Q0MaNXVWzEXn0Fy6jZx4ZmI4j7kmwzT9Uwd+7AWp5FYEyP
         /m5U2fiQQZqR5zIZt9Vh3maPJBWA5dxyqqtTQZc0wUJdf1wYGfY6Dio4o7qLx58xWOhf
         kxB0xwqOzgclCLOdsfnAQvyGEAUsLGFJWjP3WCtDwOyxnr3zFU3AVAGp/WFm054uYNE0
         zX8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770559795; x=1771164595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fL4D+I13ZwKy/CAMrafzKCwh7Apau6qCW4UWQzsXsR4=;
        b=bQiz2jbd0nDPI+4NbdrQaeu23Rgf9F6366kMf9ql5KqRYc6Nz5gc8sUTE77XMy0x3i
         vtPp8FZbJ00mxfsmEzhMLBUZiWcNseKWgNdeyLW5WhgsgqqlklunN9xNEFm0AhkvXCWA
         RG32HBkslQxOUWxzx/BMCOnSgfs+LYZzYA70IiTs0kJCoGYeM0O9fJmB1MLOMyqhd7pe
         ts5PHXAGtyIHlEBCdMXcvNV7GgtBR1aDB2f6RwcPkw5uV7xNtqLqYqLcbYRFaigQJ0Js
         QtD6LpQO4NBSX1JGpPtsnyCd9I975JjdO3i1mPfpYkNUZR2Z2WI8LDThrcKZPGPbSaMq
         5RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770559795; x=1771164595;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL4D+I13ZwKy/CAMrafzKCwh7Apau6qCW4UWQzsXsR4=;
        b=QQQtN929O4WUQwBd54pVnsVtGhfFOj668w8zEpRqEkDBt7FNUoUyX3uwD6kF1TPz2v
         AtmwkaVljWLpWtYHwDJbpAMuz1dCq5dHtBQ2AVz6lQ4YESWH1V0UpdsXs+rSiaMkYBIZ
         GYjv5nr+NyjSlLaBhxsQQCqKJq0muNBrTkVDCYXyLmugWp2uIxAvWLOACJD+Wl/4+/VZ
         jlj8h0oNm/rTtBIGImsya2Vm1P4nPPes6Pp9X+iZtcEbj8WrkNwUkYNM40ShiIT1Vdg5
         W2Jg1ryyEAM2LtVeRFw8cMg7srrvypTcBJ6iT6OEAOjDqmN2HqdckH6yz6I8vBr+Hnd9
         Xb8Q==
X-Gm-Message-State: AOJu0YxNmA+RYYQ1CwfdXXsOtyt6H3dqUcEoZzLsJns+Vneq7A160y+q
	h8M0OP8K5snB5NVACDfKpm2aGvBfVp2oUoyoMkOxg7n48C9b5jugmG+68WStBKJTvbjAnKH0opI
	rpFTSzCeMJ6ivVxoYBHNyUQVuo5Nk2tK8+fQc6Mp2X9RGjNc=
X-Gm-Gg: AZuq6aLODsjVgnllJA6kYggZJT3hc9DzunM8h4fqwBKvuPYGjKxzMg5rNyTpROQLx5Q
	6aQ4pYx3KOBvl5mnPDKzuQVcCnD91mAOVykBNyXEUCZ3kk0V6oimYeEhXre86Z+koSSCHFrWadX
	mAW5yxL4WtCHBls16dqQ6RLnqSBE3fwvazRmvlbkkKe035UcRJrSEolKl8mIvHD2mCcJvBZ7MRH
	MinBCoUdA2059QEdWWSJo22ry921RA61HxgH2eD5p4CBAU0Xvj8KSCekyf3CnUdBSzM/PPKlhnI
	pzVGzAss9QoN+sZxAMqdJipOpB9an+o2OAS3mZ9JJ/3GhxGSZBzioqSxRyJYSH43US1T9+/mZcW
	/AjSROzc2N95kr4q70EE4sTVzZCWHMhWhIfRv+eYDMz31QCPP90WgZ2YtoyS/9daMOUU3Vya0bD
	AZ+uwmho1W
X-Received: by 2002:a17:90b:4f45:b0:34c:9cf7:60a0 with SMTP id
 98e67ed59e1d1-354b3c4187cmr7418042a91.5.1770559794640; Sun, 08 Feb 2026
 06:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jayce Cao <jaycecao520@gmail.com>
Date: Sun, 8 Feb 2026 22:09:43 +0800
X-Gm-Features: AZwV_QhdvSTOO-Sieam4hFZ7BZ40ZOKqg7pQQE7E1GBqoOVhJa_YrGrwBf311lc
Message-ID: <CAGwx5_8X1O=eUycHRm1u29iJmspeF2bX0oO9E34iUt_rS1W-Hw@mail.gmail.com>
Subject: Re: [PATCH v2] clone: fix segfault when using --revision and v0/v1 protocol
To: gitster@pobox.com
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, 
	Jayce Cao <jaycecao520@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Junio and thanks for your time!

> While your change may skip the code that segfaults, wouldn't it also
> stop noticing a broken case where .peer_ref should have been set but
> didn't, even when --revision=<rev> parameter is not used in the
> command invocation?  IOW, it is better to segfault and draw attention
> by Git developers when a valid input is given by the end user and our
> code misbehaves (e.g., and fails to to set .peer_ref as it should).

I totally agree with you.


> Wouldn't the correct fix be more like the following?
>
> - split out parts from update_remote_refs() that are needed even in
>   option_rev mode into a separate helper function, and call that
>   from cmd_clone().
>
> - make the call to update_remote_refs() conditional---specifically,
>   we shouldn't be calling it when option_rev is in effect.

Do we have another fix to make a conditional call to `find_ref_by_name()`
when `option_rev` is in effect? Because from the doc of `--revision`,
"... and detach `HEAD` to_<rev>_. ...", that means we don't need to
know where the real HEAD points to?

> Also, isn't this something we can specify the expected behaviour in
> tests?  Not only we want to ensure that nothing segfaults, we would
> want to make sure that the resulting repository has no refs and HEAD
> is detached at the specified revision.

I'll add several tests to cover the bug after we make sure how to fix it.
