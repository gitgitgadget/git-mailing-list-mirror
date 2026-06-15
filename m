Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887AA35AC12
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510042; cv=none; b=IALacYbB3OH0unkQjTJH2xNxsC/iqUkVeJntNt07WXDEw2SWkS8w1fpHeh5Qayimn+Ku6GrQywM3M/UG2y1DLSksl9O1n7+1lCCH363Jlt5eOWSG8FaXUz7VyY1OI6HrD4ggqCZVTNJ2RxedAGPxIwfhYQBgDpjLBVxna2+LowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510042; c=relaxed/simple;
	bh=kBOuO8tyMUTMWkL8nPbn6UsYXgE1umAhcfGsmZ/4M2Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=czRHAur1Y1O6hzBWEt8jTLiz0CKiWpRNChirD/7VnlRhJvwJOh3vjAU7hYZb2wVeV4u8DLBSYA66FCLNHBTnMzcTKDFrUYkqI3YxYLd2gT7qdwzaEE8yCMJfzj3MNDc1QugfSwhUTWt6bJ18qUtrD1idmuTMPWV9ynG/6iTZ6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr2QVYk3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr2QVYk3"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8cce77eb087so27000476d6.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781510040; x=1782114840; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f8aRXfLXLL1xVVfknTkorduC9rbd0TMeiBOxxuuxBs=;
        b=Qr2QVYk38vMRBme7w30Z1BMooL2gKhj/aKfN6pBEnl+q1kEzPnOaXPBBS/OrMrUw2q
         AC2PFMd5O89khdN8pS8acUP6J56LTGQZqrhdGSDdwbPj+RqGdNsw39fg+hWemYNsOAcA
         9L6qYWFH6NiM7muemER9EL0JVl3oxN2JTdm1iHd7HtupahI7uJ26MOJaPES/aMKgVXkG
         acP5lwIEOAWmObXWQ7cBk9YTexDh+Z31cUQnMAnT/l7YWXOSQfiyj27sVW61mp6WQFkC
         V8c+Es+xKL9kv1Ir507zmuOm+P2pYAJmwK8bXXn08XTK0RCltGqayWfg6Wn/Wna5BEWE
         gidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781510040; x=1782114840;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9f8aRXfLXLL1xVVfknTkorduC9rbd0TMeiBOxxuuxBs=;
        b=QCyxPKPy+jRTBR9+YcJtNPpV55/8e8FLVxY+CCe2ub3r/WvavOEL/aNvzdnx5Nk9nQ
         olW+UiIZ4jiLaAB1CoXUx/gcJ0f7NfRvQxYtgMpm6+lbfwquG2RkaCOmQWQ4JK+NoSj3
         GqliUc46hq6oRLLR6wXL/qSgXWcTVf4dB0G8RQJwxxsiCCc0sYnTiB8P3XsK6uhbC1jD
         dfym5s7nd92JgFjTYYkjM51dN3G+NQeto8i229BSvwrhF8vjX680t25zT1DKPH5Yv4Pu
         CntYH+LcOUKgA4DLxWQ1gG6fj1BzcR0BjOD5n+mDFFztxiK41OWXkSwEAfY+dXSzaxVm
         H09g==
X-Gm-Message-State: AOJu0Yzye57aj9gt+cQbsrBveXl+g6C0kk5HbRPuQnbHvwocO+pY+Ehm
	bjytgqfWKAMGT8sTPSTv9XUaqshi9t4MhWTyQxkDKWLYzReLs/NOC3TchBAcaA==
X-Gm-Gg: Acq92OFcGgbGuzp3qb/zExhLTq5lwbcbZqjQLZyHYDQ8HYBSN5+dsDftMxoAeCx9xvI
	DocDPBuji/P4RS5jlQ/Wtk+vIp3d84wDd7AaYw7/YCMRftOlYRsSvrVFto28mciMR5ksBrQJBaY
	Dm3z6QYX/H8vKfahM8tLs+NL6OXwjeL77+stGDMEbGyT3Gf3tX3BdgXnWFryw3VNmdwLD2oG+gw
	MhUfTTPoKX3XLzl4G5WJISSjGyn3rXNc6XXPo0fGATgCjO6u6Z64jjL/yhitD30plC2/oPJj/eE
	ZnxDw3wEgR9ecr0nOPREcsdmZcG/qCn1IqJt4gbylP10FBqI9jt5LvflOB2f1HXmUc36AEnUqnN
	aRYC/UeRhVzxiMZFe3MeOgLqXlfzLEUFym6zR9hG++Rkg0Swul6GOZIEMiVxdiH4frKDUV+TfoT
	CKalX71DdQY/Hf5q7HKsY0ehpysA==
X-Received: by 2002:a05:622a:4d47:b0:517:6c96:8f1a with SMTP id d75a77b69052e-517fe1aa15emr195290351cf.10.1781510040395;
        Mon, 15 Jun 2026 00:54:00 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb6428a6sm118266561cf.12.2026.06.15.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:53:59 -0700 (PDT)
Message-Id: <pull.2151.v2.git.1781510039164.gitgitgadget@gmail.com>
In-Reply-To: <pull.2151.git.1781497525828.gitgitgadget@gmail.com>
References: <pull.2151.git.1781497525828.gitgitgadget@gmail.com>
From: "Koutian Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 07:53:58 +0000
Subject: [PATCH v2] gitattributes: fix eol attribute for Perl scripts
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
Cc: Koutian Wu <ktwu01@gmail.com>,
    Koutian Wu <ktwu01@gmail.com>

From: Koutian Wu <ktwu01@gmail.com>

The *.pl pattern currently sets eof=lf, which is not a built-in
attribute used for line-ending normalization.

Use eol=lf instead, matching the neighboring *.perl and *.pm rules, so
Perl scripts are checked out with LF line endings.

Signed-off-by: Koutian Wu <ktwu01@gmail.com>
---
    gitattributes: fix eol attribute for Perl scripts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2151%2Fktwu01%2Fkw%2Ffix-pl-eol-attribute-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2151/ktwu01/kw/fix-pl-eol-attribute-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2151

Range-diff vs v1:

 1:  92ba4d499d ! 1:  f4b4ca30c7 gitattributes: fix eol attribute for Perl scripts
     @@
       ## Metadata ##
     -Author: ktwu01 <ktwu01@gmail.com>
     +Author: Koutian Wu <ktwu01@gmail.com>
      
       ## Commit message ##
          gitattributes: fix eol attribute for Perl scripts
     @@ Commit message
          Use eol=lf instead, matching the neighboring *.perl and *.pm rules, so
          Perl scripts are checked out with LF line endings.
      
     -    Signed-off-by: ktwu01 <ktwu01@gmail.com>
     +    Signed-off-by: Koutian Wu <ktwu01@gmail.com>
      
       ## .gitattributes ##
      @@


 .gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 556322be01..26490ad60a 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,7 +2,7 @@
 *.[ch] whitespace=indent,trail,space,incomplete diff=cpp
 *.sh whitespace=indent,trail,space,incomplete text eol=lf
 *.perl text eol=lf diff=perl
-*.pl text eof=lf diff=perl
+*.pl text eol=lf diff=perl
 *.pm text eol=lf diff=perl
 *.py text eol=lf diff=python
 *.bat text eol=crlf

base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
-- 
gitgitgadget
