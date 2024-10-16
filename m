Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EB4409
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111645; cv=none; b=PLX0IUTwBp276qOwZmfIY45434o1ERuLQX75monIovkH9Fe0vgV7Y9Ivh8x5YUmrMwfOrGtxoZ9hX7cXrLyRxRs+MTN+BDg4IwJb6utMmcdGMvfF+uD0GdBGDU+lysFUMSfK4fBoMUKw3+OEKp7lO80d7yl5/tHzm5qIwZOyoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111645; c=relaxed/simple;
	bh=GYrk80Gyi6A3dNZvrScslecfLKCZZJFgoh01jlSDRcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvx47OkWzoynNn7Cc0WAM7q8FaGz1y5qGEOapXXR998kl8+D1npVHihu0MdxH/mbjgfJi/iJrSCuU4GzpQN8ZppCdoK2pXVPRwo3MeW5dpgmtoIRV6Zp0g2+2CFhmKOo6gV/+q9xm8o/b77At/0QgiVppk9y9rAcKf7ehX6eOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KJgwvrwq; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KJgwvrwq"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e292926104bso260855276.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729111643; x=1729716443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GYrk80Gyi6A3dNZvrScslecfLKCZZJFgoh01jlSDRcs=;
        b=KJgwvrwqT6OVORBahJjAdIPkcCPz33rcOwSSq2mOxeH6s3eymVCD7szP5rK1lmljSS
         xdjXqPp1fWPfRbJmFRqM1fSZFlng/UtrInfbvHJcx93wHTa9eOAnyntyFfYFO1lffGEC
         oqToRTKXkPqn142sQiJw1ClN2odQDOlyTvbX9ENHVdMSokPwlbheu2OQyi/ehGiWM7UW
         vhM7bBl7A5cylIDBl6o8umy/3PV5IUW1LdrW7ZpdRlsXrJyVpZWxluo6TdLmFE+TF/wo
         NI8ilvT2UyGqz6x7iDRWdYDamA6q17N02O6FbivtO/M1c5D7ki6BwEdY1eouq75ntO+l
         3HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111643; x=1729716443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYrk80Gyi6A3dNZvrScslecfLKCZZJFgoh01jlSDRcs=;
        b=kyqeBGlOAe3h5K3sMlTEwBNdOI+WhHP1fnayVUqr6U/K/grehfwevstVs5mfO53jUX
         QNCKHMZOSU4aT2Pq3px+wqmd88odWEgYNzhkyHtNaRNLXt7E2QKVx2B87StH3ULGQW7q
         zDwfgKy6pTlfftmQiiy6rIzhv0pQmzjJLeQJjpLJzeGqw8KfUAyoah6WQdg10tQWRemz
         zUz5ZeRCmaxQHRfuWYopMK0UyI7s/ZLz5QEwoq3cBse/uRK5E0eZmmN+i41MBOxGXl1s
         q6taSJ7+AEYGj4gvRTywuuS4aLqNGudhfxufeqiUy9fxYOpY00P/6usIgT2ZzmQ29tQK
         Natg==
X-Gm-Message-State: AOJu0Yz4bbpQ3iU/j9PIJsb3DxllJ5x15YsWA6MYEkoEb/h4HuiMh7Ta
	/12PINb9nqY/XEcE/237cInd7iAUJ8MeFRKTqxPriJxGUDA6jDbfvYvqnZtkGqA=
X-Google-Smtp-Source: AGHT+IGdHgFj5r1bVO23KunTMFSDInRJobqayZhR4iJR3ZieehKOTmG3w1ux7hWcjAaO7B4OQPbhTw==
X-Received: by 2002:a05:6902:2b0e:b0:e26:1422:4006 with SMTP id 3f1490d57ef6-e2978596e0amr4245816276.54.1729111643486;
        Wed, 16 Oct 2024 13:47:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfd3f1sm745440276.13.2024.10.16.13.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:47:22 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:47:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk, gitster@pobox.com, bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 2/6] doc: update-ref: remove safety paragraphs
Message-ID: <ZxAmWKkjxJDu+121@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <c4bc0553a30ac16bd242edf387280eea37aa3a07.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4bc0553a30ac16bd242edf387280eea37aa3a07.1729017728.git.code@khaugsbakk.name>

On Tue, Oct 15, 2024 at 09:03:11PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> Such a safety warning is also much less relevant now, considering that
> everyone who isn’t intentionally poking at the internal implementation
> is using porcelain commands to manage `HEAD`.

Makes sense. Thanks for carefully explaining your reasoning here.

Thanks,
Taylor
