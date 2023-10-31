Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CFDDC6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMJgHFOm"
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBECDE
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:48:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507cee17b00so7536133e87.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698731322; x=1699336122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vUjxbdeFfnd890qCyUrl2tl3UEsQMd5STiVDb5yZ7CY=;
        b=XMJgHFOmvVx3rXGxYKH/vR7FrZp/d9aeMDK/+LKt3ThUcoSRR8T5hYyhRCrhlijLtm
         dkBlheoqXfTtEIeeGJu1GPvfJugZdYNintXmgkv8W0wYGPWswXxZJowLHDCtfRkdQkom
         GvfMBt//17RjhtrveINCmncsX+Sxx7g7IWKvN+vJ8oX5CKwF9IeYpmwLvEgTYbEEUIcA
         T0nqX8Zt6WvkYflEYtUMp0Vy6sQGUGmtsZFFbBeheMihcwIPOS3FMpiGHzJD/YxPSyee
         dIP4QEXRibXX5QPP0ge+2VYGWGxOnXiSjvPBb+xwdYdTR0R0kjjtdtN+L3ScvsDXZqdl
         f+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698731322; x=1699336122;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUjxbdeFfnd890qCyUrl2tl3UEsQMd5STiVDb5yZ7CY=;
        b=mGpnwV5x0X67dm4Fv+FS/bZguPy9bAYAMjbRup604zXs5sxYRRrVicQ6Hgu/yGcD8b
         QoN4bkAHXFDYHBHt6wuzBMjPhd4A+sZcbLZJ8qtlguPKbOSDpasRdgvrObx7l+NosGeB
         whep9yRIpdqZnpTqu3KFLj2KD7NL26GRWj5pthUgq5xcGWL35KhStW/Uv7+bvIEV5vUx
         4lMSNrmpbNhjWT5LCM2F6q6vKree8V2ktKEB36WwPQ9y5gKrNYbvUTYL5KXcwJBhBWWW
         LJwaDcx4mFAR/dG9QxyXuAd9wBkPw6wW587+lrCGFzZIbeyEjW42f26kbxOOLdWPI0mG
         DEXg==
X-Gm-Message-State: AOJu0YzaeP/zwVm+JFugli8pDDEOXwo2cbJEoLKYevs8HSCRfhN+sly7
	hMcK/aQ+m21jTQP9OOsXRfWg48MmZNg=
X-Google-Smtp-Source: AGHT+IEE/lwZqTL7+mGSrOyDv68Mcc+PL14ZJvMiZtSpR+1CFe7qAk5IE9W5xfM+g1kfuEi0urGmzw==
X-Received: by 2002:a05:6512:1103:b0:507:9a05:1aed with SMTP id l3-20020a056512110300b005079a051aedmr11446769lfg.4.1698731322165;
        Mon, 30 Oct 2023 22:48:42 -0700 (PDT)
Received: from [192.168.192.11] ([178.127.214.205])
        by smtp.gmail.com with ESMTPSA id k44-20020a0565123dac00b005079f2a777asm92377lfv.137.2023.10.30.22.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 22:48:41 -0700 (PDT)
Message-ID: <9f584927-7506-421e-a363-953eebb0ef90@gmail.com>
Date: Tue, 31 Oct 2023 08:48:40 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
To: Junio C Hamano <gitster@pobox.com>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <ZUALkdSJZ70+KBYq@nand.local> <xmqq1qdb8wzk.fsf@gitster.g>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
In-Reply-To: <xmqq1qdb8wzk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

Command of developers can decide which policy use and why.
If a team decides to avoid extra merges - why not?

 > a single commit could be a large and involved
Create one non-reviewable commit or losing feature scope is much worse
practice

For me `git log --graph` is the most representative form to describe
what's going on with a project and I prefer not to complicate it. But
it must show changes properly.

--ff-one-only is handy for keeping the appearance of a linear commit
history and makes merge commit messages (from other branches) more
meaningful because they actually do represent some branch being folded
into the master.

As an example, merge commit for one commit is overkill and doesn't bring
new meaning. All one-commit meanings described in the commit message. In
this case extra branching (extra merges) just adds confusion. Plenty of
extra merges turns into merge hell when you have countless merge messages,
but you can't get sense what's going on with project.

People use rebase and fast-forward to make commit history more linear,
avoid merge hell and keep the repository tree clear - it's fine.
But it's a big mistake to merge complex features as one non-reviewable
commit. And even worse to make all history absolutely linear when you
can't find where a complex feature starts and where it finishes. If it
wasn't combined in a special branch, it looks in the main branch like a
set of different, not connected features.
In the case of problems with absolutely linear history, you don't know
how many commits you have to revert.
In case when one commit (merge commit for complex features) brings all
changes into the main branch - you know that you can revert feature or,
for complex changes, even part of a specific feature. You can revert just
A/B tests for example, if you don't need them anymore but keep complex
features - this case makes squash even more useless.
You can try to use branch names to find where each branch merged into the
main branch, but it's not as descriptive as a graph and every so often you
can lose branch names. As an example, GitLab has an option "Delete source
branch when merge request accepted" and many teams use it.

--
Ruslan

