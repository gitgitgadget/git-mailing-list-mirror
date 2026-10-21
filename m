Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590917;
	b=Bkz7fsy8q8GFLlePWXMZiZEBDZ5pJclglR3ek6HCRwUr3t0TYUw/gQdYI9luYH0MSZjA
	 vZuHt75IjaMfA7oMCSPRIRKrF2URgW3DZS0zBmVFQYZPA2lhlvzPQGIqe5wgRVzxX50iw
	 9/UGK/iVoFebNadx82sOWDSfPO8B4LogLCUrT0ujUUUM8s3Uw0zrvRyElEVga6/QFurOs
	 UmDvkBC067qwQ9KpKQc35jdbeX+SHncxb9LzBkiRsxHVLP3i03rP62MiuGTPZCyYBTTdy
	 2vNuNqfYG27lf2DNycmMOgTYClO1AWtTBlaKyGxwutaj5U/hVZn5wRTShpBBtRNE7IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590917;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hFPBx1ETjQCcU5COIY0+LKZtmtZVY0N4UtBJ37kh+VY=;
	b=RvFmgGfmcEfBGfwc/kGUMV5rcOC6eQpFufs38iYiuTor/0iLV8HeGZKluo+Pw9R1/Crk
	 FUNXZq3wOHt7jujmQKDMlg6d55BezcfPJQinVRzdvF+E2G0vNkFyUeLEQlYjZrXnMVzc0
	 DtKOPvQIqiZM3mbrm+9xD0BuCX4MSFszEZEc1tMbvKaj9LoUEoodd/FMoNQ9lomiL9Kqk
	 wxn0LpmuoQQqH13O8NWTGO5WkUt5eICNH2Fzi8PPqQXNS3BJM7msJJ8P2II5klFzddqOl
	 FnF834s5DIH9rdgqIJG8lcnBJw0MYikMNFfi6nwhktlpOFHABPUq4qAx+yykumR0cZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=OyTuJRfO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JDo0WMXt;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB5606A32E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50EB5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=OyTuJRfO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JDo0WMXt
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A91591D00142
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 09:55:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 09:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792590916;
	 x=1792677316; bh=hFPBx1ETjQCcU5COIY0+LKZtmtZVY0N4UtBJ37kh+VY=; b=
	OyTuJRfOAhjWHTpwYixa9Md0upYUZtCTG6V/KHjLuVG/FdCQZZNNaWgRfy6p8XkZ
	nZ6F14yVtcHR0DqMASst0G6lKZtK+H5XXoHtV7FEqNVIgaR8PKGTPfT4yy3O/6bI
	yJ2irhJPps6lx2B2Boh1YYzGUspQ+/UBg8aC5ZQazqusmaFGgrO0gXcf0nDse431
	n9auTzvTSPOlaiHqia94Q48p58SVZdqleuaLD6YxiIPYV7SVS4gNgFC2F2vr3Igt
	DyK/pg5X1H1d9gVW5YATznhgpXTka4yNIUdvdWIU+2zzmLYseXhlv2RpSkMhSxdn
	jDBsNso/QY1u53901zxrhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792590916; x=
	1792677316; bh=hFPBx1ETjQCcU5COIY0+LKZtmtZVY0N4UtBJ37kh+VY=; b=J
	Do0WMXtiVz0IcKobISveU2BFeDazcyvaRKh8WTP5p97ahl+6Fbz1rcB+mForxfDx
	pcGROkBBbzS5mzIHcjF6mKH/P6tcoYw+jMLl+xm/dYRDG/sBtW5w5Yjyg7aegk8f
	EA4L4EJOABBr7usV8eioprhroITKk0/c46ckPZ1nk1kdfKyvGMh4eYiMMaHlugBo
	8MQSmuvWY55r0HcuS/UC31sWbldaclmMAsaUcIkUBVKpp+A2X5PyUgXkfN+GscXr
	mxhulHd9HEGll2vVwiOApgPncKCHiSxsXI0darS5DYyo8IHhYmRjMa6vmtm61P97
	hiqbD8LmYX0Qti6k+DF8A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792590916; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:C7ynZpnJbk+6SuT+7ohqvgAmJbC2IjVK1tLRabOjYguX1qY
	CN2JuL05cFTBddHyXI8GOSdvk8vc27W8XkokC4o1dBFQNtZkwvWXB/L7B+6bNtzz
	/EC53sfm9u5tjGEJtBOMVOhU71kn3CdrIjiHnR+UhRINZTT2nwDcQdX8KZZh4855
	3fCczNb18v4Fjym7iWIEjvy4CD5KekSEl7/iPFq9oVWXKqJ39b75+XI2aSAAK+rT
	K2pYLVlxCACN85C1S9xNLme3++MEcIT7CcZtdFzLzYEgvzU4GnRY3kZmYJsWuV8B
	kUH7zpwe2baaR+vrXC1KPSJkSi7c0aUk3f+Xd/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pccrTQvVv7fFgrkrMgFdBsS4eI9goJ7/CHi8WJee7sg=:ri1Bi/2rows94he6dhQhu3bBGAloRRy7ldCYQaETZvM=;
X-ME-Sender: <xms:RMTYaoX-HxftXk_2ltzv8OuMV2U-tWc-pTsS9GpqJPchAO8ShMFjcg>
    <xme:RMTYail8emjyBKkUC-tvypIjKUTBcEETPn4Voi3vmUD-E9zVmfXcArVj3b4rH5s7O
    8FerA88wKHnSKigolw44z0tFWtmSRcktfF0INHkdJFsFgRlAWyoLvD6>
X-ME-Received: <xmr:RMTYaqCpyL8HI1yrPJjJ1pfGp6RL--1RFFwdoS86sOV353CrfG_SqE7RV9iUnyXC-nfyp2US7QCsdl9F4GBf-iCOO7V_>
X-ME-Proxy-Cause: dmFkZTGZGT175ekbvuJ46WyzXrAIcKYMr6LhdXegeJWtoDpBb1fzjUhMj22eBJEQnQz75b
    VbgDlKY22nOyBe188QM2lEfsYMs09tuQdu7iiCFare5J62TNPv1VwfGyyfvX6DJp0E47hv
    xGq1YCvGtLzPpMiETCAyHATWyVSjE0iWcv4XRCIH45/nATUBjn5nUVg251GwKl3ncBWJo+
    qeGLDWOjQVDEWL3i6K3Fw1VqdVsEDUvkfHAnDOykAAZD7c1ugeW7I/Uimm5upapCCS95ev
    RvR/WW2WBUch+EAljqBe+L99Rl3zKw6FKXbDTp9VS0WExWLp/+KAwAaTOe6Rk8a4K9gRNS
    aQt91m8QBc1xrLaKDq8tXKReDf3F5CV5LH1pehjA2F3Ylv+AoMJp6oFYg0ZBa3G/xdT5HD
    JRQTy+ruYXWgoAuWi1+ZqN3P7KE0RgtqmmYlLq29z5PQnZwF7PriR14aFhUHtctCGHzLNP
    JZytssyvBE7/MHrDtTSdbDULTDADYKxGCqmV2motQpHuEH1WpPjbAe/Ip1/yQCwPYXtHKf
    Rs2XWbRCgKJpN0ZA/py+5JuLsn2Ud0TPFiQT9Q1joV9B5ppVKfy77bvi62OftoDjLZMx/o
    VCGwECRanJ/tMt+Nob02OuFUvyqzOHDJJdbRGEHrDpeBdcYTgWekdBGkbQbg
X-ME-Proxy: <xmx:RMTYaidCMDhbYMuWQqvcWdPY5uKEAPC0r0ZOmYJ2GSPvIoU5z3bxsg>
    <xmx:RMTYalKytf9WKSLbC05aNrBL2K0FZDeEDFbPXOzf2FEQ4Y8jQBuOEA>
    <xmx:RMTYaleEwjtETQeyzMONywZJqpg0RLrhRdp6ktMiQRbz06aY_7SKDA>
    <xmx:RMTYas01gYIhyt4N74D5UIimP5ZyL5uqco8DBU1_3gPMZE3Ww0iLEQ>
    <xmx:RMTYajuzd2B7JiW98JU6NtSMNlIQOJmfe3Lv2gL4YQAYGQPNQaErhcZ8>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 09:55:16 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Wed, 21 Oct 2026 09:55:07 -0400
Subject: [PATCH 3/3] repo: add documentation for level-of-concern.
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-repo-structure-concern-v1-3-e3010552292c@fastmail.com>
References: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
In-Reply-To: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=ri1Bi/2rows94he6dhQhu3bBGAloRRy7ldCYQaETZvM=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJuHHE89v2L0KN1H1JjdpUzRk0qXBxZGKHntvTJzMnFu
 xinSB790FHKwiDGxSArpsjy/59A4yuWBxJ+Qe8+wcxhZQIZwsDFKQATMXzIyNBh0+Vw51Va9Uml
 uKBHxxt33m+1ms40TzJC5GCtZVdj4VRGhk5uh1dCIUbsrX0ycosfKJhkq4SGtu+dYN1Z6sZcpzm
 dGwA=
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

---
 Documentation/config/repo.adoc | 60 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/git-repo.adoc    | 27 +++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/repo.adoc b/Documentation/config/repo.adoc
new file mode 100644
index 0000000000..ad16bdcc67
--- /dev/null
+++ b/Documentation/config/repo.adoc
@@ -0,0 +1,60 @@
+`repo.structure.concern.commit-count`::
+	Sets the value of the concern threshold for commit count.
+
+`repo.structure.concern.tree-count`::
+	Sets the value of the concern threshold for tree count.
+
+`repo.structure.concern.blob-count`::
+	Sets the value of the concern threshold for blob count.
+
+`repo.structure.concern.tag-count`::
+	Sets the value of the concern threshold for tag count.
+
+`repo.structure.concern.commit-size`::
+	Sets the value of the concern threshold for total commit size.
+
+`repo.structure.concern.tree-size`::
+	Sets the value of the concern threshold for total tree size.
+
+`repo.structure.concern.blob-size`::
+	Sets the value of the concern threshold for total blob size.
+
+`repo.structure.concern.tag-size`::
+	Sets the value of the concern threshold for total tag size.
+
+`repo.structure.concern.commit-inflated-size`::
+	Sets the value of the concern threshold for total size
+	of all inflated commits.
+
+`repo.structure.concern.tree-inflated-size`::
+	Sets the value of the concern threshold for total size of
+	all inflated trees.
+
+`repo.structure.concern.blob-inflated-size`::
+	Sets the value of the concern threshold for total size of
+	all inflated blobs.
+
+`repo.structure.concern.tag-inflated-size`::
+	Sets the value of the concern threshold for the total size
+	of all inflated tags.
+
+`repo.structure.concern.commit-largest`::
+	Sets the value of the concern threshold the size of the largest
+	commit.
+
+`repo.structure.concern.tree-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest tree.
+
+`repo.structure.concern.blob-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest blob.
+
+`repo.structure.concern.tag-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest tag.
++
+All of the concern thresholds are integer values for the 
+floor of the base-2 log of the threshold value. The default values
+of each threshold are set to heuristically determined values.
+
diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..3c1045eb40 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
-git repo structure [--format=(table|lines|nul) | -z]
+git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]
 
 DESCRIPTION
 -----------
@@ -56,7 +56,7 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
-`structure [--format=(table|lines|nul) | -z]`::
+`structure [--format=(table|lines|nul) | -z] [--[no-]concern]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -88,6 +88,20 @@ supported:
 	quoted.
 +
 `-z` is an alias for `--format=nul`.
++
+To make it easier to know when one of the values is something that
+users should be concerned about, adding '--concern' will provide a
+level of concern to be added to the output. In 'table' mode, this will
+be a table column indicating the level of concern as a number of stars;
+in 'lines` or `nul' mode, a `concern_level` line will be added for each
+statistic with a numeric value.
++
+The level of corcern for each statistic is computed using the base_2 log of the
+statistic value. The value is considered concerning if it exceeds a heuristically
+chosen threshold value; the degree of concern is the difference between the
+base_2 log of the value, and the base_2 log of the corresponding threshold.
++
+The threshold values are configurable; see the configuration section below.
 
 INFO KEYS
 ---------
@@ -141,6 +155,15 @@ using the `nul` format:
 git repo info --format=nul layout.bare layout.shallow
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.adoc[]
+
+:git-repo: 1
+include::config/repo.adoc[]
+
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]

-- 
2.53.0

