Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0881DED49
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895601; cv=none; b=tlkGBnRL9otk2sbagPttnkcr6JnY8rZE5AyvjlEJePyn48RgLnjBcEaOwfwLRMK9dMKZjNIVqG3s7r/JK6qLaawn7XdiU8IxshHd77Tunb1VRmpq2pYUqValEJL7rbNolgr0HbkGrPE/Kg2b8eyf344W2HJmV/UU+ri6E5U44rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895601; c=relaxed/simple;
	bh=F2QmST5MM8Br4QTBqOn2zzCVFNt75N8v6aiSg6eE++A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZxmrE12oaTKM2RxzNnfjWIefN3AhTY7BIZJh6GE6+XkMY6Zet9FsuJYwXzfj36F+SPH5WPT1WANsbifVjgI5Ra/9R+GPbjzSY+OCoeFGy+NrhcKWmxEo8tRBMTXl1jwDiXborur7uxPzrG80SMk9JqO8OsRYfCu+r5fSCEJjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwF/taKd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwF/taKd"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb47387ceso64087475ad.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730895599; x=1731500399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VcBs15ynV8XYMGMrz7l5J7oiPw2NC8aHLNM9xCmJ9Dc=;
        b=lwF/taKdPWuiyC6b5v9tSEJF949UNiyCBKFGTqjqR8cc6fj4jU/sC81ACSpsmqhpBC
         Z1Wu7WaFCv9Bc7RfGoHLmMtfwH89wjFp/pvrUzvk6Eab1dZrTBh+28NhygAzmhbIs+0p
         d9ypmejQ2jEPDABmKIy3d8i5U5fXdDyV+4pvU6n3DJ3nZ6Bgo/qqCepnqh6QbEmFn+Gt
         m9j6/5JShEzvUqyCpQ2xSzLhCBQiVGet7RW7IPjjjJ6j+3Q+03JtcB67Vyv5qNECrZXp
         80/646D4us3BUZYqfC1Rm5w6ZFjorinlKFO12CQO+SPPKj0DtKmbL2CxquzodFZvtI1g
         +b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730895599; x=1731500399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcBs15ynV8XYMGMrz7l5J7oiPw2NC8aHLNM9xCmJ9Dc=;
        b=HxcmDmbxmduSNX5gq2rPPQxQ8lrgCCITdlr4j8JzwYqeIEA35jJLCAVELRHZgUn7vG
         OIIQUxQOjQiJxbAVHH2kL+ij7KXOWBt7RmtcTOdcrrq+1kl+qVmEvzFQyCMx6OP9f7UN
         B/WDQrjmQcEb4Hnrnm30pvV5jfgLMpkLYsfrcPGGlLSL7HJUdHXRY6LhuScKEqsgnZb7
         /a5HWEyozItl6KnmfsBnGR13gRlhd0L/TDEP7sdnwQuEiVxj7x1V/dNwtqR5lvz8m1Xz
         S/+uXvdZlBUb6AeQ/nf1WrgrhRfZ0mytOvhOQakgqfc2Ba5jp+A05R3T6G848ZjLfeTL
         u70A==
X-Gm-Message-State: AOJu0YyuQVgwzGRjwhcclFLX1Ql+si47IgenFN+6+TLxxzeThESrlmER
	tKMKZgD/709MyX5MTFEAm5J95ISil/PZt2Iyf4iJHeGlj8KOkbSK
X-Google-Smtp-Source: AGHT+IH9y7tCtHpjCjd4mhYXXuGvXTIVlK/UhDBvKrcss8tnqqkAxv1L21702Hp/Ba7IHiKCkblQGw==
X-Received: by 2002:a17:90b:80c:b0:2c9:5a85:f8dd with SMTP id 98e67ed59e1d1-2e8f1075718mr42903278a91.18.1730895599153;
        Wed, 06 Nov 2024 04:19:59 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc4dsm94007455ad.28.2024.11.06.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:19:58 -0800 (PST)
Date: Wed, 6 Nov 2024 20:20:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/9] ref: support multiple worktrees check for refs
Message-ID: <ZytfBSz56ocwjjWq@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYcPwLB5oLTFUo@ArchLinux>
 <ZynFNQ8SnvTJlVdN@pks.im>
 <ZyoVA-p4JXPaKTny@ArchLinux>
 <ZysN4GIc9JELkIKS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZysN4GIc9JELkIKS@pks.im>

On Wed, Nov 06, 2024 at 07:34:08AM +0100, Patrick Steinhardt wrote:

[snip]

> 
> In practice you can also derive that full refname from the worktree
> itself, as the ID is stored in `struct worktree::id`. Would that maybe
> be a better solution?
> 

I think we are on the same boat. This is exactly what I have done in
this patch.

> Patrick

Thanks,
Jialuo
