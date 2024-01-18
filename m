Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B362D63D
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594425; cv=none; b=sWq/3u1s/p3/Zqb935nvzUYNhzSI2G6cs7ObPfW72aJpRNSzj67LkL58FsunIvT1euOXUuHTd9/vtJ/zrkxDAFa9HAh6giTAnhuPid5eyh9XIiqTy/eglpCXFXgv69ga2ej1ZMrOEyZsMCsa7o1V8sJBEYopiZ4W8ktmThABF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594425; c=relaxed/simple;
	bh=c8LyekRW1lztoz0LtyPoxDsUKA/IpzbK2Qbcv3aqIXA=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=ajyKlU1fE0j1WHq0HL5ONv/fd4cxfeAPeV11n1IM+49HzggFoQl4M6OPli5lnGXXMFf9KmCc2WhHnF/AXbjDNbe7L4JOzHkXJFAPBg0hUAbdUFtNOhFlC+qe3qkDgN5b8tJk5WSf7Ilxi2+v1oRIYhcIW2vMrDsXg6hyjQUOsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=jNAJjOj9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXChUdTS; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="jNAJjOj9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXChUdTS"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C76045C00D7;
	Thu, 18 Jan 2024 11:13:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Jan 2024 11:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705594421; x=1705680821; bh=9/1YwS5WG0/dSywoX2SESY6du46paZxM
	byVmce56AYQ=; b=jNAJjOj9wO5UsQcSHvlovdLIYqClzfT3iiot8Z7YHngk8Cp4
	Lqop/2Si81B+nmmgflsxztJfKRminIKysF/zSNHbF4KXumWcy9p6c+bRFptPIKY0
	Pxwag7apclbiwxpK6QA+WUR5BgrQoZO31M+szfFAYQGllwNlRRjnfov4SBoud0XO
	/Fk4NO+uyJq7oOP5kCW7MvcSypPxDP88WQL9UsXSyleYo67OWNhlsd7Qx5tWCOgx
	m1nx85Cp856Hp8R2beSbGwW/Mo8mgbFaIFZyz1XL7J0mIzKVV2uFKZ6Orpwx7p7l
	QSduBCfGJYZfx/krkHSInisMT0ib1auDcFHiOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705594421; x=
	1705680821; bh=9/1YwS5WG0/dSywoX2SESY6du46paZxMbyVmce56AYQ=; b=M
	XChUdTS7Tsol/i15JHH9GaHgBcVg3Ur4uOz9ajfMGXBY5d6rubqkCyh6og3Q1vTB
	It9EmXWY0hMbuczEC7M/6OZuzWizblOuh9rqe8+9z+9vSUZSrVHMMzF9jMB9KfUe
	qS800+ukCMLj3IaVWgmpUgFrcA2M92ogI4H/ic5B6W0cdYSB/gUlQdNuETtAm6tk
	tEtN47hJ6B1bUnxAfhiUr33srbK6IVTystrqI9BLThHRz/0wb5sEWdeyHlTPLHl2
	HhsLGGlCzUNT7xHoztnfLZGgszAnIO+NOhcma+zGUEduRzphQ+hA6bIpLDd+tnuc
	tHkyOmtqrJKRHcfdz6JjA==
X-ME-Sender: <xms:NU6pZTuZG5vIxOkvi63t7Szfdm0fPlQaYfqxCDjfCai9lkafKkpkzcg>
    <xme:NU6pZUdcxYoBu-LjweSqMfGgEVx3ZJoLsRcfhjm0lH194vN5wM4PnISrtAOe6OMMO
    1DEN1iGf6rFpauMyg>
X-ME-Received: <xmr:NU6pZWxsxAG4Ua8_zTKhkPudoAyuprdQAnPhHHz2FF37ylr_WdanHf8emU-kcCXgFUBmGSZfY3oGy5JOlJD8CFbqOwabizaa4IJHnXF59Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfffhgfdutddttdfhieelvdetudefgfejleef
    ueeikeeugfeftdduiedvhfevgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:NU6pZSOefhokYLQyMWgp9jnx4YfJXcJFR7aANZ5EEv2UMdu36aFGsg>
    <xmx:NU6pZT-LhGihA3jpPeLeElePpYYs_pbMQFLzjSmqttg9F65E8U67mA>
    <xmx:NU6pZSWAhBYN_tF1D6VnejEq31_N0oKC_jx7nyyeGriJM8nyOKwKTA>
    <xmx:NU6pZekl-CsJ_WfBDPzsKbtPHONbi5WBhdBdJ-xgJ1D8T8RolQdOuA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 11:13:39 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] maintenance: use XDG config if it exists
Date: Thu, 18 Jan 2024 17:12:48 +0100
Message-ID: <cover.1705593810.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1697660181.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I use the conventional XDG config path for the global configuration. This
path is always used except for `git maintenance register` and
`unregister`.

§ Changes since v2 (by patch)

• config: factor out global config file retrieval
  • Remove doc on `git_global_config`
  • https://lore.kernel.org/git/c87b3d93-74db-4377-a57c-80f766d46e7f@app.fastmail.com/

§ Patches

• 1–3: Preparatory
• 4: The desired change

§ CC

• Patrick Steinhardt: `config` changes; v1 feedback
• Derrick Stolee: `maintenance` changes
• Eric Sunshine: v1 feedback
• Taylor Blau: v1 feedback
• Junio C Hamano: v2 feedback

§ CI

https://github.com/LemmingAvalanche/git/actions/runs/7521230119

Kristoffer Haugsbakk (4):
  config: format newlines
  config: rename global config function
  config: factor out global config file retrieval
  maintenance: use XDG config if it exists

 builtin/config.c       | 26 +++---------------------
 builtin/gc.c           | 27 ++++++++++++-------------
 builtin/var.c          |  2 +-
 config.c               | 26 ++++++++++++++++++++----
 config.h               |  3 ++-
 t/t7900-maintenance.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 43 deletions(-)

Range-diff against v2:
1:  d5f6c8d62ec = 1:  1c92b772ef4 config: format newlines
2:  cbc5fde0094 = 2:  269490794bc config: rename global config function
3:  32e5ec7d866 ! 3:  0643a85892c config: factor out global config file retrieval
    @@ Commit message


      ## Notes (series) ##
    +    v3:
    +    • Remove doc on `git_global_config`
    +    • https://lore.kernel.org/git/c87b3d93-74db-4377-a57c-80f766d46e7f@app.fastmail.com/
         v2:
         • Don’t die; return `NULL`

    @@ config.h: int config_error_nonbool(const char *);
      #endif

      char *git_system_config(void);
    -+/**
    -+ * Returns `NULL` if is uncertain whether or not `HOME/.gitconfig` exists.
    -+ */
     +char *git_global_config(void);
      void git_global_config_paths(char **user, char **xdg);

4:  8bd67c5bf01 = 4:  e0880af0a31 maintenance: use XDG config if it exists
--
2.43.0
