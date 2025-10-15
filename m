Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CE2D4803
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566058; cv=none; b=oIcKIqrp3RRM05mT1WU6AkNCJoh4J0OpTuhHt5Wgzig8XJpqWtMnVD03mQKpkvokPAGepHMvLd7ysw3hjcfgaLQ4ZMb9dr9Dc6+toK8w7s6NbTrLJVaYOV9zYBpac9o4GXYAsKnU197/KbAoflnHDDdvIDh9TEsEgocJxPk71n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566058; c=relaxed/simple;
	bh=DArceFpg3oBMJh2PNiV/KnBnrZAuXwQMR6aFepGR/4k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eOCzRvBp1DsHtmI00k6NbZBjiTua06cNVLot84qPXT1EGC3vEDY7WHJ8r4LOtiG+XJO/ycjqlYPI3af8uHNq331D9DgpirNRCcJqjxQkkDuRyqU0vay00j8JxULHVM9f7MB3cpvMKdythWcTNcQ1gET3E2HUxks3ibWOY3+4gJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anUjkvFo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anUjkvFo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27ee41e074dso980895ad.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566056; x=1761170856; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5TOUFJWlgrfSrtv4lYufHKW5HkERhXB69HMbSe+5fZM=;
        b=anUjkvFowi3BHPfckJlBXMXuQwzQ2Sje6LQYHM/i0FCU2b7e5YNuBIi5b3bqn0aGa4
         Rl6tbfziydZrzKFcJHEgnfH6iK8JkE2R4CZrLmH63OGK7cz9x/+OrOUEU7RUG2XI1ap+
         N5YLSOvOS0/fMalEzPpXfluwmVfsJniyLQMJloYXqlgzwIcK5BuE9z7S2ebUp/ilvzP8
         yotoAwVgHMeJV3ohBw0RTXi6CZUAFpZR7nJwegXPkVsGVxNtwSRf3QbR8IKTtS5F5ile
         FFDyWwa3NegAXd6+Sv9ULTiVPrEvLSf8V03M5m43zlXlqjEXu9I+dMtCqOp+4eftHcps
         QUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566056; x=1761170856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TOUFJWlgrfSrtv4lYufHKW5HkERhXB69HMbSe+5fZM=;
        b=PbOXvsIpSIeRPZ2/m6koSYodkJnfqkG4wzyP/r0TTJ4A6F0dE7xkr7UIY2Pm2O9QIP
         qhVAsr8kz4WNoJaunhOmvJdGOnFu3TVAwgLydh3MXvlYtoEJSXYgrXtSbK2EHK73ruTM
         CuR0lg7CRM0jvIsISbMw1sJWPSZM/pGzoiSdgZgAKNePCjbZizNhXfOMPGtF5sJe2FZU
         cH8SnwMSU3wZT6x1AjxoXn8rBWMR4rYM5TaLSraWiHzo6XzsMu3xILHrWOJHOXOIfUeu
         c1ldT101jpUYda6ErrvmUD4J7nPOD9f7y25bjKT7e3GVDP5Ri20t4g199qYebVeN+4xy
         oGcQ==
X-Gm-Message-State: AOJu0Yz20ummtciAbU1rhcC308N2ZHhRKxS74xaZI3kaOn7iNXPmsZnz
	pwpkfztv8r8/ouFI14dAfaPruXtRbh9i8nz4ZQ5qQ/rqjy1HoIJaB3FEakhCtQ==
X-Gm-Gg: ASbGncs4gs2pivXbTPfMhcvTFTJHtQCXX9Qb77mlxQQdBJ94N17/MYqHxeEK4rbvT84
	Bzv7yd1hm1cWZTnNS7SPgo6YOF69nmDKKe7eAC15fHKgnhBTOS8od8grbZFCrjPtRGMckZd7y3k
	75LtQvCvjAEjlRsz4mE69U7I7FN6Jl8ctOBZW7LOZv1KRFC0NTEGtk+6DPb6iR14ymzWbCEGGPp
	H4j8mszBjpPxf96pp/OlpC7iC3ADQTNRBEfBOa8nY+tG08gYbBWrhz5QJ3olHqbZh9+6ezCa/sl
	UBGSUmXwu2MUYSj/npOxiB79Wkg4r9tHZwI0/0CXg8xWnR0xzapsvSay1LkTnf9vlH1aW5Kn4uL
	mI6uHhiOw9GG8qd3KhpFVk0mAuCHWFAg7xl6wK0OXA/5SfXNj5pxmc1ZjmRtSsH4iDl7/Vb5W62
	u+
X-Google-Smtp-Source: AGHT+IFiAcTymPEnxhNSL5QZln6kouO3b0oFvFt7pbGhTP5813gesNstRwNpg2ZS2TcdFF/qMAa/SQ==
X-Received: by 2002:a17:903:2b10:b0:268:cc5:5e4e with SMTP id d9443c01a7336-2902720eb44mr390004835ad.1.1760566055556;
        Wed, 15 Oct 2025 15:07:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.25.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099372b76sm6867565ad.42.2025.10.15.15.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:07:35 -0700 (PDT)
Message-Id: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
From: "Martin von Zweigbergk via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 22:07:34 +0000
Subject: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
    Martin von Zweigbergk <martinvonz@google.com>

From: Martin von Zweigbergk <martinvonz@google.com>

The `git diff X..Y` syntax is quite misleading because it looks like
it shows the diff of the commits in the X..Y range but it actually
shows the diff from X to Y. IMO, if that syntax is supported, it
should show a diff from the merge base of X and Y to Y. I hope Git 3.0
is a good time to remove support for the current syntax and
semantics. Then we can perhaps add the syntax back later with less
surprising semantics.

Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
---
    BreakingChanges: say that git diff X..Y syntax will be removed in 3.0

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1989%2Fmartinvonz%2Fmz%2Fwtmnpolouvvz-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1989/martinvonz/mz/wtmnpolouvvz-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1989

 Documentation/BreakingChanges.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 90b53abcea..93fb968840 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -114,6 +114,10 @@ applications and forges.
 +
 There is no plan to deprecate the "sha1" object format at this point in time.
 +
+Support for "git diff X..Y" syntax will be removed. Use "git diff X Y" instead.
+This will open up the syntax for a more consistent interpretation of
+"git diff $(git merge-base X Y) Y".
++
 Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
 <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
 <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.

base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
-- 
gitgitgadget
