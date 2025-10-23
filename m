Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379413A258
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255110; cv=none; b=CtQzTNy/Ta3DvcYo4ppyFuz2rXOUXkX8Zeo/fcTNGlEvRlFLesVFLUdqpihokDI/qCNQyD2uhZusv3Pbzoi1SgTs86nvr52e4C4cvGHIPSIf/GEYQ7yiJ49ndizOEXLN3ThSbB8YxWTQWNixWkDHUmIa259Aspxj1muO0AjZhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255110; c=relaxed/simple;
	bh=06mCV0wyORyn+Ur2d7mRogBEds/mYNw8TnAQSDCNlMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilTCmJnmalkP/smKVUuXbydlB6wbop1k5aSlh9BxkJ/0CSw7s97UytFOf/PlBOFJw60SekPntwk6Lo9ygiD+jmiwbiLLvOOpOjgdnmSdHDyT+6RlyHprKq2FYtB7cwOIW4H2lN1bTUrVdRn32aAC1pMuIdcJ0y0i/tTeP4qOBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HBfmAyQ+; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HBfmAyQ+"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430d08d56caso6081705ab.2
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761255107; x=1761859907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQcnExmFzj3cZXKWznRZnoNevym/dYq1KKmjKxmfV1U=;
        b=HBfmAyQ+6FotEPJeQoY+n4sO9sMc7Ps9QWKB0BZN6pH9EzUWAFpw9rsR/9P3E5hTQy
         HwB8F7CL1U4q7XxL1pSDwVBn5nO5oRr7lCqJoFWAKBRXedX41RVoKYPrZqgAzxSILZV/
         8m24+NtC5TCGqgFO+YczKp0VxoqbISCRJm1GuDPy0eORj0dOKrF1QT05SAKJA4t0gFjb
         HavTUwV4jUVH1LV862x7Q81fhRdi0ZUFTHAl290IE1F7B4F8zNa5XUIzF174XIxkRpdj
         Tqeye1UwnYuDRVXnTyyizAvAA+rJG5HN1RFIcTJ2eIiTLIKHpyCHIlLhJRzC41qZ3KG1
         Vlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761255107; x=1761859907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQcnExmFzj3cZXKWznRZnoNevym/dYq1KKmjKxmfV1U=;
        b=cQKtOJLAtplO79rxWKm8vZ5KLRrP4nol+e6zaqDvVyeyNNwJy1CnqnOD2+5gFFTVNf
         MQ4GDBWSCo3pD7DxMWCu5kO782bVRzVkCaZWxslq78C2xx3b2g0UG+yA+z656shtiIhw
         EHuSy7v1NujGWXwFpYrWvuJ7thmopm5vkhCr3HZKp90C7Cwi6LrIedU3jU4tWaSLL0kG
         KDnCM5t7vtnhiF9vVRwhcu2XX7UW6Qa+jHpBgnKp87ZPgDUBWEWVLJg1fITtG5L2D1lo
         WCoHrZ5HLPagfEC3n0PqhEU1Xe1pEbhzDSENqRA05TOZFa/whSC/utow7qFmHXMNWV9B
         TwnQ==
X-Gm-Message-State: AOJu0Yxh8dyjgbg6fR/ztyk4SVh1MmRrIVUL8rGzE4RmOOgGUFOIXEpG
	qOy8T4HNXKpGEwy0JEy0r6ii37DxXRIuOx5tp7vK8CuP/CVTrooai4w4ILWYUCx7spA=
X-Gm-Gg: ASbGncsJiadz90RjjIO6lH1VZcceO9nHScR8h0ed3+LqAmkDPtdHcML0RP5uz1IRt9B
	/32CcaRjqenSkA47Le/JvGv5b0d+o6RTCZx9sW+sHIy4GFUE47u2IeZ1at1BFrbcdLWsQuk4dJs
	cijfRc7Re7XuJDgrWUJr3Qld9ufQnGLmyZTgpHLT/9zTvJQcURsTt2yfqXGijYTdAR7qR+Pz2dT
	/2ByOX2l4TubdZF7mfiKfOvIN8TjhsfdVfkPLE3pftIK6pLKUA9gQ+/0Z3YybcQrilyaHzMpG2L
	KrQ/8DvoH+n7jx2Z/HyxR/uUVqlH/4d3hnIrz0tLojY7wDG8aPKwlHZuSs0qpjCb9VY6h5auoQt
	KuDpAyMv02HM8XQNMXrvhBf86tjPjRnxt/uThffQs/4H72fjuvaAoMFnYvzjb+ANAZIwWzMPRq0
	M5bN3FvsrUnKYiObDD99YDjhKIAcRTC8XEK9CjnS+vw0WN8D9/0ZJU3fLm4TEDtpmk83pnNGQ/i
	jY6QsvQO8VlLQebWQ==
X-Google-Smtp-Source: AGHT+IF1nbLhRjok5Rkd/SjUA2o2V4sG/u0yl4Fk2R4Il8op5gB4NxYfoMKUVy2qOe6XMGDAZ0hn+Q==
X-Received: by 2002:a05:6e02:3f04:b0:430:c49d:750c with SMTP id e9e14a558f8ab-431ebed79admr2522665ab.27.1761255107353;
        Thu, 23 Oct 2025 14:31:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-431dbc31865sm14387535ab.15.2025.10.23.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:31:47 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:31:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/9] builtin/maintenance: don't silently ignore
 invalid strategy
Message-ID: <aPqewYkJFEyVohAn@nand.local>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-5-f0d727832b80@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-5-f0d727832b80@pks.im>

On Tue, Oct 21, 2025 at 04:13:27PM +0200, Patrick Steinhardt wrote:
> ---
>  builtin/gc.c           | 17 +++++++++++------
>  t/t7900-maintenance.sh |  5 +++++
>  2 files changed, 16 insertions(+), 6 deletions(-)

All looks good here.

Thanks,
Taylor
