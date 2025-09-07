Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F618A6DB
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263221; cv=none; b=s4YlS+/A/vl0ArhRpN7In+iKgHCGs/dz+qMW2plUr1x8M6hcMXWiE83Bh7gsMu1DY1DwRaTEooXFr2AvQA8tD5HIoT+0deFWAmmGdhQxrZDgKqLBrRHekCRlqxpjev8WaISjkIzB1FVioIqcZnNCqbtSFVn9tHZSTcyD0r7iQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263221; c=relaxed/simple;
	bh=qcPexrrmtQezTLvwNqtc4k+3eRnxQDeTWtE0b7wmE4U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hD+jw9e30Q8d3v/I6scIuf+jK2jlRN87PsZiBQaLwtTuHNCR6kNWdsXo1tvy1z8Y7PC1277lvphcxFjLX9a5euFBjnOVbqC2HWz3bBOp5tW2i0Orrpl/FFPvWzXBPsEi7TOyp+Cx8p+bpQ8Z9BiXZXsnTXGA7KhtJkHFVd/h08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j21Hmpk/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j21Hmpk/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b590d819aso3059815a91.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263219; x=1757868019; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8UJTNtHGhy9Cm5CfhbdX59slAGRun1cyAkQUtmSKEI=;
        b=j21Hmpk/TSoq/AAva3e0LyZjgltnUwu3bwsBTYtWTPD/5IpGJcar+Eu/xUhuI0e2nA
         nxPRh6VvBxrCyN0xPyJADrfy530yVPjN8MI7TINi4iVLJon9wB9dJBQKTORXAOWOGnsQ
         ebRZmzmqFBY8NqmAdgJSrL5x/Y37EQ6+rDzvQS2uWiKlHptu5ysj0toObru6UgpYZ3vw
         ZGhw3OIujT1mAg1ZLZ9jQpWlksVz9nzxttgsm1VXek72jDkh3vYIweybwcwVaCtQLGS5
         RCAGB6kHNTlyMGPXUMy1bSdO8/9zQmD1JUFXT09O7APCadxNld/LKet9Uq4+3ZCXj0LW
         XqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263219; x=1757868019;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8UJTNtHGhy9Cm5CfhbdX59slAGRun1cyAkQUtmSKEI=;
        b=FZxJP4djtWYH5eLeKAY+B8yu/NLH/zsVUhcub7wPCPazOUvN29EY4HyQOAPPG8lEk5
         zAZUM5xWgQ98hesFGZYhWYQ53HYNB+xpLH5bThnm7QoRNOkr8unveFo5thYrYc1aWPNy
         wRQDfUz//6kBS+xVrL66YZH2+w45WPQjULjJc8pmIGqp35qCZUeaiyGFCNAS3/l+LdzG
         0Dmom7BNCJaE1b3savv9/HgO5xodJa6ehbZ1UneHAnWh68jPK9zQEafVG7RD14cJ/ol1
         qzQmXsvLEVdNnjgzbclXjrDptxqyLw7WPUwv2ydm+xChBlrtjcNrH4nSc7u5G+O4Ktpw
         3xaQ==
X-Gm-Message-State: AOJu0YwKJPlxN2JXQEEsbrFRiVjBzHljz2+X09MNE3YGnUHGeU+8If0r
	kegbJfqKDbN6z6jB8WZ4cFwUW1/v4ogypGyIZA/p92wj72ckiD2LSLM34K3PFbPb
X-Gm-Gg: ASbGncuBhOVtnN7u9+nUu7twZpV8IuZo3bXUgz7Q0PJTVNiri0Plo7TI37mtjXBPZVY
	xOW23A6D+DMUPUyDNstTyXO6rKI+Ri1z5k+mSaG0pfT69DknQjzNrhIeB4K4Jd/I13p2qUTV5RP
	R4Phka8cpuF53W3jb0t1bShSY/diasgKSoIiR/sK+6OB3lESKkYPZtjdnvmvlhdnnCCeNU1Af+O
	KX9K6pyZgc3htNmGb0zHhVSCRBsvdLnVBXRgfNmqxlq3wLWy9oE7VSxihA3fcRZ5SqQo7TPDsKQ
	U+uz4GLIBzNlGyZLBVXm6EYD0kEYfQ2fa1Icm/HOBVacsJN5JkQGyUbKHUphVHHpj2T0lzgshLN
	RgJrJ3itnq12uwGUCCg==
X-Google-Smtp-Source: AGHT+IG2K6KuStcy27GWGGRtIFhcFJWGKlFGXkYuJrUG34SfK5XHDEVU/4r4gFZ0zr/dzD9yS/T71w==
X-Received: by 2002:a17:90b:2d81:b0:32c:7693:1155 with SMTP id 98e67ed59e1d1-32d43f2f29amr6131730a91.1.1757263218956;
        Sun, 07 Sep 2025 09:40:18 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77277ca2a1dsm14691870b3a.80.2025.09.07.09.40.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:40:18 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:40:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 0/4] enhance string-list API to fix sign compare warnings
Message-ID: <aL21cEM0OcnrKtBW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All:

This is a small PATCH to enhance string-list API
"string_list_find_insert_index" which has introduced sign compare
warnings.

Thanks,
Jialuo

shejialuo (4):
  string-list: allow passing NULL for `get_entry_index`
  string-list: replace negative index encoding with "exact_match"
    parameter
  string-list: change "string_list_find_insert_index" return type to
    "size_t"
  refs: enable sign compare warnings check

 add-interactive.c |  7 ++++---
 mailmap.c         | 10 ++++------
 refs.c            | 13 ++++---------
 string-list.c     | 16 +++++++---------
 string-list.h     |  4 ++--
 5 files changed, 21 insertions(+), 29 deletions(-)

-- 
2.51.0

