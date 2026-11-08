Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162146;
	b=k3KuyVcVbV9E3KBxDMbvbNqAImCqP5h4vAHDrMSjlRl6XVW/F7do6EhFJiAb5d22T2Sx
	 wYJE3sxteF1KrLPh9mm7suzHC33kMpSwrz1ojQqe+WmwJomboYa6cif0dTiI90QSFOcI7
	 WNiEPuWbXZhBTiv7+ZuYdcC7gJ88ZZVPcQIIkqmwPaggRlTKTPk7K0lKD9NwkEiW+glkD
	 2gCZ5mIJU+Z/1OHqvaF3Pmk2glWSgC0J2o5TbugW09F4JM4ia8vBn4z4O8qI5ZKx7pm1y
	 VqpAj32X2bTHDPZSM2dgIQT1H5S1yNmmTyOlCNfj0lA+OVErXUnAMSXGKB8SLyLvMuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162146;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=s4NlyS6DjvIwMCZUTY3xjOtOzki/ICYTgGjefZi9mvs=;
	b=ey2wUnId+KwLvopo3K/GGUIj1pg4gIdwettDmBLmssmBuNopkHxlsEUKu2DqOxKXnz3O
	 DgBtkDbFLIC+qgRTOVfewWjAx3AYYghd9IaXD4fs5qR+9dZfRW/JQvzpmyncgnlPIomX2
	 6QEaFSl8iCg1F4cSKVX3kB2NcbJraTyxANWE7w0ATEthpg3U0GOkOBK1zVH+Hd/rNuSaR
	 1xDLDN3MNVn7uh9NCmXJtOLKMGg0aDZqswybBuXeCtWSLcindJ+43hU8UA8TMc9aFy2Op
	 EuitDePA+5Hrmm+8Qh6YEbQPdqIP9A0WG1LF9K6cBKi73ZhICP7Y6GGNYwr0jQNnHtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kzANCPf0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=siqns3H4;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2C606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 18:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF2C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kzANCPf0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=siqns3H4
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63958140005B
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 13:22:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 13:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794162144; x=1794248544; bh=s4NlyS6Djv
	IwMCZUTY3xjOtOzki/ICYTgGjefZi9mvs=; b=kzANCPf02tnqSg0vFQITx3v5m7
	/3olE2thbPzixAbuxi6mBpnpziMgiS+9jldoQ12Wn6x/voe+tTBg6AA6jWWgZrHg
	tLaOTbXY20h9r2FBRKiHXbu5PKUVBuaxgV+X8qjDSGo3SIR8RL5eAKidoffqVmZL
	mYH7LlnBR3KeO/FUJgukokRzQSZDPcbrsAZC03XLxEPVolHYgrPWzNpmZHFwjYOp
	VyiGHLj91b9u4um1cO5QiLg/VAPfaIpaZCgt6hOclwr2WOJitNbqcsxAhM81QuJU
	O709RO2yinc1Pk0bbl6GQ+2lTFw2kuW/zTakbDn4xL7Ndm4rbiVz9LoH7v7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794162144; x=1794248544; bh=s4NlyS6DjvIwMCZUTY3xjOtOzki/ICYTgGj
	efZi9mvs=; b=siqns3H4X10V6/JjMv7DXkBNGSdXBgEYKH1Y4InQJrc/I8em7D5
	0g4FhkQby4HTKu89eVJGdgoJPpgobH56u8lJcDFFBf+xSD8dkf3xWgeyP8BCBLh+
	4u90ErXaPEJlCQc8Jnf+0apWExtt8UrmH+919bH+ESaN6Jbxa2j8H7gtTUjxleq/
	JTcvMz0WwgDW7SsDCZ1K1bfGJTpIM+qaw5g7imwrLg3TwkqlqGc+1LX5Daw0PCzF
	xbBZ6PvGB+EW68mQkoR/TKpxPFd6kvXdVihvSqXSKk8KzcEG2jvYDxsUskaNUwy9
	e/IOZn5DMqkHMkgUyHcf/GVZGNonVqxTQ9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794162144; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aZOQchHJs5EO3c+nS/Ku71ijUzc4mEgSQES8H5+Wy25789B
	d1eP2URiKZtV4BYYFvANpKGRUiTAdidCkNpGENLVIwAw/0HTHPpHJzShTBh1ZP3t
	KH99srzZqejvLSv+p14Fu3m+7Y846qqJZ7ad9BI3ggOgvhE92wVELAquvHdrQRNJ
	Q0uw1qef3mC9podst9YkKCbjo5l/RkPPhkiXd7sDaTk1ebHDyP0qKq37utNAMm6U
	zs6ixZ7finqnaSqtqUi4I7f1RZ3TlQUsEjwB11z3MxO56EzAg6Ms8WPBPyXx8F5H
	t7YZWxEqHDpH8nrP6dQv245dd/uDO0Uh64lOpig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:1AFGh11WJlhQ45lsvena1SFXsJ+GxPDyH4ee2/GLxoQ=:bpV+MTn0agi1A7ZtGdNWMsklsvNuLSngRdJJjbt4rJk=;
X-ME-Sender: <xms:373warltKRgxNFvxs2fC9tit3m3RI6ellMzSVP7NfrnZ9ST7p-2PSw>
    <xme:373walvU8DHatu1CUg2wZhasiBaMHSasd6Om8WLuRa0XxCO8qMNA8hK-nxAMDpjsV
    N9y46X8FMO_Q9ub-abog7c_DifYvPmR-ZWvgh3bTjbTHYPj14U1Txw>
X-ME-Received: <xmr:373wap-_SvO3HjFpSCB4liO_TdIu7QGkQNYyG_4sJ7KwZm1Yn08wR_kize2ESIySnKwmR4YRRwSIRCziMCN4_uzJmdlzoPENWG2P>
X-ME-Proxy-Cause: dmFkZTEqIbSVgN1JUvkJJJJu9p+faSXJydmxlPxI00/k0rfEJ3XVXKK4hk32YHbDlDxv6N
    fkiPMx9LARyXel7VEtoUqYcexbZMKk7/2ug/b1LsNJAvqudcnTPSf3b41qGXA3fjUC6E1z
    NiSdYOF6+6K8SSgzlnnk3nC5YuM+btOmlbGSYLeauJEDsT/3Ns13l6fdnYvml2Hb9Z5MzD
    blnEx72xXERBZIAJQLDzDamH9Amppg5sMn9rYPpfm33vWsuCm45eI4q3g/rV4l+RYdILep
    GO5Gq7Q71wDWc0EwLYQLB4Bb5fdry083IFx1e7OulPj3D+ToOnM0Hv0o6R4zwO895wToK/
    F2IjzQCzl8U4xhdfU1/JlAFBXIhTsutw1WhJ1aHV2U3HpknrRHKXDGYF+zyJ/zg6N9jcRR
    3jPzhnReaOwDpdVP2LO348IZj1vt6vRzNt/7Fma3gII4JznVKjlAL6X6xgrqr3obJ0TIP1
    GpftHlFQL/qXUkpviltacuYraqIaM+UPwa8JbQozcHg5+4SfqkmlThDDXhYdgxXboKxKtS
    NvR8oIXioHxEc01YRjYuogvO545zFB3X9NRp+1A1S/JPK7VaDE2/MAdwlSzGwthUbrHixK
    5/d3RVTo0VHbeAKx9aaHDRuDZBkHAYWTdxIuzYRmtPW9eKP1Lua7K0NYvStw
X-ME-Proxy: <xmx:373wavOaMc0qyDYYe-IGC6r14Ui6oNKu0Wm7Tbwk2c43ZBeSa44vmw>
    <xmx:373wanEIb7Z00Ufwx_nY-sWCdwU_wuHAtFqT8sv6VoYUNTGnjz24vQ>
    <xmx:373watR3BDnqxa_yKkDXKCf-xtKxSsoGXulHceglqiVln5_R6G7G6w>
    <xmx:373wakvFOPABQF1ErXUd9i4alp000JROgEhKhwHEg3qLrumJS_pLqg>
    <xmx:4L3waq-C7FkvFISnxdjqIhZf3dCkGIkDn1ugQBI6H3hTa7680vkDLwFu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 13:22:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Adam Dinwoodie <adam@dinwoodie.org>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] setup: default hash algo to GIT_HASH_DEFAULT
In-Reply-To: <20261108011633.1772000-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 8 Nov 2026 01:16:33 +0000")
References: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
	<20261108011633.1772000-1-sandals@crustytoothpaste.net>
Date: Sun, 08 Nov 2026 10:22:22 -0800
Message-ID: <xmqqik274201.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When we have no other hash algorithm to choose, we set no hash
> algorithm, which ends up with us defaulting to SHA-1.  Instead, default
> to GIT_HASH_DEFAULT.  This means that we will choose SHA-256 in breaking
> changes mode and in Git 3.0, which is what we want.
>
> Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  setup.c         |  2 ++
>  t/t0001-init.sh | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/setup.c b/setup.c
> index 61bcdafe82..4a0dfc8908 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2830,6 +2830,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  			repo_fmt->hash_algo = env_algo;
>  	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
>  		repo_fmt->hash_algo = cfg.hash;
> +	} else {
> +		repo_fmt->hash_algo = GIT_HASH_DEFAULT;
>  	}

Hmph, maybe I am not reading the code flow correctly, but does this
not break running "git init" to reinitialize an already initialized
repository?  I mimicked the new test in your patch and wrote the
following just immediately after it, which

 * figures out our hash and the other hash
 * create a new repository with the "other" hash
 * run "git init" without specifying any hash

It is debatable what should happen when you run "git init" from Git
3.0 without any specialization in an existing SHA-1 repository.

Possibilities include:

 1. turn an existing SHA-1 repository into SHA-256 including format
    conversion.

 2. notice that the repository is already set up to use the SHA-1
    format, and that the user did not explicitly say what format to
    use, and behave as if --object-format=sha1 were given with a
    notice or warning.

 3. notice that the repository is already set up to use the SHA-1
    format, but our default format is SHA-256.  Because the user did
    not countermand via an explicit --object-format=sha1 on the
    command line, we should fail loudly, "cannot convert this SHA-1
    repository to SHA-256".

I think #1 is impractical, #2 is probably the best, and #3 would
also be reasonable.

But the behaviour I am seeing with

    $ make WITH_BREAKING_CHANGES=YesPlease
    $ cd t && WITH_BREAKING_CHANGES=YesPlease sh t0001-init.sh -i -v

with the additional patch is different from any of the three (well,
technically, because the repository is empty, we _could_ argue that
we did #1, but ...).

I wonder what the "git init" command does wrt the reference storage
format (Patrick CC'ed for this)?  I am sure we do not convert from
reffiles to reftable on the fly at "git init" time.


diff --git i/t/t0001-init.sh w/t/t0001-init.sh
index bc30cf853b..1d48a712ae 100755
--- i/t/t0001-init.sh
+++ w/t/t0001-init.sh
@@ -532,6 +532,31 @@ test_expect_success 'git init uses default object format' '
 	)
 '
 
+test_expect_success 'git (re)init does not clobber object format' '
+	test_when_finished "rm -rf repo" &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		if test_have_prereq WITH_BREAKING_CHANGES
+		then
+			ours=sha256 opposite=sha1
+		else
+			ours=sha1 opposite=sha256
+		fi &&
+
+		# initialize to non-default format
+		git init --object-format=$opposite repo &&
+		git -C repo rev-parse --show-object-format >actual &&
+		echo "$opposite" >expect &&
+		test_cmp expect actual &&
+
+		# reinitialize without configuration
+		git init repo &&
+		git -C repo rev-parse --show-object-format >actual &&
+		echo "$opposite" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'init honors GIT_DEFAULT_HASH' '
 	test_when_finished "rm -rf sha1 sha256" &&
 	GIT_DEFAULT_HASH=sha1 git init sha1 &&
