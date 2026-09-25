Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA89375F83
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318649; cv=none; b=bZ7IrtJOb9lsixx470Lrq4jF/GiVfzQX03xpNNkIkgEPJqUOggu8IvF8MVYuD5aAHd1HIH7JRf2tROl89rBzhC64wO8whJfl3NlRkxozhIXweejP5oFgaNvWEo/nT5gZADUjdh3eDzABYhgjLt7LiCEd/xAOZzeM1vzKJwQdAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318649; c=relaxed/simple;
	bh=peQPFCTzBnuhzf+5+FG42vPi3p91hEL12tVgGwx1uqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=oKJHuxkSp4iSSm7oIyOPDAVsLHiNQmgEDWyLTaD+t3zn28ot1m8RqQK4Hx4sEZ1KYwy0OKi86nW0QUILcpdDqEHGM0gYrj9MVParkcj6WgZNIYK2O2lqwAl/NF7XeRzVVH8nO4m2TLITx8vNggb19fvatJGKoslS8znNM4CaUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=F35NoIsN; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="F35NoIsN"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so322431a34.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790318647; x=1790923447; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uv9Cc/Vj6KPoilbDFIvOkb93eAYbeCehWpc7Ku5+kWQ=;
        b=F35NoIsNZWx+belCbfGO0L8Nu5/SR1ZdWAAksrZ2CpZOEmiVDJhiEtB4oukgTn7qwK
         suvGppEnF8GtFOJUrxxXCft+7ZA8bQo1WHLLV0ncwGRZ28f0cMDZeTk77lwubo/BYIxO
         lBQ+Geq7kfAc9gRna3a7qmQKIvX+1OGvRzpG+W0MY2E6e+gZ5i2uTghWMQmSG2KtswbQ
         thyZx9DD4iw5DLDgAaoPi0QwQaLzo4R1Ufo+Z+KmVI3yr48cONnojCOoJoAl0AkENeip
         S4XUPPSwxbm7ide/hCLdyviLni54Jx6fm/WOERbJwhxIoqLwH/sQIwEmy4vgTiZqOF2a
         XG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318647; x=1790923447;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uv9Cc/Vj6KPoilbDFIvOkb93eAYbeCehWpc7Ku5+kWQ=;
        b=a7UOLSprOmJX9gs1ij1rY7FvS6IMHYGqzR9p6ifCa4sVM15eepXvc/F/BGpLgHvEJT
         sA3skJFxu6jO+g161j4STbKnZl2OoVqwDbAEvKgeamQdnQt/czAJJdOq5L0YhvjBDhYJ
         F2aRrR9kVxaFljTOvgiQhQc0NCa7Vi258dbqxGjK/rW9CMEw/RGWMEgehetEXPR346Ct
         ovT7hA9BYGSr7raxeF4Kxu5JvTVVTdarEyNPEnVaTL7QyZIko9n9GbNF48VdrYj3COOL
         qIrLY+didNzNAUO+K1xUncRW1hhvNvsAUkGBlZZXCzvEZaIvoW6ACs9A4V354yY+fN6n
         Oucg==
X-Gm-Message-State: AFuF++nDykxtdb5JEM7AEXH5KrT04gITxLdcHs70n0PM4OrIgaROBcKO
	OyJPeVogU5M0Jpk01Fy+4CgN1WhsbJrNWYl/LTEwcsXh0MtjpGC7LiB+EKSwskassFg=
X-Gm-Gg: AYBFou1iJMLcmy9Qf3iYJpadqvjSLDykcw3ZKsaqBGZT8VV5ji1L9tMTo2VLG/W0fwR
	DX9pAndKIL8ihh0blFXEYyECBIZgW1nr2fqh6IQe3KpfbdGr0PTLQG0z+qiLgN9NHl6KXl1NSs+
	ve6yyAlJjccERaBw4D0sZG2n8H4/RGHmO7qANntN6uKTlgJ/wFazDTnUFw4UDVuWe1q0yMuSoj9
	1579UdrSJTqKZNxpjDdEYkzvwA3omYkUFc8cTHVyIS0w8EwgLfjlg8aJwvYjmvUN4dd50/KL7mE
	CsGdViHB3vnYDK1c3emsH9vzqvJsXf/GS3kgxBCH62eh88qCWqT9xYdNi6yqIebQme8OKWeF8Nu
	U1QzQSwkIbkmj6dxOMRmTEoJBE4KbCIVDZkvm/ijfMT05sLM2nmpzKwp9bhNC+8f72k/pA21QeQ
	sd0SJ3ntyQpRpPHRGuzcTlaScyQ24PomaxwjZ8vOGgzzX/+SD71CsVgLC7Un49SyBRKIVlVvsq1
	1ED2jCJ4PsA6uVnjyGkd4kuaKP1bP4zzGjHSN4=
X-Received: by 2002:a05:6830:3490:b0:812:c5fe:5e4e with SMTP id 46e09a7af769-817829894a3mr5268408a34.19.1790318647290;
        Thu, 24 Sep 2026 23:44:07 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e9ba2a1asm1506957a34.27.2026.09.24.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:44:06 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Fri, 25 Sep 2026 00:42:39 -0600
Subject: [PATCH v4] git-contacts: allow inputting patch via stdin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-git-contacts-stdin-v4-1-9b4e4bcbb91c@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NzQ7CIBAE4FcxnMXA0qJ48j2MBwpru8b+BLDRm
 L67VC8eqsdJZr55soiBMLL96skCjhSp73Io1ivmGtvVyMnnzECAFkYWvKbEXd8l61LkMXnquMQ
 dGKMESlOxPBwCnun+Ro+nT4636oIuzdLcaCimPjzer6Oce38PRsklN9Zp2KE+exCHKlDd2NbZd
 qjwet24vmXz1QjfWLmIQcZAiFJo6Y3Y2t+Y+sJALWIqY6X2vlBOF77Uy9g0TS+fX64yagEAAA=
 =
X-Change-ID: 20260914-git-contacts-stdin-1e829930e19b
In-Reply-To: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
To: git@vger.kernel.org
Cc: Brigham Campbell <me@brighamcampbell.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=peQPFCTzBnuhzf+5+FG42vPi3p91hEL12tVgGwx1uqc=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9Y2CWMljgkTDh5PqHGY6X7h3Mo76TbXbgr/cDix82j+l
 lKF8w+EOkpZGMS4GGTFFFlUbs1SvzjZ+tHBCP4JMHNYmUCGMHBxCsBETigzMhw3q/f+uvDg2TDZ
 HbsMnXffN0g6fKdcZI5rsniUHsOeRVMZ/oq8X39o7vxf2tN1UnUfSFxlep3otnP+w1cCN55+/Sq
 9pZIHAA==
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make git-contacts accept patch contents via stdin for better
interoperability with other utilities. Read from stdin when the user
passes `-` at least once:

$ git contacts - <patch

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
Junio, you suggested that I make git-contacts process files and stdin
with respect to the order in which they appear in argv. I instead
removed the implication that git-contacts processes input in any
particular order.

Even before this patch, git-contacts parses files first, then git
rev-lists second, regardless of their order in argv. If we instead want
git-contacts to parse arguments in the same order that they're passed,
that's a change which should occur in a separate patch.

I'm happy to write that patch if you'd like.
---
Changes in v4:
- Don't imply that git-contacts processes input in any particular order
- Link to v3: https://patch.msgid.link/20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com

Changes in v3:
- Make user pass '-' instead of an empty argv and non-TTY stdin
- Link to v2: https://patch.msgid.link/20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com

Changes in v2:
- Minor variable cleanup / un-spaghettification
- Include update to usage comment
- Remove Cc trailers from commit message
- Link to v1: https://patch.msgid.link/20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com

To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
---
 contrib/contacts/git-contacts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..df7b920d9e 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -162,9 +162,11 @@ if (!@ARGV) {
 	die "No input revisions or patch files\n";
 }
 
-my (@files, @rev_args);
+my ($read_from_stdin, @files, @rev_args);
 for (@ARGV) {
-	if (-e) {
+	if ($_ eq '-') {
+		$read_from_stdin = 1;
+	} elsif (-e) {
 		push @files, $_;
 	} else {
 		push @rev_args, $_;
@@ -172,6 +174,9 @@ for (@ARGV) {
 }
 
 my %sources;
+if ($read_from_stdin) {
+	scan_patches(\%sources, undef, \*STDIN);
+}
 for (@files) {
 	scan_patch_file(\%sources, $_);
 }

---
base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
change-id: 20260914-git-contacts-stdin-1e829930e19b

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

