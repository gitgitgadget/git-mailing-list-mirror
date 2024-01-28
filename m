Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB062EB14
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472179; cv=none; b=Bp1JtHdcPd5J9VVZflR2TXo3c1WbYe+0pNZU/aquNNEYlWQ38shNxf/eOvDQlhVa9cDo4zBiqZS4/8lJg23BGa8Z7PxzKTf2j2TGG7WiDIwYb530xvPg/TluCFp050GfahdD7OTw1pZiVSh8xOJTiywJh/R3Nl6H9o7vza4E1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472179; c=relaxed/simple;
	bh=y5LQgRovUqo2GZNBDwoXA5VBaE4Vfofm08ND3592y1k=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aM5F/2smw8jc7P1aQmKR2quMzEjeYhuF3C0v1RVceRz1UOu98zTOhT4fIfOd7HBEyJXBD7aKK0MnC273jeMkjTXE58W2gOV4KXpviqHteba9r+iojwbL46APgkhBpiBxIQwgipA9SugLqry/c6CMVLBTmtnKYs61B9dBgxeMscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL3C16hG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL3C16hG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso32753945e9.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472175; x=1707076975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O0RbnxWmwwrKP4Qd1cXvfXgDfT/wMIFUG9zQB+KPX0U=;
        b=OL3C16hGUmDipI0AftVv9mMHPWXdlXrHorFKtyxddhwOkOfagDkQUyRvWV9HeD6cKR
         qf2hGVfPsAACGj//eR9zn8zs80QscJuIjE3VZiocP4Fz4IylVWY0dXX729YqL4o2mP0j
         sqP7vTauZclRT/I8esaqGB0GposAQbLUdgcToJwPu7ehtZLDpR7DStlqR14EJsgEZhR0
         sMUK2S1L/mk9Bid5lgJC8fmGehmhvfs9vR8jFZgxLxGiQ+hVWhmC6jD8qteZn9C93LN0
         ze76JQqBASLy+1Gx8DtHI1wUTDWNXsXUT2usLfAKt9HgUfQ/RU6/WT6zeNL22XC8pXbn
         rYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472175; x=1707076975;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0RbnxWmwwrKP4Qd1cXvfXgDfT/wMIFUG9zQB+KPX0U=;
        b=G4HFW7wAaGUunObWOykob6NCrySFSCSELA2sazdSx14/zyMLNMvGdvc5e1+FRFAcPb
         vehlC1OY1pvNfX9Dyl0wJ6mZ0o/ZKghJ0Y6SsywHZHokJLMOPzDipdi9gr2OkU4bvo7F
         AueWElPzRBkPaDfkxti9wVjR4YCqa6wOcj06bBZKYvVKQz9c2n0LRV1HFjcLc9kByzQK
         OMypSrQd4Of/pqUTrndQ8+q2GHKzBBlvDy2avcPodvzUgp/71bI/FyphKcdZFLRkdALA
         zOHcjvAjptOnrxurNk1ySek9tJ/3KCJtS2hmA3wvqrjAhreBocpzJDy+OXpyZTNaDWEY
         R61w==
X-Gm-Message-State: AOJu0YxM8jdXwbxHEku/H2AZMhHjy7lDhKNUy0a0a2/lIdLebwAYlU9+
	OYKB0xuHPW7k6DQCNSB1pTVPQjkPaPOL6WlWRf6Z0ZcokcKIozUHhevUfeaU
X-Google-Smtp-Source: AGHT+IG5dL2TvUPL/nSW1Abumyi3ZUyYiKh3dvaKjEcDSGaSjsjGL2hw+TpbDo2UumUvfOd1euIynA==
X-Received: by 2002:a05:600c:310d:b0:40e:c564:6ef7 with SMTP id g13-20020a05600c310d00b0040ec5646ef7mr3674116wmo.25.1706472174808;
        Sun, 28 Jan 2024 12:02:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c34c700b0040ef67f1f52sm1396359wmq.7.2024.01.28.12.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:02:54 -0800 (PST)
Message-ID: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 20:02:48 +0000
Subject: [PATCH 0/5] completion: remove hardcoded config variable names
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>

This series removes hardcoded config variable names in the
__git_complete_config_variable_name function, partly by adding a new mode to
'git help'. It also adds completion for 'submodule.*' config variables,
which were previously missing.

I think it makes sense to do that in the same series since it's closely
related, and splitting it would result in textual conflicts between both
series if one does not build on top of the other, but I'm open to other
suggestions.

Thanks,

Philippe.

Philippe Blain (5):
  completion: add space after config variable names also in Bash 3
  completion: complete 'submodule.*' config variables
  completion: add and use
    __git_compute_first_level_config_vars_for_section
  builtin/help: add --config-all-for-completion
  completion: add an use
    __git_compute_second_level_config_vars_for_section

 builtin/help.c                         |  7 ++
 contrib/completion/git-completion.bash | 90 +++++++++++++-------------
 t/t9902-completion.sh                  | 21 ++++++
 3 files changed, 74 insertions(+), 44 deletions(-)


base-commit: b50a608ba20348cb3dfc16a696816d51780e3f0f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1660%2Fphil-blain%2Fcompletion-submodule-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1660/phil-blain/completion-submodule-config-v1
Pull-Request: https://github.com/git/git/pull/1660
-- 
gitgitgadget
