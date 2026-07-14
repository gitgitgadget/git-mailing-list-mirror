Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582F25CC57
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069354; cv=none; b=jYTQXwhSIK5XtuumAJ5wDyv1sWCWiWrJ/5qsT+0NaXdrGYYhpOklKindgKGyytQvxzk1QX+cBvsfw5Eb5xwqcjaRCqvFP6A8yYy3YHJutbKeVfjaiy0jXgjqj5w0Su1q9jBh42U7mO0kDZ5gsxg7JTgnwBglw48FzHDvCkZMEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069354; c=relaxed/simple;
	bh=Bw6RRPOxvB/XgWM8bOr/THxwZ60aPAOn6N924jU/Xx0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tKQk7zN5AJTIz4uaV3GwSR1Y69xX9xZuayCaBQEhb5hp++p5e07aQrKoGTggVWMzU5C9gyW2rRv0e4UkjKEV6oj6qyDpMhIqj/F26/vYtrTZthZS8uMN2pmN/9CStou7JeSiQxnvoiDsgOD8uuUlVPyS8Y313lYPeebbpcmYJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh71j93b; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh71j93b"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a397db52c1so2517380eaf.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069352; x=1784674152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=po/WE42MbnQ1mFJEpBbDU562tsK3HqFI/2OZaylzs5s=;
        b=Vh71j93bHOSZPlTAtFDeKAUdbMqjt2zGK1tw82nczPKnBNzu60VYsA/eI9cB5jv6/a
         AlPVwDUmJhMLXfxCB3ldHcHOMgZOUS6szDp5wTyIwYWwFlCP409i1ogb1r/oqm/Q6Yop
         MznPDn2Wh9vkG0gCs3Bp2A2S5rjz3wyrHfNFqiQNIUZSdcbKzB+XPjKukfPeJLNbdDyJ
         Yz5FyqT07WEXRSs45+4ILbPP3ddIAd0j+FSJ/BlKJyYt0S65rcXZUAyaEkxQMUiGkvBn
         mSfNLBapBXQTlhc6ytu9K4jfHUGK+E5iyRod56qXJQgj6KxKKK/2C6UM/MQIOpxFvPmH
         Y6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069352; x=1784674152;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=po/WE42MbnQ1mFJEpBbDU562tsK3HqFI/2OZaylzs5s=;
        b=VGjyRJ3rXJFVD7lmOwpnxGqYpuVTLTKTIgW+qKDWie6IhGvOI1e84D683QiVHpMHl/
         /ALcP6AioZuybX23yj6l2QtZIAuF+XNDzwVbHCTH/wM9DeK7ANOuHUA/5teAgbm1uzaQ
         Je2gfBLrOVmRFZFYq2OaA1YWNWixiSRKmf3BWJneQK+aAU3ugrG4+XP7P6kiE02YDWMW
         //zQXWclJxxnAwzBs+zVSkPjaCfhKe4dRVmSyRIojeygX/Eet9RuHhQ6QuuFwUPuo+5m
         uaytmZmr9iincrkiS1UUpMr0A93B84WWPLWbeXJBnvyvyNybSx+LpBFGarMp9RyDAf2S
         UIOQ==
X-Gm-Message-State: AOJu0YyuT4bTaByCqg5oVou+S2duciEFxvAWhAhsCXsqVd2XxPjrUwTU
	MYCBogvhbr5xSK7r2MDIWK1bPWl6oMjNkrgYhDYLEBIKOeB5bbQ6ctA8Ohuwpg==
X-Gm-Gg: AfdE7cnFZ42gYcpN52uYHD99hCwhAruDbObNPNoVMAf5GMeM7cHIW95G+izVGZb1UKw
	yYKtmMbD/GixjJLehuE3kQL2NltUlubfFGEDjCLUxRW3V20WJwQFC+I6PjFnRMMSKDvIGlMH5w1
	1zYL8tUb79GBlpoBFaWCw2y350Ilhzy7WvEb7RstL+HNrVXYdqvjPdu7cM3alQts1RSBuyBfKBc
	RhSyoxXJpkuDlmk1uO8oh8JMcOFT/XGuCNozfLPi8m+Ra0jmzRtjxNMfi28Hh4NSo3facHE7TFT
	PlS3Rbw/b5AJ3pRk1teMidcJiDcc+2SkUfy9vY40p/7DQJwQSUYE5P9EeziNGucpdZVz347nJd+
	Dfa4St9iZ0bWChqKeprYVc2cuMz2zZvS/kUMT0YtdMaGTj+KOXXvUCaNezPoC24OjwUS8R0rbTU
	ZgLufwS87dLJPbulDt
X-Received: by 2002:a05:6820:2904:b0:6a3:9373:1f49 with SMTP id 006d021491bc7-6a3d9e70972mr443505eaf.10.1784069352282;
        Tue, 14 Jul 2026 15:49:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a5eee0fsm15134363eaf.5.2026.07.14.15.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:49:11 -0700 (PDT)
Message-Id: <2da452e39cbe1bd53da9d76fa7f7615c1a453634.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:44 +0000
Subject: [PATCH 11/11] bisect: handle dup() failure when redirecting stdout
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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

Treat a failed dup(1) as a fatal error for this bisect step: close
the temporary file descriptor, report the error via error_errno(),
and break out of the loop so the existing cleanup path handles the
rest, just as on other failure paths in this function.

Reported by Coverity as CID 1508242 ("Improper use of negative
value").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 15a2a30f89..801daf8c78 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1308,6 +1308,11 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 
 		fflush(stdout);
 		saved_stdout = dup(1);
+		if (saved_stdout < 0) {
+			res = error_errno(_("could not duplicate stdout"));
+			close(temporary_stdout_fd);
+			break;
+		}
 		dup2(temporary_stdout_fd, 1);
 
 		res = bisect_state(terms, 1, &new_state);
-- 
gitgitgadget
