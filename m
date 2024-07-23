Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805742AB3
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721704424; cv=none; b=AT0nhCL2ZCF6LVqiLzocGxVjSezo+SuXtxo2dlM9xj/Xa03O+DMEf4qmA9xhf9Y70k0qupXmE+5nvQ0WzQq5TplKgZGVHRxfYfnISHFtkzuCS+nirIrb+ywZ2r+LRxYUW/ZjCab+Xujui2gCCEMw7F7L1aWE9M8kp19uVxr3xAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721704424; c=relaxed/simple;
	bh=z5KtqvwlmFkPAyzbypDHyWeyOwitpwUFsKce/kFPHBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s3q2sBYfNqpaUOz7JTMv8fT2C4wIx+NK1ZAvEdfc3FeZ/AUZ36x7mMFsclVKzWXa6BKOatbqd+NQvadrm30ihZRX/jnW6mrT0w+fDiBEB/HSG7SK+n3Lso2zhAQ/m6mW/9ah2wF9bB1QFQNb6yYVigLBjl2vOdlT98dmHZZN1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wNjvOu6b; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wNjvOu6b"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E763628F8D;
	Mon, 22 Jul 2024 23:13:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z5KtqvwlmFkPAyzbypDHyWeyOwitpwUFsKce/k
	FPHBA=; b=wNjvOu6bRzKceZWf7PVCaK0Y+xwDlfMEhPY/PJQSQHE2qnDi7Qn7ID
	tmInMQgCbi0aPzUmnqcV12172uWwRNY5bLqdX6Yw1XM6KowZ76K3aMlV3UZsiAqg
	McGIXUlkmBFs+uYN6aWp6Yk4V2FY9jWGMdF9Z38kJBRPEcDPR58CY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DFBE428F8C;
	Mon, 22 Jul 2024 23:13:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40E7F28F89;
	Mon, 22 Jul 2024 23:13:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] asciidoctor: fix `synopsis` rendering
In-Reply-To: <xmqqplr59mvm.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Jul 2024 13:45:33 -0700")
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
	<pull.1749.v2.git.git.1721679949618.gitgitgadget@gmail.com>
	<xmqqplr59mvm.fsf@gitster.g>
Date: Mon, 22 Jul 2024 20:13:32 -0700
Message-ID: <xmqqle1s4x7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8C5040C6-48A1-11EF-B06F-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I think our mails crossed.  You need something like this squashed
> in, or "make distclean" would make the tree dirty as Ramsay
> reported.
> ...

And I needed to undo the .gitignore change between v1 and v2 to
match (otherwise ci/lib.sh notices that docinfo.html is an
"unignored build artifact" and complains).

An updated SQUASH??? fixup looks like this.

Thanks.

 Documentation/.gitignore                        | 1 -
 Documentation/Makefile                          | 5 +++++
 Documentation/{docinfo.html => docinfo-html.in} | 0
 3 files changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/{docinfo.html => docinfo-html.in} (100%)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index d11567fbbe..a48448de32 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,6 +1,5 @@
 *.xml
 *.html
-!/docinfo.html
 *.[1-8]
 *.made
 *.texi
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 78e407e4bd..371d56eb5e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -209,6 +209,8 @@ XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
 endif
 
+ASCIIDOC_DEPS += docinfo.html
+
 SHELL_PATH ?= $(SHELL)
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -337,6 +339,9 @@ clean:
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) GIT-ASCIIDOCFLAGS
 
+docinfo.html: docinfo-html.in
+	$(QUIET_GEN)$(RM) $@ && cat $< >$@
+
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
 
diff --git a/Documentation/docinfo.html b/Documentation/docinfo-html.in
similarity index 100%
rename from Documentation/docinfo.html
rename to Documentation/docinfo-html.in
-- 
2.46.0-rc1-52-g816ffef0a1

