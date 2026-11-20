Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176157;
	b=X0jf8tBphJj75LbIP+U8R5SAL9V2xY9P7jp7Fxpme5g94wLUUDrjIA5tq/v/ZkBTKFRv
	 8bfeVzf098aGFxBGq0xIqoWBhdOEB3mCVuHje1uN4VUBjUif1MA8PeOB0egf1xRb+T7c0
	 s+CpBOv4wZ/LPf0OGxzCZw5V6y+/x9WCMjSQrl35uVLM+gaSQpdAR0cmx9Ht0GImKAmyH
	 RUBj7ofV9ZGLDovTsMDmp1mz/TJ6MMv/PewEo9KjSo+ikni75m2I6SvBQPa31TPVdv9ev
	 u4CQRiPtthCjyoYSy2K1Ra6jYK7nnVGvn6fe74aZY3YpBfpoEUExrtDa9N925Ru2Q6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176157;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=kYVb9M2QW0OFwK9XrIzmCHECbOlm3gGlmAAcdOlFfFo=;
	b=d7bT4GnSEry3DoPvQgy+BRL9B+c++cwsotRYNZ2kjkHVTfIAZw7BEODJ1OGZPvkOdm+8
	 kPmvJE6NYk84Y+hbo4XT0GON5RIHWL9ECpoYE+XQKkbkSWmwVSDs38B9SBP9hxiaDsZYR
	 ekQrCfi5unsauFh8IAD5eQX8iWSQH5p6E4cCxxkAeWYtX0vLPBGVtC7+72bdH8fI/XsU8
	 JwY+IaksZuRb5zSP12aio4lIDl44pB7IgIieVV2MoAPgXae2Q4va0X47pZRhqkINWbm5T
	 DD5Fpr34bcpX86ul93MeLrt0FURoVAaiRIyG+BMjFLdq7+lawTub/nIt28xBGXjFMrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=bjMplQwK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zQTW7Hvl;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C138606A326
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C138606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=bjMplQwK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zQTW7Hvl
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D091EC08EA
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 07:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795176156;
	 x=1795262556; bh=kYVb9M2QW0OFwK9XrIzmCHECbOlm3gGlmAAcdOlFfFo=; b=
	bjMplQwK6hxGaguhdmK6tOjcC+bfsQvC8o/UOioICnn7VVYj1GGSDaxwxhAnSXNg
	qY4K32T3AGZ7LWZDoTQzORmD5sE/zQk7Sgic0GCsM75TP6wWhU0xlWpWS06bLQKr
	amk4ko95m9AGeuYtaCwMil3QiaQE5f1EmFvUcKw2gMk0E3dv/xF+vLXTyPvC0uRz
	STwHV9ETNGgbPfHriaHE5veFDdxGJ7pu8MuoSlOi5Oh+l51CgmXealRvMLKuowRC
	YpFB1aDhBA9m0n9zxXXSmpF4NMgm74Ew8Q4ztt28+3Y+RhtPbMLNYMPeQ6gqSG7T
	Tupjsazc2EshTePl076M+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795176156; x=
	1795262556; bh=kYVb9M2QW0OFwK9XrIzmCHECbOlm3gGlmAAcdOlFfFo=; b=z
	QTW7HvlJ+WgH58BccmMMmzRaZISLFN93XWx0QnOGyLHDXGVVM/sPEh5JdsMzm3a2
	wx9eIj8Wd4/M5zCmxOVohWc3bTgFIbfwWpjZi8hacxJsYT6Kp5T/386bUW5taIQR
	FaY8RlSeS8SpIYH/5TGvkdAuiQL8Jhx5L6ONqveiZzPH1nkjvLa9rXDbWwI4RMaM
	xqR2pusKGOMUsyUfIjsQxPZxssOYXhAOuryUGSl34A0ubNQvXbRKTigRN1EBrniV
	s8cxPSMgFcULnXEV347ZKmdtl5IOmNy8gBpPBPV+I6IeKSpSpgvjzKgxmC9zbqx3
	ku85rSIjvpvTDwTlXbHRw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176156; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:etCohGaMBLi6op2inazjTyhk6IDq+AiBdbc8r2ByjRhkJ9s
	VYlPNKgMGigOvUHx+eKyFYSSoJyirEZON5GprWPTcHoUGA4QJCmH9KQJfJ9OxSCS
	TBMksz0KEZtTbLw3qRWCF/5Ys6TeY8NnfGXKweO2rC1jwgpekdyRpZB7jN3Xy71v
	y1y7ke1PwkWQfhZ1WmPVlkOb9nub6tIj4c1bzA84KsETYX8+EXA48pO6aLY/q3ZT
	Kmy5t8ajGyowSTlUn0UyZ+ANN/Smw03E8dNJOKY+0vZB6reyuFoILGkNf51H5Od/
	p5UBTEC8m4Ggde8jykL8o3AyjxE4MbLL9BpGWzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:g3bNZbRcx3zQoXpQOBZrdEPoBI4arPrHstidhUVxXno=:A+QuNXJ27xpXYjYdWi8KiIU3IWwR60aywJlCvBqWwmM=;
X-ME-Sender: <xms:3DYAa0Bmm1WBIG7nyKIrVPwpBsmZw8eaotCD39PF-fHbr7JblCTa9Q>
    <xme:3DYAa9cdqHpAok-JPOB3bkvc3bKcHMlxzIwxempbbFYCdEtagkqiiotQYYyJ1Z4DM
    euJlRFPjYr8-0tT4BwYRsMQyil_cnyXY3y6TsAKn8ahdPVbTXbCVhDl>
X-ME-Received: <xmr:3DYAa9NJurRHTzkc6LcosKngx_FB-Di15SzB7tqa7Y1Ff852iTPAc6sQ0kKovC3xX4EjUHY>
X-ME-Proxy-Cause: dmFkZTFKfMoyZ8OsQp9Wthl1HVhqbad1g1+0FOaTNrvwg/0Vd8GZUZgulm8uuAavm4txZm
    rO3CHbCoKwYYBbsY9QWAQ06x8eZrSeU0ua3vKZjzTEfsCFacma4xkKSA05wxdhhlOVlLsS
    ceKeJl0kUvaNeEYJ9RYdq8nkFwGnncNUCAN/DQ+m70/sQDBWWaiEw065fia2LIgNHUXYJQ
    9SR479uoFdaE+Y1cVkI7Ky/y56H5gBMNB5MYoU8ogwGsgTjsIoy/Q52Y+bAfZOXcP9bJwi
    aS3rRjTuRGQQz0YREwLmG9Ffr8hpmsvEZBGl8DenEqVkHuPRsEzB9OWIPoObsNzcc3ycAF
    C6MJ+9rD5FkX6j7+SzOSH7LF1L8cmyFjLOJUbp4kEWz5fpzSJ4y/kUrq8v7VVqgt9hoYKk
    S4/ZN80FR2Oy4x+VBxcTwpYX686Bdkl5HbBvLjG1/zGy5x2WUmnPW7yosplkxVF7Y/0pYc
    GzjkicENHtaapBzrLIKj99eO1bjf9Rw/Q3pPX8ru2GfuiQgT2X1NPcpnMrAERZU+xhzQIY
    VBn2FddSUa6nIeFmzZaM25RNznji7u/BOpuRD2T2tcAttYwjJHXzGDnUzHc074dOpprFHE
    c8nOUtUNwNt0Ft3OUVmsJuezrS/SfOHJWb7v1l/x/YLtE7JDG103fKHHu51w
X-ME-Proxy: <xmx:3DYAa_6BnsJ-ZBBvATaKt7alOYU-4-hmivSAs5ufuBBW0X-12zG3Fw>
    <xmx:3DYAa5KClAHHmPwnjsBoG2mCU5Ll-PA2yoeoFWOwetrpuDZrVnfo8Q>
    <xmx:3DYAaxexzdX-qajfjBax4HeSk1HovetHe0THkar6P_CtnrYrUDluOQ>
    <xmx:3DYAa0ca4hcIC3NO9VoIFen4vL_S-Vm8UlaZgewX2nTol1Lq6Sg9UQ>
    <xmx:3DYAa_BMTzBTWWrM2hAPt6hFdOy8bNuqva2SdKlkKNmQhodp8bIREM7J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be8e8e84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Nov 2026 12:02:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:02:28 +0100
Subject: [PATCH 1/6] builtin/fast-import: stop reporting packfile
 statistics
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
Message-Id: <20261120-pks-packfile-global-statistics-v1-1-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

By default, git-fast-import(1) prints a bunch of statistics about all
kinds of internal details of Git. This includes for example how many
objects have been allocated, the number of refs processed, or the amount
of memory that was allocated.

Reporting this kind information is highly questionable, doubly so as it
is done by default, as a user really shoudln't have to worry about such
internal implementation details. For some of the above metrics it could
be argued though that it's indeed interesting to learn about the number
of objects processed to get a rough sense of what git-fast-import(1) has
done. But for other kind of information that's not the case, as it is
without a doubt purely internal implementation details.

One of these reported implementation details is our packfile statistics.
These include information on the system's page size, the number of packs
that were opened, the number of calls to mmap(3) and how many pack
windows were created. Reporting that kind of information, and that even
by default, is just completely uncalled for. This information may be
useful to a developer, but a user really shouldn't have to care about
any of this.

More importantly though, with pluggable object databases we shouldn't
assume that we're using packfiles in the first place anymore. The
current implementation of git-fast-import(1) still does, but we will
convert it to use transactions sooner rather than later.

Let's just unceremoniously drop reporting packfile information to the
user. If anyone complains (which I highly doubt), then we may consider
reintroducing this as trace2 data. The same is arguably true for many of
the other reported statistics. But for now I care about the packfile
subsystem, only, and hence those are left as-is.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-fast-import.adoc |  5 ++---
 builtin/fast-import.c              |  4 +---
 packfile.c                         | 36 ------------------------------------
 packfile.h                         |  2 --
 4 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 5201e493345..6afe14b650c 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -48,9 +48,8 @@ OPTIONS
 
 --stats::
 	Display some basic statistics about the objects fast-import has
-	created, the packfiles they were stored into, and the
-	memory used by fast-import during this run.  Showing this output
-	is currently the default, but can be disabled with --quiet.
+	created, and the memory used by fast-import during this run.  Showing
+	this output is currently the default, but can be disabled with --quiet.
 
 --allow-unsafe-features::
 	Many command-line options can be provided as part of the
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ab5d2a23448..14e75149415 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -4153,7 +4153,7 @@ static int option_parse_early_allow_unsafe(const struct option *option,
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo)
+		    struct repository *repo UNUSED)
 {
 	struct fast_import_state state;
 
@@ -4346,8 +4346,6 @@ int cmd_fast_import(int argc,
 		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((tree_entry_allocd + fi_mem_pool.pool_alloc) /1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-		pack_report(repo);
-		fprintf(stderr, "---------------------------------------------------------------------\n");
 		fprintf(stderr, "\n");
 	}
 
diff --git a/packfile.c b/packfile.c
index b32b4cd75da..5aa9b009174 100644
--- a/packfile.c
+++ b/packfile.c
@@ -36,38 +36,10 @@ char *odb_pack_name(struct repository *r, struct strbuf *buf,
 }
 
 static unsigned int pack_used_ctr;
-static unsigned int pack_mmap_calls;
-static unsigned int peak_pack_open_windows;
-static unsigned int pack_open_windows;
 static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
-static size_t peak_pack_mapped;
 static size_t pack_mapped;
 
-#define SZ_FMT PRIuMAX
-static inline uintmax_t sz_fmt(size_t s) { return s; }
-
-void pack_report(struct repository *repo)
-{
-	fprintf(stderr,
-		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
-		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
-		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
-		sz_fmt(getpagesize()),
-		sz_fmt(repo->settings.packed_git_window_size),
-		sz_fmt(repo->settings.packed_git_limit));
-	fprintf(stderr,
-		"pack_report: pack_used_ctr            = %10u\n"
-		"pack_report: pack_mmap_calls          = %10u\n"
-		"pack_report: pack_open_windows        = %10u / %10u\n"
-		"pack_report: pack_mapped              = "
-			"%10" SZ_FMT " / %10" SZ_FMT "\n",
-		pack_used_ctr,
-		pack_mmap_calls,
-		pack_open_windows, peak_pack_open_windows,
-		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
-}
-
 /*
  * Open and mmap the index file at path, perform a couple of
  * consistency checks, then record its information to p.  Return 0 on
@@ -291,7 +263,6 @@ static int unuse_one_window(struct object_database *odb)
 		else
 			lru_p->windows = lru_w->next;
 		free(lru_w);
-		pack_open_windows--;
 		return 1;
 	}
 	return 0;
@@ -307,7 +278,6 @@ void close_pack_windows(struct packed_git *p)
 			    p->pack_name);
 		munmap(w->base, w->len);
 		pack_mapped -= w->len;
-		pack_open_windows--;
 		p->windows = w->next;
 		free(w);
 	}
@@ -665,12 +635,6 @@ unsigned char *use_pack(struct packed_git *p,
 			if (!win->offset && win->len == p->pack_size
 				&& !p->do_not_close)
 				close_pack_fd(p);
-			pack_mmap_calls++;
-			pack_open_windows++;
-			if (pack_mapped > peak_pack_mapped)
-				peak_pack_mapped = pack_mapped;
-			if (pack_open_windows > peak_pack_open_windows)
-				peak_pack_open_windows = pack_open_windows;
 			win->next = p->windows;
 			p->windows = win;
 		}
diff --git a/packfile.h b/packfile.h
index ed3378c4576..bab9931d00e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -217,8 +217,6 @@ int for_each_object_in_pack(struct packed_git *p,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-void pack_report(struct repository *repo);
-
 /*
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.

-- 
2.56.1.831.g720f3f5937.dirty

