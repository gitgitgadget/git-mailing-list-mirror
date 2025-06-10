Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFA4A32
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590999; cv=none; b=Kn/M3ZAOo0yPuAvub+uFvCUt2/BdKuTekMh9CQQwi+7kEQ/gRAYa9T2s2QepUJ4oVVkGR4a1rsi4bXRmGkRkTmbUWvMtJURWhZ7pF95CfOZWHekRJttLpDzpjB+CI/ui0NWwzj4B+Juw5BjK9qNagNkFgbmWGOHKnvJ898DxNik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590999; c=relaxed/simple;
	bh=O2+EJYJ3fouHBSV8X2wzE1jjHSEzejAO3L1iR5KoQEE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZBRBz+b1Z43dnTnFCWKmRg06Z+f+xoR+SZn4gqR6axj+ltnhKSyog3v6lcSxviIfzH9J+DV16UXjUkPfsSr21WG+n+Gh4P5HfCdl629pBgjnEwcjKkgNdIZQsk5UVygmKct2cc632d+PBw+erYkSVRndiu3YxeI3ZVCnuvu0F6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9So1rWd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9So1rWd"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e78e04e48so46535197b3.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749590996; x=1750195796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=trv12vqqWYyN3eJtEFwlLCjgvl++nX8bgZxpZPeZ4yw=;
        b=h9So1rWd7PTUZDtV0wKoRZqj36du0p9F5E6y3G9vejYDUr0D38h/Qjj+MITcpRA6p2
         KNwtmcAaCC048mp/u7CBiE/OHqFc3Rjw1zHMGjMldlLWvsCDqZvO6A/yQPyvCTO4EhKa
         2HJ9tlY2cwnCWtVoY6E0DynnrLF6a9Rw0jsPxBasgGQbIzV6Eb460a3wGyA74bFj2DHT
         H1P7nd8XNPJkm8USa24nsNeKVb9K1oOBqS9RoWDY/1sfA4wcehVtuEkOWdQu+M+8J9+Q
         12qFsbWqP9axMf1F3UpR7rGgXtOVLC3++auBRmAzIL5KOVJuu7HTlFauhC5ciHsgop8R
         4Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749590996; x=1750195796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trv12vqqWYyN3eJtEFwlLCjgvl++nX8bgZxpZPeZ4yw=;
        b=oqFnVPtx2sDp4bwbStF6oRrf/otMJWsIbfnmpFkkMG+2HNF8QYWuRPHDDEUSrUYMcQ
         1xPoOyaldjIfW1XxQq5PE+W1HaeuayE6oijMi8HKjk7gS5gYb5EeCFRWnEa21a8sn2tL
         WRF/Dnm0OLHDucVe4gKAq1JqABl7BgK6mB7vA25GGRLFDfJ4MS0/y5UI2fJhN8auNKS/
         CygAH74XrkVkFM1lg2uxIhdeXXrE+dZkI/0pW0xZ3xb1wVghXXuGuS6YqtSawUu5ybdO
         p3jShlfoKsZkoXMFFLBSw4LId0hJdedNECbWWbX1XmVoNHyQBzlT7choFtE6nAIW6oMl
         3reg==
X-Gm-Message-State: AOJu0YyKQQ9C6dGRk2yHrmKqGbIuE4MHiYhoXPajU+2Fdr1tvZRTB2mG
	oNdjotEP2SbPAp9kCLzk20Mqt8o5GND/AvWt3P7q9raj7TtPwiX99Tq72QPIkQ==
X-Gm-Gg: ASbGncs6ex9XM/6CwhtN4VhZNAMDg+Pt+Ir9z/1yUt0qsmXIUc/OTdB/kh6K3/hFAJh
	VyrAhtm3Z2dkjnL37yiZwTbFfoz19Y4bCAlYVsdvbtKqu6x6Ougro217fECuUKM5KqVVgZ0MZSZ
	QmT2haROIqWNfcD0eI4lO9UJFhq9W/j5GUl9mEkGiPiUbDIdbCKSOqgHNi4ztKGIT3JFVtkbnkz
	kqayD4yxAgEbDA/L4MBfDCmepwMejXndFX4yU0Ji2spdVV3zZRpX7HLfmplJj+v+9eNpSghV3Cn
	cblqwIa5OwgN7cfNUyNOmhLg9w0Ss5PBAxxmzjCJWEOfhGInqhRhvRZ8GyiAsvlK5OsUYnsEv6r
	XXHr+zT38NRSWBbiM9+NqH34EenUM4Rj5GC+S
X-Google-Smtp-Source: AGHT+IFAIl4x3UHKRlGtyDwMjXkEBWsjQG3RlWWYte+a7JtpMPAf1q4sXCcAknpX2qmmqJLKpKgjFA==
X-Received: by 2002:a05:690c:3584:b0:70c:a57c:94ba with SMTP id 00721157ae682-71140ab7fe8mr17037367b3.17.1749590996047;
        Tue, 10 Jun 2025 14:29:56 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:150e:34a1:2af9:3077])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-710f98ed805sm17856317b3.42.2025.06.10.14.29.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:29:55 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Subject: Canonical way to filter list of commits to those pointed to by branches (preserving order)?
Date: Tue, 10 Jun 2025 17:29:48 -0400
Message-ID: <20250610212954.51868-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Perusing a Git Rev News article [1], I thought there must be a better way to
turn the commits between 2 revisions into a list of branch names—better, that
is, than parsing git-log output.

I wound up with 3 options, but I wonder if any are canonical or if I'm missing
the "standard" approach? My current best attempt leaves me concerned via the
documentation.

1. Use join:

    join <(git rev-list "$upstream..$base" | sort) \
         <(git for-each-ref --format="%(objectname) %(refname:strip=2)" refs/heads | sort)

    Requires Bash or Zsh due to process substitution, and the |sort pipe loses
    topological order. But elegant, from a certain point of view, perhaps.

2. Use git-name-rev, but post-process output (because name-rev gives results
that aren't refs):

    git rev-list "$upstream..$base" | xargs git name-rev --refs='refs/heads/*' |
      while read -r sha ref; do
        if git check-ref-format --branch "$ref" >/dev/null 2>&1; then
          printf '%s %s\n' "$sha" "$ref"
        fi
      done

    Not my favorite, but seems to work

3. Use git-name-rev after filtering with --simplify-by-decoration

    git rev-list --simplify-by-decoration "$upstream..$base" | xargs git name-rev

    Clearly the most elegant, but only if I can rely on --simplify-by-decoration
    not outputting commits not pointed directly to by a branch. But the docs say
    "Note that extra commits can be shown to give a meaningful history." Hm. (Of
    course, all the git-name-rev solutions are broken in the presence of tags,
    too, though for my use case I will just ignore that for now…)

[1]: Pushing a whole stack of branches with a single Git command <https://andrewlock.net/pushing-a-whole-stack-of-branches-with-a-single-git-command/>

--
D. Ben Knoble
