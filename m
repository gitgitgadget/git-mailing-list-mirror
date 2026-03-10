Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEA140E5F
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183025; cv=none; b=lqtqB4ZnP9nFZzzdwvyi6Iolpvbr6oqkK4oR9h9gphDq6+BKNCesuhsr8vs6SLgWd+qHU6LESIM8KERjBOBUx3atohJ1NWPjWgyjdUqnWvmJwFM9VFBIvvzQ1NwioojFFykzXXvw2ClZWyYieIFfoWmy2jpQeRU7wvfFjPp71Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183025; c=relaxed/simple;
	bh=iGRYv6hdkUdmVOnj1M5qrO5QBpeS3GrbXIYmQ3dR5dg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=illqJI0I7jdIfgyO2yYSXyv3R9WJnDX8jX7dO9SkNat9j+DzOBGeOrUJwAcV2LFmB9kpJIPf+TFRa4KlRAgZbtxWROKI+p15WPpcFSj/VVKSkldQ/rwQS3dUYtbCEgljPlDW6Dyd1abXt+0N185kKkeh1Jqkc5YaBmcWVB3+Shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeMJ11k6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeMJ11k6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd71fb9f06so294816285a.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773183023; x=1773787823; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH7vWT3p1ezC7r6pJYJSwMFOfZfMY0ka5//h9D0C6jo=;
        b=NeMJ11k66c/yFnd/2G/A/jIRTDAJQFYsqmje0Jxwmz6HCAGXkPp/jaUFYPHP3G+mR3
         iqZM24rKXT4uWrTcIwI4/mlV8j2NlnTFDI//UUAB3j5ZrKvMlLIAXkg3KPbVQrJfTVaH
         oQuyDlczg7p2A7iKHMPtdNnDw6W/pl5tfhgqO9Y+pZT0MHMZujjEbGZel9aMtuRqWK28
         oQ36QlrtYJFJqpCcVWJh2Uk89nVCwzgg2tmrQJaY74g5aysl0tqjjv5cUUnyovqfL6jX
         EZDXKJJXl67L+1XefcHLTwkaFB9K4VqONbhUUK3oIc/2PB7K49Kri0+B7/Vcadk97JIi
         Nm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183023; x=1773787823;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YH7vWT3p1ezC7r6pJYJSwMFOfZfMY0ka5//h9D0C6jo=;
        b=hUADwZ9ZGq1JAMrHANwUL3AVYNyDKeDdlU9hKZcXDLGWZ9zJUFKCsKfX6l0PUGMc7U
         qCCxzIlunaIjlGEJIR3IgfoE1yNpaPmq1ZM26CnoPOPBN4nHWcOwY42yOf2b0Wf3xLYi
         r383L03rsr5hE+gm0VjgpZ5YgQDKlHx7/+QPW+piUXWNkSLAFN3Yxz6pUSljglieWfTV
         xNMclYDl9R6NufCYcdIvXhLMOX6aeQdVX97Bt8niRgirtCRPb6gFS2fAUfhoQ/nlIYDP
         pfTJLDyWX1z0dbQ9xOu9wPAt3eEZswEraTxK33Nx2WzZlpc6dCNac1lZDVw08JrqMScE
         /rCw==
X-Gm-Message-State: AOJu0YyLSGPsQCMYkpvdWXeNJWDqQ4SMHWD5jDI+iwRQDVnrFg5IGkx1
	MdaDnG30zAcM+eYopSUYLp05yptoKWYDD44hIiqHcArfwo16MjYlrTGdkLeYXQ==
X-Gm-Gg: ATEYQzyhgzJoChaxD+IE0t6AErNxX6nyjBe4+9f5vz8dYBliBmvffE+L5wAxC2Com9/
	GNgN0ArKjHqFWJZvHHXadj4Ra4NIdbZ6PCpOnumFsyvjZ+6uE81/4T4JA4HL/37S52tiBx4dnYu
	U2dyH2TDVN5me/1eOXb3Wgw0OnfX4n+JtRWzupRcwdrup9D1Kc73SwGHfwF1EgqCFjoq629mS5y
	pmZ+nf6cUWseEycG3Q6eDYdccObNT2lz50G480AbPlaG7QGCq8749lfhT7Tge8ZI2hCMXoK+DX3
	PHm/QpEhwdFuC8szoCsvBkVkbJdEFDh2YtOA6Qf7ET6PLToYeQlnqrlK4r1Qm8cvfKAE4VabLK4
	XkQvkkGSnie5Q09P1y8RwBTnPhGqosa0fYEFvixefQ6AXAT3ct7Gdkz0pXG3Z9f9LYhihqrZxAb
	8ab17eXUdpMnBc2ARiSRXhkw==
X-Received: by 2002:a05:620a:1907:b0:8cd:9a1d:507 with SMTP id af79cd13be357-8cda1a2d21cmr82301585a.53.1773183023155;
        Tue, 10 Mar 2026 15:50:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda211518esm19104985a.27.2026.03.10.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:50:22 -0700 (PDT)
Message-Id: <pull.2067.v2.git.1773183022175.gitgitgadget@gmail.com>
In-Reply-To: <pull.2067.git.1773120813628.gitgitgadget@gmail.com>
References: <pull.2067.git.1773120813628.gitgitgadget@gmail.com>
From: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 22:50:22 +0000
Subject: [PATCH v2] t7605: use test_path_is_file instead of test -f
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
Cc: Mansi Singh <mansimaanu8627@gmail.com>,
    Mansi Singh <mansimaanu8627@gmail.com>

From: Mansi Singh <mansimaanu8627@gmail.com>

Replace old-style 'test -f' path checks with the modern
test_path_is_file helper in the merge_c1_to_c2_cmds block.

The helper provides clearer failure messages and is the
established convention in Git's test suite.

Signed-off-by: Mansi Singh <mansimaanu8627@gmail.com>
---
    t7605: use test_path_is_file instead of test -f

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2067%2FMansiSingh17%2Ffix-t7605-test-path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2067/MansiSingh17/fix-t7605-test-path-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2067

Range-diff vs v1:

 1:  8753a5d919 ! 1:  388d8d7118 t7605: use test_path_is_file instead of test -f
     @@
       ## Metadata ##
     -Author: Mansi <mansimaanu8627@gmail.com>
     +Author: Mansi Singh <mansimaanu8627@gmail.com>
      
       ## Commit message ##
          t7605: use test_path_is_file instead of test -f
     @@ Commit message
          The helper provides clearer failure messages and is the
          established convention in Git's test suite.
      
     -    These instances were found using:
     -      grep -rn "test -[efd]" t/ --include="*.sh"
     -
     -    Signed-off-by: Mansi <mansimaanu8627@gmail.com>
     +    Signed-off-by: Mansi Singh <mansimaanu8627@gmail.com>
      
       ## t/t7605-merge-resolve.sh ##
      @@ t/t7605-merge-resolve.sh: merge_c1_to_c2_cmds='


 t/t7605-merge-resolve.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 5d56c38546..44de97a480 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -34,9 +34,9 @@ merge_c1_to_c2_cmds='
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
 	test 3 = $(git ls-tree -r HEAD | wc -l) &&
 	test 3 = $(git ls-files | wc -l)
 '

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
gitgitgadget
