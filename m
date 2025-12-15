Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15002EF646
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831531; cv=none; b=jFDzmrn3FQ7qAoEFQJv3ROkvG0zQtNBGgR4cyWq2IUhF6etAVqgpNB734fHSsTJ5XNHs8ODny46bc/RLVe6AqSzzkZeHq3s/QxMjv8+0RHQ8NaB6OEUCM8ptVHsOKO/uJ+9zivNSdGGWVc1QuDCWMME5hicqkxg25HvIb0uF5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831531; c=relaxed/simple;
	bh=75N5lOBFYI6FmcVE3ZVsdzqUlc5v0VC7V4iX+0N7TCk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nyUfBuBM4C6oel3ePwLwL6hfqqyyP3yU1yAnR6dgUvJCuoug5MrCoS1qtJ3YQAJS8tcOrcaujbbFYUPoxggTk4N8/Mxy/RkoHas9+RsdMf5AhfiU6S1D6SkyFgGcVgFKzLOgiFjPa9iUt2amgKXdZAIzcAvAjz6ZHbUrutFOAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=YlPxaXwH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="YlPxaXwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765831521; x=1766436321; i=tboegi@web.de;
	bh=uYo7uY0L50yphp1di42WDTR9RCe+AqFhY2hTyk/RqjA=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YlPxaXwHSLZgLzqA9hGyB76jEfNEZQz8qX/OhcSeyv2ngknqz9oQ8IrRjCeEVsU+
	 gqpsEhP2hqOtcSd0widVePlZzyJkWKOx2wJDhk8Os8dZ1NezU6BAHoccbkYwrP44B
	 lrRUyEbNg5sIZYlKvXrUuKxKztDIeMWNj1ax74/E18zW4Rmu2Nhv8xv4mh87A7GMu
	 ncjwKdefMMcchlrLAS6h3e9YBKYNZFHxaEHKkSqLQEM7o2gUxKWFmRMzsN1tCE+tJ
	 jE2nz4ufQ2NbasJPc8Q8Q+rqarflS8awsxFJ3BznaTuE+uVeXIcg1xxCBy/xz8Zr6
	 g4mDKBTltf15IRob2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Vsr-1w0Kyu0UYz-00s2DQ; Mon, 15
 Dec 2025 21:45:21 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v0 0/3] iconv under macOS 14/15
Date: Mon, 15 Dec 2025 21:45:12 +0100
Message-ID: <20251215204512.1946461-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5hzIHIrJnRbp0RjoUyKYcIVUaeQH4/lG5qes8EY1nQV9ZRCT5RI
 uAgLenGtR/SFWyJGjAd0fyKDHnOOspFnYarnVNORhzbgpZ8uBjz3U6qpp+nDqIiAytDRQGp
 VAC3DejjuiCslqQrtZmhTLACz4+hmFMTxVJZUmiPg5DAm79CBbi7ObODdM3EC0HxyyVhHPI
 ZDZRqU3UxaYEZoCIuDAmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2k4eSVHQq7E=;QX6Pmy1snAoCS97RG8CC52EOCAD
 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
 icT9IzZLPptShgKefzDJZh7lrXo+Mmxxzvzd8K

From: Torsten B=C3=B6gershausen <tboegi@web.de>

This is my attempt of fixing the iconv problems under
macOS 14/15 (tested under 15).

The patches need to go on top of
rs/macos-iconv-workaround

Please read it as an RFC, comments are welcome.

Torsten B=C3=B6gershausen (3):
  utf8.c: Prepare workaround for iconv under macOS 14/15
  Makefile: Make all darwin into config.mak.uname
  config.mak.uname: Activate ICONV_RESTART_RESET if needed

 Makefile         | 21 ---------------------
 config.mak.uname | 28 ++++++++++++++++++++++++++++
 utf8.c           | 13 +++++++++++++
 3 files changed, 41 insertions(+), 21 deletions(-)

=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

