Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6872617
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853659; cv=none; b=eF5XemI5KLdjc4KDpMznhZ5Z3CsCyjrqDfliJKxD18kjnlNThabhzKxdGMmsemJ16jmRgYf8htt6KmqmdXlu20diXqEa3KSCW5/mBVoyN4kLVQ87fVPNR7dI69cxhcp9xCKzYk3WnoqsFUizwJXK0fvyy5MiEC/KDShWBpEvp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853659; c=relaxed/simple;
	bh=PeF8HhM/XFBSzwvR9DOUk7gFO2r+yN+b1Gq7FIW9tJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GxyiHhcClhOtG6EHFOm14Gus43a3hRUXqmu+Mscv9xvKyahXRwfIuRXHZoPbZYtmU1RObuo8jTU+4DQqt7vG9MNP7DRhFHJuxKxPsJXoqFMa60Zs0XNX+NbUEPGfv43yna7Lly68y2hES3wdF6qNxPJ7Jx2RTC6JlqyNgKoXQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qOjCa4xG; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=g1IuWW6w; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qOjCa4xG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g1IuWW6w"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h5q0k3x2xzMlK7;
	Fri, 24 Jul 2026 02:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mUPtl5hMfTzDtC46XWh7idpV4rGXRqgvIufU++Py1x8=;
	b=qOjCa4xGRLwA15dHe9WfYeq+1hFd/9rGK7SQkeBkpckHhEqBqSkRkv22fqtbgFvebFh7+z
	91kWVNmB21dJueek9n1RPTeEtNJjmlli2CAauiuZhyuPjf6xFk49M2kzvfe4tI5HYU/qrC
	tjjQoiYv2COKIa4Njqjqc734EC+DzHiXtD7V4F+SkFt4+f6v9dItv7w3TNgTd3A45gZ48J
	+CvALofoO4XAPsMmc9BKQ47myPnMpQVR92RgY5wBwCJSdI6fnquITuNvVO/hyiMm9lEPrd
	B+x4gT4LRXiGdRd2Ck/ByYEszkVj+JXxWLDSDM+cUddyd3wRYvzbC1wFAwpDJQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=g1IuWW6w;
	spf=pass (outgoing_mbo_mout: domain of fpottbaecker+git@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=fpottbaecker+git@mailbox.org
From: =?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mUPtl5hMfTzDtC46XWh7idpV4rGXRqgvIufU++Py1x8=;
	b=g1IuWW6w5hWAQj+4mugROLLJppLriZRGT/Cos1SX7oZgD4NNjX+iYmfCIbOG/eaAcILstr
	Czq9Ugy3Xxfa9lbwZ3DauG52t0MM2lspgRjUQuh3Zmo0RExDqNV49PZV3zDVFjysX3RlOy
	p9O2SIw4l6kq+F5NaJYMpgdxwFrllre3GjKwSnmfbqAWCr4dPp38N6iN6xb/V4CK43xm3j
	2ilvcVo9x8pu4/LQmpL7CumNtmQxjnXvEpKd1aQmeApGYH25N/SpIPMZXMgEm4jFPZddrg
	05WHw1CRxHujsV7tPOnRqQkrQPOTmWwWGZ121MykSnEaLZKhSCdXjmweryUDVQ==
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
Subject: [PATCH 0/3] config: support scp-style --url
Date: Fri, 24 Jul 2026 02:40:08 +0200
Message-ID: <20260724004011.41795-1-fpottbaecker+git@mailbox.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1runza5t886h6jmdiqegwyy4ebf3e5sj
X-MBO-RS-ID: dbee44b25edaa44e4e8
X-Rspamd-Queue-Id: 4h5q0k3x2xzMlK7

Almost all git commands support the same set of URL formats, which includes the
scp-style shortcut for ssh. This format is the default format of multiple large
git services, presented to users when pressing a clone button. The config --url
option was a notable exception. This is only relevant for scripting, it only
affects the config get command.

This series consists of three commits: the first adds URL default port
normalization to FTP and SSH, the second adds some git-config tests for --url
which seemed missing (present for --get-urlmatch), and the third uses the
recently added `url_parse` to support scp-style URLs in --url.

Uses in scripting of this change include smaller tools to automatically
configure some settings based on some remote, like setting up author info based
on a user git config value scoped to ssh://service.com, which is useful
because git hosters often offer an email obfuscation/forwarding feature and this
would enable easier management of identities with multiple accounts (like work
and private).

This could of course be more useful with adjustments to `fmt_ident` to support
this, with appropriate config options (what remote, copy values to repo config
or use globals automatically, ...). Which would have been somewhat out of scope
for this and requiring some more intricate changes I did not feel comfortable
with yet.


Fabian Pottbäcker (3):
  urlmatch: normalize ssh and ftp default ports
  t1300: cover --url for some --get-urlmatch tests
  config: use url_parse for --url

 Documentation/git-config.adoc           |  5 +++
 builtin/config.c                        |  2 +-
 t/t1300-config.sh                       | 58 +++++++++++++++++++++++++
 t/unit-tests/u-urlmatch-normalization.c |  9 ++++
 urlmatch.c                              | 16 +++++--
 5 files changed, 85 insertions(+), 5 deletions(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
-- 
2.50.1 (Apple Git-155)

