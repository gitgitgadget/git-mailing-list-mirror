Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6B3D9547
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696770; cv=none; b=ek1y84FzKNR2DYySn/lZPnbjjpJcJLAXnk/8m4J0L4b/I3QZcaC29jGONBHPMePyENhkL2YieNNVf1kJHSBbgjY1wwH8Uu+0kMIsWOdzhoU/MY1yiV0Uwjkl2waN0xwj8hQgsdFTSiSbh6NyhSuVBspKvPlrbsa3galv8QPwGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696770; c=relaxed/simple;
	bh=qMCLUAGFUXcFDLPHMUYQ18SRUH/qDEYvmc6zq1V4X2E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZjWGa8pUeq82NxMbtYzJyXe/z5y53FMudsXRbWeb4nGoWVwFqVM9RquMPrMQxrYZCTzv9pxcojrNC3oTjoliZZU/SS7l7/jPP/pbDb3nDxnxkRyyVNbyKO5L72BrOMMR4cLqv+KWmqdwyvJ3/TTbnUb2i1Wm1iAN/JTVNLN76Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nx9ZcLDI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx9ZcLDI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so4343335e9.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696765; x=1791301565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFe03kBpr/hHyhN/s2JqkxWpEmctMcxOEtLlESrOMGo=;
        b=nx9ZcLDI/+d7+cz0zcpaW++W2XyPz1hNFqEV2KYWNB9zs2MhmTxbDBKnMjCOgfnYVj
         20h3sqohI3WBpQFa1nYghz7sCGnUgXKMg0Ccjx6Of8IElRPL1dDrm6O0jo8R7Y7/Exu2
         0+qn0dt/Z1K4FoPPyC0Y6+kaQ2A4hBvmo8TLudgKOwKcSJjWd5kmBiUIP4cwTxZqk1MU
         NvQaqEJkuRJRGZ/aVp+VmbTlZUAKz31C/qrsPGgy94P/130mapNd4oS6I/zwyfOHPCp0
         YXtzO+ExBmZcj6dDQy6hfOq6/iYIeHxylxKef4BKJUZMbcGMQnQa6V1+gYAqym6Kkbd+
         fGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696765; x=1791301565;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFe03kBpr/hHyhN/s2JqkxWpEmctMcxOEtLlESrOMGo=;
        b=xKnMmChBuMXnVcF5LYkLmYr7R6QLA5HEDtLbOaQgZE8BUffZDPj5uoVgJgNrjJxVVM
         /aag2vExxhx+b+6x3NbWFwATZp/giv66o/tfCosUwbh/bmCHG+Ct+sDhNt/gID09OxTe
         pV3gY7gH3oQI/hh3XLr42ldsPaqABDemCd9SSE0IU8YBBp8+shBLIHizo8bvlc4AF3De
         BmGveUK+ZZKFj+/ZTdLb3eaMjIn55PSzaE09vXETVcCIFWcpzXn4IkqchkMa/Ytfrr8v
         /G7ksizk3t5yUJXP9n/HF0aKX7hGmpFmUDOAqn+sWUoNm0qhwO+Mx+hTIHhtJg+vv/kU
         9Y1w==
X-Forwarded-Encrypted: i=1; AKwUvBwciTaYNysk//Bm8YXYC1WSpVqnSe+sg8veNrUwQBVA2UNeLbCGQKkCXWnpocOq9whyuOs=@vger.kernel.org
X-Gm-Message-State: AFuF++l9jwUS17F2riCjNFlt76+0vMp9mw+vXQj3en3p0r/cMIq6zJ8f
	UJFbEF6MkQhCXpUPr5hbKlczbEFXAnbuFYmTS8DZKPicARxSPaWwicfs
X-Gm-Gg: AYBFou1wxhGQ8nyhbZ2gEhONibOUasDdOvYkGFowLyzLryGIZnoJ1CsS+KOd2ymd5du
	Xrvzazppej/8hTgAF4VuLtWlkSlAY8mcJJppGdMvwk50X20e64xSmVrFgxh/D4/6O52Xrg8AN0c
	ox6FchATQiL14nfg1nzR6reJPBfhz8gxTLF8bn6PhiWcSnrdepBSfljOZ8mAK1WCGKAP6k6iAr1
	NzwQuVFzJIFlp+SLCSVQ61eQ3pnMNDR8Up5I9LYGoX9kOnNGYSCOlAokdmjWNVY9K9yzgi/qvNw
	AuA8WOURiZOF+rjqmpeuSximc4kp4wAWe5Va3cjsARnN48f+9/DpeRfAX6+P4oISkY5EsR9rhgL
	2jpt3RN3mIcqaNhMKfIi2u5V31o97nTz/0RBIWjyprm0LPdQzg8PqvGnn+041H14MPjKD+5d4i7
	ZnyuEqlzdBYkbRaXxztwdHn8xaVVXhnoEayDc7G00VxRShQYWoqyiS7UTF/6EWBuUGH3Q+E4DKZ
	KaAq2p5WjvR4pNAH71i/ovxtQ/c0mXvqnZfgX+K8wdF7wWPiVio80c=
X-Received: by 2002:a05:600c:c115:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a00d766d63mr44680125e9.6.1790696765218;
        Tue, 29 Sep 2026 08:46:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dd27sm88073155e9.2.2026.09.29.08.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 08:46:04 -0700 (PDT)
Message-ID: <3547f4aa-649a-4f46-868c-0e50dfa69466@gmail.com>
Date: Tue, 29 Sep 2026 16:46:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/5] t5520: don't expire reflogs where it matters
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>, Eli Barzilay <eli@barzilay.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790684309.git.ben.knoble@gmail.com>
 <2ac371d2dc1425cc47bf369e88b321d3c0c8c605.1790684309.git.ben.knoble@gmail.com>
Content-Language: en-US
In-Reply-To: <2ac371d2dc1425cc47bf369e88b321d3c0c8c605.1790684309.git.ben.knoble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/09/2026 13:18, D. Ben Knoble wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> The "--rebase -f with rebased upstream" test computes its fork point
> from the reflog of refs/remotes/me/copy, and the entry it needs is
> the one that the fetch of the test before it wrote. Like every reflog
> entry the suite writes after test_tick, it is dated 2005, so the
> first "git reflog expire --all" after that fetch removes it. Pull
> then finds no fork point and rebases onto the merge head with the
> merge head as the upstream, and the rewound commits come back as a
> conflict.
> 
> Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
> default, 2026-02-24) auto maintenance runs that expiry once the reflog
> of HEAD holds a hundred entries it would remove, the default of
> maintenance.reflog-expire.auto. Which run crosses the threshold
> depends on the entries and maintenance runs before it, so the script
> passed by chance: a stash topic that no longer runs "git reset" from
> "stash apply --index" and a rebase topic that runs auto maintenance
> at the end of "git rebase" together move the expiry between the two
> tests.
> 
> Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
> matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
> as well, which expires reflogs on its own, where turning off the auto
> trigger of the reflog-expire task alone would not.

I find this commit message quite hard to understand. From my perspective 
the important points are

  - "git merge" uses "git stash" to clear any uncommitted changes from
    the worktree before it tries each strategy. The stashed changes are
    popped with "--index".

  - switching "git stash pop --index" to use merge_incore_nonrecursive()
    causes "git merge" to stop writing the reflog entries that came from
    "git stash pop --index" running "git reset"

  - that combined with "git rebase" starting to run "git maintenance
    --auto" changed when we expire the reflogs which breaks the fork-
    point detection.

The changes themselves look good

Thanks

Phillip

> 
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
>   t/t5520-pull.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 27f38ab3c8..bc818605a5 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -35,6 +35,12 @@ test_pull_autostash_fail () {
>   }
>   
>   test_expect_success setup '
> +	# Commit dates are hardcoded to 2005, and the reflog entries will have
> +	# a matching timestamp. Maintenance may thus immediately expire
> +	# reflogs if it was running.
> +	git config set gc.reflogExpire never &&
> +	git config set gc.reflogExpireUnreachable never &&
> +
>   	echo file >file &&
>   	git add file &&
>   	git commit -a -m original

