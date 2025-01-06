Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44612198A29
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190885; cv=none; b=qWNv/Lx/Cobq4KuVXqzlNZ8F1eA/HYek8aNmC5FU3+AZF5Aw8q83iy6l93oN2Q4AcipBy//Ys5+r7w24tWAaTYr+ZA3DX85jUEcfmVP4xmabhsUpISNE1mnxUoUUnJ1LmUoMI/VqiOKgJBlslAtWkKbBlxyCfB7H8L5x3wnzzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190885; c=relaxed/simple;
	bh=H/d0T1FzWR8mn7yTJqtOEDvq0OjjIf+dYlwFHPZezuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QF+Leio3wqlfu8cbtTioLyMTayl8JrEF/ctxhqEU84ux9IqGDOZkAxzbr3t27ENx9sLqgqPlhRKOwbEfa4Qi7H0uYfbVz6A0KwZJEnlXLZxCKmTwRMeG+eWWUkzq0hwgoOGeE52mK0gl7IRDpns+n1YKhyNBuCaT67rIehZ1MWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=hicSeLyM; arc=none smtp.client-ip=195.4.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="hicSeLyM"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tUsTc-003JGj-OJ; Mon, 06 Jan 2025 20:09:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dcuKKJC+WVWRpi6jG5BjPhsT8YXXOYcKfbRYrPmgL1U=; b=hicSeLyMb8gYIiy9m80CqRFwaD
	ffnyfSVRI1RGwUm9YaVPX+NP02f64cII+A0+cVdXNgczt60+VoMtJnhtfiFfbb7WF0sSo1oiBPYSe
	X9ljGdf4NlYGGtWll/PR8lkWupOeJ4UdSdzlA52eXOlysh2JW6l8+8vSAqI6i7S2CjlrqM0DC3y/+
	cLfawkMPc/yTGG4Kw4yeaTZzLRtL15ucfin7kl0DKHdyWtow82Wp5ITUB0+xRICmJWbDbmblkieN5
	Qlhe8yrBWb3jzcbqWaBQvqcApyZkyiZhRZ3bRf/mHqrXHGS2ZoFFTLoKSdHH5Xrgz0GSZc6XdCGQs
	29DMEpsQ==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:46380 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tUsTc-00Brik-EG; Mon, 06 Jan 2025 20:09:24 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCHv2 0/4] Fixes typemissmatch warinigs from msvc
Date: Mon,  6 Jan 2025 20:08:51 +0100
Message-Id: <20250106190855.3098-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
Reply-To: <xmqqfrm9t6up.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1736190564AAA26B19C3FDO
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!46380
X-Scan-TS: Mon, 06 Jan 2025 20:09:24 +0100

Thanks for your replays. I try to improve this series and add under and
overflow checks. To improve handling Platform specific stuff I add a macro
for conversion from a string to a size_t.

Best regards

Sören Krecker

Sören Krecker (4):
  add-patch: Fix type missmatch rom msvc
  date.c: Fix type missmatch warings from msvc
  apply.c : Fix type missmatch warings from msvc
  commit.c: Fix type missmatch warings from msvc

 add-patch.c       | 53 +++++++++++++++++++++++++++--------------------
 apply.c           | 37 +++++++++++++++++----------------
 apply.h           |  6 +++---
 commit.c          | 12 +++++------
 date.c            |  6 +++---
 gettext.h         |  2 +-
 git-compat-util.h |  6 ++++++
 7 files changed, 69 insertions(+), 53 deletions(-)


base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
-- 
2.39.5

