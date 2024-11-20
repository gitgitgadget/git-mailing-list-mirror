Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA41BC07D
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110006; cv=none; b=k93gMx3khfVxv2xCx075aSERLp7X1hi7DRt9F8ZE0+prlSy/Es/jZovCtK2cp/qYk8L5gpT+aRMkqh5ylPAXV25oruxfx6t6okV77YWwKTojo37Klqr/31QtN5InHudDgZANCStKTTPA/7tCn5n4UTm1gVu0WBxCMyAp2LgbOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110006; c=relaxed/simple;
	bh=Z9UaxbFdhh9MaOArSYjajcLc6K5mEUZgDqK/IgVnMJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfy7YTJ5NVd4l8wegdbwLaIbwDJ9COqBouaaQz/tbYhGtnQjBnE39STbPVYjS+FJvxlLGbfTNl2D3lgsmlMmqkz/yEqydlro30ybMmv9Lo22x6E0IojS29l/0+2xomju46FnMxXYec54klGMCax47M2AX9IFiiqibwfysml95uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=opLnIOlb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+Udp9/X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="opLnIOlb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+Udp9/X"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88C3011401DB;
	Wed, 20 Nov 2024 08:40:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 08:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110004;
	 x=1732196404; bh=2o6XbmKgA41qmWw9hoKfTL6L/ggwqZPOCCW9ExXieuc=; b=
	opLnIOlbjcf/YmQruUUIMLTom2XT9UIfk+0PltPJ55GVXCD88pnoLbnTX0PPw4RT
	mtdXfJwe6u7yZlJHyqLDPufAotqprEeb6PlmOWwpViI2HkLFDZ38rZdrHHVWkfAd
	/C/vUow2ZDQjI2EL20Tlo2OqtadMzt8qiUtSl6mRE1atLB+8OvR9YA45NWBCC+xA
	BhMnBAf2swnBtYCYLG+rgZU3B6h6lQPeFBSuqdaH7qNcQf1VQ5Mnzha178RB0Rfs
	9dVVqWja82Q7bdvx1PS5TlmPGrCG3N0prkwNiIOTACq0bt7HDIkLduAYJw2XCaTW
	lR36YP6QOonSALqa8wQOIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110004; x=
	1732196404; bh=2o6XbmKgA41qmWw9hoKfTL6L/ggwqZPOCCW9ExXieuc=; b=B
	+Udp9/XY+XCrshC+pimoPMr2EZOYkIuGMkHzaXWlCyB4aH383wYzVfpwxujgWPof
	MupKQeU2vk4jFji1YCU8ktUkJvNs+GEnT4bbse6VQxNlLUUbxMbZONOsagvo4muz
	KHOHh4k/QR7b9wYFSZbTlRNuR0gnPOwQlBOibMFeisSDGU1GUuYA7iTU7biva6rr
	p1b/IO4Pc9Tc7uY1M8WvvrFuGAxge/XHnGck07DrK4wg8jdsYaaKvW5cZ4Gb8EPg
	hCuFmpeZ4yv+BaFV9orn0Uebe56cyjxwgpqiSeaAimcQ9xcT2EEYRNv1VpItOczw
	lV1sHYWnHuSwfeS12N2qA==
X-ME-Sender: <xms:tOY9Z8wxFJkbO98ymTs-nevRmyfQNNP2mjW2OfgeRPHAOc7_aFJkKg>
    <xme:tOY9ZwSYXGoeJXVva25ZAkVd7cvJbrgue-rojR03ADRUte9nE39GsjoGClst8iIO8
    -ez8xEnAaTdELigLw>
X-ME-Received: <xmr:tOY9Z-WpEA2Aaeocv2Qu3Y3HQ1CdZ1Obr1X-hf5XxvXgbdpbDYq--m6ft_O6dxAmNpSKRkxcRqkPyMrcyTQWYJJnojvhHKE0tHpiXgLzWEDdEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:tOY9Z6iAuwL9vrUzd980hpVOF1jcpUDRoebxHZdwoF4hLSihTpYmrQ>
    <xmx:tOY9Z-B7kCZ_RxFmX9xJnG0YP3Mq1HjbeTgO4-yQhBHCqa55Nuxu3w>
    <xmx:tOY9Z7KaNi58ht6DRp_vAvNsOZNUjR9wdxsd0_lZyVb5ftbtbh2GAw>
    <xmx:tOY9Z1Bb8SY7sb0FUUmfLXG7JF6oi5ffak9aKYO4ROmwxhrFc8mrSA>
    <xmx:tOY9Zx8EVSSIPEfd3i97mM_v1D7nXXDnrDxmuFIXJ-5uvZN8CWlOrW5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 449af25c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:45 +0100
Subject: [PATCH v3 16/27] help: fix leaking return value from
 `help_unknown_cmd()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-16-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

While `help_unknown_cmd()` would usually die on an unknown command, it
instead returns an autocorrected command when "help.autocorrect" is set.
But while the function is declared to return a string constant, it
actually returns an allocated string in that case. Callers thus aren't
aware that they have to free the string, leading to a memory leak.

Fix the function return type to be non-constant and free the returned
value at its only callsite.

Note that we cannot simply take ownership of `main_cmds.names[0]->name`
and then eventually free it. This is because the `struct cmdname` is
using a flex array to allocate the name, so the name pointer points into
the middle of the structure and thus cannot be freed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c  | 4 +++-
 help.c | 7 +++----
 help.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 159dd45b08204c4a89d1dc4ab6990978e2454eb6..46b3c740c5d665388917c6eee3052cc3ef8368f2 100644
--- a/git.c
+++ b/git.c
@@ -961,7 +961,9 @@ int cmd_main(int argc, const char **argv)
 			exit(1);
 		}
 		if (!done_help) {
-			strvec_replace(&args, 0, help_unknown_cmd(cmd));
+			char *assumed = help_unknown_cmd(cmd);
+			strvec_replace(&args, 0, assumed);
+			free(assumed);
 			cmd = args.v[0];
 			done_help = 1;
 		} else {
diff --git a/help.c b/help.c
index 8b56cd6e25ba5f2be2cbf2a7a9ed48136e12a0c7..8a830ba35c6fd1377213e2ed40846f3d46dba363 100644
--- a/help.c
+++ b/help.c
@@ -612,7 +612,7 @@ static const char bad_interpreter_advice[] =
 	N_("'%s' appears to be a git command, but we were not\n"
 	"able to execute it. Maybe git-%s is broken?");
 
-const char *help_unknown_cmd(const char *cmd)
+char *help_unknown_cmd(const char *cmd)
 {
 	struct help_unknown_cmd_config cfg = { 0 };
 	int i, n, best_similarity = 0;
@@ -695,9 +695,8 @@ const char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
-		const char *assumed = main_cmds.names[0]->name;
-		main_cmds.names[0] = NULL;
-		cmdnames_release(&main_cmds);
+		char *assumed = xstrdup(main_cmds.names[0]->name);
+
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
diff --git a/help.h b/help.h
index e716ee27ea174c4dfc3b941619bf361972894212..67207b3073ce48fa25f67f9a4922abc4e2ce7926 100644
--- a/help.h
+++ b/help.h
@@ -32,7 +32,7 @@ void list_all_other_cmds(struct string_list *list);
 void list_cmds_by_category(struct string_list *list,
 			   const char *category);
 void list_cmds_by_config(struct string_list *list);
-const char *help_unknown_cmd(const char *cmd);
+char *help_unknown_cmd(const char *cmd);
 void load_command_list(const char *prefix,
 		       struct cmdnames *main_cmds,
 		       struct cmdnames *other_cmds);

-- 
2.47.0.274.g962d0b743d.dirty

