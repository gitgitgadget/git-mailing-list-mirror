Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365BC4F5E0
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723836; cv=none; b=Zw7DV8NdlykOdsngCwbHqq+rS0Ne3aJehbNa6rlFMWl3x8kBVnIPPs7OmpxYR3OR1KO9vyW7Z7pMdnIcpMwR5K0/DHBEIJvxhn59fjnkFgt3w/w1yV1SzzGp1DRe+RULoH1BvhEYdLIE9goMOJgBDglRgE5pfQlCOikNHfQGzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723836; c=relaxed/simple;
	bh=LOpj9OoeAubJRfM5mVlpfxgtw0/Ctt6E/pVFFH1BxSM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eon3OEbdAJcoxqNuWudPYFZ8TOcLqKD1vRtAj4QcqXNHO1zutIl2ergOhpXzP0aZ0R5uP9t4uplxtfqDuiBM4OXK8LNSXbONbprIYQzqU8bjJNFlgAW0sXGoJLOBxcaUIOS5tfvG1qKxxlxK1yRZd+VuapvK0kGYfTPCbS7P1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY8HuFyn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY8HuFyn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43690d4605dso22169045e9.0
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 08:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723833; x=1740328633; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quP5i9PEUhW2MNa4IZqC/iSl94X3H4Q3Yn9PMldR4G0=;
        b=iY8HuFyniEbSvMHz7z0C9eqJqPYNxuk7pB14iUhV7ZqnrUJcpASQfTrVxEXoxhfY3C
         dUNAuLD5uWUpC538vKM9fR18utl1Mu8jbcDnY4xt+G8p6VqmN9QTvcp5eZB9BI5Jbzty
         hceI+AfX7XlASWdERg/4//zRjB6R0ygv/8zpu6iUNNjplnMwsS1N4ddfhl75QnZEc9ni
         XMbJXyQ+o9yPOzq4Lv4F63jZhFqsEBYdt0XO4PaE8HB2ExZVzXcFF36Swoab4+ZfFfl7
         qFXwKh9ZbUdkPepAPDysCUvT2dWaR9P+PmsJmuuNOM/uGifxsU6VYvu9L07TV0YbsmrA
         OnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723833; x=1740328633;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quP5i9PEUhW2MNa4IZqC/iSl94X3H4Q3Yn9PMldR4G0=;
        b=JgdvBG1FzMh1um8pTb4ULVffZP8e2KAMu4Q2svqD1S1GlYL1IgQoYsqUTWNACAKyyL
         dTsaZeqWcnIWM82QRU8uycUk6vw44eYYIGkGas4z75NIhvipX9SsX6UhgFDFQcAy0Ml6
         G+bzm8DvDB5vK69tgZ9zNVNv1kmlrRYortvTPg4rabJZTyHOIczuk2HmKBnBf9dwuggz
         GlwSqsm95QMp9PJ8XI7iyOaHNiGQhUwjiDv913v7YdazDxYahn/WH+LvxwEJC+5pccwB
         3e7Vjx+gnTub64YV9vHrCU8c5mi9FMrYCH2ZxQD6njh4fPPz7LL+W256oyCK91Kh9EiU
         BS2Q==
X-Gm-Message-State: AOJu0Yw4r+89L7LbNQreRmXvsF/0wNEhwUk/YzJgnUkSylgm4R/B+LXm
	Q0xTJutMgfCt25O//6MA/9iIejFMBQfV4cMM+h773aSw1Cv/F86EFnw09Q==
X-Gm-Gg: ASbGncv4MNM1NcJhLJBZ27HEQpn5BxF0X9vIMo+6BQFAhhuEDOMM7zY/7hcbRgWsb7C
	dgfNMXtlc0ZCMbBNzHnY9Fm8bZSUIUztQdHXIZjIp/evh9W6N3WZ4q+npxHGieGjq1mdhn0bBjj
	w5Jy8eGxRCDAK3k19FBas5s9gh961Lr8NHFlSerAfBHICLo7GDRm+X+nSPXEKzCmrsR42IoCtvD
	6NqxsHO0AsGR4I+RkJu3O3f4jQZmBOp1bZ6C3u8wqGlIFrDMdd0jNrpDRknGzB//h0X2nEcXsv/
	R2VmaE6fIN04o2ZL
X-Google-Smtp-Source: AGHT+IEDrVMNTBlGY6/5JpXYkXdaOBYeFhkq3hX4wupTbBx16ShWQM68jaMIds6ohy4PEvU4ixHqUw==
X-Received: by 2002:a05:600c:3106:b0:439:4cef:3510 with SMTP id 5b1f17b1804b1-4396e6eb285mr62392795e9.10.1739723832713;
        Sun, 16 Feb 2025 08:37:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398148f4fcsm13140175e9.7.2025.02.16.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:37:12 -0800 (PST)
Message-Id: <16fec87766f97d46a337f5c514f1aec0668546ec.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Feb 2025 16:37:06 +0000
Subject: [PATCH 2/5] merge-tree: remove redundant code
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

real_merge() only ever returns "0" or "1" as it dies if the merge status
is less than zero. Therefore the check for "result < 0" is redundant and
the result variable is not needed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 57f4340faba..3c73482f2b0 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -601,7 +601,6 @@ int cmd_merge_tree(int argc,
 		line_termination = '\0';
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
 			struct strbuf **split;
-			int result;
 			const char *input_merge_base = NULL;
 
 			split = strbuf_split(&buf, ' ');
@@ -618,16 +617,14 @@ int cmd_merge_tree(int argc,
 			if (input_merge_base && split[2] && split[3] && !split[4]) {
 				strbuf_rtrim(split[2]);
 				strbuf_rtrim(split[3]);
-				result = real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
+				real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
 			} else if (!input_merge_base && !split[2]) {
-				result = real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
+				real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
 			} else {
 				die(_("malformed input line: '%s'."), buf.buf);
 			}
 			maybe_flush_or_die(stdout, "stdout");
 
-			if (result < 0)
-				die(_("merging cannot continue; got unclean result of %d"), result);
 			strbuf_list_free(split);
 		}
 		strbuf_release(&buf);
-- 
gitgitgadget

