Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112E81DE89B
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422552; cv=none; b=MxnTe0J8yavDFYiVfPWBg3gDX3Y7m61av0d1r1YX7SoMYUavQO5GVvnbFr0AhXV4leiPhshUHELY7AAOjBkZZbkTcOnSCK5klGiaBAVkGZWzxSxdPcZm9LnEyJ1NU6QddGMhulPJevZXRONjoxerOv6ZrCCSD4o3vVWMHGRw/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422552; c=relaxed/simple;
	bh=rW6XAXHR/baKs2zZ4OwvdZLmXD2Bq4LF8tM/Fw4bCbI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J9dI8EZhs7AZ1GR4pLqww+AYuhkSJYRkP1PoO2elIPgpdc0aopJFCTNFBAfGpnc/F0/FSu8NNvMhpbJsC/R+s7rxTxgXDQD2VOwa6GLBYHbwn5vanvrbuK00F6MDeGcmX+dmIqXRv1lrtRL1JP59lO8Z+aBD11Om1mzVD6zW37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ati+03Ti; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ati+03Ti"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso29612805e9.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754422549; x=1755027349; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1X06A0NdexEto8yPmI1p6MIlBfs5M6iYOqr3bHf/G8=;
        b=Ati+03TiWVWv6g+mJa+epu8LtSc4hPUoLN0Vd2mecI9LxPhfbdQU90El+WiP3VEOo8
         iPo459M1WV9Y0LKeNmPi9lPVzBckw8i8WjdQVoxN5+cJ+xWw7C68LwK/p2IF87mwg6Wg
         jntYfHqn2QU5ueVDQzxdHtHY1ob9SeIIhInvcrTs1q2rMolvTQQh2OygBXkBc52DW1L2
         5gw/CsMl6WRYXFdP+Z5W5UGkUlKsI7RpHJGimuWLocY8IIWRnlg0dg3WbDOXdHhAklN+
         GnsxSMLb4pUVikUbnQi9jbBE3Jth1uopCDOKh4B2yRDjhW68llXA+Pk7AM1aWQxfsNP7
         p3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422549; x=1755027349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1X06A0NdexEto8yPmI1p6MIlBfs5M6iYOqr3bHf/G8=;
        b=RjMfPRp3DFoLnYN3rl/Jm4ppW+ijw2bdT4YtYmi8uvfuBd8jxDuClCdIlprJdrQPQY
         rA16AFmk/y3/l4dXZMtNhwAnY4ksxgJNRy9IwFyCvy2+t6D+fWyZfz8dximzMaWRvvaz
         zgzm60c5R+1EI0pwwelfA1ZtsTeYRYVxoxpraTcT+YC5W7Zmi3H2I6Y8OWF+1AEgeT/X
         Gm9nfHs7tGmOj/IqtTij/9GDqZKkIIIgqDm7B+V/NfCwF9g3IpXMNxk+zY6pogqVCWkt
         S02pmK6WrUZ0SZx5Cs5ZP5KhVjib+fj7CjTdtbOIBQv547nn/TEUFq2wIb0phz1jJxvu
         qDvQ==
X-Gm-Message-State: AOJu0Yw8Z1GgwxV5a8LyYk61xSbK8Q/OxMuCap1mQf6PcHLT0jSjod9Y
	4sA/H28O9QAHgwdeJu/F0/zeRRBOl0ibRBADpxS0KwWt7vcXRXpSDt+wYzBcjA==
X-Gm-Gg: ASbGncv3LGQ2LXL8hR26wfZGXukLoC3aCK6MTXsAv9uhr4JxpKjnANq45dvQZ+4Yhaw
	ZGF6vwxG7UOrK6xbwTGWJHsvvnyeLNp/gTAXgMx1pIJaHFAm5KyhT/sm9dnGzLFuqfer96QXHrw
	Ez5UNtMCsmKApMjPBttFCJ+MhoT1lCr1P09ermI8EEYZYhYpTczvikfEpFpW3rO87sDUQKZeC9V
	8BmI5kcrZDVX4MLZdhIXYVZcaHSxLs3vW0GrqFixTyjQKyiMaft+WwhvODYqqp+NNkKOP13JUIg
	QWdu7PbA36rG/Us5h6Kue5XnluaZoxpEha1mq5KkzYZCubexmjAAJcVYy5OvA67UEk+9FCg77Ki
	BHL2P5q7zsMNOWpKbtVnIrzE=
X-Google-Smtp-Source: AGHT+IF4kBkAzJczUSFzIsgEKJ7IaVOdJkD48Hk5PKfc0JNZUQBXuTOM5HXsZBsP6Pt4lyr5J1nZuA==
X-Received: by 2002:a05:600c:1c25:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-459e70eeb39mr874305e9.21.1754422548728;
        Tue, 05 Aug 2025 12:35:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm20867655f8f.34.2025.08.05.12.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:35:48 -0700 (PDT)
Message-Id: <dccc204430535f8c9eb74d7861365dbb2c42bb02.1754422546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
	<pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:35:41 +0000
Subject: [PATCH v2 1/6] merge-ort: update comments to modern testfile location
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In commit 919df3195553 (Collect merge-related tests to t64xx,
2020-08-10), merge related tests were moved from t60xx to t64xx.  Some
comments in merge-ort relating to some tricky code referenced specific
testcases within certain testfiles for additional information, but
referred to their historical testfile names; update the testfile names
to mention their modern location.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 47b3d1730ece..d87ba6dd42bf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2163,7 +2163,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting mode for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
@@ -2520,7 +2520,7 @@ static void compute_collisions(struct strmap *collisions,
 	 * happening, and fall back to no-directory-rename detection
 	 * behavior for those paths.
 	 *
-	 * See testcases 9e and all of section 5 from t6043 for examples.
+	 * See testcases 9e and all of section 5 from t6423 for examples.
 	 */
 	for (i = 0; i < pairs->nr; ++i) {
 		struct strmap_entry *rename_info;
@@ -2618,7 +2618,7 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * That's why otherinfo and dir_rename_exclusions is here.
 	 *
 	 * As it turns out, this also prevents N-way transient rename
-	 * confusion; See testcases 9c and 9d of t6043.
+	 * confusion; See testcases 9c and 9d of t6423.
 	 */
 	new_dir = rename_info->value; /* old_dir = rename_info->key; */
 	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
-- 
gitgitgadget

