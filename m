Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CC18787A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230216; cv=none; b=qRzg9PVFVg7q2rbgAplsHC7ef9AesjlfmIciGRY5WFjIo5e6JKHKI6EkPtynbg6ms1dFAJXCA6h/9fiXhtZON0T0LicbirQioV/LlzVQyQpyJ/XIEviOMHfNN8kbCmIfUkOa9LXuPH176R6tG5V0pd0kezBz2xK8TBk6WNDR+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230216; c=relaxed/simple;
	bh=o7FMeRrWJH2jMx0sZfrGy8roLREqGsMq6fhQF7AnecA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ub2HRLNN/VSeEAy4Yv7ng9+qri92x//3onGJYwVLAD2KsiXj3tIbH3rE5PsS13LW7BxihYcS6Wl0LBTqzU9MEfJDz2tbT5hQUSV1zbvgojxbHWrHErBTOBpN78eA6C1pxgtX3sP21ibBsKEfKnjo1KQdN+6ZCixuxDMnZpgrWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=TAk3Iz5F; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=Bv9ye3iY; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="TAk3Iz5F";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="Bv9ye3iY"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-22435603572so74246055ad.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 09:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230214; x=1742835014;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:dkim-signature
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRgwgzcUowBwORzPKZV7U8Ytjkk/V9VnMMp2SkWJOK0=;
        b=lo98t67cJZPuYncn/gmCZmvA394x6mg8WVjcsWW+kt9oijdnaJuxyjWg5VyaC2NjDL
         8SbHYs8b/KtrT/6wWDGWCYTyJhZIDGC6SUKMOLboo8A+mhqjzzGau774r6Sz5kwiBncd
         5aFT/LPJUg080qPYMMjLy2xHxY0lnBsBv3YuE6zotWkvyoG8sVvAvveojmOUXTBlNQs5
         2jM5Pg5bGMGHpG0px3/5odl0vsrCVFkjnfraXiUZQMrQnzBFq84HFuUZDcVxEg2+5stx
         HM/KOuiXwnNkK9zUrxKbpZsoeO+pc/7RwXf+A1cTpSIKNmehnkLw/nNb4uU5JrCpISeD
         YZjA==
X-Gm-Message-State: AOJu0Yy5SsNQ9ZfIOPmq0DpAJca8/57WESWKKjcvDHpV33ndZm3KlBjl
	LHKJnIP3Hhb40KaY9pKnw0hC3tFNsnzBLQG/RGIRfMKVr+kmZ3VuYkjKgmiHSc3zhy90b70/jU0
	gs9slQXfGt48mwUACI4DgFaMcdSBTbWrSdXHKv4ngTRCySz7B+LtHFfJv
X-Gm-Gg: ASbGncsikEJfqWGzm58JdCgOi6Rr3anIsBW0vNSrdYc53msQ3NoVH/yoKoa67DbeKEi
	mnUCWbxhP4An4PwwumO0fTovUUnxDsngHkOfwYGK0SA3hhqpGLckrDDi16RqJXE/s8zxMZV/VUC
	AOS4FEeZ1ChOovA7+vguXD/zhGGxYE6EqdXHi9IYORn3ipGLMm0KzUnWUhW+B2omwo5sRDf+x8X
	O/wAIziAlJu+8kBbYYq7eEcnxOhqnQtqc34uWqSAnnTswyafTCt+jYIrC0vuUl1FSFF1wLTn+hV
	c1bSmwgLOLMJrP/uZabEx55BGfMTmCdljNBLz/js
X-Google-Smtp-Source: AGHT+IHuc4FMPfl5wi7PI4I/f0Hp5z/UtZJBg+KSoTLegBx8Dg1vEChEktvh13EaW3Rqve1yvomPE8/+FOJn
X-Received: by 2002:a17:902:eccf:b0:220:e362:9b1a with SMTP id d9443c01a7336-225e0a7b290mr149042585ad.25.1742230213887;
        Mon, 17 Mar 2025 09:50:13 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-225c6c0e006sm4106075ad.113.2025.03.17.09.50.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:50:13 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1742230212; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding : from;
 bh=o7FMeRrWJH2jMx0sZfrGy8roLREqGsMq6fhQF7AnecA=;
 b=TAk3Iz5FWrg3EXNLHS2PbU+IfXrzRzkrAaSr9ahqbXgyBM+N4/RYX3AEfC9mINRceOl2N
 8upyUZLkOBenrwgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1742230212; h=message-id : date : mime-version : to : from : subject
 : content-type : content-transfer-encoding : from;
 bh=o7FMeRrWJH2jMx0sZfrGy8roLREqGsMq6fhQF7AnecA=;
 b=Bv9ye3iYyhdFAUmN5+kfV75VtlvD0h8LH2Nnxi8z5/1pmUdWw2rHJHK9dInbhyQESQ4DP
 GllRJsJiG4zjC/aUJcj/AM/z042ECaWDjaUNqhYqC73SmGzhVBqfJD+Qeu9QMU8u3qnhgTi
 AJDu3F2tqunDfTTkjomF1BiVFUx5OyfrHS+MwUsMJB5ktCrcWYZeDS+W2y78BBwwUrDZ4UM
 kicUEueM/5YLwM8czIHdwE82JrR8GK21Z1kTCQ9l4l2XK31SCQloplYpeU/giXtl3bgDjw+
 Chu5PPE1SlOIa1fMZNiGEH1H2E6NcbyM5OfDFiRKTJLzR7y3PgKCu8jzPWJg==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZGgv84kyWzySw
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:50:12 +0000 (UTC)
Message-ID: <bce5a500-76c4-4462-8f99-b17a6f21f7ec@mandelberg.org>
Date: Mon, 17 Mar 2025 12:50:12 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
Subject: git switch --force vs --discard-changes: docs don't match behavior
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

https://github.com/git/git/blob/683c54c999c301c2cd6f715c411407c413b1d84e/Documentation/git-switch.adoc?plain=1#L115-L124 
describes --force as "An alias for `--discard-changes`."

At least on git 2.47.2 though[1], it looks like --force will force more 
things than --discard-changes:

$ touch Makefile
$ git switch master
error: The following untracked working tree files would be overwritten 
by checkout:
         Makefile
Please move or remove them before you switch branches.
Aborting
$ git switch --discard-changes master
error: Untracked working tree file 'Makefile' would be overwritten by merge.
$ git switch --force master
branch 'master' set up to track 'origin/master'.
Switched to a new branch 'master'

Is this a bug in the code or documentation?

[1] I searched the mailing list to see if there were any relevant 
changes since then.
