Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B534389E
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946930; cv=none; b=ZaSTpH0HhcWeXW5yX4skt/9bsLAIstZlDGc+xomVPdsjteoYZ8wNa3It9W8X18Sj/NZlTi2TXswuLfVVGAtnvDkkVM6Wxa0XlQBGp1ySK7zKMMAOfcX5XUqA0Ay5Xr0sVqvDiZk4V5yE/DTYA9Jqwbd8TMIqbqQKCMO6Z0aTca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946930; c=relaxed/simple;
	bh=4NB8jU98vOzmnbXcWvAz+QHPWSRcFWNAc4pUNE4hKhw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ei0plrreD+Ddg6G/oVwM8LiR4CdFJBt8WJL1qkex2ydFn9uek/flYaq01mHHidzV7+273vlN9b1KXSjeAp2a/eWrYDhLos3fjSPpUyRPOX+0cDQeVjREAp2uiHxZnCZO5zvwzeUhJZC+t9ryRmJ7hVQeghvMPLFec+/BRwYbfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6lHnL1I; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6lHnL1I"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e615efd7d7so4490647a34.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 22:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946928; x=1780551728; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3zNYFhTqaNLMC9OrmvT23m3yf3PlCl9O7yy9avsdJs=;
        b=d6lHnL1IC246uPknmlo21KT6om8TKXTHXXid8DWNvmkjNiIhSLjNCyDThSSQXHccPc
         ZGButy2tQjhyNnuxRoyFcZsTvFgaz3KnLqJrLOiTAlc/X5R1VfiDRTgUdJUWhad5y/U4
         oLFtf0iQJ/w5PavXEd9wtlh9wYa6CfL6PNkc3egxJdpJjs3OqrI72pu4lVd3MoUOV5p6
         w6HaWAz8vOc/bJyoW058bwHjBo3XdB9MKbBfxAqzOyfRoJh25FZA24JhctzEUj+rj/e6
         dWStUnEOF47naQihYEjV+bqbIePWGDVyjT5g8ChKh3OJd8XD4kUbVOE4/XXO/z0vMKNu
         jE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946928; x=1780551728;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3zNYFhTqaNLMC9OrmvT23m3yf3PlCl9O7yy9avsdJs=;
        b=Q1ZB5HWmk9BiUW8u5JIdrf035lvpJm2ixbnyXGG/e1myOnnX+L4ZlAW4+8jHrgUBnj
         xJKEgLeZe9kb1G5ddQ4IYkHIx+qvBZqK1PIjcaWP94U5n38qcP97izJ/v/iANmiUdW5e
         0RGslTFJ7hUoWvjkLSb5Z57I0Pb0uLMt0Ow8GZ10O0fASwSC769gHCqxXUW6qWeIuuys
         ou1xvoEPQLlhHVCaGhrVHcs0rVwPp8Lu70e81RaYJamxH7H8/pmee/KRBGvASClOTEgP
         IDXg3IztSFFLpGAPc4oYTpigbAhW/a3BG73Kuv/Nd81omIu7HOcdXYfLGy+rOBoLOewh
         sNEg==
X-Gm-Message-State: AOJu0YzBbk4PFgEJEBv/AjzVycoQgIbAbDy+ytd/XGJVt2TFHVQM3/eC
	2hr2EK4+flSuvnE29FqvRpG2e3nzwd00RcjappDi5AIRAWw1qCuav1Gr/IZDzg==
X-Gm-Gg: Acq92OHRjwjJ/Nt28i65AVxJrjOoCYIVuBVYLhHl643vXwh0tjQLRYudD9ahzvUuM9q
	9rAExqYZtkJfWwshwdIn6mjrcsqtGezwBlw+nOZzkZEnxboG3bNM8HaSjPA+/XaPGj+5q2bauQf
	fdLXJt9w8MihPKKagfvXxKh8vONNwlHFcKXS6XTgLkZEO9fwm9CNI70/DYMieXqFV4lbhaIqHtJ
	0kAAf1CtYA69unGhXVsHOkccZcY2tIuZlIva7jSWmUyzdiCLnPWtFwpEQz12U04scr+XRpv69UQ
	CC/9FzQGs1tNavsosta3kKZjN1DyqCtWA1PsWnzP3QrxshwHFkmouitZnzMiR4Aau3w4MR/jZe4
	DHCiz1zyKOAtFKd6+iyqh5DDSPLfixJRczzZUtswcsVUDPv2ygdsfaMrQwiiyYbEjEljf9VV44O
	FjCKlI4UqM6F6xrFAOPw6DxIQdzAaIlY1ktaRebqWAy+3g2g==
X-Received: by 2002:a05:6830:67eb:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7e5fed29659mr17447390a34.1.1779946927897;
        Wed, 27 May 2026 22:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606459bf7sm13086929a34.1.2026.05.27.22.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:42:06 -0700 (PDT)
Message-Id: <a550923440a233daea0b9819e05d6c380de00d09.1779946921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
From: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 05:42:00 +0000
Subject: [PATCH 1/2] t3404: add failing branch symref test
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
Cc: Son Luong Ngoc <sluongng@gmail.com>,
    Son Luong Ngoc <sluongng@gmail.com>

From: Son Luong Ngoc <sluongng@gmail.com>

rebase --update-refs queues local branch decorations by their literal
refnames. When a branch such as refs/heads/main is a symbolic ref to
the current branch, the normal rebase path first updates the current
branch and the queued symref update later tries to update the same
referent with the old value it recorded before the rebase.

Add a known-breakage test that exercises this case so that the fix can
flip it to test_expect_success. The expected behavior is that the branch
symref keeps pointing at the rebased current branch.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 t/t3404-rebase-interactive.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c27..42ba8cc313 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1978,6 +1978,31 @@ test_expect_success '--update-refs ignores non-branch decorations' '
 	test_cmp expect actual
 '
 
+test_expect_failure '--update-refs skips branch symrefs to current branch' '
+	test_when_finished "
+		test_might_fail git rebase --abort &&
+		git checkout primary &&
+		test_might_fail git symbolic-ref -d refs/heads/update-refs-symref-alias &&
+		test_might_fail git branch -D update-refs-symref update-refs-symref-base
+	" &&
+	git checkout -B update-refs-symref-base primary &&
+	test_commit --no-tag update-refs-symref-base symref-base.t &&
+	git checkout -B update-refs-symref &&
+	test_commit --no-tag update-refs-symref-topic symref-topic.t &&
+	git checkout update-refs-symref-base &&
+	test_commit --no-tag update-refs-symref-newbase symref-newbase.t &&
+	git checkout update-refs-symref &&
+	git symbolic-ref refs/heads/update-refs-symref-alias refs/heads/update-refs-symref &&
+
+	git rebase --update-refs update-refs-symref-base 2>err &&
+
+	test_cmp_rev update-refs-symref-base update-refs-symref^ &&
+	test_cmp_rev refs/heads/update-refs-symref refs/heads/update-refs-symref-alias &&
+	test_write_lines refs/heads/update-refs-symref >expect &&
+	git symbolic-ref refs/heads/update-refs-symref-alias >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--update-refs updates refs correctly' '
 	git checkout -B update-refs no-conflict-branch &&
 	git branch -f base HEAD~4 &&
-- 
gitgitgadget

