Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760A39FD0
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873429; cv=none; b=fmypxnwJzbAYs2KNcCFwhGNpLdY+ZvhVKLdEo8cWYHdiqIwxt2m/FWMsUn77nAo9jYEiY7eRUmsxs/cUmV40XsMyh7sUNmyW0pp+j5ad/QY0tzdJ8ZJRq+2d9dRvLQzHkPdZzENtuG83W1P9Q9kXAftJAmclgkrujoWfErssZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873429; c=relaxed/simple;
	bh=D8kpe5vwWqGeGiEytyDhj8iHvw7Pe8aLp+z9tqFyZDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBcjai2sCYTvKKOlfJfj+3tbAjJmTqrh/DWL+6CDZlbA6oIY2nv6ILxlhn3Xkrb1IjIDHsAPEvj1OIFCPwuAQwM3+MPEiyLFq2FPImM9JJNUhwA4SqDBTPJa8iKLGjrt72IeMU9+NOkHBGoGpSB7dib/YIk/fOybIZz8bJkfWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=mZgUDG6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mpphTa/E; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="mZgUDG6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mpphTa/E"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id BF7CE1C00092;
	Tue, 19 Mar 2024 14:37:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 19 Mar 2024 14:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1710873426; x=
	1710959826; bh=N712S9B/bAGgyrcDabO5BlX0LLGJpooX2bqL3xKq6GE=; b=m
	ZgUDG6nPdnZXEJ8oc7WL5/nJ0BUNaUxGZ1WnMnv4jIdiJbOz8cJ4XjobxYEFeTvU
	GShJbsVlLwfiERAYAsoZSy2lJlfcVYow0LVqn95QGIgUqSCFYrBsMgIHeXIdgDJV
	y6rA/MYgxd73curtdNqp672K9JK8wxcNBG9gh6LYwWJV02I14zyU2k7sS5IMxp3g
	UGDJlbobKTlumXOAnAfkx2pWvTs1ZdsYjbWMPKDUmXW/xiKRpAVkUIF8q3WU6gAs
	ZuQ6LZqEz7Dp+xrrZydqoPCWkJfWUxPTWpqEWTtsKKafAsNDOdlTn8bsl0UFrIL0
	Qmnf7bg02edaN6Zakso7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710873426; x=
	1710959826; bh=N712S9B/bAGgyrcDabO5BlX0LLGJpooX2bqL3xKq6GE=; b=m
	pphTa/E4WhD01GvgCzKZii1DIRcXuAwfqQUr/wQpAg9Oyk2FT9cRdJRMyH04DFj0
	YygxOL/3UqbnJJburAhU9/8KklafUKVovkHxghTKIFVehB7PgaI4/o3XWyz6Ytj5
	CxJzmCIPZUY2AAqdA72G5IoI4ErsJDrJsh5tQ1NoHAmb1KZ3rjEBnwCOrQxNugvf
	KRIgRarJmexQR4VreQpG69Cw9mtyHcN0M7NsRknj6fjHuUu6wfrwjQD/q2FtjWIH
	j1hGYdFn1mLRxhlagP0TEYCgm6OXdqHw3ljK1r1PXlu4yKMIanpe3XDfMnETdxaX
	/FMvStv5AqW/VcUw09SBQ==
X-ME-Sender: <xms:Utv5ZcMTq4bhb7_0CcRTKNeTkOOvIstIu878QFA3Qlsoh8M55W2s8UM>
    <xme:Utv5ZS-4UqTZQc6UC_NMAPHXUguwruE1uuPTtl1SAoQUZWioVbsS4jsKS01p4GL7G
    9Ugzl8N0RzodnMc1g>
X-ME-Received: <xmr:Utv5ZTT-Zs0lE3z4gmHcoUlKRVN8_N7-1W4obNNZMF_qZFHf8Q_utuMBoI3zUbyzntVi5cqDno-M2Oskb5wS8qlcAqvNnjk5ap62PRAccQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetudeihe
    eguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghugh
    hssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Utv5ZUtgELLumztSSg3nFjlzrvcgt4vK1IJ29zmGONZ8yE8erOD8aA>
    <xmx:Utv5ZUcm5JIYyvjetYXPurYRp44rsBSTeH4Z1YDfMxPXW2E6v_yKsg>
    <xmx:Utv5ZY2y4uGz8YbOOY-Ob_C3hKi0ahxu7sHakKduhELWo20F5vgABg>
    <xmx:Utv5ZY9FiiyjFxBfF7oai7EdVhSD_SMp9me0fZmaqByQD1i9qMwPSA>
    <xmx:Utv5Zc78JzL_GPv2wYAof-Rq97S1U9ws_l7K7OKHEEDznpm75dXf54ig3hg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 14:37:05 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 3/3] format-patch: check if header output looks valid
Date: Tue, 19 Mar 2024 19:35:38 +0100
Message-ID: <c570467c8db35d96e4262857658fcc64328d810c.1710873210.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.144.g29ae9861142
In-Reply-To: <cover.1710873210.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name> <cover.1710873210.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: c570467c8db35d96e4262857658fcc64328d810c
X-Previous-Commits: 0e8409227e4e8eb73bac7dff97e3f53584b4e283
Content-Transfer-Encoding: 8bit

Implement a function based on `mailinfo.c:is_mail`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Isolating this for review as its own commit so that I can point out the
    provenance. May well be squashed into the main patch eventually.

 builtin/log.c           | 33 +++++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh | 13 +++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index bc656b5e0f8..2902c2bf6fe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1876,6 +1876,35 @@ static void infer_range_diff_ranges(struct strbuf *r1,
 	}
 }
 
+static int is_mail(struct strbuf *sb)
+{
+	const char *header_regex = "^[!-9;-~]+:";
+	regex_t regex;
+	int ret = 1, i;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
+		die("invalid pattern: %s", header_regex);
+	string_list_split(&list, sb->buf, '\n', -1);
+	for (i = 0; i < list.nr; i++) {
+		/* End of header */
+		if (!*list.items[i].string && i == (list.nr - 1))
+			break;
+		/* Ignore indented folded lines */
+		if (*list.items[i].string == '\t' ||
+		    *list.items[i].string == ' ')
+			continue;
+		/* It's a header if it matches header_regex */
+		if (regexec(&regex, list.items[i].string, 0, NULL, 0)) {
+			ret = 0;
+			break;
+		}
+	}
+	string_list_clear(&list, 1);
+	regfree(&regex);
+	return ret;
+}
+
 /* Returns an owned pointer */
 static char *header_cmd_output(struct rev_info *rev, const struct commit *cmit)
 {
@@ -1902,6 +1931,10 @@ static char *header_cmd_output(struct rev_info *rev, const struct commit *cmit)
 			die(_("header-cmd %s: failed with exit code %d"),
 			    header_cmd, res);
 	}
+	if (!is_mail(&output))
+		die(_("header-cmd %s: returned output which was "
+		      "not recognized as valid RFC 2822 headers"),
+		    header_cmd);
 	return strbuf_detach(&output, NULL);
 }
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index dc85c4c28fe..533a5b246e5 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -255,6 +255,19 @@ test_expect_success '--header-cmd with no output works' '
 	git format-patch --header-cmd=true --stdout main..side
 '
 
+test_expect_success '--header-cmd without headers-like output fails' '
+	write_script cmd <<-\EOF &&
+	printf "X-S: $GIT_FP_HEADER_CMD_HASH\n"
+	printf "\n"
+	printf "X-C: $GIT_FP_HEADER_CMD_COUNT\n"
+	EOF
+	cat > expect <<-\EOF &&
+	fatal: header-cmd ./cmd: returned output which was not recognized as valid RFC 2822 headers
+	EOF
+	test_must_fail git format-patch --header-cmd=./cmd --stdout main..side >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success '--header-cmd reports failed command' '
 	cat > expect <<-\EOF &&
 	fatal: header-cmd false: failed with exit code 1
-- 
2.44.0.144.g29ae9861142

