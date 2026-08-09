Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC40355048
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267398; cv=none; b=PNiI/CSwZd5nXhI6j2PB9XGTBh5tPRO6y+H1cLU5CFy0bjwk9C/5Z9pkUw3xWUi/W04J+BXDa14V0mgm36wIdidi6dovoLPZCqaTLebuhcoVbTrSo/EjwuYsv9ZVOaX48T95/PoytVBS+SvGblR8OsOUB/QD+SHZt8PlhnHFnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267398; c=relaxed/simple;
	bh=VSmJ7wJ96Vp0nCMyCfb1QA+5wnmIbDqyYdpNHjNhg90=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hw1/ZmzNLHkkC8agW1osVQp3QbCp8FA8WXemnB96t2Evd2enIeJKYf4Z+Mwhfuc+gJ5xACiNLSSjTiXzllbo859JEH0O5jdHJEpTjDr959TnTfcYyVZhiMDXJ2idEP30QrJ/n32ulPWbaGoM0bRdxM0v4vY2hZfcRAiyyJ5gUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcCGFZvj; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcCGFZvj"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2cce930cso9620751cf.0
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267396; x=1786872196; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X1yrxk/MaixHwVYpHGsrOaNeNPhMTfea/whksJoX6Uk=;
        b=qcCGFZvju1X6z3RU21am2WHZB3mw5WC+Vzkqyrq5uig+KPIQMkt7IIyV4GLS7wHAT6
         KWJdRtDyBqiAKQeGMtLzovPzWqB3UaEff5+QAewHeDX4POn5UDqLIegNNSg7vNmLic5I
         6biFJzt+1yb5Q5v9ikAJmynez9TiHD5W2LAiQozzhcTas3eQUE4V87p5ZZtoctevfeCj
         l59Q4KLl5mZu92BIQG7U0VNiEQnBohr75dmaCoIqg1mW20eMwI2yHNP7U0Ia5tIKUCyl
         Gwje/FY75w36AoVAltbS0SZQd9zxBvHbdhAU7Z4m+xZk8rw69RoMzbjnGmBMUA2nVYua
         eZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267396; x=1786872196;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X1yrxk/MaixHwVYpHGsrOaNeNPhMTfea/whksJoX6Uk=;
        b=oXBz1D/foSfpYIQp7fpIDbbWQOuHmkW+W1gxU14hcFyXnhLOjjPQ4P32VJ4YcYD+DM
         bmJmnqYAN5BmQksW1GfNLSaPwEeDoFb/TIPeJQaRwk/OxNtYND8MgWJBVbKEwVn6DuKs
         pqy+Bbbxra00wK6izUcSsCFHdcymZSZwnT0Fn+XQgEbQevmER9XeE6e1UvmZPk5hMQFq
         MU73a9CT7nCBvjEkEVPx0B3SaL+8VJYWGEATd5UM42uv+f36p2mDBoABMv6Zae5urdK8
         CUc7WrwMa4VwwezTzHzgdLVXo2E1df7bllLgVffzo515kTlJCNxpB7fzx/sX6BM4hXWR
         d+hg==
X-Gm-Message-State: AOJu0Yx/OC8OfarED3lPW0agFXLrx9HYLA9F3nTlTr7voewG+UJvhy0F
	MYbuEghBT/6/+pnrfVg69CzLVqAxoNm+5BmsUmMjJbmlC5xOncQcBqS5CK76aA==
X-Gm-Gg: AR+sD11ajvaSWdxImhBW1JwCgeL7+9lZI++iF/QnOli+XXCCgWNiG30ynDRxnup3iid
	moNU98DOtPhBrP3YKeetlrO7dSuPJGkJxMAtH/foH+CvMxRdeLfNN6LByJlPhmu8KKkz0iK5iA6
	hIsw3UZlD5Y21gUyXgWmiQzCtj8tEHKK35iH7YzUkaUUHqY5j86pubxj48YJZiCgttlXcfw5N7T
	+uqK2p23+qqf4j13dQs37yV5UGLATUv4v1DYP1hcSeFUXfgLk7+DOEfRjI3k30Py8D0lbkaUgRz
	Ipd/ZIKbNj3HaWqV6AtFv6Dwp8O5kHy2DXfmNVY1tEQaEHYybFa5jqix87HhpeGesFm5Ep/ifVS
	ZQmspmaoanVzPGoSfsaJV6aB19l2DuKpOndE3Agwh8Ot1kLEwenzcU/8oj7Px5uKwzr/z6Cpj2V
	60MdSF6f+nJgSnCGwrHtAujF8FOrnur+GJKhJlzZ3lKem0+IS850Wt+v2C3R9TxE4b
X-Received: by 2002:a05:622a:261a:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52d0b06e247mr243597361cf.12.1786267396189;
        Sun, 09 Aug 2026 02:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.210.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165efd05sm47955931cf.20.2026.08.09.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:23:15 -0700 (PDT)
Message-Id: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 09 Aug 2026 09:23:14 +0000
Subject: [PATCH] send-email: clarify missing subject error
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Explain the required Subject: prefix when a message file has no subject.
Terminate the error with a newline so Perl does not append its internal
source location.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    send-email: clarify missing subject error
    
    Explain the required Subject: prefix when a message file has no subject.
    Terminate the error with a newline so Perl does not append its internal
    source location.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2375%2FHaraldNordgren%2Ffix%2Fsend-email-subject-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2375/HaraldNordgren/fix/send-email-subject-error-v1
Pull-Request: https://github.com/git/git/pull/2375

 git-send-email.perl   |  3 ++-
 t/t9001-send-email.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bb8ddd1eef..4d76d53c49 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -863,7 +863,8 @@ sub get_patch_subject {
 		return "GIT: $1\n";
 	}
 	close $fh;
-	die sprintf(__("No subject line in %s?"), $fn);
+	die sprintf(__("No subject line in %s. " .
+		"The first line must start with \"Subject: \"\n"), $fn);
 }
 
 if ($compose) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e9d814a34a..a403dd278b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1422,6 +1422,21 @@ test_expect_success $PREREQ 'detects ambiguous reference/file conflict' '
 	test_grep disambiguate errors
 '
 
+test_expect_success $PREREQ 'missing subject omits Perl location' '
+	cat >no-subject.patch <<-\EOF &&
+	This is the body.
+	EOF
+	test_must_fail git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		no-subject.patch 2>actual &&
+	cat >expect <<-\EOF &&
+	No subject line in no-subject.patch. The first line must start with "Subject: "
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success $PREREQ 'feed two files' '
 	rm -fr outdir &&
 	git format-patch -2 -o outdir &&

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
gitgitgadget
