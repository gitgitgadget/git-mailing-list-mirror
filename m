Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DF12A15B
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499633; cv=none; b=GfVaSn+jVdPwTjP9ot7Yu5eLCrhwTKemBmFq1VR+inPCJYMtP+fvWFXu7oOgTLafb8kXzvoGgr9LdMUnSX1opeeREKINA6H9ISJu81RocF5jMPF9kYiNuiJWQ6aYOnav6mQKSjg8ilvvXRIt45yaAw2nqNLBTHUsPAEdXIUOxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499633; c=relaxed/simple;
	bh=xMgKNLIcm9lAQcxh1/wtpf6T3uVVqdO+0FTvZhtx/0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJv0R2s2UQMfXu/cLScNG3pGJBcOQQzYmVMZI3+681fzdG16ZnOtoova7xdR7G6129d5b9OxncbqvPZzCsCE8qktmhwGr2GDox6ohGAramCC76mnva1QWzha6y1VfkvK2bsxcX0+z6xHzlqk2ewlUInVO9kwctmMMHjmnvJgUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FdM0I904; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FdM0I904"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43f984101e4so13399401cf.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499630; x=1717104430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0o/xdRRLMCeXuCxFpb/wuyXk4/6G5Ivw97ADYBrdzo=;
        b=FdM0I904E9p5T8o8i6d23xYA469d7ZJeJ/XQmAMKPwPx3V6d8Zevf3dIZYGiKsEvWX
         d3PRf/PEuiGb280jxAu0b/hJc+Sr8C5lYKTzaezATUZzDE3p0PdbZk3k04QQyhhQQ1zS
         0aCCN9J6yJOQwaD8TvSpCL+mQCPZ1nWAYqUiZVp+nFP5OWY95zyYU7FF37mV5eKXQjhT
         gZCWqZNurF2ZGHEHdcJuwqirnbbGDQcLsHGEgKkzS688AXrrBiz4nwJNAf9CLVqD3mfu
         ij/0uikdrt6HQ7DAqz565ROGHtDORry7oLJGxbrLShnna9KsL+/NcWiC9Naj15exK63+
         iGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499630; x=1717104430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0o/xdRRLMCeXuCxFpb/wuyXk4/6G5Ivw97ADYBrdzo=;
        b=umxmx79iahiwFTsqm5+IBeAKWoVKeWZihsa4Q2o5k8wLAAO6KO827Ew9AEVprUYll4
         LOHFBLEW7Tx6+nu8jLTIvex+Dm8PPIYQhGWqEMRDJnGcwu0uGJLpQsY+S6hrjysixk03
         yVdq0LaeSDPTBL2BAZcxFkfVuR7gLE+1WeCsZUBfh8EpYfN/74Iw8/3H0E2Ea5dJwGLg
         D6xo8GYwbz+y+A+XrOzHpV0LXmEWHTks700pJrIopub0wjM/jGlw8grsxnrAxF+iNJGd
         3pwxcIt/qvQyQkdmOzWV0unh4BrG65yeHj89jGMKSZpphWxZ0OZtlzu1itL9gHIYB0s6
         JOkQ==
X-Gm-Message-State: AOJu0YwBoDxVY8E8WTAiuBu7r6pYi18oBOEWG+a2hUkvTzDTdOFlwPi8
	FPO+8LXxzh5MXgG7zXnjU9S+x8/qSeWhw6S3uWnoIAS6sXN4qAQ65VE8DcPtg+X6WRRH56EFj40
	7
X-Google-Smtp-Source: AGHT+IFpJwW8LXan5t4uB+8XyTFQEZblag3qsXaBXr5He88dln6xFWKU5GT3IAkdLfuLbNIyfeCD8Q==
X-Received: by 2002:a05:622a:19a9:b0:43a:ffb9:6c65 with SMTP id d75a77b69052e-43fb0d511c9mr3821911cf.0.1716499630165;
        Thu, 23 May 2024 14:27:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17c9581sm618351cf.23.2024.05.23.14.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:27:09 -0700 (PDT)
Date: Thu, 23 May 2024 17:27:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 19/24] t/test-lib-functions.sh: support `--notick` in
 `test_commit_bulk()`
Message-ID: <936f6d1b7e392367bb87a755d014633d7171f0ab.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

One of the tests we'll want to add for pseudo-merge bitmaps needs to be
able to generate a large number of commits at a specific date.

Support the `--notick` option (with identical semantics to the
`--notick` option for `test_commit()`) within `test_commit_bulk` as a
prerequisite for that. Callers can then set the various _DATE variables
themselves.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/test-lib-functions.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 862d80c9748..427b375b392 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -458,6 +458,7 @@ test_commit_bulk () {
 	indir=.
 	ref=HEAD
 	n=1
+	notick=
 	message='commit %s'
 	filename='%s.t'
 	contents='content %s'
@@ -488,6 +489,9 @@ test_commit_bulk () {
 			filename="${1#--*=}-%s.t"
 			contents="${1#--*=} %s"
 			;;
+		--notick)
+			notick=yes
+			;;
 		-*)
 			BUG "invalid test_commit_bulk option: $1"
 			;;
@@ -507,7 +511,10 @@ test_commit_bulk () {
 
 	while test "$total" -gt 0
 	do
-		test_tick &&
+		if test -z "$notick"
+		then
+			test_tick
+		fi &&
 		echo "commit $ref"
 		printf 'author %s <%s> %s\n' \
 			"$GIT_AUTHOR_NAME" \
-- 
2.45.1.175.gcf0316ad0e9

