Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1C3E315D
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935168; cv=none; b=SjcN26D4j6yi8oprBR1HUWTSByl1dclgkm4m2f/c8tij5PgsH5T6dbYztlJqy4MWWubYYHgQo+80j5fZPhNP4CdTA/nI5ndJOzJpE6i1d4Ockk2LBi0/iUyhKa7iBMcIPrB5vLNtM+yeB7iFW+MM0uoYd3hcFtRd4ZNbshbAun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935168; c=relaxed/simple;
	bh=Hl717WDqstgWkt8Hwxz4XeBC3N90cC+nUAgHBYv352E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQmYfRkCNRKO5b3GbrnONf/uwQyX9r5brn33dK5rJ2WKoHcqK8TrVDVsVXbzjYAQYGv8yrY0Ed5r6cahon1MrGuDYPLgkom0SEpX67VLyes4iADSnOODeT+mPOcRMfnJSzB4HkoyaIQw+r1wFkJyFyJsAM2CSPp2XCdNZEI1zRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOxmFT+7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOxmFT+7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so1030818b3a.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773935167; x=1774539967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU8Re5gWirlRVL1rI7nINXQpgZipyYZkNoVLZ9MwOl8=;
        b=lOxmFT+7aoZW486muQGoSpmkXhjGXxEM72mb0jnkw99cd6yKVLT5YYO/yl/vk0jyZ/
         ZrHASMH6b1QljuYQuqEM53CDlFu11LXv8EzJwGUzHlm9UwZeAfQbdAKeBIrUnb0PXfhn
         z0YAe2cZL4+SJjBpn8Gf+/1NKtWMVtinhdu87326Pb2Nfq9OQwKMrvY961s6JRzSmU2P
         EKolUrM6uTtxQAgtj++7DYgFgdTHk5f+FQqbctJ9sPICXIQ9jz65JupxtvSRqnkT+z4w
         zpikUyUK+RM8gYaOgImWsxujyCB6yA7UQvyBgqCEWv3CrpNw7NX2Ancaiv7MDuSerSKV
         VKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935167; x=1774539967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SU8Re5gWirlRVL1rI7nINXQpgZipyYZkNoVLZ9MwOl8=;
        b=eblfVG/4Rn/QwzSl10B1Xsny84dCfMCJdFNQzJ0Zyzl0gdBAtnUvtRbgPJiCooAiN1
         9YKgABTT4ZWIFb/pCnZW2CwyfT5L6uguPn4JLNbh+OBDnJBb/hqmhkHwIr9LeO687z7Q
         YboHKRkG1VT7SP6zx+QgWMbvHCsaoXd/rKK6ttyGzkJWiZjDXMnmyrKbEckI+fhzMnS0
         fCFe1w1xGFdSv25Fom6/5TFFAlNGGW4JVrhhUJM/GAEiVD2h9fWL3LlUlMqHP4d2k6S7
         CDnNZ/GVMlcNOdfNGao06F9vJ+jU459iBHI8UA01gO8RmlYCF9gMtJhJ+8uD3n2sh750
         9Hog==
X-Gm-Message-State: AOJu0YxkmtECjK4Lk6XE2y56sBydSgsG2NMuPGJOb5AtDqA3yrvvbLNw
	bYJZhYp3PrWzcWpkyBg7nXmKM1JDOs4FvjoqHa2z+vCsZykaO+mdav0j8hlUng==
X-Gm-Gg: ATEYQzzzzyGBZjuQT4cmeNb2iGA4FiK9Uo0YDnfe2Y6n1b539gQRDlYtHaPSJxdQtQ0
	Vedi23PRdvHrVZq7SxGCd/vu0xMH6zCEpe330JHFXts8tfINYjblNnfahdEU4nOAgDB4Jn3T4Yu
	monBnajx5LEOmu4RyTJDsFpJsQlPMKZQxbEFaOKaflQRgQ9azYcUU++n8PiPGW80/WIWsMpr/sW
	Chm7anPl6D2/NajFBjnlt/+NLvSZdEj3BXP6dm3eGU6yjsAqC9UrVO9Nv6jA3dN6UaGuhebwgjO
	NVMjNAHGNCMWV27WNGr6IK5KS1do6FFH5qTR0mHN+M6v2TmX22a+r80z9BCwovrpEHuDUa9FXqW
	1FMvR2rdGabetHK7f+AOHuB/GblW4/7XrRDzI/N8GOAoCAgOwHgWyrwawhpxSVyw2HZYeLK5Yc4
	2YdmDkcMscjzAeuye86f1lbR21Ey6IzQlVk7zFLTfdZeM=
X-Received: by 2002:a05:6a00:2e24:b0:82a:780f:a181 with SMTP id d2e1a72fcca58-82a780fa99bmr4199396b3a.42.1773935166641;
        Thu, 19 Mar 2026 08:46:06 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:76df:bb95:3ddc:3aa6:6dd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b5308fcsm7614130b3a.9.2026.03.19.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:46:06 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: [RFC] git am: apply patches directly via message id
Date: Thu, 19 Mar 2026 21:15:24 +0530
Message-ID: <20260319154554.1328074-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqjyv7n872.fsf@gitster.g>
References: <xmqqjyv7n872.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
> >> Sounds a lot like "b4 am -o-" piped to "git am" to me.
> >
> > I see. Though I think b4 is an external library, and I am reckoning that
> > this functionality is used commonly so would it make sense to add this
> > natively in git am ? or it is fine using b4 for this.
>
> But lore (and the way it takes the message-ID and returns not just a
> single message but a mbox with all patches in a complete series) is
> very specific external dependency.  It does not belong to "git am",
> whose only purpose is to accept a mailbox with bunch of patches (and
> we do not care how you downloaded the mailbox) and create commits
> out of them.  Interacting with lore and downloading patches from it
> is what "b4" does and it does it well.

Hmm. That makes sense. Thanks.
