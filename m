Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C02C3257
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069541; cv=none; b=C/SAYE8DT+vGDB4DZT0D7coNQk0nccOUPGHP9c/skojPkMyRIOKM78p6PB4v1xP0LDl9uI7INRJLk6B0gsX1UOvbQwEx0z/Hs3/qmJFxC8dyDgJEzB7uLPXubJL4VHbb5CvcVDfKx9uPNCESAwbue49uJQu/J/qCgCbDLLYTWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069541; c=relaxed/simple;
	bh=lFIJ6t9kDlgDb6bFbY55CNSXfCwc0fn2ybJpvDU8AQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl5VBJ9psy/KQX01xwELE0aJAawYJM4Nshvw0OaLss76u42Q/4VR75638VPXaWgb1it2rRuyye/WtOsbj9/hXs0GYEwO8l4IkZT0kzZ6NT8F0bJrgSRTC0KhkEzzgXlbpS/Q8to2+lvLFJEM4uQPieWPOTlidWoHAJ2LbWlKPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NLTDvtQT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELohq8+e; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NLTDvtQT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELohq8+e"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CCB7140039E;
	Wed,  9 Jul 2025 09:58:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 09:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752069538;
	 x=1752155938; bh=zua7uNEMCdNOJKkg0TN0ALKvD1WwQ25j0LA0O0EJOo8=; b=
	NLTDvtQT4az+atAiAkr3Tbs5kv+qGCaZKuVTL9vetSdSO9qxMf9dz5/oyb/smh4T
	0lpLuTWpkBsafJXtaRSNvJaMu0upHI+9X4wZlzHsh254wG78Qd/TSIQ+IckI9cMh
	Ye2sNr1apy8bgrrTAY5S+Ns0DL54rEFg2OEjgJqITIJG/EU9BLTjlkQAUCxHcxaU
	qbMRKojAUnsKr/Md8Yv0tNgui5et4Lb2qGKHnSvNf1UPhOkEA72fHZJUoqSW5bTI
	nisjw265verPpJ0ruHylSEKxEbr44KTvrCwK+FdBfwG3DwJX0zP6BO6fgvJbFAvC
	MKfcgm7vySl8qvxQpynOnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752069538; x=
	1752155938; bh=zua7uNEMCdNOJKkg0TN0ALKvD1WwQ25j0LA0O0EJOo8=; b=E
	Lohq8+e3ZofGULrNvZFhO1+Q49CykqGhdd5gCN0+rUlg0zluyjapNmCIzQQlD+RN
	vCCpGo+OoNlskAUiPcNMZ0tEKxtAMNxwM2LXfedevGy/KZ2aXx4K5pHn70turrNw
	BnwxlvALQKoiHWd2TczMLYhos+c48KjyHffQK+ZZBVjSz4UD3L0FqqASz9QNLznB
	JmoVG5KFlrgbFZBUKbWvtuSxSbNQZcU9gu7GJVtkknYcSjpwXNJNNn+XOF8B6jQb
	sVf8KbPxOoYDkqPb411wigSgx1Xg1n+GkfNonKjA0ElS8PnDrSJrjoz82LX06xCX
	swtQ9wpMadKQqx0pEMf1w==
X-ME-Sender: <xms:onVuaG_ZIbBssKbtaSPgRsa3MoHJNhYcAFd4CRjmpW7cyyaSNuSySQ>
    <xme:onVuaG5EYFCndQC0_GGE1j-U51oPfFjRQef2XuOlhsfj_jf5zFm1U-R38vwQ1SSUb
    1-JjMYqaXIlVUfMdw>
X-ME-Received: <xmr:onVuaN0_uleh6oQDLPD6EMTsCMKNcw1aI6YSXk1OHXCFbTa0qo1lsVNwjU-p6tazWaymAXknCs8VwKkRG1KRIYlNr6_mFS70Yct_i9weGOHM8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:onVuaNA8MB-3P2ieGLE9IWXm5T4auWry94UGnozE19nuMdRBcFay8A>
    <xmx:onVuaP2vhKt_bQ-173BFkHflWcaypoKz05XArmwyIBRDCk8-NEhXwg>
    <xmx:onVuaHvvbLzuEvQjXOUtZ701v34b0Qu9cyto-eZc6YKR78ltzpVtfg>
    <xmx:onVuaP5wwDpx5voCYWMI66PGgyMZL5prHa3u-PnE_ynD8SWhmsk1IQ>
    <xmx:onVuaJg4f1WABeKyHQT-CRKW0lXVY2MxA3Aag9YNv9BG72yeWQDyxzor>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 09:58:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d69a040f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 13:58:56 +0000 (UTC)
Date: Wed, 9 Jul 2025 15:58:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
Message-ID: <aG51nFpH6kMT95uf@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
 <77b841ea-eab1-4e76-98ff-f7a16653fcb8@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77b841ea-eab1-4e76-98ff-f7a16653fcb8@web.de>

On Wed, Jul 09, 2025 at 11:45:14AM +0200, René Scharfe wrote:
> Build on 09705696f7 (parse-options: introduce precision handling for
> `OPTION_INTEGER`, 2025-04-17) to support value variables of different
> sizes for PARSE_OPT_CMDMODE options.  Do that by requiring their
> "precision" to be set and casting their "value" pointer accordingly.
> 
> Call the function that does the raw casting do_get_int_value() to
> reserve the name get_int_value() for a more friendly wrapper we're
> going to introduce in one of the next patches.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/am.c                  |  1 +
>  parse-options.c               | 41 ++++++++++++++++++++++++++++++-----
>  parse-options.h               |  1 +
>  t/helper/test-parse-options.c | 13 ++++++++---
>  4 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index a800003340..c9d925f7b9 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2406,6 +2406,7 @@ int cmd_am(int argc,
>  			.type = OPTION_CALLBACK,
>  			.long_name = "show-current-patch",
>  			.value = &resume_mode,
> +			.precision = sizeof(resume_mode),
>  			.argh = "(diff|raw)",
>  			.help = N_("show the patch being applied"),
>  			.flags = PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
> diff --git a/parse-options.c b/parse-options.c
> index 68ff494492..ddac008a5e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -68,6 +68,26 @@ static char *fix_filename(const char *prefix, const char *file)
>  		return prefix_filename_except_for_dash(prefix, file);
>  }
>  
> +static int do_get_int_value(const void *value, size_t precision, intmax_t *ret)

Nit: after the fourth patch we have `do_get_int_value()` and
`get_int_value()`, where the major difference is that the latter dies if
we failed to parse the value. It might be easier to discern which is
which if we called them `get_int_value()` and `get_int_value_or_die()`.

Patrick
