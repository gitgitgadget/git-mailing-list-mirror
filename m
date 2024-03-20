Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532686ACB
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972359; cv=none; b=M5viu4txdGdRdSZpzR0b/LPNUSzsZM2AqEy7x7KM14Ff3LVjwVVEvM7ENvIDCWhey/QJJRZGeJ+gmEhS5vPgK5IDpBn+r+p/BxiviA18D5meNQEgFh4SuGHQgxPSs+FzcTSQJBwRMWzSgoOSWW1zk4/gSvx0ziv50VP+vwyQlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972359; c=relaxed/simple;
	bh=GlY92Z4ds5nCsWYJoGQMI6CgCmEoD2F7qw05/3ktzI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N52T5T5q3GAPxiB95sTi7kITtfr773h3qpm/dRdGi7c1h9srhCIh7OjHLvXvOwbadMbSGS95MqdzVt6Dt+510/2vTENIw+QlEikiewwD+07gbMDHmP4wImOGNG/X5KvuvMiY4Yrue7td7xv3HyAw+wvkF89XueSFh+6Wt6nyA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uXBYO0F0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uXBYO0F0"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789e4a4d3a5so23346785a.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972357; x=1711577157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsap2U0PPPij8jTyogEOiI4xnjSxw193AnQxICyLyzQ=;
        b=uXBYO0F0H5PNyQqQy038H3MkIHcDqjkv9niacvVlevZ5JRG7p2bma+dzT0FM0BbE0A
         PmW3sIrMyCEJTw3mQIowr2eSGTYLqP4yzxtb7PDsDB7mndCgOYvbeUBKdTYYJkz2ds5o
         wu46148tKgSs8vi29h4GxqMAuCdSSvjBmnu+QWLudS7mU67+1eFsKMYL8oHmKCWAAiDx
         wWGpI3/QvUC7X1iJ3FSTvg6yXJwkyO0QV1Iz1w01dC0XxgDi2HDcnhu6n7P2XZGjqLjI
         gR6v/kTfpZwot+Ok0kVjvlKwUMS3YBx5PIObNUz/QUTyZqFigImpaDSQWmdxjp01luNQ
         43Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972357; x=1711577157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsap2U0PPPij8jTyogEOiI4xnjSxw193AnQxICyLyzQ=;
        b=f4gVbfStG6fPmHCVtQ+O94jQEO44JVor+lPNPiEfwiyoDz+IU3iDwaS3aEf307LJFx
         WYafPj9e7lOVWtHyFfWv6vYO1KMFmIrJDL7RRjI3TBZtGHVeS1L5K5CxLkhR6OcbahHg
         1vAIImLCAeC6/jRrhEuMMJQX5wF/GSiJ4O/rAF3yFJSHAX0w8gMfYBG8f6VZa0GMgklg
         BLxVOfZ6OhnLHyOhGhL0R3Ap/sVE2FfF/MxlA2lTfn8Onm8MevdXkP0ccbF3VQpcHdFv
         rEq0oP9ffwt/+cN0tG8wxZCgPKib9iTp8O7s1ks0xU1pHg/k/2vvvs7dzuKkJ7zCQDbs
         nnGw==
X-Gm-Message-State: AOJu0YyFgHZzrllygHgTIV9j5MDvSDrqWH/587Q5oU79J1aeaLKm8SF+
	dwEMaKHh3Fdizhsb00OG9u2WDOaehX2St+doCOYssey4IUXrTxdalQmEFBoN5DtP7C6LdiGQ3pI
	zxN0=
X-Google-Smtp-Source: AGHT+IEeOHJTXhWkiebLJGetAl1qSnFy3bwJPkFHllifmAy8811j4zJ0nGCiK3gaNxe93RxisGSgww==
X-Received: by 2002:a05:622a:58a:b0:42e:def6:3d31 with SMTP id c10-20020a05622a058a00b0042edef63d31mr4064052qtb.49.1710972357096;
        Wed, 20 Mar 2024 15:05:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5-20020ac85cc5000000b0042f01390d5csm7898784qta.30.2024.03.20.15.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:56 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/24] t/test-lib-functions.sh: support `--date` in
 `test_commit_bulk()`
Message-ID: <7d3b88e6fd68724c1a984396be64e1043411dcb1.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

One of the tests we'll want to add for pseudo-merge bitmaps needs to be
able to generate a large number of commits at a specific date.

Support the `--date` option (with identical semantics to the `--date`
option for `test_commit()`) within `test_commit_bulk` as a prerequisite
for that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/test-lib-functions.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6eaf116346b..312cc5d4c79 100644
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
@@ -488,6 +489,12 @@ test_commit_bulk () {
 			filename="${1#--*=}-%s.t"
 			contents="${1#--*=} %s"
 			;;
+		--date)
+			notick=yes
+			GIT_COMMITTER_DATE="$2"
+			GIT_AUTHOR_DATE="$2"
+			shift
+			;;
 		-*)
 			BUG "invalid test_commit_bulk option: $1"
 			;;
@@ -507,7 +514,10 @@ test_commit_bulk () {
 
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
2.44.0.303.g1dc5e5b124c

