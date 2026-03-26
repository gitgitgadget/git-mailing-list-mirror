Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED70347BD4
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555623; cv=none; b=LpzOBR5n5UhOtCbl+alFtfrtVoRwH2i1K0Lmy/jnPpH1aBZX906GEs86N1cRj+HUI2wq67nqFSVPHZiCsBEGhaFtYspSCgqMT0iwcfbgxevKTgOG7SCLPrlH40d0+zk72OkPaEEkbNDEu7WHcLyIIEmEF7bvDpXx7ugTvA8Fszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555623; c=relaxed/simple;
	bh=wgVnHr4mCmh6jcQ3QnaIOeEyvHmEekmeu8M1hcmZtKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmY4QyXqUliiLs0ktsvgPrOps1B2/kgVnde8lVgwNCmgFnEiMOHqfDhsGbeeJmdQJpl8mD57nS4XL/8V1XeGVpHqKgGPlUOmYqWRr1n6Bt6/H49g6JCTgxbHiNtv5urL9xjum2BHyMBa5SJPspIBI2g9rMx+V8ENq/Yd1mZY8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=M8r3pDsX; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="M8r3pDsX"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774555613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z37IT0eHR/NdODkNST+A/Ps1EG9B3TgT7AG+wkisdKs=;
	b=M8r3pDsXcdI02gZCNptD6uWJRIFgCuGRtpI/me1Tl/dGhW0Ar3K401ZpnXd2knsLTyNAuK
	Trg2N+JyLNJfRsMIa+dmiy2qxO9p0687Tm3kgHX/HW3GTuD9YMwOWdXGEbcdDL5+XsNRFt
	wbE6F0UuD19f36hqdd4fd9jJegv7CMBWCYFX8SMHMi1qb6WgmExuyaPot5+3db2cWVkejH
	Y9EA29PRbFqf/IiumodHguxRmVGbT1OgQqmdUO39AdzG05Aih2nYYzYymENOcScWmeZU+/
	hcTMoggHrm4Cl9c591H5tB9rrFH0OR2d2nWhxzv0fNQV3m4Ye8iUuNdK1nIpgg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] docs: fix --commit-list-format related entries
Date: Thu, 26 Mar 2026 21:06:40 +0100
Message-ID: <20260326200643.20251-1-mroik@delayed.space>
In-Reply-To: <20260326185541.17523-1-mroik@delayed.space>
References: <20260326185541.17523-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3468; i=mroik@delayed.space; h=from:subject; bh=wgVnHr4mCmh6jcQ3QnaIOeEyvHmEekmeu8M1hcmZtKg=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpxZHHVLCa7YqQjTV9mpLhKfV+yZBK25tv+oT7O arPUC2Ek6eJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacWRxwAKCRBIeX6hnBm+ 0Q5PEACWi2OaLrjiB86MFNjbBpnjQAZQl1SkUQjGpPznvmp3FgXs7usiyZzPNSBxuwZ85Nx8aj3 tFtJT7Tq5hvnsB6kN81gaDHiVBHUKrE8UKAglVOunXH2QMwjFT8ht6D1qMvUAqhgiWJGWCp76FB /n7YhplTOUsgAK6sfT6qdYv1HwTSMVIzmiV3MvQpxmR6Co9F2NFSHXrZHBHTLsRdo1kPY2mAPZK Oy1np2v4bpLJ2s45PJQmQiwxfsgWP/YHkSrsapLM/E1A90In/QwQDQINz8COwpr1oz7yfJoryvD 50dqOjurdh5izzKPyn6ANUSbMpcqdEaN/8eOmfN/5/g1PfaJGkx92U/i/hjnGLdiXJl7ZBxLnmg NJ5wlZEncnXoy1GJqtKYrSThIS1roGnHstitNJ1pmuwUmmYM5nnhc0gtLtH7fCSVXCFbF/So4PG 0DxS8M9loZjdBOrGR4iS2YzX21GUD1mT8Biggrl77peHJfR0jJ6TCObbl8lpYD9SyYk4Y4T4aTL 4MNmDJHSMinPA0cd6JSPBrd/4hBYub7IlhPE1eUfeJXwHRsZr4I9CwAUHT1KwHNa2IDX5VJ7VtC b7uK8Hh7xbjWQDVf6/49j/WlOOqLpLsXkNJ7LL8KRNl4S0P3/VjmMJ3oiY2N4x9wRxn26cDDywr 0wwG9CayGtsF9IA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Documentation specifies that "git format-patch" would default to
format.commitListFormat if --commit-list-format is not given, but
doesn't specify the default if the format.commitListFormat is not set.
The text for --cover-letter is also obsolete as the commit list can now
be something other than a shortlog.

Document to reflect changes.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
Ended up with something more verbose compared to what Junio proposed,
but it might help the user to better understand why we check for the '%'
in the first place.

Same goes for the implied `--cover-letter`. Instead of rephrasing I
added a note for the user to clear up any ambiguity.

 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ef1ed1d250..dbd186290b 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -103,7 +103,7 @@ format.coverLetter::
 
 format.commitListFormat::
 	When the `--cover-letter-format` option is not given, `format-patch`
-	uses the value of this variable to decide how to format the title of
+	uses the value of this variable to decide how to format the entry of
 	each commit. Defaults to `shortlog`.
 
 format.outputDirectory::
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index c52dbcc170..fc0023b9b7 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -319,21 +319,24 @@ feeding the result to `git send-email`.
 
 --cover-letter::
 --no-cover-letter::
-	In addition to the patches, generate a cover letter file
-	containing the branch description, shortlog and the overall diffstat.  You can
-	fill in a description in the file before sending it out.
+	In addition to the patches, generate a cover letter file containing the
+	branch description, commit list and the overall diffstat.  You can fill
+	in a description in the file before sending it out.
 
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
-	series. The accepted values for format-spec are `shortlog`, `modern` or a
-	format-string prefixed with `log:`.
-	e.g. `log: %s (%an)`
-	The user is allowed to drop the prefix if the format-string contains a
-	`%<placeholder>`.
-	If not given, defaults to the `format.commitListFormat` configuration
-	variable.
-	This option implies the use of `--cover-letter` unless
-	`--no-cover-letter` is given.
+	series. The accepted values for format-spec are `shortlog`, `modern` or
+	a format-string prefixed with `log:`. E.g. `log: %s (%an)`.
+	Modern is the same as `log:[%(count)/%(total)] %s`.
+	The user is allowed to drop the `log:` prefix if the format-string
+	contains a '%' character. The '%' is expected as part of a placeholder
+	but this is not validated by git.
+	If not given, defaults to `shortlog` unless the
+	`format.commitListFormat` configuration variable is set.
+	This option given from the command-line implies the use of
+	`--cover-letter` unless `--no-cover-letter` is given. Note that
+	`format.commitListFormat` being set does not imply the use of
+	`--cover-letter`.
 
 --encode-email-headers::
 --no-encode-email-headers::
-- 
2.53.0.1181.g1066ffbbbe

