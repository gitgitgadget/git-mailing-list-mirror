Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845748;
	b=rMrxo3k5WbRagtkZnAUir+LGPUpvqOCg1FdJE4eMb+qgfW44QuO4IHUQ9z1jxO8Yf+fZ
	 VrWJ8f79O0wIt4AK93AmRaDLDDVOlcsqqOkw8GoO8o47/zzeR7FxzZbrUTVHhGiBgaj1a
	 xnfzcI+tAyRN6IXDWrQG1eMJ1zVARJ4kpOTmvU+4gXJMay1tbIJH4heKc6F/ywcMq+b5l
	 V4rB6UTrZ15h13YHcbh8Z4+ArO21NG7cfxtvcezswM8EU2wjs4CNqJNdhRTcHvH8/ws5B
	 Y2D7W4+9Qw9tbx3xiZ6fHjAVsbC7jcR2DE35pKT24/zx+baf/HnIYh/IceQRmSFdr4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Eafmhd/gPrkzXJwFjbNjGHpfwpq4Z5QrRuy7AE391aM=;
	b=uQKJaILBGsROdo4Iw2WC3S+kOxj8mxQUtEAUFB3JQa7BItZgf9t0aTT+wXBRstocbmdi
	 VAdafwAY7W7J6sOVmwS7wuSmoVHFSs6T6ILL/Vvhdo5f425Av//zHmO9ekQxyvOaGFwBP
	 UDIS9eA9Lff7oAMtRnw4ndlIV0LUtXcTEgDsFHj3TDMh1dj4xQydNapPe537D8PM5mL33
	 Wrg/Edvg+e7v+AhoSLthzBhczSaBF//dkCUXJ6gM1vsBMaw5dMnz9ZlA1uqGjY14nTp6t
	 p7G1Gvi3FM3hatbAYLoyHhzWd8xDgJRKt7Tw6dEI9NHykCmCeRCOakEAsdEe6k3YJcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b="k/wgMyBi";
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F4606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=k/wgMyBi
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-862a5b64755so1206273a34.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794845747; x=1795450547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eafmhd/gPrkzXJwFjbNjGHpfwpq4Z5QrRuy7AE391aM=;
        b=k/wgMyBi28Qr0q8qUr0R118NVJ4/e673FhCjSgr8yUpLicc1GURjZuUkBqlSGzmSqa
         fHH+mSnmhXo0KF4n+GZcvo9eiEQx+2qyC5hhWMN6WZFPI1C+yQngYiVcoVUCni1OYXDe
         yei4BIKZQ9JPcK8bciWiDh7kf4mSlAYmkZhScb44A8EYB0CWHN1kD2IOXoZzNQTpQ/dm
         Ec+G2KpsLvN84b3bfcAgM9ZHikeK+EO2cFb9eIXMB/2yUSMoovU26uUdXNBidHmgTH6c
         Hjfze1XiUnKHFBeQ4K1YCXNp/bFCvTX7N0ed7o9Tu7DCZGJsS+4GAjghIB8d+LTLJ+Y2
         xF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845747; x=1795450547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eafmhd/gPrkzXJwFjbNjGHpfwpq4Z5QrRuy7AE391aM=;
        b=mobGNlglbDnoZRQ4hODGH6waSWLVAwpsOmWBSDUQI3UI3IGhYjsMICtYotsoBcbonw
         iTIv5kHRUsR2O7cCbNBF1xJ+nuOFUpUmuB7qjtFJqUYhQocnrTqap/sXuBYg7pa9wJ9k
         w3ixWySrebu+AX1rE+WJ8iyAoStyWm7cUboTKGaHFYiCBT/JT4hb6Hu5qJz2GlwSdGlU
         XWMADb+D4LfmgbDZOeCTlDqesZby+cO/zn3Jw5LAIHX/5dIQMCH0W7Z85pNtsRDmTf6N
         vAY1Cp+I8P2wuVwV+dfXJZpqEpDCa5mrfcZLIREyRQ0A0xIiG4aBIZf+TB0tAwI1l/t/
         Q9aQ==
X-Forwarded-Encrypted: i=1; AL+hErGCOHj0duTzZPK7PoPEIAPVydVaPl9O9ecN9OXVqBuiLSMYNOqeuq6BhFFayqzu/CJijOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BSWFwrHseB2PqOppRFu9detmuBtsRzFea4lECDUCSWLS4OVAj
	A2aroyhNjNWMpyQacmgbV+zH+4gLrUvZ6IU5G0O3xnzHoOfyoRmQ0KVE4ltnkjODp+qlwtCu+xi
	22/0U0CwJ8035snObTFPxQt3StvhqFBQJdyYQUI+Sj1SENZgHWTtfsLW9GLGlHq79zbAT9luY4m
	YFBLJpTKlCJqLIzNOg6HUwdkzfI9q1QwQ=
X-Gm-Gg: AYBFou13TPTKTebr5YwmIWElisVgGXltfcy6AsvGwT4cGUpqxWRTcma/Nr76UoG/LWP
	YZmjrKk04GLtLUyI1IG3Kt/H8FODuXjQucPRmKISihxd/y4kuWoyg+NZj79xTVtBdyavhphQXA6
	8CHvf0GsUyYKVPdENFSpf4Xb7owHqLNb6OSHn7SwMv/sZ4cOFoCjTEf7kkaWL2T7/z9HchlK09I
	Sl5XjQlQWuRqTS6BmACGoccuHwoz/dOM/fvy567cBOA/3gHcqiS8YTsHxJ84qGnc5PYRU4WRxnf
	RmbU7H77l8T0i/0IjW4kJ7AOXfyB425a/qvg1fFdfHAhF7H5Bg3zxf7wk6rsTF7dXNrP1fGkkVe
	ugSXlaeW2ZymypHW00pWjx+wuJktYiRNmjrX8VPNlhs/xUzoaEl0e5PKZu0ChKEsqZfmp1+IFkR
	5Mznpj3rUpEyK3bTQuckcRsF90T30x45md+F/jUzzKt7ybDg6FktKGDB/L9Qsr8U6URgwI7YtV1
	2Lxt5TTuzP7PAvgQWK8+UrwVdtk18dK7h3EcDJcV3iq5E5THHArBddnwQAX70dyRn3C/ssjzOCs
	LP/8JjICgo1f5f118Py2zz1fu1hCZ1fMN18YgP38mNIJAUP1glxjANRZKWkrk+VM2FZ81IW+ZxD
	UUOcU9Q7vD4QQwi1mmNjQicocqUq+pImwOdQxZymiw31blDOg8rzipYcqqcIrfVlrsANye7dKQU
	aCMm9rp1M17yVuBXysAno36bhAVwjggcASU+yvXN+8M8TgX6RFP1xi2f9QJPd1ZQLdUnYbEXJGd
	P/30gvxrudTiWBWZlTaBZY83Q0ZbVUG4ATKa8mX77P3WmfKhzuQ
X-Received: by 2002:a05:6830:2e13:b0:81d:c548:292f with SMTP id 46e09a7af769-8628982704bmr12884839a34.12.1794845747122;
        Mon, 16 Nov 2026 08:15:47 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8629dede41esm8967960a34.16.2026.11.16.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:15:45 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: gitster@pobox.com,
	git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	--cc=sunshine@sunshineco.com,
	--cc=kristofferhaugsbakk@fastmail.com,
	--cc=ben.knoble@gmail.com,
	--cc=haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v5 1/5] worktree remove: refuse a worktree in the middle of an operation
Date: Mon, 16 Nov 2026 11:15:40 -0500
Message-ID: <20261116161540.55855-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqld6wblrm.fsf@gitster.g>
References: <xmqqld6wblrm.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Having a central place like this is a very good design to keep it
> extensible.  In addition to "git worktree remove", we have
> protection against checking out the same branch in multiple
> worktrees.  How should this check interact with the checks done in
> that other code path, if any?

The two checks answer different questions, and I think they should
stay separate.

die_if_checked_out() asks "does another worktree hold this branch?".
It goes through is_shared_symref(), which uses
is_worktree_being_rebased() and is_worktree_being_bisected(), so it
only cares about a rebase or bisect that names a branch.

check_no_operation_in_progress() asks "would removing this worktree
lose state?". That is also true for a rebase of a detached HEAD, for
"git am", and for a cherry-pick or revert, which hold no branch.

They agree where they meet: while a worktree is rebasing "topic",
"git worktree remove" refuses it and "git checkout topic" elsewhere
refuses too. After "git worktree remove --force", the worktree is
gone, so the branch is free again.

You asked the same thing on [3/5], so I answer it here too. The
detection overlaps, but the result does not. There are now three
places that read the rebase and bisect state of a worktree:
prepare_checked_out_branches() in branch.c, the two
is_worktree_being_*() helpers in worktree.c, and this function.
prepare_checked_out_branches() records only branch names, so 1/5
cannot use it as it is: it would miss a detached rebase and "git am".

A helper in worktree.c that reports which operation a worktree is in,
and on which branch if any, could serve all three. That fits well
with the libification you describe below:

> In the longer term, I think it would make sense to create a single
> helper function that checks if the worktree is in discardable state
> (without dying.  Just return an error code instead), call it from
> here, and have call(s) to die() here.  Then move everything below
> the callchain to worktree.c one level up to libify.
>
> Not in a scope for this change, of course.  #leftoverbits.

so I would prefer to do it as a separate series on top of this one,
if that is OK with you.

Thanks
Jasper
