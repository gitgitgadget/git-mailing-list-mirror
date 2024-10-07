Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A318B483
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302783; cv=none; b=tAN3RLpq6hoyPs1Y6idcxLuMILGROHC4yYpJwtgGbL7LQcfD8OBdNSt3QZowNVw11FAvY9Ff6lr5UUhI2ofGaiARqTSAPKWsJW7PJxpVHxdAtf3ul39NMRZC9RdibNfxakRTy1MkHczbVwrmW47umo8IVoVwaphasA+eQwU24+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302783; c=relaxed/simple;
	bh=6y5nWknXxeL/jHFhViAjAHX6QGHJkkdT4am3IJyw408=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAU3cvvy1qHhnGpmUW7CLzp+6FY6kdJILBPYwL5p1qQIU2WaErEydkyYPnmvepCifdjDgkusDLgW29bNwRx27q74uPfmvcY0poRQVlbBHZAZdCccPiGNYsrRm+fa4hzVFYwJJQOxf6yOJCSSpP9M7NeOOUoU6m9c9ST9BilFsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i75gkKF5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i75gkKF5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb92346caso27080085ad.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728302780; x=1728907580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVlFR1S2BOWtNkjb5bGuKKAu7hYobhGeJvI3hkdUQ9I=;
        b=i75gkKF5im4vwMKaiZZ6Np0N32chLb+JPVzMZz6IoYq/Nn8q0x2t5HLc4hZnAVgEzE
         VMDpuVzWP5nURI3dqSPM/FYqQj+3IOsK/AqG+6lWYrsEy6+HpWdIIbnrnwADxg0Eu4fE
         y32gpulL3tuLmG7/6JvktNbbYf8DLfgVIsibDAkXH8wYV+4WUucqZqjFdQuzsaoQ4WL3
         KKabgou301UKArSYjUv16EIYPOyU6ZEjno1GwKc6EYHNI2nWu0fbIO+H+vkj9j2uouwV
         vky4cgK4hPZ0NgDULH7Jf2n3Ebi7b4Ot29CKaLNLhmISegbG2hqlHQzy2+wN9UU2h3z+
         wFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728302780; x=1728907580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVlFR1S2BOWtNkjb5bGuKKAu7hYobhGeJvI3hkdUQ9I=;
        b=GNqmNaTvpg58xRQRdvaMwp93tmJKevmt7GxS4ke6VnEJjEPSCDW0UaFEWhI71Tr+o/
         6faZEYRsnKxtSj/bMv/4plAcA97i6DmhmeB81TLpfl2mW9B/TaLLefQDVMNQbi/1UK0I
         RlZhQJZqy2fmBc49Ad+SO+rkQodSlB+qB/DgZUdt9Sx+omr8npVEwdDPGQXOJUcWiyrc
         hR/SwXGgy/mf1AoJNlrZL2A+eutsrun2ue2Eg55kgcp9UcG5roRvr5jtJKPzf9UjHf1r
         dh2S/vZ9Yj5gzU+Cgq5zoqcbrBfsNvvhkJFxoTKl2XctcWDkjs80QjOO2Y8C2mstLGyb
         ymgg==
X-Gm-Message-State: AOJu0YwRPp03PEDNkX4GSM3kiQPNxu5bJO8QtoQTntYEJfkHt+DgL3Sj
	ys0jCRwn7T+xOSobNRzevSMiMCjEjkzWgLT4grlg6UCYXH+oS+Oa
X-Google-Smtp-Source: AGHT+IEQAiXEyqcvViKeYiNW5X8/3Azn64mpdk/0lVgYbkl0oNi5OPqtFx9giyFkucIhfLT4LySmkg==
X-Received: by 2002:a17:902:da82:b0:20b:51c2:d792 with SMTP id d9443c01a7336-20bff37a652mr216241485ad.2.1728302779831;
        Mon, 07 Oct 2024 05:06:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1395db96sm38152605ad.213.2024.10.07.05.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:06:19 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:06:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/9] builtin/refs: support multiple worktrees check
 for refs.
Message-ID: <ZwPOwgXITjoUejp5@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-jkFE9NN30uDl@ArchLinux>
 <ZwOBwxiSZpxJlsfT@pks.im>
 <ZwOe7YVWmhshRhI9@ArchLinux>
 <ZwOm43a2ZmpvnlWc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOm43a2ZmpvnlWc@pks.im>

On Mon, Oct 07, 2024 at 11:16:19AM +0200, Patrick Steinhardt wrote:

[snip]

> > However, the refname would be printed to "refs/worktree/test". It will
> > make the user confused which "refs/worktree/test" is checked. So, we
> > should print this information like:
> > 
> >     Checking references consistency in .git
> >     ...
> >     checking references consistency in .git/worktrees/A
> >     ...
> >     checking references consistency in .git/worktrees/B
> > 
> > However, when writing this, I feel a ".git" is a bad usage. It will make
> > the user think it will check everything here. This should be improved in
> > the next version.
> 
> But wouldn't it be the better solution if we printed the fully-qualified
> reference name "worktrees/worktree/refs/worktree/test" instead? That
> would remove the need to say which directory we're currently verifying
> in the first place.
> 

Good idea. I will use this way in the next version.

> Patrick

Thanks
