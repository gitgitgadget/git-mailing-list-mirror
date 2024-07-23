Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086914B06A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756647; cv=none; b=SC+e2wnlPFv0STJx/kOBZ32WzMc+YdS8I6jG6xeDgiTZTkan3MAqbW9tRqV9HEFFGbL/CXIEhiBe0j57YICJrKVurIfCXOBuCFe0A0/aVQteloZCvemSbdxixPtAGBpijgltQaEnnB3+tOZW7fVdiOxKnaOSm/qE7LmHT5dV20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756647; c=relaxed/simple;
	bh=4pjKr4uFHsS/AAOX/3VSQXRENp4mxnbCRZM5ef5irHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EzVgQLIPcIS6icL8KECmOkwGyoDc6QbBKJu6RC6gULq2ArF1i8W/0LYJWFnFKsv8/aRFId1GYG4fUkUtX38aKHjF7hdGio/QydeZ09id5z8uytkG8iOedbpSPwKGMjrmBHC23Ijh5D2AYWbv/XTIeJaNH2t3758jqUf6vAzVA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5mG2u8/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5mG2u8/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2F182DB3B;
	Tue, 23 Jul 2024 13:44:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4pjKr4uFHsS/AAOX/3VSQXRENp4mxnbCRZM5ef
	5irHo=; b=E5mG2u8/2J91BERyE3oyObzYXE81wM7CEJLeTyT9F1E69O/n4FcZDv
	zPcs8mUhLk0WDNNzKY3FjivzYKvqs0SrKl6Pgd2P0rDvSRCW9XpVB3kayrmqO+aq
	TklG7kxHX/e8XGzVg/1NBhow2RP045mg6tWnxfvgFfBOtJGrV49dY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E384A2DB3A;
	Tue, 23 Jul 2024 13:44:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF5762DB39;
	Tue, 23 Jul 2024 13:44:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
In-Reply-To: <xmqqv80w2ji8.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	23 Jul 2024 08:52:31 -0700")
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
	<xmqq8qxvhcy5.fsf@gitster.g> <8404759.T7Z3S40VBb@cayenne>
	<xmqqplr5e5yk.fsf@gitster.g>
	<89d00235-71db-4087-8ffb-7e93c3f470a0@free.fr>
	<xmqqv80w2ji8.fsf@gitster.g>
Date: Tue, 23 Jul 2024 10:44:02 -0700
Message-ID: <xmqqv80w0zrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26E84722-491B-11EF-BCC3-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> In the meantime, I am tempted to
>
>  (1) apply Dscho's CSS change (but with fixes to avoid "make
>      distclean" issue) and leaving git-clone as-is.  or
> ...
> I'd probably do (1).  Even though chances of unintended regression
> might be smaller with (2), which would only affect clone and init
> manual pages (as opposed to anything that uses <code> inside <pre>),
> it's less work (and more work to validate the result visually, which
> may be a pain).

So, I decided to keep Dscho's latest CSS-workaround change intact,
and queued a stupid and obvious workaround clearly marked as a
tentative measure on top of it.  I am planning to merge these two
patches down for the release candidates.

Without your incremental update to git-clone.txt, git-clone.html
rendered through asciidoctor will say wrong things, so we'd need
to apply it anyway.  So I cannot put your patch _on_ _hold_ for
the purpose of the upcoming release, if we wanted to ship a set of
source that produces correct version of git-clone.html.

So in the end, we'd need both ;-).

Thanks, both.

----- >8 ---------- >8 ---------- >8 ---------- >8 -----
Subject: [PATCH] Doc: fix Asciidoctor css workaround

The previous step introduced docinfo.html to be used to tweak the
CSS used by the asciidoctor, that by default renders <code> inside
<pre> as a block element, breaking the SYNOPSIS section of a few
pages that adopted a new convention we use since Git 2.45.

But in this project, HTML files are all generated.  We do not force
any human to write HTML by hand, which is an unusual and cruel
punishment.  "*.html" is in the .gitignore file, and "make clean"
removes them.  Having a tracked .html file makes "make clean" make
the tree dirty by removing the tracked docinfo.html file.

Let's do an obvious, minimum and stupid workaround to generate that
file at runtime instead.  The mark-up is being rethought in a major
way for the next development cycle, so what the CSS workaround we
added in the previous step may have to adjusted, possibly in a large
way, anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.46.0-rc1-52-gda884b23f2


