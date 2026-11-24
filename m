Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516684;
	b=LFUki83nOBvKoBFRgDC2fUagDeJXw59N/3pIgg44GKBXOmOGVGe9g6Mzn1XyrKpkoUOo
	 d8SX3NvZA7p4wtwQv2LwhsHdOT5NdBDH5JHBu7T0pRnMUOil3yUiM1j75iNrxGKO5LFP7
	 jCiM3cQRxCrf1m9VDdWetlHb4v6B9rPK+4Mw59Ih4mgVhLVr7r0rWMmw1PCleDiwW/agR
	 u7Ldgk6s2FC2/ivcMEqH8B+i968qa5q4adE+HNkTJYd22HjbMuq9KQbN/geeK0YL7v0WE
	 NzrtsVcUqpoV9MRd86Bl17oBpqe1MFAwcGaflkT984nL5bqYElJ0u3Qk3xQO/llpYLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OAEqS904orIqVh7qMIPijZ7AsPMhxhM08HVEHgMoGU4=;
	b=ZiT/eCdFosaTzn6+zpER/DQVa6rrfCYOlwSqdysWCpLnR97f/V64m4Iwmlnrparbv7qO
	 CA54wATiNI75OtYDqOLg8H3QHuR3Uiymu1LKRFw/d8JTCz/xQzND40ssRzTdMVyk/k7Dg
	 08zsnNs1DvbJdswdE6BGIAQi/U6nfYpVtmhM24HZO1RRsLwoihSqR4lcnNONbRoBmLIgD
	 sFnzGVP0J3y896Q16IAVuP2WMTNov4zBVGFmm6HfAyqCYSn33WlAZvcZGhXfmH5D/eQeZ
	 jPI0OdfthnAvFrsuXvxoBc1nNX/lyDFAxvsUhTJq7Ug2jCYgyQnD7tmBCxLOlAK4tYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pv3/QIY0";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A415606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A415606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pv3/QIY0
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so2775656f8f.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 02:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795516682; x=1796121482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAEqS904orIqVh7qMIPijZ7AsPMhxhM08HVEHgMoGU4=;
        b=pv3/QIY0hm3KazvAYNvw33GzzvBEOTF1kFaz30vNh2lb6bFb0oa278Yxfv/poJyukJ
         BR5BbxjQlMMs71Ie+2crx6CMlpnZj+dVoJXO4yL89FbZxVPCDdYnw0mHAILJlM2H9G8V
         Gn3G/SIRo0VriFrRjWq/uTkCl7ydG36DM1m8nTUTxBw2XoFUKeF2w+xGYSbWjSTFt0T9
         wgA3/cc9MX2aWfreyISe97yJr0bpd+w7mhPXikw5eLmd5hTe9jTo1LIXpqW1y8R6tvBc
         GlOtsWZd/KvV5xjg4vdJY/6hH9y9Q9Ps+1ZPn2AfPFub36mK8duesYEp1HQ6IhwfHuD8
         /7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516682; x=1796121482;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OAEqS904orIqVh7qMIPijZ7AsPMhxhM08HVEHgMoGU4=;
        b=OIKjdpG/mL/k2ELxv5py/DnXx77rfE2Ltu4Zo/mAEOlk+li6wwDpbXenuwfnvzb4ou
         9NW3gPbGbuAkg9qCPKS4/M7JDCKDkbSUHHi9aKZYBmCFnoWgSE8FvazV907k9N+kvgMS
         qvjnEF6d2/xEfI0ZQT15P+2oNWv+F0mUuj6ZEeU2f749ANXF+xvvFO5E8k1+/KboOpND
         wVxY47YxoBVNh77R7x8Z2e1FScbjH1K5Ax/77ehZar3/ViBsJQGLZUUPOqyp7s/pB03e
         XLfc1rasREFE7kDMOn3rF0xY3ZNA4wS9FdQTYbSwT+VdJLmA9RF+iCV4PVw3oIUBr92r
         F58w==
X-Gm-Message-State: APuU4Z+pS0AdxPFYsRgQVYBekkY19cpiRzVo2zZZn11fM9aDWXMmf9B8
	ucATCNb8g+1WLzxOJNxlWQvMNzcRL9tojNkUDytSnzAT+dgC4RCXgE0LDEHFmw==
X-Gm-Gg: AZFdTZekjfmFs1Bkw5N8ReCflZP2tnAL32STwl2YDIOwru2hy91bw5zJgXA2JOTC3Cn
	6Q+yU58ntxqMowrMw22qUt8231EjkLZtawwDkGyGr424I3+dN0SU7mKlP4qvpOTVAvwx53b6gwd
	0MNbGHO3y6Mg8le4igwz4v1CFUBnos8o5noTnClB1/IehuAO1dT6UuMorLp+PvL6e/+qn9+rF2e
	u5Vh7L+CcnZ28S5lt1dR/5qnScHdLs+Jb5SrSa+OObASpN0Ma1RcptRR+kVA8b/x6TOPQuhCMmV
	KsPbZN/AkWrwhNFVAvvBuOVfY5QTeO4I576/WkA3nzsZV4HZPRfjSArN8qhfEwzWbQuOVEvMUa5
	wtKFIDu24D2S2n+HdivyUcyqSfsHomb87mJcQw2p3+GM9RreX4fb5EZst9Ko4yr4nr4+xnc7I7g
	eJ4jpHk6QFxTiTaoB0Jee6Sxc2jQfBjwqPP7hmgMEerrmnEOn3lKThO77sLWHyeurzOeuWxGwjz
	MtdOMjhVb3Nkqdgk942zKgeFY9M97Jh4jNdWk1zQybbUFOcxB/ViyC0akz15+l/qHLkNvdr/kZl
	hOWliY1KRkMZH4TjigGM0eG6kbN+V/QZqJmMbzQroCtbf/jLkUNu8w==
X-Received: by 2002:a05:6000:4704:b0:4a9:760f:183a with SMTP id ffacd0b85a97d-4abb400aef0mr28403040f8f.32.1795516682302;
        Tue, 24 Nov 2026 02:38:02 -0800 (PST)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm24192850f8f.17.2026.11.24.02.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:38:01 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] var: add GIT_COMMENT_STRING
Date: Tue, 24 Nov 2026 10:37:38 +0000
Message-ID: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.1.576.g0cfbda1d5c7.dirty
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27) we
have two separate config keys that set the comment string used by git
when creating template commit messages etc. As that commit notes, when
core.commentString is set to a multi-byte string, it can be useful to
keep core.commentChar set to a single chararcter for compatibilty with
older versions of git. That makes it awkward for scripts to determine
what the comment chararcter is because they need to do something like

    {
        echo ' #'
        git config --get-regex '^core.comment(char|string)$'
    } | sed -n '$s/^[^ ] //p'

Add GIT_COMMENT_STRING to "git var" to make it easier for scripts to
determine the comment character.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
base-commit: f7de81456940dd6f3274e461149bba12965de609
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fvar-comment-string%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/f7de81456...fa8b80af2
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/var-comment-string/v1

 Documentation/git-var.adoc |  4 ++++
 builtin/var.c              |  9 +++++++++
 t/t0007-git-var.sh         | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 5f240eb56e3..04aeccd7aa6 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -130,6 +130,10 @@ endif::git-default-pager[]
     The path to the global (per-user) configuration files, if any.
     This variable can have multiple values.
 
+`GIT_COMMENT_STRING`::
+    The comment string used in template commit messages and rebase todo
+    lists etc.
+
 `GIT_HOSTNAME`::
     The hostname of the machine, as reported by the operating system.
     This is the hostname matched by `includeIf "hostname:..."` (see
diff --git a/builtin/var.c b/builtin/var.c
index eb85a985b15..6dc8ec4ba9f 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -188,6 +188,11 @@ static char *hostname(int ident_flag UNUSED)
 	return xstrdup(buf);
 }
 
+static char *comment_string(int ident_flag UNUSED)
+{
+	return xstrdup(comment_line_str);
+}
+
 struct git_var {
 	const char *name;
 	char *(*read)(int);
@@ -262,6 +267,10 @@ static struct git_var git_vars[] = {
 		.name = "GIT_CONFIG_GLOBAL",
 		.multiread = git_config_val_global,
 	},
+	{
+		.name = "GIT_COMMENT_STRING",
+		.read = comment_string,
+	},
 	{
 		.name = "GIT_HOSTNAME",
 		.read = hostname,
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 883a45399e2..f228cb5bb6f 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -434,4 +434,14 @@ test_expect_success 'git var -l lists the identity components' '
 	test_grep "^GIT_COMMITTER_DATE=" actual
 '
 
+test_expect_success 'GIT_COMMENT_STRING' '
+	git var GIT_COMMENT_STRING >actual &&
+	echo "#" >expect &&
+	test_cmp expect actual &&
+	git -c core.commentChar=: -c core.commentString=%% \
+		var GIT_COMMENT_STRING >actual &&
+	echo %%>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.1.576.g0cfbda1d5c7.dirty

