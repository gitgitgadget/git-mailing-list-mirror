Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449241C7B62
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405161; cv=none; b=kh3Cxra5dkrIISXmxL1Oj10h7noHOlHXhKtPWhJOcRsW6msXeCWoAJFsv65Ggd/CFQidSyFSo8gwxVGS/SdEKMWCK+rxKkp1x+8//2mUbL+Nwt53qF9XMqgtd8X+EOjMGm3OQnUK9PRiSXChnTbxpUjm/tW6sGlhoAd4geMpG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405161; c=relaxed/simple;
	bh=rqgQNCt6QUovPxJ7cfUtjhTq5CII8IJjndeAKYS4mYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQHShY2t4MrIISr6n/EuiIQgu6gqgkzUmYeKfRMLCe2LD2o4VdYYd8qBJhxediXP1OobDa+JnMr5O4mJM//ItvEdgXCGnbWodSuZhhPjSHlCs+TH4oCMZmouSyoekyM3w4zIluaMifjo8KLzqFXt5yCrOF/GytiMivwjc35VUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xOyA/FEO; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xOyA/FEO"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e3a97a6010so15102857b3.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730405158; x=1731009958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqgQNCt6QUovPxJ7cfUtjhTq5CII8IJjndeAKYS4mYE=;
        b=xOyA/FEOpcS1KUZRTpprzDytNyxPL2jxdYN2v+R0oduOcKM7d2xbKQ+0hYPkDWrjVr
         4Rsxp+iImIW9mJlXGayivQaaWyTZY/vuQN/LIOrW5MgEGtmWBJ5zh/rWePTe0t982f7G
         eIFGEznw/46CifGg897+tJP925qDlTe8Mdc+xmBGLKU3QiN5DLw45KxISBfug7hIXjTu
         uszjIbVh0LY4FDF/0ux+0viAg51JvcOQIRCCV8bb47G091BNWGkwYEgZSt48gTbSTw72
         R3f6BVqzHmNtv+r5F75T9BPclNG3KrhnxBnx3yTU4gjl2H7v+BnCjTa9ozBNSHOeIW5A
         4dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405158; x=1731009958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqgQNCt6QUovPxJ7cfUtjhTq5CII8IJjndeAKYS4mYE=;
        b=HMi0ya3R3VgHQ0zmh17sHVKzhtvJC2uEU9ucSB+QiEyC8Z70sOgXD12OxGxAoW7qeI
         metBlQw8CVF+KUaAtD902XdSV0lRz4ZagxwsDOVvZEv0auRiLNbjS/SP55Z6LCJJ3t+R
         KnWlMbyEjhB1hx/erYxpXLN2VPG08sX3P51IbRLO6q3FriTyMjmnozPhgIBTYMsW9i7R
         KuzdSgfs6S/VrsrsFMVgmJyhKKPZiogSczJdXS2BlVKzCz6vb1slVoRMKncIByqAUzD5
         qvTzzlNu6VOFMH1bVSwg7kE188a8eTG1JGMvTNqsaV+NAV3/S0dqWuPsUD+1yKTfstw3
         qtIQ==
X-Gm-Message-State: AOJu0Yw5vm0MF7kDyYkIM31q7guWHUcyMyAzN3/p7EJ1ZONuWoQn81SX
	v80dl0LztquH3n9JxbTTpYkg02oRuD7vMGjfbGDb26nXCWOb0BBxnSfhtWH+oYg=
X-Google-Smtp-Source: AGHT+IGl+VcHJVf7WsQ7ArejE77k80FP4pfTTaeOUgKOU1aOHrBjyGLJllWZ1XfOE+zwYZsUsf8N5w==
X-Received: by 2002:a05:690c:94:b0:6e3:1e5d:fe2 with SMTP id 00721157ae682-6e9d8acb426mr204019687b3.31.1730405158101;
        Thu, 31 Oct 2024 13:05:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b23ce8sm4073367b3.37.2024.10.31.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:05:57 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:05:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 0/9] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <ZyPjJKYZzeFGLxin@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1730366765.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1730366765.git.karthik.188@gmail.com>

Hi Karthik,

On Thu, Oct 31, 2024 at 10:39:43AM +0100, Karthik Nayak wrote:
> Range-diff against v3:

Skimming the range-diff, this new version looks good to me. It would be
nice to hear from another reviewer or two before we start merging it
down, but I think that this is looking good to me.

Thanks for working on this!

Thanks,
Taylor
