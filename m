Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF24DEC3D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547244; cv=none; b=aQ1SzJTjr/00ho3n24K91AOsX1lY1OSW8BOfQnSzTWF7zR0+nBYk/jlu1VEBzs0BXaOgPF0RoMEPPh9GPdEYnTlLn2RsTlncbwLXxUTkryC7LAteAyQpDQ3mgNZA+mSogA/h7+v6Zcxx4ME/qxkf3u+5d4XBztduEcFCGjxHe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547244; c=relaxed/simple;
	bh=AbvkcuA1vOKjb84e/sSf63w43Eez3tLnVnd0vN1OJx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HugYQqTtjC95lBE/Ljz7qiFeZKkD704Ga2AHeOAQwPRkHsVUe7NhVlqUmQO60a5wDRX513ip9AsYnHTnyKRllYF2DOJs58uzXUNLlN8Zjz08pHEZuLm2Zo6WMn8A2I6SWgFEcwZt4iYv50ClAlpszSwCQJh38x21fra74iQ64DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqL2UDZD; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqL2UDZD"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48e94879f02so1533294fac.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547237; x=1792152037; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=HqL2UDZDh66D+RSti1+Um8UvB56vlbam9uptXRFLvvcoUFC+Jl+S4B8Kj36VhDqsdb
         6aPLYSdZgxsxxBzMiTgtNTxz3fYi5+q4X/GkqVUeBgaTnqe2k5AqFWm7Ys9Qw+DxRaWh
         E+foHaQmBXjMI+c20N4kGTsNCfbV1EGA3e1VenEtl15EHWrUllfNjjU+o66KwGJrcrTj
         DR49uxk16dWkFAlShFV+Pt7YQ4RaJr9AFSL39X0UDZZdD4UTwgzSZmt41xbYUw+cOvvW
         VRHL9VlzCt7QtfqNM2zI0XhYaiZnudyKz+GQAqr8aPTB+5aur8R/ZmEZKvlUK5zFutBI
         jrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547237; x=1792152037;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=XIOQHPzyElcg5P6/H6mvz+ymZlwAyZHaQcKHcBKfrMtGQGucyySUBTS2MWc72Y/wmQ
         Nvio/WBKHDYKXR0WdJrun+K4Evc0eA6GMkuTuud/vJMt8DE/KwZ7fdpkxHwjAFKrJjtv
         lPhvzbqBUpc7Xci/EP5LDKoYafdvg89m9q1tG37PbvMUXhVWYZk/dsfzcj9nqLfnPwOP
         BPtqeh4UWJEloxsyVd7DDdIi8dd0r+nvVp+GHoQhxu0bUd3jvkEPkanWaCKleqAwwrc0
         7XTFzJJwPBSa8GjfLjRe81ZRCALcdN/NhfJ3XRlEl9xkF3ok9pYmuOhQOJLlSpuk4rug
         VTvQ==
X-Gm-Message-State: AFuF++nTyu9mXdGA5f9HrGaekPkjPKF2QFyDPjbZzsEPqjvWCNzTkoyV
	XZzQEH2JUB3H4kRMQ+w/bfPt5IDPh8FOnK7oHeQBPPZzwNyD5YOufyJ3yFN9bg==
X-Gm-Gg: AYBFou3+rBTBIVS3Sib5rXRxyyi9y3jtRcp2wv6ZNxbw1aj5orKGYGg36zOAiBu5lFv
	YOE577gwZcXHDTOgXNPG/OxksuBw2jSOmOH8YTQRJw6lFSIr9QxEFcYPboXgOOyZx8SB47Vm6oa
	ISctGb1Y3c2q91XRA+VuJfH3K7L1QpPB0WLULH+5Ul1EuJmBWvhOrLQrIWFMFHTjJfqErz5mlpe
	+BfyivXXlBd1tHiWwT0n2H+MP1x6GYqluq/1gQ63eSF6oMMgDkyMllybKQDAQ7PH4BihzWTlt8h
	gVorG6XIVjp5kQuARThH19DiQI0vtt1OK4SOqfSHsvDj2XKa5LH6LNYxhk+ZwM8jdveKHXqBPIL
	tg6KEb0cQqzj6Vn3ZWx0gN6RN2UEKaGLp8kBe9i7D47cJVdH1cfT8Vkn2yrHD/so3yKdJjP8/R7
	08D9otlvJ1NEkw27X+XQMPtsLlYGEc3Q6KdtxS4trXEHp9F4uYv+BzY3PlM+fJJ5JEMMcWP+OHD
	bM=
X-Received: by 2002:a05:6871:c923:b0:48f:e0f6:c45f with SMTP id 586e51a60fabf-4a2a8a02a64mr1222505fac.45.1791547237123;
        Fri, 09 Oct 2026 05:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.148])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a8582a95sm1457942fac.11.2026.10.09.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:00:33 -0700 (PDT)
Message-Id: <ac77db6762c55eff9b6883eba98bfde3694aef24.1791547213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:00:13 +0000
Subject: [PATCH v2 6/6] doc: git-pull: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 88f4fd3926..73f6d460bb 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -38,7 +38,8 @@ or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
 want to handle, you can safely abort it with `git merge --abort` or
-`git rebase --abort`.
+`git rebase --abort`. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
 
 OPTIONS
 -------
-- 
gitgitgadget
