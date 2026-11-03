Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728663;
	b=1+0Qv6qovUaFxZ049SGe5HWrFTZkQDgbJwpxVCn5uSL1CUHruQswP3Jn3Bg2/r+1ytoB
	 owvkqrO+svyQ8FUksJlsK4gTCLDIGt6UcHsuvjZNGEII56qxdpz6QJohekpWq+LNNGt51
	 PYF5QBw/kRKpoy5Q+rOkkjhKiF4wmfEpB6U5w7y3b5Ao+8rcCghP06ZveuO8D2a9qGM6m
	 uNWX7Qk5ysv331aUWRbKKMCIMKnR/QPAh3Ug8iPpcw43xMqTUFMdnNFE2NK6iYIqadPck
	 Tsf4cx1415ClKQS0IigeV72BG3AuPqifygpJkiSAE7zkC3Vg2Geypz1m5/PWaNV9ymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gatpHxLQ2giViMKex2a90km4JMusQK8pNLcKw0JhhiU=;
	b=Sku2urMElkdH2XfnClf/BtBHD3rbHL9voePZscV08x7DhW9cwuEOGbE7bFcmAo5yy8Js
	 6Cv8S9lS/jHS7jdVA/l02UYNQI6NEWiLXXWGyHKGVKi7l9YJZt9fR9SG6P4fDX90HK3ID
	 rDd5aUJPhNAwSPXFX4AcgEMhzf+HWQoQaQimCn6qHs9DdAwq5ZLgbLQvpBvTNo8R/R1DL
	 wVUhzFzZHqOBaG6kbhv8rpzkV3MaKMzfdFEvU0afqljujuausiEPuhuAAmcVFQ1VbMqaS
	 fNHeLS1X4Uqrkia2hzwAHak8u6kPS5A24ex3I1ucFlraNCipaLUrJnzjcoonagaD9Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KDaX5HYl;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E77606A328
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E77606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KDaX5HYl
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-170135e43c7so2856933c88.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 09:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728662; x=1794333462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gatpHxLQ2giViMKex2a90km4JMusQK8pNLcKw0JhhiU=;
        b=KDaX5HYlNa3QkQsfFOkl5tj7wpsyAM9Z+DhA7HBVxOeYFGr+WaEsA1kTfVkuPa2jd7
         ZjyzXzeB9yZDiaSX/V+Xe2m7cUHIzjHT+KgF4nyAqlwaI2oov0VF7A1+5wLOKQP4iKUv
         Z0TFQDYwpAUaQSjGhqYS/QrSYHszdtO3ft+v3EtI5TiS/5MCmaAj7T4AVK1nveKhf7YR
         DyB9+QUAH7ekSVriQdZBApFMrh9RmaVVlIY6CHPIkIJb0y4MdfnlYQhj6fEh5Yq2grnt
         KtUiJKUBPE0kev1e72DwK3cVo+PWWmFjRZkP1UlfnXQtwWNnByi8vybfTTcYvrgisXnq
         VCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728662; x=1794333462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gatpHxLQ2giViMKex2a90km4JMusQK8pNLcKw0JhhiU=;
        b=RaCHnE/8yLhhqIaAwE43K+FUw7VxWFjLmPqdFy0vMCVje3NuHOKKf42snhkelSRLVC
         4/mHGTOawMJ4y8YQStGrrTY6FXRQClWcKfhpB/wmJdfH1W+6G0CT3s28+5IVB8LBvPql
         n5sHXWuzkNTsFNhmZjMX1pEhFdY9KnqZzEmFBNFfY609yjORcwKQFU9y2nk/WKJFb/ww
         ucE6CbPJfbUscaD5+5sI2NmLpF4XoIGOlePF/vIxZ0OZ1+wVfXstt69rTIU3WdmAjJXI
         1af/MyzZ0fqhqkY2fr1essqHMs47D4v25lZ+DAXB5Hiakaes6DX8qO/1L3N+LY/QwqG4
         uZ/A==
X-Gm-Message-State: APuU4Z9eFcFoYIvRI2EO+bQKPRaMOBMPQhGwEaMybVaYtO2MwTcX7wA7
	eYOxHOP/fIlLWOzSBM/qsnvvSZL/sdBt4iccEzxo/7KqPJjL+R1oMLa7Arbweg==
X-Gm-Gg: AYBFou2j9OmExXrXgZvvNr0g3YJ+8/zLmkJqQqliz76ePUNeWx0yeoUyShOu16TvbN/
	KH68F10J2cMCH0i9PCWnwJufVMncK16Y2w7kd+MzlEW5acMmVgYhpmuMKSo20PaIprQ03rlFuM6
	I/V5joznqyWgjSTF5Iw4xyCcGLCvAz6qcSe6ml2wLW6FqzIJqJSEE5Ij8tpvzHjKGAxlvZ4F83e
	xSDV/IW+N1QbaDcSEMoAekKpqVoZihaTQdWkxB+/o4cP1PfLmjf9S+zXctZQRIo8qw943nkmONY
	cAA5BUPgpBp7tMrjyn+TnZh9zlWFnO6o5rphJV0LGJybxMGCcMYHRuat5u7nAV0dWvLKGH/xNwb
	ilXpXp2GOF9OwG0HA7nwbUL9n+4fGQA/2EYcCfp8gpbihrprvRboL1LDhhMqugzKAEQokTc3dd6
	Nk50413nAXKFK36H00gLDs0bLgqCzmRBZd0KX2DzhkfAJ6PuSyOWqJ38qKyGjmE38unWA3NAFaC
	eEjfshKNljUV6vwQfLFo8llxFJByReq5kX65H5Z5xh2TK9bZ5MT5FGnu8NqRCTcWaX91Q4nJsmK
	W0b3AsiL/XQ+Ci9ENuAHhRepw/0nPMaktv7lFvO7kwL4rd5rYg==
X-Received: by 2002:a05:7022:208a:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b042725256mr12685291c88.17.1793728662202;
        Tue, 03 Nov 2026 09:57:42 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2ddsm477617c88.10.2026.11.03.09.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:57:41 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: johannes.welsch@googlemail.com
Cc: git@vger.kernel.org
Subject: Re: [RFC] git branch: add -s/--switch to create and switch to a new branch
Date: Tue,  3 Nov 2026 17:57:21 +0000
Message-ID: <20261103175721.1148-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CA++gwosYFaOLD5nZjKUUFtp1ryezikqAsD6vu=uqBzOwyszASw@mail.gmail.com>
References: <CA++gwosYFaOLD5nZjKUUFtp1ryezikqAsD6vu=uqBzOwyszASw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Johannes,

[snip]
> when I want to create a new branch, git branch is naturally the command I think of. I want to create a branch and also switch to it.

I get your point, but wouldn't this introduce some overlap between "git branch" and "git switch"?

Currently, we already have "git branch <name>" to create a branch without switching to it, and "git switch <name>" to switch to an existing branch. If you want to create a new branch and switch to it immediately, "git switch -c <name>" already does that.

In fact, the git branch documentation[1] itself suggests using "git switch -c" for exactly this use case.

[snip]
> switching is an additional action when creating the branch, rather than the primary operation.

I understand where you're coming from, but isn't this separation between creating and switching branches one of the reasons git switch was introduced in the first place?

Would adding this functionality to "git branch" make that distinction a little less clear?

Thanks!

Pushkar

---

[1]: https://git-scm.com/docs/git-branch?#_notes
