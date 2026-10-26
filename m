Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036648;
	b=t7Bf2seD+No02tOdIeb+H96K/AQe/I/QePr2+rVj8s2OCrqz0/qLVyrqPa2+tw6a08RA
	 XwPc6VDodNOBgLhEzrUo09qXi+wBG4AOHR8objPS6ztg9rJYbBd2G7Qnpl1+AUxCOnADn
	 A9K+7Qgld4vNKj/ZSnOwrMN3pCVoUSXc1Kr1GZGZQD6Z6l7VobQMjEF23JeDaf5SDlTGL
	 Ih6DD+0YtXSnXrhfKLlT1wIl2EJ3cIIUF/+Ix9FbOg82+U7aMbne5Xrgyviitijb+k+AT
	 OgdseJabb/JCYY5D3XFAdCotnzEyhezQ7ne4f9VWkS0vgrd2rKgnMSWWauravwIMFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036648;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=r99u26mwyvRTDTqF9bnwEwbaV9TbNGwtPfgwC4D4CO4=;
	b=bBZ4SqWrt5yjesawBq/pB3aICceE4voJywzKtGhoKZTPG6NgdkHq42l3UoxNWBVfKpLu
	 pj8I/bneDk6WMiI20FXfu1lcj2lUN87wSj9oa6TfthusBkbiTZr1PymLnZqtgLfAqVMo9
	 qL+3Kvnp1TUsSKWzXE8x89fV3MPcqLAp/zgAL54o6qVVe0MZuWhgAUOxusPCY9JmWWmmL
	 MMSzQXW3j3eeE2jIjqQfHYzu3CzRcB9LeF2YRykqeB+garVB3KWr6Y2HdnXjooNivESmQ
	 tzGG/PT8GcgfJhqSEI+kXuJHbWnwqvghzByGo7wyYCf8EpU2G6c2mYWKnkLtjSGaEOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=qb50Rkz8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TG3VEcuX;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D75606A32E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D75606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=qb50Rkz8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TG3VEcuX
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 818031D00332
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:44:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 13:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793036647;
	 x=1793123047; bh=r99u26mwyvRTDTqF9bnwEwbaV9TbNGwtPfgwC4D4CO4=; b=
	qb50Rkz8WLj72NofvdR0j7epaMzISsaZDzrAmgkvJJdVW1s2nEg3Y0cPqJtkPDyd
	Zysr1L8wiXB6nPBpLnclS97UrdqIJnvAhh2/642gLf6/iHJdaApRtLCtSc0mJ1Aq
	CqVdbT1ZjtLh6fqHsfIL0k12UZEPG5cSn+UOBjPicS1wuaPymeMF0GjwOKHHVoAM
	pzTeM3XXdb+D+XvenhsQ8m4zGnZ9CTwUcQ+83gvtymVM++CrVYZ4U9dGIm9unt5a
	LBfYduvkDFANzKFYZ+FVxIwY5ljWCzMwg1oDSLdPFvm4kGEhp9SHDIN1+o3/1BcO
	oc9hQWStq5CZwcqyui4hcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793036647; x=
	1793123047; bh=r99u26mwyvRTDTqF9bnwEwbaV9TbNGwtPfgwC4D4CO4=; b=T
	G3VEcuXAu6feWNVrhmaZfcSh7auawwvTDf57uq+ATiYj8DjHBOLyc25PUT0WSdY5
	Dr1paoXB1GUXfciFIF7ANTiAX53Mx9tsF7pPZ7ts/bj1LsgDeOyewQnjF/2wA0Sg
	dRTZi4ZjSVWooysCiGjxi1/gWatrD6iP6RA5a84CwTvO26KojTFDhGzeRHerCUQD
	4VznS42Dn/G/Upg0W2CJPDYiaw1FSEh3aTJ244ogOLODoHVnaBEUvhvGynneXXYJ
	mvua242Wst2gChRaB9Ak5EemWNBtpvQ5nR9M27FrHByByfEiy8Z18Abiwgx7xrFC
	NxZfC5SUWiY0d7b3rsgtw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793036647; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nN0JP/Mntj8NQMZXYemOhNniKQzCj1Kj68UIw4+kGNcmU/1
	sS2HMopqRK3Xl7AkJ7Qqk1OV3bC6PCtpwkXiEFgRXAjAPLKuHjZ5Bqdf/RxuYPiv
	y6rxkvv0dxEjxg1eygxOAQ5CdTJ/cZTsoqAWk6CR0980aQetfMY8PTcPiVAu4kbl
	hzCWLL35aq41PkNiRpOF+gjEe0avyn/6VgEIk9vD4KXVRqyEvkhbcG/ZeClc+xrH
	fBHIuIgzYvu0AJglR8b33LYjyctj0mcmmSI1Ij6jyh6NolbYLn5wKKx/krZWtm+1
	55sZWxBYNNZnpLhl7YxGCouxONmEbz4Y8XmbOKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kxrzbaKkptpBtRWinjmzi1ZTXHB5XdqyY7nS+elIdsc=:Q0M2F20bGN72CYrCa3hpTXGBmFroROvtjB4GZRaDDyc=;
X-ME-Sender: <xms:Z5HfaoT8P48KDx34vCsw2DjMSSrLDfa1yPZrbzVcgx54rlOeqkQ3ZQ>
    <xme:Z5Hfary7YJXpHcTJD6T_tSbhcuQutA1CFBDNn4HdFlpgSiiuRwNHscPbMv63hP9_4
    SyH8tAsFl9Jgv7yWsOn0EiDQUnnvNI1H1BcxTdgroixhLYKATBVLqQ>
X-ME-Received: <xmr:Z5HfajfNc9AiJU0oQitkjyUdYn6csPkunhvbOKKZMFFnSlpUFwJXtDNR6qe7jra1JKTcEKGZ_ntePPYZaS7YlQ4ACcqM>
X-ME-Proxy-Cause: dmFkZTFJYUsLm7GlYnx5KEUThlR56jMPVc83Wv4woFYlUk3FvIZnR/5el8K8RXOB9CQZsz
    Im/Jx5VcVpPUtqukSZjImTtWvSxkMiwustbt0epzd3cZJ+fJHk6vlaS6nsvFEkowL/o2QA
    gtR7ow4Gc0cBbQI6WVcW1k1mxN60tjEU3FX+4I9tSSpaab6596jUR1PihXHrJJGGHXhtgH
    cSWls5MbggIkfMyq6t4z2cn+ZOOMq8Nj2tZt85xQGHkrBQnp3Ug1gup0Cri3du8XUlxzJV
    /yVXFgAOc2khfBDSwyr3oeek+ZfS6dkSKKQn5nKFH3M8Ba21NwOypikfeZ/D3t2mS4PEi2
    KXx5C1u7GGCi9nBBE0r+/Clk2/M72MppUUQpZJddPzNpjxBlZ0Ex6mLZgnPFNZz/raFxNo
    wHNQhZxJu/Le5bAFqI4Omm+syPmsiZNd0Nzr8nunnaLOXSI7L6TncflqMX0qqj0st7aDmO
    IwgPLa43rr04ZfvwqmHf37HQrJf+C4ZhCSex2vH7qVWBBWa55RgYdCUH5XVZ6eJMX3xyo/
    qrBFNmsaRgoufnQ3Htrdyy/4AyJHslddaiM5ys1OKrmIeMzugKeOxWOQKNo5blo5BoywhG
    zANYQBqviIhBMg/ozwcwrw+ruHugNJo0GJhLwHScGlV2XzJZ/m1jvjbhtxGw
X-ME-Proxy: <xmx:Z5HfanITPNQ7ZeoSjckam4kKHC4WEaonM1GX9jehUVg8O6vH1jCRGw>
    <xmx:Z5HfakEx6wk_eQvTmxFUJA_gx8avphRiD1-MGkNz_ZC8NwLbYik12Q>
    <xmx:Z5HfahpK6Ooe-pYuWYIwjcj-HNDl7hwOIjqJMC77_WaNl82SGe4LkA>
    <xmx:Z5HfatSbB28gpS2-WM1OMEMKxuR65st6BZCyxT0sHwJO0wHD2WLhOw>
    <xmx:Z5HfarqcgcOvySmOnRlT5rxHG_QHwgZaE4WFwQNJ2r-nJGgIlGyfVixb>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:44:06 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Date: Mon, 26 Oct 2026 13:43:56 -0400
Subject: [PATCH v2 3/3] repo: add documentation for level-of-concern.
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
Message-Id: <20261026-b4-repo-structure-concern-v2-3-e0df34228dc8@fastmail.com>
References: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
In-Reply-To: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4377;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=Q0M2F20bGN72CYrCa3hpTXGBmFroROvtjB4GZRaDDyc=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLLuT0yeoXg65PqrY04L8rh+HOiO3ptrJaO/pFrrj7XGa
 u0L8psXdpSyMIhxMciKKbL8/yfQ+IrlgYRf0LtPMHNYmUCGMHBxCsBEGGYz/OHsC3l3l32GbIny
 jZJXWmpt5wPae5i3vpmgES9YvbTh7g1Ghns3X3xg0EguFi454yGrmb9fk8VPee/daQXFRwP2xLh
 sYAIA
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

---
 Documentation/config/repo.adoc | 59 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/git-repo.adoc    | 27 +++++++++++++++++--
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/repo.adoc b/Documentation/config/repo.adoc
new file mode 100644
index 0000000000..811b099d72
--- /dev/null
+++ b/Documentation/config/repo.adoc
@@ -0,0 +1,59 @@
+`repo.concern.commit-count`::
+	Sets the value of the concern threshold for commit count.
+
+`repo.concern.tree-count`::
+	Sets the value of the concern threshold for tree count.
+
+`repo.concern.blob-count`::
+	Sets the value of the concern threshold for blob count.
+
+`repo.concern.tag-count`::
+	Sets the value of the concern threshold for tag count.
+
+`repo.concern.commit-size`::
+	Sets the value of the concern threshold for total commit size.
+
+`repo.concern.tree-size`::
+	Sets the value of the concern threshold for total tree size.
+
+`repo.concern.blob-size`::
+	Sets the value of the concern threshold for total blob size.
+
+`repo.concern.tag-size`::
+	Sets the value of the concern threshold for total tag size.
+
+`repo.concern.commit-inflated-size`::
+	Sets the value of the concern threshold for total size
+	of all inflated commits.
+
+`repo.concern.tree-inflated-size`::
+	Sets the value of the concern threshold for total size of
+	all inflated trees.
+
+`repo.concern.blob-inflated-size`::
+	Sets the value of the concern threshold for total size of
+	all inflated blobs.
+
+`repo.concern.tag-inflated-size`::
+	Sets the value of the concern threshold for the total size
+	of all inflated tags.
+
+`repo.concern.commit-largest`::
+	Sets the value of the concern threshold the size of the largest
+	commit.
+
+`repo.concern.tree-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest tree.
+
+`repo.concern.blob-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest blob.
+
+`repo.concern.tag-largest`::
+	Sets the value of the concern threshold for the size of the
+	largest tag.
+
+All of the concern thresholds are integer values for the
+floor of the base-2 log of the threshold value. The default values
+of each threshold are set to heuristically determined values.
diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..bc866c88a8 100644
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
+in `lines` or `nul` mode, a `concern_level` line will be added for each
+statistic with a numeric value.
++
+The level of concern for each statistic is computed using the log_2 of the
+statistic value. The value is considered concerning if it exceeds a heuristically
+chosen threshold value; the degree of concern is the difference between the
+log_2 of the value, and the log_2 of the corresponding threshold.
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

