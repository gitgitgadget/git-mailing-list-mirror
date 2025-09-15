Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E592341655
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950151; cv=none; b=IZgfP4a12WwjOPMC1AYbAp7p4zQW6+h3pBMl92UwH+k4aVcSc9AlqpwU5iLRpCsuNh6HztiIdW6ueFimGMbIae89OXapcgNSbrS/zj25OlYfjajnihSc4PRjeI/Fn3MbBR6JZW259e3TWOt+xrjVw50WzWsesy6iPegw7Bipeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950151; c=relaxed/simple;
	bh=ktAY2K5ppXtk+RWYe3thB5kH2TyWh9ZKR609LwT8bvQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MS9KqqpxKxAnDilpzb9AJFELt60LTMTAcuoriGxkDZ7cCPg6TREeJlA57HEv1wkuM77nBStX4NWrwvO0ui2DyO76W+i0+OJ0cyIMgw8UMiWiauVTHQ4U9AbLjnsM9bP29xkTLtPxxC1SpXETnB9hloRmbTAXcARTkMXtHbKohtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEtPyHEy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEtPyHEy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109c6b9fcso34321361cf.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757950147; x=1758554947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k68SYWLp05kve75UIJ3PVxvdS8/CrOruqIn4ehLoaa4=;
        b=XEtPyHEyxl9WfAFIvsWj2+Hmq2ro4C7m+TGCBAaVKeFLKwEt6V1RuruXe1l+tf5qqU
         J7kb3NVZS7v58WMxdTJh3MeX40DKIevv4HhNQ6CYxe+xPF3xZoGUWP48FJhs6Hp/u9Gs
         4hP1Xsa26WjbVtCHwPMo16KQGTQ0AiKx0mlqy6a1GkcnEi057lZ3xfOY5qAzTa3UftjJ
         BwHZA7stZwkJY34Sujcdpvmisk6YE4jcSbOFaB7obHAsgA5Jrn/rsvMIuzJMM+Dht+Ud
         oHe12bCDw5HRQT70lDjnqaE3DwhqWO9yVAGGF+POd2QOVgcUFg+5XE9TdIkpbNUB15iL
         YM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950147; x=1758554947;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k68SYWLp05kve75UIJ3PVxvdS8/CrOruqIn4ehLoaa4=;
        b=iK61uvpfW7llKFy6XQs7IF8zdP9nnO0VFVawngJ0+prSiGydK09FSWfhcK+JdaTdzn
         85yzu8iIhZCAMrqme0Ra6MovjW7nsXBv1XtJsk/G2Rz6Oe2T5SLfsE1VzI4tNpaPdoOE
         u2Z5hTBmTLOXkbkG6bW8JniQKYOKG/t/7vDfhAVxeQoDgpMHe8IlaxD6MZMDNf8GgBrx
         f1XzE3dvSX6BYJkWi9dzPG1u3lMWaIybZTtaLelW9JtZDQulSNBTfbVoCMssOW4lll0S
         1GASk1fX0PRjCXtM/Zc43NLY7neVR8ubuItLY6Bwtl56rDRyBK8jggFA2/zfU2Ojtn8v
         wgrA==
X-Gm-Message-State: AOJu0Yz639YXW7FipCMDH5PElGS5ccTMhz9oQBcpFup98PWW56CZiVck
	w5+FaUihKj/kaK102nnisC1WUug4azaWtQcMOoqlsJqP7gDXfpmQ193EXccS1g==
X-Gm-Gg: ASbGnctt12apjZ5Qx17dy/rIvqCNEX6346jq/blIfHbYHVn9rFvx8saPVlkEc1Nq/X3
	VFfa1rTW41LunLSJ4vDbye4ixR6Fo66qTRgixxoyzB6zvmT25fXcoXWUwVyUn4Cf85Ff/fOi6VJ
	o23vUAvYb27561e03n2ywKNu/oiimtmqh/0Akeb9IPFqGLqBiKN3QvjvgXquSukP/GccjPW65mC
	WP1ViFeT4Hikt9G64HkZbyeDv4RiMxOs+2MAAKUwbZWFGrLyiAMQJ8azJyRV9JyvyChyJuSb6G0
	Jk1RslUpvGnM4GAIlJc6GxAbTTibXsu7ZzqSYcDKc0z0P6fcqnqhCsJANAcrrMxo8gPWQJHy4E8
	DdXUVgqRxFOE3WDxkbZNVVUqy
X-Google-Smtp-Source: AGHT+IEBMkERDRnFjS3t/ursX61QftysC7+VYsEJFn5HeAltUoJ4eCKNWJpbNCtAyGYr+nsIENSn2w==
X-Received: by 2002:a05:622a:4808:b0:4b7:9d73:ec9c with SMTP id d75a77b69052e-4b79d74178dmr60540861cf.21.1757950147171;
        Mon, 15 Sep 2025 08:29:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.95.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cfab4f6fsm808869085a.69.2025.09.15.08.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:29:06 -0700 (PDT)
Message-Id: <3e2ec7b37f1935c5b091fc4b47b6209beb384d3a.1757950144.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Sep 2025 15:29:03 +0000
Subject: [PATCH v2 1/2] add -p: mark split hunks as undecided
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a hunk is split, each of the new hunks inherits whether it is
selected or not from the original hunk. If a selected hunk is split
all of the new hunks are marked as "selected" and the user is only
prompted with the first of the split hunks. The user is not asked
whether or not they wish to select the rest of the new hunks. This
means that if they wish to deselect any of the new hunks apart from
the first one they have to navigate back to the hunk they want to
deselect before they can deselect it. This is unfortunate as the user
is presumably splitting the original hunk because they only want to
select some sub-set of it.

Instead mark all the new hunks as "undecided" so that the user is
prompted whether they wish to select each one in turn. In the case
where the user only wants to change the selection of the first of
the split hunks they will now have to do more work re-selecting the
remaining split hunks. However, changing the selection of any of the
other newly created hunks is now much simpler as the user no-longer has
to navigate back to them in order to change their selected state. Due
to concerns that users may be relying on the current behaviour [1]
this change is guarded by WITH_BREAKING_CHANGES.

[1] https://lore.kernel.org/git/xmqqjz9b6xr1.fsf@gitster.g

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/BreakingChanges.adoc |  5 +++++
 add-patch.c                        |  7 +++++++
 t/t3701-add-interactive.sh         | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061..f62f75898f 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,11 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* The behavior of "git add -p" has been changed so that splitting a
+  hunk that has already been marked as selected or unselected will now
+  prompt the user to select each of the new hunks created by the
+  split instead of them inheriting their state from the original hunk.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
diff --git a/add-patch.c b/add-patch.c
index 302e6ba7d9..32157e31ed 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -956,6 +956,9 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 			* sizeof(*hunk));
 	hunk = file_diff->hunk + hunk_index;
 	hunk->splittable_into = 1;
+#ifdef WITH_BREAKING_CHANGES
+	hunk->use = UNDECIDED_HUNK;
+#endif
 	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
 
 	header = &hunk->header;
@@ -1057,7 +1060,11 @@ next_hunk_line:
 
 		hunk++;
 		hunk->splittable_into = 1;
+#ifdef WITH_BREAKING_CHANGES
+		hunk->use = UNDECIDED_HUNK;
+#else
 		hunk->use = hunk[-1].use;
+#endif
 		header = &hunk->header;
 
 		header->old_count = header->new_count = context_line_count;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 04d2a19835..43a856e0c0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1301,4 +1301,14 @@ do
 	'
 done
 
+test_expect_success WITH_BREAKING_CHANGES 'splitting previous hunk marks split hunks as undecided' '
+	test_write_lines a " " b c d e f g h i j k >file &&
+	git add file &&
+	test_write_lines x " " b y d e f g h i j x >file &&
+	test_write_lines n K s n y q | git add -p file &&
+	git cat-file blob :file >actual &&
+	test_write_lines a " " b y d e f g h i j k >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

