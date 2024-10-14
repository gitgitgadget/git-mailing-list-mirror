Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7D33991
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908477; cv=none; b=EPrQKf4zuYCMKpdVt98tFbB1jHLWwR8bk+jQ66YAj1NwnQn4Pqeo3RrZ92+EguAJYq+7djDUdKqoEzja/ueC92HgfeM0YBOFlEqy4gZTTjrsBoJm2dRvlP4L+9gPFu5qb8NmDVFI0oMAs2l63x2ElL9Gm0/MorAOCjW9lZuSZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908477; c=relaxed/simple;
	bh=kidwMGuNMOq9y/opyOJy+2pDrTIrPZDMmon0I69jOSg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iTNe0ALKs2KmAhZkoYxh6C7F6iDt7RNxMd62E0fn4uOAxa3D5TgInKUVhtV7i2pge79eP394Y4oUmJv65Jq3IXojgyqlZ6RNbEdnWlvvDLQf2J7OKU03V6upyliU/z4boAIFhIivafbpYgDPKRqRVtBls7Pmzl4Kpiv7dkK+Iv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j7A4rM0P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWRktcM7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j7A4rM0P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWRktcM7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBCB0114018C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Oct 2024 08:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1728908474; x=1728994874; bh=u6awLXEz2hUS6Y/Sd4j2oPhe4H9uNZtL
	7hLfoQQ/5hQ=; b=j7A4rM0PrqLoM2iLrDkt9z6IwpROk7nf4a4cOYDcMsEX8JLI
	4iUIPuLaFRMbqhkYeh2CpwTPoa6b3ANKdzcE+dyiai3r+Ab+CUTViR+5WSpR8Sfe
	GrLod2W4v/Ut2yzbFi3Zmk8WOjXboGHOEH43l3k2JTHNfX/o4HZW7PksLa84ViKY
	xnYbf9Ttp9nwtHjBQ6+qCZhxjy/pqw6W4Oj7uBN2guAKhPww3RR1PT3EH+14I6GS
	+gFUl4aJx/Hjm2MTaaN5tjrFddmVia1medebItp6kYlyfCo7e9il71IUbRWOY7fZ
	QCVOXkoVE4VuHTASy32vo4Zh3aGvW0llDV0+bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728908474; x=1728994874; bh=u6awLXEz2hUS6Y/Sd4j2oPhe4H9uNZtL7hL
	foQQ/5hQ=; b=YWRktcM7ck2+tqCDFHJewWvNAuho3sTCj+3EUXetT4Qo4TCN0av
	zkb3k+hrdqKl8xT+ieCFaj2ZFjG3r8yE+ZYH3r6uUBh0z9pgaPwBsQTzw3Rq+G6y
	yBAUtPDthIfG1rhzZG+HmR0hcDYOaBHD1fdvd7X1og/EaYQcLfVAGXf655GNxf73
	i8/A4DyZG9AF2or9EMlD6afU2pggVy/rXfNh8gmyLST23IszwLGGKH8CZxlzUMZT
	+6uMJqc/xCOnkvLK5VeAyN64V1SS2SnMvwqfMb1KiVYAx2vEXDZo9y26MfZa/7O7
	1tRk4F0u8ah74kSAtsu5XkRKMBXhDHWsBHQ==
X-ME-Sender: <xms:ugwNZysJGAh-0arBFlrNXXIsYe_PwK0uYVljtRdPKRbaCJQw4-dyFQ>
    <xme:ugwNZ3elEhCvIQh3M5UuKzTBHejgE4jiFX4sMHIg-s5X4DhVG1eAUXmXlu2vhsI5k
    Z-DZ9MoOQLjNEruOw>
X-ME-Received: <xmr:ugwNZ9y1rUscPQ3AN1bLEJ4XwzeM5TnVK3qqyIPYK16wpr-frCSG40pzg4YJ5SenBwEmrdIl2PkiQEstpR96JYhhxlj8nnb4hUD1N1Ii-2EbJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepieekheelleetgfegud
    ehhefhjeelieetledtjefhledtuefhfffhhffhueeliefhnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghdptgdutddqthhlihgsqdhgihhtfigvsgdrshhhpdhhthhtphdqfhgvth
    gthhdqughumhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ugwNZ9OCDf7YPlwqBjvFLbdOGfmZq_C3kaXoFrWmITYRoVlwSsIMkQ>
    <xmx:ugwNZy8KEiCSAr7GoXLv-A2BXQw9Il6NQIV71cKdXB-UqTyiBlJCJg>
    <xmx:ugwNZ1UsD4Pivd5pGPXc9tAQ5ih8bknqmj7maCgVKSdvoDfHKqwgUw>
    <xmx:ugwNZ7fPQ3bCGY7q06ecT5kPVQTSRdTe7mkI51FnlFVjMi3OKEYF_A>
    <xmx:ugwNZ4n11DTc6aywQ-KyKb84UmkSs18uihJUeD7w0T2S1mGhKNYpHYmp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28c6a928 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:19:59 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/10] Platform compatibility fixes
Message-ID: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series includes platform compatibility fixes that I have
found while working on the Meson build system. These patches have been
split out of the original patch series at [1] such that it can land
independent of the changes in there.

I'll reroll the Meson patch series eventually and build on top of this
patch series here and a second, independent patch series that updates
clar [2].

Thanks!

Patrick

[1]: https://lore.kernel.org/git/cover.1727881164.git.ps@pks.im/
[2]: https://lore.kernel.org/git/cover.1728903464.git.ps@pks.im/

Patrick Steinhardt (10):
  t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
  t/test-lib: wire up NO_ICONV prerequisite
  t/lib-gitweb: test against the build version of gitweb
  t/lib-gpg: fix setup of GNUPGHOME in MinGW
  t1401: make invocation of tar(1) work with Win32-provided one
  t3404: work around platform-specific behaviour on macOS 10.15
  t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
  t7300: work around platform-specific behaviour with long paths on
    MinGW
  builtin/credential-cache: fix missing parameter for stub function
  http: fix build error on FreeBSD

 Makefile                                     |   1 +
 builtin/credential-cache.c                   |   3 +-
 contrib/buildsystems/CMakeLists.txt          |   6 ++
 http.c                                       |  10 +-
 t/lib-gitweb.sh                              |   2 +-
 t/lib-gpg.sh                                 |   2 +-
 t/t0028-working-tree-encoding.sh             |   6 ++
 t/t1401-symbolic-ref.sh                      |   2 +-
 t/t2082-parallel-checkout-attributes.sh      |   2 +-
 t/t3404-rebase-interactive.sh                |  26 +++--
 t/t3434-rebase-i18n.sh                       |   6 ++
 t/t3900-i18n-commit.sh                       |   6 ++
 t/t3901-i18n-patch.sh                        |   6 ++
 t/t4041-diff-submodule-option.sh             |  16 ++-
 t/t4059-diff-submodule-not-initialized.sh    |  16 ++-
 t/t4060-diff-submodule-option-diff-format.sh |  17 ++--
 t/t4201-shortlog.sh                          |   8 +-
 t/t4205-log-pretty-formats.sh                | 102 +++++++++++--------
 t/t4210-log-i18n.sh                          |   6 ++
 t/t4254-am-corrupt.sh                        |   6 ++
 t/t5100-mailinfo.sh                          |  14 ++-
 t/t5500-fetch-pack.sh                        |  14 ++-
 t/t5550-http-fetch-dumb.sh                   |   4 +-
 t/t5601-clone.sh                             |  11 +-
 t/t6006-rev-list-format.sh                   |  54 ++++++----
 t/t7102-reset.sh                             |  40 +++++---
 t/t7300-clean.sh                             |   2 +-
 t/t8005-blame-i18n.sh                        |   6 ++
 t/t9300-fast-import.sh                       |   2 +-
 t/t9350-fast-export.sh                       |  10 +-
 t/test-lib.sh                                |   3 +-
 31 files changed, 273 insertions(+), 136 deletions(-)

-- 
2.47.0.dirty

