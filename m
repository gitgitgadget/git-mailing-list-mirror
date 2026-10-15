Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4784EC657
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097570; cv=pass; b=gwjLNDaaULaJA0cKOxO20dPlFQUo48r7XpI6Megg5BeHW0u27z6EQww4o0iz+ZU5MbsNIe3xiCFwdxwvW3k18DEM1+Gth6EO0twOrT3ZlpiLZQHJHRnNpJ7nJ/tpVanVGxiRV7udyVJ1sDTRr0C9+kQB1eRomMu1zPFGMTBdnF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097570; c=relaxed/simple;
	bh=NHa52vVMbzDEhTmVNtIfZfPseYbmt8VZ5F3Bb3C3Cmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOhWU03hc9WEEpZ7zNj9/szDvvSjUT+J+A47SkRLFnQhjaeoygpDGKVtOVBVtetb+ygfPBFEpdWefZdZe73UYFMcOyamS+L1fKne8q7dpHpX1v2UKbhRhuHpQUPbPvS41dSQWiZVmS2HoxU699vinKErK7ne5cj+S2Fvp4zGU5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih1lVHja; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih1lVHja"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso904604a12.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097566; cv=none;
        d=google.com; s=arc-20260327;
        b=P4MNKGyfToEwBeqsdTCBMQSjxNMUyNPgSQLdQuC+ER8E74C3yzh1PdHXZsMpqWPYjx
         u+TEDeVfALDZQC0SGzmdZ8BS9LZEooEY+VFeqK178ielPcefcuAhqedxqzQUXMDgloUH
         LOxO90YLACoKAZiyM1RsMk3JenKZMmwM5ymjXoXutkNMUoi0RL4P5NYiimqxmD3cn9QK
         b6cXaN944g07Sv65aLEzd1hgWbUetOfiIPMK60gjNB+WWXzXM34gAHw3oGl9/GSVi35P
         e0AuzDgJwxiVTQU8WEbg5IfmWzwNk7rk3YNukUc/3+/FbliwEBA6vkRyd0Ej2zZEoRKC
         FWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NHa52vVMbzDEhTmVNtIfZfPseYbmt8VZ5F3Bb3C3Cmw=;
        fh=8KVHYsQo7SpvtQKH4KOhABWHBpdVCe8lMQmYQdwqDkY=;
        b=Y9DbxZC8EF/YY6VW3bkjUTaYtJp5mjbN7OlOz4FWgUpNf60ac9fkHrEtxsjxtVyeup
         x3/QOwScPM67tiT82squyoWE4NIaxuvPsWJPdkMMSZxI8smJj0rnf8W8rkhX7aKRmQ7u
         2ouIwwSNv1LstRZh00SHfkUA9LdQj4mwiQvwSajRoJyON2xiYjqL90epSH5sJYi16IeO
         bGCdzoJdPQW+ZSkCWsX0vZzJ7w4RN2tH2h8IdIQuC/dhQXwJRspKKZwTGMGikMXb9wrQ
         +BGuwNPRbpiu6/gheWftnOG80bS4PoGGED+lMlX93ENmXzwqRqg5gfKidPh/GukilGSu
         1XRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792097566; x=1792702366; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHa52vVMbzDEhTmVNtIfZfPseYbmt8VZ5F3Bb3C3Cmw=;
        b=Ih1lVHjaZgyglWUGqdImg2A3DQgipX0eYtLhPbebp8VnjSkSGRXaTvLfEfLwEuj7m3
         36UFaRN1/ouUM8QEarvMFHy3aIXlULOVXYKblkx8h9MmnC4+Oz4ALmJe4YuNYz/K+oF+
         X9uVQwPyO9VlG2eywWrUf8bi4tXYwcshBO7FWxpGwQqjjyFLZz/xE6vnNqSyI6QdBiFy
         m14xczAK394EdWeAV+3rNPBjMzHflUu8mA4bqrJdQ1d+SXFOEV0jW+Y08E7A1iivybTS
         eFnjTPmgbjsmlSJX4tINPDHxjf3zQAEz+0EYI5FjDmYfsfzOp2LRKB+PgrkpQjw7L0Cd
         Mnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097566; x=1792702366;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NHa52vVMbzDEhTmVNtIfZfPseYbmt8VZ5F3Bb3C3Cmw=;
        b=ejF5yzncAepEhZhDEEBaf6P4mNPfhkX6ORT8+7nE4jJgvlaQjiO9PvaRHQYrBFQJF0
         rBWekE8nA9Z8QjK7Wc2rqgBV/yWmkWOcIdzRLs7OE8xSAm546rCb55D+NMdaUZ7CTzI2
         qw1KrcdpFY/wG9gQALO5zN8Ngg0ysHrIhPcJqNO1N20V/NNUikgZuIp6rivkdp9vZg6P
         Qx5ehEMLsxt2zKCdaCl7sdaNKjfDwnG8IrmjmwJPXreJ4pgSUlfNhWiHtRmez1LEoLQh
         eaULhHighEVmdlDlZ1OCC8yjvjr2h75RKfXuwKs46v9F6MepgoYAxRd5V/uw39shOXII
         yEAg==
X-Gm-Message-State: AFq9FYI0+x+eYxveGEcxo+Q6EfAutLdJp4zqL8IMUre3odxgZTkKQgpz
	UZOtYwzk1c9VbC544b4I7fT5wrJXCESBARuWaQyaKjk6HJUH+8s3lKcLEJBL9Y7fWsFGrsaGwKk
	cLNnsMdf6y3S13rsJkNyy72xm0ec4d6s=
X-Gm-Gg: AYBFou3tIJbceDqF+j+frr3ZsAKBXfPE1eR1R1tq+LatgcLjGzenvwIJJ1JLHgLq713
	AGhPoTaLCbxXXDUIcO+ZDB4i3kS1PRnMA/A7aajHOMBJJXkkthvIPD8hCnPOUBpPU6YyLM7/PYx
	GhSsHhCzomcVsMPCuajR8Xp+P2L+fHTSQnU9pa7YV14OkM0HmbGaEGIiGAT5yU0auyC7yHIGXZn
	a+GJIVBPfEn3gAG9pxVJVVt2ZjYgDnlnebOsu+TJigUMr+O0rotqjVS85cqeDeRrRynXYztVzb8
	zVrYBpgl8UqgToH7yHUKCydJCADlFbOSbgYH6DGq103p5/oIIc7FOnM=
X-Received: by 2002:a05:6402:a61a:b0:6af:9a8e:56e2 with SMTP id
 4fb4d7f45d1cf-6b387d46c15mr647971a12.8.1792097565786; Thu, 15 Oct 2026
 13:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <d95ed5bd679cea41320c39824b969377e8c88e09.1792070038.git.gitgitgadget@gmail.com>
 <b55b6643-b9a2-4e41-8100-2de545004845@app.fastmail.com>
In-Reply-To: <b55b6643-b9a2-4e41-8100-2de545004845@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 15 Oct 2026 22:52:08 +0200
X-Gm-Features: AclHuK_sFKI6aojHqqIXT_2cgvfjpEQzJ-ebHtv1YupreY4LwX_wGX3l0dDr3uA
Message-ID: <CAHwyqnUATY3chz+Ryz9D3fAmhbfTOr36pbNa_xLkT5yBgVWjyQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] reflog: name the strings that mark switches, renames
 and rebase steps
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> [snip]
>
> The context is that you are about to use these prefixes in more than one
> place. And the principle you are following is no duplication. Then the
> details follow. If the details of exactly what they say is worth stating
> in the commit message.

Thanks!


Harald
