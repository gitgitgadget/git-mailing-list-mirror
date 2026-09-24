Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA961625
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213180; cv=none; b=E9hY1Cd+zZUZgIjTbaHWUGyKqUMfuRFDyPlB6Lqnu9Id4j43xf3AGyhwQIZ6hYuNqNp42r8u+PixRFcVIJsdtKyaInWzcfIKtzxo+mEBmVokJH3cuiraG/RWdliEKvEm404svNW7Lslnb3B87sFViY+dSJYxi0g4SG9rgNHbRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213180; c=relaxed/simple;
	bh=MdzBcGoFGgp0yAmjlLTj5i7LiVw3X0pnqfzTFt447eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=M4lsu6t2jPeL43vFbWAtbQtL4FTOOaurphn4xCYDjjoTKWIGA62SrJh0oWIF29/PpKRiY6YLBEctBMJAFopnYJWoUzXMoqzra7RbAYV8vTZdXeQUi1gPDI2kk9rpwpDVKPCRZiIwrVMMAZEYqg/A36VIvWeP+0DsTIT6d+oGNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=FCadrZO7; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="FCadrZO7"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2a99so1091597fac.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 18:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790213178; x=1790817978; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87nd/dkY7Z4l96DM7Lo8a0Ep2aLz/wvWPIvNUmoo2Gk=;
        b=FCadrZO7qIw+3rZ15uMCDTHjphz6v7wNg8jC1juxSmtqL3rbXdy5Ty/mNmWF4MLYSp
         RkyTEfwzWkQ3bJq26aQkwa2WAjidqx7h+/mP3aCDT943ZpeQip6ANChy2RjtjwHwUPQ9
         Mvzhd4hO2ScIWLc+UmhP6vrGSqvmJ2UXIg7Bc4l6PDwXiqed4lXMZUpdZdv4b/K+fw3I
         a5+lwddTTwYkKX9lDOgi2nVXkX88pQQYTJgorXdu/QYoVuztX6FTiZUiHgbvTCoiD5o9
         34z1KbiDHgka/+cCUm69zLNquugCFzNyUfWQkdubrZ2xB0e2g7EDG3ZjZ6FFxmNWTfr+
         Igqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790213178; x=1790817978;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87nd/dkY7Z4l96DM7Lo8a0Ep2aLz/wvWPIvNUmoo2Gk=;
        b=ZTAOx2I1ug/GvWuHVkA2qmhIxL3T/MpuqhfUTuH7ow4XZHsNIixL+4Ta5vcjbxyT3l
         OSsRiNQoHMnKc5GqN2IYCLln5KC+n2LaLOy01dYg+jVsOwuwzoYAyBMVHfOZSGEEMBaf
         xDK20pa0iXBgg13CJV4lzP9ZZwrJUJVaJenvotrH3IH/T4vkMGxLoLQD03rwa9cKQqfN
         pWJEX7qWUOGuI5wsZJJMaHKwdlHx+ZCcQlaNyrbOsffgVP2dvU9mRyZS2E5EMMu64FmL
         P2p4REGFJe2lISQwHWXAKwYCRCfCSe0TGWoVZzgk7JIFw6JdG6WS64F4QzVY3n9QDDyR
         QuRQ==
X-Gm-Message-State: AFuF++lewtfGkxEaMI25kBXXkjFdwZg3hnS8YWA7E6TrQgU1lThU8mM6
	bz84zBVyvHwlYudRa7dWPiZ7OLox4AERbBwsBgc7JO1e6lzM3rjOx+IBslbK+vOvt7Y=
X-Gm-Gg: AYBFou2xqFlOp7yDqqQ52eF8XW8L3fBfXIN/K6E5cH6HthvLrp1XewekvrBBMf2GFcO
	5hrauqX04+WL3+X1ARDK69RI+lPRdPasUhhqpgK6N8F9D4d65Zb4TC7F6vc+p6Ivfl8S/JF30Ap
	HI/AQQTXfEJh+OlZhv8jKGt7BKlP5ngYAelfRD/bTicmTKXEqM9X1ZwWbAFnYs6aqUHcmf+2hN0
	glNX0l1E/lhFDjoZci8noImInlI3FG1b+kMJKokbMFbAj2cHK7jfYcGHxn9dKQH2V7Nt8iK13cD
	isugNqIZMr0SpevFoeAFLJCmQcjdTZ+H9r35npdsFi6pAFZYZYNfvqWj15qgP2toD/MncfAQgRa
	6aG+FL0prGCR8Yw81hmCk5PuqSDulgcFwY2sxn6swhZBVcRkusE+rAgSmt95RAyJvYkNbhXkp4D
	F/BQNBqXNcUwUn+OeVB+Jk2gnJxzj35HjMn7CitStlaZyBZZ4wUNdhw0/bQ6275hgHGGfndy2Ly
	pTWd8JKpiYra/p1P+KO8igsgIXveZJtheEUsUE=
X-Received: by 2002:a05:6871:c8dd:b0:48f:e25e:e203 with SMTP id 586e51a60fabf-491e6df1dc6mr1121480fac.52.1790213177813;
        Wed, 23 Sep 2026 18:26:17 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491ed1e75a1sm917940fac.4.2026.09.23.18.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:26:16 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Wed, 23 Sep 2026 19:25:30 -0600
Subject: [PATCH v3] git-contacts: allow inputting patch via stdin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw7CIBQFf6VhLQaoxeLK/zAuKL1tr+krgETT9
 N+FunHRuJzknJmFOLAIjlyyhVgI6HAaI+SHjJhOjy1QrCMTwYRkip9oi56aafTaeEedr3GkHEq
 hVM6Aq4rE42yhwdcmvd2/7J7VA4xPprTo0PnJvrdq4Gn3NxA45VRpI0UJsqkFu1YW204PRg9zB
 X1/NNNAUiqIX1mxKxNRJhgrmOS1Yme9L1vX9QOYWMgVHQEAAA==
X-Change-ID: 20260914-git-contacts-stdin-1e829930e19b
In-Reply-To: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=MdzBcGoFGgp0yAmjlLTj5i7LiVw3X0pnqfzTFt447eY=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9aWGtNb0oG8jSxnbJdvXbb4m7Tmtn6tGc15S0+z+CcVT
 /4Tvju3o5SFQYyLQVZMkUXl1iz1i5OtHx2M4J8AM4eVCWQIAxenAEwk5CjDP0utP8Z3p1s4bb2U
 M9HAQk6Z4c+tzbnN2x/tT75+lid4LTfDf/+XXYtCdhY6Hwj4vezwXz5vqeB2H7WIyZsspcu47+9
 dxQsA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make git-contacts accept patch contents via stdin for better
interoperability with other utilities. Read from stdin when the user
passes `-` at least once:

$ git contacts - <patch
$ git contacts patch1 - patch3 <patch2

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
This patch is motivated by an ongoing personal effort to allow b4 to
invoke git-contacts automatically.

This latest revision requires the user to pass '-' instead of implicitly
reading from stdin when stdin is not a tty and argv is empty. This
simplifies the change slightly and allows for input via files,
revisions, and stdin in a single invocation of git-contacts.
---
Changes in v3:
- Make user pass '-' instead of an empty argv and non-TTY stdin
- Link to v2: https://patch.msgid.link/20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com

Changes in v2:
- Minor variable cleanup / un-spaghettification
- Include update to usage comment
- Remove Cc trailers from commit message
- Link to v1: https://patch.msgid.link/20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com
---
 contrib/contacts/git-contacts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..74910496f4 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -162,9 +162,11 @@ if (!@ARGV) {
 	die "No input revisions or patch files\n";
 }
 
-my (@files, @rev_args);
+my (@files, @rev_args, $read_from_stdin);
 for (@ARGV) {
-	if (-e) {
+	if ($_ eq '-') {
+		$read_from_stdin = 1;
+	} elsif (-e) {
 		push @files, $_;
 	} else {
 		push @rev_args, $_;
@@ -178,6 +180,9 @@ for (@files) {
 if (@rev_args) {
 	scan_rev_args(\%sources, \@rev_args)
 }
+if ($read_from_stdin) {
+	scan_patches(\%sources, undef, \*STDIN);
+}
 
 my $toplevel = `git rev-parse --show-toplevel`;
 chomp $toplevel;

---
base-commit: f0ef1b96a076d08dc972a8d2cb0d1cfd60931eb6
change-id: 20260914-git-contacts-stdin-1e829930e19b

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

