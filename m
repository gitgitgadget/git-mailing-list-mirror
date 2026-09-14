Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A313E49CD
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367395; cv=none; b=Q7CrSUuXLpxu6XfrQjTdklNWfS1KjfWkxIn1eNlnOkMnfnadFZhivU0CSC9NGO+scEkGUn7bv5Sb7i4Sn8KjAv5iOD9xdCiFtEDh9ICm8J96Xnt9PTJR+scVrWrCfWjtdJcmeAJ6EHZRJHGTnL0JSi/4UDfmVmeK4o42xZxH3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367395; c=relaxed/simple;
	bh=MqPjA5H87WS1xx/CYPWHVDVuZ0HeqVUC+z1SPg6H7AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyn9Y5fj33Nhc3lcRqPNDXWGhAYAyB9+JmverrbCCaYo6lNOLLQ8MI015GzeG0S+4kl7r5C/vE+8L+ynOdE4mQrM6VniC8/K0C3gL1eGN8mNPyKUIX8hdLrtxLa73usy18pldU46E9Z8WXUEl+zkFFdG82jXUZZN8Qk1WP3JI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EdfFPzzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=agMFu7YW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EdfFPzzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agMFu7YW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C69651D000B4;
	Mon, 14 Sep 2026 02:29:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 02:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789367391; x=1789453791; bh=4vrVDksBPl
	RGA0M1Sd1CgUng5Ndb4ojskY7SaW3M8JM=; b=EdfFPzzhzXktiF5UKcRPVJa2+D
	d0jIwopRfj8BbMZ4D7o/QomialTm3sYz8ZE8CWkV3bkYlbI3kXLQc3DtIVC+z2rs
	xqvcBfGX9USTWqBC56s/hl86tjejgEgup+Fx3iIOsLN9xdVEe1sEoy+ChP/RNGk0
	kFa+qOUEkzSGkaamXFnYraVZOGPYIsFrCZsyH4q1vULzPc+JtBEUxtwjkoTgLzBg
	MZcvZ5o27+x8lRq4OxUc0sJB4UQyvgonXC0Q2ODrhVDaQQkgu+m92VKISmV/C4VR
	O60IfXJ2EITf8hmG6+scg4GFtYTQXpEoj3gT9s64NEGSstWwnf5elGh/R0Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789367391; x=1789453791; bh=4vrVDksBPlRGA0M1Sd1CgUng5Ndb4ojskY7
	SaW3M8JM=; b=agMFu7YWFDc3UxEwlQPeb6R/j1uUV3f1zBfyZq92+S9n27EF1F9
	WN8rywhxXYaKWPChxjKsh212CY+nFg8FEkxtt1vrKeuVnJdq8rT9Zp7YaoXkr6sy
	8gjCom0Nds3RKmWzlBSCJfS6r/OQq56d/MtUmkUcYyfddkGF16gZ1l/wr3v8SSMe
	ou8HKeupAg1KEcK7DmIUmEZxR+UzdDGTnz/zaHs63t+5LFGBwciKb6m7vIrmizk3
	FN19Ua8HI6wiC9Y16TKUPlct9GCyTKKMxdLrEQnC+LgDKyL82c5+o83Ygo5zkcDi
	n7tPyMwH79cHgBTF5XiWSroX7JTW4ZmJtGA==
X-ME-Sender: <xms:X5SnanHZNN9LGnTT60C9vvehDrrCSYFC0xI4g0embchr4ULUM1x3qA>
    <xme:X5SnarwS2qjvjNbnIzBi3DsNplAxD4LCU4MM_sTFNZed_yIjansUW_xG5zpzQ_HFt
    G51J7dS--wGqueNczgCnil7A_FUAzdSB9kqKvL_MJE2hOJMcWTIrw0>
X-ME-Received: <xmr:X5SnamjqfFNx64pbD3-jkYChmqvJffOA0pScyJ2E0AeN-_wB_UzWVCERZXQoYtxCID9iWA>
X-ME-Proxy-Cause: dmFkZTFL1gQ0t3KcCNFzwypEyliJOi6F2e9gnSwUZRscWCAjQmv13lbYny85P4KUGDrcwN
    bdHu7LUHo4hFTka48pLT7aYIAJivYWAlGUpSiRQ63VT2yXJGChijrbNbF9MONd5mA0s43o
    3FZE4StgP1Pdc878GFObP7Iz66TwEFJR5Yl5bgUhGD33ySJyvgbG5KrUjJ/6NC/1UkszZ2
    OzeZZaT2gdIhL1Fwp8RN0nyjxWsM9xStOD02Ne6JcjsOqU1+GH9u7UKQAlnXHySAJ9aErY
    NQYJhoNXQL4wIPV0KWEJPDEtrhnDLXaLpvEr4X4rDNjb7D5y2uLlH9cH2uGPhm4bICp4jA
    wa8OaIp/XEuTTgu8mW5iTbs+/Co58cFBnY/UMxvyFxTfWlUfog/RgysUZDtQjH/0kaVmZe
    /vgVH/83mJVif9uMgji2nDg6suVm5OrSuibhnZcgMao3/8g0Rqy6aYNu7rz+fyI64oJKk2
    PbYzGJMMhuHg7AXGzoNxq39gVZQq+Yl1MOnmcv2jKKnSnpbtidhKvcEHNj20KhzWsoqDhk
    vgGLK7asShsgk5Ou3yGEqP2LAov6GNFEjwCmQ4vSlBShKgpP8YdybUjCc4sOU5GvOrFsHw
    QaHFeqqv/oKRL6tmjlVA1Je6FaCs891HKSAeQQfswnj8bGhGKM0RWN3/KjMg
X-ME-Proxy: <xmx:X5SnauzBc_em6C7ZcD-sutLOz58pTlv6vtcy3PFaXEEniD2nZp-tIw>
    <xmx:X5SnahIVdTRcR3vZgsinonpaFMZqdOle5AI_HjMSRtINe4b1ZMb6zA>
    <xmx:X5SnatSl8ZnYa6epmFbUxD1rQOI3CHGDrNNooUJnF8yRVRuJtJIFIw>
    <xmx:X5SnahodI8yDJNpxxY_Smzh7H9nXKjmvgHTRrDMUAR0HZ1CXHTRQng>
    <xmx:X5SnasO224eWDSaH2boKZWuqy41t3eTZn4dRUpHgHomb8HeWacpoW5W5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 02:29:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb6bcd18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Sep 2026 06:29:49 +0000 (UTC)
Date: Mon, 14 Sep 2026 08:29:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH] completion: complete 'git worktree repair'
Message-ID: <aqeUWrx7pbzDVbVt@pks.im>
References: <pull.2218.git.1789171955370.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2218.git.1789171955370.gitgitgadget@gmail.com>

On Sat, Sep 12, 2026 at 12:12:35AM +0000, Yoichi NAKAYAMA via GitGitGadget wrote:
> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> 
> Added completion support for the 'repair' subcommand of worktree. It
> optionally receives a list of paths to linked worktrees or paths to
> worktrees with broken links.

We typically write commit messages in imperative mood, as if instructing
the code to change. We also briefly describe the status quo, even though
it's not as important in this particular case. An example could be:

  Our Bash completion does not know to complete the "repair" subcommand
  for git-worktree(1). Add support for it.

One could also try to add in your bit about worktree paths, but that's
something that's quite obviously visible from the diff anyway. So this
may or may not be valuable.

Other than that the patch looks good to me.

Thanks!

Patrick
