Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272486;
	b=Ih1Ab+QBWBDhA9VEYNoTXSUD3zR4ktCtjvcTLqCFsGakL0qeoBdLztOQW/TL3QQlUTBn
	 Rqlt5qJzumByW13y7RZkeqQaSJOEFeJ4eVjIbHKlCFuA7ltRikPpPwcUcjDv0wrf6De4Z
	 UZ2gSBpXeEQWL9yjmhwH8ksDURpE4sfpGmlJmyYEWO0Ovv+4KmWfU+Ugr71DDbQOleyzh
	 6SDhlWjrCthgJDIfmuPEOuxC6wHNfqo47Q7nDGlfcF1qCQ1KCm83PdORy8pY08mlEi5Ah
	 jpZR6RQhVswW1oVI2X52C91AbWckqPygQ5WhPSCAP4qHQU6SkAsb6soIiNMGQaMHYXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RnqZmWpncscbZK5j8YFEjkgHssywGsqVwh1vmQS7dm0=;
	b=zlpHiFRcuhn2xn/3Tpdn9UAswLTK6pL9YtyHCpTzYKnLGGr4Y7PGHuLH1PKgp05Vzgnj
	 b1zZluM/KscqPnrXKej/0WaTVAjxTGX5aj9r6wcOuYCX025hV+Ecum953wYaWsj/dtSQe
	 N/tcgfd210aJrPA+MNTkKCwAFW7Gj7TjZTkMYtxNesrDhBEEqP6zx0IPZqTz9l7NvNued
	 5yYBm84NI7YBmQ2XsZ1uwsheg12yQckDmfglLHkvMKctIgYZNE5d+7PDfBHspfLkXtsQy
	 jv9IX4SKIeEa+bB/KQ1PAKkxLxWmRfLGKSFzAi2iWJswIUWT/Eab7dZSw+08Z7U33Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZCDzLDTr;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785A606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 11:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7785A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZCDzLDTr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so18771105e9.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272485; x=1793877285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnqZmWpncscbZK5j8YFEjkgHssywGsqVwh1vmQS7dm0=;
        b=ZCDzLDTrf0dSsLRdqk7QIAQXdWiMCsRqHWDRT19sjfcUENv9vsmOUntxCvfq40a2O4
         YBY0sczMU7r93t3b8G0kZ4H6ZtdZ3cBibThX7ghVKSaHhFYM7GAB6Q9sLHIbasjedGrZ
         FJKDV36vxT3HnDYYEauAbzGRSqsFxS6GieEHa7FW+jyLEPKZe7OIKosiEGFFRQhX39Nh
         SVHrYuJu4rSIlxAn4JnfJorR9tw5g/p4lOmeR2LhDTgqxyHpkSyRT/yVJXT7/XmQl0bQ
         gP6BbAKjrFWGmDP6PUGfyPC4HBQlWXYk1jbkJC/20nBNtaeCs/s3DMDfXOmrAeSliDr8
         c7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272485; x=1793877285;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnqZmWpncscbZK5j8YFEjkgHssywGsqVwh1vmQS7dm0=;
        b=syAFI8gAM9pvvQS9ZAHusopkJggULcI2ohLBd5YfFTJV3klJ2L9kG2DtL0ORqOhxpe
         r/kFfppgmBouTD3I+nOQj7wRnR+qU1SHnIt+dzoYfbXGCW4gN9btHqIgBZuP04QzwiIL
         NC2styuF5DRLevC5Pnbzhpk4p0iPfNn65t4gAnBmy0WrVEl/nBHK6I3FT3cUo42lCyoP
         O1WfWT7YriMRl1BPxtfOzJ2T/nt90Cvc9VM+wraqiG32Jn5dRs6HgMxeSpdHSbbrYE68
         GZvRxQNlYEkoeOs9Btm7FF7g9/WomGPCVJJtwLLpznFvaB9qK2VBWpVQakj/dbFwsTWx
         RPUg==
X-Gm-Message-State: AFq9FYLaemtYZChz4j9foQl/zpumLu3eM06Q7dailYnHnwqsaqST/ZYb
	oLmpk2LQYswliuQ8vF0d+qPGp7qgl1H/UzWLXwr22Jee0F9IgVFiH5Q+
X-Gm-Gg: AYBFou0TG6l/I0B9K8oi3Tki3z2eGLkBHanAzWBgJVKf3rJ9y721vw1tZdz4GHKFRwi
	vM/OKouoAcqCwmsHaCzyzqkiXSlZHy9Ff73E+RVzv2VL9KHd24LQH5oTiReZNkv04bP3N0sQrzH
	F+w40JwIo4A5PqJ7TgTkJ2VBL8BHQNcCCdGzr8crV4OpiEbyMXmKxPu2dRzc0ZVe6mEDQRKb1Y2
	VjZa+aWJeAivExgvh+55n5D5Kte76a9QrASCQVV8ofwbmw+544OsaMmuuzWjeP2ptzRZLdAOHMS
	ka00qPh2S9nVrx66l2Ye5fN0QkqsBXNcTK51ie6CH4zZPKg8ptu0Enni4/nvp2YvHcG/rGIQEPf
	Px7hsbl2lDkSbQYD7Qwyn2gytxKGTNGIhbuCOMWF+mVZDyaCZOy9umlh/gxJBQeM6EYyAX4y+V3
	FyNSwnCiI0gRm1Vk0yc1J5grgfq/favfbG8xq99aw3PZ+/2wqicUcCixSHV1sFzKGJFiyl+V80s
	5/wO5ZbjrM+owPHaKVm4+/E1f2N5qN2ctFxZPNKINotsFJ1Te2AbcHMqy0p8hPUAKLIVNSGcHdx
	hTRKtl6okjUN8nWk5RpHjgy/afxMAgPoaOcEFwDdq+b2LHFb+21oS0PCl3X0982ZhEOWCu9bN/A
	GZkpu2fY=
X-Received: by 2002:a05:600c:1d0a:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4a9678c28ffmr116462875e9.22.1793272484524;
        Thu, 29 Oct 2026 04:14:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm86267655e9.8.2026.10.29.04.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:14:43 -0700 (PDT)
Message-ID: <d0051192-8e86-403d-9aae-b988883ccfd9@gmail.com>
Date: Thu, 29 Oct 2026 11:14:42 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by
 branch
To: Jasper Mayone <me@jaspermayone.com>, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
 haraldnordgren@gmail.com, ben.knoble@gmail.com
References: <ad504925-cdda-4de6-8791-97a51a9d90a3@app.fastmail.com>
 <20261029044633.12429-1-me@jaspermayone.com>
Content-Language: en-US
In-Reply-To: <20261029044633.12429-1-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 29/10/2026 04:46, Jasper Mayone wrote:
> 
> So I would like to drop --branch and instead make %(worktreepath) use
> the same information, so that it names the worktree of a branch that
> is being rebased or bisected. That is a smaller change with no new
> option, so the naming question Eric raised and the --filter-command
> idea Junio floated do not come up.

That would certainly be a useful improvement, there are a few 
differences compared to adding something to "git worktree list" though

  - "git for-each-ref" does not have an option for NUL terminated output
    and %(worktreepath) may contain a newline. If is possible to work
    round that using one of the quoting options, though it is a pain to
    use those if you're not using one of the supported languages.

  - there is no way to know from the output whether deleting a worktree
    will delete the whole repository.

  - I'm not sure that it handles branches that are checked out in more
    than one worktree. For warning that a branch is in use somewhere that
    does not matter, but if you want to track down all the places it is
    checked out it does.

> Is that change in behavior acceptable? A script that reads
> %(worktreepath) would now get a path for a branch that is being
> rebased. I think that is a fix, since the rest of Git already
> considers that branch checked out, but I would like to hear if anyone
> relies on the empty value.

I think we can consider the change in behavior to be a bug fix.
> Phillip, thank you for the review. Your point that "git worktree
> list" output does not say which entry is the main worktree still
> stands, and I can send that as a separate patch if it is wanted.
As Eric said, we only need to mark the main worktree if we're filtering 
the list of worktrees, otherwise it is always the first one listed.

Thanks

Phillip
