Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD3ABE65
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697803; cv=none; b=M4PDyVNdTviu4roXqIwtu5B2iL8qqawLFzjfjTRmvhfTYAV4+ff/IfLIcW9InZMbqc/yJNMDNZizUEBaWsoyCB12CGMvL3GqXMn46H1n/kk2IToIIxr8ZfB/oPR2p6m9kSjteQOjh2Uoq0vEwwim+8cNvFkHTCoaca2ioPDbZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697803; c=relaxed/simple;
	bh=4ZP4xfDsJdNW5syTAMSbm6pEHivl+K9hdCP4cvlw2Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlMYB5puQgPQQh7dHvU8iCy6WRjshXk7WNkoBx2pbJeasHxHtwlUXUEUpMVjR5zLxA8zO56ZFugX7rrcJS7EvyosMEo0LNTikc8qav+/tmsoVtULPSKGDWR1IlA5dKIoWjXeIKdYfiIk9ZBapA6iorWvjEi8NouNpYc0LlrRdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoLFOVdH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoLFOVdH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99ebb390a5so34964466b.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728697800; x=1729302600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1xbwj/bdEV/vJyLMpdUUhO86jpBmMnVDrj7Xsyluz4=;
        b=ZoLFOVdHurpVciWglPyCjW8ETfQPRadOLd07O8YOagynyKGmuD7l6VkeqiC8SYIUSF
         Pain3gHus5z/oSlLykKz6WzRAhpAKpZvOOT/wD7QJ6fqdc97T8wwhPm7GKN1H1BpfjyL
         9hGbYmg8crTIBjQHrXQiEyfK+L5ADr0ZfzVrPde4zmg0+g7maC9jKHsBRvjUjqyZRAoU
         zQsSRpU2fYXAVVFeYizVLBNK2iOSiM28alUjwT3d4urUOFAzSK6i0gjSFuar/3d5CHIH
         TQQ1aDe8CVKG6EI8FPRPv1D5PPCv7FE2Laqru8O1gOqLbZnlFZV9UaF/i79cBHMK5n+T
         04vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728697800; x=1729302600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1xbwj/bdEV/vJyLMpdUUhO86jpBmMnVDrj7Xsyluz4=;
        b=dhaZnNsz7BYiKXnU52VgUheozTu7re2ZAuAGZkjHsdn8ZmRE08eXDNNI94oT2IgEZG
         TcLMZ3yZXo7XT+nS2dpbYOb4xit1t1wM/zIYoFblJOksW1NrY4cdz+XyTTynY0Crqes8
         PhY9m+gwoXc1ghQG8cJytpYAMukNeVTHcZFUlU9GVG+pNUkNZ+p/ca11ng80ReYpaPp3
         yywRkxhIEponP9Y7bKC2WfsfTMbvD0uuJJDkryZTmN2cmhQ8gDTND4sEp7JpEKLcQbK1
         REC/cL9B95phMF1S+bWoeAqYC2rV1P8sQMf4kNTjUFCcQGgc9lsjq59AfX8sEJeTz2Lp
         AzeQ==
X-Gm-Message-State: AOJu0Yz7CyXmkJ0Tiydhfxpb80AGXWl268ceKp8elHI8scCUmFexABpC
	E9JFaILRRjBx4LhNC/ezBE1Ovfj6iEf2HQpy70sl/UxyfA3q8Wn6
X-Google-Smtp-Source: AGHT+IH7Uv0+xLGy5nDEFD40EnaGUpEEnoFSsLvPAlhud8fIuqBzQeMiXOzFVNzegQuJbedBQD8NDg==
X-Received: by 2002:a17:906:7307:b0:a99:4112:5e6e with SMTP id a640c23a62f3a-a99a0eb7dd7mr846083166b.3.1728697799879;
        Fri, 11 Oct 2024 18:49:59 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bfc5esm273122266b.142.2024.10.11.18.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:49:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johannes.schindelin@gmx.de,
	spectral@google.com
Subject: [PATCH v3 1/3] clang-format: re-adjust line break penalties
Date: Sat, 12 Oct 2024 03:49:51 +0200
Message-ID: <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1728697428.git.karthik.188@gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) we
adjusted the line break penalties to really fine tune what we care about
while doing line breaks. Modify some of those to be more inline with
what we care about in the Git project now.

We need to understand that the values set to penalties in
'.clang-format' are relative to each other and do not hold any absolute
value. The penalty arguments take an 'Unsigned' value, so we have some
liberty over the values we can set.

First, in that commit, we decided, that under no circumstances do we
want to exceed 80 characters. This seems a bit too strict. We do
overshoot this limit from time to time to prioritize readability. So
let's reduce the value for 'PenaltyExcessCharacter' to 10. This means we
that we add a penalty of 10 for each character that exceeds the column
limit. By itself this is enough to restrict to column limit. Tuning
other penalties in relation to this is what is important.

The penalty `PenaltyBreakAssignment` talks about the penalty for
breaking an assignment operator on to the next line. In our project, we
are okay with this, so giving a value of 5, which is below the value for
'PenaltyExcessCharacter' ensures that in the end, even 1 character over
the column limit is not worth keeping an assignment on the same line.

Similarly set the penalty for breaking before the first call parameter
'PenaltyBreakBeforeFirstCallParameter' and the penalty for breaking
comments 'PenaltyBreakComment' and the penalty for breaking string
literals 'PenaltyBreakString' also to 5.

Finally, we really care about not breaking the return type into its own
line and we really care about not breaking before an open parenthesis.
This avoids weird formatting like:

   static const struct strbuf *
          a_really_really_large_function_name(struct strbuf resolved,
          const char *path, int flags)

or

   static const struct strbuf *a_really_really_large_function_name(
   	    struct strbuf resolved, const char *path, int flags)

to instead have something more readable like:

   static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
          const char *path, int flags)

This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
few characters above the 80 column limit to make code more readable.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/.clang-format b/.clang-format
index 41969eca4b..66a2360ae5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -209,13 +209,14 @@ KeepEmptyLinesAtTheStartOfBlocks: false
 
 # Penalties
 # This decides what order things should be done if a line is too long
-PenaltyBreakAssignment: 10
-PenaltyBreakBeforeFirstCallParameter: 30
-PenaltyBreakComment: 10
+PenaltyBreakAssignment: 5
+PenaltyBreakBeforeFirstCallParameter: 5
+PenaltyBreakComment: 5
 PenaltyBreakFirstLessLess: 0
-PenaltyBreakString: 10
-PenaltyExcessCharacter: 100
-PenaltyReturnTypeOnItsOwnLine: 60
+PenaltyBreakOpenParenthesis: 300
+PenaltyBreakString: 5
+PenaltyExcessCharacter: 10
+PenaltyReturnTypeOnItsOwnLine: 300
 
 # Don't sort #include's
 SortIncludes: false
-- 
2.47.0

