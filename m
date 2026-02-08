Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351935B659
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770564357; cv=none; b=fh0gyzDpazWlbVJMi7hrSgSluO3SV7YklHgg93wf+ZQACmp+KzrD3bJpls5ykX7a8crKRDR7BK8u2tf9vPmPcE+9cmfKf5fJTKi+IsL4+hIX0ZBeCtA7JOE6I3MesoMF2fBYS7F/MiYtptbBlsGpTt+JaBWqFbAuN6Mvmwz4ETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770564357; c=relaxed/simple;
	bh=zY/tqHpY3x694cyhQv35JO/t7mdB6C2m75h5yX3Ijo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHSup6rIKXvy8ptY+VUXrHGYjVY157qaR9PxM8tzNSwX0hKvoh0lVtb5dnRgzaAz4oJN8TxZfdEmnyxIx/hh/d1NofM+iW2pdd8y9fGGv89Da+yp/Z4QJfnILjaz47P3gZpcREW6nqqLINlb7uyndYmmcyJafJvjPiZaaAnHV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYU4gqht; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYU4gqht"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6c67bc8b9eso1398167a12.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 07:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770564356; x=1771169156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyRluEm0aCFFn5eA5dnkWunAQS89njqR8EyStXe1gUs=;
        b=BYU4gqhtMBKTuj9H2rDcd1yUShUUheGPobE2SDOomVuKUtwg38Bd7JX33QmDIa3ZJ4
         DTAP78x9zNa+v8yJHvGEJt2V3DIynopra5fi6MFtPCRTA35dzaAUVk/OgbJOpYsN9sAq
         ohPmdk3M0OeprFg073kKV6AYOfu4uqj+Yk5rf5cwrT07AHxxlb4QkokQovshBw6W8EFz
         32wzqRc6IYES6IYHa5AxM0QOhI+yjjLeSr5HEkaNISd4qLwZaN5nuA1j0nPOnRSwXgej
         taV6wr7LHHWjgOVVo23RJrAhy9LeqxElVExbPUZ34NPOZJIbmbo9Ci56VbRU6567VTYv
         Tw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770564356; x=1771169156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyRluEm0aCFFn5eA5dnkWunAQS89njqR8EyStXe1gUs=;
        b=Pc+5fw1SVxj2bWmasPwVbTGLiwM6x08/1IsUKDbgHiciTFuQL9+EEAksgc9pcY2n4I
         0aR6j0JaWCvWBH6TUUn8DVGnYJvOTf3fDCXgFtVOHc1FVieSMwLE76TsW5asgPXuFAnM
         Rf55387gl523fMn8E7xrnSQdhwMYXwcV/zf2Wl/t2WIQQvw5qwdccufnlisETcVy57bm
         wpeCAxmT+OVn+jkJK0yss9dLD0PBnFj8Ee/72RGIq5D1X83z2KOZTH2GgLmYu3t84SRT
         Ac32mMlZaLBq3Mbx4NcOTqT5aI7XF0RUhU1/3M6R8hfskP+738z4Q6AEalL58hnRTc4z
         bLIg==
X-Gm-Message-State: AOJu0YxexP6mUWBRbPs6JUedSaA2DsDyzjUaMYDibhAbdnZqQod0aV6t
	u2DvuxwXClDjFpV5VvFOWrUWDRXh7psz6SQpPsC/+vOeEctUT3tHpJGY
X-Gm-Gg: AZuq6aKiCBmuuC3twTAErRubdcodlR77FvWxvjRMq/J5n6Y2vhVZVbiAcak4F2nDP7X
	whOf1HJrYsAZ1HAxHyZ5Dmb7uAkMT4T3neze2I0vc718g7xcp7cAPmNO0r/cB0kZlVS2533AZQA
	SBqB2m1z3d5+xOqOYrFR09dk7ddv1mRej+FklZzqyrV8mYJ5LvmE5wOiTx3MAgge2yFlP3BwP1y
	Q8YWFVfl2XJSwpcWyy5uikL7tbEajznYiupTTh7AV5fYcQ06TOfdywaeTgwz/t75BFzeFFqkcBn
	noymXv5/rCrMWLKOYbfZTImeHqJPMqYYoiW+GXqacgufLkcB/JUdbxt+IbJ7rDVa0yArp8b3E27
	2gNYDEc3OW4w3hwS/s54wJZjPSlrCYIW0JJnZ/U7gupo4Eq13DeWWgtmeyRu9UPKLa7WdZF6ZLM
	i3fSzvsE1KlOKoDlFQI5nNnHd9GwzRHlmdtuPDjDXl6IfO50zwMhJ4vYOPONWmpaVZlyDmPu5+z
	C1U7mkN0FVvTalARgmuCmRb77PLNpXJllvBIO8PT1yclYMyZOidmqKL5MSYxGyNmPfCfIAci0Km
	cWMknRAOGt9pw2L3+7fjvDwEhJC9W2QUIiIxvc9X
X-Received: by 2002:a17:902:f651:b0:2aa:d647:b3ed with SMTP id d9443c01a7336-2aad647b56fmr31449965ad.34.1770564356045;
        Sun, 08 Feb 2026 07:25:56 -0800 (PST)
Received: from localhost.localdomain ([8.222.234.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c4d8dcsm83667015ad.9.2026.02.08.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 07:25:55 -0800 (PST)
From: Nitro Cao <jaycecao520@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	jaycecao520@gmail.com
Subject: 
Date: Sun,  8 Feb 2026 23:25:51 +0800
Message-ID: <20260208152551.93473-1-jaycecao520@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqfr7hsk63.fsf@gitster.g>
References: <xmqqfr7hsk63.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio and thanks for your time! I'm a newbie, sorry for the last
reply :(

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
