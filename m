Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F83557E6
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891746; cv=none; b=f18z+V4Znz9/IHKyESJJIwOsq3mo+f/E048EyphNb2EbzbnDzUiTAQjx+LROuXp4SwrsAMAK51vwYuV/CuKNv6WVh23VzP0IJQOn0vfPVc/t4oRjqiWjuiqU669nC3GdqIihCIz/pVpbhBPwiePvbIbFMy4kGg8zotZz6RN+GlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891746; c=relaxed/simple;
	bh=bRrRtfQ7NROusaAukjI4mDMS+e6JsmO6sbf/wOZcdy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E/Yds2s1sZAZ+CPcQr8O12PL7RvrGRqq+ND46/q4sm+wdUhSeqQCtE4fUXEhJz+BOh/RRn4gam0Y5DGPB3GSQPF9uRaSMPGPwtNsa4zb1P7aF1XhATwmrLbqiKAyYvSapowAAZFFtKqQg13otZ3EVpPVvqAuLdskxT6mkcESMNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlSDGgpA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlSDGgpA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso25597555e9.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765891743; x=1766496543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRrRtfQ7NROusaAukjI4mDMS+e6JsmO6sbf/wOZcdy4=;
        b=hlSDGgpAJSQF0Y72AG1ZNywqgqTKi0mRCIcJQctDMBLwvQ8uAzMlVj6HyDXny3ybAh
         jyj7Ak3/gPMEBjSZ8S/uNBaibxpCyJeAc6Xcu4JjRUBX6WjbG1qoSSfKdzaw4NV3DRfm
         Qd8ibW5c2JkwX/ZGgiBZlehry3UUaA4JBTiCZs5Mp6rZSJ9VW5x2Mn8s1FdPwmWJ1mut
         5fxyz3D9dRUPRFXbmSuJJ+icfMUQZvqnGADNCE+81puvOvl9V1j1l47Oh97xI0Of/MSP
         Sv0rz8TExMtWLJ9xOAtTrUfWvz3fkk2hOg18/pVNGOKxiV+XZdWqVbMsVRzvJbQav7kx
         0hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891743; x=1766496543;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRrRtfQ7NROusaAukjI4mDMS+e6JsmO6sbf/wOZcdy4=;
        b=njN92a17Zbsd8nwJTq6/+iZ0kIjIuuUnd2dRVZJgAyzsMJWvceBE2p01mkFKFa1XcW
         qXvChpKzztko7HyafRH8pi/V5232e3cqgZS7DIwp9DnFwld6iH84ErnLj0Zzz8rkgjKl
         MtSwcOfXFX2ZOiX72fBt9Fmg6UOFWJoImRY9JUfJi7QWVq5pgIzfpIrwB1QERIUrJIUx
         +9AUXNMh5MYUoVPZjgkh64SqB/Usro4zWmYDrA0IpKl6yKQEGE/tkZjq8KMIyJHjcp8q
         eOUNFhns/6rgKYBWSGeYALRiLRQNE7JmjSLCsFcocjKsamijU3H4wSCA+9i2Xf6LMOuF
         Au8A==
X-Gm-Message-State: AOJu0YyV55N9umBm+TjMWIqcXop3ODbKGZxsE1MEbxrijsiaBLNROatl
	C3UoCSz4kdoVfuYcXDLcfAZjwTHnEL6ijCXj5eGM2RKdrMNLfrxTnMNOzcBY9ACB
X-Gm-Gg: AY/fxX40m7KckR7emEBrxxvegY3eOrDqIv+H2pHt5uujA3D7uUTP/zqoyN5EZouIA/E
	omK84G8lIZ4hXFOWrf2dU+9Mb+CuWkl2n1Oj/BJDjEaIHcillQcHyfUBpMCssjzu6GQ9UHRFPv3
	0cKVKHwennfZqZ5rLGq3MM/p9dbeqkUoCM33BeuxxRhGNyb4fdedZVDoLau5oDc++XMEso6zLa4
	FYIgkSXCRKizFWI+2VzhfxlX29l491CWsQ+ocmceOMoXeWZccd5hPdmJ8ZwMFcW/G9dl/cXAgKc
	u3pFxptGmti0Go6zeFvgfNLtJLXdXJ3yysAjvQNK7Ajw2j/MymIJLbTqzHMqU0Unb3X84OFOT1U
	W3U08vDmvB5U8CxBWL08JISZtg4LSIUBriTRY8ArUMANkI8Hs6Tpke6JuJ0HSZSHHNjB4xK7pWe
	fS+o1A2likLgemWT49rtg=
X-Google-Smtp-Source: AGHT+IHzRkYarOaYnnFR6ZzYpxsw62LzyJAZW9ny/NW5G6Y20bvvd2P8qkIxe/++E+CqrI2QVHmetg==
X-Received: by 2002:a05:600c:470e:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-47a8f8c0527mr166675925e9.12.1765891742372;
        Tue, 16 Dec 2025 05:29:02 -0800 (PST)
Received: from pop-os ([2c0f:2a80:a8c:b510:40ef:64e2:e26:b9d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f38a4b7sm244740515e9.3.2025.12.16.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:29:01 -0800 (PST)
Date: Tue, 16 Dec 2025 14:28:59 +0100
From: Bello Caleb Olamide <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christiancouder@gmail.com, usmanakinyemi202@gmail.com
Subject: [Outreachy] - Week 1
Message-ID: <aUFem8vqUFCS/4NU@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Week 1: Onboarding, Communication, and Choosing My First Issue
Repository: https://gitlab.com/Cloobtech/git

Bello Olamide
·
Dec 12, 2025
·
3 min read


The Outreachy internship officially kicked off this week, and the past few days have been a blend of onboarding activities, community interactions, and diving straight into my project on reducing Git’s global state. It has been exciting, occasionally overwhelming, but overall a very fulfilling start.

Settling Into the Outreachy Community

On the first day, I was invited to the Outreachy community space on Zulip, where interns can ask questions, interact with the program committee, and connect with fellow interns. It was comforting seeing other people who were just as excited and nervous as I was.

Later, I also received an invitation to a GitLab Slack workspace that included my mentors and several Git maintainers. This has become our main space for day-to-day collaboration and technical discussions.

Syncing With My Mentors & Setting Up Communication

I emailed my mentors, Christian Couder and Usman Akinyemi, on Day 1 to introduce myself formally and discuss our preferred communication channels. We agreed to use GitLab as the primary platform to host my working branches, track progress, and prepare merge requests.

With this settled, I set up my GitLab remotes and ensured I could push branches and create a public mirror of my work.

Starting the Project: Identifying My First Issue

I didn’t waste any time getting into the technical part of the project. After reviewing previous contributions, I decided to begin with an earlier patch series, done by Ayush Chandekar, that attempted to move the git_attributes_file global variable out of environment.c and into struct repository.

Link to the discussion can be seen below

https://lore.kernel.org/git/20250309153321.254844-1-ayu.chandekar@gmail.com/

The earlier approach, after moving the git attributes_file into struct repo-setting, proposed passing struct repository *repo through the functions of the attributes subsystem. However, Junio Hamano observed that this design could be improved. His suggestion was insightful:

Instead of accessing git_attributes_file through the repository struct, it should be reached via struct index_state.

This is because:

An index already knows its repository

A repository may have multiple indexes

The attributes subsystem already passes struct index_state down most of its call chain

This results in a cleaner and more consistent API

This design conversation made an excellent starting point for me to understand the trade-offs in Git’s architecture and why reducing global state requires careful restructuring rather than simple variable relocation.

Early Challenges & Mentor Support

While pushing my first branch, I ran into an unexpected issue: GitLab didn’t show the “Merge Request” banner I was expecting.

After some confusion, my mentor stepped in and pointed out that I had pushed to the wrong remote, he however pointed out that this wasn't a fault of mine because that was the URL I was provided with initially. He provided the correct GitLab URL:

https://gitlab.com/gitlab-org/git/

Once I updated the remote and pushed my branch to the right place, everything worked smoothly. This was a small moment, but it reminded me how helpful it is to have mentors who respond quickly and guide me in the right direction.

Closing Thoughts

Overall, Week 1 has been a strong start. I’ve settled into the community, clarified communication channels, chosen the first issue to work on, and begun studying the surrounding code and previous attempts.

So that’s my Week 1 experience.

Catch you all in week2 :)

---

This email is cross-posted from my blog: [https://cloobtech.hashnode.dev/week-1-onboarding-communication-and-choosing-my-first-issue]
