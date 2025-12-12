Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4923BCFF
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765567197; cv=none; b=F7bUjSTeImtxFXe97MsEPyIFHPuBsjlD9nL5YpnimfYw9aAUS0pIJijr1gGnXB5Ww6oqTNB/58GxEwQxh4DIWFQsjDpET6beDLN3vv40H2WmPDEFSJj5+0cQKFcCibYaHTkaQwBU9lRUfgH98/KIMrp0LBk7hJ+dMyZ/rghIHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765567197; c=relaxed/simple;
	bh=Tv9Tk+F7ePXXe4SLCxpk47mJh1ze/ELdoR9I4xP4Sy8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SlEfw70FzhdhDwF/5au+ZOl6SlZaNNX5h3nJEnefg0PoD8A8XGc7PwPcal+wgIv6n4hdWyv8/aMxx3wcWyKxumhSxT2I4zCM/CpGLTF2SP0WitfBFZS4uPTmOn8PxCzPuS+DZSGfvB1ssp2MIeDaY+OiQT6oBeaBCQG3T+aDzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BasNV4/o; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BasNV4/o"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so643041f8f.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 11:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765567194; x=1766171994; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XM7JOt6ThA1RL+Ec7y0IUGB0anH49A8ecu7MTeFGpZU=;
        b=BasNV4/olEUEe5VsxIJPnf6JqqlMO5VU7kins1eFyVvSsmAp1o19eRtz4a/rmoloGp
         UPIbakuZTn1EmxBS6l3JJV8xfXTDljjdKmxfOfA89nbYPMI34qz91PSHPAjQ3/ymSp2N
         XTnSNjAJi9rg2jF/vGD2rVGzemRobleAJWLlG0IBgPrX8KDe3T4EvdIHrVwXAEnwLcuX
         zqtM0O/Jn0GEiWaXHZCqCu7LubQZE/9LSLLbStl3nRHPq75/MCIHmG4UU1hQOna2AG7I
         c1uX30/99G99DODnYj1rrS37tLMTOi2MBQSUEnduLZo8OU1ktchmtEqEyTWW0d6fi69D
         vsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765567194; x=1766171994;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM7JOt6ThA1RL+Ec7y0IUGB0anH49A8ecu7MTeFGpZU=;
        b=Mxkyey3IvU0AFzzusGDB2HjVbfk4hLqh1xjF9vaAc+0PeJeTSypVlP494qHUHS5Ma9
         dr4fLITwrAMGH6oH1k4Hg9wsQax3Y7UeC3mVzw5shfeOBmrEjkbNi18xbJzf5cqIxWxW
         y/eCX5eoB/ozRlUcsnQK8Ii9M5qG2mg3JUTlmvJ/riNS3mlXxEnAI3mG/GS1uXRqEtIK
         EHsZ9Bev3V4RbnkB0akkxo92NG9EfAGNyrEW6T1HxBY6w7iEi5rvN7uaxlu8VGD7DYGB
         yvlvRRnbms0OqKBTg6xtBMqCudsNWhs+Rt0L1FLVEbUurZx1Cy99f78kKPDecktpt4Ex
         yNhg==
X-Gm-Message-State: AOJu0Yxp1GOXSOrQch2Hy3WX67mOoD0gE4Ipf2SEMwEJWxnAQy+OruPE
	NpI04T0ACLfYZXxZAnMABWzgYR/2ZTsMwFGI8WJInp+iTFp1jP+Gt7Yv+YQAIZLzftRI8i5Rje8
	yMYyk3GgEEeN+yAzC/fO+V/PFhpFQD34JhmZu
X-Gm-Gg: AY/fxX4bJYtynoY2G/7L80EuJrLSQUsaNvXdqdNBgb1oXPQPwOfbBYMD0c1q6ujnnn1
	xmle12F361qQJugT33lbtOBRzpIqwg7mF3Gk/QPoFt54VjMC4yEfXZ0Fa261hP9C2IE067EnaGF
	KMSlKNbWOt3ShRcEupJ2CuXMgNIdjDSMcg4XRAO32MT4CWRDWnhZu2DqqC1lJhOQ1fmJPdrzGDH
	aw1g4xf02HZSNMfH9sKLbxgk8VG4oh8Xf5m1aAWyO+6/uTqBGyeBdEgNCD5fDT453IB+Vc=
X-Google-Smtp-Source: AGHT+IF9bV1O2pOS24NwgS1LCVho1DsXNyGcXmuT1iaVIRcTpF8cTqKahigUacK3EXE8pabKwo7HPRNZDbbP5y4/NE0=
X-Received: by 2002:a05:6000:1acb:b0:42b:483f:da8b with SMTP id
 ffacd0b85a97d-42fb46db125mr3422705f8f.25.1765567193796; Fri, 12 Dec 2025
 11:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yee Cheng Chin <yeecheng.chin@gmail.com>
Date: Fri, 12 Dec 2025 14:19:17 -0500
X-Gm-Features: AQt7F2puucydQxCO0wW8s2FRJsyj08_U2Xre3_EU8jduAEQqA8RP4J5lCM3J5JU
Message-ID: <CAHTeOx-SMLh_idKhGczPKzZNOKy04uYXmUhL8Z79yRuNpmE4eA@mail.gmail.com>
Subject: Git replay: How is it supposed to be used with raw commits?
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The new `git replay` command allows replaying commits without checking
them out in the worktree, but it only updates/prints out the result
commit (in handle_ref_update) if the commit you are replaying is tied
to a local branch (DECORATION_REF_LOCAL). If you just pass a raw
commit hash, git replay will happily replay the commits and create new
commits in the objects database, but doesn't print anything out. Is
there any way to recover the created commit? Right now it feels
confusing as the command succeeded, doesn't complain, and yet doesn't
print / update anything either, while silently creating new commits.

Just for reference, I mean doing something like:

    git replay --onto master master..45ab67bc

or

    git replay --onto master master..HEAD~

This could be useful when I'm playing around and don't want to
accidentally update an important branch, or scripting (where I don't
really really want branch names for intermediary commits).

It feels to me that there could be another display mode that just
prints all the new commits created and lets the user handle it.
Otherwise perhaps an error is better to inform the user that they are
supposed to be passing in a branch name.
