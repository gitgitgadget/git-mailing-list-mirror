Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208122D792
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076588; cv=none; b=D6CawBVd6+MyxaBaZ9R2QzyOufJNvJdJtSdqy3kJFvkfhPRpeSsoJyQ9SvlOeg1FLzNS1fz4SisXf07HJ56zz+l2guySpDQn+3in9rUguveOVhjKNPNsfDaybaIKa7Jfa1UmJMv+T89nQYKqBl1Aw/UEqM6UtvR8k/n7s5USzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076588; c=relaxed/simple;
	bh=dimNp5TiAKAfMtBCidyI8DmerTc88b9eKkExuia106g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjdQTs2QvybhDWxNE8sMdA4IEzsW4yqf06ml405bmn1r8gAiqvZY9ZInQv5o+1GBlrAJYPCHKlQYSrXUV3+fy8I2J5v+2306CBoZgjrIYxNhX349NskOBtzb5Qa6PUfVHQRNtyAVNwXiRVfSyQcHR34VxbS9LvQ1Xn+AEdSZWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b7ZgvdCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iq3SE4pu; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b7ZgvdCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iq3SE4pu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E7D3A1D000FD;
	Fri,  3 Jul 2026 07:03:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 07:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783076585; x=1783162985; bh=9oezOVGhLR
	AG/HoMRZ1aCegxmB4P1ZKwP5XlLXPjPEo=; b=b7ZgvdCQxpvkyYyfXJ3GkctG/Y
	o4fO/BRzLOTOyxTwpcR3wflEVPOsHcHMDiHviqKZ13v2tz5PzDde0yVaY1yzwxgf
	y3xnMsu2sRs0BZrB/YWHOQZ/gZJa4oEetw09BLn5C8BNcMmH4pFP8t5ehlKoomSN
	SjEh9BJZojsoNEZN4vCPgtUSPoFMXrIuOgaTldsPQrXVM9kW0Wqd34pB0/peXhP9
	pCaonfLwoBR+XBfms95TrCfVbcLsfYMaTBlxHvijA08CnWjmTMiNHqYVsHD0CJKA
	oLzjf/YqPD6V/H8du8Wtj9O6jplVX/3DkmJZqi/JaJn1JK6YbFPkFMI2EE6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783076585; x=1783162985; bh=9oezOVGhLRAG/HoMRZ1aCegxmB4P1ZKwP5X
	lLXPjPEo=; b=iq3SE4puN71OFZFYCAa/7qF/CeyCpCiHURpJruUeuJXCfpvnvYU
	fwrmMMzOEGq3VGWeCghBoFaiFAORK15q6mcJHgOBObq50WM6t/u2xnCczrhODdEv
	VL0j4X5Dzd7DDViRV3xrDBuMd8iRpJMG9Uw8+yJPYfqpqPi0v8/GXpfG6/nGqFiz
	aGGidGDfN/8b+awzipsF//S9Xhxv0B/ead8QW70vVhkAuMIPzHtfhSjjjjakQBNC
	l1IcmwHUTTwqvorWgUkuE0jvgkhMUnp/gZ+ToNYdz1FGZjG0rcSfUbryo8B3KQLu
	NcLdBAMLhWQIbqZFuAc0SQqQ1hujPAC1DsA==
X-ME-Sender: <xms:6ZZHaoVGbdDE1sUwMmGVgjLatJ5XgYmIO7Fg0HlQ6J0mlpKQe0tiNA>
    <xme:6ZZHauGuH8r6xAdpY8-gPa6eMP2gvmv9K3rpWCYEqB2k6HwlagZ3uy2bDXTTF_Zvm
    ZW3SYrkHN_gdX6y_hGsDmkbI9PhInnDnO799u2IauWRl4TtUQBWMg>
X-ME-Received: <xmr:6ZZHasdYHRH3DijWWQPep8OUTccK5A_Zy6_cmgkxgEmmwN_SAsgdrjLKZlFA05b_9Vsee7M1ennfQKMXVEfyXlQigDDsVo7YK3l4LNlmFw>
X-ME-Proxy-Cause: dmFkZTF4C00PKcVvNrCTIvFIh+7YL4kJ+0k8c5Yooen9gD5Yrod9jmeAR4G3jiImTVh9oU
    tZcf7EAnJswtHQvGXSbj5mj5PqTPpF9Zh8Yn/YLah4+hpThCqIOFEYx3Efz7AJ7JfNnC8+
    Pri5tR+/3dJGmTOPzY+fb1cRNxyoRryelXzLEITtkJRsVHY17Bd3HE8icaK7G6cUrOEGzp
    LJ7YjPRPzqIi3OZYQcje6ZggU1aPg9buXF6ei2j1WICpPPmKS//SYkFSvOuk2j4tOYeqHE
    3+uggGzPfIKNVz7jkm6gwizs1KK2UQ7uReiHCo+3lrfOMwLfNSQKu3ehwbwl84++5J70CX
    V4jTI3WVBUAC1S0HkLm9V9QIXNXMF6KEmyUrduY4hhnR/3fbcB67IZWox+tJyud/n428wX
    yf5fK+7pV87VJkH4PJtl9cMTIVbzAwaZLzUYcaSEMI0YRE9s69sJcJYVhH4zavORKV7aCp
    eS587z+8Dgrh1/8nO8hQ34A43PO5xVzg/bc++am5e7O3mGC10ZlTeA/VCS3ew0eiH8Mbqz
    O2t3NmJ8XHQeKNz0YaJY7ISFnG34PvBL6CixQRy+vPheTA82sCrKVY09Z4ZGUB2XDkkK7/
    xSC3ycYGCt/hDOghCpS0YLhPIPHtLHar+fU41e5BNmpcLrD8DkrN5FZNlZPw
X-ME-Proxy: <xmx:6ZZHanLwsRTWsYk1aWGutAUsM8rx20GgeWZcnU7VurAa1bRpYHmL2g>
    <xmx:6ZZHapEUG4lL5prz8hOs4Jx9F5YOVc7ygS37SiW1o5fHgcy6zxgaXw>
    <xmx:6ZZHaiBJH2Co2sb2oNy6c6M7H6xoylU8TxrnrtsXpezfSvmAAMxVTg>
    <xmx:6ZZHak89SHvEzO6msnjjiWHjiC0tOs3yG6s9ZSWg9vkNAaskahe4mQ>
    <xmx:6ZZHavLV3u4IOkS8pkegTq7xz7fzTx1JVcxHOzp5i2fSPJ1I-JRnRooI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 07:03:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd754776 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 11:03:02 +0000 (UTC)
Date: Fri, 3 Jul 2026 13:02:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
Message-ID: <akeW4yFC8uuu2o8a@pks.im>
References: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
 <20260703-includeif-worktree-v6-2-a13893ad9a7f@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-includeif-worktree-v6-2-a13893ad9a7f@black-desk.cn>

On Fri, Jul 03, 2026 at 11:13:18AM +0800, Chen Linxuan via B4 Relay wrote:
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index f3892578e4ff..4e840dfdb35b 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -396,4 +396,132 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
[snip]
> +test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
> +	mkdir real-wt &&
> +	ln -s real-wt link-wt &&
> +	git init link-wt/repo &&
> +	(
> +		cd link-wt/repo &&
> +		# repo->worktree resolves symlinks, so use real path in pattern
> +		echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
> +		echo "[test]wtlink=2" >.git/bar-link &&
> +		echo 2 >expect &&
> +		git config test.wtlink >actual &&
> +		test_cmp expect actual
> +	)
> +'

Okay, this covers one scenario. But with "gitdir:" we're actually able
to use both the symlinked and the real location:

    test_expect_success SYMLINKS 'conditional include, worktree matching symlink' '
    	mkdir sym-real &&
    	ln -s sym-real sym-link &&
    	git init sym-link/repo &&
    	(
    		cd sym-link/repo &&
    		link_path="$(pwd)" &&
    		real_path="$(test-tool path-utils real_path "$link_path")" &&
    		cat >>.git/config <<-EOF &&
    		[includeIf "gitdir:$link_path/.git"]
    			path = gitdir-link
    		[includeIf "gitdir:$real_path/.git"]
    			path = gitdir-real
    		[includeIf "worktree:$link_path"]
    			path = worktree-link
    		[includeIf "worktree:$real_path"]
    			path = worktree-real
    		EOF
    		echo "[test]gitdirlink=1" >.git/gitdir-link &&
    		echo "[test]gitdirreal=1" >.git/gitdir-real &&
    		echo "[test]worktreelink=1" >.git/worktree-link &&
    		echo "[test]worktreereal=1" >.git/worktree-real &&

    		git config get test.gitdirlink &&
    		git config get test.gitdirreal &&
    		git config get test.worktreereal &&
    		test_must_fail git config test.worktreelink
    	)
    '

The last call to git-config(1) fails, which is inconsistent with how
resolve the path for "gitdir".

Other than that I didn't have anything to add, thanks!

Patrick
