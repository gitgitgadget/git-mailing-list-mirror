Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360A352027
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521829; cv=none; b=aKWeN1D1sN+a5EsMDIKIz5XYMwblvtaOhZdAiXnaDgOZvcLZF2v+rxzqX6HbaliHP0NIWHFZoFsyBUohQZqpbLcMGifQBmDrs6+hdSSW7ywSUQG4s8RuaSAJLK/s3UCa/eQc6OaRuZvuC0gEtbPARKJuBs0pzWFa18briQbopPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521829; c=relaxed/simple;
	bh=L0aorolHmh+zSLT5M0c7vnPuY4g2EN853XQHlkWL9pA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dDQUx+j+dLxoJbsqeJ7Bq+MdxXdnnGUUuceKnnGV1/1+ZWLSRgTreTWFmVSQndIXjdxCZl29s3VGBvSB3UxQkysxc4Vh53mlAEj9jxHmUgE86qGPgI0FZdYKI0sochIQyXo7ZLAUxPhjb+o+KRNXuW5alChZ94ncYhpMq23c/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/ZzeKi+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/ZzeKi+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38101f85591so1828906a91.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521828; x=1787126628; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1vM6rnfrf+U6NL+99w+dEPnnPVhqWaQiZSU7UUwUYus=;
        b=g/ZzeKi+zY8zbfLyO0GInByOsQdZ41Sjf5qDy3L2QrGjoR6PNs7zYEaGV5AF65gv4A
         K958ry7rat84PkUxBfmWzciaoBOrU7x5/RnfRD15GrnLUIiPymSpvVBmLXmUBaCzOypv
         lW6HtzBqHHffh07fdip70G7MvZ7iP16gA1YpqYU5XM/eNAHY+KzE2+is1xv6thWiUNQ5
         VOTudEjrpUz7SI7YU0rXWHgZoEmvb64SxJrNBOToCz7lILR51M2aNYT+t+q+QoQKWdPH
         43ZqAcAqP29fhbscF5REacaCTLZp1/vYe84zo8mLiBvPuG/1WStXjIv/ObLNlOqvnF0x
         UENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521828; x=1787126628;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vM6rnfrf+U6NL+99w+dEPnnPVhqWaQiZSU7UUwUYus=;
        b=EZF5XvD4uLuLU4ajnaZ4QEe4oqQoC5Rq8pJsvFmETWj6RVzKztesUsZ3iIg41vVSiE
         fWbllIXnkmb9O3hGyeHCS95k4NtaG2uMxX7BSBCzuGlNoM43zeKdDHuItOxaMDNOKBXr
         z+rCHc3RKC88xPo6QutLtVzZy8cyG4dxWkHdwgNDNAZ+3EoBLtBFCHOe2AIlYHAqZ3kA
         P17R12OCLqBFC5kq3BrPLWShtnvgSVsA7knPradPtrZEFFdQxxJc1n2q6BVn2GTlSBDN
         ln915FNNJEHXted0F4wfB7+s6U2VOUNqpvooluECRp4x3QvFHq2S8LkDe6hb7QcLMCBi
         myVg==
X-Gm-Message-State: AOJu0YwqN7yhvEw9Fx3c8NP71pK7Nj7cb38eleOYyOu3JhCE0gUHm/C+
	eNcN4b/Py4vlcCsLYVD0JaeuBKYijL0607DDqo+qYYaQBGIWi7nCnymZmeMABlD5
X-Gm-Gg: AR+sD13Xwasx8tMopOAGRYti8RjwyTMcyEf1Nfu6ppwRAQqmLrQ2Or3TbG5cEX6LY6S
	5UlL/Dx6GzDuX6TCQ54Hm7ap4O4Yb3eNoGCisZhC7bL/tdqdwMWgslmN7YllNVW8EQShaAECA6E
	RU1xoh0KadBZdl+4OXxOTEXULqO+kFWlVn2nDUQdlR10e5AB8kn3L5nep7kBKNdPlgkSE/HTouM
	w+z/DQejFDOTgxr2Kuuucu5d/MK+70o5zQqRDLx9rOE0TVmckxEfFwCGvu1xyua7Dks6B4m445r
	+O0uXfj/9oN+5QcY3GcQwrAI2nEcCj+hzyqcqeiTLSpAZStCcagmHc9xycosFUmc3UBLVNQ6fZI
	EP0K/KGonjH+rLAQTAAQRTL2iWpYgFSJflfLlvfsD6oUP3luAYyX+TggFj8/mk4Ih4bz1A4ezoU
	m3WK0w10vJodRmDUTc26QPDfOHsrTGddoMF2aI9pKgZ3f8f1a25Ru12S2629IeUQ==
X-Received: by 2002:a17:90b:224d:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-393028e1b44mr1145746a91.5.1786521827517;
        Wed, 12 Aug 2026 01:03:47 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8e3f565sm2620985a91.13.2026.08.12.01.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:46 -0700 (PDT)
Message-Id: <258dbb0fbda31ab0627f9da179c1c37cdd64666c.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:20 +0000
Subject: [PATCH v3 12/12] bisect: handle dup() failure when redirecting stdout
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
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To capture the output of each verdict command, bisect_run()
temporarily redirects stdout to a temporary file via the classic
dup(1) / dup2() pair, restoring it afterwards. The return value of
dup(1) is not checked, however. When it fails, the saved descriptor
is -1, which is then passed to close() (the issue Coverity flags),
and the matching dup2() that is meant to restore stdout also fails,
leaving the process with stdout still pointing at the temporary file
for the remainder of the run.

Treat a failed dup(1) or dup2(..., 1) as a fatal error for this bisect
step: close the temporary file descriptor, report the error via
error_errno(), and break out of the loop so the existing cleanup path
handles the rest, just as on other failure paths in this function.

Reported by Coverity as CID 1508242 ("Improper use of negative
value").

Assisted-by: Opus 4.7
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index ceb60b0626..be42468af6 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1308,7 +1308,14 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 
 		fflush(stdout);
 		saved_stdout = dup(1);
-		dup2(temporary_stdout_fd, 1);
+		if (saved_stdout < 0 ||
+		    dup2(temporary_stdout_fd, 1) < 0) {
+			res = error_errno(_("could not duplicate stdout"));
+			if (saved_stdout >= 0)
+				close(saved_stdout);
+			close(temporary_stdout_fd);
+			break;
+		}
 
 		res = bisect_state(terms, 1, &new_state);
 
-- 
gitgitgadget
