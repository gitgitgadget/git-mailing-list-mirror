Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182137EFEC
	for <git@vger.kernel.org>; Wed,  6 May 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099350; cv=none; b=ZSH3IUHcNBAF4kG2Rz3FwZSkGeAKrRFXrlcPFQRpBQWxz7z+dSQb+6vFRgMmsw209J6812Bkm1i9zr5w1zPquUE7i8eI07glraOJR1dh2dXOtVlH5Lb+3E1x19Gv+srcuTchfymei+OcJylTKaOxP7X9+zMf1ns2QD7s0RzbKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099350; c=relaxed/simple;
	bh=+WqozhxzKKmsJoYlWMR+XWL2DIHhBOXamfmDRvgmzU8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNV2yAWPhu4kIZdE6QXpaGC+JArZBhHVFhUJuMIKdf5YzG3g8p/Rax381MezkTR060GvdUj7+gnYwNgbRRcAtTVmRNq6910st2Fyntnc+ApsiXm8ASnyjJSy4CaZwgSa5YkeIWX3Zq1ntQdCOet9Qeu7nULqekUFo5FM05QI9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pJSaneER; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pJSaneER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778099334;
	bh=3VYKAaHk1PDGkd9OzVWShPnHts5b83SmGoaM8Bd6Eww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pJSaneER6RuDR6pMJ1J7m7lq48Q8uq2Z7Ay6a+b/KBfMKIDJcwyvoVWqyJSkySVrC
	 iDhF+MDkndWTVH+itR4xFs1TadiaiXLOre/V+Fkv7FVD02gj9v6fJ8/ZFioTwZbTFP
	 GElkBmGfjtNDtnnRfQy7tlnVHI5TiLQluvXccTZM=
Received: from DESKTOP-31CF0TC ([58.209.116.75])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 72BB2671; Thu, 07 May 2026 04:28:43 +0800
X-QQ-mid: xmsmtpt1778099323tixewiwh9
Message-ID: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
X-QQ-XMAILINFO: MKQst53PCfggKKKnCGApDC1qPK1YeWJL1jXft5TWw7TLIaKgWKMvE95DBV5Rlb
	 /BLe4B443CA6lsRH4IH6RcyB7KipN9kT6Rm8LnsQI/EiWHbT3eZRwEiYbXnO4xqT20TdSB2SHHw/
	 QMRyZGH2DyWV0YPk34/CsEp8lORcNk8zLNKBsrRGlsk7c1a0hlrQNj858p2nTE1Hov7T7hZ6B45n
	 7nPIqD41B+5ZclVYRJLNYzsccRsvg3lXgIhA0JBKiTDxdxon6Z1sfJ0z4QZG9APQgpQMw3FwjBm1
	 MoO9lQHg5t1eIdwihwHcf5/oiTa161csk7sIk/lk9JRyRH29c8vaU1XksbYBFmTShrB/nrWr8N22
	 kpxV3C5BNATFQdjfzmn2CulrSw8nzeroMqSq/3xJhIiVF1MsFB9jPjjH2H/AF8QvrCqiiXR38PhU
	 5OE1Nnuy9kgShGn3S/n1orRNxcIHCxUkG0FtsVqt5/wswtWPm9/cn38aRs6ao97oueJaR1sheax/
	 y5Yf41M/xVfjxf5rdnW/JDKymAWA2FGNBGi0Bk/qepw7y6V/0JODgOoT/rL8SQsJT0MTFijrauGp
	 tRQUI/BI2wi15JKCxj5uhD3lEqFpYte+bMTM4nTll54yNrQD6MlcKKyQ+2vlYIA/Kcz5d0EhqkHJ
	 s1TB8O0JBS6jamoBhed/zL6/Cpat8uqBVgdd+acbC1C71hVzfPFdZ19HAsFlhNHly12iFJCfYmHE
	 mu1tE304xfmcRbIPJaczg6bm/FsBO7/5f8CfN8VeKxw/ECvH90ebVmMclxcS/gSGzwOvSMRBQFnx
	 Ite++r97ebqXTtPqHxMJZuyNuq1oxIfnvGcoyCvmBOkac/miPkU7krLYPfLH4Fs8fpla0ELdM8BM
	 6zckjMuRw9DnNEd5Lw/kq94BULcYOC8aDXt4O0zgNZg5rMWapgTHDc0WqQG++1u0cBFPjicSoHb5
	 nXlJRHzyybyC/a14ki8o/wtGZowUxvfWaAaY6Y/I3rzkiqzjDVBvlpeoVo74YVz/sYV3yoX+Cnds
	 KBgtJJbyOkAdHfHcAp3uOTJT1qQkM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v6 0/3] git-gui: robustify startup and fix environment handling
Date: Thu,  7 May 2026 04:27:48 +0800
X-OQ-MSGID: <20260506202751.3294-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
References: <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses the startup crash introduced by Git commit
"2d92ab32fd ("rev-parse: make --show-toplevel without a worktree an
error", 2019-11-19)", which causes `git gui` to die with a Tcl error
when a worktree is missing (e.g. inside a .git directory without a
working tree, or in a bare repository).

Additionally, it resolves two historically inconsistent behaviours:
- The "Visualize ... History" menu items were enabled in bare
  repositories but triggered Tcl errors due to the missing worktree.
- `GIT_WORK_TREE` and `GIT_DIR` environment variables were not
  respected early enough, so `GIT_WORK_TREE=/some/path git gui`
  often ignored the explicit worktree and brought up the repository
  picker, and an exported empty `GIT_WORK_TREE` confused commands
  like `git branch --show-current` in bare repositories.

Shroom Moo (3):
  git-gui: restructure repository startup
  git-gui: disable gitk visualization when no worktree available
  git-gui: handle GIT_DIR and GIT_WORK_TREE early

 git-gui/git-gui.sh | 170 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 128 insertions(+), 42 deletions(-)

-- 
2.52.0.windows.1

