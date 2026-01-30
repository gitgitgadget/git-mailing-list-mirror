Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F120353ED3
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770799; cv=none; b=Dg3T/qBzGl99xBHXXdJbNgIeHC/WD41gF1O36L/K0XpxrNpvr4FjPXrfkv6toP9DiCKV2RSvwkpy7r3sD4BFIWA/7KpLD73l1m0Is//1TlAXrASESvm+q281Z5eftKxP9LH+/5aEEOReynCKY5JOXEq5r19IJQ/mAs+L3IvWxgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770799; c=relaxed/simple;
	bh=DCKMnSJZWrlDMDBTV+hYFnLKg2ovQsZ2MYiuYtf48G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRxU1A/EokR4TJla5QvnIWkjsJ38z+XrkzP9wyDSuoe8KGm30J/Fl/vSnvPXVWuCTKdUraP0xc6NnSz9NTWqj8l557XIS2AZr9qYSOzzXla8vAMyz6DW2nKS+7reE5Ct2Hk0Tomur1lNzbh3B8RM8P2DVkPUxbaCywv3JqimStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBRbhxZd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBRbhxZd"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so1863491e87.3
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769770796; x=1770375596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDHnRbLZBgTNn4pe0jCvlfoSG+fuE4BL1n1W3VerdMM=;
        b=KBRbhxZdjwU5sPTw+z7cH4pDWyBX0M4JsmRseVInSp3cNlYrpDtQDyUBEVDTua/hzL
         Hb1S8ncR0eLTnCB1zQVcKMiMephHbs662bKt0NxEHd293JbPbVQ9b8S4P5P2CWqKo/AF
         lby8RRFoGYbrbYBAmq4JDuYLsZEkUboJnNM1puDI36L3VYXDhc4BN1yyMmLzGMNTJ6Qe
         h5CO/yIv6hpJEhoJ9oM2eAryIcGW88RuNfmMZQlXmmoHeF5Nl/cZ522Xulehw9rPgvjF
         ddiB5ggfVlA8TA2ZE7jA5zJFkodXekC48aUjXwu2SoV820uYgiHgHh/UMsqTXuF5OfLH
         nxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769770796; x=1770375596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uDHnRbLZBgTNn4pe0jCvlfoSG+fuE4BL1n1W3VerdMM=;
        b=SwS+lsITd0XM2JaSvNnBH/U++ki2wHOPa8/aPhipicdgEAIoSUk4xo/p9atk/IOmve
         wNm23vzflx9zgHPwOdQGqI0g9bOZ0jUw1CBO3j4BEV83GIiZDdo3ozInnQ0UxHLYEDs/
         NyAkHgXPiJIfMyxwo+/L1rpK1YDpK4iCB52TkENs9MER/b6kwy3snebq1G3/TH9+Mgrg
         hbDSvDpq2YzX4Lq5JDD4ryEj+fDQTqgJ68WfpdvNIyEHhk466PN19T7lm3DjsfZzp4rK
         9s9A2C+u/Pq1To4O1/c06fd6b91WYzzjFVHr8H/4uulXpMpTqkR8NhY9KUo16gdT1sRt
         nc3w==
X-Gm-Message-State: AOJu0YznxEu7gCpyHGFfSR5NMy52dcwNzsyfPSXNtf48XLTh/rw9rcRj
	8K1zjVE6pmVex2a07J/Qs6umz69cUtRmXaM2pvTyN6xPXn39KikALGsI
X-Gm-Gg: AZuq6aIC/OE5tUePmbmcrBNWPUezmPD+FcI/igXPRIGk4jq+12dSKESlMuNzwAjc931
	v8vzBCrMIev4Bz8Jew3ZEiy3LctU9dzvZvrGqGqPAeXHnxFY3s1tI24zGHgwboGppLNEO4NqE32
	p0IpBpWQul39kL6K1sCtczQcQl1Rq1i0Og0ifTUMuUFzvUUnSpxSMrbb7gOLoLOoDKbmtTVcKuM
	jXioztLIofrfWMujs8jgvfuHdD86p2fw3sLZpBQrOezfZ1SpZegBGjRe+3YA0/K/jcGP6qe8jDY
	tJ6Y7WYpllfQMd6NL+T1SNArQSF23WpkYzLMw2te92jOOESMRhZZzs/DXWU8vPy4Ztq7nDPS0Sq
	bJ10TU8eBLDmzxUFbOJTBTLcGjzqAgYVncrVxu+Pcae+OsmrL4A94sJRV9g9sQ1/UbOGRWamGIa
	lPTp0Nq94Ap6kXvq1bqggkaVuuRv5cNXg8UymLiPxbbgmHa0mw5O5LXJ7s49GLQktTxOITFBj8I
	ueYsd+/Bg==
X-Received: by 2002:a05:6512:154b:10b0:59e:1954:1d51 with SMTP id 2adb3069b0e04-59e19541e28mr313400e87.50.1769770796207;
        Fri, 30 Jan 2026 02:59:56 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b2c09sm1697157e87.65.2026.01.30.02.59.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Jan 2026 02:59:55 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Fri, 30 Jan 2026 11:59:54 +0100
Message-ID: <20260130105954.59636-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq1pj8b22h.fsf@gitster.g>
References: <xmqq1pj8b22h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for your comments!

> But @{upstream} and @{push} are inherently very different from what
> you are adding, aren't they?  Asking for topic1@{upstream} and
> topic2@{upstream} makes quite a lot of sense, because the meaning of
> @{upstream} depends on "which branch's upstream are you talking
> about???".  But I suspect that asking for topic1@{default} and
> expect it would be different from topic2@{default} is nonsense, as
> "the default" is not per branch but is an attribute of a repository.
> In other words, <branch>@{default} may by itself be a nonsense
> query.  Are you rejecting a non-empty <branch> that may appear
> before @{default} as an error?

I will update the code to treat 'new-branch@{default}' as nonsense, it's
not a case I thought about, and would never use 😅

> After cloning an upstream project, those who dislike the local
> branch name 'master' often rename it to something else, like 
> 
>     $ git branch -m master main

I have never heard about anyone doing that. Isn't it more expected that
people keep whatever branch is on the remote? But regardless, I hope
there is a way to still make @{default} map to whatever your renamed your
default branch to.

> Given
> that the names of local branches are under control of the local end
> user and not upstream projects, I would imagine that the primary
> branch used by a user is of per-user nature, not per repository.  In
> other words, instead of having to do "git branch -m" after cloning,
> you may do "git config --global init.defaultBranch" just once and
> keep using the same default name.

My ratio on cloning other people's repo vs. create new repos is likely
999/1, so I'm given the default names that maintainer chose. I have
default branches called 'master', 'main' and 'develop'.

Yes it's possible to rename, but what this feature does is open up the
convenience of not having to bother with that.

I have this script that I run many times a day. However it doesn't work
when remote is not called 'origin', so I have another version for
'upstream', etc:

    git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

That's uneccessary overhead, that could now be replaced with:

    git checkout @{default}


Harald
