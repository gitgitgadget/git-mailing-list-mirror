Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F52DE70D
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739529; cv=none; b=DcQ3kvX475eD6MyRS+B+LpAjkE1+A9uqxtfJwtgeRJnNaa42OSCw0mfgmZNcvDjC1NzovKM8AIX6OQFNgMXn98odo4gKVWMpB2dRFzP0clDLux9QNbGwgLcolXsKyZZlQEbjg7LZMMiuq5EMTOUVYiRIXQH7TcJtmF0o6sKLo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739529; c=relaxed/simple;
	bh=TX/5IhvaNZqP2JDR6sZOqkIYQdQmZuGXWkLyKSzs6Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4NB04KlscspBlZhRzCNCl7Uynxda8V1xUUR+qVoypgBDMmCp7MNvtGFnlsWcbjOnO5Pu55l60OA7qa1cVPrA3l0HQdpDHwR4lw1rfKT75u+34S8tVfMUWbLC3P8cSzC2wioCylHDdvhnCUn3UxzuEG9NjuVnfszMxRO3SIlRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ/nfSbp; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ/nfSbp"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-464bc03efd8so4974054b6e.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 11:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772739527; x=1773344327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1p1bqwZfHz0SmvMoAWqk4aO3k7sIRGQlQkfxAnv3wRE=;
        b=AQ/nfSbpIa4xNCFBVp3IYIy0OL1n1KI2BginnAhaupH+TxbmNFRvq5HqUc0HV7nC+N
         izNUdFtmdotejAIqzrSV5JiThUOHf3P/JOaOqQic8HaJE4TM3SDgnYSE7acH//Nys0Kv
         3lfJudeBV4FCNK6m5uHJ/ZTC17l3rI3HNBq1w8dpQyF9tIqcfEFoEz1zHcLkO/eOkbii
         WKPY8w4xPLH38kYfYFDeE0C/NrSiyWE5tEBkWPWIkQLpPjEqPE+WOPZ1wg53tImkQwOx
         Fbbpd2z/qd8F7y00JnbcXQ9dPqFjn+xKZrawYJrf/mXSF7evOpKg6nO9EHGoOz4uIR9s
         kucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739527; x=1773344327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p1bqwZfHz0SmvMoAWqk4aO3k7sIRGQlQkfxAnv3wRE=;
        b=gzD2JoL/vzWxvR/bqCRb+ZcQ99aA/cmdMU8vGyUEKxyskNhV9zYlGEsvJQuxJKao3V
         5IeNgaZjOdPTKmNnGEKkX83DaP21lZYLK6QZhr6wGQ2tWhnWyQonlvPSwZog4hCSSxZr
         ud2B2c1XH6BA8Ji7ACHuYO4aMeTjKWeuyFH1/NMLrNs4IR/ta6hFXX8zTndyQKbwUEb5
         ulWLxaKOgP74315PuZvyO4+ON/ViKVpKfANtMgV73PrRN4n931uI35FWIsk0//RV2sjz
         qhj1b+XkO53Eb0N8n/GDOodRrjGYC6nlgQJDmir3w7wYwCJuf00+OUohM66PNZ4UKr/S
         Kf5w==
X-Gm-Message-State: AOJu0YwXxp1PzatyBcKunmj3x8ZVm62TLcRziplgC/0t7hOSs6trTgz5
	C74OhYXDuyPCcB7gUncS1vZ/Yc3mEFcC4URDr4xX/widf+whsHqZ7B46w6dG9Q==
X-Gm-Gg: ATEYQzzjKyNiP1+SEme9C11ZmHBnpXl6pHfnqBQOPjuVoJIFWMGgRuFRbC0cFq3Kbx7
	00AZ5OZfawAUlLkmKmwWE8H9/wYrHqk4DvyO0YgeSFMRTQrDNn+XSDddwxsJOaM/AwteKGP/JN3
	/a3C3hIhHCovnoQ+rtwUcnUl0dyMkI/FOUgsNiIuWJgcKUxctlxzt5WB9038SMluC7EhP4V5ULU
	rRR5UFToPMhR9cjgKgrqAq6HIsfxc4HqFbb30+Frm1Qc6+9t23hWMBEiVVAB32wxHG8vOTOB5uz
	307JimCgB2xqZ/P49ns1e9S/+9TJ6gp4yet1NJR92tyMkkJMhwLYcQ5+PRLDKUqAFNeuSe/+KA3
	mHVsoKX8aBmCsEFrHtVS/ytIe1MSOFZrUjWdrCd5cMGAHE3E9Us+cM7pJROdwNRs63fR1dO7CPV
	ezh+SqDVoHpLFowRe919nYXqxQuIPBxy4=
X-Received: by 2002:a05:6808:23c4:b0:45e:dbf9:61c7 with SMTP id 5614622812f47-466d8736002mr517375b6e.46.1772739527121;
        Thu, 05 Mar 2026 11:38:47 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d9absm22446864fac.16.2026.03.05.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:38:46 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] Documentation: extend guidance for submitting patches
Date: Thu,  5 Mar 2026 13:38:36 -0600
Message-ID: <20260305193836.973122-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before submitting patches on the mailing list, it is often a good idea
to check for previous related discussions or if similar work is already
in progress. This enables better coordination amongst contributors and
could avoid duplicating work.

Additionally, it is often recommended to give reviewers some time to
reply to a patch series before sending new versions. This helps collect
broader feedback and reduces unnecessary churn from rapid rerolls.

Document this guidance in "Documentation/SubmittingPatches" accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/SubmittingPatches | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e270ccbe85..5acd692ad7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -38,10 +38,23 @@ they have no obligation to help you (i.e. you ask them for help,
 you don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
 help you find out who they are.
 
+It is also a good idea to check whether your topic has been discussed
+previously on the mailing list, or whether similar work is already in
+progress.  Prior discussions may contain useful context, design
+considerations, or earlier attempts at solving the same problem. Being
+aware of such discussions can help you avoid duplicating work and may
+allow you to coordinate with other contributors working in the same
+area.
+
 . You get comments and suggestions for improvements.  You may even get
   them in an "on top of your change" patch form.  You are expected to
   respond to them with "Reply-All" on the mailing list, while taking
   them into account while preparing an updated set of patches.
++
+It is often beneficial to allow some time for reviewers to provide
+feedback before sending a new version, rather than sending an updated
+series immediately after receiving a review. This helps collect broader
+input and avoids unnecessary churn from many rapid iterations.
 
 . Polish, refine, and re-send your patches to the list and to the people
   who spent their time to improve your patch.  Go back to step (2).

base-commit: 628a66ccf68d141d57d06e100c3514a54b31d6b7
-- 
2.53.0.381.g628a66ccf6

