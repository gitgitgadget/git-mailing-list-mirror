Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0AF1E5702
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771794877; cv=none; b=gB8TDkjpzUgbHkNiv8zGfMgo1RHI7jOQ5svuvWCsawCeWxA+ogActz/fv3IUH2fl8tjo2AOa8LwRStX+HWAlSVdEZOLURuhVTrHzuMdBKxlKy+gHb4DCJFsnVsduX/pzaErJmE6ZJP3EnYMQK/KyTdOO8Jm/gGzAQs6LRKrn2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771794877; c=relaxed/simple;
	bh=cNR58Qd+d4eRXIn6F7RWtJioeRyXcazAeaaWjO/Gezg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YEUG1Cvo1xcRHXSFCwMb1q56xvB5nJ+qZSwU45i0OwWjBbiFTH1shEt7/40EHmbkG6M0bBj9OOqMLI1N0Ra4HQ+0W96/Tbncui+1X5TcYBndaOTWn3mkqr0B4Skg/9OqhDjrFb5QUZ76k3H/B5f8lDPq+I/xKmxy8p17DUhIiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddbloHbd; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddbloHbd"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1275910b930so2693484c88.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 13:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771794875; x=1772399675; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrQwtUXcUd0Byoui/MSfgAoBwz8FoAI+OFASoXxILrw=;
        b=ddbloHbdNoEAhm3vkqUmxOzbkNhijXJzsdqamEmYU8V4l2KAoJPQ9J121IeOnGFKiE
         vuMHBJFuBMe9IJlL77HdMaMjAbn68cjloo9wpbmGUhVFP/1sVflDc9m4p6tYsJYv6/fM
         9IkH7IiXjIcGu6IWDDuSu4QXWKs9jnpaJyavcPmzYEptBOY/rPq7og/XDotNsGSUmZ1X
         Ecx43jW45hnleO+qE6twJb/eKtv/AgRraBuK6pgUlJJzR9AYVtjOZWe9/tjTRjsj9OZB
         uURKrP9Yj+JKE7RmKxjqzVz1ORpFM2imF6FqfBkU4D969s97LlbwDJe0aS+QzQFyFbfC
         2Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771794875; x=1772399675;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrQwtUXcUd0Byoui/MSfgAoBwz8FoAI+OFASoXxILrw=;
        b=s8YGu9UWyXIGi7Iv+JArhdu1WwInQkb6LlrtEBJ6YmMxLuWYo9uvEzIyTkx51h1YZv
         Quc3nGMela4YmWjV1TLmXJuGn/WslJqvV3QpJn8Vnq+UyZXlRL02LxI7+88c11oVRuM+
         F0/lnSv+I+TLGsXRhIRUfJSgId2UbhtYwgqnwa4H3jW+EJop1LWA6NfCacZoK+dTRw1I
         3QGujGFjY3p/5vp8khdKj9iAG1Yetvv2ZFqTvRlTPMDagluF7JMMQxEgm2COOAyE0KHS
         cQ2OoHnS+duNE2PJmE5dOMceJlDCJxmOPt5F2fFR6fNQquEv3aRWPkEehsju9aisY25v
         +MZA==
X-Gm-Message-State: AOJu0YwH8aPGmpUmne+jzpcaIyFyuNeXZ0IXrPMtQj4H/zf158/85CF+
	2uVdwRW4bubhytC/HRebg7/JXEYbvR3aPzHlUVDn0maHKZ5sMBIDcXt+
X-Gm-Gg: AZuq6aL9JcMKMo2WAmFIjPndLHI4z9lWQqECOC8fg363Y6wUCU9VfXPexwhGsM/ODcK
	1knYsFT98YzV06hq9zCaRw660/6wyQ991xAy6q34Oz3vWYwY7Vc7XZyzl3UWU3gwHAE4U1qwbGz
	hh/7PxGVuBj0d4Ky0gGr5j5ymgYhJeE4Da9KOdgRU/oWPyX2wzBf8o9XYtj2tLTWEJwPr7vnWLQ
	AUP4acr/7Wx8Yb95aRv/R9qMrx2qjI16orRVrcGt9KMR9mkqvxgpIpE1soFCOgT04J49mFXB4ow
	WvH+Yw1LRQa5bUVvmGvsWcCq24mDbEf72jyY8dixSF3EQx7hETZ5spEoMGLc5GQHlAY0seL4b75
	MqhX3ZeGRf8UUVrORwbLixCau+bLGfsSNlNJLLBy7Wjn8uBs7E7RGuOAYs2WaTE/1HRyWyKQLM1
	PMKNOLR7A+v/5+jYoxVQodCan7wWERpk2A9+CE0/03ih2CTuqdcSOK9Q==
X-Received: by 2002:a05:7022:6199:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-1276abb674fmr2385661c88.19.1771794874795;
        Sun, 22 Feb 2026 13:14:34 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8a657sm6524508c88.12.2026.02.22.13.14.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2026 13:14:34 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [proposal][RFC] Improve the new git repo command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CA+rGoLdSR=NPoD7XEbYPoRTt0VS5M0QhzHcy-OmyuZMMVN-H5w@mail.gmail.com>
Date: Sun, 22 Feb 2026 18:14:20 -0300
Cc: GIT Mailing-list <git@vger.kernel.org>,
 karthik nayak <karthik.188@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 jltobler@gmail.com,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <3C0852FD-59FE-496D-9521-E123181901B3@gmail.com>
References: <CA+rGoLdSR=NPoD7XEbYPoRTt0VS5M0QhzHcy-OmyuZMMVN-H5w@mail.gmail.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> A list of my past activities in Git:

Looking the Git history (`git log --author='K Jayatheerth'`), there
are many meaningful patches that you didn't listed here.

> 3. Project Proposal
> 
> 3.1 Why "Improve the new git repo command"?
> This project is particularly compelling because I have closely
> followed its development since its inception. Consistently reading
> the weekly updates (https://lucasoshiro.github.io/gsoc-en/) and
> following the mailing list patches for git repo info has deepened
> my ongoing interest in this specific initiative since GSoC 2025.
> This continuous engagement has provided a strong understanding of
> why the command exists and exactly what needs to be done.

Thanks for your interest in my work :-).

> 3.3 Proposed Solution and Objectives
> The main objective of this project is to implement the changes and
> additions discussed in the introduction to make git repo a complete,
> modern replacement for parts of rev-parse. My proposed solutions are:
> 
> - Removing the global state: The builtin/repo.c file currently opts
>  into using global state by declaring
>  #define USE_THE_REPOSITORY_VARIABLE at the top of the file. My
>  goal is to remove this macro entirely to align with Git's
>  libification efforts. To achieve this, I will refactor functions
>  that implicitly rely on this global state instead of the passed
>  repository context. For example, in get_layout_bare(), the repo
>  argument is currently marked as UNUSED because the function calls
>  is_bare_repository() (which checks global state). I will update
>  this and similar functions to evaluate the explicit repo struct
>  instead.
> 
> - Implementing category keys: I will add a way to map specific
>  categories to a group of values. For example, if a user types
>  git repo info paths, the internal logic will look up the paths
>  category and return git-dir, common-dir, and other related
>  values all at once instead of requiring manual queries for each.
> 
> - Adding path values: I will integrate the missing path values
>  currently obtained through git rev-parse (like toplevel and
>  superproject-working-tree) and --git-path (like index and hooks).
>  Since initial work on this has already started, my goal is to
>  take over the effort, lead the necessary design choices on the
>  mailing list, and complete the implementation.
> 
> - Enhancing repo structure: I will study the external git-sizer
>  tool to figure out which of its repository analysis and
>  statistics features can be natively implemented into the git
>  repo structure sub-command.

It looks to me that you're proposing too much here. I mean, I agree
with everything that you proposed here, but maybe you won't have
enough time to do that given the pace of the reviewing process. For
example, my first GSoC patch series took 11 versions until it was
accepted.


