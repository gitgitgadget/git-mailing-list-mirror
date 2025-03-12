Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89511145355
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816238; cv=none; b=KE8wv9lIHqLskB3WvhH0UugIQhNqVRNX0uL7C81WXu1nnNoIdnzmEZjlcjiBWXLoBp5fEjiD4MxsXLjyoayrC234Ks/qzxUeho49hPvHh9Dl0j8gT/e6aSh9WGVR0fIMAvfjM7lJqQug/01vyIUOeyWiqRS/MNNZpPTZnHCqUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816238; c=relaxed/simple;
	bh=nCSKvPrNNmDJzvWTfXwQzvrXPrHoLVOAzY9QlF0L3sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4wP3LR0eW5NfF2O9xU9dWwUEIQ1Ulhj2ePYyjBpKAKRqSRe2BQNWF9K6wGV8HaEm257IIw2uQ16sADhW7aq6QHO5DHhJZtjk7O9A1dO9KsmEBTQURLaKm7+Fuv2+syat+BiIg7ebF4niUlKULx9R4EC2uVNTzf9VutbaY/MUII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ieKO0Z5R; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ieKO0Z5R"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fee63b9139so3567477b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741816235; x=1742421035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5VTMs+Yp9hvv/obxnoXJojQKz13y+Qs1Y/uF40rE5w=;
        b=ieKO0Z5RWIu20eC79Rh6yWDHHxaACFawUnGksBCxzFN6qBWUUalN0KbsWIBJ+hanzh
         3poTpOxlFJpX5KkKyM5rl4I2+h2GIwlohJxei1Okf2p763ESfD3rv15vcVAXBAngHyqF
         Cy+/g0ni7W5/bM8pcuXgO/5brMSJGX/LXhNpf+XEUmAwbTsFNJByr/++CPRgSIA1uF7i
         R9savKCqpIMTnKcs1auwzaymKtJRj8rwhXYZ17b4iqn0MUw4hanlEspHBlooK3jc0GHu
         YkKJ8kJaxsJ+UaXe8nRFJEs9uEbonBByk+5j2rIgYtdltQ05l9xzfQyHQU94eWg7U0qn
         KClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741816235; x=1742421035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5VTMs+Yp9hvv/obxnoXJojQKz13y+Qs1Y/uF40rE5w=;
        b=hZP7kxUaVPNNZsVgxeRE8huTroydj9daehuQI2h1XnyQV9V87Px0lDjo09L1nZHGeE
         1hrtk0TOZkNzXx8HaMyJ5jHp11KDlUEjnUnEIThy85MBYCDwBV6vGBwUH/Ld57JmDf/N
         GhrsRoT2NW3dFauHZjbBjjIB6WGriTz02fZtguAmS9us1LBMCSklsq9olIXwvV3l2vKl
         D90PYNGaugpcRL08OmW65L2cT8ZeRsDc24osIZynRaYi06hKsXidYd+yfAC8gQutk7M+
         V/cvmPCGzbllfYssEyMnaWn1S6dJRpPRp1BDjMz4iJMgPgGwhUoI1J+Nbzo/+Nm1cuxE
         plWw==
X-Forwarded-Encrypted: i=1; AJvYcCW6AdpVihNieAspCh1rtLQx9LNMdlCrxvldvZv4zvqk0Hpt6eYkSoAFl09GoaLmbjUNPlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUfEg03/X5rkqPevVl9g4z2Ht0HkWpdgCjPNOGkwnhCkpfAtC
	jbb1Wf9CZZBTlTtgT0EETUHRhDJK/PwEJ9kvX5TM7WwbeBpD7rl5jY4wk6h1eDU=
X-Gm-Gg: ASbGnctWmDvSi6XhPDjR3r0deWezrKDok8RnOKBzsRvqnIUtfYf0nXqwNK5O1HTC4c1
	rgrzZvS7pgJ8o9wH8i9f/rNecN3PyOcV0cFKQBKWE2gO+U0s11azClf0kvtNvj7B9viXSu89WE1
	IIZKtx82cVfQNJuraS51c0bHA/FdmNYT98/CfVk6xQr+zI4OGNUK8iK6/O4B8gVs/8A1CCJ8ek8
	f5QevMR05NxZUnETyecQhEiVW+X4AqZDAY2qj31OBu97NX+1dYQG0cf+k7Tu6ktz34KhXueoBYW
	NMerSu1yuv1nTY97qHWY+LEIz6x/FgSlcm7STOFoasAzx7khOgeFACW+61rXd6loww8SRAKHAtl
	UIaVWKTqNWVuzExYEp3NKOwsjiVo=
X-Google-Smtp-Source: AGHT+IFSPUERt6/3aiWVFJzBHbOBQYH6F2oKDDTZhy/sNk4QPV5B0rQ0Jx3SjkoQjquRdkXf6TiL7g==
X-Received: by 2002:a05:690c:3411:b0:6fe:5dba:b190 with SMTP id 00721157ae682-6ff2f810e1dmr2048997b3.11.1741816235524;
        Wed, 12 Mar 2025 14:50:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a67dc1sm33472817b3.40.2025.03.12.14.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:50:35 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:50:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] merge-ort: allow rename detection to be disabled
Message-ID: <Z9IBql7M3UuVMotw@nand.local>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <4292b22723f759c3e0f84ac1000992187a9c7f7c.1741362522.git.gitgitgadget@gmail.com>
 <Z9FAix-VKGte8UKk@pks.im>
 <Z9Hobtp+9esKkY/O@nand.local>
 <CABPp-BFj08mpXGiSoZ3xZ4KamwTJ4k5wPLTCJh6hUtKSxWE52Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFj08mpXGiSoZ3xZ4KamwTJ4k5wPLTCJh6hUtKSxWE52Q@mail.gmail.com>

On Wed, Mar 12, 2025 at 02:40:35PM -0700, Elijah Newren wrote:
> > I don't know if a link exists; I suspect the request referred to here is
> > an email that Johannes Schindelin wrote to Elijah privately).
>
> It exists: https://lore.kernel.org/git/CABPp-BG-Nx6SCxxkGXn_Fwd2wseifMFND8eddvWxiZVZk0zRaA@mail.gmail.com/
>
> ...which wasn't Johannes' request.

Ah, thanks for the link!

> > But I am almost certain that the behavior requested here is to disable
> > rename detection to match the behavior of GitHub's prior use of libgit2
> > to perform merges, where we also had rename detection disabled (for
> > reasons that are unclear to me, but Peff might know).
>
> No, if that were the sole reason, I'd say it probably only belongs in
> our internal fork.  Disabling of rename detection within GitHub was a
> temporary internal migration measure, not a desired end state -- at
> least that's the way Johannes portrayed it to me.  I know that
> "temporary" sometimes lasts longer than we want, but now that I've
> become internal to GitHub, one of the things I want to do is add some
> weight to that "temporary" modifier.

:-).

Thanks,
Taylor
