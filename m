Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D451E51D
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726930746; cv=none; b=csq76J9QQXcZnLL8bpv2JxR+008yOMk+fKsKVt4JbRuArzP2DCuiN3bU07L1E4keo+LdK/9W3QOZSVjY37lCAVdDkWXHfXa5okA0o4AH+l5y1ibiG3LM7tFkJ26tKT7jGp15zBKhwMjhkzsGoYnnrQFQOujLMMtA3LlS62wwbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726930746; c=relaxed/simple;
	bh=IEhtDAZDPcP0oaPrD8PbIN8XsDs1scYcWPWHWH4FIaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJNEkv1vLBbb4IepQeu9oVZ1ZRWkb1p1JFUIIWGpVs6Q2Vv3WJ1TbR/BnMpWflw8QjtrCJ9Hf8w6YZExb8MpLj9pBs6spV1sPzPX4x+cLjZLAFe1eQGYhSkqbRwIXYfD+FqEx9n3DXueGd1EGc3/iNDNNX5TBYKOFU6qilYv9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOqbiYYg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOqbiYYg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374bd0da617so2005656f8f.3
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726930743; x=1727535543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr+X3zXcaTnVoULtLol6dXlmTFE8c5a5O3NG4V9jRiU=;
        b=cOqbiYYgowW0dX4724txHfmAUCHRfjBHDKi/LkCFz3G10h4yumLN4WzP9TwcElCOxm
         AKbqtx0jbKZxMqNkM7Z0CljotxYT1GhldWoLKvTiA6yP3RkIygIN2BfRPl1fxmEIvhAX
         ARQ4fwb0M6gEN2PkdtnIlZ0Rbu4jWtR1e0aHs2296DiG/OkpYavk/aKFkSZLpaiZS2OX
         ib+oK0abtYRAYfk4AuaANQPMRgZmXvKle66u25YB7vzVhywsFhxFiYZMxY3+Gc9G6QOk
         l1lA3mqWrLFR9a8m1yLqKHAi9i3O+YGyNI/osmI+uVWVx1LS9QOChFjRQ4vo/3Vvcaru
         VPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726930743; x=1727535543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr+X3zXcaTnVoULtLol6dXlmTFE8c5a5O3NG4V9jRiU=;
        b=d5UHP70S/Cp5Rq3KxBMwCiMzVcrhPZFlp/YKb6X3biZXdb4aU/mSdkVwOW6ANTbdIb
         Y1fHgaJ9zw4FHqkMSdK6bUHldYzOJgGmuGM8KXO0yVtXkrM5VPUvzqZc/WIxfLNa109u
         Y/PSMIivo7OmYq8sUc5+EFWdFyu/Hs+DMMcAkF/F62R7yCqW+9oQpmguZLssD1fSEDFi
         Cy1a5qdrxTDp3gmzNqG0nRKqhye5SBK01/MJd61JTdAJz9DS6dXsmzb712NseZyduGch
         q/LDeLGrGx8i0M2KZseYTsRtvfYA64wMk64BS053AgzeLYLRZQtZ48IRbBvGZ7e7bEmL
         v6Lw==
X-Gm-Message-State: AOJu0Ywdy/zmpC3pOKGbhg69o1X5ghADePc2YU+W6Tv73+wMFQ4sjvnd
	ehCI7YE20W8UydpyCo1GrdpL7Y+xwJ4Ff+Hr+BfHS5qZBvGIIbbHDAJFdeP6
X-Google-Smtp-Source: AGHT+IHmGbFoyAdFf4nVwVuXPpjWT6TplUY9lRAAjYSu87zd041ZWdai58aHYwYbUM1YFWBB7e1ANA==
X-Received: by 2002:a5d:4f0a:0:b0:371:8f32:557e with SMTP id ffacd0b85a97d-37a4235a22dmr3647387f8f.39.1726930742380;
        Sat, 21 Sep 2024 07:59:02 -0700 (PDT)
Received: from Lagertha.triskell.i234.me ([81.56.75.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99ebsm20260617f8f.63.2024.09.21.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 07:59:02 -0700 (PDT)
From: Francesco Guastella <guastella.francesco@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	guastella.francesco@gmail.com
Subject: Re: Re: [PATCH] builtin/worktree: support relative paths for worktrees
Date: Sat, 21 Sep 2024 16:58:57 +0200
Message-ID: <20240921145858.1987-1-guastella.francesco@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqikupbxh5.fsf@gitster.g>
References: <xmqqikupbxh5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you for your feedback on my patch.

> I may be misremembering things, but wasn't the use of absolute paths
> a concious design decision?  
> 
> When the source repository and an attached worktree know each other
> with relative location, moving merely one of them would make it
> impossible to locate the other.
> 
> On the other hand, if they know the other peer's absolute location,
> at least the one that was moved would still be able to locate the
> one that did not move, which means that it is possible to find from
> the one that moved the other one that did not move, and teach the
> latter where the new location of the moved one is.
> 
> The only case where it may be an improvement to have them refer to
> each other with relative locations is when both of them move in
> unison without breaking their relative location.

Regarding the design choice between absolute and relative paths,
I’m not certain whether using absolute paths was an intentional decision.
Your example highlights a valid advantage of absolute paths;
however, this approach is not without its limitations.
In my cover letter, I mentioned just a few issues related to absolute paths,
and my online research revealed many other problems that could be mitigated
by supporting relative paths.

To support this, many users have requested this functionality or have created
scripts as workarounds to convert paths in Git-generated files.
An example from my own experience is that worktrees created on Windows are
considered prunable by Git because paths starting with, for instance, ‘C:’
have no meaning in GNU/Linux environments.

To avoid breaking changes and maintain backward compatibility, I chose
to extend Git by adding support for relative paths rather than replacing
the original behavior.
This approach gives users the flexibility to choose what best suits their needs.

In my experience, having the option to use relative paths is essential for
effective worktree management.
For instance, not having this option has led me to avoid using worktrees
altogether (up to now, at least :-P).

If it’s helpful, I would be glad to enhance the documentation to clearly
outline the pros and cons of using relative paths, including
the valid example you provided.

> There may be problems other than the design choice I mentioned above
> in the resulting code after applying this huge patch, but as it
> stands, the patch does a bit too many things at once to be sensibly
> reviewable.  I cannot comment much on the implementation (at least
> in this message) in its current form.
> 
> For example, the refactoring of t/t2400 into t/lib-worktree might be
> an excellent thing to do, but it looks like that the change to the
> tests alone deserves to be split into at least a few patches (one to
> refactor the test script without changing any functionality, and one
> or more patches to add or improve test helpers, and another that
> comes with code and behaviour change that add tests for the new
> behaviour when configured, or something like that).

Regarding the extensive changes in the worktree add test suite,
I understand that this makes the review process challenging.
I consolidated many tests into a reusable function to ensure that
Git behaves correctly regardless of whether absolute or relative paths are chosen.
Each test there now also includes a call to the check_worktree_paths function
to verify the correctness of the generated paths.

> I might be tempted to come back to it later, but style violations in
> the t/lib-worktree.sh were annoying enough to discourage me from
> reviewing it (if it followed Documentation/CodingGuidelines, it
> wouldn't have repelled my eyes).

Lastly, I sincerely apologize for any coding guideline violations. I reviewed
the guidelines carefully and made every effort to adhere to them, so I regret any oversights.
I will make the necessary corrections as soon as I have the opportunity.

Thank you again for your time and consideration of my patch.
