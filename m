Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C3372
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434828; cv=none; b=ZCrL5GuGpWEO6XY94po3iwtwGqleXolaTHiLtaunYW31Rar8Fd5TJVRGjThwkMmQGaleQXuqx1uX/HDdn1yUP0i6U5lKXjf0+T8kKbgWwd5vE1JErZJGEpOAdhIKvWty9lxwKpuRaMqpDSOUQGFyAlgXVr2KuR/tK3CZ6Ey521Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434828; c=relaxed/simple;
	bh=7GarbPdXVQ68u6K0/fZUUKaeLwU3eoxlk7UuXvochlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0pLsjehNFRfaf3uxM+rRvU9z7vieMCb3zO++C7cvYOGXtwh/ibcWra8KRI63hWimR5bQm1ZLDCFBQlTU8oeInvbLNPp8UrsYvQf5+hRzYra9WOwwevnNHgVr1R7Ow9mxpKKf2cKop2KydqhaEZ35yfPjqKu7JmnbKF/vKFvHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUy8SxhA; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUy8SxhA"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72726e4f96cso245670a34.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742434826; x=1743039626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LFPvPgu1nbM0r6AG46IARMkG3jl4n58nfOXJSDKDP+s=;
        b=kUy8SxhAtRv99foQqzbBaVPNaLkob+XnxQ++d8T0zKUNlSeoE2Hb/P91Q2Mn2cywLW
         O/Q5LdZR+cyZSDlBoFeo2DF7NsBxc4uF18apvc73YLfbBQBhZlWlfEv+k2JnyBzqPebj
         rwDqZMOGh3A+nm2s8wOL9OV+6a8sSJx7lrWupFlLKnwaOrPsyMK7kwDI01tMJGMQwXIn
         3De2Bp3nN6296GfzKNW6qrLf14U1QG7umVH6lSWrb+D+XQWU7x/lHYmyMH8gTD3m06bt
         T86m/UdYmesDbHZhQJIIqhI+SHC19ERWKORoyi57SXyoCaE3DDuftuiLTfSXbo72RlTC
         mijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742434826; x=1743039626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFPvPgu1nbM0r6AG46IARMkG3jl4n58nfOXJSDKDP+s=;
        b=FigKUI0uAeJ3Pqi2hsMtcuXq2NFlZUt/v2yE/ndRyOrphlm77HCZUsRSE6gQnVSyh+
         woK/gkzFl81lQBfWv9AmNPNtgCxJ00pOUbMbseLchaUv+52j+gVY9aTTw0N9T6MT0dha
         8cBU5d09quALm8OF4aRKRxPlKKTYCjttu5LvKCxCzaw7wjH6nqY1lT8z/CHBQnfm7E03
         um2YO68B4bGCzAOJz/wtA+rD08DukICu1KqqtcrNmXAAVt5Lf9R/LJV7x7toa+K3cRz7
         ZkmcSGKsbGEOWct/FfoJoea9Np8qGEIwkdXpMJtng1FyPgLivnrLrkvSSvz548wiHxNK
         i9eA==
X-Forwarded-Encrypted: i=1; AJvYcCUHk7J+Ze5BYtzXRWt0WSRGRPD3NfUJkOQuY2VGl869kay42x+5oDziMrzm18kfsuX2gbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVC4twS4PEom1RXzLKn0MgV7SByVWxhn8n1Ype6YZ2CnksVE/k
	TfMn/NxGOteMD8+B9H97VWstdh8pHxMEqjji3lICRS5N7hbr8Co5
X-Gm-Gg: ASbGncu2p4eQnWLUyVmiNxE+qaNWcbmZzYexDRvKy79NRtdX8EqdmCbLudIeJwpuDks
	LXV9zHHMmkOUAw9CN7P6A1QO5CxzUDPPIdnaaTLKNvJJkmoxDIDXxXkRK9XxKLazZlf3UNo3ZHJ
	0ROu5bbO6fk3/pcS0jsz0qoQQel+v/deXLS9fSkYVwG/Hef4DAsDDqXnam/QNetS8jJrvBhuUB1
	+KaFMD9FWrwKGMwmZBo0/uv8+Bp6/lG1hQ8e91wvHpG9ZXwEEQsDYoNkjC17LaZBJmczotERUyv
	VUmwm59DBQyxZwg4qJuMSmeKbgqaftzso3L4rg==
X-Google-Smtp-Source: AGHT+IHTJM4ZnR/ctXZHGuBuSMsZjZizSEuNfxN3jg/d4QYqyI/9NpiZ3PuZH1Zc6y4cxq+c/i2Mkw==
X-Received: by 2002:a05:6830:6e02:b0:72b:98f8:5c95 with SMTP id 46e09a7af769-72c02e1897dmr1246431a34.1.1742434825879;
        Wed, 19 Mar 2025 18:40:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72bb274ea93sm2790011a34.55.2025.03.19.18.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 18:40:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:36:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Elijah Newren <newren@gmail.com>
Cc: alan@norbauer.com, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: bug: git shows hints that should be suppressed
Message-ID: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
References: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>
 <CABPp-BGTrEfGqX=o3W5rfqZiRdEuAzdKJuT8W0J=6kSY9ME4LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGTrEfGqX=o3W5rfqZiRdEuAzdKJuT8W0J=6kSY9ME4LQ@mail.gmail.com>

On 25/03/19 07:45AM, Elijah Newren wrote:
> On Wed, Mar 19, 2025 at 2:59 AM <alan@norbauer.com> wrote:
> >
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > `GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=/dev/null GIT_CONFIG_NOSYSTEM=0 GIT_ADVICE=0 git clone --quiet /Volumes/sourcecode/npm-packages/packages/repository-tools/node_modules/.cache/@altano/repository-tools/2078b9db1d71a4f4a5422e25a7016c75/git.bundle .`
> >
> > What did you expect to happen? (Expected behavior)
> > I would expect the clone to happen without any hints because I provided both `GIT_ADVICE=0` _and_ `--quiet` to the command. Both should suppress the hint.
> >
> > What happened instead? (Actual behavior)
> > I received the "hint: Using 'master' as the name for the initial branch. This default branch name" on stderr, which caused my tests to fail (I am using git programmatically in a test).
> >
> > What's different between what you expected and what actually happened?
> > The hint on stderr was displayed.
> >
> > Anything else you want to add:
> > This behavior is NOT observed on git v2.44.0 and is observed on git v2.48.1. So the bug started occurring somewhere in between those versions. I can find the exact version the bug was introduced manually with some effort if that would be helpful.
> 
> Bisects to 199f44cb2ead (builtin/clone: allow remote helpers to detect
> repo, 2024-02-27); cc'ing its author.

It looks like prior to 199f44cb2ead (builtin/clone: allow remote helpers
to detect repo, 2024-02-27), the default branch name advice message
would never be printed when cloning from a bundle regardless of whether
`--quiet` option was set. This particual advice message also doesn't
respect `GIT_ADVICE` either. So something about the change has made the
message start printing when it previously did not.

Digging a bit further, this change started partially initializing the
refdb with a HEAD file which had a side-effect of changing the location
where the first `git_default_branch_name()` was invoked. This matters
because `git_default_branch_name()` only computes the default branch
name once and uses a cached value for subsequent invocations.

Previously, `create_reference_database()` was the first
`git_default_branch_name()` call site and was configured to always
suppress the advice message. Due to the refdb being partially
initialized with a HEAD file, `create_reference_database()` stopped
invoking `git_default_branch_name()` altogether and the default branch
name computation was defferred to a subsequent potential call site
`guess_remote_head()`. At this location, `git_default_branch_name()` is
configured to not suppress advice messages.

Also, `guess_remote_head()` only invokes `git_default_branch_name()` in
cases where the transport is unable to figure out the remote HEAD and
must guess. This explains why the advice message gets printed for bundle
clones, but not all clones.

One option to fix this would be to adapt `guess_remote_head()` to
support configuring the underlying `git_default_branch_name()`, which
has since been renamed to `repo_default_branch_name()`, to be quiet and
suppress the advice message. The call site in clone could then be
updated accordingly.

I'll submit a patch that does this.

-Justin
