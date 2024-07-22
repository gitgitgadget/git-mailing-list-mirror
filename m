Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA0219E2
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681138; cv=none; b=kT7Hz0Po2GojdOuBaSvrzXqFFPm8njBge+OizGamDpfOpJoeN0RV1A7In6tfdzsLP9tCJnI7Vqn94Rr8zNaLbbgZNimJXuUfeFfVn1kHfcq5T4DyVHuL1OoHZvhgBBGEXId2rAGvK76oeqazlVC5gTEF8KaioDPe0IMtnOQMxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681138; c=relaxed/simple;
	bh=2NilyjoiIgbTg7gnhUQ54MqD4Aaq2odhB7N3k+YzO3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eV7thUZ3Otzz2BvABvbWKoqL4nd9bmBjqNpquJji8wsPMxsng+cq3CpptztTOIK+cdW2UcjgDBY84u4Qasf40R4ylUV32jIKqajp7FLVtoDTDxVL8xHVZ46PeTM//Kkfwzw1cl9VKVO7iE1cfTxjcE51w4zhd6YYuYQhstwHBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gEePHGxG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gEePHGxG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A84C02246B;
	Mon, 22 Jul 2024 16:45:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2NilyjoiIgbTg7gnhUQ54MqD4Aaq2odhB7N3k+
	YzO3Y=; b=gEePHGxGqqcIU/ck46c7rqZspN6GrPWqw/WzaR0k1KxuIj2ctEcsmx
	8FjykNYxxjv0dFmFrxiRDBR6QPptnWpk/prybeYQ/BPV+X24KYHIbZ0BDnJKi88R
	+23XUkl8RdsaxW0GbhbFdjA4IQSj2AGhFDT1YXvsEqDZ3E/7kX9Uc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D6AE22469;
	Mon, 22 Jul 2024 16:45:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06F9922468;
	Mon, 22 Jul 2024 16:45:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] asciidoctor: fix `synopsis` rendering
In-Reply-To: <pull.1749.v2.git.git.1721679949618.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Mon, 22 Jul 2024
	20:25:49 +0000")
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
	<pull.1749.v2.git.git.1721679949618.gitgitgadget@gmail.com>
Date: Mon, 22 Jul 2024 13:45:33 -0700
Message-ID: <xmqqplr59mvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5836DEFC-486B-11EF-BC81-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since 76880f0510c (doc: git-clone: apply new documentation formatting
> guidelines, 2024-03-29), the synopsis of `git clone`'s manual page is
> rendered differently than before; Its parent commit did the same for
> `git init`.
> ...
>  Documentation/.gitignore   | 1 +
>  Documentation/Makefile     | 1 +
>  Documentation/docinfo.html | 5 +++++
>  3 files changed, 7 insertions(+)
>  create mode 100644 Documentation/docinfo.html

I think our mails crossed.  You need something like this squashed
in, or "make distclean" would make the tree dirty as Ramsay
reported.

 Documentation/Makefile                          | 5 +++++
 Documentation/{docinfo.html => docinfo-html.in} | 0
 2 files changed, 5 insertions(+)
 rename Documentation/{docinfo.html => docinfo-html.in} (100%)

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
2.46.0-rc1-48-g0900f1888e



