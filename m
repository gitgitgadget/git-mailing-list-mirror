Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B73FBB3
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732441441; cv=none; b=fy0X8GmBSKGznp1zXgjooi5IEOqsgKPIsHnEk+I4X+t6pWTmdAD+FeKlMVLmZWc/5cTpQwLJUxWAOAZe0EPvWF+8JR5Ie8BGWYw9Tj/cGL/ubwKQ0N0LSISLZ4C1u4xiMD/ZynL9S+ByTOKQKvAM5GJlnmqhuPZcX5fpLbslyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732441441; c=relaxed/simple;
	bh=9qNRfNIEIBnprIECRA0ZkQhuG3Q4Go9CssS5MBdFqOg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JSGTOxbgwoChM2Q1UrOQHk1SyarEeCcWVR4YJUyfNmtWW4pu6IdD1sRw/4vIU7JLF59mDTBhjrlpIRpCiOvqwm+3gJRAVGH4gESbcCy9mw1kKqZT6gw7U+ulnO63IEYnsyJfNrCp/Rf/Yk2N/m3wr0vPOoAmqKdeQH7DJPIHkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABeXeLDl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABeXeLDl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 30DA813801F7;
	Sun, 24 Nov 2024 04:43:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 24 Nov 2024 04:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732441437; x=
	1732527837; bh=LBRCLMa9yoAxbsVSwDrn83E2en6olHoHr+upvRBHTOs=; b=A
	BeXeLDlG2d0xtUNOiS6rKbGEYKniaMCzdVkdi/GpWaaAfncIISXepWM7Gz3gRRgA
	/j/WIHNGnvZSG34aJ7cUd1+OcHcrPmJIHXZD5xbumIQC6wQlZsJ+aEIOZi7GxouE
	z9Wpi9sEe4eV6Z2gJ4SKJJs7YlemBuO6xTo7ljlfE1oes1TiUvYgEi+uv+34SuBW
	KOoO+iiW15K+utlcXdKLyie+3YY0l0KQ+E8ggthFHDu4ub9ImnX3Vuopjz4WdSA9
	jDqWRiP3OcmcFzr5r0g7bNOQ5Z9qYmw82WXl98lIkjxHwY7AumiwNN+QGR7OoKOf
	ybji1WsMCVdNwdi7WHOLw==
X-ME-Sender: <xms:XfVCZ-Sy9X5ZmZ32CfuLGvNbR40qWeGnDNNhFsaQmzx7pz1xm4iV0g>
    <xme:XfVCZzwffLeVXHMbtxRgZzQuaef-7ca63akxbAuzxiIYojjVY5BOq2NVMZ41gmVZl
    laigqjCDrDVXsL2yA>
X-ME-Received: <xmr:XfVCZ72MmW6rqrhip5z1twIjw-5vnHlrAcX2BPFmUOCUX5E6Q_ATRbY5AyTKGw1Lu4HHmN4qbu3jGG2LlXvu0-FZJKHqQSR-9n0tbYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    gfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehg
    ihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftd
    ekfeeuveelgfelteeiueffffekhffgkeevheekhffgteejhfffgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XfVCZ6Am8vSJfGLvWMnQOpgU39poSXp65lRzdzahkoaVGFVZVT2Ryw>
    <xmx:XfVCZ3j2kXEJyhKrPsdYaqDsVf6f_sX94YMN2sgraVPQf97ChCjtiQ>
    <xmx:XfVCZ2pdHEYWcnODJUffQthxgKUnqByxQexjYZ--pQfGUOsx_WX55w>
    <xmx:XfVCZ6iTVtIoA7u2r2RHn4DcZPKDLbEeYcoxKSF1jvue1l0g-ssCdA>
    <xmx:XfVCZ6taCDAgP1mbXbtr7kH-YHu-JYP6MUQgHBSFOb87npnEy_pUXZFK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 04:43:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] doc: option value may be separate for valid reasons
Date: Sun, 24 Nov 2024 18:43:55 +0900
Message-ID: <xmqqjzct9db8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Even though `git help cli` recommends users to prefer using
"--option=value" over "--option value", there can be reasons why
giving them separately is a good idea.  One reason is that shells do
not perform tilde expansion for `--option=~/path/name` but they
expand `--options ~/path/name` just fine.

This is not a problem for many options whose option parsing is
properly written using OPT_FILENAME(), because the value given to
OPT_FILENAME() is tilde-expanded internally by us, but some commands
take a pathname as a mere string, which needs this trick to have the
shell help us.

I think the reason we originally decided to recommend the stuck form
was because an option that takes an optional value requires you to
use it in the stuck form, and it is one less thing for users to
worry about if they get into the habit to always use the stuck form.
But we should be discouraging ourselves from adding an option with
an optional value in the first place, and we might want to weaken
the current recommendation.

In any case, let's describe this one case where it is necessary to
use the separate form, with an example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt         | 10 ++++++++++
 Documentation/gitcredentials.txt |  5 +++++
 2 files changed, 15 insertions(+)

diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
index 7c709324ba..e484be9a36 100644
--- c/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -88,10 +88,20 @@ scripting Git:
    other words, write `git foo -oArg` instead of `git foo -o Arg` for short
    options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
    for long options.  An option that takes optional option-argument must be
    written in the 'stuck' form.
 
+ * Despite the above suggestion, when Arg is a path relative to the
+   home directory of a user, e.g. ~/directory/file or ~u/d/f, you
+   may want to use the separate form, e.g. `git credential-store
+   --file ~/sec/rit`, not `git credential-store --file=~/sec/rit`.
+   The shell will expand `~/` in the former to your home directory,
+   but most shells keep the tilde in the latter.  Some of our
+   commands know how to tilde-expand the option value internally,
+   but not all.  The `--file` option of `credential-store` is an
+   example that it needs shell's help to tilde-expand its value.
+
  * When you give a revision parameter to a command, make sure the parameter is
    not ambiguous with a name of a file in the work tree.  E.g. do not write
    `git log -1 HEAD` but write `git log -1 HEAD --`; the former will not work
    if you happen to have a file called `HEAD` in the work tree.
 
diff --git c/Documentation/gitcredentials.txt w/Documentation/gitcredentials.txt
index 71dd19731a..f6ce923f25 100644
--- c/Documentation/gitcredentials.txt
+++ w/Documentation/gitcredentials.txt
@@ -240,10 +240,15 @@ Here are some example specifications:
 # the arguments are parsed by the shell, so use shell
 # quoting if necessary
 [credential]
 	helper = "foo --bar='whitespace arg'"
 
+# store helper (discouraged) with custom location for the db file;
+# tilde expansion often requires the filename as a separate argument.
+[credential]
+	helper = "store --file ~/.git-secret.txt"
+
 # you can also use an absolute path, which will not use the git wrapper
 [credential]
 	helper = "/path/to/my/helper --with-arguments"
 
 # or you can specify your own shell snippet
