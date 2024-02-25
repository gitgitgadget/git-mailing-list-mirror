Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B21B966
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708898200; cv=none; b=n1DdF3VOC6Lz3pWxlBSfyjBE9VVwA0qeTAZO+3WCI8ixOqNyDuGC/xB4SIPtuBitjW+lAUzD4UBH42ECZmRm9lwjEKKZcxBt+nc691GxzoR7fLChu1pzV8cHJ/x7m8wDzE8TVzmjrNvqz3CUxxfK6KWE5N1bgbd5Vlr9aPcuS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708898200; c=relaxed/simple;
	bh=g1AJ71IQVZZwV8spod8AfSqMSN5oNXxxf8sErkfPZWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q28j69r/uuMRM/hyu+j9T4YAqWHuBhPOgsNrwod3OLMabQqXjM53c4G9N4qrP292D6YAcvjV/fLXuxWOqyutKqbGqqk+Y1xb6hsMC04p0GodfpV9A8LE3g8ZBYIJtUR9zy1nLSQ24ZgzpZO4dHiCu1g9eZJOBcUoheNzzEhdO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A018fMJ5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A018fMJ5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783045e88a6so232164985a.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708898197; x=1709502997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=742ivkcUygGRiimt85J/bASp/7jWnncqx6Q9yy/bCSI=;
        b=A018fMJ5wrNl4ksG5exFjoecDduzJWvAtOka0XAWfpDB66eqJYxqiBZPrRSNy7BDk8
         hNx72bqqptjgD0vujgndTeDQuMSQdTEuok291V4C629NUXPjGU1plLb6XQnzGHicPugx
         d02+DMbQWZvTDXeY8lwk7mc/6VfmlByx7k2NAEN+Gid9XLsTY0ofmU0HD0sRI7xvUHPT
         2EAME4iZjaaVsbWwhFS7rOmvMKsHskt4/cpD2e6Xpkei1D39JlAIpIKT0CvnlqiXPmmp
         kfIC+xx90Cf9RRbaNPHdHUT8uNeusG9HB58o4majWSb6gn2QZ2LzFH8fvnp39/jZ9IKU
         /xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708898197; x=1709502997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=742ivkcUygGRiimt85J/bASp/7jWnncqx6Q9yy/bCSI=;
        b=jXEqRyr3HS74bBuhGKto9ZA/mGPe+etS6zOKkjm/RHM52B59sZhtEmdwoOOnjiDzuT
         9DBsCppCW7q9XTkc4775QQOqhG8ib9W2Z+zvU0ctbwrGcpoQDioFArKNhJkt3BlPkSCu
         1iOiIH+dqWcKjDW4koHp60iRf3wdBuYI/yj7nGR/fmOCRFya6rCHqfm6zph318yKM/r5
         5fqQN6LH5jdo0b3xpdo3jjujASZ35aNBI8N5y7sTn0rZD5MA+tRUIjFVlLd/qh6v/gh+
         EI8VMEBJqyPRWD7hvOFy2gCSJ4yvZP0Hh36r8J0jdj6uGH5auBLAWlxDYEy2PFPaZ8du
         9N5Q==
X-Gm-Message-State: AOJu0YyfJIdmXpG/I2PwfJqP+2AC04Y55qlvkX22lp9awHVcr4MjCJv5
	8uDOR8D1eB8GhDjC+sU4wXE5KUOidmEeT+FbhiCLus+7bJuToIcZ
X-Google-Smtp-Source: AGHT+IH7jY4CZ7T4RhEpocO3utzJnvrnRe8xtFKdBo3ve/Z8poHnKcUHFdWwcJzEQrfTDD6DYVq2tg==
X-Received: by 2002:a05:6214:4a87:b0:68f:e7c5:a1f2 with SMTP id pi7-20020a0562144a8700b0068fe7c5a1f2mr7000426qvb.63.1708898197677;
        Sun, 25 Feb 2024 13:56:37 -0800 (PST)
Received: from [127.0.0.1] ([2606:6d00:11:ff90:6090:e182:bd61:ebff])
        by smtp.gmail.com with ESMTPSA id qh27-20020a0562144c1b00b0068fb940bc92sm2126129qvb.144.2024.02.25.13.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 13:56:37 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Sun, 25 Feb 2024 16:56:16 -0500
Subject: [PATCH v5 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-1-af1ef2d9e44d@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
In-Reply-To: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.14-dev

From: Michael Lohmann <mi.al.lohmann@gmail.com>

This is done to
(1) ensure MERGE_HEAD is a ref,
(2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
(3) error out when MERGE_HEAD is a symref.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 revision.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..ee26988cc6 100644
--- a/revision.c
+++ b/revision.c
@@ -1973,8 +1973,12 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
+	if (read_ref_full("MERGE_HEAD",
+			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			&oid, NULL))
 		die("--merge without MERGE_HEAD?");
+	if (is_null_oid(&oid))
+		die(_("MERGE_HEAD is a symbolic ref?"));
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");

-- 
2.39.1

