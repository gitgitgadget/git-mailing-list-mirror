Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899935977
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902990; cv=none; b=OMSMfPXGoBNihPA5QNbJKmIyvZTEEKnZHnz8jPtlorUrtY2OYW/hRApeHYIehHLN5e72kHEKy+p79hy9cCF5YWOGobNHgvJeqClmiOQVJSojenHDy70sZJAHfie4sKs7n+pEu0lz5r5oaaKEXwifST0jeiW6kHFUXmmuyZdnEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902990; c=relaxed/simple;
	bh=5bjcD1nEHW/bnp9/jx/U/pNrU1DE0NiTx/ERcBFu8hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXfeBPJZo9OHAoEOXc8C/49SKhmqO34JwB1mQ1FcPQWdNg+olVK3+7cRQZ9Yp3OHBwYT4xBDjuCKxulELi2D7rGVPwixINgveq+6O7NQWgog4njeyiiWgw+Vg/u9l3V1vghzciRmZdV0PIpZWlsgniBmHWqoYs7jDDww5OsqgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7+66f3z; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7+66f3z"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-659848c994bso2658962eaf.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765902987; x=1766507787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HIA0qLnZ6YHVFzEtzqQl6JbxDTw9pxZblzYhMH1Q3Q=;
        b=D7+66f3zgTibEAoKFsLe4DekUOE6/PBxdgq2jtJjG/Ii4kEF2eBT6gZLa4gpuBUHdY
         OtZ4eOl2x0t3059mmfATbr+zAtsQQReAwx5oB2T7GXCU+UYp+e60ci2KbZMVYjxx2LAk
         PHvZXwSTHMQqZLwncTEHPPwD5nh5qwoBMNv9PxDm8TgvHs7e0d2eV1YXQhrjSEjBJAQ3
         SCrXCd8uLt7y90h/JsKuVzrGU7ULF6iOWxv5wgvcGFBO90PUbQ/YrAhJKzoP6mUHkafn
         SDvWmHLuDISRy/uipXczDRNH4zz/j77crz2XZOQTcvMHp7Pzb+d5gkKhgA0UnKoGNAsX
         mcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765902987; x=1766507787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+HIA0qLnZ6YHVFzEtzqQl6JbxDTw9pxZblzYhMH1Q3Q=;
        b=MzMHX2CcNnLIG8xf98ANuRH9bk1ZZFjrI8UnLJjykIl5qQjVl+nR6wtX/lL/IfiZQL
         MwDUaQPCejhNIOf8ddHfDhWuD6HF3ToGS39o/yb1vqfbyD2XgZK/nYCJ8FgyeOF1qp3v
         1LSG2kteJAqrBn13kooiCCHUWerrgOuYb7bdcGHCj2syf3y2Cy8XHKz1YapPz3siK0F9
         yqhsXx0X7A6IBIqxjyMLU5eji5P/jbrYa0IYMIyHMLk//7DSYiBQRr0SSAsWBVqDIct0
         xb97PD+L+vX/VaFQY+zRNEFmh9SYpNBsZMStzcExqAwSbtX59NYmIQjfAy61Np6JyVkL
         WuYw==
X-Gm-Message-State: AOJu0Yz0lsYcNIkmd8hEnKt+inPPMmcickzD1wC7iYi178MAtUxciWNw
	W9m5aOCHWf/buXz5m+KuM6kkjt1I+oedhs4BQ+eV1lfvU5KVgrGyAXmSbpMknS3VpJrb9REch+A
	pYQ6LUGR9v3CufWa25Ug+K6UJ2VQTgSwZVg==
X-Gm-Gg: AY/fxX5geIuRgptzNGAYDoMh22M/cQi9zQIciUjDbwJ0xEilvKnB97TLFokcNSgTU8J
	0M1bPPRITOKdip4V38w1U05DbIImzE3pPOCFEdB2EuY8ROfObXKGHwu/kfNboh7tr5BSZlBNMa0
	YfCYEZKL1+Rq4fMhhe7Z6sffbb7BFjcWrDpYmDrJ7dbZpcmKcofGiaAC3FmALz6w9q9kPcM8Jqa
	weORkhGstdaUHR20CHhwehfZ8Gu9mHVG08dgcM8EouvLN7vre96eSJc4S7ARGR4/T61oQPVBe30
	zVIxuRm1iEcqcKNwE+MIuLx6kGD4
X-Google-Smtp-Source: AGHT+IGg43k9GlpA3RJTLb1fdJzUc28Dj2DtLNhy/2prbcjTyFmL3C1Fu8Oyz61YpmfBfCd6wisaqmAZjTTmPHaT5d8=
X-Received: by 2002:a05:6820:a05:b0:65b:39df:8066 with SMTP id
 006d021491bc7-65b45257f99mr6176888eaf.42.1765902987501; Tue, 16 Dec 2025
 08:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
 <73ba74b8a2e7aaa625e6f0689a9f900ceebaaa03.1765894781.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <73ba74b8a2e7aaa625e6f0689a9f900ceebaaa03.1765894781.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 16 Dec 2025 08:36:16 -0800
X-Gm-Features: AQt7F2o_rV7yqLztV2xcG87xaBL-DQTmwAl053vYTkAUqqI4f8u4c6AoqA8x9C4
Message-ID: <CABPp-BHH2NaLc9tFmO1hKcY4O6jZJU05+65viR1T_yBaarCwrA@mail.gmail.com>
Subject: Re: [PATCH v3] replay: drop commits that become empty
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 6:19=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the changes in a commit being replayed are already in the branch
> that the commits are being replayed onto, then "git replay" creates an
> empty commit. This is confusing because the commit message no longer
> matches the contents of the commit. Drop the commit instead. Commits
> that start off empty are not dropped. This matches the behavior of
> "git rebase --reapply-cherry-pick --empty=3Ddrop" and "git cherry-pick
> --empty-drop".
>
> If a branch points to a commit that is dropped it will be updated
> to point to the last commit that was not dropped. This can be seen
> in the new test where "topic1" is updated to point to the rebased
> "C" as "F" is dropped because it is already upstream. While this is
> a breaking change, "git replay" is marked as experimental to allow
> improvements like this that change the behavior.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Changes since v2:
>
>  - added a couple of commas to the commit message as suggested by Junio

 - also changes "can been seen" to "can be seen"

I'm also curious if you are keeping the "--only" in the testcase
intentionally, or overlooked that part of Junio's feedback.


Anyway, this round looks good to me.
