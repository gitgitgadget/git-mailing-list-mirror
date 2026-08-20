Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916830499A
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264421; cv=none; b=sxVFjQcxSvIDNT4r1clUblaWJX6kCpTQ4pxj8tkkbliFuSq9iOSji8E7izUzNI5pksHvtR5Tkpaar05pUYNuZaJHBGRQRCMoUjz+AB9PxR+xg8i0x8sXtr6sIrxkwf6SedrEYBs17WGzA4eH/05jPEMfZvP2r3y2KbP4S9gFiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264421; c=relaxed/simple;
	bh=OJS5Z0iHOdJUaRpyKzc+Ki4xW4XaHXCLtPvoT2m9hMQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mOOxdu00wMDVd0qasuJDYGyM5hNNvHz0l0DjoVj0cQsSld+osjMRkFHDYhl57idAru7ETP22k+fZiGeDE0iHalTyuRJrK0BgzK3rOdNa801SmUqbln85MdCJgBShTLyxxqD5vubbfryK2hsTyom+jXVVYLFiWULbJPbb1qGmtOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJPW8ILa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJPW8ILa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d032846c95so4630565ad.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787264420; x=1787869220; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8BYYFkrbgG89tlutQ1o319MeBW2tD1RHFRdEH9Vs9Go=;
        b=PJPW8ILa/Dq62Jb5GbO/ueDp8aAJbCDulDyoWblx+OZwlm6otJ0VTYApHPoNpeqyOu
         +pjCdpevdQricU075PrkWxGCDtkBCeqmYrhMkQrw3XYQpa2pzWG+S3CFNwmQbejQsLjK
         Lnepwzn/NHvzorhkxf0m8DIeDbOhLYn+w3ZCSfvaoHnnff6RXXQ9BOGavpaXjyOohuf/
         HuEMjguIhXRRNLXBUp+i7ey5OicinEi22waov0jMAVvclQNrAX/junxLcDxuySAh81Id
         S1f0Inlsaz8JSZAmYP/CnO7aIH6K70zjyZb3xpHQBzbkduDQjHQ3Q1jzT5GDOeHP6Ki5
         m4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787264420; x=1787869220;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BYYFkrbgG89tlutQ1o319MeBW2tD1RHFRdEH9Vs9Go=;
        b=b+FfjQOJiVK5F/5GIgVAxETvSFJRGxwbWSce8Ilme6Xo+uAZzs5hivevprwNoBk+MK
         qfpvM3hIoMTudOXrjP9PuesTcImWEu8InFnHxvsaX29Z47S9cQylI+u6J4E+Vv1749YP
         odFHr3SpwmZ4D/JOdjr4pTxJ/vQsgVFCfupikgTwBEOCQLbVLzUElfu+Jg2kwIfzZq7S
         WghyNckaiv/tFhxhcOMSVXHqHGN1uC4+Ogvk5gPxFu5KKlRxBg+PADhm0X/TCCGbbnKQ
         k+9eAB/1x7F6h38L8MCkvNXy0qJjwnnw8/DDGP8GGucBVEUmGvgIZtp1HQmAMznfzSTT
         QoFA==
X-Gm-Message-State: AFuF++kbcWXRgfwSL9p53kth4CarAVZVN0pgTcoV9ZEcGq9mW3g7gA1J
	QuwmsgD4Gct2B/uwYGNI59KjzICt6Epg37nleDpI6ABh3FewZBssyGdn7zM+Cg==
X-Gm-Gg: AR+sD125XdyVfls4zHeRSS2ux5h4RyVkWJYbYXP1vt5oiuid7OdLJmkMkIH63BizZLm
	F0nLpKRyE8sGVkOsSWtSWUu57xJf0TDYg6G2rbZGefORB8FJjQUSDT3C04q0U/6jhkkVjgH19x2
	6r5L5t7hGCBE0SFNVCdYe94hHKlPRE9xX9kxvgI91Er84lliVhMyKino+afuBSWk6MfEQ46vFe7
	/qj8b+BX68an+MzIM0QY1F88ID/vzxr+MHoD8oyTRk5qqPrF3XucSCmPwQ78SxjEJE2/v3GTRzJ
	oDvyLwbZiF1qJgx/ZU7G4CZh9AiupLLMaLfMg39drJDcTOUrtRx5x9mIt1FFpclXNubQkYkpUNF
	JoXMfImG+Wu5sZ9WVVswfj7FPqrKt4I1zOLdz5kNIzonJgwWk/r4F4ysTYRtPM6O5DQgZuemyC/
	7fmGIGia3IDE9BqsBXtchnc4SMnvW8BCssz30bAsJaeqqTf69T7aSj5X7w+7JXCr90DWTR2LLsJ
	McS
X-Received: by 2002:a17:903:2407:b0:2d1:1d3d:97b2 with SMTP id d9443c01a7336-2d64b1464dbmr35625185ad.11.1787264419474;
        Thu, 20 Aug 2026 15:20:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.241.147.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef6ec40sm21234901eec.7.2026.08.20.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 15:20:18 -0700 (PDT)
Message-Id: <pull.2203.v2.git.1787264417682.gitgitgadget@gmail.com>
In-Reply-To: <pull.2203.git.1786653837190.gitgitgadget@gmail.com>
References: <pull.2203.git.1786653837190.gitgitgadget@gmail.com>
From: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 22:20:17 +0000
Subject: [PATCH v2] t1402: test forbidden characters in refnames
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
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>

From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>

git-check-ref-format(1) documents that a refname cannot contain a
space, tilde, caret, colon, question-mark, asterisk, open-bracket or
backslash, nor the sequence "..", and cannot be the single character
"@".  Of these, only "?", "\" and ".." were tested embedded in an
otherwise-valid refname; "*" was checked only as a lone character or
with --refspec-pattern.

Test all of them in that embedded form with a single loop, and check
that "@" alone is rejected even with --allow-onelevel -- where "@" is
otherwise a valid refname component, as "refs/@" confirms.

Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
---
    t1402: test forbidden characters in refnames
    
    git-check-ref-format(1) documents the characters that a refname may not
    contain (space, tilde, caret, colon, question-mark, asterisk,
    open-bracket) and the rule that it may not be the single character "@".
    t1402 only exercised a few of these directly.
    
    This adds the remaining forbidden characters in embedded form, and
    checks that "@" alone is rejected even with --allow-onelevel, where "@"
    is otherwise a valid refname component (as "refs/@" confirms).
    
    Test-only; documents existing behaviour, in the spirit of 919eb8ace
    (t1402: check for refs ending with a dot).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2203%2Fnikolauspschuetz%2Fns%2Ft1402-forbidden-characters-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2203/nikolauspschuetz/ns/t1402-forbidden-characters-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2203

Range-diff vs v1:

 1:  f254db5b09 ! 1:  cc013499f9 t1402: test forbidden characters in refnames
     @@ Commit message
          t1402: test forbidden characters in refnames
      
          git-check-ref-format(1) documents that a refname cannot contain a
     -    space, tilde, caret, colon, question-mark, asterisk or open-bracket,
     -    and that it cannot be the single character "@".  Of these, only "?"
     -    was tested as a character embedded in an otherwise-valid refname;
     -    "*" was checked only as a lone character or with --refspec-pattern.
     +    space, tilde, caret, colon, question-mark, asterisk, open-bracket or
     +    backslash, nor the sequence "..", and cannot be the single character
     +    "@".  Of these, only "?", "\" and ".." were tested embedded in an
     +    otherwise-valid refname; "*" was checked only as a lone character or
     +    with --refspec-pattern.
      
     -    Add the remaining forbidden characters in that embedded form, and
     -    check that "@" alone is rejected even with --allow-onelevel -- where
     -    "@" is otherwise a valid refname component, as "refs/@" confirms.
     +    Test all of them in that embedded form with a single loop, and check
     +    that "@" alone is rejected even with --allow-onelevel -- where "@" is
     +    otherwise a valid refname component, as "refs/@" confirms.
      
          Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
      
       ## t/t1402-check-ref-format.sh ##
     -@@ t/t1402-check-ref-format.sh: invalid_ref '.refs/foo'
     +@@ t/t1402-check-ref-format.sh: invalid_ref 'foo/./bar'
     + invalid_ref 'foo/bar/.'
     + invalid_ref '.refs/foo'
       invalid_ref 'refs/heads/foo.'
     - invalid_ref 'heads/foo..bar'
     - invalid_ref 'heads/foo?bar'
     -+invalid_ref 'heads/foo~bar'
     -+invalid_ref 'heads/foo^bar'
     -+invalid_ref 'heads/foo:bar'
     -+invalid_ref 'heads/foo*bar'
     -+invalid_ref 'heads/foo[bar'
     -+invalid_ref 'heads/foo bar'
     +-invalid_ref 'heads/foo..bar'
     +-invalid_ref 'heads/foo?bar'
     ++for c in '?' '~' '^' ':' '*' '[' ' ' '\' '..'
     ++do
     ++	invalid_ref "heads/foo${c}bar"
     ++done
       valid_ref 'foo./bar'
       invalid_ref 'heads/foo.lock'
       invalid_ref 'heads///foo.lock'
     @@ t/t1402-check-ref-format.sh: invalid_ref '.refs/foo'
      +valid_ref 'refs/@'
      +invalid_ref '@' --allow-onelevel
       invalid_ref 'heads/v@{ation'
     - invalid_ref 'heads/foo\bar'
     +-invalid_ref 'heads/foo\bar'
       invalid_ref "$(printf 'heads/foo\t')"
     + invalid_ref "$(printf 'heads/foo\177')"
     + valid_ref "$(printf 'heads/fu\303\237')"


 t/t1402-check-ref-format.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index cabc516ae9..9dd64662b2 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -49,16 +49,19 @@ invalid_ref 'foo/./bar'
 invalid_ref 'foo/bar/.'
 invalid_ref '.refs/foo'
 invalid_ref 'refs/heads/foo.'
-invalid_ref 'heads/foo..bar'
-invalid_ref 'heads/foo?bar'
+for c in '?' '~' '^' ':' '*' '[' ' ' '\' '..'
+do
+	invalid_ref "heads/foo${c}bar"
+done
 valid_ref 'foo./bar'
 invalid_ref 'heads/foo.lock'
 invalid_ref 'heads///foo.lock'
 invalid_ref 'foo.lock/bar'
 invalid_ref 'foo.lock///bar'
 valid_ref 'heads/foo@bar'
+valid_ref 'refs/@'
+invalid_ref '@' --allow-onelevel
 invalid_ref 'heads/v@{ation'
-invalid_ref 'heads/foo\bar'
 invalid_ref "$(printf 'heads/foo\t')"
 invalid_ref "$(printf 'heads/foo\177')"
 valid_ref "$(printf 'heads/fu\303\237')"

base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
gitgitgadget
