Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832BF1D1E65
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305341; cv=none; b=dZiBXj6xi3fusacrGtJlxm2idJQJCksDYdIIsapzIjsPCBnuO7LLIYhh76Av4zdB4CUIzSlfEMSoRuDKLnBYRMtp65G/2sptHK7Zk3RruyySfXu3ZFFAVP9XvxwmehLwAEaFAB8pzWLkJWaGIIvgIZfw2Gwup3+9PHEB+ow/pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305341; c=relaxed/simple;
	bh=UvaDPp12LoQzlU1vksy1KuYuM7+3NByC8bWnrknpMOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQtNbyIZ6o4BvtePjjbD1io5Ef+Xx978Aeu9pS/Dn5ZHDuod/uZSDb+F8UwRqJBM2ucQ5zOMhZUm+9bJAg2GFRpvNVf5sCGTDi+BdyZcS0M8uMvbTOHg90bypO1wLKaIXoYBSP8RYNuKgJqDtBCpaP5HtplXhfSbR+8X0icB7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+6ukjoD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+6ukjoD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b64584fd4so40904545ad.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728305339; x=1728910139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgcNovxVGRGWI2etgOXUNPDgGpwAO8IsYigqq4nS/wM=;
        b=X+6ukjoDM2xt4hD91pJ1+SBRu7yJGnEyZxoplLI3n9dFZJmRnGMVRfeUMBRyM7bSEI
         vW/P/MZ+d57wCwsZ0L7Ioivq6qFk8WWCAKhEfnyGOD6xlQU+BUeu3GXQuqC4gz/9YQzn
         dkctszaXbaxqVKUHEHfdDdp8E61QvxkeAkWPJKhBZiDQ+TlsERHoLvqcijWsMxbuX4Ea
         UqVljDRdksuDhl15nQEXXZ3SPj0ogiIDHhQh2SXpAQ1vPUF0zKfxUgLZ6sN/Bwm3Fq4Y
         En0fSPxd1xC1STxHGuqzVNlmJTyjrZTJYL7+ID7W+MgaP6eIdTEVdEYr4GFTb5P5uv3e
         +Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728305339; x=1728910139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgcNovxVGRGWI2etgOXUNPDgGpwAO8IsYigqq4nS/wM=;
        b=BoI9j+DSsXr00tS8atKAv43LVsg3JiSgojHU3D57rcsZAcrZ7+Ns0ZrO+oN7meJyVf
         YrP+e11yERPvBqJs7rBBIKKjnEYtkwv5kDhtfM7Nz2HaJuH4zMvimmtNeUIQ2F/LBqJv
         HuJ6l2tSm79bN4hvre9siRapsUEXNiWqJKajYIXYrgfkwkVhlf7brlQ2uMWfpIbmKwYI
         irwpn5wDWP8YspWl04wdXSR7Xadmy8LGY2Qy0iyZvTrW3Kua7tq3T9HXjkMR+tCRZ5wl
         Y5rP+O9lfoddy45Z9QA43hiEZPSV3a7q5XuSwTKzKKqASn9wJkYxnRt+hUDTkZayjVuM
         Aklw==
X-Gm-Message-State: AOJu0YxTnRQu4AmF9vrRdMSL+XyGDSc1/Cnyb+Cx8D/g/J8M8ajoAofh
	XWHpXNkGZundJMl9igWlD7BevoIohYcH32nhwHzxNrlsUXMSNion57B1+haM
X-Google-Smtp-Source: AGHT+IHV7c7U2Vu1ZW8MAAd3LuvCQ8sdTm4U7k98SAF9COTqPWqsroxdSC6WzT3Rr1CoUOvhKMezYA==
X-Received: by 2002:a17:903:32c2:b0:20b:8d5f:a918 with SMTP id d9443c01a7336-20bff225f4bmr180053415ad.57.1728305339306;
        Mon, 07 Oct 2024 05:48:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1398ee12sm38902985ad.287.2024.10.07.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:48:58 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:49:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/9] add ref content check for files backend
Message-ID: <ZwPYwbeYJn30pPnM@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
 <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

From the discussion with Patrick in v5 and Junio in v4. I conclude the
follow things:

1. "fsck_ref_report" should not be refactored to accept `NULL`. There
would be only one situation where it will be a little bad (the content
of a ref does not end with a newline). In the other situations, the
message part will be useful, such as:

  refs/heads/garbage-branch: trailingRefContent: ' garbage'.
  refs/heads/escape: escapeReferent: referent 'xxx' is outside.

Although for some messages, only use fsck message id is enough. But we
could also specify the message. It's not harmful anyway.

2. The mapping from fsck message id to error case should be one to one.
This is essentially important because the user could set the fsck error
levels. If we use multiple to one, we will give the user a bad
experience. We should avoid this.

I will wait for more comments to ensure the next version will be better.

Thanks,
Jialuo
