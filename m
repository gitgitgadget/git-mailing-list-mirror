Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB541374A08
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336831; cv=pass; b=klSpsy393UrYLgOgTIrGLZDKP3MCbZaqrAXkwcEipz4LX+GqHo9A4G5XDiM124ETq9rmN1m3yzS007TtBDxZgOyD1PtIgreNn4DMflTJPj9hOWB3lvZqJXE+XOCNH29Apt7esT9j812+U7vjK4EvWGNUjHvLam9MwpLU/LrS1uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336831; c=relaxed/simple;
	bh=xP4wgycTBIkt8c6sVkj+Z6gor+uRbN/SxwXhPjWur1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWfD/FMNP/FaHU+6/M+USICXezUjtT6gggR4XI0p7VPPkqQRRXSv1+NDQJ6j8gogPjNZg7SVyW4sUVSjiDq3UFSuKIQlVN2SXxHXVMjkSOpf6qyCyrC1ApY6oTeslcnz/ayKEDeoao99xZhUqebhuxTME+fJP/ovRsOrF8ec0X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLJg/4JM; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLJg/4JM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso182520166b.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 08:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792336828; cv=none;
        d=google.com; s=arc-20260327;
        b=q66OxGskgnRf1a2pqV5gnl06esv2VSTYDsb+VJCNRYFHeIz4YpcdDhKzisXC8iOA+S
         Ns4LpMqIaQ0EZNpGXhhQlrErq/kHOy02+bwEdmhyQf3YGlmjN1MWG2BXpzSx4tBtHexX
         J4wkW0Tj2zn+BZIXh4sv6Jd+IhZmCwKw1ji+CAy21MvbkLPaoB/Q1jEIAgxg7iFSv/3B
         /kby4+0knIHBCZNTf/Gg1WybydFHbRu+Z0mkzNbPFDPGlGZIi9HgjntYrEBYiFeCX3/O
         XaCW/aeL/yZO44yIH8ef7pyz/phZtMQ+/fYfDmsyJx/p3r0kZ1w8rG9MDw7/lQq+PShj
         pS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xY+XbxjdXKSX5SrgS6tbTG04dRCh2I8Bt6Y5M0wr/og=;
        fh=6b4Qzxpe7vOCxdSipzihDsIevbuuxZlUr+ip4NeWDp0=;
        b=MBQL58AKMF/CVRid5i2RG4Oq1GxKp4pmVVVz0hlG1ZnzHoO6xX3wvpxcMnly6lKUsX
         Fn8WzzJZB44KFq+xDrAwKkVAgxqVO2OlMhJHjngWwgoLT+X47HvFcWjlwxt+cszmyUtv
         uwmFEOARUrK+Pa4CM08SJlCgcH6/+z2bTsH5qgBLAVR1AJP++YcSw+UjKxg1ys+KYEZl
         R5V/0Km95pDo5QQcCOcPAQnvoYrh/3y4X89HmEiNYkNOhiXG+jHL6IUHWPLM5K9EaukF
         jikFthwng8cwhWJ7b9BDq7y5UF+pMv75Rq2Hiuaikki7C2exDD8bX+rFEVcGFn01m7Kr
         qHPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336828; x=1792941628; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xY+XbxjdXKSX5SrgS6tbTG04dRCh2I8Bt6Y5M0wr/og=;
        b=qLJg/4JMWHdlhgJcz6304kzqwxK1ur/NZCLXZ+LFqch4XUM5Py3Ih4/pBbJA+tjUN2
         dRlgfrDcswtjWCzy5/YPBoqDkrqZmYSpgjoBvGMUO+jaH6hoQKdgut93uz+9Fplnscwi
         F0Ae7C+UxlSqAlk0Gw4cFvnoou3VOQLk4WF+ER8ABQjEitelUlGjElvWCwXDQ6Feugyx
         EzyJ/vHHILLjq0Xf2RBjFBW9FVUis130u1MruJ781IouJpquCjqOSTg+aNRGL0hRzPd/
         CWSTNidLSrXnxR1mXaIjZee5K2T4gPFMqIPqG9EMxyBs8HsxLizv3Q3FMtcrP4NLiIXy
         TDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336828; x=1792941628;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xY+XbxjdXKSX5SrgS6tbTG04dRCh2I8Bt6Y5M0wr/og=;
        b=u8AqEPEFwj3LdF0cZRGu3obVgoNYYT91nMf7B/eKE/cMoLyBTYYvp/MWg7ZprGm8Zi
         gUnifR2DS1ttY7GmWZWFaZtT6tXJ+tQxQ/vSRPYOTEGDTjdH004oaf4vttTxlFZ5McDk
         uX05kRD0XCYha52EVNBN4Ol9xwZKIPGxA4477Q4vYc5PV72XKjUqTG5rsYdkj+0tGhlA
         TNnRpEfl7kACbTu6OwZWlZ4iSXaTJDLd+keckRVoJAqz2EpSmfwmlMVBm0r58GtuGFn1
         TgGmUmUlpAPcGoxn7tHUimIZE+oZIEVSXyElc4BjN18JpF4dW5xPpgD6a3k/s0omgGif
         jZBA==
X-Forwarded-Encrypted: i=1; AKwUvBylVVNCS4SU6I727Q9VXihnAaJcnS9w6iL4mh574rPHKFEQvP1VYrdkN4JQ3gvDXLkb3vk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxUUPCWBDq+mcjRmZaJPjZnBI4spF6xgIacFk3c44vYoBTGTvE
	YnHuaL0GYrCRUida29Zby029mL9lUCbyxf67udnylMcqMpijDlxrPZ2j/mzSYlJ59qu2F5afTki
	jRjsW7pHYVb0BOOkxpa9WaIpIwpMpt7QxlNVW
X-Gm-Gg: AYBFou1eK40zBfetW0ylfsDeQU9Y+v/l/gV13W3aagx/Ziaq/ZRAspC/c0yafPuKiBY
	C0vX8vYG3lITdjwrFLE6O5NcR1SBe2NF38QIg4PQoDFu+DgbTNcpFj0hTrXItLnxy5oSDeLCyak
	mkI6Ufdp+dhJK8sPoPPjkqE00wQ/I9zZxbHKPTe72oXHmNl0pBNHB9ajmsRic1Xv0iXFUqJH1NM
	kAqRCUKur15GbkqQMUHXpF8YG8npW32MtzS28mlpMb+yzFwFiU/DEhPIfLX8DBsrEBXqVeT3ccL
	Z/PeWSPVK8rFIAZpbFKxY4UUH9bvj55mDrfY1s4HPyBurORoNIcMjBt5ojRsGV0wZl0=
X-Received: by 2002:a17:907:8e88:b0:c33:9fab:5f61 with SMTP id
 a640c23a62f3a-c419f60c256mr331873966b.29.1792336827940; Sun, 18 Oct 2026
 08:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2450.git.git.1792134165785.gitgitgadget@gmail.com>
 <xmqqcxt9h9g6.fsf@gitster.g> <d2264240-1530-48a2-ac3e-ae46f855872f@gmail.com>
In-Reply-To: <d2264240-1530-48a2-ac3e-ae46f855872f@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 18 Oct 2026 17:19:46 +0200
X-Gm-Features: AclHuK_1Ba1qRsEgGzT3XQV0qM6aijB4FmL_syRlf6_sMmiQSX_0NFW3a3tZULo
Message-ID: <CAHwyqnV=iiocV2FA32-X8LTgYwWmzQguPtkykFKM-t7B7ttNOw@mail.gmail.com>
Subject: Re: [PATCH] branch: let inherit track a remote-tracking start point
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"

> For me it depends on what I'm forking from. If I create a branch on my
> desktop, push it to my server and then create a local branch from that
> on my laptop, I normally want the new branch to track something like
> origin/master rather than the starting point. However, if I create a new
> branch from origin/master then I do want to track the starting point. So
> it is not clear to me that the behavior proposed here is better than the
> current behavior, but equally I don't think it is any worse. Having some
> way of saying "set up tracking when the starting point matches one of
> these patterns" might be useful, but I find the tracking options to "git
> switch -c" so confusing I normally just run "git branch
> --set-upstream-to" afterwards to set the upstream I want.

I don't actually use 'git switch -c', I just used that in the example
because it's the *modern* way to do things. In reality I always run
'git checkout -b'. I agree about `set-upstream-to`, there is probably
no single terminal command that I run more than

    git branch --set-upstream-to=origin

Your example got me thinking. Maybe we should go the other way? If we
can inherit from the branch we are coming from, should we do that as
first prio? Because of the `--set-upstream-to=origin` usage, we will
likely already be tracking the right one. So

    git checkout -b first_branch
    git branch --set-upstream-to=origin/master
    git checkout -b new_branch origin/another_branch

could give us a 'new_branch' that tracks what 'first_branch' tracked,
i.e. 'origin/master'. Maybe as a fallback, we could have the new
behavior from my v1, so if 'first_branch' has no tracking branch, then

    git checkout -b first_branch
    git checkout -b new_branch origin/another_branch

falls back to 'new_branch ' tracking 'origin/another_branch' instead?
Or not, maybe this fallback is just bad?


Harald
