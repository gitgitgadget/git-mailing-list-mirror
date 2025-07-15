Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03531B4F1F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622402; cv=none; b=fLfP51Eg9wrq+mn3TAkXD0R6CWHsvhVL8wXDCTnLY5S9mU8wG6+dW96AcAPCpZ4I+9nWbjtt/XMUJAG6C8iBEq4SdIGGX2uOG9SJodARlQbovMcDBEqh/Juz4oOWpUveIAzDOpmOfFGozLyxEGd+1ltVGu0DZq4pqh81nblANKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622402; c=relaxed/simple;
	bh=opJdmPiEtCn0KcGMRJ5uFS4GbYQWPfew8lhgE0CnALs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A15h8jMjwFwCQo4ky6DKFuMD6fnI/6EzzbmPqg1abn11RG/5GdKW9dUPyRNtsMvLwugASNGe5roxckKSaWvL7zyxTcfNNUSaNW+sRZ5X5cLbqDcmG0TuoNDuSRxHb6XBKNLNWwB+S2ux/44ZcH2jNvc5Gs7DLWxcOJx3fq/ohUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=mZyLTRp2; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="mZyLTRp2"
Received: from satellite-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id bp8quChur7HMwbp93uU8yV; Wed, 16 Jul 2025 00:33:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1752622389; bh=SpsApbIQsTGNnJ+l1ppEIxkmlTVJIfBvA3t0YnpSHvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZyLTRp2a9lGJHA+KkpJBNGlMFyJmY0oZQPlqO7TLbDWxXs2eRz+8WC+ZHbsk8zpy
	 zexO6zAppNzyNLOjT0NlixcReqmkZek7yyHaINZeNvWqY+ebRboD9MmlaMt9iDUDJO
	 jXiJybVjkPe3w2guVo4Z8oPv1bK7rSQyQyy8R5cGzJy7Ixfkh6Nakde3d59pLt4U4D
	 3Z4mZq1ZHycv4koLnv+ii/G2g2Ff/DPdSc7qFHo4DkmTynVTsR7H3AI4iReNJ2DWOO
	 gkTS0GzuVqmt9fpdXbkXy5C/AtwMMQ92xGTUZUi2nnbocNw7RBYZcvgdyQ0maObcDA
	 GgKccuzR3wEPA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ZNB0mm7b c=1 sm=1 tr=0 ts=6876e535
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=XfaMCxBbOBvcb8ZzGj4A:9
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	irecca.kun@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] meson regression fix
Date: Wed, 16 Jul 2025 00:32:37 +0100
Message-ID: <20250715233239.1539780-1-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
References: <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP/hof5YRR0hULwFpi2GQgLtuqnC8dXDqWzrCL/y/A2QdJLYvdr/zwXFBFFlcFLvbspOT50Gm9KUXyMOS1jxbaR/Zi3++DUq84nkzYt8XWV8z8mpS9aZ
 zoLaEG5AqLjKNARu2Fa+1iOpejZyB93idI4qNHp/hI9HVyp8/hwsgmzTwndWNTAF7i4JsID57WdDcNeSsLel3MtoN+tRecRdZCA=

As promised, here is the patch to fix the regression caused by
commit 837f637cf5 ("meson.build: correct setting of GIT_EXEC_PATH",
2025-05-19).

I compared the meson and corresponding make installations, which
shows (in addition to fixing the regression):

  - the make install includes 'gitk' and 'git-gui' which is
    missing from the meson install.

  - the make install includes all of the 'builtin' commands
    in the 'library executables' (e.g. git-add), which the
    meson install omits. (I thought we had stopped 'installing'
    the builtins).

  - the make install uses hard links whereas meson uses symbolic
    links.

  - meson omits the Irish translation (see patch #2).

I noticed some other problems, which I was chasing to see if I could
fix them here, but it was taking me down an unexpectedly deep rabit
hole, so ...

ATB,
Ramsay Jones


Ramsay Jones (2):
  meson: fix installation when -Dlibexexdir is set
  po/meson.build: add missing 'ga' language code

 meson.build    | 42 +++++++++++++++++++++---------------------
 po/meson.build |  1 +
 2 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.50.0

