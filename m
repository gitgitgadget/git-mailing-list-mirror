Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCF138494
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841624; cv=none; b=WRKj8m/pC/2wUcPjZE96FqxdXhoozO6gzP2rLZqQmb4x8h/0xONZ1ZF1a+O0nWBCl2DQhd/dkBCGL6uOEf0AX+b4YGVddnS4xwXeOA1Bda/r5hjuE6q0cIwEMLdyIdYPILE+5qkc7/1WPiRy1lI/DOR4z0KXeuEmGD+CxyaW8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841624; c=relaxed/simple;
	bh=qoEg2HQT+5EEpXwuHIsbVEyNlIXVjA7VRt6zrmgMomM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQK434HHaIJpaNxJ01l1MeoflnfuUe6vCfUYqcQwMrGECgqEZaf7zZA/1CpWn2ZuzNwbCp9WLJsCdLzpmxl+2JRyxgrp3WNFSvDY5113LLwfzh0wu8ScKcoOUc0+77kvDYiAzph6szl9E8PX25wLO9hAfuxC2NtMni9cnATl+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=jMfmdbMX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rOiNu+qw; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="jMfmdbMX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rOiNu+qw"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 7C3515C0076;
	Thu,  7 Mar 2024 15:00:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 07 Mar 2024 15:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1709841621; x=
	1709928021; bh=Ub8fbcl6KS2OuYDodgAgrdZoJj66Y276f7ABDV+08Vs=; b=j
	MfmdbMXONFze2PCBDJ4GvfeW4KXdW90ArKADXvZVIBVZS++evShdG3Bj4spW+Unx
	NGjbypFISDChK3o/gAccNjNAmnXRSboh9PQTbNzGNVNm/uD3VdW/d/hV/7t4dD8t
	0jNv0Wo45R4eAsjdlUxGMkYSgHQuJl0EpU3hw2AGolrF2kNLbQTyxLYrk//pO5Gv
	aPyKKvgJQFSGAxwXUMScN5nl0y1FzcI3BdlNZhleKtW6sVE9ssMy0JekF1+62h8G
	icaVm/G8D2aFva8mmpiV0Jmp0K0O5E/wpXFPfU5tqOG6bRVXeMQlTQ5bxpIGq2xq
	tdN1LYmVMtxN69tFik3wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709841621; x=
	1709928021; bh=Ub8fbcl6KS2OuYDodgAgrdZoJj66Y276f7ABDV+08Vs=; b=r
	OiNu+qwifuxy0g8HyqO2t4WGjZsP1dcki5/UUm/cNKzvLdyB/xmxHXSlU2Vu8pWs
	VGHhdM7GkT4gtQ2p7ml46ckpt2dkLQFb7OpLa2d+2UiNmdQ66yxcjsGeVb/LTGYz
	B2bIVZ9aIwqof5DYTj4tyDs7oqaF+aBwILaqE87OTcoruXK8BsgRLpGjFZ/fU10i
	UfqPJIKfoRir4gFYBZE9iEtKVt+u9bcKSg1xPLteBhmvKyzzgJAu7rHaOOm5C3/f
	MR9J7CGCLMpYUWHTPk5iUy9XV1/9NppmyDmg2qD1IzMR8lr6ipZ/eDsR/YBEIizR
	eCwF3xzJkN60t8jh/nmTw==
X-ME-Sender: <xms:1RzqZY7TntfjKgYbg_ZRBZ7ueJoGSmK8i9cTZlIpLGsD_lt2RfZ0SVw>
    <xme:1RzqZZ7Dj_NxwHVJY7YSYxaZnaTFZLzIlqYjRYaAHta-qx_l1-4dv0e0955z-9js1
    yyF8uTCbQZaADiwwg>
X-ME-Received: <xmr:1RzqZXeW_i6vsnl_K6ZVXz9E4s061xVRr_oP05mhIqWONZAyjVZlIZctQ6CJwZkxIXheGBZ7VTghAzBnFBBO7D2DsC2rGVJ8JiP1W7D_Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:1RzqZdJmLOqA0oJOVegUUV9TGk_AYEZZENPA014RC5fzhcIFY0Y7fw>
    <xmx:1RzqZcI3JLtOR55l-gfMTuAP9K4SN3-l3qRwJ8QMgkXZJ9KqrvlZKw>
    <xmx:1RzqZeylQly_jFwyq6IsEkHYSgFYCQVK0FHsi-98jQuLmnFfldIpMQ>
    <xmx:1RzqZWi6RilhWEWxykeeTWRWA4K8jY0vYFpvfC0PumZK87u_h09BFA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 15:00:20 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/3] format-patch: check if header output looks valid
Date: Thu,  7 Mar 2024 20:59:37 +0100
Message-ID: <0e8409227e4e8eb73bac7dff97e3f53584b4e283.1709841147.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709841147.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 0e8409227e4e8eb73bac7dff97e3f53584b4e283
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
index eecbcdf1d6d..27e1a66dd03 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1872,6 +1872,35 @@ static void infer_range_diff_ranges(struct strbuf *r1,
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
@@ -1898,6 +1927,10 @@ static char *header_cmd_output(struct rev_info *rev, const struct commit *cmit)
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
index dfda21d4b2b..98e0eb706e6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -258,6 +258,19 @@ test_expect_success '--header-cmd with no output works' '
 	git format-patch --header-cmd=./cmd --stdout main..side
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
 	write_script cmd <<-\EOF &&
 	exit 1
-- 
2.44.0.169.gd259cac85a8

