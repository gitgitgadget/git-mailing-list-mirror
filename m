Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935D30E0F2
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135555; cv=none; b=a1wcoMDj+vhFvI1iYN+1fmFAne8fwzFu639I7ntoyR0iUqVWOy44rWWgsNTz7Q/xkKgQTDY+K0wwjZgETQqPp+sYkjvWhs+bs2pdTESOcmQRg6W33i0gbHpJoliTwRNuYxNsuUr7k7DqSrhkA9iJUqGxSlsyMV132HCDGJ5Y2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135555; c=relaxed/simple;
	bh=H5n1XQFNzNe8dsvBKtZ6MeDQ5HQG0/pzUEeJUf2VUGs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U+gp/LWG9SrXZqtIEQW2kxwpJrEyXtWpHi9yFkLX8d94mtFpgdceny0vP6xAOERUPfVx0jothXZ9eumknwhiGzugrH4SoT+bjTZ2n5x6bdqxlMe+Zz7rcUg69ODgD850q3PtJMLFF4uFQqKulWfgGJZEB3tB/XbHRqioEUPnliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDMWrz0B; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDMWrz0B"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-82621039b6bso1980895a34.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135552; x=1792740352; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tiY27Vn0pc3/nyxJodWF6QqSYyxrzWM6maTWw9Yi92I=;
        b=eDMWrz0BhaGnJ05N4V26DfOgT/H6m64a7GO7YMW0VfpaGM0riLid8rZ20RTSzKOfBE
         FCaV5qIfPZNJNu9LJu3qeUTWE9RCJozLyD2PRfqawhKu37Cnlmnp3rB0hQvGlZ6e5JD7
         kOmMn2lm66x4wliaO8F6+6SgKLL8PMMVnbSM0dlLpC6zKl3/yj2gNccJ1+lECbP7e/QA
         Myj36ki/dtYOGlvi+3tRa4VT/Xcj0rMyBcweO0dmOMntXU7naTnxHDCXvtn6ad5BzWDA
         qI/RublwsBq/AEaJ3wr9nIF0kCAidPWrT0qRAnoCaWAwEvyjWCg7K61hsZ13rSyAc4tw
         p+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135552; x=1792740352;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tiY27Vn0pc3/nyxJodWF6QqSYyxrzWM6maTWw9Yi92I=;
        b=kRTJEAAEAcKGty8wGdkJm8HZAmqxZzuEbyLlzrG/RUrQ/zcjRYK6sMBWPEezLgxeEV
         LgwAsR2Hbsy6K83+QTOZlfIRrsjo9npInQdJRaWlAnIkMmbG2UasZr9pzd9yUZ4fs+1s
         t86XfyGI0L2ULnek3dYupqNsXhcLB6GB4MdiqHpfpRhBq8oOm89sdWJmoESn0oJrGdSp
         LisXg034QBBONGNKsEXHwiCzHrpPFoPhDFKU2mVOVnfDJ5L/0DiJE+fK8IVwwtErMk/z
         IXn4p/S6WW7g39/zq7IE1IAQec6Bm8UElcWO7929aIynq8RqXIax54TB/rG0qELUc5Ky
         7Jeg==
X-Gm-Message-State: AFq9FYIcWhaHtVfXbU5bCtpIE4RtMKzrmv4qjbcrDsksxZ2QcW6xitRI
	nBY8pm/yCNPQW7YBCtxhqQL4MO+nN3r2np9g9TTVp/ePQ+eNZmEnLtzem2rKIw==
X-Gm-Gg: AYBFou0e3Jlt3ynGqPTTKDF+d2NGdky3LOPEJkQiMVPgvWtLQ0sx0zP5CV00N8B1lS4
	xlRXPTMLO/fdstmefJMYhgF9105k/7preGnwEc+Md/V/A5+3iCyr9Vdj0sX/FngNsbgWddGRmTO
	zW67aL8kU1YH4cJ2N2JsRAbq7hWMhnCsJj+9UQVVcWvE2J13O7cSDnrBY6UcceBXDOhGEF6VNK+
	oU020V3t65JBCPEXuNGBWhFV0PHj4UI5Y9wwDV6nS1SEWBByz4aAbMh9WeE1wx0Rh71IdEK6Bup
	MDh9WCBF9GEXoQIgqKGjVDkj7wO2HaEustVL7Wtn73S1cbQvoP0yLjcs+A0RHmEW7W956I+Ed7O
	chy25c252SmRJcA/MWjpRy5o5Z16/7t+cksbe9rbZa3BZxCNi90//eNTsvD92NZwHp65aeNNhuQ
	Wmnx4K4EDgXcp8D0W4BtWxptNN1uJlFtOmjcaivL10C8gTLcYYDbr8O8WZeA3F7gX59P+sqjll
X-Received: by 2002:a05:6830:258a:b0:811:a535:60 with SMTP id 46e09a7af769-83094a8b66cmr21801525a34.9.1792135551795;
        Fri, 16 Oct 2026 00:25:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.94.165])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm1206809a34.0.2026.10.16.00.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:25:50 -0700 (PDT)
Message-Id: <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com>
In-Reply-To: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 07:25:48 +0000
Subject: [PATCH v2] [Outreachy PATCH] t2030: modernize test path checks
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
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith Poojary <poojarysrujith@gmail.com>

From: Srujith Poojary <poojarysrujith@gmail.com>

Replace old-style file checks with test_path_is_file and the helper

test_path_is_missing for clearer failure diagnostics in test output.

Search with: git grep "test -[efd]" t/

Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
---
    t2030: modernize test path checks

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2256%2Fpoojarysrujith%2Fmicroproject-modernize-path-check-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2256/poojarysrujith/microproject-modernize-path-check-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2256

Range-diff vs v1:

 1:  641b9330c9 ! 1:  93cf6c12f4 t2030: modernize test path checks
     @@ Metadata
      Author: Srujith Poojary <poojarysrujith@gmail.com>
      
       ## Commit message ##
     -    t2030: modernize test path checks
     +    [Outreachy PATCH] t2030: modernize test path checks
      
          Replace old-style file checks with test_path_is_file and the helper
     +
          test_path_is_missing for clearer failure diagnostics in test output.
      
          Search with: git grep "test -[efd]" t/


 t/t2030-unresolve-info.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 9af24b1204..56a7f849d6 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -170,7 +170,7 @@ test_expect_success 'rerere and rerere forget' '
 	git rerere &&
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
-	test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_file .git/rr-cache/$rerere_id/postimage &&
 	git checkout -m fi/le &&
 	echo resurrect the conflict &&
 	test_grep "^=======" fi/le &&
@@ -182,7 +182,7 @@ test_expect_success 'rerere and rerere forget' '
 	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	test -z "$(git ls-files -u)" &&
 	git rerere forget fi/le &&
-	! test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&
 	tr "\0" "\n" <.git/MERGE_RR >actual &&
 	echo "$rerere_id	fi/le" >expect &&
 	test_cmp expect actual

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
